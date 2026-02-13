Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B5FEDF17D
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 16:28:44 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.75682.1771000107736271370
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 08:28:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O3mVfeqZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48068127f00so11024245e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771000105; x=1771604905; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MJS2AImwTgi7u2cwHDBtzCy6XVWCRXYPfpP0BopPf0=;
        b=O3mVfeqZTkjKhLQqudoPNFN9eWaY3e0YdMG0VgCTnmNtfcbi5xZxzh/Qy//LOWfOB9
         WuPoXp7nZNT66M7gKTXbCNsz6mUzux4wnS3kQs9Kqqn+ZdkW2B9auFbmnzMDH+fJusdH
         BwT+hk5P7DbbtWMl7M7il+WLuOM8zeEw/088M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000105; x=1771604905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9MJS2AImwTgi7u2cwHDBtzCy6XVWCRXYPfpP0BopPf0=;
        b=jo+CfO6mCPPAn8kBVu9AGmAeQ6qiJJlBx2iA1yg9fzc6Qt+uwHtbQ4StIunkDhYiVr
         SRoFcipD64x+Rw4ANloWLjRIHZ9c1JNIf4sW8472XBSdLmZw7S/6v0MAbNWTJfiXj5m3
         YxZHhWtGxijR227GZVAI2DN3R1PqcVkTF8LuItotQwQh3WM+jt2O80hAIKYQqfJZoQ24
         rWVQ7rFlysPN0mAE14rEA5hUtdKlyiPZD3JYExjnuXO9y15emXhmzT8bv19vvZOopBkR
         Qx3HA8riUmx+xzIp8gkyRTGRvD1ul87poqOhwBCdIpUlmeukmYvgve77PVHET5pDbrZZ
         MIcg==
X-Gm-Message-State: AOJu0YzPwLfGtIYXxWvBGB0YWkUbZa84y4l32HtucH06CKqdmInnZCYE
	6vicnSEPvI3L/VSsJ7fHdHp+lXM3C8swOj18E5g7CwjSPIbHNUlbMzEt2JzY1ZnkpwcBB5yc0IJ
	p6zE/f6E=
X-Gm-Gg: AZuq6aL/6dVxjYwe3GfX/dnzZC0+PAgxRrJfGNHUKgQx/7F6pUs9Z8yJAtFG8Jos6AZ
	PZkP2DWw6rV0iZBcO4XZY7BWuH7VSQOq+9E3wKK9KjHGRHwHTuTErEGpNxDjRgpZAVrOMIK4rPK
	IN6sTJyjJfAst2YHX8DANEVkPJyTe8RbCLeeA4ArZNBWjP3SrySFG3psxVSjnmdU8ziI0rYTVw/
	qxA0ZmYjXkiIbZA79iVtoSTd/5HdwTdKXHx2ykdHAnjJctdbYWcist6CPoc33mPhMpxX9gAJA9y
	7Woun4YbYZlpdhZA9rDDWGFTYzyvMOyjwLXa3KV+8gWW+6ymitEZs/98Z2A/gO9SBMIRmdjArcZ
	6qbP/7dcQjivA0ODmhBnNe1t6z2Hrh+tZy37VgOX0bFv4ZQJ9WI6J74Ey/FJRb6sk0wqY4bWFQ9
	zqI/ubTb8vrydjSKr+syoLxsm0E6cZQ/ADzqL16ezZT19sqPgrB8A=
X-Received: by 2002:a05:600c:4e49:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-48373a08300mr40892665e9.1.1771000104812;
        Fri, 13 Feb 2026 08:28:24 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e20e:afdc:37ec:38d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1b4sm6046701f8f.14.2026.02.13.08.28.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:28:24 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] fetch: Drop CVS fetcher module
Date: Fri, 13 Feb 2026 16:28:22 +0000
Message-ID: <20260213162822.1758624-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260213162822.1758624-1-richard.purdie@linuxfoundation.org>
References: <20260213162822.1758624-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 16:28:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19030

CVS is extremely dated technology and is not used anywhere significant/public
any more. The existing code is not well maintained and is hard to test without
any public CVS repositories. To be honest, if you're still using CVS you really
shouldn't be.

Remove the fetcher as obsolete and a generally bad idea now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-fetching.rst          |  71 --------
 .../bitbake-user-manual-ref-variables.rst     |   7 -
 lib/bb/fetch2/__init__.py                     |   2 -
 lib/bb/fetch2/cvs.py                          | 157 ------------------
 lib/bb/tests/fetch.py                         |  35 ----
 5 files changed, 272 deletions(-)
 delete mode 100644 lib/bb/fetch2/cvs.py

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 27e276885a6..8e1a232cdbc 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -84,7 +84,6 @@ fetcher does know how to use HTTP as a transport.
 Here are some examples that show commonly used mirror definitions::
 
    PREMIRRORS ?= "\
-      cvs://.*/.\*  http://somemirror.org/sources/ \
       git://.*/.\*  http://somemirror.org/sources/ \
       hg://.*/.\*   http://somemirror.org/sources/ \
       p4://.*/.\*   http://somemirror.org/sources/ \
@@ -264,76 +263,6 @@ Some example URLs are as follows::
 
       SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47;downloadfilename=myfile.bz2"
 
-
-.. _cvs-fetcher:
-
-CVS fetcher (``(cvs://``)
--------------------------
-
-This submodule handles checking out files from the CVS version control
-system. You can configure it using a number of different variables:
-
--  :term:`FETCHCMD_cvs <FETCHCMD>`: The name of the executable to use when running
-   the ``cvs`` command. This name is usually "cvs".
-
--  :term:`SRCDATE`: The date to use when fetching the CVS source code. A
-   special value of "now" causes the checkout to be updated on every
-   build.
-
--  :term:`CVSDIR`: Specifies where a temporary
-   checkout is saved. The location is often ``DL_DIR/cvs``.
-
--  CVS_PROXY_HOST: The name to use as a "proxy=" parameter to the
-   ``cvs`` command.
-
--  CVS_PROXY_PORT: The port number to use as a "proxyport="
-   parameter to the ``cvs`` command.
-
-As well as the standard username and password URL syntax, you can also
-configure the fetcher with various URL parameters:
-
-The supported parameters are as follows:
-
--  *"method":* The protocol over which to communicate with the CVS
-   server. By default, this protocol is "pserver". If "method" is set to
-   "ext", BitBake examines the "rsh" parameter and sets ``CVS_RSH``. You
-   can use "dir" for local directories.
-
--  *"module":* Specifies the module to check out. You must supply this
-   parameter.
-
--  *"tag":* Describes which CVS TAG should be used for the checkout. By
-   default, the TAG is empty.
-
--  *"date":* Specifies a date. If no "date" is specified, the
-   :term:`SRCDATE` of the configuration is used to
-   checkout a specific date. The special value of "now" causes the
-   checkout to be updated on every build.
-
--  *"localdir":* Used to rename the module. Effectively, you are
-   renaming the output directory to which the module is unpacked. You
-   are forcing the module into a special directory relative to
-   :term:`CVSDIR`.
-
--  *"rsh":* Used in conjunction with the "method" parameter.
-
--  *"scmdata":* Causes the CVS metadata to be maintained in the tarball
-   the fetcher creates when set to "keep". The tarball is expanded into
-   the work directory. By default, the CVS metadata is removed.
-
--  *"fullpath":* Controls whether the resulting checkout is at the
-   module level, which is the default, or is at deeper paths.
-
--  *"norecurse":* Causes the fetcher to only checkout the specified
-   directory with no recurse into any subdirectories.
-
--  *"port":* The port to which the CVS server connects.
-
-Some example URLs are as follows::
-
-   SRC_URI = "cvs://CVSROOT;module=mymodule;tag=some-version;method=ext"
-   SRC_URI = "cvs://CVSROOT;module=mymodule;date=20060126;localdir=usethat"
-
 .. _svn-fetcher:
 
 Subversion (SVN) Fetcher (``svn://``)
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index f8f824f9f5a..1508d259e32 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1131,10 +1131,6 @@ overview of their function and contents.
       Specifies the directory BitBake uses to store a cache of the metadata
       so it does not need to be parsed every time BitBake is started.
 
-   :term:`CVSDIR`
-      The directory in which files checked out under the CVS system are
-      stored.
-
    :term:`DEFAULT_PREFERENCE`
       Specifies a weak bias for recipe selection priority.
 
@@ -1635,9 +1631,6 @@ overview of their function and contents.
 
       -  ``ccrc://``: Fetches files from a ClearCase repository.
 
-      -  ``cvs://``: Fetches files from a CVS revision control
-         repository.
-
       -  ``file://``: Fetches files, which are usually files shipped
          with the Metadata, from the local machine.
          The path is relative to the :term:`FILESPATH`
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7e0ef05246f..dcf7adc26ab 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2100,7 +2100,6 @@ class FetchConnectionCache(object):
             self.cache[cn].close()
             del self.cache[cn]
 
-from . import cvs
 from . import git
 from . import gitsm
 from . import gitannex
@@ -2127,7 +2126,6 @@ methods.append(svn.Svn())
 methods.append(git.Git())
 methods.append(gitsm.GitSM())
 methods.append(gitannex.GitANNEX())
-methods.append(cvs.Cvs())
 methods.append(ssh.SSH())
 methods.append(sftp.SFTP())
 methods.append(s3.S3())
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
deleted file mode 100644
index 01de5ff4caf..00000000000
--- a/lib/bb/fetch2/cvs.py
+++ /dev/null
@@ -1,157 +0,0 @@
-"""
-BitBake 'Fetch' implementations
-
-Classes for obtaining upstream sources for the
-BitBake build tools.
-
-"""
-
-# Copyright (C) 2003, 2004  Chris Larson
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Based on functions from the base bb module, Copyright 2003 Holger Schurig
-#
-
-import os
-import bb
-from bb.fetch2 import FetchMethod, FetchError, MissingParameterError, logger
-from bb.fetch2 import runfetchcmd
-
-class Cvs(FetchMethod):
-    """
-    Class to fetch a module or modules from cvs repositories
-    """
-    def supports(self, ud, d):
-        """
-        Check to see if a given url can be fetched with cvs.
-        """
-        return ud.type in ['cvs']
-
-    def urldata_init(self, ud, d):
-        if not "module" in ud.parm:
-            raise MissingParameterError("module", ud.url)
-        ud.module = ud.parm["module"]
-
-        ud.tag = ud.parm.get('tag', "")
-
-        # Override the default date in certain cases
-        if 'date' in ud.parm:
-            ud.date = ud.parm['date']
-        elif ud.tag:
-            ud.date = ""
-
-        norecurse = ''
-        if 'norecurse' in ud.parm:
-            norecurse = '_norecurse'
-
-        fullpath = ''
-        if 'fullpath' in ud.parm:
-            fullpath = '_fullpath'
-
-        ud.localfile = d.expand('%s_%s_%s_%s%s%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.tag, ud.date, norecurse, fullpath))
-
-        pkg = d.getVar('PN')
-        cvsdir = d.getVar("CVSDIR") or (d.getVar("DL_DIR") + "/cvs")
-        ud.pkgdir = os.path.join(cvsdir, pkg)
-
-    def need_update(self, ud, d):
-        if (ud.date == "now"):
-            return True
-        if not os.path.exists(ud.localpath):
-            return True
-        return False
-
-    def download(self, ud, d):
-
-        method = ud.parm.get('method', 'pserver')
-        localdir = ud.parm.get('localdir', ud.module)
-        cvs_port = ud.parm.get('port', '')
-
-        cvs_rsh = None
-        if method == "ext":
-            if "rsh" in ud.parm:
-                cvs_rsh = ud.parm["rsh"]
-
-        if method == "dir":
-            cvsroot = ud.path
-        else:
-            cvsroot = ":" + method
-            cvsproxyhost = d.getVar('CVS_PROXY_HOST')
-            if cvsproxyhost:
-                cvsroot += ";proxy=" + cvsproxyhost
-            cvsproxyport = d.getVar('CVS_PROXY_PORT')
-            if cvsproxyport:
-                cvsroot += ";proxyport=" + cvsproxyport
-            cvsroot += ":" + ud.user
-            if ud.pswd:
-                cvsroot += ":" + ud.pswd
-            cvsroot += "@" + ud.host + ":" + cvs_port + ud.path
-
-        options = []
-        if 'norecurse' in ud.parm:
-            options.append("-l")
-        if ud.date:
-            # treat YYYYMMDDHHMM specially for CVS
-            if len(ud.date) == 12:
-                options.append("-D \"%s %s:%s UTC\"" % (ud.date[0:8], ud.date[8:10], ud.date[10:12]))
-            else:
-                options.append("-D \"%s UTC\"" % ud.date)
-        if ud.tag:
-            options.append("-r %s" % ud.tag)
-
-        cvsbasecmd = d.getVar("FETCHCMD_cvs") or "/usr/bin/env cvs"
-        cvscmd = cvsbasecmd + " '-d" + cvsroot + "' co " + " ".join(options) + " " + ud.module
-        cvsupdatecmd = cvsbasecmd + " '-d" + cvsroot + "' update -d -P " + " ".join(options)
-
-        if cvs_rsh:
-            cvscmd = "CVS_RSH=\"%s\" %s" % (cvs_rsh, cvscmd)
-            cvsupdatecmd = "CVS_RSH=\"%s\" %s" % (cvs_rsh, cvsupdatecmd)
-
-        # create module directory
-        logger.debug2("Fetch: checking for module directory")
-        moddir = os.path.join(ud.pkgdir, localdir)
-        workdir = None
-        if os.access(os.path.join(moddir, 'CVS'), os.R_OK):
-            logger.info("Update " + ud.url)
-            bb.fetch2.check_network_access(d, cvsupdatecmd, ud.url)
-            # update sources there
-            workdir = moddir
-            cmd = cvsupdatecmd
-        else:
-            logger.info("Fetch " + ud.url)
-            # check out sources there
-            bb.utils.mkdirhier(ud.pkgdir)
-            workdir = ud.pkgdir
-            logger.debug("Running %s", cvscmd)
-            bb.fetch2.check_network_access(d, cvscmd, ud.url)
-            cmd = cvscmd
-
-        runfetchcmd(cmd, d, cleanup=[moddir], workdir=workdir)
-
-        if not os.access(moddir, os.R_OK):
-            raise FetchError("Directory %s was not readable despite sucessful fetch?!" % moddir, ud.url)
-
-        scmdata = ud.parm.get("scmdata", "")
-        if scmdata == "keep":
-            tar_flags = ""
-        else:
-            tar_flags = "--exclude='CVS'"
-
-        # tar them up to a defined filename
-        workdir = None
-        if 'fullpath' in ud.parm:
-            workdir = ud.pkgdir
-            cmd = "tar %s -czf %s %s" % (tar_flags, ud.localpath, localdir)
-        else:
-            workdir = os.path.dirname(os.path.realpath(moddir))
-            cmd = "tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.basename(moddir))
-
-        runfetchcmd(cmd, d, cleanup=[ud.localpath], workdir=workdir)
-
-    def clean(self, ud, d):
-        """ Clean CVS Files and tarballs """
-
-        bb.utils.remove(ud.pkgdir, True)
-        bb.utils.remove(ud.localpath)
-
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e2a7eec9cbd..2a8501dc2ea 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -158,39 +158,6 @@ class URITest(unittest.TestCase):
             'query': {},
             'relative': False
         },
-        "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : {
-            'uri': 'cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg',
-            'scheme': 'cvs',
-            'hostname': 'cvs.handhelds.org',
-            'port': None,
-            'hostport': 'cvs.handhelds.org',
-            'path': '/cvs',
-            'userinfo': 'anoncvs',
-            'username': 'anoncvs',
-            'password': '',
-            'params': {
-                'module': 'familiar/dist/ipkg'
-            },
-            'query': {},
-            'relative': False
-        },
-        "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg": {
-            'uri': 'cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg',
-            'scheme': 'cvs',
-            'hostname': 'cvs.handhelds.org',
-            'port': None,
-            'hostport': 'cvs.handhelds.org',
-            'path': '/cvs',
-            'userinfo': 'anoncvs:anonymous',
-            'username': 'anoncvs',
-            'password': 'anonymous',
-            'params': collections.OrderedDict([
-                ('tag', 'V0-99-81'),
-                ('module', 'familiar/dist/ipkg')
-            ]),
-            'query': {},
-            'relative': False
-        },
         "file://example.diff": { # NOTE: Not RFC compliant!
             'uri': 'file:example.diff',
             'scheme': 'file',
@@ -1417,8 +1384,6 @@ class URLHandle(unittest.TestCase):
     password = urllib.parse.quote(r"!#$%^&*()-_={}[]\|:?,.<>~`", r"!$&'/()*+,;=")
     datatable = {
        "http://www.google.com/index.html" : ('http', 'www.google.com', '/index.html', '', '', {}),
-       "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '', {'module': 'familiar/dist/ipkg'}),
-       "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', collections.OrderedDict([('tag', 'V0-99-81'), ('module', 'familiar/dist/ipkg')])),
        "git://git.openembedded.org/bitbake;branch=@foo;protocol=https" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo', 'protocol' : 'https'}),
        "file://somelocation;someparam=1": ('file', '', 'somelocation', '', '', {'someparam': '1'}),
        "file://example@.service": ('file', '', 'example@.service', '', '', {}),

