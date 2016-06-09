Return-Path: <andrew@bradfordembedded.com>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
	[66.111.4.26])
	by mail.openembedded.org (Postfix) with ESMTP id 937DF60767
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jun 2016 13:44:42 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6ABB320D02;
	Thu,  9 Jun 2016 09:44:43 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
	by compute3.internal (MEProxy); Thu, 09 Jun 2016 09:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	bradfordembedded.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=p8DVp
	d3xmCTB1a91M4tGCNtCNJc=; b=MeaH5mBAkE42WBDQd4kdPAuhGqD5+Yjbu5XHc
	2Doue2bQPohCbh7rzhsvX86hmGm74GfKHPveOVYGLTJOS8XAtXzA5VgsSQGQCsrt
	EFQtlFVJm6p1dyXrYPTmYfRMl+E6PlhxwehupkEtFNq88Tf5Hh82rkrxmeTwrE+/
	/9bvjw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=p8DV
	pd3xmCTB1a91M4tGCNtCNJc=; b=PpQUzF18GvGxT1jOgbZmjRIpHXr7YHM8mHJb
	2br34QBKu9Aus9C6SXhT9LQ2x56+hwtGxlwCgEomVfRSeIrKLrR001pvyTSklA5h
	DDCJ2hbmFrcPPpwpiceVl5ujbFI7PcPQdJaEvwsD+1dxrcf6q2j3i36Freho8LKW
	Hl39hPw=
X-Sasl-enc: lqwawdImEiMWUMkD4Eu7c9Ud66JnGAkByHjTXMxADRF0 1465479882
Received: from kaim-eeyore.kodakalaris.net (clr-vpn01.kodakalaris.com
	[198.140.222.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id A8508CCDB0;
	Thu,  9 Jun 2016 09:44:42 -0400 (EDT)
From: Andrew Bradford <andrew@bradfordembedded.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Jun 2016 09:44:08 -0400
Message-Id: <1465479849-28634-2-git-send-email-andrew@bradfordembedded.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1465479849-28634-1-git-send-email-andrew@bradfordembedded.com>
References: <1465479849-28634-1-git-send-email-andrew@bradfordembedded.com>
Cc: Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: [PATCH v2 1/2] fetch2/perforce: Rework to support SRCREV and P4CONFIG
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 09 Jun 2016 13:44:43 -0000

From: Andrew Bradford <andrew.bradford@kodakalaris.com>

In recipes which use the perforce fetcher, enable use of SRCREV to
specify any of: ${AUTOREV}, changelist number, p4date, or label.  This
is more in-line with how the other fetchers work for source control
systems.

Allow p4 to use the P4CONFIG env variable to define the server URL,
username, and password if not provided in a recipe.

This does change existing perforce fetcher usage by recipes and will
likely need those recipes which use the perforce fetcher to be updated.
No recipes in oe-core use the perforce fetcher.

References [YOCTO #6303]

Signed-off-by: Andrew Bradford <andrew.bradford@kodakalaris.com>
---
 lib/bb/fetch2/__init__.py |   3 +-
 lib/bb/fetch2/perforce.py | 270 +++++++++++++++++++++++++---------------------
 2 files changed, 150 insertions(+), 123 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f612318..a880483 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -803,7 +803,8 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None):
                   'GIT_SMART_HTTP',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
                   'SOCKS5_USER', 'SOCKS5_PASSWD',
-                  'DBUS_SESSION_BUS_ADDRESS']
+                  'DBUS_SESSION_BUS_ADDRESS',
+                  'P4CONFIG']
 
     if not cleanup:
         cleanup = []
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index ce3cda2..b8169f2 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -1,14 +1,12 @@
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
-BitBake 'Fetch' implementations
-
-Classes for obtaining upstream sources for the
-BitBake build tools.
+BitBake 'Fetch' implementation for perforce
 
 """
 
 # Copyright (C) 2003, 2004  Chris Larson
+# Copyright (C) 2016 Kodak Alaris, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -26,7 +24,6 @@ BitBake build tools.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
-import subprocess
 import logging
 import bb
 from   bb import data
@@ -36,151 +33,180 @@ from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
 
 class Perforce(FetchMethod):
+    """ Class to fetch from perforce repositories """
     def supports(self, ud, d):
+        """ Check to see if a given url can be fetched with perforce. """
         return ud.type in ['p4']
 
-    def doparse(url, d):
-        parm = {}
-        path = url.split("://")[1]
-        delim = path.find("@");
+    def urldata_init(self, ud, d):
+        """
+        Initialize perforce specific variables within url data.  If P4CONFIG is
+        provided by the env, use it.  If P4PORT is specified by the recipe, use
+        its values, which may override the settings in P4CONFIG.
+        """
+        ud.basecmd = d.getVar('FETCHCMD_p4', True)
+        if not ud.basecmd:
+            ud.basecmd = "/usr/bin/env p4"
+
+        ud.dldir = d.getVar('P4DIR', True)
+        if not ud.dldir:
+            ud.dldir = '%s/%s' % (d.getVar('DL_DIR', True), 'p4')
+
+        path = ud.url.split('://')[1]
+        path = path.split(';')[0]
+        delim = path.find('@');
         if delim != -1:
-            (user, pswd, host, port) = path.split('@')[0].split(":")
-            path = path.split('@')[1]
+            (ud.user, ud.pswd) = path.split('@')[0].split(':')
+            ud.path = path.split('@')[1]
         else:
-            (host, port) = d.getVar('P4PORT', False).split(':')
-            user = ""
-            pswd = ""
-
-        if path.find(";") != -1:
-            keys=[]
-            values=[]
-            plist = path.split(';')
-            for item in plist:
-                if item.count('='):
-                    (key, value) = item.split('=')
-                    keys.append(key)
-                    values.append(value)
-
-            parm = dict(list(zip(keys, values)))
-        path = "//" + path.split(';')[0]
-        host += ":%s" % (port)
-        parm["cset"] = Perforce.getcset(d, path, host, user, pswd, parm)
-
-        return host, path, user, pswd, parm
-    doparse = staticmethod(doparse)
-
-    def getcset(d, depot, host, user, pswd, parm):
-        p4opt = ""
-        if "cset" in parm:
-            return parm["cset"];
-        if user:
-            p4opt += " -u %s" % (user)
-        if pswd:
-            p4opt += " -P %s" % (pswd)
-        if host:
-            p4opt += " -p %s" % (host)
-
-        p4date = d.getVar("P4DATE", True)
-        if "revision" in parm:
-            depot += "#%s" % (parm["revision"])
-        elif "label" in parm:
-            depot += "@%s" % (parm["label"])
-        elif p4date:
-            depot += "@%s" % (p4date)
-
-        p4cmd = d.getVar('FETCHCMD_p4', True) or "p4"
-        logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt, depot)
-        p4file, errors = bb.process.run("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
-        cset = p4file.strip()
-        logger.debug(1, "READ %s", cset)
-        if not cset:
-            return -1
-
-        return cset.split(' ')[1]
-    getcset = staticmethod(getcset)
+            ud.path = path
 
-    def urldata_init(self, ud, d):
-        (host, path, user, pswd, parm) = Perforce.doparse(ud.url, d)
+        ud.usingp4config = False
+        p4port = d.getVar('P4PORT', True)
 
-        base_path = path.replace('/...', '')
-        base_path = self._strip_leading_slashes(base_path)
-        
-        if "label" in parm:
-            version = parm["label"]
+        if p4port:
+            logger.debug(1, 'Using recipe provided P4PORT: %s' % p4port)
+            ud.host = p4port
+        else:
+            logger.debug(1, 'Trying to use P4CONFIG to automatically set P4PORT...')
+            ud.usingp4config = True
+            p4cmd = '%s info | grep "Server address"' % ud.basecmd
+            bb.fetch2.check_network_access(d, p4cmd)
+            ud.host = runfetchcmd(p4cmd, d, True)
+            ud.host = ud.host.split(': ')[1].strip()
+            logger.debug(1, 'Determined P4PORT to be: %s' % ud.host)
+            if not ud.host:
+                raise FetchError('Could not determine P4PORT from P4CONFIG')
+	
+        if ud.path.find('/...') >= 0:
+            ud.pathisdir = True
         else:
-            version = Perforce.getcset(d, path, host, user, pswd, parm)
+            ud.pathisdir = False
 
-        ud.localfile = data.expand('%s+%s+%s.tar.gz' % (host, base_path.replace('/', '.'), version), d)
+        cleanedpath = ud.path.replace('/...', '').replace('/', '.')
+        cleanedhost = ud.host.replace(':', '.')
+        ud.pkgdir = os.path.join(ud.dldir, cleanedhost, cleanedpath)
 
-    def download(self, ud, d):
+        ud.setup_revisons(d)
+
+        ud.localfile = data.expand('%s_%s_%s.tar.gz' % (cleanedhost, cleanedpath, ud.revision), d)
+
+    def _buildp4command(self, ud, d, command, depot_filename=None):
         """
-        Fetch urls
+        Build a p4 commandline.  Valid commands are "changes", "print", and
+        "files".  depot_filename is the full path to the file in the depot
+        including the trailing '#rev' value.
         """
+        p4opt = ""
+
+        if ud.user:
+            p4opt += ' -u "%s"' % (ud.user)
 
-        (host, depot, user, pswd, parm) = Perforce.doparse(ud.url, d)
+        if ud.pswd:
+            p4opt += ' -P "%s"' % (ud.pswd)
 
-        if depot.find('/...') != -1:
-            path = depot[:depot.find('/...')]
+        if ud.host and not ud.usingp4config:
+            p4opt += ' -p %s' % (ud.host)
+
+        if hasattr(ud, 'revision') and ud.revision:
+            pathnrev = '%s@%s' % (ud.path, ud.revision)
+        else:
+            pathnrev = '%s' % (ud.path)
+
+        if depot_filename:
+            if ud.pathisdir: # Remove leading path to obtain filename
+                filename = depot_filename[len(ud.path)-1:]
+            else:
+                filename = depot_filename[depot_filename.rfind('/'):]
+            filename = filename[:filename.find('#')] # Remove trailing '#rev'
+
+        if command == 'changes':
+            p4cmd = '%s%s changes -m 1 //%s' % (ud.basecmd, p4opt, pathnrev)
+        elif command == 'print':
+            if depot_filename != None:
+                p4cmd = '%s%s print -o "p4/%s" "%s"' % (ud.basecmd, p4opt, filename, depot_filename)
+            else:
+                raise FetchError('No depot file name provided to p4 %s' % command, ud.url)
+        elif command == 'files':
+            p4cmd = '%s%s files //%s' % (ud.basecmd, p4opt, pathnrev)
         else:
-            path = depot[:depot.rfind('/')]
+            raise FetchError('Invalid p4 command %s' % command, ud.url)
 
-        module = parm.get('module', os.path.basename(path))
+        return p4cmd
 
-        # Get the p4 command
-        p4opt = ""
-        if user:
-            p4opt += " -u %s" % (user)
+    def _p4listfiles(self, ud, d):
+        """
+        Return a list of the file names which are present in the depot using the
+        'p4 files' command, including trailing '#rev' file revision indicator
+        """
+        p4cmd = self._buildp4command(ud, d, 'files')
+        bb.fetch2.check_network_access(d, p4cmd)
+        p4fileslist = runfetchcmd(p4cmd, d, True)
+        p4fileslist = [f.rstrip() for f in p4fileslist.splitlines()]
+
+        if not p4fileslist:
+            raise FetchError('Unable to fetch listing of p4 files from %s@%s' % (ud.host, ud.path))
+
+        count = 0
+        filelist = []
 
-        if pswd:
-            p4opt += " -P %s" % (pswd)
+        for filename in p4fileslist:
+            item = filename.split(' - ')
+            lastaction = item[1].split()
+            logger.debug(1, 'File: %s Last Action: %s' % (item[0], lastaction[0]))
+            if lastaction[0] == 'delete':
+                continue
+            filelist.append(item[0])
 
-        if host:
-            p4opt += " -p %s" % (host)
+        return filelist
 
-        p4cmd = d.getVar('FETCHCMD_p4', True) or "p4"
+    def download(self, ud, d):
+        """ Get the list of files, fetch each one """
+        filelist = self._p4listfiles(ud, d)
+        if not filelist:
+            raise FetchError('No files found in depot %s@%s' % (ud.host, ud.path))
 
-        # create temp directory
-        logger.debug(2, "Fetch: creating temporary directory")
-        bb.utils.mkdirhier(d.expand('${WORKDIR}'))
-        mktemp = d.getVar("FETCHCMD_p4mktemp", True) or d.expand("mktemp -d -q '${WORKDIR}/oep4.XXXXXX'")
-        tmpfile, errors = bb.process.run(mktemp)
-        tmpfile = tmpfile.strip()
-        if not tmpfile:
-            raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", ud.url)
+        bb.utils.remove(ud.pkgdir, True)
+        bb.utils.mkdirhier(ud.pkgdir)
+        os.chdir(ud.pkgdir)
 
-        if "label" in parm:
-            depot = "%s@%s" % (depot, parm["label"])
-        else:
-            cset = Perforce.getcset(d, depot, host, user, pswd, parm)
-            depot = "%s@%s" % (depot, cset)
+        for afile in filelist:
+            p4fetchcmd = self._buildp4command(ud, d, 'print', afile)
+            bb.fetch2.check_network_access(d, p4fetchcmd)
+            runfetchcmd(p4fetchcmd, d)
 
-        os.chdir(tmpfile)
-        logger.info("Fetch " + ud.url)
-        logger.info("%s%s files %s", p4cmd, p4opt, depot)
-        p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt, depot))
-        p4file = [f.rstrip() for f in p4file.splitlines()]
+        os.chdir(ud.pkgdir)
+        runfetchcmd('tar -czf %s p4' % (ud.localpath), d, cleanup = [ud.localpath])
 
-        if not p4file:
-            raise FetchError("Fetch: unable to get the P4 files from %s" % depot, ud.url)
+    def clean(self, ud, d):
+        """ Cleanup p4 specific files and dirs"""
+        bb.utils.remove(ud.localpath)
+        bb.utils.remove(ud.pkgdir, True)
 
-        count = 0
+    def supports_srcrev(self):
+        return True
 
-        for file in p4file:
-            list = file.split()
+    def _revision_key(self, ud, d, name):
+        """ Return a unique key for the url """
+        return 'p4:%s' % ud.pkgdir
 
-            if list[2] == "delete":
-                continue
+    def _latest_revision(self, ud, d, name):
+        """ Return the latest upstream scm revision number """
+        p4cmd = self._buildp4command(ud, d, "changes")
+        bb.fetch2.check_network_access(d, p4cmd)
+        tip = runfetchcmd(p4cmd, d, True)
+
+        if not tip:
+            raise FetchError('Could not determine the latest perforce changelist')
 
-            dest = list[0][len(path)+1:]
-            where = dest.find("#")
+        tipcset = tip.split(' ')[1]
+        logger.debug(1, 'p4 tip found to be changelist %s' % tipcset)
+        return tipcset
 
-            subprocess.call("%s%s print -o %s/%s %s" % (p4cmd, p4opt, module, dest[:where], list[0]), shell=True)
-            count = count + 1
+    def sortable_revision(self, ud, d, name):
+        """ Return a sortable revision number """
+        return False, self._build_revision(ud, d)
 
-        if count == 0:
-            logger.error()
-            raise FetchError("Fetch: No files gathered from the P4 fetch", ud.url)
+    def _build_revision(self, ud, d):
+        return ud.revision
 
-        runfetchcmd("tar -czf %s %s" % (ud.localpath, module), d, cleanup = [ud.localpath])
-        # cleanup
-        bb.utils.prunedir(tmpfile)
-- 
2.8.1


