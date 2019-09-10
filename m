Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 4019D7F351
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2019 14:16:13 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id l16so20547203wrv.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2019 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=2OW/aL4H5jkbPu3ZDS+OWH2WkPx65CaY2bMF+u5rm4I=;
	b=QS1Yv+RIAwUnUyvu16UqNmBRMyyrU53GiDcgtp+Ycre1gAqLgPEonOmpa5BzoK9nHh
	ODaudcNZQV2ZCPCzc7h5DGAFzbT++8AcDZ5wSwvcmGoCEmT2nbU2uq4fYZgHKOHu3Kto
	CJ8exs6/OJOLdxx5t+S/QdZ47XC4OtfaKW8V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2OW/aL4H5jkbPu3ZDS+OWH2WkPx65CaY2bMF+u5rm4I=;
	b=RNXnRmn3HYjbJheCwtd4a11nPes+3TeFwWGUKaQ0215SgyS/vrMADtpqHGl+G2LDGL
	+v1wL3gIsxleN1QypVppLH2BEOpXk25Ii9IAOkZwlILqDEB9mjFPSTBKdtkyZUU7h3bS
	B/DcPwV36dXlmwQIUqW4Uq+cJmXk1A8L4Rgwv/jnrGNDOVGplQ5h0o7+ku5V4WLvp5Xu
	fOf+TLam7fIYCwONZocAr+IzDGKG8fPPL2Cqog+2NeTvQlCY21copceDKVzuwSnfk1DK
	yhj9zPcGYeH781xvuXwqygWYH3GCVROKQnPuvozmjefyCmG2BwEoruO1Yc6APv3ykWO/
	Tv8g==
X-Gm-Message-State: APjAAAVTVw92OepWvf1/QQg86K3Y8aTkIkzNVg/4VMbzubCdA0TaOhWa
	xKZpp1xs9BU2OVBGkNZp4LNAXjRud6k5Dw==
X-Google-Smtp-Source: APXvYqxDWTYvDeK/5D9b8unvM/EPGgki16hLYYkiBYSSYeDikdvkK6ckkXgXTUnCTGbhwzGz0oxjVg==
X-Received: by 2002:adf:f282:: with SMTP id k2mr26156576wro.38.1568124964811; 
	Tue, 10 Sep 2019 07:16:04 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	f186sm4954353wmg.21.2019.09.10.07.16.03
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 10 Sep 2019 07:16:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Sep 2019 15:15:55 +0100
Message-Id: <20190910141555.6710-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910141555.6710-1-richard.purdie@linuxfoundation.org>
References: <20190910141555.6710-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/2] hashserv: Drop handler thread
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
X-List-Received-Date: Tue, 10 Sep 2019 14:16:13 -0000
Content-Transfer-Encoding: 8bit

With performance measurements we've proven the handler thread is slower than not
bothering with threading so drop it.

There was also a bug in this code where the database was being repeatedly being
reopened/closed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/hashserv/__init__.py | 62 ++++------------------------------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index eb03c32213..9d5722ab88 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -24,17 +24,8 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
     def log_message(self, f, *args):
         logger.debug(f, *args)
 
-    def opendb(self):
-        self.db = sqlite3.connect(self.dbname)
-        self.db.row_factory = sqlite3.Row
-        self.db.execute("PRAGMA synchronous = OFF;")
-        self.db.execute("PRAGMA journal_mode = MEMORY;")
-
     def do_GET(self):
         try:
-            if not self.db:
-                self.opendb()
-
             p = urllib.parse.urlparse(self.path)
 
             if p.path != self.prefix + '/v1/equivalent':
@@ -67,9 +58,6 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
 
     def do_POST(self):
         try:
-            if not self.db:
-                self.opendb()
-
             p = urllib.parse.urlparse(self.path)
 
             if p.path != self.prefix + '/v1/equivalent':
@@ -141,62 +129,22 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
             self.send_error(400, explain=traceback.format_exc())
             return
 
-class ThreadedHTTPServer(HTTPServer):
-    quit = False
-
-    def serve_forever(self):
-        self.requestqueue = queue.Queue()
-        self.handlerthread = threading.Thread(target=self.process_request_thread)
-        self.handlerthread.daemon = False
-
-        self.handlerthread.start()
-
-        signal.signal(signal.SIGTERM, self.sigterm_exception)
-        super().serve_forever()
-        os._exit(0)
-
-    def sigterm_exception(self, signum, stackframe):
-        self.server_close()
-        os._exit(0)
-
+class HashHTTPServer(HTTPServer):
     def server_bind(self):
         HTTPServer.server_bind(self)
         self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_LINGER, struct.pack('ii', 1, 0))
 
-    def process_request_thread(self):
-        while not self.quit:
-            try:
-                (request, client_address) = self.requestqueue.get(True)
-            except queue.Empty:
-                continue
-            if request is None:
-                continue
-            try:
-                self.finish_request(request, client_address)
-            except Exception:
-                self.handle_error(request, client_address)
-            finally:
-                self.shutdown_request(request)
-        os._exit(0)
-
-    def process_request(self, request, client_address):
-        self.requestqueue.put((request, client_address))
-
-    def server_close(self):
-        super().server_close()
-        self.quit = True
-        self.requestqueue.put((None, None))
-        self.handlerthread.join()
-
 def create_server(addr, dbname, prefix=''):
     class Handler(HashEquivalenceServer):
         pass
 
     db = sqlite3.connect(dbname)
     db.row_factory = sqlite3.Row
+    db.execute("PRAGMA synchronous = OFF;")
+    db.execute("PRAGMA journal_mode = MEMORY;")
 
     Handler.prefix = prefix
-    Handler.db = None
+    Handler.db = db
     Handler.dbname = dbname
 
     with contextlib.closing(db.cursor()) as cursor:
@@ -223,7 +171,7 @@ def create_server(addr, dbname, prefix=''):
         cursor.execute('CREATE INDEX IF NOT EXISTS taskhash_lookup ON tasks_v2 (method, taskhash)')
         cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup ON tasks_v2 (method, outhash)')
 
-    ret = ThreadedHTTPServer(addr, Handler)
+    ret = HashHTTPServer(addr, Handler)
 
     logger.info('Starting server on %s\n', ret.server_port)
 
-- 
2.20.1


