Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com
	[209.85.214.45])
	by mail.openembedded.org (Postfix) with ESMTP id 45E0B78E35;
	Thu,  9 Aug 2018 22:10:55 +0000 (UTC)
Received: by mail-it0-f45.google.com with SMTP id h23-v6so130757ita.5;
	Thu, 09 Aug 2018 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jwhAzdG0GqxwfET69sy1g9wOq/vpGem0F1cn+ewYNXc=;
	b=gQgTBP/57Gsi51vAnDa+SFXpVKavgBqaqH3XMTn6NbMo32GWaHxHskk0pqrPEY1dTH
	VhuKXrxlMuNZ5gD+5yUkKsa7J/JhNnSZa2pyJCSXKjmGhRUVcKAxn+wn2r7sOf5v35ZE
	Nw70Fy2Y/T6t15oC+imwuN3gM3mpSlhQe1o10SbUjpqRAt+7zkG3dlfZ3CpA0IlnMP3t
	rtvxKpQdMAiIrymWAlfnER/F1FOMwAHDt+XpCjhOkib0oNiKrnWH5yQS3Q0Pv1p2jEaO
	y9eOZPueD7fyp/ijZhG8fC6lgzgvveyPIjnd+gRtq7e/6pjWPsQ0fedUGgSV7qQNkPWx
	Q+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jwhAzdG0GqxwfET69sy1g9wOq/vpGem0F1cn+ewYNXc=;
	b=huHrvuu+xnyx9c8BAzADnpMECqjKPzmVxN83J095ZRfH0a+f3hhXr55OID49M5SuOp
	aIOHJ6MfPs6WEbC0qywiihB48YdRb5xjH6BWAp3Ewcj2Smy40+hweq325xAusB5BUKWw
	NYH68O9nVAU3S1Vq9i6VhNFk8Bai1zUNbHb7Zy6mgcYT/ehdbib8/sJQQk9WhHjSivOE
	X3vhCHNFlUMJUPWQCANU+NbIEouNnIoHlN+R/d1fO5chZfnI24MkuWOomNcbLVEjKqhW
	A3ivSSVwUWKwwg1jYlMlvYF/DlW2nk/otVR0bT5N2Zk12o6CD9ufOnBgTtoW85nO6lTn
	VBew==
X-Gm-Message-State: AOUpUlHkOzB/lnrhd63czxIDJizibZ8ZrmCWy4drh+Ux9slKmpxmbl+I
	IC51D3xuoXtoZetHHItVJmHDJtJy
X-Google-Smtp-Source: AA+uWPzI/fbKeLkb/SnbYVuQiQSufMp0xqXbssTXJWQjrkTpmy8fP9jxia5/HzBXYVpBEagUDU5qzA==
X-Received: by 2002:a24:8745:: with SMTP id f66-v6mr89116ite.87.1533852656074; 
	Thu, 09 Aug 2018 15:10:56 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:39 -0500
Message-Id: <20180809220840.26697-16-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 15/16] bitbake: hashserv: Add hash equivalence reference server
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:55 -0000

Implements a reference implementation of the hash equivalence server.
This server has minimal dependencies (and no dependencies outside of the
standard Python library), and implements the minimum required to be a
conforming hash equivalence server.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashserv     |  67 ++++++++++++++
 bitbake/bin/bitbake-selftest     |   2 +
 bitbake/lib/hashserv/__init__.py | 152 +++++++++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py    | 141 ++++++++++++++++++++++++++++
 4 files changed, 362 insertions(+)
 create mode 100755 bitbake/bin/bitbake-hashserv
 create mode 100644 bitbake/lib/hashserv/__init__.py
 create mode 100644 bitbake/lib/hashserv/tests.py

diff --git a/bitbake/bin/bitbake-hashserv b/bitbake/bin/bitbake-hashserv
new file mode 100755
index 00000000000..c49397b73a5
--- /dev/null
+++ b/bitbake/bin/bitbake-hashserv
@@ -0,0 +1,67 @@
+#! /usr/bin/env python3
+#
+# Copyright (C) 2018 Garmin Ltd.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+import os
+import sys
+import logging
+import argparse
+import sqlite3
+
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),'lib'))
+
+import hashserv
+
+VERSION = "1.0.0"
+
+DEFAULT_HOST = ''
+DEFAULT_PORT = 8686
+
+def main():
+    parser = argparse.ArgumentParser(description='HTTP Equivalence Reference Server. Version=%s' % VERSION)
+    parser.add_argument('--address', default=DEFAULT_HOST, help='Bind address (default "%(default)s")')
+    parser.add_argument('--port', type=int, default=DEFAULT_PORT, help='Bind port (default %(default)d)')
+    parser.add_argument('--prefix', default='', help='HTTP path prefix (default "%(default)s")')
+    parser.add_argument('--database', default='./hashserv.db', help='Database file (default "%(default)s")')
+    parser.add_argument('--log', default='WARNING', help='Set logging level')
+
+    args = parser.parse_args()
+
+    logger = logging.getLogger('hashserv')
+
+    level = getattr(logging, args.log.upper(), None)
+    if not isinstance(level, int):
+        raise ValueError('Invalid log level: %s' % args.log)
+
+    logger.setLevel(level)
+    console = logging.StreamHandler()
+    console.setLevel(level)
+    logger.addHandler(console)
+
+    db = sqlite3.connect(args.database)
+
+    server = hashserv.create_server((args.address, args.port), db, args.prefix)
+    server.serve_forever()
+    return 0
+
+if __name__ == '__main__':
+    try:
+        ret = main()
+    except Exception:
+        ret = 1
+        import traceback
+        traceback.print_exc()
+    sys.exit(ret)
+
diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index 06a1c9a78dd..de1f8f74dda 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
@@ -22,6 +22,7 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib
 import unittest
 try:
     import bb
+    import hashserv
     import layerindexlib
 except RuntimeError as exc:
     sys.exit(str(exc))
@@ -34,6 +35,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.parse",
          "bb.tests.persist_data",
          "bb.tests.utils",
+         "hashserv.tests",
          "layerindexlib.tests.layerindexobj",
          "layerindexlib.tests.restapi",
          "layerindexlib.tests.cooker"]
diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
new file mode 100644
index 00000000000..cde030cb88e
--- /dev/null
+++ b/bitbake/lib/hashserv/__init__.py
@@ -0,0 +1,152 @@
+# Copyright (C) 2018 Garmin Ltd.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from http.server import BaseHTTPRequestHandler, HTTPServer
+import contextlib
+import urllib.parse
+import sqlite3
+import json
+import traceback
+import logging
+from datetime import datetime
+
+logger = logging.getLogger('hashserv')
+
+class HashEquivalenceServer(BaseHTTPRequestHandler):
+    def log_message(self, f, *args):
+        logger.debug(f, *args)
+
+    def do_GET(self):
+        try:
+            p = urllib.parse.urlparse(self.path)
+
+            if p.path != self.prefix + '/v1/equivalent':
+                self.send_error(404)
+                return
+
+            query = urllib.parse.parse_qs(p.query, strict_parsing=True)
+            method = query['method'][0]
+            taskhash = query['taskhash'][0]
+
+            d = None
+            with contextlib.closing(self.db.cursor()) as cursor:
+                cursor.execute('SELECT taskhash, method, depid FROM tasks_v1 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1',
+                        {'method': method, 'taskhash': taskhash})
+
+                row = cursor.fetchone()
+
+                if row is not None:
+                    logger.debug('Found equivalent task %s', row['taskhash'])
+                    d = {k: row[k] for k in ('taskhash', 'method', 'depid')}
+
+            self.send_response(200)
+            self.send_header('Content-Type', 'application/json; charset=utf-8')
+            self.end_headers()
+            self.wfile.write(json.dumps(d).encode('utf-8'))
+        except:
+            logger.exception('Error in GET')
+            self.send_error(400, explain=traceback.format_exc())
+            return
+
+    def do_POST(self):
+        try:
+            p = urllib.parse.urlparse(self.path)
+
+            if p.path != self.prefix + '/v1/equivalent':
+                self.send_error(404)
+                return
+
+            length = int(self.headers['content-length'])
+            data = json.loads(self.rfile.read(length).decode('utf-8'))
+
+            with contextlib.closing(self.db.cursor()) as cursor:
+                cursor.execute('''
+                    SELECT taskhash, method, depid FROM tasks_v1 WHERE method=:method AND outhash=:outhash
+                    ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
+                        created ASC
+                    LIMIT 1
+                    ''', {k: data[k] for k in ('method', 'outhash', 'taskhash')})
+
+                row = cursor.fetchone()
+
+                if row is None or row['taskhash'] != data['taskhash']:
+                    depid = data['depid']
+                    if row is not None:
+                        depid = row['depid']
+
+                    insert_data = {
+                            'method': data['method'],
+                            'outhash': data['outhash'],
+                            'taskhash': data['taskhash'],
+                            'depid': depid,
+                            'created': datetime.now()
+                            }
+
+                    for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
+                        if k in data:
+                            insert_data[k] = data[k]
+
+                    cursor.execute('''INSERT INTO tasks_v1 (%s) VALUES (%s)''' % (
+                            ', '.join(sorted(insert_data.keys())),
+                            ', '.join(':' + k for k in sorted(insert_data.keys()))),
+                        insert_data)
+
+                    logger.info('Adding taskhash %s with depid %s', data['taskhash'], depid)
+                    cursor.execute('SELECT taskhash, method, depid FROM tasks_v1 WHERE id=:id', {'id': cursor.lastrowid})
+                    row = cursor.fetchone()
+
+                    self.db.commit()
+
+                d = {k: row[k] for k in ('taskhash', 'method', 'depid')}
+
+                self.send_response(200)
+                self.send_header('Content-Type', 'application/json; charset=utf-8')
+                self.end_headers()
+                self.wfile.write(json.dumps(d).encode('utf-8'))
+        except:
+            logger.exception('Error in POST')
+            self.send_error(400, explain=traceback.format_exc())
+            return
+
+def create_server(addr, db, prefix=''):
+    class Handler(HashEquivalenceServer):
+        pass
+
+    Handler.prefix = prefix
+    Handler.db = db
+    db.row_factory = sqlite3.Row
+
+    with contextlib.closing(db.cursor()) as cursor:
+        cursor.execute('''
+            CREATE TABLE IF NOT EXISTS tasks_v1 (
+                id INTEGER PRIMARY KEY AUTOINCREMENT,
+                method TEXT NOT NULL,
+                outhash TEXT NOT NULL,
+                taskhash TEXT NOT NULL,
+                depid TEXT NOT NULL,
+                created DATETIME,
+
+                -- Optional fields
+                owner TEXT,
+                PN TEXT,
+                PV TEXT,
+                PR TEXT,
+                task TEXT,
+                outhash_siginfo TEXT
+                )
+            ''')
+
+    logger.info('Starting server on %s', addr)
+    return HTTPServer(addr, Handler)
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
new file mode 100644
index 00000000000..7efb1fce0bc
--- /dev/null
+++ b/bitbake/lib/hashserv/tests.py
@@ -0,0 +1,141 @@
+#! /usr/bin/env python3
+#
+# Copyright (C) 2018 Garmin Ltd.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import unittest
+import threading
+import sqlite3
+import hashlib
+import urllib.request
+import json
+from . import create_server
+
+class TestHashEquivalenceServer(unittest.TestCase):
+    def setUp(self):
+        # Start an in memory hash equivalence server in the background bound to
+        # an ephemeral port
+        db = sqlite3.connect(':memory:', check_same_thread=False)
+        self.server = create_server(('localhost', 0), db)
+        self.server_addr = 'http://localhost:%d' % self.server.socket.getsockname()[1]
+        self.server_thread = threading.Thread(target=self.server.serve_forever)
+        self.server_thread.start()
+
+    def tearDown(self):
+        # Shutdown server
+        s = getattr(self, 'server', None)
+        if s is not None:
+            self.server.shutdown()
+            self.server_thread.join()
+            self.server.server_close()
+
+    def send_get(self, path):
+        url = '%s/%s' % (self.server_addr, path)
+        request = urllib.request.Request(url)
+        response = urllib.request.urlopen(request)
+        return json.loads(response.read().decode('utf-8'))
+
+    def send_post(self, path, data):
+        headers = {'content-type': 'application/json'}
+        url = '%s/%s' % (self.server_addr, path)
+        request = urllib.request.Request(url, json.dumps(data).encode('utf-8'), headers)
+        response = urllib.request.urlopen(request)
+        return json.loads(response.read().decode('utf-8'))
+
+    def test_create_hash(self):
+        # Simple test that hashes can be created
+        taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
+        outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
+        depid = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+
+        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
+        self.assertIsNone(d, msg='Found unexpected task, %r' % d)
+
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash,
+            'depid': depid,
+            })
+        self.assertEqual(d['depid'], depid, 'Server returned bad depid')
+
+    def test_create_equivalent(self):
+        # Tests that a second reported task with the same outhash will be
+        # assigned the same depid
+        taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
+        outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
+        depid = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash,
+            'depid': depid,
+            })
+        self.assertEqual(d['depid'], depid, 'Server returned bad depid')
+
+        # Report a different task with the same outhash. The returned depid
+        # should match the first task
+        taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
+        depid2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash2,
+            'method': 'TestMethod',
+            'outhash': outhash,
+            'depid': depid2,
+            })
+        self.assertEqual(d['depid'], depid, 'Server returned bad depid')
+
+    def test_duplicate_taskhash(self):
+        # Tests that duplicate reports of the same taskhash with different
+        # outhash & depid always return the depid from the first reported
+        # taskhash
+        taskhash = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
+        outhash = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
+        depid = '218e57509998197d570e2c98512d0105985dffc9'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash,
+            'depid': depid,
+            })
+
+        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
+        self.assertEqual(d['depid'], depid)
+
+        outhash2 = '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d'
+        depid2 = 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash2,
+            'depid': depid2
+            })
+
+        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
+        self.assertEqual(d['depid'], depid)
+
+        outhash3 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
+        depid3 = '9217a7d6398518e5dc002ed58f2cbbbc78696603'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash3,
+            'depid': depid3
+            })
+
+        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
+        self.assertEqual(d['depid'], depid)
+
+
-- 
2.17.1


