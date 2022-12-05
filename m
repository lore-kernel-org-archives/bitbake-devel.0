Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF2C4321E
	for <webhook@archiver.kernel.org>; Mon,  5 Dec 2022 15:18:25 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.17863.1670253501041140452
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Dec 2022 07:18:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KwY6HA3G;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so10301407wms.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Dec 2022 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGzPNJDiYLZR+x5Rq787G3kNSutlrlsLCt3EEQoqtPQ=;
        b=KwY6HA3GcJHBrYs08ghtDy0VQae3frKeAsw4ji3z+cT5qcW1nDaRBjCRzXwqxq9Slz
         jiENOs3q6aLBKjM4vXzIJl0POJicNTc/AMBGjfsI7ovbp8XrA66D4R7pMPtw43C8xUQa
         PApPZIv3NqUKMbE0AY7EL+Pe5oCmUZfpG2smQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGzPNJDiYLZR+x5Rq787G3kNSutlrlsLCt3EEQoqtPQ=;
        b=ZGsVJfvc7l4RuXRvlw6AKH+8o9YFYhyCNb7VWyq4mPtaNmv0gC5oWtc65iXlKzWSpK
         pt06QxTlenF/ww8y5eiOnUF5SqGPNfLGI2Q1L3w2wcy+/UHdvq9iXwyG8sKcxP5PPqYk
         NTFnhIsRFeytRzwo7DPXyklKaFu8yiQUoZkuZ8ZEMo3e6tH6/xL2gAv3mplUSOxIKSN1
         nuMUxk5xeV+IlptnKS+9Hj5UUwADrqS1ecAkHjoGQrekIC5d/FiSnX5Lrae3p50eEPZW
         wJBd1GGQWBVKXRLhZVEmqOyPZsAhBN1wT+BXayP97s7FratI1VBn5YjjDgfqaF0ES14Z
         OmbA==
X-Gm-Message-State: ANoB5pk1eUqwb2WNvUso5I9aGGXsFvPYEGlBECHS+nmtBLnBXvRY2vEm
	0kFpbN4TqSCr0/YItD+zjJBMQvRmBpKwl9db
X-Google-Smtp-Source: AA0mqf4TGEIcMR4SzXp7R46W1xa4yqU5ymRZwi4vPOmdQXuikspng6iyo0zN44D8yuD27jH+l9QOHA==
X-Received: by 2002:a05:600c:3d08:b0:3cf:e84d:6010 with SMTP id bh8-20020a05600c3d0800b003cfe84d6010mr51575666wmb.197.1670253498985;
        Mon, 05 Dec 2022 07:18:18 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d7b7:8e1d:6b4f:ea31])
        by smtp.gmail.com with ESMTPSA id dn13-20020a05600c654d00b003c6bd12ac27sm17877751wmb.37.2022.12.05.07.18.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 07:18:18 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] cache/siggen: Simplify passing basehash data into the cache
Date: Mon,  5 Dec 2022 15:18:17 +0000
Message-Id: <20221205151817.1769536-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Dec 2022 15:18:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14134

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

v2: Add default for the cache entry so selftest works

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index cb6cf21727..e117fe56cb 100644
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
+        self.basetaskhashes = metadata.getVar('__siggen_basehashes', False) or {}
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


