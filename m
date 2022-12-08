Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68155C4332F
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 17:36:28 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.21233.1670520983646830880
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Dec 2022 09:36:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=a7xMNQE3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so1577282wmb.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 09:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWmgm3tpJHU733yVkCf83J2VgomCGkX/W0k8OSVFST8=;
        b=a7xMNQE3fqBz8CvLHl1pMmD0Sp+1TwvyoiaQGh8sip2hGNqTGVgOfRjTM3oRZrW9SR
         W6f2wn/7hiY/q1Q4GZpvZ2Kt7E6gTP9/YX5JNAFnwkocTulTCPuwJ1HX0DG+7aKTXtYq
         fk+azWEaTx6UnFc+vFqC36MmAzxUeDI5jLUKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWmgm3tpJHU733yVkCf83J2VgomCGkX/W0k8OSVFST8=;
        b=JZb1C+e9UYMGAKt60GIPBP9dYs91xyIO7PBAr9wRGoOk8zB07BH3JOnLVjh9Pjpe/w
         t2ySn2aCZ5b8xppKI93pf4jrA7+7aILr1oRddSX7bixF5QF33t2KX1xXVBirPS/CGgPq
         HxaiMDxBsMif56FzLzFY0MPIAj4/XVwXJ/7uqbxhLXRTHz1/LejuIc8C9ME6Jz4QwaVg
         nd6zfgMGj7flmcEJGObX+geMPC/a2YJBnfxcNGioZx3Z+7j01pkS2ns806BBpxz+pQgy
         8P7WU0pr1fPt81Ucefwpv1O6QXLUS0ChPHifrzaI12KiJnekh7AOvt55QcxdvFx2+zNK
         zn6g==
X-Gm-Message-State: ANoB5pnLB1rVlo2Dlc3xkPZ1KjM3wT15MaaeWyI0E61exHeQGyi2UNlJ
	vgOnAWQXSotyr1zXLYByl7ersaub/gPjJI1t
X-Google-Smtp-Source: AA0mqf4bOodCoBmSpnGf6IJL7VyPmCH+ghIN1agVSi7+rKLHu89dSKJCotL/LcQQh7nKUgU7wITO2g==
X-Received: by 2002:a05:600c:3799:b0:3d1:f74d:4f60 with SMTP id o25-20020a05600c379900b003d1f74d4f60mr2193642wmr.22.1670520981651;
        Thu, 08 Dec 2022 09:36:21 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:50bb:c4ee:bb3b:bc91])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05600c1f0a00b003d070e45574sm5956409wmb.11.2022.12.08.09.36.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 09:36:20 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] main: Add timestamp to server retry messages
Date: Thu,  8 Dec 2022 17:36:18 +0000
Message-Id: <20221208173619.2382692-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 17:36:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14154

We have timestamps in the server logs but we don't know which
UI messages correlate to them. Add some timestamps to the messages
which doesn't make them pretty but which might make it possible to
debug problems.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index f56c3d46a2..6294b85cfd 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -17,6 +17,7 @@ import warnings
 import fcntl
 import time
 import traceback
+import datetime
 
 import bb
 from bb import event
@@ -384,6 +385,9 @@ def bitbake_main(configParams, configuration):
 
     return 1
 
+def timestamp():
+    return datetime.datetime.now().strftime('%H:%M:%S.%f')
+
 def setup_bitbake(configParams, extrafeatures=None):
     # Ensure logging messages get sent to the UI as events
     handler = bb.event.LogHandler()
@@ -434,7 +438,7 @@ def setup_bitbake(configParams, extrafeatures=None):
                 else:
                     logger.info("Reconnecting to bitbake server...")
                     if not os.path.exists(sockname):
-                        logger.info("Previous bitbake instance shutting down?, waiting to retry...")
+                        logger.info("Previous bitbake instance shutting down?, waiting to retry... (%s)" % timestamp())
                         i = 0
                         lock = None
                         # Wait for 5s or until we can get the lock
@@ -459,9 +463,9 @@ def setup_bitbake(configParams, extrafeatures=None):
                 retries -= 1
                 tryno = 8 - retries
                 if isinstance(e, (bb.server.process.ProcessTimeout, BrokenPipeError, EOFError, SystemExit)):
-                    logger.info("Retrying server connection (#%d)..." % tryno)
+                    logger.info("Retrying server connection (#%d)... (%s)" % (tryno, timestamp()))
                 else:
-                    logger.info("Retrying server connection (#%d)... (%s)" % (tryno, traceback.format_exc()))
+                    logger.info("Retrying server connection (#%d)... (%s, %s)" % (tryno, traceback.format_exc(), timestamp()))
 
             if not retries:
                 bb.fatal("Unable to connect to bitbake server, or start one (server startup failures would be in bitbake-cookerdaemon.log).")
-- 
2.34.1


