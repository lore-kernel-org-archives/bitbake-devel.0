Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24759C4332F
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 00:04:58 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.195303.1672272290120146969
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Dec 2022 16:04:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UUsyVx0X;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id co23so16129763wrb.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Dec 2022 16:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hz8KHo1RCeIKMe3kl0VhRaRuBipUBJiN9maJ682XUA=;
        b=UUsyVx0X5FtJgzrSqolASDUWXvEMA5YXOOH26bw/BO3H+hb73FBLnLgbDwBd9ForYE
         cYpamdmKyvxYclHwIWMsFgA/hS0eyYtmPLlFWsWKxUquAkDWpOaOdkNNQJ0KJWTrvYKD
         DjTn+EgGBh+ts04k5e+/kW1whaUtg8l9y4yJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hz8KHo1RCeIKMe3kl0VhRaRuBipUBJiN9maJ682XUA=;
        b=0q57khQHhoQ5K6v7ojVGWQWDw5CrOvbqo4pJIrZPWcC+u0gJhVPncyBrl83p2vVuss
         hiM9L65PzO/gWugjXp1Bl34klILf/9xP4DPUymse/k3mXFn5EF0KrzERmokWYNy+EzeA
         eCc9Y4rweFst/7U828zdVjWWjWiEy/fRPDwwyQRZ4+JTU9iRGXRHI4C1Vne72xP+hYro
         iQfi7mo07S3GgCe8LpWk0SGljG6ujvTC97E7xuWTzyYc7VKYCtQeBW5/48FDKxfVoY6r
         X7mcP4tQfLkmPRRXQlRKTWiP/TXZBkunEK0fGWUYNWqeqUChgmY05xpA0Cm1c2KqfXWH
         7+nw==
X-Gm-Message-State: AFqh2krm+D+e/siJda69vOQfAxZEShGzpWdpeYMY1anhcWpO2fvWZV83
	X2hvC9JKz1GC0kkcHz6VMa4zNxfDlzyMtJLg
X-Google-Smtp-Source: AMrXdXvGCQfEvobLZNP9fkrZT+Szw3DxphKcLtKnlDD/zcN+1cOl0Z3tx0iefzy1df957c8PCHD7pQ==
X-Received: by 2002:a05:6000:16c4:b0:242:5083:abea with SMTP id h4-20020a05600016c400b002425083abeamr23274085wrf.69.1672272288011;
        Wed, 28 Dec 2022 16:04:48 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id v7-20020adfe287000000b00241bd177f89sm16514239wri.14.2022.12.28.16.04.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 16:04:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cache/siggen: Fix cache issues with signature handling
Date: Thu, 29 Dec 2022 00:04:46 +0000
Message-Id: <20221229000446.846258-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 00:04:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14241

There is a bug in the current cache code where the restored data structures
were "inverted" leading to some very weird issues, not sure how anything worked
like that, this patch fixes it.

Also fix some issues with multiconfig cache ordering problems by resetting
the stream counters when appropriate.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py  | 3 ++-
 lib/bb/cooker.py | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index f5b527ba6a..3fc097241a 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -311,7 +311,7 @@ class SiggenRecipeInfo(RecipeInfoCommon):
             cls.restore_map[pid] = {}
             cls.restore_count[pid] = 1
         map = cls.restore_map[pid]
-        for fs, dep, mapnum in deps:
+        for dep, fs, mapnum in deps:
             if mapnum:
                 ret[dep] = map[mapnum]
             else:
@@ -759,6 +759,7 @@ class MulticonfigCache(Mapping):
         loaded = 0
 
         for c in self.__caches.values():
+            SiggenRecipeInfo.reset()
             loaded += c.prepare_cache(progress)
             previous_progress = current_progress
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 88c97c5e4a..14440f1647 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2240,6 +2240,7 @@ class CookerParser(object):
 
         def sync_caches():
             for c in self.bb_caches.values():
+                bb.cache.SiggenRecipeInfo.reset()
                 c.sync()
 
         self.syncthread = threading.Thread(target=sync_caches, name="SyncThread")
-- 
2.37.2


