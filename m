Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0615D6B6A2
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:39 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.18608.1730304096787464826
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:01:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=wrM/cMWd;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.178, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-208cf673b8dso65520215ad.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730304096; x=1730908896; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+P6VO2Dt2ncFUue5XYCYncaHg/N/ar9MngzijxPvv8=;
        b=wrM/cMWdqbYZkN9h+YH5i2xC9Dax0lCwP2/pWRsOcw3giji4KYtN3n/kTy1Xb0ougp
         +6YswkiA6zgjUD39VGZwbqbQ+sluOBE2MDDRnv4qjIkgvuGqBGK75KJv4Hz0HW+OXx+u
         1s4Gf6B8t+jJTPlKqU6DXN4ap58aBeZ5lnNMO5rwTngP/00Lp72yWmpCdMqfHGkwL1DT
         PPdcrxkX/3G30M0h4kgvILVfLG1Loh5R8I8E3HsgOulA+E4FRFGUq6kql+FF3cJPy7C0
         04NpN2exwK43qngy0QeYsS5g+ZrhD0z8+cqTUqnlOswiZguK3kacDN0t5g5/cuBy1w9d
         oaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304096; x=1730908896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+P6VO2Dt2ncFUue5XYCYncaHg/N/ar9MngzijxPvv8=;
        b=DTjD8f5tgIe8Gccnv/Rvo153UPFtFutj10rTcxcys26gik+F+ustomajlu8NsKMO9b
         Iwzc2WqhWf0jZUKwxHmEfz/ULy4IxfwMflFpx2uPuIUHamTGwhDsxrdQoKbxGH3//jvM
         j2QmX5whL5WeYcGvdR0IdZIss5AALb5AlYWMF1LrVKDls+3rYw/gIQHxjTcBg4ZiAyu6
         8YGhZ/Hjv1AmmaTxVIv32u3HGiviwGWy1tzqgIhxDlKDn8u74uLlmVi0lhUrXjEuM1+z
         RAntHGBNcadN4e4LMAKK6yq5i14h/veALYliqpWeFNIp934woEd67Dta/ZRIK0c7naLH
         Z/1g==
X-Gm-Message-State: AOJu0YwTOuFrH/xnqT/LV5KzijIaBUbbnKq46Y2RZgdzMC0c5kWfoZtm
	rcvtopmcBh2Pjdz34BPdDrprSwPIGoq+iEkVhsBavFkah2ujCINiFiLmKtavlR/GHxn/RVQZfKZ
	I
X-Google-Smtp-Source: AGHT+IHHMSml6xiUek2nocgOsgpHe+H7YY7ZqygVrqpR9bxCyugT58OnmIN4kQ8y6YfsqohLK2DLWw==
X-Received: by 2002:a17:90b:3654:b0:2e0:7b2b:f76 with SMTP id 98e67ed59e1d1-2e8f1072f43mr17554212a91.19.1730304095930;
        Wed, 30 Oct 2024 09:01:35 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa26a4fsm1911814a91.23.2024.10.30.09.01.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:01:35 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 1/4] gitsm: Add call_process_submodules() to remove duplicated code
Date: Wed, 30 Oct 2024 09:01:21 -0700
Message-Id: <a09294a5e139a67b75bfc35abae59e348129a1e0.1730303370.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730303370.git.steve@sakoman.com>
References: <cover.1730303370.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:01:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16746

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


