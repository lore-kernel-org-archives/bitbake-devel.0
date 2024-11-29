Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8DDD6EC1C
	for <webhook@archiver.kernel.org>; Fri, 29 Nov 2024 22:10:17 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.123949.1732918207889421383
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Nov 2024 14:10:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JzSxgkSH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de9f789cso830267f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732918205; x=1733523005; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+M7qhcVEMGbmkTaEfkGOlF0rjLHfKb+JOq3lsHyVAs=;
        b=JzSxgkSHXnKzFeone8MznLWQ18oPCfxI2/TH7zhYgUx8QzdNSDPWWM76+fmw0lxUaU
         ojurm1i3RC+txSJJyVaByxvLFOz6qzxXzoK1es7SebTo8sN/xGO6u1nCQXyFTpTZIYCg
         3FZxWBC43IqEkk0YgR8RwkDyvfNUFMcyKMdqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732918205; x=1733523005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+M7qhcVEMGbmkTaEfkGOlF0rjLHfKb+JOq3lsHyVAs=;
        b=lwS8UUdxNnM14YyGqJjaK6yqzGTSSw5O5np/mQUyijEdvAg7N3/sOP5AQxcyTaIKFU
         QP9mpuyWwtMxu9osfoGUInX2060BYkpISqU6AJCIGHvv4WIH/8jsp2q58l5gA/iHRPfN
         ibU62wRnzEYdy9KgNx7/07/6ADPJqH5lgUe1eizV7fbnJuTpr/1hYKs5KdayYuxXxG9v
         Ap8gljq/Bu391WRxSjHP202aXLNSR8dSo0mSYPlRA0DIqNLnjq7PCLVjA7bNnUCB9kmR
         TP/P9sJgmEy+t6b4KVhxAlfqWmJ3rBcrZ4h928Aulm9Zq8iYIQhYZ70LYw7ptPvBQD4n
         NY1w==
X-Gm-Message-State: AOJu0YzN6pwfF61k1Z8BoOo1io0row5iyFwFryV+eUuBA3aN0h+xC9qc
	2iy5vNTgVpkx+h4xXIYgwyrhN7En5wUuujP7aB0zEmRT0SWzUqYryZtxRi2gWRW5znZyWJpp0ad
	h
X-Gm-Gg: ASbGncvjNk10fzX2nz6irog6FVRY9daMrrVYIFgHpEHq/Jn7nzpSVC2yxYazLjqCljm
	spG3+kcQAzO7vlcNYyzJQULSCcfz6rsrGhhSoMDNLdOOMyGzMzWoDPIDVJh13rXAoOeYIh7td5U
	ugeuS8AYHPK4rwVqEHQmR3f8WlomVWowe+4B0ncxKkXxEqsA5spScHj5InWKExpGFATmpUwyPO8
	CDR/xu6LsTNhNq0r01O0bweRwelcYvpKpT4t6YlW8GIEnWTZ74UO2vA6EKDKKbZXqG8KSNrQ+H2
	4l4=
X-Google-Smtp-Source: AGHT+IFAhYa7lv4cNeJd65+S54bPSOzOtwXmX38bG0el3UcKlMmhr2rzA0w5Ybbi1HjDwYi2anfWaw==
X-Received: by 2002:a5d:64c6:0:b0:382:5aae:87cf with SMTP id ffacd0b85a97d-385c6ebe438mr10141916f8f.31.1732918205109;
        Fri, 29 Nov 2024 14:10:05 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1083:22d7:abf5:ae6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e16d722fsm1228038f8f.41.2024.11.29.14.10.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 14:10:03 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: Optimise setscene loop processing
Date: Fri, 29 Nov 2024 22:10:01 +0000
Message-ID: <20241129221002.770402-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 22:10:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16852

Rather than looping through things we looped through on the previous execution,
start looping where we left off for setscene processing. This gives speed
improvements depending on the kind of build being executed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2179ee1302..6457726d96 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -14,6 +14,7 @@ import os
 import sys
 import stat
 import errno
+import itertools
 import logging
 import re
 import bb
@@ -2204,11 +2205,16 @@ class RunQueueExecute:
         if not hasattr(self, "sorted_setscene_tids"):
             # Don't want to sort this set every execution
             self.sorted_setscene_tids = sorted(self.rqdata.runq_setscene_tids)
+            # Resume looping where we left off when we returned to feed the mainloop
+            self.setscene_tids_generator = itertools.cycle(self.rqdata.runq_setscene_tids)
 
         task = None
         if not self.sqdone and self.can_start_task():
-            # Find the next setscene to run
-            for nexttask in self.sorted_setscene_tids:
+            loopcount = 0
+            # Find the next setscene to run, exit the loop when we've processed all tids or found something to execute
+            while loopcount < len(self.rqdata.runq_setscene_tids):
+                loopcount += 1
+                nexttask = next(self.setscene_tids_generator)
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values() and nexttask not in self.sq_harddep_deferred:
                     if nexttask in self.sq_deferred and self.sq_deferred[nexttask] not in self.runq_complete:
                         # Skip deferred tasks quickly before the 'expensive' tests below - this is key to performant multiconfig builds

