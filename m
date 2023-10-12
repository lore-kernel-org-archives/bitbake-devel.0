Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B18CDB483
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:25 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web10.25786.1697149044824754172
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=U7VaMtUT;
 spf=pass (domain: gmail.com, ip: 209.85.167.180, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3af64a4c97eso857104b6e.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149043; x=1697753843; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=U7VaMtUTsWI4gk/nLKN8mk/5csXVRQakydw1jsokg7jYrJ4qrZQ+dEIL+HTyl8QSiM
         kEB5pyVh1DpRLC7x2JGBzn4nYS0S9dZqaS85IXtDuhxU7rjla5gZIFiREix/LLH7pJoV
         AkL/a1EChZYPT8NEaOYkZeJpQ7V25iZLdnOzImXB4rb4qQwP9H2n3OPLV8jnPLVFFRQd
         mi6RyQcz6kFG1HSDF87ZJksFzBky4je829dkZcDYwcJquxb4f7gsJjgobBbbI21aQo7M
         i/jY9TE1m30LQRrQDUMkeenQEeBQlZAlkyeHsCq8OLMiRou3EfJ1htY9BF3S6CuIG/wy
         mrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149043; x=1697753843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=q5Pmxa8u/XACZ63iaLIONstqHmFH/ZMArKUYSlFCB7nETR2AsY70OoxeTIS+kK0ITv
         eOfG8p1rF29gFKryL9eHLwjkKlrlKCEKLXgIyrR7JSsCprZ45Wz6Te1gz19tmIenL7r1
         UjnMYTYPaCC4GqFpfWfqEB+a3Zej7xzRx2iB/e8zTraZHWzn0g67VP336AvmJIhd90MJ
         DE6jGfvdDydLbiz+dX4kWOc22Zn/tFFUmW9FPCa9R9J0EGhcKeOyDjRs1RQZNHkaZdoE
         rfDhaJyQBLWDPrb3JhRSWOB3vSzvZaDmSHvd0rfObpW/TGFG4FIGpc+DXmGNQY2EvfmW
         ZaSQ==
X-Gm-Message-State: AOJu0YyqSOT69zkk8HqC19ELAGhRS1IruPf+4itatATP2OcDPGusWJFn
	osyVbHRkBGuL5ixL71/CeSpLX8gJ4Us=
X-Google-Smtp-Source: AGHT+IFN6x4NbhxvEXPofX814kXhgC5xeFGlD5qWP57cE2iD4nCw/3DCNCDhNqOEFmVYEYcv65Uw9Q==
X-Received: by 2002:a05:6870:e98:b0:1e9:8d7a:fc5b with SMTP id mm24-20020a0568700e9800b001e98d7afc5bmr6256923oab.47.1697149043534;
        Thu, 12 Oct 2023 15:17:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:22 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 14/18] asyncrpc: client: Add disconnect API
Date: Thu, 12 Oct 2023 16:16:51 -0600
Message-Id: <20231012221655.632637-15-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15232

Adds an API to explicitly disconnect a client. This can be useful for
testing the auto-reconnect behavior of clients

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/client.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 628b90ee..0d7cd857 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -67,11 +67,14 @@ class AsyncClient(object):
             self.socket = await self._connect_sock()
             await self.setup_connection()
 
-    async def close(self):
+    async def disconnect(self):
         if self.socket is not None:
             await self.socket.close()
             self.socket = None
 
+    async def close(self):
+        await self.disconnect()
+
     async def _send_wrapper(self, proc):
         count = 0
         while True:
@@ -160,6 +163,9 @@ class Client(object):
     def max_chunk(self, value):
         self.client.max_chunk = value
 
+    def disconnect(self):
+        self.loop.run_until_complete(self.client.close())
+
     def close(self):
         if self.loop:
             self.loop.run_until_complete(self.client.close())
-- 
2.34.1


