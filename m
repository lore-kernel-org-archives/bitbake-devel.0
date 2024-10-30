Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4315D6B6CC
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 19:12:30 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.23489.1730315543920601201
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 12:12:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=ALb5ZpTZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.53, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso114384a91.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730315543; x=1730920343; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+P6VO2Dt2ncFUue5XYCYncaHg/N/ar9MngzijxPvv8=;
        b=ALb5ZpTZpfY0+0c0fgXmZTYI54veE4LOtKDljUxBxRwF+8YUZmEJQNKo126w4yuRZa
         6win9clQ6y9a5cXGPV5k8Qc2SHI952OOnQ0rfo4X1TJ2sZ8ZP5Toc/eJdbeatnzAJIl+
         pT5FxrZ3K839a+AqtTBWJ5j8r6rZ7AoFztK+uasuqqGd86rWtsWXbDYrdMmYS1TYCPgX
         8SZZv+WcN+l8446EiwiDVOlZHMNPxkuwpvXutCTx2KTviubyI++i3pQjoC4gWZRj1M1L
         oXIoF95boeYKBt9/glMcBBn7Fg29x5Apum3VfojB4Ekh8gpqisbBTZqJSk1CPm7/coRS
         UhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730315543; x=1730920343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+P6VO2Dt2ncFUue5XYCYncaHg/N/ar9MngzijxPvv8=;
        b=gasK122RbI3+HGMCwNGIlwEE9xU0Gwcyq1p4YAeQ7RxvxSIZVbzo1w7Udz15GThi/h
         22weS161mZKetqTyzal1O6LsASwBVZuokXKUk9yltD7CbmtKAAu+c9kNsES20QiiCou2
         rSAHUZGB+MhLmPTOTFkxP5SvRED0LFndccip9icqulMLiMUWiN/x7m0DGZ7N85EfmYX/
         ldt4L8/AOHawklh58SlUNyovX/h3lNYkzZuOts24rI9whjRyO0c14/kHhCWD2LA2m3lJ
         JYz26TPUrIFvtBP7jT0OLAkM1tdqmOjxKp1tFoRKFT3Dl4Xn8JIrOoH0iZJ57jixj0XQ
         Pz5g==
X-Gm-Message-State: AOJu0YweMzoPtbFu0EhNtRb9prO1hJ/m59lnF1yCuhBse9M+h3XFzXXb
	Re9YDHtPur/2h+atI02dMrIYZYQyQTcEVLj68jKoVYRVRikrbX0xmWUqRWr1MEQKatMnwPJWOWl
	z
X-Google-Smtp-Source: AGHT+IHdviYvk7H+vqJ7BavcyEiRqOOzpfKTlXBO1h5B/wK9GE9GEhR8IConTTM4Xjum4gsiWqKkDA==
X-Received: by 2002:a17:90b:3755:b0:2e2:de27:db09 with SMTP id 98e67ed59e1d1-2e8f1078c4dmr17634206a91.19.1730315543046;
        Wed, 30 Oct 2024 12:12:23 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa36672sm2248203a91.14.2024.10.30.12.12.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:12:22 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/4] gitsm: Add call_process_submodules() to remove duplicated code
Date: Wed, 30 Oct 2024 12:12:05 -0700
Message-Id: <e3443a490035fb0fba465efcd154ffa24f044916.1730315315.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730315315.git.steve@sakoman.com>
References: <cover.1730315315.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 19:12:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16757

From: Robert Yang <liezhi.yang@windriver.com>

There are 14 lines can be removed, and can make it easy to maintain.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0ea2c1ac079d63349407a69172ff80cd9acc7252)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/gitsm.py | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f7f3af721..17aac6357 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -147,6 +147,17 @@ class GitSM(Git):
 
         return submodules != []
 
+    def call_process_submodules(self, ud, d, extra_check, subfunc):
+        # If we're using a shallow mirror tarball it needs to be
+        # unpacked temporarily so that we can examine the .gitmodules file
+        if ud.shallow and os.path.exists(ud.fullshallow) and extra_check:
+            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+            self.process_submodules(ud, tmpdir, subfunc, d)
+            shutil.rmtree(tmpdir)
+        else:
+            self.process_submodules(ud, ud.clonedir, subfunc, d)
+
     def need_update(self, ud, d):
         if Git.need_update(self, ud, d):
             return True
@@ -164,15 +175,7 @@ class GitSM(Git):
                 logger.error('gitsm: submodule update check failed: %s %s' % (type(e).__name__, str(e)))
                 need_update_result = True
 
-        # If we're using a shallow mirror tarball it needs to be unpacked
-        # temporarily so that we can examine the .gitmodules file
-        if ud.shallow and os.path.exists(ud.fullshallow) and not os.path.exists(ud.clonedir):
-            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
-            self.process_submodules(ud, tmpdir, need_update_submodule, d)
-            shutil.rmtree(tmpdir)
-        else:
-            self.process_submodules(ud, ud.clonedir, need_update_submodule, d)
+        self.call_process_submodules(ud, d, not os.path.exists(ud.clonedir), need_update_submodule)
 
         if need_update_list:
             logger.debug('gitsm: Submodules requiring update: %s' % (' '.join(need_update_list)))
@@ -195,16 +198,7 @@ class GitSM(Git):
                 raise
 
         Git.download(self, ud, d)
-
-        # If we're using a shallow mirror tarball it needs to be unpacked
-        # temporarily so that we can examine the .gitmodules file
-        if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
-            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
-            self.process_submodules(ud, tmpdir, download_submodule, d)
-            shutil.rmtree(tmpdir)
-        else:
-            self.process_submodules(ud, ud.clonedir, download_submodule, d)
+        self.call_process_submodules(ud, d, self.need_update(ud, d), download_submodule)
 
     def unpack(self, ud, destdir, d):
         def unpack_submodules(ud, url, module, modpath, workdir, d):
@@ -263,14 +257,6 @@ class GitSM(Git):
             newfetch = Fetch([url], d, cache=False)
             urldata.extend(newfetch.expanded_urldata())
 
-        # If we're using a shallow mirror tarball it needs to be unpacked
-        # temporarily so that we can examine the .gitmodules file
-        if ud.shallow and os.path.exists(ud.fullshallow) and ud.method.need_update(ud, d):
-            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            subprocess.check_call("tar -xzf %s" % ud.fullshallow, cwd=tmpdir, shell=True)
-            self.process_submodules(ud, tmpdir, add_submodule, d)
-            shutil.rmtree(tmpdir)
-        else:
-            self.process_submodules(ud, ud.clonedir, add_submodule, d)
+        self.call_process_submodules(ud, d, ud.method.need_update(ud, d), add_submodule)
 
         return urldata
-- 
2.34.1


