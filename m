Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F51AC678D5
	for <webhook@archiver.kernel.org>; Wed, 11 Jan 2023 17:51:12 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.31120.1673459463438189621
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Jan 2023 09:51:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Sa8wux1C;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id l26so11646933wme.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 09:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWVsYbTHLS5Ge4M6kMfqhc/blCDJRRduENq5dr4B9eM=;
        b=Sa8wux1C4i7Q+SZHSIPZIvj2e3/hBMdWKkwZFbNRuUx0z0TDdy+i/kuGVzJbzm1RfY
         gTBfZIUJdovP1mHrx7Xn3mydcgObpbYwIy9ASmN1jP3VkIP55igjZjmNXgCd1+XOsmDs
         4dJ9AnvCjovHO4YBezfmkdRw3ZjmGH04kf+2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWVsYbTHLS5Ge4M6kMfqhc/blCDJRRduENq5dr4B9eM=;
        b=jWdPHyabUUsFm61Sg5t7TxTvLLJsvdkCzV4Qqesbod/7rhlvTVRVWt7DS8HwinoQ6m
         1ANdz8PHkzaRkv+IBVwL/L1u1AzNVoHrSFhBJd503hnXoWIEMskIY+JHQ9xw82WFMOLe
         AxIiPgC7fQdX+srKb66xY5j6npToKnDW95at3+GcGNXKBt88wRqGf3mhiCrfocVhcPPK
         hU1FwPlRwxttoybLaTRoCoHZXZJSlYkOU4QAMJtkb9L0eopTroqV0UGL+Wey40WkdjKK
         mPfOmZb8G6Ul7sGzhqgHLjGpTK5PeA6zXIXLUL1xtH/C0otW4u16o/Jbog9yl76Q4/Io
         VbKg==
X-Gm-Message-State: AFqh2krFXT8uoF2joDwsF0ITPpBRY4mcJt7g4UUjxpm7DqJfFhL3Ek5Z
	tjSsI+OkhGC35Ly385+pl8TzXom8joVwgqtJ
X-Google-Smtp-Source: AMrXdXvQTQz9s/RwjJ7TILTE+7b+p5qQfwMZgxaBLjYkO6JSjPYwy9/O7fuv5bESQekcHxxy9EHqJQ==
X-Received: by 2002:a05:600c:a4f:b0:3d2:196c:270c with SMTP id c15-20020a05600c0a4f00b003d2196c270cmr55829966wmq.31.1673459461801;
        Wed, 11 Jan 2023 09:51:01 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a11f:4d56:748b:c178])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003d9f14e9085sm11689624wms.17.2023.01.11.09.51.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:51:01 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] cooker: Fix exit handling issues
Date: Wed, 11 Jan 2023 17:50:58 +0000
Message-Id: <20230111175058.1526619-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230111175058.1526619-1-richard.purdie@linuxfoundation.org>
References: <20230111175058.1526619-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 17:51:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14304

The shutdown() call should definitely not be waiting for idle, since we
expect execution and events to continue even after setting either shutdown
state. This was causing the UI to appear to hang at Ctrl+C interrupts.

Also ensure that if we reset cooker, we stop any active parser processes
since these currently appear to be being left behind.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5cb5c2a2b6..617d582acc 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1743,7 +1743,7 @@ class BBCooker:
         return
 
     def post_serve(self):
-        self.shutdown(force=True, idle=False)
+        self.shutdown(force=True)
         prserv.serv.auto_shutdown()
         if hasattr(bb.parse, "siggen"):
             bb.parse.siggen.exit()
@@ -1753,17 +1753,14 @@ class BBCooker:
         if hasattr(self, "data"):
             bb.event.fire(CookerExit(), self.data)
 
-    def shutdown(self, force=False, idle=True):
+    def shutdown(self, force=False):
         if force:
             self.state = state.forceshutdown
         else:
             self.state = state.shutdown
 
-        if idle:
-            self.waitIdle(30)
-
         if self.parser:
-            self.parser.shutdown(clean=not force)
+            self.parser.shutdown(clean=False)
             self.parser.final_cleanup()
 
     def finishcommand(self):
@@ -1775,6 +1772,7 @@ class BBCooker:
     def reset(self):
         if hasattr(bb.parse, "siggen"):
             bb.parse.siggen.exit()
+        self.finishcommand()
         self.initConfigurationData()
         self.handlePRServ()
 
-- 
2.37.2


