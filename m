Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEEBC25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 19:39:52 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web10.25269.1717011587520456362
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 May 2024 12:39:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MUmoUv6E;
 spf=pass (domain: gmail.com, ip: 209.85.167.176, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d1d35cdcadso42325b6e.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717011586; x=1717616386; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bgeq8NtLWAHPHfls5167YjDH7FziGumy/Ix3wNLl4ow=;
        b=MUmoUv6EWzDn82f3U2TaBAVRH3ADXqXMgU3PBBz5VXfMAfDnPVTyaeZQiYYAUDAM+p
         sDRPRewVpeJZbAZAYSQxSKx+vRRYFlsl8yBalPiOQnucvLp27Ac6ugCE7fOfSxnOU4Fl
         TCmgleOYghTi/KfST2DZNO16cVjYJPNDbrqfGiZFEfOR2jreLM856gEh/52dxduuymrA
         Snyi2nE0KmwUbabF9Dvhz4ZoKJ1FmimgWUYbMlIXyb2IpDczXJ0OzVHP851Y/RQJQJNP
         yp+z5NOizD5MTAulS5pYMvs6kZ5C8c9NU539OtttoptVpA4ciJRZoRe4EDkttQbxcByQ
         h/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717011586; x=1717616386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgeq8NtLWAHPHfls5167YjDH7FziGumy/Ix3wNLl4ow=;
        b=IX3PW8d5gppvD99cqxI12NejnNw0ZtNdL0ijP6P54zPGWLxWSpqrk96SfjBi3P5fAZ
         h4Axn3ZlHFW+dgjNGgOuAwHeikaa8PVzdVmaGOWYFh+R6VjNYTGllevi8lW/jnWC3sUE
         nQDATWIFn8BB2gcgSyUkcRxGIrKBxHSObbu6rni11vclnxBymk9miMdnXrGz+2OUHrLA
         ibiciZ8xsLUhYRVjXd34guK0yFYbZBfvj5/TmOKwIcYnns1KYNhxAnBQkQaf63C1tEn3
         354wEMUt4R2rgrn0lYI3g6R6WB+s5tp13thsi4uZoolqHn9Cq4nKiuGUeMHb0/RLTjPR
         9Blg==
X-Gm-Message-State: AOJu0YzyZBUZyNYV01FIKkd/NGGPqeM1AYhrujrsKyWdrEymNOJGYqmd
	fLt6vozNla8RgwInLCai/56Kk5tEp5QbNaYVY0DMpJ9wUN3db9CZmC2cYw==
X-Google-Smtp-Source: AGHT+IF1EdYnX3+WCn12FFAvWPf+529/Fw9m89KYGbN5ousGdQMQ9SkffeT9Hdf/u8Xej2eqxthv8Q==
X-Received: by 2002:a05:6808:2128:b0:3c9:6683:1e0a with SMTP id 5614622812f47-3d1dcb5a421mr30337b6e.17.1717011585652;
        Wed, 29 May 2024 12:39:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::980])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1b37200f9sm1771649b6e.36.2024.05.29.12.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 12:39:45 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] hashserv: server: Add support for SO_REUSEPORT
Date: Wed, 29 May 2024 13:39:33 -0600
Message-ID: <20240529193933.3372776-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 19:39:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16283

SO_REUSEPORT is a socket option that allows multiple servers to listen
on the same TCP port, and the kernel will automatically load balance the
connections between them. This is particularly helpful for the hash
server since it runs in a single thread. To take advantage of a
multi-core server, multiple servers can be started in parallel with this
option (up to 1 per CPU) and the kernel will load balance between them.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashserv     | 10 +++++++++-
 bitbake/lib/bb/asyncrpc/serv.py  | 34 +++++++++++++++++++++++++-------
 bitbake/lib/hashserv/__init__.py |  6 ++++--
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/bitbake/bin/bitbake-hashserv b/bitbake/bin/bitbake-hashserv
index 4bfb7abfbce..01503736b93 100755
--- a/bitbake/bin/bitbake-hashserv
+++ b/bitbake/bin/bitbake-hashserv
@@ -125,6 +125,11 @@ The following permissions are supported by the server:
         default=os.environ.get("HASHSERVER_ADMIN_PASSWORD", None),
         help="Create default admin user with password ADMIN_PASSWORD ($HASHSERVER_ADMIN_PASSWORD)",
     )
+    parser.add_argument(
+        "--reuseport",
+        action="store_true",
+        help="Enable SO_REUSEPORT, allowing multiple servers to bind to the same port for load balancing",
+    )
 
     args = parser.parse_args()
 
@@ -132,7 +137,9 @@ The following permissions are supported by the server:
 
     level = getattr(logging, args.log.upper(), None)
     if not isinstance(level, int):
-        raise ValueError("Invalid log level: %s (Try ERROR/WARNING/INFO/DEBUG)" % args.log)
+        raise ValueError(
+            "Invalid log level: %s (Try ERROR/WARNING/INFO/DEBUG)" % args.log
+        )
 
     logger.setLevel(level)
     console = logging.StreamHandler()
@@ -155,6 +162,7 @@ The following permissions are supported by the server:
         anon_perms=anon_perms,
         admin_username=args.admin_user,
         admin_password=args.admin_password,
+        reuseport=args.reuseport,
     )
     server.serve_forever()
     return 0
diff --git a/bitbake/lib/bb/asyncrpc/serv.py b/bitbake/lib/bb/asyncrpc/serv.py
index a66117acad1..46d54fb5112 100644
--- a/bitbake/lib/bb/asyncrpc/serv.py
+++ b/bitbake/lib/bb/asyncrpc/serv.py
@@ -138,14 +138,20 @@ class StreamServer(object):
 
 
 class TCPStreamServer(StreamServer):
-    def __init__(self, host, port, handler, logger):
+    def __init__(self, host, port, handler, logger, *, reuseport=False):
         super().__init__(handler, logger)
         self.host = host
         self.port = port
+        self.reuseport = reuseport
 
     def start(self, loop):
         self.server = loop.run_until_complete(
-            asyncio.start_server(self.handle_stream_client, self.host, self.port)
+            asyncio.start_server(
+                self.handle_stream_client,
+                self.host,
+                self.port,
+                reuse_port=self.reuseport,
+            )
         )
 
         for s in self.server.sockets:
@@ -209,11 +215,12 @@ class UnixStreamServer(StreamServer):
 
 
 class WebsocketsServer(object):
-    def __init__(self, host, port, handler, logger):
+    def __init__(self, host, port, handler, logger, *, reuseport=False):
         self.host = host
         self.port = port
         self.handler = handler
         self.logger = logger
+        self.reuseport = reuseport
 
     def start(self, loop):
         import websockets.server
@@ -224,6 +231,7 @@ class WebsocketsServer(object):
                 self.host,
                 self.port,
                 ping_interval=None,
+                reuse_port=self.reuseport,
             )
         )
 
@@ -262,14 +270,26 @@ class AsyncServer(object):
         self.loop = None
         self.run_tasks = []
 
-    def start_tcp_server(self, host, port):
-        self.server = TCPStreamServer(host, port, self._client_handler, self.logger)
+    def start_tcp_server(self, host, port, *, reuseport=False):
+        self.server = TCPStreamServer(
+            host,
+            port,
+            self._client_handler,
+            self.logger,
+            reuseport=reuseport,
+        )
 
     def start_unix_server(self, path):
         self.server = UnixStreamServer(path, self._client_handler, self.logger)
 
-    def start_websocket_server(self, host, port):
-        self.server = WebsocketsServer(host, port, self._client_handler, self.logger)
+    def start_websocket_server(self, host, port, reuseport=False):
+        self.server = WebsocketsServer(
+            host,
+            port,
+            self._client_handler,
+            self.logger,
+            reuseport=reuseport,
+        )
 
     async def _client_handler(self, socket):
         address = socket.address
diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index 74367eb6b48..ac891e0174d 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -13,6 +13,7 @@ from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_WS
 
 User = namedtuple("User", ("username", "permissions"))
 
+
 def create_server(
     addr,
     dbname,
@@ -25,6 +26,7 @@ def create_server(
     anon_perms=None,
     admin_username=None,
     admin_password=None,
+    reuseport=False,
 ):
     def sqlite_engine():
         from .sqlite import DatabaseEngine
@@ -60,9 +62,9 @@ def create_server(
         s.start_unix_server(*a)
     elif typ == ADDR_TYPE_WS:
         url = urlparse(a[0])
-        s.start_websocket_server(url.hostname, url.port)
+        s.start_websocket_server(url.hostname, url.port, reuseport=reuseport)
     else:
-        s.start_tcp_server(*a)
+        s.start_tcp_server(*a, reuseport=reuseport)
 
     return s
 
-- 
2.43.2


