Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA124D6EC06
	for <webhook@archiver.kernel.org>; Fri, 29 Nov 2024 12:55:34 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.115390.1732884928990457510
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Nov 2024 04:55:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PpfvFAkf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a766b475so16823195e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 04:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732884926; x=1733489726; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNt5WstnBKXO9H02muANGzQRk5K7DRCfatU/SJsa9/w=;
        b=PpfvFAkfXaBJ+4PyUse2h2HYlMLJVjV1Ju+D5iGINxtr2k305mXb8fAnFwfIdByzd4
         TNQgjV4jLpfVcl73szDv1b/1jVTVx8TlXj0by0u5R0F9IxO1E3N2qYWNZtwnHRhwiR7W
         gQf37AjeEYT750a+wuw9gv7zmLr9TyKHCjLwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732884926; x=1733489726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNt5WstnBKXO9H02muANGzQRk5K7DRCfatU/SJsa9/w=;
        b=bZjXcu/UweJAdr/E3R14Dbht9QvuxYAHpXqHZ7Bw1OPF1lTlw8KvXp8vHDXcQ5IEET
         F0X6jbcWId5VKlIr1wM1uuqV41zCDTDxxLWHIHZGC12i5tcsiHNNJRuDl5YAHquwoZ4Q
         JLzO2pgYAYGfHSXclGfLQnb+uDaMN7mHmXiKVuvWOXNvxYgzOGBjqpHQ54tcftaeEm4u
         lJBNHy9mD26hSt5M3R0A2lBXSYadKSIu/6CdE+2P5/tgazkZRoY9ArG51oQEM3ArHuxE
         YcMpAwRvW/RWBm3+1dYtF3gnItFbADUok+8aS5F9zsjPdW0bA7uz6NjspJWmyWyvkVQ8
         4xMw==
X-Gm-Message-State: AOJu0Yyoap/BhvWUr2k6/rJsODq9geUjscl6Kvu2fGJTn7dz+EnkQHOy
	yCmNBjx5Ub5KNiARSANBjouXYpAOY93exFci8MMz9IGq+VU4RYNj0OkvTe4DI+914XFx/Kf0fST
	5
X-Gm-Gg: ASbGncvp0q0XGv9TBy8Q3rjVxH04CCEHsa5Lrh/T538IgMvsvgGIX5YWPIlYA00caxv
	IViIyUo9AHPuimnHdp99lL02j8KvPm6lT8Gs82540msOXLTCNb9+8JSA9pyq6GcHoJQbExLPiJC
	CLCH2v4bVVPpWdkgDQHGEa2DrLOJLIJMkCncGXmbrFQkUtS6kYQaMDbZsYDbh/S0jctbZVkQIlI
	+XpUCZqWQPTTxbckSF19/s7gq2tmNWCdEhnlSSsct/+6si95mocpP+1ZnEGvsNBmJzOweo8kQcE
	Uhk=
X-Google-Smtp-Source: AGHT+IHrInWXoTw5ovvSwSJ/16zqm+bIlZrOeKL4raHtViwMu7+tOwg5l7+4KMN6L+UjZInbqJ6Pxw==
X-Received: by 2002:a05:6000:4710:b0:385:e013:73f0 with SMTP id ffacd0b85a97d-385e0137516mr1833391f8f.59.1732884926329;
        Fri, 29 Nov 2024 04:55:26 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3ee5:ac4c:88d3:867b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d33a13adsm3522152f8f.73.2024.11.29.04.55.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 04:55:25 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Fix performance of multiconfigs with large overlap
Date: Fri, 29 Nov 2024 12:55:24 +0000
Message-ID: <20241129125524.131362-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 12:55:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16848

There have been complaints about the performance of large multiconfig builds
for a while. The key missing data point was that the builds needed to have large
overlaps in sstate objects. This can be simulated by building the same things with
just different TMPDIRs. In runqueue/bitbake terms this equates to large numbers of
deferred tasks.

The issue is that the expensive checks in the setscene loop were hit every time
through runqueue's execute function before the check on deferred tasks. This leads
to task execution starvation as that only happens once per iteration.

Move the skip check earlier in the function which speeds things up enormously
and should improve performance of such builds for users.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 61608ac603..2179ee1302 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2210,6 +2210,9 @@ class RunQueueExecute:
             # Find the next setscene to run
             for nexttask in self.sorted_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values() and nexttask not in self.sq_harddep_deferred:
+                    if nexttask in self.sq_deferred and self.sq_deferred[nexttask] not in self.runq_complete:
+                        # Skip deferred tasks quickly before the 'expensive' tests below - this is key to performant multiconfig builds
+                        continue
                     if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and \
                             nexttask not in self.sq_needed_harddeps and \
                             self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and \
@@ -2239,8 +2242,7 @@ class RunQueueExecute:
                         if t in self.runq_running and t not in self.runq_complete:
                             continue
                     if nexttask in self.sq_deferred:
-                        if self.sq_deferred[nexttask] not in self.runq_complete:
-                            continue
+                        # Deferred tasks that were still deferred were skipped above so we now need to process
                         logger.debug("Task %s no longer deferred" % nexttask)
                         del self.sq_deferred[nexttask]
                         valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, 0, False, summary=False)

