Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web10.72633.1629391612329972090
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Aug 2021 09:46:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Yb6+uJ7j;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d5so5084895qtd.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Aug 2021 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pSnjxmPE7JFFM75kyM2xdisXbLZntAkjopgTp+bD7B8=;
        b=Yb6+uJ7j8r3sQAFN2NQGIdB0HCdUKwxl1tr1fW9a7F0nS7Oxou3LojKjuxdz2VsMnJ
         rBfJjLVQcYkbhT8IPkElgmvSdxdyEK723TAExP9Gc5KwvHJ2gRHc56v6cGY4AWPApUdP
         iJ6Q0mN9DKlmeM3fqk1WEhBFDEvwR6FuV45uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSnjxmPE7JFFM75kyM2xdisXbLZntAkjopgTp+bD7B8=;
        b=JvgKmp2jDfsI5pnCq+wjSzKA6MDCW5Jyt/Bj/JnFpzigmKvgFqDaNVrqvnUtIMhaCY
         xBwC0COeRShg2/2C0I1uwthVZvZ4Pxsr6v0PZEeVvVNAzMi7UrPPoOnIDKhvown65Rrm
         j7ubKFBknvKAMOC6Pc5bMtzwTXBg9S0A/QwgXKF8ztr6cGoEo0or6hZ22EinAnwV+zKF
         9a+lU7POtfVnM8L7h3ApADLHwRe4J63QC6RbDygyXowyaaGBa2XLmeUdTd9Ox6baeqep
         Y/t90/7FausV0WaIg8j4csxBH8xIpwzXHfrMK1rhkgkul8T0xE+YwuDMnFPC7eDr0Ahw
         l76w==
X-Gm-Message-State: AOAM532v08arF0zyz2PTgsCnwIyOwJGJa52iqJERl3+XwI6wy6SoEq56
	EzG6D6YkyMBWBbR4ZHAtjAifaWbf4loxgQ==
X-Google-Smtp-Source: ABdhPJxoVz0wVdb1JpzQ1vHZGXZmJ0QMSAn2GvZwk393yjP1BC3PC4ot/RwkxQep3jVwwZR7Pcdt6w==
X-Received: by 2002:ac8:5892:: with SMTP id t18mr13516695qta.37.1629391611153;
        Thu, 19 Aug 2021 09:46:51 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (192-0-174-222.cpe.teksavvy.com. [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id c27sm1817987qkp.5.2021.08.19.09.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:46:50 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Paul Barker <paul@pbarker.dev>
Subject: [PATCH v6 1/4] bitbake: asyncrpc: Defer all asyncio to child process
Date: Thu, 19 Aug 2021 12:46:41 -0400
Message-Id: <22a4e6fc5913fdf78f5c93893b16472f0641ff29.1629388054.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629388054.git.scott.murray@konsulko.com>
References: <cover.1629388054.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <JPEWhacker@gmail.com>

Reworks the async I/O API so that the async loop is only created in the
child process. This requires deferring the creation of the server until
the child process and a queue to transfer the bound address back to the
parent process

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
[small loop -> self.loop fix in serv.py]
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/asyncrpc/serv.py | 118 ++++++++++++++++++++++++----------------
 lib/hashserv/server.py  |   4 +-
 2 files changed, 74 insertions(+), 48 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 4084f300..45628698 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -131,53 +131,58 @@ class AsyncServerConnection(object):
 
 
 class AsyncServer(object):
-    def __init__(self, logger, loop=None):
-        if loop is None:
-            self.loop = asyncio.new_event_loop()
-            self.close_loop = True
-        else:
-            self.loop = loop
-            self.close_loop = False
-
+    def __init__(self, logger):
         self._cleanup_socket = None
         self.logger = logger
+        self.start = None
+        self.address = None
+
+    @property
+    def loop(self):
+        return asyncio.get_event_loop()
 
     def start_tcp_server(self, host, port):
-        self.server = self.loop.run_until_complete(
-            asyncio.start_server(self.handle_client, host, port, loop=self.loop)
-        )
-
-        for s in self.server.sockets:
-            self.logger.debug('Listening on %r' % (s.getsockname(),))
-            # Newer python does this automatically. Do it manually here for
-            # maximum compatibility
-            s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
-            s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
-
-        name = self.server.sockets[0].getsockname()
-        if self.server.sockets[0].family == socket.AF_INET6:
-            self.address = "[%s]:%d" % (name[0], name[1])
-        else:
-            self.address = "%s:%d" % (name[0], name[1])
+        def start_tcp():
+            self.server = self.loop.run_until_complete(
+                asyncio.start_server(self.handle_client, host, port)
+            )
+
+            for s in self.server.sockets:
+                self.logger.debug('Listening on %r' % (s.getsockname(),))
+                # Newer python does this automatically. Do it manually here for
+                # maximum compatibility
+                s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
+                s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
+
+            name = self.server.sockets[0].getsockname()
+            if self.server.sockets[0].family == socket.AF_INET6:
+                self.address = "[%s]:%d" % (name[0], name[1])
+            else:
+                self.address = "%s:%d" % (name[0], name[1])
+
+        self.start = start_tcp
 
     def start_unix_server(self, path):
         def cleanup():
             os.unlink(path)
 
-        cwd = os.getcwd()
-        try:
-            # Work around path length limits in AF_UNIX
-            os.chdir(os.path.dirname(path))
-            self.server = self.loop.run_until_complete(
-                asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
-            )
-        finally:
-            os.chdir(cwd)
+        def start_unix():
+            cwd = os.getcwd()
+            try:
+                # Work around path length limits in AF_UNIX
+                os.chdir(os.path.dirname(path))
+                self.server = self.loop.run_until_complete(
+                    asyncio.start_unix_server(self.handle_client, os.path.basename(path))
+                )
+            finally:
+                os.chdir(cwd)
 
-        self.logger.debug('Listening on %r' % path)
+            self.logger.debug('Listening on %r' % path)
 
-        self._cleanup_socket = cleanup
-        self.address = "unix://%s" % os.path.abspath(path)
+            self._cleanup_socket = cleanup
+            self.address = "unix://%s" % os.path.abspath(path)
+
+        self.start = start_unix
 
     @abc.abstractmethod
     def accept_client(self, reader, writer):
@@ -205,8 +210,7 @@ class AsyncServer(object):
         self.logger.debug("Got exit signal")
         self.loop.stop()
 
-    def serve_forever(self):
-        asyncio.set_event_loop(self.loop)
+    def _serve_forever(self):
         try:
             self.loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
             signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGTERM])
@@ -217,28 +221,50 @@ class AsyncServer(object):
             self.loop.run_until_complete(self.server.wait_closed())
             self.logger.debug('Server shutting down')
         finally:
-            if self.close_loop:
-                if sys.version_info >= (3, 6):
-                    self.loop.run_until_complete(self.loop.shutdown_asyncgens())
-                self.loop.close()
-
             if self._cleanup_socket is not None:
                 self._cleanup_socket()
 
+    def serve_forever(self):
+        """
+        Serve requests in the current process
+        """
+        self.start()
+        self._serve_forever()
+
     def serve_as_process(self, *, prefunc=None, args=()):
-        def run():
+        """
+        Serve requests in a child process
+        """
+        def run(queue):
+            try:
+                self.start()
+            finally:
+                queue.put(self.address)
+                queue.close()
+
             if prefunc is not None:
                 prefunc(self, *args)
-            self.serve_forever()
+
+            self._serve_forever()
+
+            if sys.version_info >= (3, 6):
+                self.loop.run_until_complete(self.loop.shutdown_asyncgens())
+            self.loop.close()
+
+        queue = multiprocessing.Queue()
 
         # Temporarily block SIGTERM. The server process will inherit this
         # block which will ensure it doesn't receive the SIGTERM until the
         # handler is ready for it
         mask = signal.pthread_sigmask(signal.SIG_BLOCK, [signal.SIGTERM])
         try:
-            self.process = multiprocessing.Process(target=run)
+            self.process = multiprocessing.Process(target=run, args=(queue,))
             self.process.start()
 
+            self.address = queue.get()
+            queue.close()
+            queue.join_thread()
+
             return self.process
         finally:
             signal.pthread_sigmask(signal.SIG_SETMASK, mask)
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 8e849897..a059e521 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -410,11 +410,11 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
 
 class Server(bb.asyncrpc.AsyncServer):
-    def __init__(self, db, loop=None, upstream=None, read_only=False):
+    def __init__(self, db, upstream=None, read_only=False):
         if upstream and read_only:
             raise bb.asyncrpc.ServerError("Read-only hashserv cannot pull from an upstream server")
 
-        super().__init__(logger, loop)
+        super().__init__(logger)
 
         self.request_stats = Stats()
         self.db = db
-- 
2.31.1

