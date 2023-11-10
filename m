Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61591C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 15:50:16 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
 by mx.groups.io with SMTP id smtpd.web11.30918.1699631415409283568
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 07:50:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ff+JNEEb;
 spf=pass (domain: gmail.com, ip: 209.85.161.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5842ea6f4d5so1212390eaf.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 07:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699631414; x=1700236214; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOLoc1AGiCCFHABmiW4KQZ3r9KPt5bejQygjaVYA3+M=;
        b=ff+JNEEbHWYo7gptmIGu4bNWumHK6LA+zM6gGTLLkCBZ9pmgR076cbsPgckl+z/gPN
         AhMuOlnl5HeSuy0zrOLHHL9fzN5Wwl+dlpsrGCZgiLrFQQkSerOTj6S5uS3nKhqvXnv9
         LpDcExjpDrgAiMQ+Vx20XwS/E8Fi7WJ+dvkKFOSbW8tfDxk++CbiJyg+dT4uIhMbiMSE
         8dwpaeP8LMEgP1CGKo4ojaUeH1ddSFaW1aj5L8oqvOkCCHtCqt1BCCMgYZ8fc1XVhx7i
         0Cn4atyveWwMamNeBNYoZS5DPG2PUrgnqOdw2bmsdXyOtzD/7+tjWYHJQb9TCAVPEv29
         hBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699631414; x=1700236214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOLoc1AGiCCFHABmiW4KQZ3r9KPt5bejQygjaVYA3+M=;
        b=Cu7bck8lVv+hOY2AwOdsBP5Gf3F0ria1UBpeF9NTrl676DCDzNl3sqWQ7YDuiJ2brz
         owTtpzKMGNisP9LkGhEpybz4IqWsPm7ebFtYfBCVmqRavJXxFhc5r4KdXTAR1U+2etss
         TrIaEyFF7UJGdm6m6AZVKaB+bS0AtNWypxUXAXz8Kjk7cxPAM0gYVtcLt+sEdw2QLFB7
         3PHm12EFNqr8dorrso+EKnuBoc2YBy4B5CBwuatLD+e7+EwJA8M4usKxrI3eLVcATmo3
         VYVRgtImJLWGV8xjM/kqcjx+poK0oJH7tnSIdNO/YqF2A8PJRXaLR1uqemxQ/wK1rAq/
         xuZw==
X-Gm-Message-State: AOJu0Yy5SM6jx1wwrk3aEdf1VmssyjrHSk8imMydA5V+TapShYFNx3Uf
	o3nGvgZaNJq67CtMIZkK4Sxy0dePgaQ=
X-Google-Smtp-Source: AGHT+IHBK7+cN+8M3LlNg9kPTkoXFqGMyDkGkEAN26UtyH/wiSYakFWv3n/3WYRN45nRfsOiEm+a7w==
X-Received: by 2002:a4a:e257:0:b0:587:992d:48b with SMTP id c23-20020a4ae257000000b00587992d048bmr7620219oot.1.1699631414142;
        Fri, 10 Nov 2023 07:50:14 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id 64-20020a4a0943000000b0057b43a25deasm3470859ooa.3.2023.11.10.07.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 07:50:13 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] asyncrpc: Add option to set log level when running as a process
Date: Fri, 10 Nov 2023 08:50:09 -0700
Message-Id: <20231110155009.941766-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 15:50:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15505

When running an asyncrpc server as a subprocess, it is often desired to
run it with a lower logging level since the normal logging of clients
connecting and disconnecting is not desired.

As such, add an option to set the logging level of the server when
running as a subprocess and set the level to WARNING when starting a
local hashserver or PRserver

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/serv.py | 5 ++++-
 lib/bb/cooker.py        | 2 +-
 lib/prserv/serv.py      | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 5fed1730..f0be9a6c 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -322,7 +322,7 @@ class AsyncServer(object):
         self.loop = asyncio.new_event_loop()
         asyncio.set_event_loop(self.loop)
 
-    def serve_as_process(self, *, prefunc=None, args=()):
+    def serve_as_process(self, *, prefunc=None, args=(), log_level=None):
         """
         Serve requests in a child process
         """
@@ -351,6 +351,9 @@ class AsyncServer(object):
             if prefunc is not None:
                 prefunc(self, *args)
 
+            if log_level is not None:
+                self.logger.setLevel(log_level)
+
             self._serve_forever(tasks)
 
             if sys.version_info >= (3, 6):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9a3e32ac..4bf1809b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -345,7 +345,7 @@ class BBCooker:
                     sync=False,
                     upstream=upstream,
                 )
-                self.hashserv.serve_as_process()
+                self.hashserv.serve_as_process(log_level=logging.WARNING)
             for mc in self.databuilder.mcdata:
                 self.databuilder.mcorigdata[mc].setVar("BB_HASHSERVE", self.hashservaddr)
                 self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.hashservaddr)
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 6168eb18..62d3b5a0 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -130,7 +130,7 @@ class PRServSingleton(object):
     def start(self):
         self.prserv = PRServer(self.dbfile)
         self.prserv.start_tcp_server(socket.gethostbyname(self.host), self.port)
-        self.process = self.prserv.serve_as_process()
+        self.process = self.prserv.serve_as_process(log_level=logging.WARNING)
 
         if not self.prserv.address:
             raise PRServiceConfigError
-- 
2.34.1


