Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1BDC3F6B0
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 10:32:59 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web09.5473.1659695557785809113
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 03:32:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MS5QIw0z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id j1so2798216wrw.1
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=F2hCJeQbfoqBe21zqmSE+YDSfi4TlR5zW5ja4oN+C+A=;
        b=MS5QIw0zraE+kP10xQiwXrfMpAS9TRewaevt/tPkRLXSF0RP9KE26qZwVf0c0WHpeU
         vnTwBfSnzPmqBmzcwmoSWDeKXT9L68MQ1fifXb/eDKxAZlRoiLiRqLfio46u4W4qnzjL
         1pOLKDAWZCYyT+Nuhrw3vT1c3LB+DzVxvPCfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=F2hCJeQbfoqBe21zqmSE+YDSfi4TlR5zW5ja4oN+C+A=;
        b=74/O4N2V1cpvfLywgYmjJGmTeOXOSBPNekkWXNTK1c4+Rosz863nUovZr0cAu7o875
         OGBRFEthy8Cz0n4XMDgLV4It0zs2ae+3SVwZw4OV9BdD+MZg4nfvDun+D8oO/tTAqKO+
         kWHlmUywjaY1Yw0IKVuEjU/cjI2V0ASYROpbs7x72D0UCoFX1J5ulQYVr32oHEpxNtcH
         57KFfNIwQKIhRSTpCD7/lw1bn/sInKAlWn3RI0nF6R2JFIsoPhuwzp/QZMOivs/8csHe
         D9oaShr4zL1sOzb8CaGAidhTQmc/bsKbeuYYTo6B+hPNLPMDUsnsRwVoqKfA8Mqg/Bb8
         lqXQ==
X-Gm-Message-State: ACgBeo2VHrYC5Cf7ifhQTY/A1zw4W5D1u/RY1iSfw+R0230jtLxYXfYb
	bXMS+l6nCxFAUums9MDyJuOlXvqLIuF5wA==
X-Google-Smtp-Source: 
 AA6agR5lQ4ITbGKayCr6UK0IzUD58GnxmxJOlSodlL0m1yI1faEKerLmYG0+ptPbLWaxiPBgKEWWew==
X-Received: by 2002:a5d:584c:0:b0:220:590f:27bd with SMTP id
 i12-20020a5d584c000000b00220590f27bdmr3912590wrf.342.1659695555962;
        Fri, 05 Aug 2022 03:32:35 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f483:fcb0:1452:5a5a])
        by smtp.gmail.com with ESMTPSA id
 e12-20020a5d65cc000000b002207a8773b7sm4501401wrw.27.2022.08.05.03.32.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 03:32:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] runqueue: Improve deadlock warning messages
Date: Fri,  5 Aug 2022 11:32:31 +0100
Message-Id: <20220805103232.3674163-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220805103232.3674163-1-richard.purdie@linuxfoundation.org>
References: <20220805103232.3674163-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Aug 2022 10:32:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13874

Tweak the deadlock breaking messages to be explict about which task is
blocked on which other task. The messages currently imply it is "freeing"
the blocking task which is confusing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 4d4ac3b991..e06246f741 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2237,10 +2237,12 @@ class RunQueueExecute:
 
         # No more tasks can be run. If we have deferred setscene tasks we should run them.
         if self.sq_deferred:
-            tid = self.sq_deferred.pop(list(self.sq_deferred.keys())[0])
-            logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s" % tid)
-            if tid not in self.runq_complete:
-                self.sq_task_failoutright(tid)
+            deferred_tid = list(self.sq_deferred.keys())[0]
+            blocking_tid = self.sq_deferred.pop(deferred_tid)
+            logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s blocked by %s" % (deferred_tid, blocking_tid))
+            if blocking_tid not in self.runq_complete:
+                logger.warning("Failing blocking task %s" % (blocking_tid))
+                self.sq_task_failoutright(blocking_tid)
             return True
 
         if self.failed_tids:
-- 
2.34.1


