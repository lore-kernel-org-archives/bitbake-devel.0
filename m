Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA6A108B8F7
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 11:07:39 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10101.1774004850307733028
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 04:07:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D9JHj93U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486b96760easo20632285e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774004848; x=1774609648; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNs7iTAie1C3Y5FChX0eYzt3UEajE1IRn9Ut9+X1HgM=;
        b=D9JHj93UQP9uqoCN7bswmzYi5aQ5Sw+uHPy/zwAOcoUeP22AmppYua2voA4XC5kmSp
         gpV91CrWqXv/wZmKBa8BrIqomHY+VLHJxy6ug+W2/zyXwWy5qUzWWO7vQA/oTGBfTTDx
         3n06WHkWQih9cVaYtlMspf3jMLGVtViuLxUyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774004848; x=1774609648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNs7iTAie1C3Y5FChX0eYzt3UEajE1IRn9Ut9+X1HgM=;
        b=PT1eujMqZSOralpKU1BYFsCGXirWSqqQjXxWqHlkN2TXe/SjySfMlSPHhn64hJlCqI
         JWm4MjsYQ5I2p7jn1wIQzDvARH9Rjc+MLClyXiPpfkKr4+pmcbnosbzfB6CINUBzpHGw
         w3/mKcHwfA43r0/T7la0NNUwzE97zOn1xx5xVlfkbZ1NPH7NLj7wADBXG/CWGZJg+dUB
         WHxW8DV402Fd76FHmQS3GWepJZ1F6XUfS7WZaDx3LPBSpq3jss7Z3aYRPnnWEbvkIwZE
         3b/WRr3J1fOGDDUyfMP4frHwijxPD0yWX/llgEpjlReqr9krOShBTsmQlqvliQEAUrZ2
         JN6w==
X-Gm-Message-State: AOJu0YyxEHloZouP/HW8grgpQIvlNd8AKOaUszWx+xnjVjH3UN/L2QiE
	fAn3UBn/Q12Y8JFFSJOrOX3UoSqaf6BVV6Dy+03y93uWqfRwt83iQWgBqTrlLFKqk9rPJccUCZk
	k5rOYwQs=
X-Gm-Gg: ATEYQzzYqtr6zPRusl1GTekkV2oDRk4upP7Z2wBv6CBA13QbmkOR1oUjpAcJALW/Jpc
	+s6gB577aDSHAjALVaYoSWcYcV8dn35nnoBachHlmuGDKvzsS/CttkWwnJqdQV3Whgax5V4UB7j
	44kMyKJntUe/tIqZWZeyvLB4ef3BrirNWyNEVuwcBcFKDb4Sww466ICQTRAkKtCZkXHBw2IG/KX
	0AmkjfZgx1og/258kPPfKz6sgV8qDBl94QjviKZN5txCs9dyznlg5WbAk1p++gm39JVEVdm9gcD
	gp0MDBJ0dPzGpQRK0uGzrtbcnCAYyMtSK1CPETFvgwWsyaWrVlaf/FR1xNKyqGOa36J19Cr9L5w
	BAIv2J1/xT7Y+z1ab+87qolF17z5JoOrV59edSGQAZDPg9qp+NhBP7vQjsFwuV+D7cu1x1mMZhE
	ic9aQnz6R3MQGKUZRBoqAZaJA1eYXt+AE4RCApEyACWty/Xbkgs+fa
X-Received: by 2002:a05:600c:47ca:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-4870169a1eemr10494165e9.12.1774004847765;
        Fri, 20 Mar 2026 04:07:27 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:72df:cb96:568c:f7d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff19d393sm13977285e9.16.2026.03.20.04.07.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:07:27 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] fetch/git: Add an 'update' unpack mode to the fetchers (git only for now)
Date: Fri, 20 Mar 2026 11:07:26 +0000
Message-ID: <20260320110726.477775-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 11:07:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19185

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
index 738174cd104..84fecdad07e 100644
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
+                raise bb.fetch2.UnpackError("Can't update shallow clones checkouts without network access, not supported.", ud.url)
+
+            output = runfetchcmd("%s status --untracked-files=no --porcelain" % (ud.basecmd), d, workdir=destdir)
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

