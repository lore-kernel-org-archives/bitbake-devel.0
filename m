Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail.openembedded.org (Postfix) with ESMTP id 9A7B57F318
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:56 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id x1so27665837wrr.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=AY5SPHdXWOxYd8yuMqrSZRt4ze0dr9jB6WkRLfV2zhs=;
	b=a3Jd+2eLcJPqurNdYSEKHgQh0bX+xV1Scc076ISMSJ5UObmSe5Ckk1A8Pv/b+IAcbk
	NSPwDivC8XaVZiDGUJGuVooom89oUr437Nchg2IiJqp+gZLx5533ezVX85nsWWa2fwot
	vgZHFOyRZR7cHZn/DRVkvvkZ3Rdnq8AtPCOb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AY5SPHdXWOxYd8yuMqrSZRt4ze0dr9jB6WkRLfV2zhs=;
	b=U7YV4lux/mwZtqHaWWRHm3SBlm751kNxhSR9fOYSuwraaGb0qPyFzELIUH+23Fq2ib
	muA2P87c5DTz0lZiyu+KjKDm7szhQ4gIlSZ4qBKkQw5xe/dzl54VrW2qIet/tfBj8e+p
	hC34rpv+7PWi8A69Jo73L80zhrlW46Ddb5sjr/QQVq2F3ZFck/coAgHks/9MyDwZnH3M
	+XI7f7/1XaT8KwWZ2zEdThFYnxU9boj+tX8dJstkvPgqwsMojbB+8aGSqYUcGkc587Du
	gOygI68KIloj5j6yoDbsQgqXtBZi6cplDxFKz985PgJ/JQt0L13axCNrdiuDx31JzI2g
	R9ow==
X-Gm-Message-State: APjAAAWdPWKzpn5bAhWlr/ok5IP/FMfgxFs7xCWPbhaES2oLPZyDT88s
	IsnlcsecGUzMbUJjxDCKYdX/c2nRaEI=
X-Google-Smtp-Source: APXvYqxUFNSbv4E63U6ZWosDmRaF5h9DvMe5DBzQF0W1yGPJagC50sKcjhCNcCiJGMjLFEqa/dCEXA==
X-Received: by 2002:adf:f104:: with SMTP id r4mr57669907wro.140.1564759256967; 
	Fri, 02 Aug 2019 08:20:56 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.55
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:40 +0100
Message-Id: <20190802152049.16529-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 07/16] cooker/hashserv: Allow autostarting of a local hash server using BB_HASHSERVE
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
X-List-Received-Date: Fri, 02 Aug 2019 15:20:56 -0000
Content-Transfer-Encoding: 8bit

Its useful, particularly in the local developer model of usage, for
bitbake to start and stop a hash equivalence server on local port,
rather than relying on one being started by the user before the build.

The new BB_HASHSERVE variable supports this.

The database handling is moved internally into the hashserv code so that
different threads/processes can be used for the server without errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-hashserv     |  4 +---
 bin/bitbake-worker       |  1 +
 lib/bb/cooker.py         | 15 ++++++++++++++-
 lib/bb/runqueue.py       |  1 +
 lib/hashserv/__init__.py | 19 ++++++++++++++++---
 lib/hashserv/tests.py    |  7 ++++---
 6 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 848a0ca39f..6c911c098a 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -41,9 +41,7 @@ def main():
     console.setLevel(level)
     logger.addHandler(console)
 
-    db = sqlite3.connect(args.database)
-
-    server = hashserv.create_server((args.address, args.port), db, args.prefix)
+    server = hashserv.create_server((args.address, args.port), args.database, args.prefix)
     server.serve_forever()
     return 0
 
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 3e502d5ca9..96369199f2 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -418,6 +418,7 @@ class BitbakeWorker(object):
         bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
         for mc in self.databuilder.mcdata:
             self.databuilder.mcdata[mc].setVar("PRSERV_HOST", self.workerdata["prhost"])
+            self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.workerdata["hashservport"])
 
     def handle_newtaskhashes(self, data):
         self.workerdata["newhashes"] = pickle.loads(data)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b4851e13ed..84f25ec94e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -31,6 +31,7 @@ import pyinotify
 import json
 import pickle
 import codecs
+import hashserv
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")
@@ -230,6 +231,8 @@ class BBCooker:
         self.state = state.initial
 
         self.parser = None
+        self.hashserv = None
+        self.hashservport = None
 
         signal.signal(signal.SIGTERM, self.sigterm_exception)
         # Let SIGHUP exit as SIGTERM
@@ -368,6 +371,15 @@ class BBCooker:
 
         self.data.setVar('BB_CMDLINE', self.ui_cmdline)
 
+        if self.data.getVar("BB_HASHSERVE") == "localhost:0":
+            dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
+            self.hashserv = hashserv.create_server(('localhost', 0), dbfile, '')
+            self.hashservport = "localhost:" + str(self.hashserv.server_port)
+            thread = threading.Thread(target=self.hashserv.serve_forever)
+            thread.daemon = True
+            thread.start()
+            self.data.setVar("BB_HASHSERVE", self.hashservport)
+
         #
         # Copy of the data store which has been expanded.
         # Used for firing events and accessing variables where expansion needs to be accounted for
@@ -1645,9 +1657,10 @@ class BBCooker:
 
     def post_serve(self):
         prserv.serv.auto_shutdown()
+        if self.hashserv:
+            self.hashserv.shutdown()
         bb.event.fire(CookerExit(), self.data)
 
-
     def shutdown(self, force = False):
         if force:
             self.state = state.forceshutdown
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 5b44df8188..8b9cb688fd 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1254,6 +1254,7 @@ class RunQueue:
             "buildname" : self.cfgData.getVar("BUILDNAME"),
             "date" : self.cfgData.getVar("DATE"),
             "time" : self.cfgData.getVar("TIME"),
+            "hashservport" : self.cooker.hashservport,
         }
 
         worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 768c5504cf..7ec9b64419 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -18,8 +18,15 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
     def log_message(self, f, *args):
         logger.debug(f, *args)
 
+    def opendb(self):
+        self.db = sqlite3.connect(self.dbname)
+        self.db.row_factory = sqlite3.Row
+
     def do_GET(self):
         try:
+            if not self.db:
+                self.opendb()
+
             p = urllib.parse.urlparse(self.path)
 
             if p.path != self.prefix + '/v1/equivalent':
@@ -52,6 +59,9 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
 
     def do_POST(self):
         try:
+            if not self.db:
+                self.opendb()
+
             p = urllib.parse.urlparse(self.path)
 
             if p.path != self.prefix + '/v1/equivalent':
@@ -123,14 +133,17 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
             self.send_error(400, explain=traceback.format_exc())
             return
 
-def create_server(addr, db, prefix=''):
+def create_server(addr, dbname, prefix=''):
     class Handler(HashEquivalenceServer):
         pass
 
-    Handler.prefix = prefix
-    Handler.db = db
+    db = sqlite3.connect(dbname)
     db.row_factory = sqlite3.Row
 
+    Handler.prefix = prefix
+    Handler.db = None
+    Handler.dbname = dbname
+
     with contextlib.closing(db.cursor()) as cursor:
         cursor.execute('''
             CREATE TABLE IF NOT EXISTS tasks_v2 (
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 8300a25599..15f4a52ee9 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -11,14 +11,15 @@ import sqlite3
 import hashlib
 import urllib.request
 import json
+import tempfile
 from . import create_server
 
 class TestHashEquivalenceServer(unittest.TestCase):
     def setUp(self):
-        # Start an in memory hash equivalence server in the background bound to
+        # Start a hash equivalence server in the background bound to
         # an ephemeral port
-        db = sqlite3.connect(':memory:', check_same_thread=False)
-        self.server = create_server(('localhost', 0), db)
+        self.dbfile = tempfile.NamedTemporaryFile(prefix="bb-hashserv-db-")
+        self.server = create_server(('localhost', 0), self.dbfile.name)
         self.server_addr = 'http://localhost:%d' % self.server.socket.getsockname()[1]
         self.server_thread = threading.Thread(target=self.server.serve_forever)
         self.server_thread.start()
-- 
2.20.1


