Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C27EC4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 15:30:56 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.30148.1699630254420531991
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 07:30:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MZhorhSC;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6c398717726so2028689b3a.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 07:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699630253; x=1700235053; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpNvhC24gFg8pXGSLeBE0miX8I/P9d1eNObp6oNsEX0=;
        b=MZhorhSCVy8BHBE7KfwwFVeiB5H0J+S23GBk0aDNAYh/j5Uen5OB1HXTH7/HwREiYA
         4nWhn1Dr0zyXXv54OcSS2wp7ez4Mk9O6XLOT08MwEehzPNhMn2K5oGKso9FJW7D/tmqn
         jwaJGdDvDNrQSZ/pGYtiUBWku7gCBxsZu/AWztSSQtDNO7zwHyP9o0AGrBG/oFhQL4/j
         Bc/H2svnKHJFydxgUL615mXtvgIWxsjS62n7oWl8PIq6843PiTpUzEiuSqhghCOruO6G
         zOzr832eNsq379dUpW2WzKLj+ZQsQ3BaHQD1c9CA/4bwDfzO9luBkT2vMfNV1BpZ05wk
         SE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699630253; x=1700235053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpNvhC24gFg8pXGSLeBE0miX8I/P9d1eNObp6oNsEX0=;
        b=Y7EfKUXMQubuYDIx+iql6S1F3GrSwN0oh6SHVLWWmi4/B2U+7n28g2FrruWjfbvw3d
         yLfB7pRLJVA14Ivr6QQN5koWqvXRRtk2MN7oPC5kEgZXUUWa+vVCPORBqnxkOU9tPzN0
         XD4eTIL1+06mWAZkNU0WmSfgWq2JVxQsQe8P+IrnzPQLXvx4zkeizYZsWy7x2bB1Cp2m
         HeBglIUeCoH2IGQXypxAqtkxC1C/Z+EC1+ZFQcwSuAS7pVjl5OaVNOTAD/XxwexmU8BS
         Olg4YKSfnvD3ZFeBeQtT3ciJ2n7Z+lGWTimc6yLLYkjdKTnL3Y5ak39BUp30QBaKQ4QM
         D0Pw==
X-Gm-Message-State: AOJu0YzMpxDBRjRgF2bFu0dWYfiY1eKaL7DPvZOIqJtCUHWjiwcHNUEr
	FYPDiyB7ZrT4kqcbWJoh8n9o0hv5SCUxrw==
X-Google-Smtp-Source: AGHT+IGZBR6Ps76+quR1Mq/Cf5xkdoHyqr5NdYiYGBrEXuAxy5y5x5/4UoGhXCSsbxDJQpWsACiJjA==
X-Received: by 2002:a05:6a00:1a91:b0:693:3c11:4293 with SMTP id e17-20020a056a001a9100b006933c114293mr7972664pfv.14.1699630253399;
        Fri, 10 Nov 2023 07:30:53 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:cf02:179f:ed0:bddf])
        by smtp.gmail.com with ESMTPSA id l21-20020a635b55000000b0058c1383fa8bsm6693706pgm.0.2023.11.10.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 07:30:53 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] toaster: log ProcessLookupError in test_runbuilds
Date: Fri, 10 Nov 2023 07:30:10 -0800
Message-Id: <20231110153009.3592572-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 15:30:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15503

This repeatably fails:

Exception in thread Thread-2:
Traceback (most recent call last):
  File "/usr/lib/python3.10/threading.py", line 1016, in _bootstrap_inner
    self.run()
  File ".../poky/bitbake/lib/toaster/tests/commands/test_runbuilds.py", line 39, in run
    os.kill(int(pid), signal.SIGTERM)
ProcessLookupError: [Errno 3] No such process

Rather than have a hard error, add logging and output as a warning.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/tests/commands/test_runbuilds.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/tests/commands/test_runbuilds.py
index c77d6cf4..14b35764 100644
--- a/lib/toaster/tests/commands/test_runbuilds.py
+++ b/lib/toaster/tests/commands/test_runbuilds.py
@@ -19,6 +19,10 @@ import time
 import subprocess
 import signal
 
+import logging
+
+logger = logging.getLogger("toaster")
+
 
 class KillRunbuilds(threading.Thread):
     """ Kill the runbuilds process after an amount of time """
@@ -36,8 +40,11 @@ class KillRunbuilds(threading.Thread):
 
         with open(pidfile_path) as pidfile:
             pid = pidfile.read()
-            os.kill(int(pid), signal.SIGTERM)
-
+            try:
+                os.kill(int(pid), signal.SIGTERM)
+            except ProcessLookupError as err:
+                logger.warning("Failed to kill pid. %s" % err)
+                pass
 
 class TestCommands(TestCase):
     """ Sanity test that runbuilds executes OK """
-- 
2.34.1


