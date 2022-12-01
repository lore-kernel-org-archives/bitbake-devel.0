Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A647C4332F
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 22:09:47 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.59145.1669932576896201030
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Dec 2022 14:09:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Tafvhx3W;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso3897481wmb.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 14:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSGthCojQRNG3QUuSnObU/Ha2VLA9NbW5NAOWKw6lRM=;
        b=Tafvhx3WRyPTf3ospfYSPBG3fT17ffVeMycjLoJqCWpJ7jQOMo+fYjcgfZPQYbhOD7
         CnZAU+IDSka61JdqHr37O3GJsFp8CNXFSuf4SsuJOdeUM2efKjFeURzpo5lgYJazp8PQ
         5v/DjzZPZVodE+T1veQCasQiq4jUj8e9KcWf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSGthCojQRNG3QUuSnObU/Ha2VLA9NbW5NAOWKw6lRM=;
        b=xNqHcFmpOVnj201WcGQiDoWJ9+kT1ctNXenIiverZofNpYz+hBMPmPDNRM8ZEUUnqJ
         OKkPMH1wWJDUOEdd1BTAN3p4m+wN555dV3E8TZsJMjdT+HnX3s1B5nlIkoH4XRm//05p
         Y55PeAFRtK1nDHfrLYoWUtQp3w6MmJwJhxWnuERgTI9vSsG3YG2kFpXAI/aKS4xVz8vj
         zemcS0E/qR7AXmHtIgwMPAf48GVd8mNwfPASLwX8fxtKrIH3AY06iM72kQuCZCyr9z5N
         jDJcSXl1SkoNrkpYolTT8OcnxY9x8B3lONtds+C3vPcIW1Z0tObyLJBhy3Y0wiMU//uh
         xAJg==
X-Gm-Message-State: ANoB5pnglCLuAxRDOuU4bK6Xcymewsk9SfEHcWKmosex9Fk9u1VsEFs+
	FqZGNe0jt1BkML9rxFIZiaP5s8VFpZXWOA==
X-Google-Smtp-Source: AA0mqf7lGYHXJXkLVxyDVDQDcR4svb1ljvQyHSeht6cfXgwq+qli4Oq+ahIqesykwAby9s4p17ftmQ==
X-Received: by 2002:a05:600c:3c87:b0:3d0:58bb:9fa3 with SMTP id bg7-20020a05600c3c8700b003d058bb9fa3mr16807044wmb.39.1669932574617;
        Thu, 01 Dec 2022 14:09:34 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f4c:de93:c029:9984])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b00242442c8ebdsm420531wrw.111.2022.12.01.14.09.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:09:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cache/siggen: Simplify passing basehash data into the cache
Date: Thu,  1 Dec 2022 22:09:30 +0000
Message-Id: <20221201220930.1207183-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 22:09:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14129

The basehash data is really internal bitbake data and passing an object
directly is more efficient than creating and then extracting variables.

This will match the format of other data we may optionally wish to
store in the cache so more to the more efficient method. Nothing I
can see is using this data today (and nothing should be).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py  | 4 ++--
 lib/bb/siggen.py | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index 72b906c153..ee67e80a79 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -247,8 +247,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #for task in self.taskdeps[fn]:
         #    self.dump_sigtask(fn, task, d.getVar("STAMP"), False)
 
+        basehashes = {}
         for task in taskdeps:
-            d.setVar("BB_BASEHASH:task-%s" % task, self.basehash[fn + ":" + task])
+            basehashes[task] = self.basehash[fn + ":" + task]
 
     def postparsing_clean_cache(self):
         #
-- 
2.34.1


