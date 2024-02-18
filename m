Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B4C5478A
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 20:08:05 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web10.25559.1708286880306523128
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 12:08:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PikckazD;
 spf=pass (domain: gmail.com, ip: 209.85.166.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c72290deb6so109119939f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 12:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286878; x=1708891678; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4D9le2KkjKbIj5/ZeXSLmEDIerOkrycNwUHeOgzjZA=;
        b=PikckazDYtQW64xt5AFnj5UfcIxf6zPPi2hSIRrWOvxjUr+0MDqBZuNTagg0Cm8uzV
         R75jBCWc+1N4aDgtZ8vSsMfEIcyqIQWg0/kbj2RUR7YSdO0vE3UAGFqw0aph8AMIcASk
         4nGpyNB5S/1RwxfkHghtesUALFgR8IGiHDdf2Fdpy9TEGL3t2YhIg4Uti7ZxPaZa93cL
         sQ8ws7bgWuZD6mNs8gZaMAS+m2JFEr9Glp13VoBR4eHWGtry4mZSZM/kVGVMBQs4XBEU
         tRFzLlZopW4rrttlYrDvzRoz68oC/fjYLffOorw5RIHFathJ/Ccgp84sBHP2P74N0/q0
         OsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286878; x=1708891678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4D9le2KkjKbIj5/ZeXSLmEDIerOkrycNwUHeOgzjZA=;
        b=C4AakR4lTWmVhqxsqvakARnbPclEyxZgEbuggawtPAaW6QgxPPaW9fTHF9ZA76L9c0
         lpXRFSEIne49MzIo/889WfM0oOe9wgmjEnZisX6JOBy8ZiIDfjP18R9OcC764SGmoJh6
         HgT1wHDd3xrYlz82eTMvKemoU/7x2fQaPqgub789pmnOPruHbvQW1SCtBdc6in0lpx6t
         7/JbB9dF8jEA7sAiWoh+w6IKnOW2b59sWcQs/D00HX3/s58uYfxqeuI2M5FiFvXrp5DO
         facl2uukB4b/NhEKpAo/P0cDuiDLprSTnFNk8KMyQKwynW72fUoEi5bgjkDp73xAP8ge
         gF/A==
X-Gm-Message-State: AOJu0Ywh2Z8l6dMwgCy4jJKT8DIDskS9/i7kJXULXA1aXQqpx2OTu6Vm
	Z5gwbTIPBVJ5fkowvjCzhafBL1vaLbfgceDgbIPH1/ph4UgzLkbDksFH3S4w
X-Google-Smtp-Source: AGHT+IGz8xJsUy3D85cm3nNsFaXyXo6TBTIUSem8zh3V/lPn0TGo51zn3d09cTkQesAcnqRCVp5PFA==
X-Received: by 2002:a6b:710d:0:b0:7c7:4daf:485a with SMTP id q13-20020a6b710d000000b007c74daf485amr1432614iog.11.1708286877987;
        Sun, 18 Feb 2024 12:07:57 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id u6-20020a02aa86000000b004741e1544b6sm549278jai.81.2024.02.18.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:07:56 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 3/5] asyncrpc: Add Client Pool object
Date: Sun, 18 Feb 2024 13:07:41 -0700
Message-Id: <20240218200743.2982923-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218200743.2982923-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 20:08:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15919

Adds an abstract base class that can be used to implement a pool of
client connections. The class implements a thread that runs an async
event loop, and allows derived classes to schedule work on the loop and
wait for the work to be finished.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/__init__.py |  2 +-
 bitbake/lib/bb/asyncrpc/client.py   | 77 +++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/asyncrpc/__init__.py b/bitbake/lib/bb/asyncrpc/__init__.py
index a4371643d74..639e1607f8e 100644
--- a/bitbake/lib/bb/asyncrpc/__init__.py
+++ b/bitbake/lib/bb/asyncrpc/__init__.py
@@ -5,7 +5,7 @@
 #
 
 
-from .client import AsyncClient, Client
+from .client import AsyncClient, Client, ClientPool
 from .serv import AsyncServer, AsyncServerConnection
 from .connection import DEFAULT_MAX_CHUNK
 from .exceptions import (
diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index 0d7cd85780d..a6228bb0ba0 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
@@ -10,6 +10,8 @@ import json
 import os
 import socket
 import sys
+import contextlib
+from threading import Thread
 from .connection import StreamConnection, WebsocketConnection, DEFAULT_MAX_CHUNK
 from .exceptions import ConnectionClosedError, InvokeError
 
@@ -180,3 +182,78 @@ class Client(object):
     def __exit__(self, exc_type, exc_value, traceback):
         self.close()
         return False
+
+
+class ClientPool(object):
+    def __init__(self, max_clients):
+        self.avail_clients = []
+        self.num_clients = 0
+        self.max_clients = max_clients
+        self.loop = None
+        self.client_condition = None
+
+    @abc.abstractmethod
+    async def _new_client(self):
+        raise NotImplementedError("Must be implemented in derived class")
+
+    def close(self):
+        if self.client_condition:
+            self.client_condition = None
+
+        if self.loop:
+            self.loop.run_until_complete(self.__close_clients())
+            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
+            self.loop.close()
+            self.loop = None
+
+    def run_tasks(self, tasks):
+        if not self.loop:
+            self.loop = asyncio.new_event_loop()
+
+        thread = Thread(target=self.__thread_main, args=(tasks,))
+        thread.start()
+        thread.join()
+
+    @contextlib.asynccontextmanager
+    async def get_client(self):
+        async with self.client_condition:
+            if self.avail_clients:
+                client = self.avail_clients.pop()
+            elif self.num_clients < self.max_clients:
+                self.num_clients += 1
+                client = await self._new_client()
+            else:
+                while not self.avail_clients:
+                    await self.client_condition.wait()
+                client = self.avail_clients.pop()
+
+        try:
+            yield client
+        finally:
+            async with self.client_condition:
+                self.avail_clients.append(client)
+                self.client_condition.notify()
+
+    def __thread_main(self, tasks):
+        async def process_task(task):
+            async with self.get_client() as client:
+                await task(client)
+
+        asyncio.set_event_loop(self.loop)
+        if not self.client_condition:
+            self.client_condition = asyncio.Condition()
+        tasks = [process_task(t) for t in tasks]
+        self.loop.run_until_complete(asyncio.gather(*tasks))
+
+    async def __close_clients(self):
+        for c in self.avail_clients:
+            await c.close()
+        self.avail_clients = []
+        self.num_clients = 0
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        self.close()
+        return False
-- 
2.34.1


