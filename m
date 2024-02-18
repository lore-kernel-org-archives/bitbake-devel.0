Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D9C5478A
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:00:15 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.29233.1708297211536013677
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:00:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lqtAM3bW;
 spf=pass (domain: gmail.com, ip: 209.85.166.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so231047439f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297209; x=1708902009; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4D9le2KkjKbIj5/ZeXSLmEDIerOkrycNwUHeOgzjZA=;
        b=lqtAM3bWqvct8WjykCbwirSg7HpSkgloMXr4IA9tGgLJNnMsTB44QpyNurzElEby+S
         6ljx49UjGFdguJDefb4MXH1Z/lSSOroaZxzdIKcpjf5Ml8snGDW3ZEDUPa0bnCrvi3sy
         b8nlz+oTtsp/dyul/AvF4P1JyRAU3mJXTAgTMieXuwig6uR9f8MTar/WvQ3mxJvHAF8S
         PWCbWYMUrUbivklfuVy0KJzrBWHB9ft6H5UXBoIFig+FM0LdCDX3w0oQanY+DuKWi4xM
         sxnqldLxquVlUBKZ+Wt2TzxBh9MO16yp9+vtCcNwkeehyaFM51Ee0OgIHpvAIHCfXW+x
         86yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297209; x=1708902009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4D9le2KkjKbIj5/ZeXSLmEDIerOkrycNwUHeOgzjZA=;
        b=eyqbBp7C+Kx7ZBqkQ4FPGhNa4yWJaWRI3oZfk75oiYJ8RiMayFSspO2TeT1PQC1fra
         2y5u3MfTrvFIhvbr7VKbDiwDkDn/B7ULOATNIsnrYp0+bS2rZGG+Fwj/rm+wmjfoHCLR
         5kqyJWvSCJ8m8NycuwHJh8dZqFVZK6tbVcZhu97UAov/w4q9FXKcrbFUe4ERhjYYj5WU
         5aZVHoGgin+KAjmTfizIm3ETMVRZE+7L2n2z/qq7aGY6xjci7vZgv92fIo+yYffyTWEl
         XDZCZpBvNvFlyASxvXeocyq4rqemcNW57kxq5zKKvSWY+D0IynC+yZna8nQofViTPGZL
         r8fQ==
X-Gm-Message-State: AOJu0YzeXjjuiQxa28ptq3exq/LSj27MJ/ve8xvR+PEytHYlPj4w5OTB
	IgSV7AOkHLqvBAU4FTExpVpHbpomokD7vnfnaP5A3D82oONrp0y72V/MlWop
X-Google-Smtp-Source: AGHT+IEtJybtvLabRQusJniYPEBrbBKy0aYfs7QWhotm3BFx/+B6PcaKbr5qjyv5gKxqTy2YX7pTwA==
X-Received: by 2002:a5d:8498:0:b0:7c4:9619:a6ce with SMTP id t24-20020a5d8498000000b007c49619a6cemr12640197iom.12.1708297209048;
        Sun, 18 Feb 2024 15:00:09 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b004712a778fb4sm1214848jap.28.2024.02.18.15.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:00:08 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 4/8] asyncrpc: Add Client Pool object
Date: Sun, 18 Feb 2024 15:59:49 -0700
Message-Id: <20240218225953.2997239-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218225953.2997239-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
 <20240218225953.2997239-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 23:00:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15926

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


