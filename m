Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web12.10041.1626970785749822223
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jul 2021 09:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=VZJFVtMX;
 spf=pass (domain: gmail.com, ip: 209.85.167.175, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f175.google.com with SMTP id a132so7146279oib.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jul 2021 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exb7DFkIXvKW4+Ky07yLylwvBLuEe0ShW0+VJXCKiZs=;
        b=VZJFVtMXEWGJj2yLF896hjOwqFvOY35sOVpDU8onmco/Q9Cb0t2MhL0MgzXWsJ9ni2
         Isjs9iq6VZHfY4R0w+uwG1q4SiPQKJdsfSy+tGphkaNyrITfc2enkc9X+u44I8eKhIVz
         7UJrQjvz3zOomfIIHjJUObwBH6tJOjYFBtwB/Fq0bffUbBYLfAsFCyj26qix8gPGawYc
         Jl+cK8PfBdso11BgpOkTrxCr87EOEbBRAz6lDLx2N7ktPf2nQuqAbPnN3uFgI081qQ+L
         0eFlc7fgEdlKCkBmMkaDf0HeBUGo1nh9E+JFZ4exwgD4v9z/hVXDxnpy3ZFxZGBr7gVv
         ihtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exb7DFkIXvKW4+Ky07yLylwvBLuEe0ShW0+VJXCKiZs=;
        b=U5yluWtYNL+6pm4JV1i8ChNaBMLOniLXeQF3oXHPcj2FCELkQY23HSkasqiiVIz0/k
         dHFj+ISem+JxnmBfjco6eAglTCCGe+tpXCb7rOStEXdOoUqBDiNy7wcL+wJMUpr1MLiN
         gIszq0t0e4vSY2FC1Em8klMHDl1mJnfNvwzbUHu5tO92UtWHm+brP1ocajrwCCQff/hE
         qmJGRZ45QFiNZRRUBRBObY2MkXDdW5/X2zQeZsMg5f2CBYgb/oiWNYwUoc360xYi6ep3
         6LW5vf94HSIMVEFLNZUONqb8ntnzr0uvJPIV68aDm5tiVAyeQ/tQKmmQyLKwtWMXZ3k+
         Gl8w==
X-Gm-Message-State: AOAM532ntMLdfLLdo9EvnQU4tNo8OvOnp1UfAyZo83JyGn0fRbNtAA4D
	iIv0eRHWThmQfAskrTqBrrtlJO0SI+IIxg==
X-Google-Smtp-Source: ABdhPJxgiwR7712jKIWytC2FarQYeV3w63xtuvLtz2WRpqG92x+p51QVq26aqcWPv7zDHbg2dykL4Q==
X-Received: by 2002:aca:5802:: with SMTP id m2mr5539158oib.23.1626970784821;
        Thu, 22 Jul 2021 09:19:44 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id h1sm5387846otj.48.2021.07.22.09.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:19:44 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Scott Murray <scott.murray@konsulko.com>,
	richard.purdie@linuxfoundation.org,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: asyncrpc: Catch early SIGTERM
Date: Thu, 22 Jul 2021 11:19:37 -0500
Message-Id: <20210722161937.4880-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the SIGTERM signal is sent to an asyncrpc server before it has
installed the SIGTERM handler in the main loop, it may miss the signal
which will can cause the calling process to wait forever on the join().
To resolve this, the calling process should mask of SIGTERM before
forking the server process and the server should unmask the signal only
after the handler is installed. To simplify the usage of the server, an
new helper function called serve_as_process() is added to do this
automatically and correctly.

Thanks: Scott Murray <scott.murray@konsulko.com> for helping debug
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/serv.py | 21 +++++++++++++
 bitbake/lib/bb/cooker.py        |  3 +-
 bitbake/lib/hashserv/tests.py   | 54 +++++++++++++++++++++++++--------
 3 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/asyncrpc/serv.py b/bitbake/lib/bb/asyncrpc/serv.py
index ef20cb71df..4084f300df 100644
--- a/bitbake/lib/bb/asyncrpc/serv.py
+++ b/bitbake/lib/bb/asyncrpc/serv.py
@@ -9,6 +9,7 @@ import os
 import signal
 import socket
 import sys
+import multiprocessing
 from . import chunkify, DEFAULT_MAX_CHUNK
 
 
@@ -201,12 +202,14 @@ class AsyncServer(object):
             pass
 
     def signal_handler(self):
+        self.logger.debug("Got exit signal")
         self.loop.stop()
 
     def serve_forever(self):
         asyncio.set_event_loop(self.loop)
         try:
             self.loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
+            signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGTERM])
 
             self.run_loop_forever()
             self.server.close()
@@ -221,3 +224,21 @@ class AsyncServer(object):
 
             if self._cleanup_socket is not None:
                 self._cleanup_socket()
+
+    def serve_as_process(self, *, prefunc=None, args=()):
+        def run():
+            if prefunc is not None:
+                prefunc(self, *args)
+            self.serve_forever()
+
+        # Temporarily block SIGTERM. The server process will inherit this
+        # block which will ensure it doesn't receive the SIGTERM until the
+        # handler is ready for it
+        mask = signal.pthread_sigmask(signal.SIG_BLOCK, [signal.SIGTERM])
+        try:
+            self.process = multiprocessing.Process(target=run)
+            self.process.start()
+
+            return self.process
+        finally:
+            signal.pthread_sigmask(signal.SIG_SETMASK, mask)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 39e10e6133..b2d69c28cf 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -390,8 +390,7 @@ class BBCooker:
                 dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
                 self.hashserv = hashserv.create_server(self.hashservaddr, dbfile, sync=False)
-                self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
-                self.hashserv.process.start()
+                self.hashserv.serve_as_process()
             self.data.setVar("BB_HASHSERVE", self.hashservaddr)
             self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservaddr)
             self.databuilder.data.setVar("BB_HASHSERVE", self.hashservaddr)
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index e2b762dbf0..e851535c59 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -15,28 +15,32 @@ import tempfile
 import threading
 import unittest
 import socket
+import time
+import signal
 
-def _run_server(server, idx):
-    # logging.basicConfig(level=logging.DEBUG, filename='bbhashserv.log', filemode='w',
-    #                     format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
+def server_prefunc(server, idx):
+    logging.basicConfig(level=logging.DEBUG, filename='bbhashserv.log', filemode='w',
+                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
+    server.logger.debug("Running server %d" % idx)
     sys.stdout = open('bbhashserv-%d.log' % idx, 'w')
     sys.stderr = sys.stdout
-    server.serve_forever()
-
 
 class HashEquivalenceTestSetup(object):
     METHOD = 'TestMethod'
 
     server_index = 0
 
-    def start_server(self, dbpath=None, upstream=None, read_only=False):
+    def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc):
         self.server_index += 1
         if dbpath is None:
             dbpath = os.path.join(self.temp_dir.name, "db%d.sqlite" % self.server_index)
 
-        def cleanup_thread(thread):
-            thread.terminate()
-            thread.join()
+        def cleanup_server(server):
+            if server.process.exitcode is not None:
+                return
+
+            server.process.terminate()
+            server.process.join()
 
         server = create_server(self.get_server_addr(self.server_index),
                                dbpath,
@@ -44,9 +48,8 @@ class HashEquivalenceTestSetup(object):
                                read_only=read_only)
         server.dbpath = dbpath
 
-        server.thread = multiprocessing.Process(target=_run_server, args=(server, self.server_index))
-        server.thread.start()
-        self.addCleanup(cleanup_thread, server.thread)
+        server.serve_as_process(prefunc=prefunc, args=(self.server_index,))
+        self.addCleanup(cleanup_server, server)
 
         def cleanup_client(client):
             client.close()
@@ -283,6 +286,33 @@ class HashEquivalenceCommonTests(object):
         self.assertClientGetHash(self.client, taskhash2, None)
 
 
+    def test_slow_server_start(self):
+        """
+        Ensures that the server will exit correctly even if it gets a SIGTERM
+        before entering the main loop
+        """
+
+        event = multiprocessing.Event()
+
+        def prefunc(server, idx):
+            nonlocal event
+            server_prefunc(server, idx)
+            event.wait()
+
+        def do_nothing(signum, frame):
+            pass
+
+        old_signal = signal.signal(signal.SIGTERM, do_nothing)
+        self.addCleanup(signal.signal, signal.SIGTERM, old_signal)
+
+        _, server = self.start_server(prefunc=prefunc)
+        server.process.terminate()
+        time.sleep(30)
+        event.set()
+        server.process.join(300)
+        self.assertIsNotNone(server.process.exitcode, "Server did not exit in a timely manner!")
+
+
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
         return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
-- 
2.32.0

