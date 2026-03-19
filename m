Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441A4107529F
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 12:28:39 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9788.1773923316234886645
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 05:28:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Yx+Hj2jW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so7842005e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773923314; x=1774528114; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yk029to6cIlv8D3f0zDt272H11k9cJlzce37OGoLNH0=;
        b=Yx+Hj2jWI9MHO/D5OibCWHPe19t43cyYfxkDuTrW6jo+VRIdR3rT/pyldwAbgOm5QB
         LgP/5rC/KsfowYAsyjbfOjQOAJIqtVTQ89e/suEeURLCEqNjjbLCshO/sZh043d4AzN5
         8P1fjM8d0vTljzsgNFuHFOc27Hbn7LcwEv45g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773923314; x=1774528114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yk029to6cIlv8D3f0zDt272H11k9cJlzce37OGoLNH0=;
        b=nVekIibGfdve6gSASj8xF/GcgtBxdiUlted6yaAzK18JdIJ79K3nkeFB1RQqunvq4w
         023zLZ0Q2G76O4xfCMQe63pYGrrhjBsbd4uL582J1+hIg97BLFrhSGRVlCm7xMmUwfFq
         7bFl4c2vPK3Ho5Gv1txjUcgQZEne5sPhI1YsqPQuiWoj6StrLVBorhJ5mm4mAMSff5uA
         gaLArlcP32mtQClwgGGajTN8pcjGZSQHBHiky13jAzGTqfc3I6as5UlZTlttNWDC/+TO
         jf5tgKaH/DtPg5AXjOPG8snSwwG5+jMZTtJMtd4NczxnhWBIOjZ2ykJbfan4nLVK1kKH
         TgYA==
X-Gm-Message-State: AOJu0YyR6f53cw1RhztL5QoJNbSdvK6wuKUzZIkvoWJraFHVLcGUKmks
	BBx0QsWlg6x3yucTT4yn9an92zXXdf3rKHwS5gcczQbq7NT11Jg+08DyoC9WPH/VzD4EmRF8jwl
	B6/nKDxQ=
X-Gm-Gg: ATEYQzw5lqncalhJ4ZZ+uYj9ZzGHN020/zEQ7A4MBOMEMLGaMllzBS8qZbZ+RqcHF6G
	MSCXmfnkrNl+6Vqqew+XZxq4WQOSDAUsMOzQDmEkqW+vd6rk92UCdVcasAYtty+RhenZIMXkwp4
	DWvixCgx/VPrpF8WPXzvqPQ/Tp4/uZ9t9BIfTKyqHduN0nILpvTwl50xJKaLYr46nuAU6DGfTk0
	WJjBfkiah3PJttRyul28dWs3O1PLyF1xmxGLlUKAdxQkQGFP445EfPidW34j0tnmR4HAtgsW8X5
	T/FSX44i/fhvFUJhVmJemojiwjyUeShFjGczSPRpVPR/g0Jq80xefXlIlEa8CIsjHzYTCFp/vcE
	QN0sQfAmi3ZXTLjS7QSw6tKmnXICbyePfbI7/tpvfbcIWL4CxVOrLAJF+8kIbZJdu09Lnnznbrw
	P8rND5tJv7oYiw1cfhoa/eVli0Rqc0YYw6lK9/e59lkuT0nD89zBDYM7KoTDde/Q==
X-Received: by 2002:a05:600c:1d0b:b0:485:45fb:3472 with SMTP id 5b1f17b1804b1-486f441bacdmr120114205e9.7.1773923313941;
        Thu, 19 Mar 2026 05:28:33 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ff93:3918:cd96:9fb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4baesm91419815e9.13.2026.03.19.05.28.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:28:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/git: Add an 'update' unpack mode to the fetchers (git only for now)
Date: Thu, 19 Mar 2026 12:28:32 +0000
Message-ID: <20260319122832.2607446-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 12:28:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19172

We need a way to allow the git fetcher to update data in place rather
than remove and replace. This change adds an unpack_update() function
which can be used in place of the usual unpack() call. This will attempt
to rebase changes on top of the upstream changes. It will raise an error
if any local uncommitted changes are present.

The implementation adds a "dldir" origin to the list of origins in the git
repo which we can then fetch from and update against. This origin may be
of use to users accessing the git repo outside the fetcher too.

unpack_update() should never delete existing data in the way unpack() does
but can error out in many more different ways due to the number of possible
input states.

Currently only git is supported.

The intention is for this to use used by bitbake-setup instead of unpack.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 13 ++++++++--
 lib/bb/fetch2/git.py      | 51 +++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index aaefd860204..909ae98146e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1634,6 +1634,9 @@ class FetchMethod(object):
 
         return
 
+    def unpack_update(self, urldata, rootdir, data):
+        raise RuntimeError("No method available for this url type: %s" % urldata.type)
+
     def clean(self, urldata, d):
         """
         Clean any existing full or partial download
@@ -1990,7 +1993,7 @@ class Fetch(object):
             if not ret:
                 raise FetchError("URL doesn't work", u)
 
-    def unpack(self, root, urls=None):
+    def unpack(self, root, urls=None, update=False):
         """
         Unpack urls to root
         """
@@ -2009,7 +2012,10 @@ class Fetch(object):
                     lf = bb.utils.lockfile(ud.lockfile)
 
                 unpack_tracer.start_url(u)
-                ud.method.unpack(ud, root, self.d)
+                if update:
+                    ud.method.unpack_update(ud, root, self.d)
+                else:
+                    ud.method.unpack(ud, root, self.d)
                 unpack_tracer.finish_url(u)
 
             finally:
@@ -2018,6 +2024,9 @@ class Fetch(object):
 
         unpack_tracer.complete()
 
+    def unpack_update(self, root, urls=None):
+        self.unpack(root, urls, update=True)
+
     def clean(self, urls=None):
         """
         Clean files that the fetcher gets or places
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 738174cd104..1de70c5757a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -656,7 +656,10 @@ class Git(FetchMethod):
         # The url is local ud.clonedir, set it to upstream one
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=dest)
 
-    def unpack(self, ud, destdir, d):
+    def unpack_update(self, ud, destdir, d):
+        return self.unpack(ud, destdir, d, update=True)
+
+    def unpack(self, ud, destdir, d, update=False):
         """ unpack the downloaded src to destdir"""
 
         subdir = ud.parm.get("subdir")
@@ -680,7 +683,7 @@ class Git(FetchMethod):
 
         destsuffix = ud.parm.get("destsuffix", def_destsuffix)
         destdir = ud.destdir = os.path.join(destdir, destsuffix)
-        if os.path.exists(destdir):
+        if os.path.exists(destdir) and not update:
             bb.utils.prunedir(destdir)
         if not ud.bareclone:
             ud.unpack_tracer.unpack("git", destdir)
@@ -691,11 +694,15 @@ class Git(FetchMethod):
             ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
 
         source_found = False
+        update_mode = False
         source_error = []
 
         clonedir_is_up_to_date = not self.clonedir_need_update(ud, d)
         if clonedir_is_up_to_date:
-            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
+            if update and os.path.exists(destdir):
+                update_mode = True
+            else:
+                runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
             source_found = True
         else:
             source_error.append("clone directory not available or not up to date: " + ud.clonedir)
@@ -703,8 +710,11 @@ class Git(FetchMethod):
         if not source_found:
             if ud.shallow:
                 if os.path.exists(ud.fullshallow):
-                    bb.utils.mkdirhier(destdir)
-                    runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
+                    if update and os.path.exists(destdir):
+                        update_mode = True
+                    else:
+                        bb.utils.mkdirhier(destdir)
+                        runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
                     source_found = True
                 else:
                     source_error.append("shallow clone not available: " + ud.fullshallow)
@@ -714,6 +724,32 @@ class Git(FetchMethod):
         if not source_found:
             raise bb.fetch2.UnpackError("No up to date source found: " + "; ".join(source_error), ud.url)
 
+        if update_mode:
+            if ud.shallow:
+                bb.fetch2.UnpackError("Can't update shallow clones checkouts without network access, not supported.", ud.url)
+
+            output = runfetchcmd("%s status --porcelain" % (ud.basecmd), d, workdir=destdir)
+            if output:
+                raise bb.fetch2.UnpackError("Repository at %s has uncommitted changes, unable to update:\n%s" % (destdir, output), ud.url)
+
+            # Set up remote for the download location if it doesn't exist
+            try:
+                runfetchcmd("%s remote get-url dldir" % (ud.basecmd), d, workdir=destdir)
+            except bb.fetch2.FetchError:
+                if ud.clonedir:
+                    runfetchcmd("%s remote add dldir file://%s" % (ud.basecmd, ud.clonedir), d, workdir=destdir)
+            try:
+                runfetchcmd("%s fetch dldir" % (ud.basecmd), d, workdir=destdir)
+                runfetchcmd("%s rebase --no-autosquash --no-autostash %s" % (ud.basecmd, ud.revision), d, workdir=destdir)
+            except bb.fetch2.FetchError as e:
+                # If rebase failed, abort it
+                try:
+                    runfetchcmd("%s rebase --abort" % (ud.basecmd), d, workdir=destdir)
+                except Exception:
+                    pass
+                raise bb.fetch2.UnpackError("Failed to update checkout in place: %s" % str(e), ud.url)
+            return True
+
         # If there is a tag parameter in the url and we also have a fixed srcrev, check the tag
         # matches the revision
         if 'tag' in ud.parm and sha1_re.match(ud.revision):
@@ -729,6 +765,11 @@ class Git(FetchMethod):
 
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=destdir)
+        if ud.clonedir:
+            try:
+                runfetchcmd("%s remote get-url dldir" % (ud.basecmd), d, workdir=destdir)
+            except bb.fetch2.FetchError:
+                runfetchcmd("%s remote add dldir file://%s" % (ud.basecmd, ud.clonedir), d, workdir=destdir)
 
         if self._contains_lfs(ud, d, destdir):
             if not need_lfs:

