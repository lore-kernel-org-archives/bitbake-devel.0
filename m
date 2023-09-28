Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69486E732FE
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 17:06:09 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web10.19057.1695920765151788179
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Sep 2023 10:06:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KVkg1vbh;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1dcfb2a3282so5067149fac.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695920764; x=1696525564; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgcnrNjvCa+O23jJRcO2GfBxbQCQ2CJH/XeNs8oGsOs=;
        b=KVkg1vbhc3Y0QhjOZkyeH5FzWW0Fmm5hHQ4LXZFTe2GTrz6H53mFZ8fnfpE25ha/QY
         tjaoH91h8s3kTv4GfKWpcosRtLaVaq2ULdwd0LZUoiQGyatkzeMKMNLdn6UVJIRkJwYc
         2KWBfZomuAPnBq2sUY1lCrtoVNkwf86f4X5rJz3+IWRLiJC0bA6AVhROx7n06OmrnCdx
         aJhl1aa0xTI/Hsof50gVcBp3pU2obGc71kc7GO8jPuiYOdMXJBCRTcOhcrtCv8i1iC+d
         f+JiW8m6iAJXBW1IW6r7geAjBpJsR1vrY8m9n08lOAG6R5vxYjAze3/IHs8+8/+thJEL
         +Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920764; x=1696525564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgcnrNjvCa+O23jJRcO2GfBxbQCQ2CJH/XeNs8oGsOs=;
        b=dUtj7TK6AfTe5WexHT700JjtY8IPJYHqHJULD7PNTniefX2GxP9LehoJuZrcmLdPGE
         u4sEVx7rl78GnHTpECj9ODJ4FM7gzZ2yLfRLoyNzQq/1QlqbB5RcUxULxD7frU+tomKH
         +Fku8Au6220YK7BaGnP5p057/XdL7TmQIERkfffpCLSKIElYLRhf96T+L2USVYxVYWZ9
         vdssVKjHmyAoXjwdLrAahAVfXKX6V/hdnThu5aooq/4yla/YwhlX7MQfeSOrvS+saiDA
         BIqqPXZ7DmHkjUsdRMXw/0XIjmgT/GfjuHMeUdi6rOuz40ArqORBh4eDEs4c3Pdx1zlk
         QAAQ==
X-Gm-Message-State: AOJu0Yz5amcFrtyOkDoyP69WuEqEZe8nhmw3aAu+CazlbyOMdtZlL+4I
	d/is0Xl+zNcFI77vwC4CIRjDK4JncnU=
X-Google-Smtp-Source: AGHT+IGri4lGwvotJcShi8OoP/b7VvfSyN2J3WUweha0lJoIIEW1pa0PVNCHHIOcMEHEY4hMYrrSkA==
X-Received: by 2002:a05:6870:958b:b0:1bf:df47:7b5e with SMTP id k11-20020a056870958b00b001bfdf477b5emr1907390oao.16.1695920763774;
        Thu, 28 Sep 2023 10:06:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::f27c])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm1389772oal.1.2023.09.28.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:06:02 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC 5/5] hashserv: Add websocket connection implementation
Date: Thu, 28 Sep 2023 11:05:51 -0600
Message-Id: <20230928170551.4193224-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928170551.4193224-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 17:06:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15147

Adds support for the hash equivalence client to talk to a server over a
websocket. Since websocket are already message orientated (as opposed to
stream orientated like the other implementations), a new MessageParser()
class is implemented for them (although, this class would work for any
message orientation socket, not just websockets).

Note that websocket support does require the 3rd party websockets python
module be installed on the host, but it should not be required unless
websockets are actually being used.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/client.py | 38 +++++++++++++++++++++++++++++++
 bitbake/lib/hashserv/__init__.py  |  9 ++++++++
 bitbake/lib/hashserv/client.py    |  1 +
 3 files changed, 48 insertions(+)

diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index 335da09d8c6..b0892a82436 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
@@ -78,6 +78,35 @@ class StreamParser(object):
             self.writer = None
 
 
+class MessageParser(object):
+    def __init__(self, socket, timeout):
+        self.socket = socket
+        self.timeout = timeout
+
+    async def setup_connection(self, proto_name, proto_version):
+        await self.socket.send("%s %s" % (proto_name, proto_version))
+
+    async def invoke(self, msg):
+        await self.socket.send(json.dumps(msg))
+        try:
+            message = await asyncio.wait_for(self.socket.recv(), self.timeout)
+        except asyncio.TimeoutError:
+            raise ConnectionError("Timed out waiting for server")
+
+        return json.loads(message)
+
+    async def close(self):
+        if self.socket is not None:
+            await self.socket.close()
+            self.socket = None
+
+    async def send(self, msg):
+        await self.socket.send(msg)
+
+    async def recv(self):
+        return await self.socket.recv()
+
+
 class AsyncClient(object):
     def __init__(self, proto_name, proto_version, logger, timeout=30):
         self.socket = None
@@ -111,6 +140,15 @@ class AsyncClient(object):
 
         self._connect_sock = connect_sock
 
+    async def connect_websocket(self, uri):
+        import websockets
+
+        async def connect_sock():
+            websocket = await websockets.connect(uri)
+            return MessageParser(websocket, self.timeout)
+
+        self._connect_sock = connect_sock
+
     async def setup_connection(self):
         await self.socket.setup_connection(self.proto_name, self.proto_version)
 
diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index 9cb3fd57a51..aa5c7e736d7 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -11,9 +11,12 @@ import itertools
 import json
 
 UNIX_PREFIX = "unix://"
+WS_PREFIX = "ws://"
+WSS_PREFIX = "wss://"
 
 ADDR_TYPE_UNIX = 0
 ADDR_TYPE_TCP = 1
+ADDR_TYPE_WS = 2
 
 # The Python async server defaults to a 64K receive buffer, so we hardcode our
 # maximum chunk size. It would be better if the client and server reported to
@@ -91,6 +94,8 @@ def setup_database(database, sync=True):
 def parse_address(addr):
     if addr.startswith(UNIX_PREFIX):
         return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX):],))
+    elif addr.startswith(WS_PREFIX) or addr.startswith(WSS_PREFIX):
+        return (ADDR_TYPE_WS, (addr,))
     else:
         m = re.match(r'\[(?P<host>[^\]]*)\]:(?P<port>\d+)$', addr)
         if m is not None:
@@ -137,6 +142,8 @@ def create_client(addr):
     (typ, a) = parse_address(addr)
     if typ == ADDR_TYPE_UNIX:
         c.connect_unix(*a)
+    elif typ == ADDR_TYPE_WS:
+        c.connect_websocket(*a)
     else:
         c.connect_tcp(*a)
 
@@ -149,6 +156,8 @@ async def create_async_client(addr):
     (typ, a) = parse_address(addr)
     if typ == ADDR_TYPE_UNIX:
         await c.connect_unix(*a)
+    elif typ == ADDR_TYPE_WS:
+        await c.connect_websocket(*a)
     else:
         await c.connect_tcp(*a)
 
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 7d2b9cb394f..c80aa32fa55 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -107,6 +107,7 @@ class Client(bb.asyncrpc.Client):
         super().__init__()
         self._add_methods(
             "connect_tcp",
+            "connect_websocket",
             "get_unihash",
             "report_unihash",
             "report_unihash_equiv",
-- 
2.34.1


