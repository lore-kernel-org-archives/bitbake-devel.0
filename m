Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f170.google.com (mail-it1-f170.google.com
	[209.85.166.170])
	by mail.openembedded.org (Postfix) with ESMTP id 717627BE2D;
	Fri,  4 Jan 2019 16:20:28 +0000 (UTC)
Received: by mail-it1-f170.google.com with SMTP id p197so2167339itp.0;
	Fri, 04 Jan 2019 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2ct5EP618wMJIyxWAo+AHNXaf4lAgPz3EI31xBVwSVc=;
	b=HmlUvqafYChOTQ2x2jspT4qQ/L9C9OBDowW4Nu3XeINuwMn83IyTp+4veZGvBJZyt0
	i83Es43MDnWAI0QBJGhE73ZdTdq6ely5WL1KrzQ1jYzGVpb+45M47ZFz/k1/vKe7SYIh
	ReejzSgrzrExUMmi9er+mCu1QcUptY/NIAJqzEqRL9A6jnruZIFWrW7Xqu+f19hiuYx6
	GmN76BujD1mCDzReYtECtTEYxIlJ57jhgrSXdANEBdORxShYYOxD0pZNOg8GFvZgqv67
	ajOhvhPzHejw5aLpQwp4cHimm4kpnD80aa7HagyQUa99B67PhnJMNuMAK7Pb0UHLattC
	2bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2ct5EP618wMJIyxWAo+AHNXaf4lAgPz3EI31xBVwSVc=;
	b=ucO1bC+2hLsoZ0ijWmrbOtGbCewruphVVbUklAyK4v6vwZZ6t60oTm34MhqfUBjZXK
	ASRmq8fa4JflRABffIPiGOKp6a7UtG9frQfQC78eQlXbc3Bs17XurVS7LF9+r77FnBdK
	gccjKBWNH51xXBj0AZfOIBHMs+1x7Ji/glp4gHwaB8EDBCOXUoLYHNI05+E3XsnRlHer
	AQVnnPTltZc5rkmEbxT/viJC1XQTXNb1/gvMJ+I02BQjSDIVxiEzokPrkNiSckOJIILp
	xpzl/IGj4pjkUY3bFkps3qBHza3v9PJ12KclpfaEkwmoo2zHO8XpNpyVhJumSblilqMg
	GF/g==
X-Gm-Message-State: AJcUukeGdIG+RINQhcnlq1+50cBAfGuzVWK//xAKEK9oHfQY6Mk8TiOZ
	hrIglRPdeUuoIIvOWJ2jhp9Nx1Ik
X-Google-Smtp-Source: ALg8bN7Wei6Qd3JJ9caMJFCTQgyzlIEchCaVv2Zc6+YV3/XTnscQUADAtVCCnzQVlJ6fEI4M7z0f5w==
X-Received: by 2002:a24:7e8c:: with SMTP id h134mr1304708itc.130.1546618828764;
	Fri, 04 Jan 2019 08:20:28 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id j8sm736702itb.30.2019.01.04.08.20.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 04 Jan 2019 08:20:27 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jan 2019 10:20:14 -0600
Message-Id: <20190104162015.456-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104162015.456-1-JPEWhacker@gmail.com>
References: <20190104024217.3316-1-JPEWhacker@gmail.com>
	<20190104162015.456-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v7 2/3] bitbake: hashserv: Add hash equivalence reference server
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
X-List-Received-Date: Fri, 04 Jan 2019 16:20:28 -0000
Content-Transfer-Encoding: 8bit

Implements a reference implementation of the hash equivalence server.
This server has minimal dependencies (and no dependencies outside of the
standard Python library), and implements the minimum required to be a
conforming hash equivalence server.

[YOCTO #13030]

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
index c970dcae90c..99f1af910f4 100755
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
@@ -35,6 +36,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.parse",
          "bb.tests.persist_data",
          "bb.tests.utils",
+         "hashserv.tests",
          "layerindexlib.tests.layerindexobj",
          "layerindexlib.tests.restapi",
          "layerindexlib.tests.cooker"]
diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
new file mode 100644
index 00000000000..46bca7cab32
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
+                cursor.execute('SELECT taskhash, method, unihash FROM tasks_v1 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1',
+                        {'method': method, 'taskhash': taskhash})
+
+                row = cursor.fetchone()
+
+                if row is not None:
+                    logger.debug('Found equivalent task %s', row['taskhash'])
+                    d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
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
+                    SELECT taskhash, method, unihash FROM tasks_v1 WHERE method=:method AND outhash=:outhash
+                    ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
+                        created ASC
+                    LIMIT 1
+                    ''', {k: data[k] for k in ('method', 'outhash', 'taskhash')})
+
+                row = cursor.fetchone()
+
+                if row is None or row['taskhash'] != data['taskhash']:
+                    unihash = data['unihash']
+                    if row is not None:
+                        unihash = row['unihash']
+
+                    insert_data = {
+                            'method': data['method'],
+                            'outhash': data['outhash'],
+                            'taskhash': data['taskhash'],
+                            'unihash': unihash,
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
+                    logger.info('Adding taskhash %s with unihash %s', data['taskhash'], unihash)
+                    cursor.execute('SELECT taskhash, method, unihash FROM tasks_v1 WHERE id=:id', {'id': cursor.lastrowid})
+                    row = cursor.fetchone()
+
+                    self.db.commit()
+
+                d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
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
+                unihash TEXT NOT NULL,
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
index 00000000000..806b54c5ebd
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
+        unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+
+        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
+        self.assertIsNone(d, msg='Found unexpected task, %r' % d)
+
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash,
+            'unihash': unihash,
+            })
+        self.assertEqual(d['unihash'], unihash, 'Server returned bad unihash')
+
+    def test_create_equivalent(self):
+        # Tests that a second reported task with the same outhash will be
+        # assigned the same unihash
+        taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
+        outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
+        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash,
+            'unihash': unihash,
+            })
+        self.assertEqual(d['unihash'], unihash, 'Server returned bad unihash')
+
+        # Report a different task with the same outhash. The returned unihash
+        # should match the first task
+        taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
+        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash2,
+            'method': 'TestMethod',
+            'outhash': outhash,
+            'unihash': unihash2,
+            })
+        self.assertEqual(d['unihash'], unihash, 'Server returned bad unihash')
+
+    def test_duplicate_taskhash(self):
+        # Tests that duplicate reports of the same taskhash with different
+        # outhash & unihash always return the unihash from the first reported
+        # taskhash
+        taskhash = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
+        outhash = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
+        unihash = '218e57509998197d570e2c98512d0105985dffc9'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash,
+            'unihash': unihash,
+            })
+
+        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
+        self.assertEqual(d['unihash'], unihash)
+
+        outhash2 = '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d'
+        unihash2 = 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash2,
+            'unihash': unihash2
+            })
+
+        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
+        self.assertEqual(d['unihash'], unihash)
+
+        outhash3 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
+        unihash3 = '9217a7d6398518e5dc002ed58f2cbbbc78696603'
+        d = self.send_post('v1/equivalent', {
+            'taskhash': taskhash,
+            'method': 'TestMethod',
+            'outhash': outhash3,
+            'unihash': unihash3
+            })
+
+        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
+        self.assertEqual(d['unihash'], unihash)
+
+
-- 
2.20.1


