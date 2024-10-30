Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D49D6B6B1
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:40 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.20164.1730306979014907943
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:49:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=qiNYPonj;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.172, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-72070d341e5so12046b3a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730306978; x=1730911778; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7ax1GpfX2hcri928NKx/n4J2dBkmECGZuHUaHm6UDk=;
        b=qiNYPonjzFS03nYNJq7/nzppzpLj63OfyEtZQG1vHP+F7QxXaEi1gatCk8HWXg13kc
         V5cal3tEAtqSJ0ExXAP2rUm5iAhKAmJaEdRH/rp5bsMlut3mA/fPuYHEC4c3wbI8o7Q2
         CyYi/H0kJGNgDO2eu5gnkG31A/m5Eeh3SDQkbz9oFK2Mc9nuOF8/WIK+bKFUyUwX6CI1
         i+jrm0SmyCkqHaO8vkXr39CAjbJggAxLvv5xky8MtEkviFmDHxcOg9oCYIg/JYmtdWtK
         n2hDuZ+ClA5xFryeruJWg1B56NJ7ogNvjUaGdA9bVqZCfkuPGnKVDRaTdM7yla+Hm8wZ
         woNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306978; x=1730911778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7ax1GpfX2hcri928NKx/n4J2dBkmECGZuHUaHm6UDk=;
        b=T5B84w6FEOGRbDU4Zz3NE4ZhTq7OUUhNV3s5aq55DnucRSeOAoV1ObMh6utx0OHr3T
         HeitJ9GfTAfnEH0qnpuGuyOUFqINcsp/GeLmcQmg/YsMWirXCrDuoGc4k+3H5Evgrhgk
         WYeoo7asKgYL39kElxU8+2dIx6OiHoIQlT4lAJU94hdOmyPtRGhmP4oRH2xK3hW0rIWu
         A9ce3QFlDV/b8ovIuXr3IiapMgj7HmxdtrjdwtluStw8JAoDjeAWn7Ld6E9RoOEld7p1
         9moS2fW+5E9XPMcnVePo5Izo9Aof+N4dPgogM/xIDzkoKZ4HE5NJM8dhzDejOIN5qdHc
         ghYg==
X-Gm-Message-State: AOJu0YyvmWD45RYtQYFL7iQW17UhW1EnTPiiJbadrfV2hIhCHfCOrwK8
	3WIz2J+KQm4+q96JyVlaCn0MS36S+h/sb7lVLb2d8jj7gJI9Gaao1MWFE+DI41NVsyyeu3VizqJ
	T
X-Google-Smtp-Source: AGHT+IGD1MKcwQQOVyrLMcQaHiDEVTKHAIYXpmb/EccesUbPHqoe86BFix4OnC7JYUpK+KR8xvA8kw==
X-Received: by 2002:a05:6a00:1488:b0:71e:7c25:8217 with SMTP id d2e1a72fcca58-720b9de1487mr360884b3a.25.1730306978253;
        Wed, 30 Oct 2024 09:49:38 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e49asm9466200b3a.32.2024.10.30.09.49.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:49:37 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/5] gitsm: Add call_process_submodules() to remove duplicated code
Date: Wed, 30 Oct 2024 09:49:25 -0700
Message-Id: <339fed27d8f6e18c298380e03c4a6b4b041cd161.1730306845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730306845.git.steve@sakoman.com>
References: <cover.1730306845.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:49:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16751

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
index c5f7c03c4..0699645fb 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -139,6 +139,17 @@ class GitSM(Git):
 
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
@@ -156,15 +167,7 @@ class GitSM(Git):
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
@@ -187,16 +190,7 @@ class GitSM(Git):
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
@@ -249,14 +243,6 @@ class GitSM(Git):
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


