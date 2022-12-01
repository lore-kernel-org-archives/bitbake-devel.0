Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B9C4332F
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 23:11:37 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.60803.1669936294903221014
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Dec 2022 15:11:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RNKaGjIT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id bx10so5328535wrb.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 15:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlHbOS33NNwmejmYO2b3dV4DKZkE/yxCtdH6H0o34qk=;
        b=RNKaGjITiUPAHt2Nj4sWSrtIwPblJayeSh2fkHT0DRXHTwa+lZsR5ct6eJU/Zl7Qci
         8jcTRy0ihN/aTz+6gk2T+P1pUrBmwtlOpAyWMfaR8q7WkSAmBSkKksmX6dWSfankCvcp
         Qp7puipJk9veLEyY+qjYSAvnSlJVkUYTc9ZIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlHbOS33NNwmejmYO2b3dV4DKZkE/yxCtdH6H0o34qk=;
        b=e83tHlb3/rUT4yAUzWm5NEhkV2ECBKiq0cmRvNO8TcIgxIDAZh1hdm8Kcik33hFM+C
         JkeSC493TQDg5+AFI+XEUTXxmU1mse4+oU/T+eJ5w/P+meYLxeKsv9DQU82yFnI3x7qo
         TzYHo9LUuFSk2X38BNbVOELxF2jTtZCMkqaRFQ9bk+5cz3o9rdHQiJO5HZLMKcbzg8vZ
         rgWNBHZGlFTGyO5W+v+SSrCTA2hZnAI3tDgmKJ13pLeKdq1ybeuiB572eqvv9B+3+9Sj
         or7FSUe5YtNVz2fS2aJjYcnHlchXpJsZ7dXFgzIstr29rDupq/4ydTsoxqyZXmneOJ9D
         dzBQ==
X-Gm-Message-State: ANoB5pm6SFsCZag36U0uXOEC8O4INnRe4ek8EweaHeELyOiRpabKgQkj
	unc7as5kucK4Cp7TMU7bVRLsKXvDQfHSXQ==
X-Google-Smtp-Source: AA0mqf5DuykCj6HjzXvzjJqegXEK5sWJ+9BqH8wSr8in8hkDrOHwt8H6OEztcvcpenDySniKWMl0xA==
X-Received: by 2002:a5d:61cd:0:b0:241:f8e3:7111 with SMTP id q13-20020a5d61cd000000b00241f8e37111mr25433388wrv.299.1669936292952;
        Thu, 01 Dec 2022 15:11:32 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f4c:de93:c029:9984])
        by smtp.gmail.com with ESMTPSA id cl8-20020a5d5f08000000b00241fde8fe04sm5695304wrb.7.2022.12.01.15.11.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:11:32 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen/cache: Optionally allow adding siggen hash data to the bitbake cache
Date: Thu,  1 Dec 2022 23:11:31 +0000
Message-Id: <20221201231131.1212052-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 23:11:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14131

Being able to track siggen hash construction data can be useful for cache
debugging. For now, add an extra cache class which contains this information.
It can be enabled in the same way as the hob data cache through a feature flag
to cooker. This allows us to experiment with the data without carrying larger
patches around and ultimately may allow use to have a hash mismatch debugging
mode that is more easily enabled.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py  | 25 +++++++++++++++++++++++++
 lib/bb/cooker.py | 10 +++++-----
 lib/bb/siggen.py |  4 ++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index e1214d6ad2..436a5d2256 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -238,6 +238,31 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootlogs[fn] = self.fakerootlogs
         cachedata.extradepsfunc[fn] = self.extradepsfunc
 
+
+class SiggenRecipeInfo(RecipeInfoCommon):
+    __slots__ = ()
+
+    classname = "SiggenRecipeInfo"
+    cachefile = "bb_cache_" + classname +".dat"
+    # we don't want to show this information in graph files so don't set cachefields
+    #cachefields = []
+
+    def __init__(self, filename, metadata):
+        self.siggen_gendeps = metadata.getVar("__siggen_gendeps", False)
+        self.siggen_varvals = metadata.getVar("__siggen_varvals", False)
+        self.siggen_taskdeps = metadata.getVar("__siggen_taskdeps", False)
+
+    @classmethod
+    def init_cacheData(cls, cachedata):
+        cachedata.siggen_taskdeps = {}
+        cachedata.siggen_gendeps = {}
+        cachedata.siggen_varvals = {}
+
+    def add_cacheData(self, cachedata, fn):
+        cachedata.siggen_gendeps[fn] = self.siggen_gendeps
+        cachedata.siggen_varvals[fn] = self.siggen_varvals
+        cachedata.siggen_taskdeps[fn] = self.siggen_taskdeps
+
 def virtualfn2realfn(virtualfn):
     """
     Convert a virtual file name to a real one + the associated subclass keyword
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5a5ba7fb70..4be95dd7fb 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -80,7 +80,7 @@ class SkippedPackage:
 
 
 class CookerFeatures(object):
-    _feature_list = [HOB_EXTRA_CACHES, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS] = list(range(3))
+    _feature_list = [HOB_EXTRA_CACHES, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS, RECIPE_SIGGEN_INFO] = list(range(4))
 
     def __init__(self):
         self._features=set()
@@ -367,12 +367,12 @@ class BBCooker:
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.enableDataTracking()
 
-        all_extra_cache_names = []
+        caches_name_array = ['bb.cache:CoreRecipeInfo']
         # We hardcode all known cache types in a single place, here.
         if CookerFeatures.HOB_EXTRA_CACHES in self.featureset:
-            all_extra_cache_names.append("bb.cache_extra:HobRecipeInfo")
-
-        caches_name_array = ['bb.cache:CoreRecipeInfo'] + all_extra_cache_names
+            caches_name_array.append("bb.cache_extra:HobRecipeInfo")
+        if CookerFeatures.RECIPE_SIGGEN_INFO in self.featureset:
+            caches_name_array.append("bb.cache:SiggenRecipeInfo")
 
         # At least CoreRecipeInfo will be loaded, so caches_array will never be empty!
         # This is the entry point, no further check needed!
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 34b71d596a..3731cd6b69 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -252,6 +252,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
             basehashes[task] = self.basehash[fn + ":" + task]
 
         d.setVar("__siggen_basehashes", basehashes)
+        d.setVar("__siggen_gendeps", self.gendeps[fn])
+        d.setVar("__siggen_varvals", self.lookupcache[fn])
+        d.setVar("__siggen_taskdeps", self.taskdeps[fn])
+
 
     def postparsing_clean_cache(self):
         #
-- 
2.34.1


