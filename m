Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E86C98324
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 07:46:58 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32883.1790495202929987093
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Sep 2026 00:46:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=XTXpsOIJ;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso6238685e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790495201; x=1791100001; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WdIFVnZKxNPRQYye1Kj6tfTMTEp+O6oS1NBwhahoxJY=;
        b=XTXpsOIJhOceEkZjUugXP5XLPiDZ7p6Q3WZ4ltIrXxfSKUxT80KuGe5gGqvIVvuACP
         zo97mcOBrBcXYw0Xuw8d0+EPy0pXzSk9UvDR5SxF+nDmMjbonzRecXB5APF/WYypfJ3V
         TzGWmfTxj2Te8aoxiEiZZ/2xCwlXbhac3oRR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495201; x=1791100001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WdIFVnZKxNPRQYye1Kj6tfTMTEp+O6oS1NBwhahoxJY=;
        b=Ahy66dCOGYYDP6ubI4l5zb1bAB2RzWghu6K5XOnrebK1ioifP4ow6jzYI5nL95sN/X
         r/CCZAe/BzoZ+Syw27bA6vRizATBbA4B8WwQoXUHQm5i9mA6v8BxQ0FKrZBfvSsm2rnU
         XvsloMhHe41ZuEyL7cgnO5hjukGzRUEt2eNJ326M7UWFaXC3wzaFJLFfP+mGmvClC8vi
         zhkL1E3A3ANVcwlMJO8vsveKD33HvTZfIj4+9rokHd+mx5Jmx6NFCgtasB97ZK5PS5DP
         AQkDFNv8qTDUtRDzNLH5nW89fuRxoIepaO/kgrRq1SdvzT9c5eYGw15F4ypN2jOCYJVt
         3teQ==
X-Gm-Message-State: AFuF++luTUNvX+gqPtfv7nC2MJQF/oiKTsdBUfYwxjLCF1JOpFfW1KxP
	tJSwFlZ+KlOGBroubvCdvSs+j803Q6cSgT5mwmjvgdq1ah4SjrLFfGhtH7VMAe+YXidBXntonLD
	97mgy738=
X-Gm-Gg: AYBFou2J9J7aCyTmuWyEm0GCPjoiCF/fwjPep51toZfGo2SBbaBBBb5CefLjxyCPcc9
	5DQZ3OIO6UfXCRAvfKustWmJ8WStFAf2qJ3CYLeFka5zeBVGUc38t79xRkZbYoX9uBAs07GAt9J
	pa1fXcEk6Lp/gj0sjV4wJ3mRIH4E43FV0f+07YK5tNBvUEYVhlcXGsEFBJz0meN06RUPAJ5lJjh
	iqrrMO0Nn5fBBLA2EkwytZspa7OD5dwoEmCDHfsl3Li87vEKhkhMDZ/yyFDhbbZcoVMmLmzXxOA
	aXCrrDBDKJkhCi58uAH6Hwdy0o22ESwsyZ4qyYaCkKR2r8w/sZMdq3dJ7N32ARsGf5wtwt4jbSU
	XxmhVyjgRh9imvpMcdzlEhnD8wPyYu0hTXRnHTNrI2b0KyyU/hp3TaR1n1GsGonK9uqnFJpFxcW
	HTAqMga/tCsOmTD/kyl8Ut3adsdI7Mi+nclBld8GMzHFMFJBzWIgI3BaEDRUK66UDPKQXKwgfMB
	Pap/WrqIOyidWXZPrwNeklGrK0FaQhdj12zX/V1YZR8cSE+PBFfizlK1i0BnxQHViWlnEhsvw==
X-Received: by 2002:a05:600d:4445:10b0:4a0:37b:5c25 with SMTP id 5b1f17b1804b1-4a0037b5ccbmr1046095e9.11.1790495201111;
        Sun, 27 Sep 2026 00:46:41 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm18485266f8f.2.2026.09.27.00.46.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:46:40 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 6/6] asyncrpc: Close the client event loop when the client is collected
Date: Sun, 27 Sep 2026 09:46:35 +0200
Message-ID: <a8b1dd0aa61ad91716379cdad59c4a9206ebfd7f.1790495161.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790495160.git.yoann.congal@smile.fr>
References: <cover.1790495160.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 07:46:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20265

From: Francisco Pedraza <fjpedrazag@gmail.com>

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

Shutdown errors are logged rather than raised, since an exception from
the finalizer would otherwise be discarded by the interpreter and
reported only as "Exception ignored in". A peer that has gone away or
stopped responding is expected for a client that was never closed and
is logged at debug; anything else, including a loop that cannot be run,
is logged at warning. The exceptions raised by websockets fall into the
latter case as they cannot be named here, websockets being imported
lazily in connect_websocket(). The loop is closed in every case.

Reproduced with two clients where the first is never closed, on python
3.10 with websockets 10.4 and on python 3.14 with websockets 17.0.1.
Both report the warnings without this change and neither does with it.
Each handled exception type was checked to not escape the finalizer, to
still close the loop and to log at the intended level.
bitbake-selftest hashserv.tests passes.

Fixes [YOCTO #16236]

Reviewed-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Francisco Pedraza <fjpedrazag@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7a3cb0d55e3698e883a9ff8491febc9d155482ca)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/asyncrpc/client.py | 50 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 17b72033b..dd28fa730 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -7,15 +7,19 @@
 import abc
 import asyncio
 import json
+import logging
 import os
 import socket
 import sys
 import re
 import contextlib
+import weakref
 from threading import Thread
 from .connection import StreamConnection, WebsocketConnection, DEFAULT_MAX_CHUNK
 from .exceptions import ConnectionClosedError, InvokeError
 
+logger = logging.getLogger("bb.asyncrpc.client")
+
 UNIX_PREFIX = "unix://"
 WS_PREFIX = "ws://"
 WSS_PREFIX = "wss://"
@@ -224,8 +228,49 @@ class Client(object):
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
+        # This can be called from the finalizer, where an exception would be
+        # discarded by the interpreter and reported only as "Exception ignored
+        # in", so report the error here instead. The loop is closed below in
+        # every case.
+        except (OSError, ConnectionClosedError, asyncio.TimeoutError) as exc:
+            # The peer has gone away or is not responding. That is expected
+            # for a client that was never closed, so it is not worth warning
+            # about. asyncio.TimeoutError is only distinct from OSError on
+            # python older than 3.11.
+            logger.debug("Client connection already closed or unreachable: %s" % exc)
+        except RuntimeError as exc:
+            # The loop could not be run, for example because another loop is
+            # already running in this thread. Unlike the above, this means
+            # something is wrong with how the client is being used.
+            logger.warning("Could not shut down client event loop: %s" % exc)
+        except Exception as exc:
+            # Also covers the exceptions raised by websockets, which cannot be
+            # named here as it is imported lazily in connect_websocket(), and
+            # whatever may be raised while the interpreter is shutting down.
+            logger.warning("Error shutting down client connection: %s" % exc)
+        finally:
+            loop.close()
+
     @abc.abstractmethod
     def _get_async_client(self):
         pass
@@ -258,9 +303,8 @@ class Client(object):
 
     def close(self):
         if self.loop:
-            self.loop.run_until_complete(self.client.close())
-            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
-            self.loop.close()
+            self._finalizer.detach()
+            self._close_loop(self.loop, self.client)
         self.loop = None
 
     def __enter__(self):

