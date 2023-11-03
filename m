Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC0C0018C
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:16 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web10.53505.1699021631921432564
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IwTtEBcz;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1f03db0a410so1328411fac.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021630; x=1699626430; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=IwTtEBczW/Qsv1NG+vy3CbuQ4+551uTpS+6Um/YHdBBzGzl0b4i4C7xGjDf+g4tl/U
         COxvUiNRRApt34epLC9dlN3u1t4NUrxOZk9H3A9HZisgWCEFX2EAVD/rxz+7D7OQkCYx
         94Pbi7nc0zBT2RUfn/XnHyDEXtazBJ5q/gmMfLT4me9RtYCUxb0RViF5UYGT3mXY8oir
         ZxEGuRVHSqyYoiS9CmwzxTpDWM4iQfB8TLoaZFXqJiqhdja3Gy6NQHjr4fDFb44rxaSv
         Xh2Ek8bA7CzQR85aPzzpwVhpzs/Rh8rYJ9jrWO8takMChsjfE9wHMFFq4dIwQ+CarnWx
         MSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021630; x=1699626430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=hmpckZQvjzEsPkIvWAsbGZWZkERTiMwTVkUOwXClXE+hEozAhC4IW+LcCShtR0ABhk
         YDBvRY+oBUj+qaORB8YPLVaKNtQSL6TJ5YxMRJ5jlBQ8EiRJwIDFW6a4+MxIFwNz26Tj
         rwvihf1MxW71xsGya5YgxO01vD26QDopq/1iv0YXnCFgA9umSELZem3CiU/ClzZHLSOw
         JdduQCQJosc5s+RQZv24+erOFz6VZLm9u3RE37czYVifwcltrjz5ZDizlw/GXBqLjJPq
         hpqEIgTVInG2NHQEcG4HYsFnSKK+h3knQoYRngN+WXJId1yIXn716WtfFwa8iaRHrusT
         XB8w==
X-Gm-Message-State: AOJu0YzXbEb17wxwz3TYDjBRRxucHSikDBOxug6lNIMrB5eI33+YxKg0
	jh74o4IfEF/hGeUJo7lMn/qARGTcKOQ=
X-Google-Smtp-Source: AGHT+IGoNPAF/qjoBdCsbMGnR/SIRISMYiKMxMbT60QhGMZ7BzsC8wig4os13JNGNtx7nsMhl5BiVg==
X-Received: by 2002:a05:6870:1045:b0:1bb:a227:7008 with SMTP id 5-20020a056870104500b001bba2277008mr20735678oaj.3.1699021630605;
        Fri, 03 Nov 2023 07:27:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:09 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 12/22] asyncrpc: client: Add disconnect API
Date: Fri,  3 Nov 2023 08:26:30 -0600
Message-Id: <20231103142640.1936827-13-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15433

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


