Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4105CC25B74
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 15:42:37 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web10.13123.1717083755435484189
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 May 2024 08:42:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CiegFcow;
 spf=pass (domain: gmail.com, ip: 209.85.167.170, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9cc681ee7so417989b6e.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717083753; x=1717688553; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcezi2kXC/Gkh1WBjOM2igjWwiAgAtPzKF8Boct/JTE=;
        b=CiegFcow8/2olvDrkF5TyXp2U8MNPMhICpF0+SSWGYlJqGS5Vu69VAsRcLF3kt7Oju
         HYbXCjqzrhcId/Mog/7jaMu9i2nJFGQ/yD4+F5r7NAo/XRVDXoYOufVCiiu9rAJRxMFu
         nV9PAfYDfp5Rp5Eb3MFot9FEiDuWtPTK60F6mq97e/hbTVxCf62IZe30081qPWR7uPcO
         4ynWUI1b0KRIkMeGgx32Dg6rRZaoSMEy/ucbBwOTB2D187MYYN9Fp0D4mJg8T00GklUO
         HqivPiwGCvAiVSIjY8Cxxd2X12t9kYyLxVma80bxz4RvvLJzpafeJMFz89Iswpb46+Di
         sXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083753; x=1717688553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcezi2kXC/Gkh1WBjOM2igjWwiAgAtPzKF8Boct/JTE=;
        b=jF85DL6M8sUsI4es4350qdSB20C2bjdDa5w8LNcjw/8Mkvs1mg6S6JQUNWupbbIRjM
         Ozr3WBwGF24h301NLCGQmtu9wKKxxDcX5L+oeG2BJ5GxiDOoafubgBz3dwmK0neLSSkS
         H9P1Y2MxJxBRjb4fsHJj477Cx2zqYt8c94c1J782dKtOONl7Yb53JVglQucEg+ywuRVd
         xij16ZY7pqd4NV3JQe5CjCXbLeQe490C3piCOQKUnAoi8jRwq6ImJ9apzL7/POXmlaJd
         CM68oa15rIUjgSzrNex91wdITzsFJtw4FRnOROxdaLg19QrSIvJharJPe86y+YOfmon0
         nyLA==
X-Gm-Message-State: AOJu0YzwAEVaA84zBEOqOfyt9knSrCJ/bOWupFUYECZvd18ybX0A9Xbt
	ALOSwMhemhc6XsxaUmUyLlqDKUl8jD9HGwXvML2urm5fPgVVk49phFD7jA==
X-Google-Smtp-Source: AGHT+IFX7A+oNFfGODuBHl+CxeJh1xMIjeHM8Z69KcSBc9e3NplOyJPcMil95dkdCIHQVI/AMeRbEA==
X-Received: by 2002:a54:4113:0:b0:3d1:d2e1:6283 with SMTP id 5614622812f47-3d1dd2ece0amr869416b6e.25.1717083753597;
        Thu, 30 May 2024 08:42:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::125b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1b372013bsm1987961b6e.45.2024.05.30.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:42:33 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] hashserv: client: Fix changing stream modes
Date: Thu, 30 May 2024 09:42:30 -0600
Message-ID: <20240530154230.792726-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 15:42:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16292

When switching from normal mode to stream mode, skip calling
self._set_mode() again because this will cause a recursion into the
_set_mode() function and causes problems.

Also cleanup some of the error checking during this process

This bug affected when a client would attempt to switch from one stream
mode to another, and meant that the server would get an invalid message
from the client. This would cause the server to disconnect the client,
and the client would then reconnect in normal mode which was the mode it
wanted anyway and thus it would carry on without any errors. This made
the bug not visible on the client side, but resulting in a lot of
backtrace JSON decoding exceptions in the server logs.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index d415617b206..a510f3284fc 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -121,24 +121,28 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
 
         return await self._send_wrapper(proc)
 
-    async def invoke(self, *args, **kwargs):
+    async def invoke(self, *args, skip_mode=False, **kwargs):
         # It's OK if connection errors cause a failure here, because the mode
         # is also reset to normal on a new connection
-        await self._set_mode(self.MODE_NORMAL)
+        if not skip_mode:
+            await self._set_mode(self.MODE_NORMAL)
         return await super().invoke(*args, **kwargs)
 
     async def _set_mode(self, new_mode):
         async def stream_to_normal():
+            # Check if already in normal mode (e.g. due to a connection reset)
+            if self.mode == self.MODE_NORMAL:
+                return "ok"
             await self.socket.send("END")
             return await self.socket.recv()
 
         async def normal_to_stream(command):
-            r = await self.invoke({command: None})
+            r = await self.invoke({command: None}, skip_mode=True)
             if r != "ok":
+                self.check_invoke_error(r)
                 raise ConnectionError(
                     f"Unable to transition to stream mode: Bad response from server {r!r}"
                 )
-
             self.logger.debug("Mode is now %s", command)
 
         if new_mode == self.mode:
-- 
2.43.2


