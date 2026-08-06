Return-Path: <fjpedrazag@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7DAC56208
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 16:13:10 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23048.1786032786994393740
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Aug 2026 09:13:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NAvm5tVx;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: fjpedrazag@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf49dc28ccso3355985ad.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786032786; x=1786637586; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gxMs8WgC2PS2EQKBZxfq3sMusnYr0ty5y+HqGtQTzjo=;
        b=NAvm5tVxmO0KQ8VH0+NCdCtBjMZ5HvDXleGaLcv2V4KiHDv2jA2kY9t+eEVTxMF1VQ
         1nxogSgp2Np20dAlV3VLuXsz1+Qgnb8SgE0Ph+8bn5oAgp27T3vyR6UiY7Qom4DQNCgF
         dB5rQ4mtd1kzqJo07XfVMeAujY27lJrWl9Os9MN32Y+IeaUBcak0R6P6hV9zZmw5QS6e
         TbLrKL94SUS8DzRkRL71XS9JEaplk2EgkHtoxjJ/HEPcB5FoW9yodlw0B79o7RJ8G/jL
         PvF4aghaeLNaPtpha/8z8JuMek377Hkfus9YmFVkoMBJbNIzD0G3qls/tbJ2Q2ZNcHCd
         lEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786032786; x=1786637586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxMs8WgC2PS2EQKBZxfq3sMusnYr0ty5y+HqGtQTzjo=;
        b=Ipe+19E1H5BnkEQ4kJz3p57XxZmyhjaiS9nWWeUW+fsVhD2DpEeA2QSa4ngj62QudH
         Pcdd11CBWCgfu6lHOwf9NGb5Ea0DjTd178CEa/ZMB8nIS836JXw5RSEDGAjgInMOTQGf
         fQxe30Y6BHVjPwXbylELSpctQOyH1GQFOdP1fPBGHWDU6HWdT4jMPMvivzsC5/fqFHo8
         turxu5E0p0/Qj/8bcPViJMqwl7QribrdjIXE+v3N0Ft4HzS0fvZxSWRK/igkwzT1ICIn
         6HJTHuRv9FdjyKucT7XoUbz2ateUqaeYfWMU85vbZY2cza0WGW1gYTwVLtcy+XvLyAmn
         +nzQ==
X-Gm-Message-State: AOJu0Yx7+7f3fSVBuZF3JcHOe4ZBoWPhYmA2F/vTxUVVb2ZkiqLKGCBc
	5f6UCsZOznaW/8EsDwp1qGj7Z3CtXdQimptXjsxgCQQJUTlPqFrITEMtYOEca9ALb84=
X-Gm-Gg: AR+sD10OqXFbdefCQ75Ccp7jSsZ2HaNMOTNFDAi9mTqdaBRtoixlWjZBtEC4VEdAwo4
	imUwoVapHH831V59ThSKhWx6rGMW9986STeGD3I1IIej1Zz4ZOamtnMha1GZQ4Z074dGlx/NvHs
	vUeqPgazLRQp8Thoyzvj6ZXumr8E6Ohn3DHtULGPYyyu2ILta8+QXUe6pZ4nDswpdZYd/qaUzul
	W8kL0xjTQAD37Ssy0a9nmmt02sCyL7JpMATVjhTLPgSGQ3ak/sUXDltrWJIVTWKLt/OILginw9v
	SzcWRkD+K0BjenCrJPpuheHccOV63VpErfaFqgBfvXrJCX57EXs1/E6Cxr8fXXAWXJ167tZ2h+g
	ZVxT2t96usVI7+/GU5eBskIJKWlFcxF3o/CDOvKgLOSD1vjJr0Rjn4GzFbZ7Yk6g4w5JI4agzvG
	IU7ADizljg+Rs+DoswoGnX4LOKb3rb6kZYEplzFYZ5tgpH1GmBBYF7w3FlOL06/1BGjDvY0YLl8
	dYMPWGhsNxBja1QIGm3gn7pOTO8fwns
X-Received: by 2002:a17:903:2f8f:b0:2ca:d803:5c8f with SMTP id d9443c01a7336-2d0ca73a210mr124721575ad.1.1786032786209;
        Thu, 06 Aug 2026 09:13:06 -0700 (PDT)
Received: from fedora (c-73-63-238-177.hsd1.ca.comcast.net. [73.63.238.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158676f579sm27163873eec.20.2026.08.06.09.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:13:05 -0700 (PDT)
From: Francisco Pedraza <fjpedrazag@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Francisco Pedraza <fjpedrazag@gmail.com>
Subject: [PATCH] asyncrpc: Close the client event loop when the client is collected
Date: Thu,  6 Aug 2026 09:12:58 -0700
Message-ID: <20260806161258.3815426-1-fjpedrazag@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 16:13:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19904

Client creates its own event loop and installs it with
asyncio.set_event_loop(), so a client dropped without close() being
called keeps the loop, and any transport that loop owns, alive. The
loop only becomes collectable once a later client replaces the global
reference, and asyncio then reports the transport and the loop as
unclosed:

  ResourceWarning: unclosed transport <asyncio.sslproto._SSLProtocolTransport object>
  ResourceWarning: unclosed event loop <_UnixSelectorEventLoop running=False closed=False>

This is why the warning shows up at an unrelated later point rather
than where the client was leaked.

SignatureGeneratorUniHashMixIn caches its client and only closes it
from reset() and exit(), so any teardown path missing those leaks it.

Register a weakref.finalize() to close the loop when the client is
collected. close() detaches the finalizer first, so the explicit path
does the same work as before.

Reproduced with two clients where the first is never closed, on python
3.10 with websockets 10.4 and on python 3.14 with websockets 17.0.1.
Both report the warnings without this change and neither does with it.
bitbake-selftest hashserv.tests passes.

Fixes [YOCTO #16236]

Signed-off-by: Francisco Pedraza <fjpedrazag@gmail.com>
---
 lib/bb/asyncrpc/client.py | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 17b72033b..115acd456 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -12,6 +12,7 @@ import socket
 import sys
 import re
 import contextlib
+import weakref
 from threading import Thread
 from .connection import StreamConnection, WebsocketConnection, DEFAULT_MAX_CHUNK
 from .exceptions import ConnectionClosedError, InvokeError
@@ -224,8 +225,29 @@ class Client(object):
         # required (but harmless) with it.
         asyncio.set_event_loop(self.loop)
 
+        # The loop and its transports must be closed even if the caller never
+        # calls close(). Since set_event_loop() above replaces the reference
+        # held by the previous client, an unclosed loop only becomes reachable
+        # for collection once another client is created, at which point
+        # asyncio reports "unclosed transport" and "unclosed event loop"
+        # ResourceWarnings. The finalizer is detached by close() so that the
+        # normal path is unaffected.
+        self._finalizer = weakref.finalize(
+            self, self._close_loop, self.loop, self.client
+        )
+
         self._add_methods("connect_tcp", "ping")
 
+    @staticmethod
+    def _close_loop(loop, client):
+        if loop.is_closed():
+            return
+        try:
+            loop.run_until_complete(client.close())
+            loop.run_until_complete(loop.shutdown_asyncgens())
+        finally:
+            loop.close()
+
     @abc.abstractmethod
     def _get_async_client(self):
         pass
@@ -258,9 +280,8 @@ class Client(object):
 
     def close(self):
         if self.loop:
-            self.loop.run_until_complete(self.client.close())
-            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
-            self.loop.close()
+            self._finalizer.detach()
+            self._close_loop(self.loop, self.client)
         self.loop = None
 
     def __enter__(self):
-- 
2.55.0


