Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3935.1795855313725592276
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 28 Nov 2026 00:41:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WNwNlo/N;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so8017236f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 28 Nov 2026 00:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795855311; x=1796460111; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fakLztGFBbgqfeerkFazS2rsBVW90rWC9knePmc0viM=;
        b=WNwNlo/NfbGEx6QK+PslRKT/z8zZnbwEBETAn/mJ8QhZtI7bgT489LoMAMo0f0wrzz
         xzez2WUtqXkCibQoaZuJ9w7nT6ekhP60hN88wgeA72mq0G1i/gF58739HMVI3LBJyuBN
         qh6A7XZSWmFDlJBM1NjHod/BWjDcuNE4UQ73I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795855311; x=1796460111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fakLztGFBbgqfeerkFazS2rsBVW90rWC9knePmc0viM=;
        b=Nz+/ZTX9sm0JzaFoydkYwTLElhkHLP4W5XDZ9p/OjDTSuU4VuDQbonnkvrDcgDLvaR
         lfEm8XOf1Bxu4aheFXKSCsCc+bBH1IMrsQ5XpqFEuqU94HSMZZ/I6jwx82jfX53HeWob
         DOR+eQP1bn/FBg58lSLHkgnnzidy2qPzCISHneeRQLSJwRI+FXrZnvzJ2l32FFHTzXvC
         ODflelC95enQbnvoH/Wbso4534EM4M1MFKbRN4oOflD1mNZHP84GdkkSNIBayZVpYzGu
         MOi+mn6LnhSM7lxU+txuj+IQHGQMR4luJ/y9qN8Zi2B9cf6yPNH3BScPwfwyHmUxfFZd
         0JQQ==
X-Gm-Message-State: APuU4Z9DkT9ACH9i2oR1pyWlb0/+S5mWi7TcX6BgDHEpoj/VozAuENqr
	nHvDKZ7gx4eTpp5eLZ1zfZ9fEgQKSGsqpuDQm6rKnYhB3LB1vBFyBb6XHv6ug2tUorrPn0nrw+v
	tR3iICEM=
X-Gm-Gg: AZFdTZct4ZTJLP0StAQ6o5XjrBxrkfcall1uftdd1nOp83RjT+NzTMe35WtxNxDtqM3
	OIpmNpoYYLHRpSdfcwpIQ2fZpIQ8gfQfLn+uycM5b1mfUsjri7bK91dDgz/3EVGgCzuZQlsFTS8
	emQU9o0qfbWf8JXrmkLD+llycu79nMFMY4NfwSmj+0Gk7sc6Jejb+8gV/09pR99KLDK0KE3bXuz
	yhotnuEgm7Xv/AB+XkuQDfb7ehmo0lx4mayRFkBm1N2Ns/3n4s4s14DEvS3WptvtlHLfEpyDNeK
	XylrRiFw+aqmFTe+8b9QJeuZ8njCaToXAdrjULeoXyKLpR/4fJnG2l8LKHjdsRpYtPxdKm6wA1x
	U4DpwfZEwRBX2GLflByWik00rmcmBgcevz/mktJrLPl45oLGqDahhawoxIiK63gHgZUd8dAEJF9
	tYk4PherSKe+Uifoqe3Mzq5rgVfq5x2efFDIUagR2UAyqKO0OtqKp+GRBc+sxI37Nxf1UVepKPf
	Y5XYp6zedGG7kZ3+t2ooknuPYX9MZqsX5kG+cuKHy0QJmBDESf25E7/jxqKYgMSuPTgWSWjl3cu
	TdJwDArn3kH7TpoCTbyWBtZTbebPBSktMqSWM3NxwMNF5yeYHzpwPnDvzPElBnE8stqx0rkSeiD
	WiHa+
X-Received: by 2002:a05:600d:17:b0:4bb:aa4f:c027 with SMTP id 5b1f17b1804b1-4bbaa4fc171mr165117745e9.0.1795855311389;
        Sat, 28 Nov 2026 00:41:51 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1739:bc1e:4865:8522])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab5ffcad11sm50039664f8f.0.2026.11.28.00.41.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 00:41:50 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] cache: Add support for BB_CACHE_EXTRAVARS
Date: Sat, 28 Nov 2026 08:41:48 +0000
Message-ID: <20261128084149.2414987-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sat, 28 Nov 2026 08:42:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20482
Content-Type: text/plain; charset="utf-8"

This allows the metadata to specify that some variables should be cached on a per
recipe basis.

This is useful for example to allow RECIPE_HOSTTOOLS in OE-Core to error up front
in a build if tools are missing rather than the build failing part way through.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 39d051402e1..67c3f14ccc1 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -27,7 +27,7 @@ import shutil
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "156"
+__cache_version__ = "157"
 
 def getCacheFile(path, filename, mc, data_hash):
     mcspec = ''
@@ -131,6 +131,11 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.fakerootnoenv    = self.getvar('FAKEROOTNOENV', metadata)
         self.extradepsfunc    = self.getvar('calculate_extra_depends', metadata)
 
+        self.extravars = self.listvar('BB_CACHE_EXTRAVARS', metadata)
+        if self.extravars:
+            for var in self.extravars:
+                setattr(self, var, self.getvar(var, metadata))
+
     @classmethod
     def init_cacheData(cls, cachedata):
         # CacheData in Core RecipeInfo Class
@@ -168,6 +173,8 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootlogs = {}
         cachedata.extradepsfunc = {}
 
+        cachedata.extravars = {}
+
     def add_cacheData(self, cachedata, fn):
         cachedata.task_deps[fn] = self.task_deps
         cachedata.pkg_fn[fn] = self.pn
@@ -237,6 +244,9 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootlogs[fn] = self.fakerootlogs
         cachedata.extradepsfunc[fn] = self.extradepsfunc
 
+        cachedata.extravars[fn] = {}
+        for var in self.extravars:
+            cachedata.extravars[fn][var] = getattr(self, var)
 
 class SiggenRecipeInfo(RecipeInfoCommon):
     __slots__ = ()
