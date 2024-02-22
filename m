Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203ECC5478C
	for <webhook@archiver.kernel.org>; Thu, 22 Feb 2024 22:32:01 +0000 (UTC)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
 by mx.groups.io with SMTP id smtpd.web11.26322.1708641117617222414
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Feb 2024 14:31:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XbvTVtap;
 spf=pass (domain: gmail.com, ip: 209.85.166.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c3e4290f5fso7607239f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Feb 2024 14:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708641116; x=1709245916; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iScEZByyO/SKo225bRjmwcSnHFUrtJt7ZgL3yQO6nUk=;
        b=XbvTVtap7DBbUwFw9RAiZfvw8hSEAs4Um0ywQ4N6BEBKC/kAZP1C0Ykw0m0o4tujVS
         Y1Psh21D54Nf9hLcsbCxXNaOHnrjpyjCY6FEDvTHn+fUTsSta3GSJMv/3C3vSNwMSqrY
         P5LPsPhnYbtrJm505VTRDf07yjGG3PbKkr8zZIZcNh36LIQ3dQm6t3QoY7kXGyKziNjX
         9VP21ZZn3uAhT2CjRkdF/HAdWnc1573UVR+SLD5c8eaFao7iKSTGiZafDWl8BQIT2x/J
         PdJJIdPdlGsRf4aelxAeXex9fcwE0mczeUxz/54c5A1kjdq9mjOd3p/0HZ3MyE6/4Qkv
         SqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708641116; x=1709245916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iScEZByyO/SKo225bRjmwcSnHFUrtJt7ZgL3yQO6nUk=;
        b=NXAUtLCJ1zrX+Z0oEs3mx+T8T6Nv9G69PNtuT9zS0RpgFWh1Q18beeNwh7C2XSOMFj
         EEHy7qfu4ph4Ixz+PXTwqS5AcFqzT9N3F+GKT++qvVU8i1YxcfkIobWicx2CkAnoFMIg
         LWsyn43LXbpSwpYv66BIx8nKfbjyuo2TNlAmQrlURqit4ynfauKI3BXeknLeD/Z2cZXS
         Zb00Ezv7ddCrQbz8liMW95QFs9AmUNJ6SZ2oWMrADqAd/Eur74jukmtTWdCBNk3eTIVk
         lkNLYaiOb0MCIIvuEfDhvvKIsq2wzbi7VL1L+phPKoY8u2xj9a7jS3L1bYptT7Bkaoo0
         VCxg==
X-Gm-Message-State: AOJu0Yy1afSmGSA9cVKzUeLlnQGBwuw+YCv7OfYp5I3MdPmg1LrhFGDz
	LZsXDPJ3n2Cb5dU13ZI6N7dubMaN9UOr4eFfXkk4FZpVpP52w//UsraCljLA
X-Google-Smtp-Source: AGHT+IGk1dACzKRQxh9bIjkORyV3JMJI6A1fTVsx8AzyAGF9iygUqDpPn2QjOqNAg0lySydAPTkjJw==
X-Received: by 2002:a6b:5817:0:b0:7c7:798a:a64a with SMTP id m23-20020a6b5817000000b007c7798aa64amr245429iob.21.1708641115478;
        Thu, 22 Feb 2024 14:31:55 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::25d7])
        by smtp.gmail.com with ESMTPSA id cu14-20020a05663848ce00b00474100af2dfsm3283031jab.54.2024.02.22.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:31:54 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] asyncrpc: Add support for server headers
Date: Thu, 22 Feb 2024 15:31:48 -0700
Message-Id: <20240222223148.3949435-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Feb 2024 22:32:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15953

Adds support for asyncrpc servers to send connection headers to clients
on connection. Since this is a breaking protocol change, clients must
opt-in to expect headers from the server, corresponding to a version
bump in the client protocol.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/client.py | 33 ++++++++++++++++++++++++++++++-
 bitbake/lib/bb/asyncrpc/serv.py   | 16 +++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index a6228bb0ba0..29a5ab76aa9 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
@@ -17,13 +17,24 @@ from .exceptions import ConnectionClosedError, InvokeError
 
 
 class AsyncClient(object):
-    def __init__(self, proto_name, proto_version, logger, timeout=30):
+    def __init__(
+        self,
+        proto_name,
+        proto_version,
+        logger,
+        timeout=30,
+        server_headers=False,
+        headers={},
+    ):
         self.socket = None
         self.max_chunk = DEFAULT_MAX_CHUNK
         self.proto_name = proto_name
         self.proto_version = proto_version
         self.logger = logger
         self.timeout = timeout
+        self.needs_server_headers = server_headers
+        self.server_headers = {}
+        self.headers = headers
 
     async def connect_tcp(self, address, port):
         async def connect_sock():
@@ -61,9 +72,29 @@ class AsyncClient(object):
     async def setup_connection(self):
         # Send headers
         await self.socket.send("%s %s" % (self.proto_name, self.proto_version))
+        await self.socket.send(
+            "needs-headers: %s" % ("true" if self.needs_server_headers else "false")
+        )
+        for k, v in self.headers.items():
+            await self.socket.send("%s: %s" % (k, v))
+
         # End of headers
         await self.socket.send("")
 
+        self.server_headers = {}
+        if self.needs_server_headers:
+            while True:
+                line = await self.socket.recv()
+                if not line:
+                    # End headers
+                    break
+                tag, value = line.split(":", 1)
+                self.server_headers[tag.lower()] = value.strip()
+
+    async def get_header(self, tag, default):
+        await self.connect()
+        return self.server_headers.get(tag, default)
+
     async def connect(self):
         if self.socket is None:
             self.socket = await self._connect_sock()
diff --git a/bitbake/lib/bb/asyncrpc/serv.py b/bitbake/lib/bb/asyncrpc/serv.py
index f0be9a6cdb2..a66117acad1 100644
--- a/bitbake/lib/bb/asyncrpc/serv.py
+++ b/bitbake/lib/bb/asyncrpc/serv.py
@@ -39,10 +39,14 @@ class AsyncServerConnection(object):
                 "address": socket.address,
             },
         )
+        self.client_headers = {}
 
     async def close(self):
         await self.socket.close()
 
+    async def handle_headers(self, headers):
+        return {}
+
     async def process_requests(self):
         try:
             self.logger.info("Client %r connected" % (self.socket.address,))
@@ -64,12 +68,20 @@ class AsyncServerConnection(object):
                 )
                 return
 
-            # Read headers. Currently, no headers are implemented, so look for
-            # an empty line to signal the end of the headers
+            # Read headers
+            self.client_headers = {}
             while True:
                 header = await self.socket.recv()
                 if not header:
+                    # Empty line. End of headers
                     break
+                tag, value = header.split(":", 1)
+                self.client_headers[tag.lower()] = value.strip()
+
+            if self.client_headers.get("needs-headers", "false") == "true":
+                for k, v in (await self.handle_headers(self.client_headers)).items():
+                    await self.socket.send("%s: %s" % (k, v))
+                await self.socket.send("")
 
             # Handle messages
             while True:
-- 
2.34.1


