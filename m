Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2830DC4332F
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 22:17:47 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.59199.1669933059303733676
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Dec 2022 14:17:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ho3C9hUJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id o5so5120148wrm.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhCdn8X4mk/It4h+o0MtW+a9keQiIWZfYmGP2sKt9vY=;
        b=Ho3C9hUJ5TtDOchYN4odb/5PYZwSD4S/F9Dakdi7yoHkqu9uZ2PTSfOUdYy+elywDF
         zIIAUBGLKqMn2WrJflOagsGJ9JBftxlp/AdkYW85ULIcMGLyF2ohHFZN66jk11WsTQYl
         G9QK1IdiJ1cKIOvMtHyxp0+e6KjZ0TMA1fljg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhCdn8X4mk/It4h+o0MtW+a9keQiIWZfYmGP2sKt9vY=;
        b=ZwxOZPZOD4HjF25HUV0foVmomd8TPxLXU9AuDxgzQ5Mq6ZdpGpj47Jc/i/2jboJWyH
         04WZBEMHiOuAh3r4D+HeSLfEffejn0bv/PF3cdqt//bEFrC8DVvGOk06fZzMW55tCvde
         RZCVgoTnKcFIFRb7f8kOefHcJWA7JVJd3sab/HYGY9rtVrBD+k4bNM669lWxrq41lw1a
         /3ldxpszSBOikqENXnUsI+30Qa39ySkxow4Jf1SX0Z11fb43fdEDZBYzDEk69pzzt6I0
         fKBvsYX9RUiKOkLnBi4zfVUjUF6ZPtxpSq4O3D2+wuehlggxlzi0V+vNyRWMo7wonB36
         L9Vg==
X-Gm-Message-State: ANoB5pkJawaVSHg8F7sbpUXI+qt52ANIDS7/aB6QZt2QDW1PHd/TmHkk
	PImBFKlFUyHT4hryH7fsVygfBmMw06fbPA==
X-Google-Smtp-Source: AA0mqf5tDRIgQqFEs16R/hYGRxzwntYaKYEYhoAa4DQVeWy2wcEuZgGiWX7ChUv0qPLzi5NZl7spbQ==
X-Received: by 2002:adf:e50e:0:b0:241:cce2:1af with SMTP id j14-20020adfe50e000000b00241cce201afmr38631532wrm.615.1669933057243;
        Thu, 01 Dec 2022 14:17:37 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f4c:de93:c029:9984])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d5649000000b0022cdeba3f83sm5418022wrw.84.2022.12.01.14.17.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:17:36 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] cache/siggen: Simplify passing basehash data into the cache
Date: Thu,  1 Dec 2022 22:17:36 +0000
Message-Id: <20221201221736.1207775-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 22:17:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14130

The basehash data is really internal bitbake data and passing an object
directly is more efficient than creating and then extracting variables.

This will match the format of other data we may optionally wish to
store in the cache so more to the more efficient method. Nothing I
can see is using this data today (and nothing should be).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py  | 4 ++--
 lib/bb/siggen.py | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index cb6cf21727..e1214d6ad2 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -28,7 +28,7 @@ import shutil
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "154"
+__cache_version__ = "155"
 
 def getCacheFile(path, filename, mc, data_hash):
     mcspec = ''
@@ -105,7 +105,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         self.tasks = metadata.getVar('__BBTASKS', False)
 
-        self.basetaskhashes = self.taskvar('BB_BASEHASH', self.tasks, metadata)
+        self.basetaskhashes = metadata.getVar('__siggen_basehashes', False)
         self.hashfilename = self.getvar('BB_HASHFILENAME', metadata)
 
         self.task_deps = metadata.getVar('_task_deps', False) or {'tasks': [], 'parents': {}}
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 72b906c153..34b71d596a 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -247,8 +247,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #for task in self.taskdeps[fn]:
         #    self.dump_sigtask(fn, task, d.getVar("STAMP"), False)
 
+        basehashes = {}
         for task in taskdeps:
-            d.setVar("BB_BASEHASH:task-%s" % task, self.basehash[fn + ":" + task])
+            basehashes[task] = self.basehash[fn + ":" + task]
+
+        d.setVar("__siggen_basehashes", basehashes)
 
     def postparsing_clean_cache(self):
         #
-- 
2.34.1


