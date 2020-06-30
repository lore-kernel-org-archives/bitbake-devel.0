Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.7695.1593486544934697255
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 20:09:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Uw8kIlJa;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.41, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f41.google.com with SMTP id cv18so3654655pjb.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2020 20:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=w11h1tCZUeHST3+45DUTGNzdndm08lSDLwlQvD298tc=;
        b=Uw8kIlJa89lri1wJsHCtOSk+vNLGtWnWnG6e29/0VV5SONiwvxYWC5BszMiBv+36im
         aJ+2R9d0itbMP6bWCuUDbhQnEhwp4nIKMQgE7spBdtQ/tYecDZMCqS+3f+Imn9xIBzIq
         mIB2EefmRAoNAWd8VY8Szro3ES/8AF1oduQnHTnMOyDx22qd4Wo2NV9Dg7C6biLRFVCf
         xtCVKFX140yApQxvKR3rUXT+3UvpK2FnMe9LywvGsofW7MWztzyJfkH/gmsOiNFyhNtl
         VacZPrHwm/GSa1/J8Dl1eQn5pJHqZMgmpb2J6LuCE2+69R1Nh6AYq78/W+JbfALtYQji
         Mt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=w11h1tCZUeHST3+45DUTGNzdndm08lSDLwlQvD298tc=;
        b=Qc2QvkhQO/gpMpn+5UGylbszoBo7+vJZjrFgDGBbtGm8J5tmGz70hyMf4CZc65Rg4A
         4nlCjGb5M/ZCABoXWmdmVkTqvYNwQ48f/yD+aXChDZDgWQ5LnxRjrPj+rTfH5gzf00bx
         Njg/QaVAFyFa+Z5gyQSD84g7idWDZU9OzOM9sKZOki7GVJNajpB+oOoGF5K/wqMTK4Vq
         UcC0pfgwN5VxG7khOB0pksDHstF3oFzGydryz+xBW4BhfFYl3axV5j3HBDXMdjZ8qta4
         rWNG+pLtYkEvtZLhABSjAgDGVO5cZcE6X3OFDR9cYO2QTXbLVFKOqRKcjOYj9rkBuxDY
         26oA==
X-Gm-Message-State: AOAM5304Yflc/hpU7uz8hxmN2SkG1/IuAHKFZD6naK/zPGz8fAjsBDqZ
	oM9Es1Ne0AaxMLMixCiyrbelL+pdaY0IJg==
X-Google-Smtp-Source: ABdhPJwihyEen0chesJR5rQVQN38c1n0GZzywHUR1vFVp1lEBMCbTX2DTK/6XyJSi2p5sq26zSD1ew==
X-Received: by 2002:a17:90a:a406:: with SMTP id y6mr21797472pjp.216.1593486543746;
        Mon, 29 Jun 2020 20:09:03 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com ([99.197.43.113])
        by smtp.gmail.com with ESMTPSA id n14sm970933pgd.78.2020.06.29.20.08.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 20:09:03 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/6] hashserv: Chunkify large messages
Date: Mon, 29 Jun 2020 17:08:23 -1000
Message-Id: <224ed6abbfa7b9c2d968fbbb75cc0dc6a3129813.1593486375.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593486375.git.steve@sakoman.com>
References: <cover.1593486375.git.steve@sakoman.com>

From: Joshua Watt <JPEWhacker@gmail.com>

The hash equivalence client and server can occasionally send messages
that are too large for the server to fit in the receive buffer (64 KB).
To prevent this, support is added to the protocol to "chunkify" the
stream and break it up into manageable pieces that the server can each
side can back together.

Ideally, this would be negotiated by the client and server, but it's
currently hard coded to 32 KB to prevent the round-trip delay.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e27a28c1e40e886ee68ba4b99b537ffc9c3577d4)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/hashserv/__init__.py |  22 ++++++++
 lib/hashserv/client.py   |  43 +++++++++++++---
 lib/hashserv/server.py   | 105 +++++++++++++++++++++++++++------------
 lib/hashserv/tests.py    |  23 +++++++++
 4 files changed, 152 insertions(+), 41 deletions(-)

diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index c3318620..f95e8f43 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -6,12 +6,20 @@
 from contextlib import closing
 import re
 import sqlite3
+import itertools
+import json
 
 UNIX_PREFIX = "unix://"
 
 ADDR_TYPE_UNIX = 0
 ADDR_TYPE_TCP = 1
 
+# The Python async server defaults to a 64K receive buffer, so we hardcode our
+# maximum chunk size. It would be better if the client and server reported to
+# each other what the maximum chunk sizes were, but that will slow down the
+# connection setup with a round trip delay so I'd rather not do that unless it
+# is necessary
+DEFAULT_MAX_CHUNK = 32 * 1024
 
 def setup_database(database, sync=True):
     db = sqlite3.connect(database)
@@ -66,6 +74,20 @@ def parse_address(addr):
         return (ADDR_TYPE_TCP, (host, int(port)))
 
 
+def chunkify(msg, max_chunk):
+    if len(msg) < max_chunk - 1:
+        yield ''.join((msg, "\n"))
+    else:
+        yield ''.join((json.dumps({
+                'chunk-stream': None
+            }), "\n"))
+
+        args = [iter(msg)] * (max_chunk - 1)
+        for m in map(''.join, itertools.zip_longest(*args, fillvalue='')):
+            yield ''.join(itertools.chain(m, "\n"))
+        yield "\n"
+
+
 def create_server(addr, dbname, *, sync=True):
     from . import server
     db = setup_database(dbname, sync=sync)
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 46085d64..a29af836 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -7,6 +7,7 @@ import json
 import logging
 import socket
 import os
+from . import chunkify, DEFAULT_MAX_CHUNK
 
 
 logger = logging.getLogger('hashserv.client')
@@ -25,6 +26,7 @@ class Client(object):
         self.reader = None
         self.writer = None
         self.mode = self.MODE_NORMAL
+        self.max_chunk = DEFAULT_MAX_CHUNK
 
     def connect_tcp(self, address, port):
         def connect_sock():
@@ -58,7 +60,7 @@ class Client(object):
             self.reader = self._socket.makefile('r', encoding='utf-8')
             self.writer = self._socket.makefile('w', encoding='utf-8')
 
-            self.writer.write('OEHASHEQUIV 1.0\n\n')
+            self.writer.write('OEHASHEQUIV 1.1\n\n')
             self.writer.flush()
 
             # Restore mode if the socket is being re-created
@@ -91,18 +93,35 @@ class Client(object):
                 count += 1
 
     def send_message(self, msg):
+        def get_line():
+            line = self.reader.readline()
+            if not line:
+                raise HashConnectionError('Connection closed')
+
+            if not line.endswith('\n'):
+                raise HashConnectionError('Bad message %r' % message)
+
+            return line
+
         def proc():
-            self.writer.write('%s\n' % json.dumps(msg))
+            for c in chunkify(json.dumps(msg), self.max_chunk):
+                self.writer.write(c)
             self.writer.flush()
 
-            l = self.reader.readline()
-            if not l:
-                raise HashConnectionError('Connection closed')
+            l = get_line()
 
-            if not l.endswith('\n'):
-                raise HashConnectionError('Bad message %r' % message)
+            m = json.loads(l)
+            if 'chunk-stream' in m:
+                lines = []
+                while True:
+                    l = get_line().rstrip('\n')
+                    if not l:
+                        break
+                    lines.append(l)
 
-            return json.loads(l)
+                m = json.loads(''.join(lines))
+
+            return m
 
         return self._send_wrapper(proc)
 
@@ -155,6 +174,14 @@ class Client(object):
         m['unihash'] = unihash
         return self.send_message({'report-equiv': m})
 
+    def get_taskhash(self, method, taskhash, all_properties=False):
+        self._set_mode(self.MODE_NORMAL)
+        return self.send_message({'get': {
+            'taskhash': taskhash,
+            'method': method,
+            'all': all_properties
+        }})
+
     def get_stats(self):
         self._set_mode(self.MODE_NORMAL)
         return self.send_message({'get-stats': None})
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index cc7e4823..81050715 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -13,6 +13,7 @@ import os
 import signal
 import socket
 import time
+from . import chunkify, DEFAULT_MAX_CHUNK
 
 logger = logging.getLogger('hashserv.server')
 
@@ -107,12 +108,29 @@ class Stats(object):
         return {k: getattr(self, k) for k in ('num', 'total_time', 'max_time', 'average', 'stdev')}
 
 
+class ClientError(Exception):
+    pass
+
 class ServerClient(object):
+    FAST_QUERY = 'SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
+    ALL_QUERY =  'SELECT *                         FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
+
     def __init__(self, reader, writer, db, request_stats):
         self.reader = reader
         self.writer = writer
         self.db = db
         self.request_stats = request_stats
+        self.max_chunk = DEFAULT_MAX_CHUNK
+
+        self.handlers = {
+            'get': self.handle_get,
+            'report': self.handle_report,
+            'report-equiv': self.handle_equivreport,
+            'get-stream': self.handle_get_stream,
+            'get-stats': self.handle_get_stats,
+            'reset-stats': self.handle_reset_stats,
+            'chunk-stream': self.handle_chunk,
+        }
 
     async def process_requests(self):
         try:
@@ -125,7 +143,11 @@ class ServerClient(object):
                 return
 
             (proto_name, proto_version) = protocol.decode('utf-8').rstrip().split()
-            if proto_name != 'OEHASHEQUIV' or proto_version != '1.0':
+            if proto_name != 'OEHASHEQUIV':
+                return
+
+            proto_version = tuple(int(v) for v in proto_version.split('.'))
+            if proto_version < (1, 0) or proto_version > (1, 1):
                 return
 
             # Read headers. Currently, no headers are implemented, so look for
@@ -140,40 +162,34 @@ class ServerClient(object):
                     break
 
             # Handle messages
-            handlers = {
-                'get': self.handle_get,
-                'report': self.handle_report,
-                'report-equiv': self.handle_equivreport,
-                'get-stream': self.handle_get_stream,
-                'get-stats': self.handle_get_stats,
-                'reset-stats': self.handle_reset_stats,
-            }
-
             while True:
                 d = await self.read_message()
                 if d is None:
                     break
-
-                for k in handlers.keys():
-                    if k in d:
-                        logger.debug('Handling %s' % k)
-                        if 'stream' in k:
-                            await handlers[k](d[k])
-                        else:
-                            with self.request_stats.start_sample() as self.request_sample, \
-                                    self.request_sample.measure():
-                                await handlers[k](d[k])
-                        break
-                else:
-                    logger.warning("Unrecognized command %r" % d)
-                    break
-
+                await self.dispatch_message(d)
                 await self.writer.drain()
+        except ClientError as e:
+            logger.error(str(e))
         finally:
             self.writer.close()
 
+    async def dispatch_message(self, msg):
+        for k in self.handlers.keys():
+            if k in msg:
+                logger.debug('Handling %s' % k)
+                if 'stream' in k:
+                    await self.handlers[k](msg[k])
+                else:
+                    with self.request_stats.start_sample() as self.request_sample, \
+                            self.request_sample.measure():
+                        await self.handlers[k](msg[k])
+                return
+
+        raise ClientError("Unrecognized command %r" % msg)
+
     def write_message(self, msg):
-        self.writer.write(('%s\n' % json.dumps(msg)).encode('utf-8'))
+        for c in chunkify(json.dumps(msg), self.max_chunk):
+            self.writer.write(c.encode('utf-8'))
 
     async def read_message(self):
         l = await self.reader.readline()
@@ -191,14 +207,38 @@ class ServerClient(object):
             logger.error('Bad message from client: %r' % message)
             raise e
 
+    async def handle_chunk(self, request):
+        lines = []
+        try:
+            while True:
+                l = await self.reader.readline()
+                l = l.rstrip(b"\n").decode("utf-8")
+                if not l:
+                    break
+                lines.append(l)
+
+            msg = json.loads(''.join(lines))
+        except (json.JSONDecodeError, UnicodeDecodeError) as e:
+            logger.error('Bad message from client: %r' % message)
+            raise e
+
+        if 'chunk-stream' in msg:
+            raise ClientError("Nested chunks are not allowed")
+
+        await self.dispatch_message(msg)
+
     async def handle_get(self, request):
         method = request['method']
         taskhash = request['taskhash']
 
-        row = self.query_equivalent(method, taskhash)
+        if request.get('all', False):
+            row = self.query_equivalent(method, taskhash, self.ALL_QUERY)
+        else:
+            row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
+
         if row is not None:
             logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
-            d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
+            d = {k: row[k] for k in row.keys()}
 
             self.write_message(d)
         else:
@@ -228,7 +268,7 @@ class ServerClient(object):
 
                 (method, taskhash) = l.split()
                 #logger.debug('Looking up %s %s' % (method, taskhash))
-                row = self.query_equivalent(method, taskhash)
+                row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
                 if row is not None:
                     msg = ('%s\n' % row['unihash']).encode('utf-8')
                     #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
@@ -328,7 +368,7 @@ class ServerClient(object):
             # Fetch the unihash that will be reported for the taskhash. If the
             # unihash matches, it means this row was inserted (or the mapping
             # was already valid)
-            row = self.query_equivalent(data['method'], data['taskhash'])
+            row = self.query_equivalent(data['method'], data['taskhash'], self.FAST_QUERY)
 
             if row['unihash'] == data['unihash']:
                 logger.info('Adding taskhash equivalence for %s with unihash %s',
@@ -354,12 +394,11 @@ class ServerClient(object):
         self.request_stats.reset()
         self.write_message(d)
 
-    def query_equivalent(self, method, taskhash):
+    def query_equivalent(self, method, taskhash, query):
         # This is part of the inner loop and must be as fast as possible
         try:
             cursor = self.db.cursor()
-            cursor.execute('SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1',
-                           {'method': method, 'taskhash': taskhash})
+            cursor.execute(query, {'method': method, 'taskhash': taskhash})
             return cursor.fetchone()
         except:
             cursor.close()
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index a5472a99..6e862950 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -99,6 +99,29 @@ class TestHashEquivalenceServer(object):
         result = self.client.get_unihash(self.METHOD, taskhash)
         self.assertEqual(result, unihash)
 
+    def test_huge_message(self):
+        # Simple test that hashes can be created
+        taskhash = 'c665584ee6817aa99edfc77a44dd853828279370'
+        outhash = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
+        unihash = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
+
+        result = self.client.get_unihash(self.METHOD, taskhash)
+        self.assertIsNone(result, msg='Found unexpected task, %r' % result)
+
+        siginfo = "0" * (self.client.max_chunk * 4)
+
+        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash, {
+            'outhash_siginfo': siginfo
+        })
+        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
+
+        result = self.client.get_taskhash(self.METHOD, taskhash, True)
+        self.assertEqual(result['taskhash'], taskhash)
+        self.assertEqual(result['unihash'], unihash)
+        self.assertEqual(result['method'], self.METHOD)
+        self.assertEqual(result['outhash'], outhash)
+        self.assertEqual(result['outhash_siginfo'], siginfo)
+
     def test_stress(self):
         def query_server(failures):
             client = Client(self.server.address)
-- 
2.17.1

