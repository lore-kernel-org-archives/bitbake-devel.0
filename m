Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6697CD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:58 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17311.1780483729051124556
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 03:48:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Gn59smDU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-46015dc517aso2371497f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780483727; x=1781088527; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECwLOKzEL1DPg7svBOpvAa7iKJDZb5pYLvIEmH3sy6Q=;
        b=Gn59smDU2yCJpI62Ak+EH7tNSHqtQNa8PVYq+m4xADxHO/nHHM505U89vNfPjWmaki
         K4Zuy9ov5GQFQg2RVzlWHU/Vf+sPuUdZLFtEqPiZZXAbMtuD+wMVKYS1V0kuB/oR/6cx
         h/lOVcHtUS8khwGUYsjou7YWAdLAeHf5e7Q6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483727; x=1781088527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECwLOKzEL1DPg7svBOpvAa7iKJDZb5pYLvIEmH3sy6Q=;
        b=eQCZk0IOt03u81FW7tDv7Y86FRgdXg1kTbtgrcmVW5p5f0bjopGQkBSera3BGyHhgZ
         iRwmM6mdZw09R9cntXo8jLEgM651p/J6/0tf/+DZarLk1SDCQjfSLCzM4sm1fIR8Z/Dg
         OErw0teRtZZGXn5EoUNSJEOKJVt35Od5YOtJF6DPufX96aRdoayY/AtQipSpbCsplk4x
         IfEABSGZIWWH9rX/IjnGQ7Xf5HQiz1A+wCI54a54WhoLDXfjyYLRmXAZ3KXPXaNzL+vv
         CLET19G0BAKIY/TXYbRWiGo3TXohpVXOnrVXLZThbOCrjWttcRIKHYu7Cw9hWKHpWBXH
         /VgA==
X-Gm-Message-State: AOJu0YyWjvdzPEFM0MrtVMIByomkycZjffdk9fOyGVNZTIqKePc7SEmt
	ffu1ak92cwJwmlhTSjw/ry9awPn7sFkj6Ej08yM3Uju81CVDIeoBRDGLgiPOaoHcdNfRVKo/5jG
	z9OH6
X-Gm-Gg: Acq92OEHDR2JkIycldYXRJKBr57HulSla2Xnb1FImB6KHdBTeF697hW74efNLqfYb26
	mqVQO1N5q21y951L8emRkQYZf9fJDZ8j5larKq7EtVCQAwtD6Re83y7wpXOJvYtD5zQzj8FoBMe
	T4sgPWZ4VKWFFb8A4HQRhqejegYHTzN/OnyYfba0KglhEEZZ8korg3OLe72PayQK1b5wNVgoioR
	XyMPD5sQ2JUhQ0ezfWQFJnjfgBma75T2SCc3d/6d+I++pQ/0A64XsU7VES7EGABl31r64GZHAqq
	WsJg8kxnpBdBqlsf9EFc6r9KwG2v10sWKeTZSALOxSUSzkGB0t6kTgoQzaER7WMZPQNE6nE3B2Z
	fvQi0CZE5ivkLVtVMhJoIASYUHD6Veua1vuBAojl2+xFUWCCXjKYixf/Cwplv2xOw5o+ZUCzlfI
	wK9khD9YLU2qZ0mJI4o4W2yZi+hkpEZLEuXgnT7q5z/DKf3iXiaZpwAQ2zCN2Bh3XWu3e6a1eh
X-Received: by 2002:a05:6000:1818:b0:45e:9421:4ca8 with SMTP id ffacd0b85a97d-4602184bfe7mr3359279f8f.28.1780483727291;
        Wed, 03 Jun 2026 03:48:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8090759f8f.30.2026.06.03.03.48.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:48:45 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/8] fetch/svn: Convert to use lists of command arguments
Date: Wed,  3 Jun 2026 11:48:37 +0100
Message-ID: <20260603104840.815399-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
References: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 10:48:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19598

To follow best practises and avoid shell=True subprocess usage, convert
the fetcher commands to use lists instead of strings. This improves variable
quoting and models modern coding standards.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/svn.py | 71 +++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index b5862139fac..84e15c02d3c 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -13,6 +13,7 @@ BitBake 'Fetch' implementation for svn.
 import os
 import bb
 import re
+import shlex
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import MissingParameterError
@@ -34,7 +35,7 @@ class Svn(FetchMethod):
         if not "module" in ud.parm:
             raise MissingParameterError('module', ud.url)
 
-        ud.basecmd = d.getVar("FETCHCMD_svn") or "/usr/bin/env svn --non-interactive"
+        ud.basecmd = shlex.split(d.getVar("FETCHCMD_svn") or "") or ['svn', '--non-interactive']
 
         ud.module = ud.parm["module"]
 
@@ -83,15 +84,17 @@ class Svn(FetchMethod):
         options.append("--no-auth-cache")
 
         if ud.user:
-            options.append("--username %s" % ud.user)
+            options.append("--username")
+            options.append(ud.user)
 
         if ud.pswd:
-            options.append("--password %s" % ud.pswd)
+            options.append("--password")
+            options.append(ud.pswd)
 
         if command == "info":
-            svncmd = "%s info %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
+            svncmd = ud.basecmd + ['info'] + options + ['%s://%s/%s/' % (proto, svnroot, ud.module)]
         elif command == "log1":
-            svncmd = "%s log --limit 1 --quiet %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
+            svncmd = ud.basecmd + ['log', '--limit', '1', '--quiet'] + options + ['%s://%s/%s/' % (proto, svnroot, ud.module)]
         else:
             suffix = ""
 
@@ -102,22 +105,24 @@ class Svn(FetchMethod):
                 options.append("--ignore-externals")
 
             if ud.revision:
-                options.append("-r %s" % ud.revision)
+                options.append("-r")
+                options.append(ud.revision)
                 if ud.pegrevision:
                     suffix = "@%s" % (ud.revision)
 
             if command == "fetch":
                 transportuser = ud.parm.get("transportuser", "")
-                svncmd = "%s co %s %s://%s%s/%s%s %s" % (ud.basecmd, " ".join(options), proto, transportuser, svnroot, ud.module, suffix, ud.path_spec)
+                svncmd = ud.basecmd + ['co'] + options + ['%s://%s%s/%s%s' % (proto, transportuser, svnroot, ud.module, suffix), ud.path_spec]
             elif command == "update":
-                svncmd = "%s update %s" % (ud.basecmd, " ".join(options))
+                svncmd = ud.basecmd + ['update'] + options
             else:
                 raise FetchError("Invalid svn command %s" % command, ud.url)
 
+        extraenv = {}
         if svn_ssh:
-            svncmd = "SVN_SSH=\"%s\" %s" % (svn_ssh, svncmd)
+            extraenv['SVN_SSH'] = svn_ssh
 
-        return svncmd
+        return svncmd, extraenv
 
     def download(self, ud, d):
         """Fetch url"""
@@ -128,45 +133,47 @@ class Svn(FetchMethod):
 
         try:
             if os.access(os.path.join(ud.moddir, '.svn'), os.R_OK):
-                svncmd = self._buildsvncommand(ud, d, "update")
+                svncmd, extraenv = self._buildsvncommand(ud, d, "update")
                 logger.info("Update " + ud.url)
                 # We need to attempt to run svn upgrade first in case its an older working format
                 try:
-                    runfetchcmd(ud.basecmd + " upgrade", d, workdir=ud.moddir)
+                    runfetchcmd(ud.basecmd + ["upgrade"], d, workdir=ud.moddir)
                 except FetchError:
                     pass
                 logger.debug("Running %s", svncmd)
                 bb.fetch2.check_network_access(d, svncmd, ud.url)
-                runfetchcmd(svncmd, d, workdir=ud.moddir)
+                runfetchcmd(svncmd, d, workdir=ud.moddir, extraenv=extraenv)
             else:
-                svncmd = self._buildsvncommand(ud, d, "fetch")
+                svncmd, extraenv = self._buildsvncommand(ud, d, "fetch")
                 logger.info("Fetch " + ud.url)
                 # check out sources there
                 bb.utils.mkdirhier(ud.pkgdir)
                 logger.debug("Running %s", svncmd)
                 bb.fetch2.check_network_access(d, svncmd, ud.url)
-                runfetchcmd(svncmd, d, workdir=ud.pkgdir)
+                runfetchcmd(svncmd, d, workdir=ud.pkgdir, extraenv=extraenv)
 
             if not ("externals" in ud.parm and ud.parm["externals"] == "nowarn"):
                 # Warn the user if this had externals (won't catch them all)
-                output = runfetchcmd("svn propget svn:externals || true", d, workdir=ud.moddir)
-                if output:
-                    if "--ignore-externals" in svncmd.split():
-                        bb.warn("%s contains svn:externals." % ud.url)
-                        bb.warn("These should be added to the recipe SRC_URI as necessary.")
-                        bb.warn("svn fetch has ignored externals:\n%s" % output)
-                        bb.warn("To disable this warning add ';externals=nowarn' to the url.")
-                    else:
-                        bb.debug(1, "svn repository has externals:\n%s" % output)
-
+                try:
+                    output = runfetchcmd(['svn', 'propget', 'svn:externals'], d, workdir=ud.moddir)
+                    if output:
+                        if "--ignore-externals" in svncmd:
+                            bb.warn("%s contains svn:externals." % ud.url)
+                            bb.warn("These should be added to the recipe SRC_URI as necessary.")
+                            bb.warn("svn fetch has ignored externals:\n%s" % output)
+                            bb.warn("To disable this warning add ';externals=nowarn' to the url.")
+                        else:
+                            bb.debug(1, "svn repository has externals:\n%s" % output)
+                except bb.fetch2.FetchError:
+                    passs
             scmdata = ud.parm.get("scmdata", "")
             if scmdata == "keep":
-                tar_flags = ""
+                tar_flags = []
             else:
-                tar_flags = "--exclude='.svn'"
+                tar_flags = ["--exclude='.svn'"]
 
             # tar them up to a defined filename
-            runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.path_spec), d,
+            runfetchcmd(['tar'] + tar_flags + ['-czf', ud.localpath, ud.path_spec], d,
                         cleanup=[ud.localpath], workdir=ud.pkgdir)
         finally:
             bb.utils.unlockfile(lf)
@@ -191,9 +198,11 @@ class Svn(FetchMethod):
         """
         Return the latest upstream revision number
         """
-        bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "log1"), ud.url)
-
-        output = runfetchcmd(self._buildsvncommand(ud, d, "log1"), d, True, extraenv={'LANG':'C', 'LC_ALL': 'C'})
+        cmd, extraenv = self._buildsvncommand(ud, d, "log1")
+        bb.fetch2.check_network_access(d, cmd, ud.url)
+        extraenv['LANG'] = 'C'
+        extraenv['LC_ALL'] = 'C'
+        output = runfetchcmd(cmd, d, True, extraenv=extraenv)
 
         # skip the first line, as per output of svn log
         # then we expect the revision on the 2nd line

