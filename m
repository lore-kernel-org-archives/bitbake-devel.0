Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1477.1795801581486622069
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Nov 2026 09:46:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Kn8FUN+o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso84834335e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2026 09:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795801580; x=1796406380; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VcZQoLfV/uT2c1x4SoXRb7+GGRNaFRY7hfq2W28crR0=;
        b=Kn8FUN+oA2je7NSF2+4e1Ksv5Bw6Lhwkw8ToWpFnl8DjSW0S5/Q6+HXhdF8Eimouni
         3RGbDdm7UfafW8Hvzd2QF4y3ab8Y9Y5sHwETCifJuhQ1v92ZAdc+eDt5887UR1CdvLXS
         tPcgZAmo14iAqeESbdlD6YH4ORIikF7BWyn2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801580; x=1796406380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VcZQoLfV/uT2c1x4SoXRb7+GGRNaFRY7hfq2W28crR0=;
        b=01vx2e0f44eLgvvm+9Uc51o3BM69DCrfzCjpPWZi8hG/kWKXjoPKV4CNvOHxuAfHnx
         ttAKlsikeeV7s8Zk2hd4oTnlGr1Kznn5bFR7tAeTo1NVNo78J7Ngv/ZQEbPPVXh4Rli1
         Z67biH7qymT4Ol6QbuYssNfmzcMYu6tJa2rQrWsGae/Jaf33Mw1lklkuRu7KdWySzHkf
         fWvzLsiy3ygtejBUWvne7sDUz2dnIVCj2VB0KWM5gse+WnOpQkkIYLD/Eih424ikymOo
         UuULXED/4a1NKAymBuc21NEAs2forIrFF+PlePd6PPyo+xfV3IoFdz+NT2oYm+92OV/g
         BVuw==
X-Gm-Message-State: APuU4Z/gw6JhUdQoWoCxPS65bUMD1PLKvUTBQ7gX6dC7cU4oteuumelC
	qDzwK+xoJsn91W0wONc9c0GDc83G6k69KR8N+hmpd8tF1so7i4mbLWdZ2sbpV27UDVdRtqMGFz1
	Ez/pj0uU=
X-Gm-Gg: AZFdTZfJ/F1b2YCBepJnD+6nsyWRE1qK4wABJwzY33pJTb3r7QOLH6cVCrUVx/l9Y4f
	JiFLPf6vIXrU/83XvWNSkmfAt6tWqO+2FOV/ATSz0btpquicpuWAJYvR4NdAhlv+BoJS6OYYEm4
	dca1RyqXTSDidvEDIxYVh0+17KB5M+AHv680Kvr8B4pVL1FGYdIYyPBOrOCKAvbsR6mRUm2BIm5
	B557pot+Qm3/J84ebIuW4FU6x3mad1PBDKXSrU5Y7y8sdQVoEBr0CoUfUi+o3ZuDfdFiuSOT454
	bX4iBRUFwcLwtNQGfnKWRqtNaAzcxk2LaSD149JHjiim9yGF4/Mae/UplKqZUgdRVgImcz3o3R2
	5Io4OTr2/FtPMyIa3hvDBzbigWe/JNqNv7BOxuTgrsFEJfh0VW+uvCWj0Ln/NCxpkw2liKulgEv
	2ozCpheOmare4BkjHHC/23snAQ6JmiP1UjxtbR24wHAzjElHnM/WV0+R5/UMEG9EvHIOyQeli7u
	+7hcIzOZOxi4cHF4iR+wzajZSN+uCKdAn9i6Y6n00kFJS6OUTomzwsqpSBFxc5M/9D6PGLPJyIp
	1k4L9lK8izIMuylhu+B9JUI/SI2gm3ewW3/ouhtXmmALE79Vq86vx62oDPbxp0aiEMlMV/vYhLt
	ksDg=
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb888120famr519096175e9.16.1795801579697;
        Fri, 27 Nov 2026 09:46:19 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:47cb:b596:3be3:8f97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm790022715e9.3.2026.11.27.09.46.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:46:19 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] cache: Add support for BB_CACHE_EXTRAVARS
Date: Fri, 27 Nov 2026 17:46:15 +0000
Message-ID: <20261127174616.2269186-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127174616.2269186-1-richard.purdie@linuxfoundation.org>
References: <20261127174616.2269186-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2026 17:46:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20480
Content-Type: text/plain; charset="utf-8"

This allows the metadata to specify that some variables should be cached on a per
recipe basis.

This is useful for example to allow RECIPE_HOSTTOOLS in OE-Core to error up front
in a build if tools are missing rather than the build failing part way through.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 39d051402e1..492fc75e3ad 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -27,7 +27,7 @@ import shutil
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "156"
+__cache_version__ = "157"
 
 def getCacheFile(path, filename, mc, data_hash):
     mcspec = ''
@@ -131,6 +131,14 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.fakerootnoenv    = self.getvar('FAKEROOTNOENV', metadata)
         self.extradepsfunc    = self.getvar('calculate_extra_depends', metadata)
 
+        self.extravars = self.listvar('BB_CACHE_EXTRAVARS', metadata)
+        if self.extravars:
+            for var in self.extravars:
+                val = self.getvar(var, metadata)
+                if val:
+                    bb.warn(str(val))
+                setattr(self, var, self.getvar(var, metadata))
+
     @classmethod
     def init_cacheData(cls, cachedata):
         # CacheData in Core RecipeInfo Class
@@ -168,6 +176,8 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootlogs = {}
         cachedata.extradepsfunc = {}
 
+        cachedata.extravars = {}
+
     def add_cacheData(self, cachedata, fn):
         cachedata.task_deps[fn] = self.task_deps
         cachedata.pkg_fn[fn] = self.pn
@@ -237,6 +247,9 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootlogs[fn] = self.fakerootlogs
         cachedata.extradepsfunc[fn] = self.extradepsfunc
 
+        cachedata.extravars[fn] = {}
+        for var in self.extravars:
+            cachedata.extravars[fn][var] = getattr(self, var)
 
 class SiggenRecipeInfo(RecipeInfoCommon):
     __slots__ = ()
