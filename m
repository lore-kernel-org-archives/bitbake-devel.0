Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id B3C987F35F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:59 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id x4so24413993wrt.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=35Py8gx26IwKPlYQ76150ukrvKwCfY1jaBf8WnabviE=;
	b=eGO1ELK/9FjTMeU/d24fTLRqhLS63B2CsyuSj5mxLMv3V7KFkGFKUdiFC6xj9UuOVY
	/EUqUwlLitQpsnW32w+4wmW9VHjdVYIwZeEUr9QR2uk/imks6pNb6WgiQBBm1ImSyjr6
	0SJ1iEqWzbWp34ZPYvZPG00Qx2Qp9EFskNQTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=35Py8gx26IwKPlYQ76150ukrvKwCfY1jaBf8WnabviE=;
	b=ePu2+acM9lRRyBAax2+KYonprbuBaHkQgqTLfz64D59qHwYBYBEjJzeYmpa1qoyGdw
	jnCimBXJFl8oyj1Hd3/4akRa6kUwi6nYOc4EEOAxlA+232R+SxvRGpu0v9f/VbKdX9Qf
	leZqAajw2fL3hKacJhJmDI0OxXnUNOA7zF2mRlxbhDCluQB0g5XYYrE2La442Esey3ew
	n5XQbhv+S6eabOigJrrpKFtqZnM14nz395C7Aw7Y9dGJZCQLmFRbP7ZD09v0iWLnimld
	rRiUaNy6LpiWh8WPDQkTR3IYh4effZ4r2yyekxyp5dQzKEOxRBhqxVQ4w1qtgAGNlRJO
	85pQ==
X-Gm-Message-State: APjAAAWHCE31aMz9R/z3yz2kM3RaofLwxJhx8+RajedixqH2Wnv7E6Rl
	X8h9cFoZ+u/7cuDwKlsRxg7cj3YDJg0=
X-Google-Smtp-Source: APXvYqyc+uJpB2hKJjgUhtUJQwpjxWJ1Pbm44SGzTHfubGVf3h/SzjC1gLlw/c5blvlModxX5HnxCg==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr93258974wru.288.1564759260187;
	Fri, 02 Aug 2019 08:21:00 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.59
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:44 +0100
Message-Id: <20190802152049.16529-11-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 11/16] hashserv: Switch from threads to multiprocessing
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 02 Aug 2019 15:21:00 -0000
Content-Transfer-Encoding: 8bit

There were hard to debug lockups when trying to use threading to start
hashserv as a thread. Switch to multiprocessing which doesn't show the
same locking problems.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 20 +++++++++++---------
 lib/hashserv/__init__.py | 14 ++++++++++++--
 lib/hashserv/tests.py    |  8 ++++----
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 84f25ec94e..6e1d59bb3a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -193,6 +193,8 @@ class BBCooker:
         bb.parse.BBHandler.cached_statements = {}
 
         self.ui_cmdline = None
+        self.hashserv = None
+        self.hashservport = None
 
         self.initConfigurationData()
 
@@ -231,8 +233,6 @@ class BBCooker:
         self.state = state.initial
 
         self.parser = None
-        self.hashserv = None
-        self.hashservport = None
 
         signal.signal(signal.SIGTERM, self.sigterm_exception)
         # Let SIGHUP exit as SIGTERM
@@ -372,12 +372,13 @@ class BBCooker:
         self.data.setVar('BB_CMDLINE', self.ui_cmdline)
 
         if self.data.getVar("BB_HASHSERVE") == "localhost:0":
-            dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
-            self.hashserv = hashserv.create_server(('localhost', 0), dbfile, '')
-            self.hashservport = "localhost:" + str(self.hashserv.server_port)
-            thread = threading.Thread(target=self.hashserv.serve_forever)
-            thread.daemon = True
-            thread.start()
+            if not self.hashserv:
+                dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
+                self.hashserv = hashserv.create_server(('localhost', 0), dbfile, '')
+                self.hashservport = "localhost:" + str(self.hashserv.server_port)
+                self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
+                self.hashserv.process.daemon = True
+                self.hashserv.process.start()
             self.data.setVar("BB_HASHSERVE", self.hashservport)
 
         #
@@ -1658,7 +1659,8 @@ class BBCooker:
     def post_serve(self):
         prserv.serv.auto_shutdown()
         if self.hashserv:
-            self.hashserv.shutdown()
+            self.hashserv.process.terminate()
+            self.hashserv.process.join()
         bb.event.fire(CookerExit(), self.data)
 
     def shutdown(self, force = False):
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 86aa7e9de6..1d5e08ee5a 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -13,6 +13,7 @@ import logging
 import socketserver
 import queue
 import threading
+import signal
 from datetime import datetime
 
 logger = logging.getLogger('hashserv')
@@ -147,8 +148,14 @@ class ThreadedHTTPServer(HTTPServer):
         self.handlerthread.daemon = False
 
         self.handlerthread.start()
+
+        signal.signal(signal.SIGTERM, self.sigterm_exception)
         super().serve_forever()
 
+    def sigterm_exception(self, signum, stackframe):
+        self.server_close()
+        os._exit(0)
+
     def process_request_thread(self):
         while not self.quit:
             try:
@@ -163,6 +170,7 @@ class ThreadedHTTPServer(HTTPServer):
                 self.handle_error(request, client_address)
             finally:
                 self.shutdown_request(request)
+        os._exit(0)
 
     def process_request(self, request, client_address):
         self.requestqueue.put((request, client_address))
@@ -208,6 +216,8 @@ def create_server(addr, dbname, prefix=''):
         cursor.execute('CREATE INDEX IF NOT EXISTS taskhash_lookup ON tasks_v2 (method, taskhash)')
         cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup ON tasks_v2 (method, outhash)')
 
-    logger.info('Starting server on %s', addr)
+    ret = ThreadedHTTPServer(addr, Handler)
+
+    logger.info('Starting server on %s\n', ret.server_port)
 
-    return ThreadedHTTPServer(addr, Handler)
+    return ret
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 15f4a52ee9..6845b53884 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -6,7 +6,7 @@
 #
 
 import unittest
-import threading
+import multiprocessing
 import sqlite3
 import hashlib
 import urllib.request
@@ -21,16 +21,16 @@ class TestHashEquivalenceServer(unittest.TestCase):
         self.dbfile = tempfile.NamedTemporaryFile(prefix="bb-hashserv-db-")
         self.server = create_server(('localhost', 0), self.dbfile.name)
         self.server_addr = 'http://localhost:%d' % self.server.socket.getsockname()[1]
-        self.server_thread = threading.Thread(target=self.server.serve_forever)
+        self.server_thread = multiprocessing.Process(target=self.server.serve_forever)
+        self.server_thread.daemon = True
         self.server_thread.start()
 
     def tearDown(self):
         # Shutdown server
         s = getattr(self, 'server', None)
         if s is not None:
-            self.server.shutdown()
+            self.server_thread.terminate()
             self.server_thread.join()
-            self.server.server_close()
 
     def send_get(self, path):
         url = '%s/%s' % (self.server_addr, path)
-- 
2.20.1


