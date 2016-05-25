Return-Path: <andrew@bradfordembedded.com>
X-Greylist: delayed 303 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 25 May 2016 19:53:33 UTC
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
	[66.111.4.26])
	by mail.openembedded.org (Postfix) with ESMTP id BBD077316D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 May 2016 19:53:33 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6CEEF21526;
	Wed, 25 May 2016 15:48:31 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
	by compute4.internal (MEProxy); Wed, 25 May 2016 15:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	bradfordembedded.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=8HIHP
	QV3nfNvTRIsSiZvjrNO9bg=; b=r404IlL0Ic1vZYJMyVRvYI/xD61l4V8PNbjzq
	knB1Ha0hfRnS8mEFc0qhDKubgW5kutHpccGMXoc1F5U0lKCXaaWkSHJt5I68IQKY
	EOFF4YNmkg+0V6kdmrTX58SeV78WVBvRxg3J23ycoePDGk2DftNiGqnHhFrM1r/o
	MYDMCg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8HIH
	PQV3nfNvTRIsSiZvjrNO9bg=; b=ojXlIwzAHohoa11bplR+vKiCNSWoP4lQ2zGy
	kYDFWqoJLQj+p3SDJjQoSXFtZebrWQU+Dv0H+5FM2sDq88c0UTWEAwasfDmpMMDR
	CaNB5w7kfCf06CzVQrkq/A/8N3DVJPX55wSUvv3kkFF552hza1RwTnItYGPlj488
	AtVkNW0=
X-Sasl-enc: wQ3okCdreMhUCqS+pbECSpoDxi/XVOaS0dr3Ru2RX0N9 1464205711
Received: from kaim-eeyore.kodakalaris.net (clr-vpn01.kodakalaris.com
	[198.140.222.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1D8C7F2842;
	Wed, 25 May 2016 15:48:31 -0400 (EDT)
From: Andrew Bradford <andrew@bradfordembedded.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 May 2016 15:48:23 -0400
Message-Id: <1464205704-26377-2-git-send-email-andrew@bradfordembedded.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1464205704-26377-1-git-send-email-andrew@bradfordembedded.com>
References: <1464205704-26377-1-git-send-email-andrew@bradfordembedded.com>
Cc: Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: [PATCH 1/2] perforce fetcher: Rework to support SRCREV and P4CONFIG
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
X-List-Received-Date: Wed, 25 May 2016 19:53:35 -0000

From: Andrew Bradford <andrew.bradford@kodakalaris.com>

In recipes which use the perforce fetcher, enable use of SRCREV to
specify any of: ${AUTOREV}, changeset number, p4date, or label.  This is
more in-line with how the other fetchers work for source control
systems.

Allow use of the P4CONFIG env variable to define the server URL,
username, and password if not provided in a recipe.

This does change existing perforce fetcher usage by recipes and will
need those recipes which use the perforce fetcher to be updated.  No
recipes in oe-core use the perforce fetcher.

References [YOCTO #6303]

Signed-off-by: Andrew Bradford <andrew.bradford@kodakalaris.com>
---
 lib/bb/fetch2/__init__.py |   3 +-
 lib/bb/fetch2/perforce.py | 279 ++++++++++++++++++++++++----------------------
 2 files changed, 147 insertions(+), 135 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7d2f350..b6e9f9a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -809,7 +809,8 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None):
                   'GIT_SMART_HTTP',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
                   'SOCKS5_USER', 'SOCKS5_PASSWD',
-                  'DBUS_SESSION_BUS_ADDRESS']
+                  'DBUS_SESSION_BUS_ADDRESS',
+                  'P4CONFIG']
 
     if not cleanup:
         cleanup = []
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 3a10c7c..b84489a 100644
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
@@ -25,9 +23,8 @@ BitBake build tools.
 #
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
-from future_builtins import zip
 import os
-import subprocess
+import sys
 import logging
 import bb
 from   bb import data
@@ -37,151 +34,165 @@ from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
 
 class Perforce(FetchMethod):
+    """ Class to fetch from perforce repositories """
     def supports(self, ud, d):
+        """ Check to see if a given url can be fetched with perforce. """
         return ud.type in ['p4']
 
-    def doparse(url, d):
-        parm = {}
-        path = url.split("://")[1]
+    def urldata_init(self, ud, d):
+        """
+        Initialize perforce specific variables within url data.  If P4PORT is
+        not provided by the recipe but P4CONFIG is provided by the env, let
+        perforce use P4CONFIG as it naturally does to set P4USER, P4PASSWD, and
+        P4PORT.
+        """
+        ud.basecmd = d.getVar('FETCHCMD_p4', True)
+        ud.usingp4config = False
+
+        path = ud.url.split("://")[1]
+        path = path.split(";")[0]
         delim = path.find("@");
         if delim != -1:
-            (user, pswd, host, port) = path.split('@')[0].split(":")
-            path = path.split('@')[1]
+            (ud.user, ud.pswd) = path.split('@')[0].split(":")
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
-            parm = dict(zip(keys, values))
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
-
-    def urldata_init(self, ud, d):
-        (host, path, user, pswd, parm) = Perforce.doparse(ud.url, d)
+            ud.path = path
 
-        base_path = path.replace('/...', '')
-        base_path = self._strip_leading_slashes(base_path)
-        
-        if "label" in parm:
-            version = parm["label"]
+        p4port = d.getVar('P4PORT', True)
+        if p4port:
+            ud.host = p4port
         else:
-            version = Perforce.getcset(d, path, host, user, pswd, parm)
-
-        ud.localfile = data.expand('%s+%s+%s.tar.gz' % (host, base_path.replace('/', '.'), version), d)
-
-    def download(self, ud, d):
+            p4config = d.getVar('P4CONFIG', True)
+            if p4config:
+                logger.info("Using P4CONFIG to specify P4PORT")
+                ud.usingp4config = True
+                ud.host, errors = bb.process.run("p4 info | grep \"Server address\"")
+                ud.host = ud.host.split(': ')[1].strip()
+                logger.info("Determined P4PORT to be: %s" % ud.host)
+                if not ud.host:
+                    raise FetchError("Could not determine server name from P4CONFIG")
+            else:
+                raise FetchError("SRC_URI is not valid, did you forget to specify P4PORT or P4CONFIG?")
+
+        relpath = ud.path.replace('/...', '')
+        relpath = self._strip_leading_slashes(relpath)
+        relpath = relpath.replace('/', '.')
+        cleanedhost = ud.host.replace(':', '.')
+        ud.pkgdir = os.path.join(data.expand('${P4DIR}', d), cleanedhost, relpath)
+
+        ud.setup_revisons(d)
+
+        ud.localfile = data.expand('%s_%s_%s.tar.gz' % (cleanedhost, relpath, ud.revision), d)
+
+    def _buildp4command(self, ud, d, command, depot_filename=None):
         """
-        Fetch urls
+        Build a p4 commandline.  Valid commands are "changes", "print", and
+        "files".  depot_filename is the full path to the file in the depot
+        including the trailing '#rev' value.
         """
-
-        (host, depot, user, pswd, parm) = Perforce.doparse(ud.url, d)
-
-        if depot.find('/...') != -1:
-            path = depot[:depot.find('/...')]
-        else:
-            path = depot[:depot.rfind('/')]
-
-        module = parm.get('module', os.path.basename(path))
-
-        # Get the p4 command
         p4opt = ""
-        if user:
-            p4opt += " -u %s" % (user)
-
-        if pswd:
-            p4opt += " -P %s" % (pswd)
-
-        if host:
-            p4opt += " -p %s" % (host)
-
-        p4cmd = d.getVar('FETCHCMD_p4', True) or "p4"
-
-        # create temp directory
-        logger.debug(2, "Fetch: creating temporary directory")
-        bb.utils.mkdirhier(d.expand('${WORKDIR}'))
-        mktemp = d.getVar("FETCHCMD_p4mktemp", True) or d.expand("mktemp -d -q '${WORKDIR}/oep4.XXXXXX'")
-        tmpfile, errors = bb.process.run(mktemp)
-        tmpfile = tmpfile.strip()
-        if not tmpfile:
-            raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", ud.url)
-
-        if "label" in parm:
-            depot = "%s@%s" % (depot, parm["label"])
+        if ud.user:
+            p4opt += " -u \"%s\"" % (ud.user)
+        if ud.pswd:
+            p4opt += " -P \"%s\"" % (ud.pswd)
+        if ud.host and not ud.usingp4config:
+            p4opt += " -p %s" % (ud.host)
+        if hasattr(ud, 'revision') and ud.revision:
+                pathnrev = "%s@%s" % (ud.path, ud.revision)
         else:
-            cset = Perforce.getcset(d, depot, host, user, pswd, parm)
-            depot = "%s@%s" % (depot, cset)
-
-        os.chdir(tmpfile)
-        logger.info("Fetch " + ud.url)
-        logger.info("%s%s files %s", p4cmd, p4opt, depot)
-        p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt, depot))
-        p4file = [f.rstrip() for f in p4file.splitlines()]
+            pathnrev = "%s" % (ud.path)
+
+        if depot_filename:
+            # FIXME: handle when SRC_URI is a single file and not a dir
+            filename = depot_filename[len(ud.path)-1:] # Remove leading path
+            where = filename.find("#") # Remove trailing '#rev'
+            filename = filename[:where]
+
+        if command == "changes":
+            p4cmd = "%s%s changes -m 1 //%s" % (ud.basecmd, p4opt, pathnrev)
+        elif command == "print":
+            if depot_filename != None:
+                p4cmd = "%s%s print -o \"p4/%s\" \"%s\"" % (ud.basecmd, p4opt, filename, depot_filename)
+            else:
+                raise FetchError("No depot file name provided to p4 %s" % command, ud.url)
+        elif command == "files":
+            p4cmd = "%s%s files //%s" % (ud.basecmd, p4opt, pathnrev)
+        else:
+            raise FetchError("Invalid p4 command %s" % command, ud.url)
 
-        if not p4file:
-            raise FetchError("Fetch: unable to get the P4 files from %s" % depot, ud.url)
+        return p4cmd
 
+    def _p4listfiles(self, ud, d):
+        """
+        Return a list of the file names which are present in the depot using the
+        'p4 files' command, including trailing '#rev' file revision indicator
+        """
+        p4cmd = self._buildp4command(ud, d, "files")
+        bb.fetch2.check_network_access(d, p4cmd)
+        p4fileslist = runfetchcmd(p4cmd, d, True)
+        p4fileslist = [f.rstrip() for f in p4fileslist.splitlines()]
+        if not p4fileslist:
+            raise FetchError("Unable to fetch listing of p4 files from %s@%s" % ud.host, ud.path)
         count = 0
-
-        for file in p4file:
-            list = file.split()
-
-            if list[2] == "delete":
+        filelist = []
+        for filename in p4fileslist:
+            item = filename.split(" - ")
+            lastaction = item[1].split()
+            logger.info("File: " + item[0] + " Last Action: " + lastaction[0])
+            if lastaction[0] == "delete":
                 continue
+            filelist.append(item[0])
 
-            dest = list[0][len(path)+1:]
-            where = dest.find("#")
+        return filelist
 
-            subprocess.call("%s%s print -o %s/%s %s" % (p4cmd, p4opt, module, dest[:where], list[0]), shell=True)
-            count = count + 1
+    def download(self, ud, d):
+        """ Get the list of files, fetch each one """
+        filelist = self._p4listfiles(ud, d)
+
+        if not filelist:
+            raise FetchError("No files found in depot %s@%s" % ud.host, ud.path)
 
-        if count == 0:
-            logger.error()
-            raise FetchError("Fetch: No files gathered from the P4 fetch", ud.url)
+        logger.info("Fetch " + ud.url)
+        bb.utils.remove(ud.pkgdir, True)
+        bb.utils.mkdirhier(ud.pkgdir)
+        os.chdir(ud.pkgdir)
+
+        for afile in filelist:
+            p4fetchcmd = self._buildp4command(ud, d, "print", afile)
+            logger.debug(1, "Running %s", p4fetchcmd)
+            bb.fetch2.check_network_access(d, p4fetchcmd)
+            runfetchcmd(p4fetchcmd, d)
+
+        os.chdir(ud.pkgdir)
+        runfetchcmd("tar -czf %s p4" % (ud.localpath), d, cleanup = [ud.localpath])
+
+    def clean(self, ud, d):
+        """ Cleanup p4 specific files and dirs"""
+        bb.utils.remove(ud.localpath)
+        bb.utils.remove(ud.pkgdir, True)
+
+    def supports_srcrev(self):
+        return True
+
+    def _revision_key(self, ud, d, name):
+        """ Return a unique key for the url """
+        return "p4:" + ud.pkgdir
+
+    def _latest_revision(self, ud, d, name):
+        """ Return the latest upstream scm revision number """
+        p4cmd = self._buildp4command(ud, d, "changes")
+        bb.fetch2.check_network_access(d, p4cmd)
+        tip = runfetchcmd(p4cmd, d, True)
+        if not tip:
+            raise FetchError("Could not determine the latest perforce changeset")
+        tipcset = tip.split(' ')[1]
+        logger.debug(1, "p4 tip found to be changeset %s", tipcset)
+        return tipcset
+
+    def sortable_revision(self, ud, d, name):
+        """ Return a sortable revision number """
+        return False, self._build_revision(ud, d)
+
+    def _build_revision(self, ud, d):
+        return ud.revision
 
-        runfetchcmd("tar -czf %s %s" % (ud.localpath, module), d, cleanup = [ud.localpath])
-        # cleanup
-        bb.utils.prunedir(tmpfile)
-- 
2.8.1


