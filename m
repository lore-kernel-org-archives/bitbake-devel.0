Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECFAC47DA9
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 19:42:31 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.64.1706557345906709341
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jan 2024 11:42:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CLZqM6eS;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so128415139f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jan 2024 11:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706557344; x=1707162144; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4D9le2KkjKbIj5/ZeXSLmEDIerOkrycNwUHeOgzjZA=;
        b=CLZqM6eSAMB8Ovdpi91IKNWCUUyh64qVc4A0cUrmULwQbuNUXZlOhSmvh23S0J0lHO
         PJOFmvhvxmge2bZ1yHfaTOlPl2qzKelUcEqYiuyLYO0MPQGVG4jsxfbdAL+KskLco3a1
         w7m9eOww1WtXMFpCu+R9Zpr6K7A/5LcDPPrEEXukxvpLsTnNDWKIuhRj7Y9e2JdXYbMr
         kG7uAUx7oJBM7dEDDVc/9pzQBL2GU9U9Dv4ir3Q+gm20vvItFPQQvNDiNt7nciSKArf2
         hAD9rAAJY8gqSHRfVkRq2yGo87QsFYfYjuYwJt9WknfS36gGLo8M81CMrJ/sIG9/80kW
         oMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706557344; x=1707162144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4D9le2KkjKbIj5/ZeXSLmEDIerOkrycNwUHeOgzjZA=;
        b=PkVVbn9TEvDVSoIia6c0t60ugBni+lR3hDe/bj2HMC3A5tYwzW0PTsOoKfa7s5bf7B
         jgHdgARIvM0NScFou9z88TQnFfCqrdqzL3chy2nUXzByCHYZmOFLuGTUavL54yaSl5Be
         fbWYM/5BCUpnw09QkYx6R+YhKoM2clO/lDret3QA7vY+r3heGzF6qLTM9mviZgVP9LJK
         bZyWRPm/eMdysyr8rvprI596N024GII9YwA3H/4jpoe1bDdvo+OduH3B82y3xZQNoK8l
         +YjgIcHZSe796nEyrv9PxbgCeLSDII5HDKFh+5aJSzeQTo7vsLhO5z03qRO6LvKyq21K
         fHvA==
X-Gm-Message-State: AOJu0YwFwT82eqe2RaOJG9lr3Dz0mGDwXcPB59+Eq5GTWVaG96QrfEBJ
	YkKxnWAwm5IptFbAD1Z+H/9NoQ/GotrueNsUoppnZArWgJjz/uPSYA+CH5fm
X-Google-Smtp-Source: AGHT+IFEnql4aBALMIm0iwYkwbccE3LM4fq922EvOzsbQnGbZeJjUZiJunHUOrYoMA/qzW2QOxOJjg==
X-Received: by 2002:a05:6602:235a:b0:7bf:deb3:86c with SMTP id r26-20020a056602235a00b007bfdeb3086cmr7087616iot.6.1706557339606;
        Mon, 29 Jan 2024 11:42:19 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::529a])
        by smtp.gmail.com with ESMTPSA id b7-20020a6be707000000b007bfebc01ca4sm1082242ioh.8.2024.01.29.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:42:18 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/2] asyncrpc: Add Client Pool object
Date: Mon, 29 Jan 2024 12:42:07 -0700
Message-Id: <20240129194208.4096506-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jan 2024 19:42:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15803

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


