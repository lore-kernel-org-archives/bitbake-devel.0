Return-Path: <fjpedrazag@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC807C56208
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 21:59:26 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30412.1786053562164418036
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Aug 2026 14:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NuOhOwgM;
 spf=pass (domain: gmail.com, ip: 209.85.210.174, mailfrom: fjpedrazag@gmail.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e4e98d2cfso495432b3a.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786053561; x=1786658361; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d2LpEULHSetkDBQKf26I6jGV7vp1brawepaX50rSuE0=;
        b=NuOhOwgMiBqXWuD7ntxzi/AYsIdax+pO3LG5JJUBX4sNMoetSkeXMAx03QOZ2IY/9q
         2d8heZ+Z/vn2Gyiay9uFzys6ogEhIWsBHaMc7FP/NsYqi3iJG5xMNes7aDTO07ju0fhZ
         JhgNPp9IGOXlH3XUzS6g7iA9we+gXwtHkhq2w/ZivDgWL7gEdgl5mFAo2ResJ/NIEbkc
         cnyjXoRliD84ZB6KQ8ECZnvYtH8/PhskVRND1kFinf6iSJACTRJU+ZJyl6DTQ1svgsTv
         BLsR6PGLhGwb6xxV4BitFThIlJ+JPx0tkgeE0hjZOKnQBahiEdUknC4S4KBtqnBaKbgr
         R9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786053561; x=1786658361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2LpEULHSetkDBQKf26I6jGV7vp1brawepaX50rSuE0=;
        b=GOCAcB4drImz0c/aTinLgfuFVYU8ixeQRJOBrvvP65HvmCEs51BL2NYwPvMlJuk9BP
         sXGrKFW15zY2BHvP2BcGh01DScearwUwJDAW9dh5iBQOeM0hroAfj8UX3aKth4P/KOFg
         qtu+Supq4O+vxKlSu9BPiTHIN7bvZPN+awQ19BJ8LFMcixbEmRRXT6tN/wbuJIjfkVeT
         ls0V7/fI0BLHewrfoWIif9lrcPC0iFYZCuzmZFn8S614Lw16QwtmskXGJ8tLDuZwEVml
         bjrwxzzhOhhsSadSygrsJkA1mb+u7cWY+E8iUOzFSv2TzKZy6ZIpdXjD3bEUbJBa8yJ+
         kKIw==
X-Gm-Message-State: AOJu0YxTObVZ8elDgIjV3osCKYpuzCLgZBaFhRdzCJZsv759vfjbF06J
	Dyq40r4GBf2C34x6uk/h/Jo1KF2L3Fc2UZVNu1gJuA+J+4HCwu8A7rlbvwTFuTsUcLA=
X-Gm-Gg: AR+sD125vUmIZSKMgRuQtiGom2WbO1gEGCxP7K33/vjmxXgssixa2SNXviZcGklha+X
	2cK9hgxOHHjCHOoZ6qFde7w4pRRJNVrnBUpCignalXP4B4uFInAytr5zpHtCBGWt0Vv0YkUG4Yf
	Z/8O23HgjkuiOKHa2lUmL+cPYdub+ufh6IvGImgFmKP6dSIXEgqNvqhDF2cQxvmb+JQJzaNRt6w
	lDD/vYMlSHnNpm/iwjSVhFktIB9hbLVjPZPgMNTMoQNIT/pZ+uLcU2HBMeCki+hkrwt3m2shg7l
	QaKVHRRUMVzEDDycoARJIhLP607/Fr3KB9niuBSETOfu8fSZH9FmWOuhgPawUKlZAXfClIRWal2
	m9GK/v2paBEtIUck+CnwZBQnqF4UFKpyvQgljs79gdQnTVl4BPavmJPqkiet727zi4eXbyQ6aXi
	sx5DJmfQofWmDmqr9jEZZRwsiL+m6DArlkUXZC6AzMMlqbdQC5p0wGUgtajGRqs+guPJ6RwjArP
	ohpS7ronPJzcF4KKfFBUvc2pUOxWgc=
X-Received: by 2002:a05:6a20:4321:b0:3c6:673d:b5d8 with SMTP id adf61e73a8af0-3cb863f3bb0mr14339230637.3.1786053561370;
        Thu, 06 Aug 2026 14:59:21 -0700 (PDT)
Received: from fedora (c-73-63-238-177.hsd1.ca.comcast.net. [73.63.238.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f187sm25774b3a.39.2026.08.06.14.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:59:20 -0700 (PDT)
From: Francisco Pedraza <fjpedrazag@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: JPEWhacker@gmail.com,
	limon.anibal@gmail.com,
	Francisco Pedraza <fjpedrazag@gmail.com>
Subject: [PATCH v2] asyncrpc: Close the client event loop when the client is collected
Date: Thu,  6 Aug 2026 14:58:49 -0700
Message-ID: <20260806215913.3910602-1-fjpedrazag@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Aug 2026 21:59:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19908

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
-- 
2.55.0


