Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EA6C04FFF
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 17:20:35 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.26822.1713288031509713527
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Apr 2024 10:20:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MYy7B3gc;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02111C0003;
	Tue, 16 Apr 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713288029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yQJvOfQ/6vrQQVd7/KDMS1SG+Q6EOYOjHhCb6ZK0mE=;
	b=MYy7B3gcfdqGEc5icfN5pFSf6iWLXz+qEoKC4V3zVQchZo2FT4jmVe+naMgKnmNhHxyNOj
	gHZPZJQUjuTNnUG28ahaVFObv/jeysOtvLkL2yyULz5aO+hVPPJB3sh1w3Mg8xsd8/s7uV
	exVV3kQ1EPdEERs9TBpQdwGLitoklyle6uRI5DeR26LRrI794+wMRYdlORJyP3Bc7zX3Sb
	sZEX9A8uyUiQWxsHGB6juBOnwQ5IM074iwX+nuubpc8OalmnkB8y/45ONDYdZXBNIjCB0v
	2LfK+CnkeDn3HRMSS9ES5oudAb9eeJm/GFQPecjqhByKfo/EgUYJ/hxRSlFJ/w==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [RFC][PATCH 3/3] prserv: start bitbake selftests
Date: Tue, 16 Apr 2024 19:19:45 +0200
Message-Id: <20240416171945.3799445-4-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
References: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Apr 2024 17:20:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16101

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
CC: Joshua Watt <JPEWhacker@gmail.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-selftest   |  2 +
 lib/prserv/__init__.py | 24 ++++++++++++
 lib/prserv/tests.py    | 84 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 bitbake/lib/prserv/tests.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index f25f23b1ae..ce901232fe 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -15,6 +15,7 @@ import unittest
 try:
     import bb
     import hashserv
+    import prserv
     import layerindexlib
 except RuntimeError as exc:
     sys.exit(str(exc))
@@ -33,6 +34,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.utils",
          "bb.tests.compression",
          "hashserv.tests",
+         "prserv.tests",
          "layerindexlib.tests.layerindexobj",
          "layerindexlib.tests.restapi",
          "layerindexlib.tests.cooker"]
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index 2ee6a28c04..76041f9001 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -20,6 +20,30 @@ def init_logger(logfile, loglevel):
 class NotFoundError(Exception):
     pass
 
+def create_server(addr, dbpath, upstream=None, read_only=False):
+    from . import serv
+
+    s = serv.PRServer(dbpath, upstream=upstream, read_only=read_only)
+
+    (typ, a) = parse_address(addr)
+    s.start_tcp_server(*a)
+
+    return s
+
+def create_client(addr):
+    from . import client
+
+    c = client.PRClient()
+
+    try:
+        (typ, a) = parse_address(addr)
+        c.connect_tcp(*a)
+        print("CLIENT CONNECTED TO: %s" %(addr))
+        return c
+    except Exception as e:
+        c.close()
+        raise e
+
 async def create_async_client(addr):
     from . import client
 
diff --git a/lib/prserv/tests.py b/lib/prserv/tests.py
new file mode 100644
index 0000000000..1e3b63913b
--- /dev/null
+++ b/lib/prserv/tests.py
@@ -0,0 +1,84 @@
+#! /usr/bin/env python3
+#
+# Copyright (C) 2024 BitBake Contributors
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+from . import create_server, create_client
+import sys
+import tempfile
+import unittest
+import socket
+from pathlib import Path
+
+THIS_DIR = Path(__file__).parent
+BIN_DIR = THIS_DIR.parent.parent / "bin"
+
+def server_prefunc(server, idx):
+    logging.basicConfig(level=logging.DEBUG, filename='bbprserv-%d.log' % idx, filemode='w',
+                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
+    server.logger.debug("Running server %d" % idx)
+    sys.stdout = open('bbprserv-stdout-%d.log' % idx, 'w')
+    sys.stderr = sys.stdout
+
+class PRTestSetup(object):
+
+    server_index = 0
+    client_index = 0
+
+    def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc):
+
+        self.server_index += 1
+
+        if dbpath is None:
+            dbpath = self.make_dbpath()
+
+        def cleanup_server(server):
+            if server.process.exitcode is not None:
+                return
+
+            server.process.terminate()
+            server.process.join()
+
+        server = create_server(socket.gethostbyname("localhost") + ":0",
+                               dbpath,
+                               upstream=upstream,
+                               read_only=read_only)
+
+        server.serve_as_process(prefunc=prefunc, args=(self.server_index))
+        self.addCleanup(cleanup_server, server)
+
+        return server
+
+    def make_dbpath(self):
+        return os.path.join(self.temp_dir.name, "prserv-test%d.sqlite3" % self.server_index)
+
+    def start_client(self, server_address):
+        def cleanup_client(client):
+            client.close()
+
+        client = create_client(server_address)
+        self.addCleanup(cleanup_client, client)
+
+        return client
+
+    def start_test_server(self):
+        self.server = self.start_server()
+        print("SERVER STARTED WITH ADDRESS: %s" % (self.server.address))
+        return self.server.address
+
+    def setUp(self):
+        self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-prserv-test')
+        self.addCleanup(self.temp_dir.cleanup)
+
+        self.server_address = self.start_test_server()
+        self.client = self.start_client(self.server_address)
+
+class PRCommonTests(PRTestSetup, unittest.TestCase):
+
+    def test_create_pr(self):
+        result = self.client.test_pr("dummy-1.0-r0", "core2-64", "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a5")
+        return self.assertEqual(result, None)
+
+
-- 
2.34.1


