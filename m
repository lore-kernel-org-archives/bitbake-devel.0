Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail.openembedded.org (Postfix) with ESMTP id F3D207F333
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:58 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id z1so77564622wru.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=UcuSscboNo5zJs2l/YdDQFdctSTDl7erJJjeFWN7Xhw=;
	b=ZXF+YzyEcJ080+cGQAMDNaOHyiL0nqhq+DqrzxBWwSmh1bXvnQu8FfRnQrtO2cDvpR
	TAfPo4QyYCPsc4/2Bq19Qk3zQRbxGwtBJfLuy5YQp4xX+rdfBjRCxplUqjYeNcm+9MNE
	66t0cBXn8SXHx01vdki1qYqScmct6XMPS4HoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UcuSscboNo5zJs2l/YdDQFdctSTDl7erJJjeFWN7Xhw=;
	b=YnrRp0i/Y6pOsvBYmTRZE6hqtfdsOLi1Hq+0GdZCG+3LkXlBn0uLpN2QA2Hm8DEzR5
	Kqi+LBXcL15SlG9fuWNVVLg3gt4UswxMVFpr0EbY58HdPK8454qUA8nUbRr1vSTb8Z6G
	hEYX4D1yRiz4CYHQlISL3e9aR6A2V/jyLOWy0S5DCRS36xym79s2ZwERgL32hUVgTYoc
	lw5aF0K6Yn4yLL/s7qxdfN8Yg771lehH8rrEZisZ0TSpdhrQhg2w56FPiKsV0yhmKj2U
	lrddN9UhGs4JOdBUziza1uRgz+9tI4pZbUJ7PX7au8TgyZSMy0MCZ68vlzJam+Lmac67
	0tnQ==
X-Gm-Message-State: APjAAAWozbwz34tW9HydbIEF5ZzD70f7a+oz79kxnl2kgk7iAoxKRDxx
	j6FZd6lKUqu45zB9U2RoxMCb2lIGQAs=
X-Google-Smtp-Source: APXvYqxQQ0wM4swFUY7kOVzy/VTu6ZT7ZegLqfzaHVSqh9yupq+JyRnUyhNs0HC4H1JsI1vlvBXXsQ==
X-Received: by 2002:adf:f601:: with SMTP id t1mr51352256wrp.337.1564759259405; 
	Fri, 02 Aug 2019 08:20:59 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.58
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:43 +0100
Message-Id: <20190802152049.16529-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 10/16] hashserv: Use separate threads for answering requests and handling them
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
X-List-Received-Date: Fri, 02 Aug 2019 15:20:59 -0000
Content-Transfer-Encoding: 8bit

Experience with the prserv shows that having two threads, one accepting
and queueing connections and one handling the requests leads to much
more reliable behaviour than having everything in a single thread.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/hashserv/__init__.py | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 544bc86b16..86aa7e9de6 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -10,6 +10,9 @@ import sqlite3
 import json
 import traceback
 import logging
+import socketserver
+import queue
+import threading
 from datetime import datetime
 
 logger = logging.getLogger('hashserv')
@@ -135,6 +138,41 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
             self.send_error(400, explain=traceback.format_exc())
             return
 
+class ThreadedHTTPServer(HTTPServer):
+    quit = False
+
+    def serve_forever(self):
+        self.requestqueue = queue.Queue()
+        self.handlerthread = threading.Thread(target=self.process_request_thread)
+        self.handlerthread.daemon = False
+
+        self.handlerthread.start()
+        super().serve_forever()
+
+    def process_request_thread(self):
+        while not self.quit:
+            try:
+                (request, client_address) = self.requestqueue.get(True)
+            except queue.Empty:
+                continue
+            if request is None:
+                continue
+            try:
+                self.finish_request(request, client_address)
+            except Exception:
+                self.handle_error(request, client_address)
+            finally:
+                self.shutdown_request(request)
+
+    def process_request(self, request, client_address):
+        self.requestqueue.put((request, client_address))
+
+    def server_close(self):
+        super().server_close()
+        self.quit = True
+        self.requestqueue.put((None, None))
+        self.handlerthread.join()
+
 def create_server(addr, dbname, prefix=''):
     class Handler(HashEquivalenceServer):
         pass
@@ -171,4 +209,5 @@ def create_server(addr, dbname, prefix=''):
         cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup ON tasks_v2 (method, outhash)')
 
     logger.info('Starting server on %s', addr)
-    return HTTPServer(addr, Handler)
+
+    return ThreadedHTTPServer(addr, Handler)
-- 
2.20.1


