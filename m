Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B0BEDF17D
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 16:00:04 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.75019.1770998397721793512
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 07:59:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eNSjIbSc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4837907f535so1080895e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770998396; x=1771603196; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDJQAqaKQvQEX/vmDYZ4BHCGV/E9a2kJPrH/DuRRdiE=;
        b=eNSjIbSc6YwIC66R8TwWsVVVINJYYIFgcy8iDnNQILevIWeh4v7C/mfeDwWpmInKc1
         2FYFnac/BFDyc0ive6Y3zIoD6DVq9QAKESRgwc0vGTx7KLLb1XDBwxzoN9kO+1wZIPXU
         zt0kSUQUFyP+rxXYJsWz1Y0YsFapcHkwz5uF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770998396; x=1771603196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDJQAqaKQvQEX/vmDYZ4BHCGV/E9a2kJPrH/DuRRdiE=;
        b=XEQIsPFVGWId2FHDN58iUfIj+sAGnO5vakG0H6DcQJAvZ0qHKEBrBsu5gFOnXaY/wH
         UN3Ie0SCNgTBKO5+JPwfmOqZB2FWjvgfclFiHREuofpGWSYFYaTHbngOCsqVVjcpxx/i
         t6W3BDxZ1Knh1MNo8pMwvMv5ZMZWsRpuGF68vtU98UGGcenEeUgJdJb4NWJbBdtc+Ui8
         wVYWr3sJyWZhdzLSPT4RHoxvFeibbOg8OLn4oJd5+vtwn99+d5uQ223HJgiVXMWRMPU1
         FykI/CpB4jLOeaKje9vkZEsQi6/wgF2q0mEquycbHcqKTm6o3272TP5Cwg10FwNxw3+n
         HozA==
X-Gm-Message-State: AOJu0YwHDmj51uLAhHWlAnA0exaLRvqAmD7rCUCbLf5GOwLfE49ZbTmH
	PDrXVBAHXaw46S/VbglL1bLwM6kSBbzbRcCTOe7FnJudrxU+JUTRm1xd59qL7iu5KjG+uvzW+cR
	upCoVvGU=
X-Gm-Gg: AZuq6aKdld229/AJSTjywg4gG8kcxiz3QtKZE2Qg07lSWQv6sL0gJZ3WA/BxtSnORuV
	4x5R1zQvGszF6+l+cIw5SZoyBGYdzs4ON7PWEEmQUCSeQibF534Gj3eRHXbAEFyRkv9PSHfhVKS
	AlHSxO5GGi/8TPM0XXQpFANwq6siJt5JG5F9unURmKQJzpnaR5eW+GJAvEkRHmNKJt9LosipY1b
	7IkYsx9PK+AzP2wkY5XAqLFE3m2EcCZdEyl2wpK3/UCU7wIgCAqGYpWrmgWS9JoqixYmSpFaDwm
	s3B4jzTq7Di3oFRi/tyM4v8CtaQYKkFoFOV8q0teQwrLfWGUT9BH+5gHYbm4dttsOGRcDoWExQ3
	L7cC85TcTGgc01I3GNFHPC4cv1E4tFc/wf4cw1AwbkUDFlCqjWXVD3DriosMBwHUa8CTQDM9MZp
	i3LHFmM8nCktTJ3bBswHu1UM8Iq6RUOLeQ51PO8NKv9iaDMAom12Y=
X-Received: by 2002:a05:600c:45cc:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-48373a6c1f8mr35841405e9.35.1770998395196;
        Fri, 13 Feb 2026 07:59:55 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e20e:afdc:37ec:38d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a2998fsm19408295e9.17.2026.02.13.07.59.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:59:54 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch: Drop Bazaar/bzr fetcher
Date: Fri, 13 Feb 2026 15:59:53 +0000
Message-ID: <20260213155953.1751687-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 16:00:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19028

Bazaar has been of limited use outside of Launchpad for a while. Most uses
within launchpad now use git. The original bazaar client was also replaced
by breezy, which whilst supporting the bazaar repositories, mostly works with
git as the backend now too.

The existing code has been broken for a while and nobody seems to be using it,
lets remove the obsolete technology.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-fetching.rst          |   3 -
 .../bitbake-user-manual-ref-variables.rst     |   7 -
 lib/bb/fetch2/__init__.py                     |   2 -
 lib/bb/fetch2/bzr.py                          | 128 ------------------
 4 files changed, 140 deletions(-)
 delete mode 100644 lib/bb/fetch2/bzr.py

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 2b06c1d4716..efc0f8456ee 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -84,7 +84,6 @@ fetcher does know how to use HTTP as a transport.
 Here are some examples that show commonly used mirror definitions::
 
    PREMIRRORS ?= "\
-      bzr://.*/.\*  http://somemirror.org/sources/ \
       cvs://.*/.\*  http://somemirror.org/sources/ \
       git://.*/.\*  http://somemirror.org/sources/ \
       hg://.*/.\*   http://somemirror.org/sources/ \
@@ -827,8 +826,6 @@ Other Fetchers
 
 Fetch submodules also exist for the following:
 
--  Bazaar (``bzr://``)
-
 -  Mercurial (``hg://``)
 
 -  OSC (``osc://``)
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 4b3b10d4662..c75f2c27b32 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1127,10 +1127,6 @@ overview of their function and contents.
       A name assigned to the build. The name defaults to a datetime stamp
       of when the build was started but can be defined by the metadata.
 
-   :term:`BZRDIR`
-      The directory in which files checked out of a Bazaar system are
-      stored.
-
    :term:`CACHE`
       Specifies the directory BitBake uses to store a cache of the metadata
       so it does not need to be parsed every time BitBake is started.
@@ -1637,9 +1633,6 @@ overview of their function and contents.
 
       -  ``az://``: Fetches files from an Azure Storage account using HTTPS.
 
-      -  ``bzr://``: Fetches files from a Bazaar revision control
-         repository.
-
       -  ``ccrc://``: Fetches files from a ClearCase repository.
 
       -  ``cvs://``: Fetches files from a CVS revision control
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index bdd4973945a..d21e9c18fa0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2111,7 +2111,6 @@ from . import ssh
 from . import sftp
 from . import s3
 from . import perforce
-from . import bzr
 from . import hg
 from . import osc
 from . import repo
@@ -2134,7 +2133,6 @@ methods.append(ssh.SSH())
 methods.append(sftp.SFTP())
 methods.append(s3.S3())
 methods.append(perforce.Perforce())
-methods.append(bzr.Bzr())
 methods.append(hg.Hg())
 methods.append(osc.Osc())
 methods.append(repo.Repo())
diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
deleted file mode 100644
index fc558f50b04..00000000000
--- a/lib/bb/fetch2/bzr.py
+++ /dev/null
@@ -1,128 +0,0 @@
-"""
-BitBake 'Fetch' implementation for bzr.
-
-"""
-
-# Copyright (C) 2007 Ross Burton
-# Copyright (C) 2007 Richard Purdie
-#
-#   Classes for obtaining upstream sources for the
-#   BitBake build tools.
-#   Copyright (C) 2003, 2004  Chris Larson
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-
-import os
-import bb
-from bb.fetch2 import FetchMethod
-from bb.fetch2 import FetchError
-from bb.fetch2 import runfetchcmd
-from bb.fetch2 import logger
-
-class Bzr(FetchMethod):
-    def supports(self, ud, d):
-        return ud.type in ['bzr']
-
-    def urldata_init(self, ud, d):
-        """
-        init bzr specific variable within url data
-        """
-        # Create paths to bzr checkouts
-        bzrdir = d.getVar("BZRDIR") or (d.getVar("DL_DIR") + "/bzr")
-        relpath = self._strip_leading_slashes(ud.path)
-        ud.pkgdir = os.path.join(bzrdir, ud.host, relpath)
-
-        ud.setup_revisions(d)
-
-        if not ud.revision:
-            ud.revision = self.latest_revision(ud, d)
-
-        ud.localfile = d.expand('bzr_%s_%s_%s.tar.gz' % (ud.host, ud.path.replace('/', '.'), ud.revision))
-
-    def _buildbzrcommand(self, ud, d, command):
-        """
-        Build up an bzr commandline based on ud
-        command is "fetch", "update", "revno"
-        """
-
-        basecmd = d.getVar("FETCHCMD_bzr") or "/usr/bin/env bzr"
-
-        proto =  ud.parm.get('protocol', 'http')
-
-        bzrroot = ud.host + ud.path
-
-        options = []
-
-        if command == "revno":
-            bzrcmd = "%s revno %s %s://%s" % (basecmd, " ".join(options), proto, bzrroot)
-        else:
-            if ud.revision:
-                options.append("-r %s" % ud.revision)
-
-            if command == "fetch":
-                bzrcmd = "%s branch %s %s://%s" % (basecmd, " ".join(options), proto, bzrroot)
-            elif command == "update":
-                bzrcmd = "%s pull %s --overwrite" % (basecmd, " ".join(options))
-            else:
-                raise FetchError("Invalid bzr command %s" % command, ud.url)
-
-        return bzrcmd
-
-    def download(self, ud, d):
-        """Fetch url"""
-
-        if os.access(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir), '.bzr'), os.R_OK):
-            bzrcmd = self._buildbzrcommand(ud, d, "update")
-            logger.debug("BZR Update %s", ud.url)
-            bb.fetch2.check_network_access(d, bzrcmd, ud.url)
-            runfetchcmd(bzrcmd, d, workdir=os.path.join(ud.pkgdir, os.path.basename(ud.path)))
-        else:
-            bb.utils.remove(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir)), True)
-            bzrcmd = self._buildbzrcommand(ud, d, "fetch")
-            bb.fetch2.check_network_access(d, bzrcmd, ud.url)
-            logger.debug("BZR Checkout %s", ud.url)
-            bb.utils.mkdirhier(ud.pkgdir)
-            logger.debug("Running %s", bzrcmd)
-            runfetchcmd(bzrcmd, d, workdir=ud.pkgdir)
-
-        scmdata = ud.parm.get("scmdata", "")
-        if scmdata == "keep":
-            tar_flags = ""
-        else:
-            tar_flags = "--exclude='.bzr' --exclude='.bzrtags'"
-
-        # tar them up to a defined filename
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.basename(ud.pkgdir)),
-                    d, cleanup=[ud.localpath], workdir=ud.pkgdir)
-
-    def supports_srcrev(self):
-        return True
-
-    def _revision_key(self, ud, d, name):
-        """
-        Return a unique key for the url
-        """
-        return "bzr:" + ud.pkgdir
-
-    def _latest_revision(self, ud, d, name):
-        """
-        Return the latest upstream revision number
-        """
-        logger.debug2("BZR fetcher hitting network for %s", ud.url)
-
-        bb.fetch2.check_network_access(d, self._buildbzrcommand(ud, d, "revno"), ud.url)
-
-        output = runfetchcmd(self._buildbzrcommand(ud, d, "revno"), d, True)
-
-        return output.strip()
-
-    def sortable_revision(self, ud, d, name):
-        """
-        Return a sortable revision number which in our case is the revision number
-        """
-
-        return False, self._build_revision(ud, d)
-
-    def _build_revision(self, ud, d):
-        return ud.revision

