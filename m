Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
	[209.85.166.51])
	by mail.openembedded.org (Postfix) with ESMTP id 889C17F288
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2019 17:47:51 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id j4so975347iog.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2019 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DDseG/sR838iic6N+5Rhug/cMfjntxkR0xWjDbYHOD8=;
	b=AFvxjS1j0JPOzbtTI6iAU/5d/ZzRQ5DFc6yXzXsbcix4aCD6wRssVxeqD+wIMXrAmo
	vTTdE9pauCKAVb28DL95jRI3dJUUj+HDWuJXCS8IiO+tKLD4YEF6+sHa6j18w7Pmx5RM
	u1KwC615lx3RQ3uYYSFZR7jWsONj/vRAFKG3RTYx4qOoJLgjuU5oCUeBsoGVcHb0Xwg7
	rqsvF3TUlvitx6XRfXibPK7Xle/akIk0NxQERqxHWnGSdg7zkxpydhgBqg6Pucs/rvL+
	CtZVUE1aYjs5DvckcfKeMZ0YoYAfKaPGk2GiglPLdJefA/q4ar3oGJ9JeAorSezPpsYA
	2yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DDseG/sR838iic6N+5Rhug/cMfjntxkR0xWjDbYHOD8=;
	b=uFmBXkfUMm8BTepzIaaJ9xm9TZkiE6ndsP+fskf3xa2Gx7JKqPraKnIMv2ZCy13Rd+
	XR2Zh6r68Dy4EAf3+bDNLtU3ZyF6TQZMGw7wYgeT9oyMnfncu61R6Ax944iIkSoCQlUb
	3Nf1nMYoqflA0fKspvPuOfiPaX7breD4Lrh0O+AtFPYac/rUYsHOscof8TR+oAKoNJSf
	frDwdb3Wn4VOFj1g7HuH2oVqTAvOgQEaDEueb6IfffuriX+lhqu8N05fCF2mi5zOQJZR
	nrkRyl4fPe6E2tqsMq/nOSfCr+EJy4gF9z6wtMOCHcTpbZsI63zBZh4C1eW05S1N+FnM
	HPzA==
X-Gm-Message-State: APjAAAVyO+RHhhYypJl89PYNxOGIErHYPpwOgobMw4S1T6FR78KrfTwR
	cF3n616VAWrHfupVuskqU5bpUmTK
X-Google-Smtp-Source: APXvYqzumN8UtVFJ/5HR5ya58N4CXDkPd8VTdDlioVwpjhbIPoqGHuw4/Z88wTXE0NADHHzvB42Clw==
X-Received: by 2002:a02:1cc5:: with SMTP id c188mr1310704jac.26.1568656071084; 
	Mon, 16 Sep 2019 10:47:51 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	e19sm9524291ios.29.2019.09.16.10.47.49
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 16 Sep 2019 10:47:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2019 12:47:33 -0500
Message-Id: <20190916174733.14392-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] bitbake: Rework hash equivalence
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
X-List-Received-Date: Mon, 16 Sep 2019 17:47:51 -0000
Content-Transfer-Encoding: 8bit

Reworks the hash equivalence server to address performance issues that
were encountered with the REST mechanism used previously, particularly
during the heavy request load encountered during signature generation.
Notable changes are:

1) The server protocol is no longer HTTP based. Instead, it uses a
   simpler JSON over a streaming protocol link. This protocol has much
   lower overhead than HTTP since it eliminates the HTTP headers.
2) The hash equivalence server can either bind to a TCP port, or a Unix
   domain socket. Unix domain sockets are more efficient for local
   communication, and so are preferred if the user enables hash
   equivalence only for the local build. The arguments to the
   'bitbake-hashserve' command have been updated accordingly.
3) The value to which BB_HASHSERVE should be set to enable a local hash
   equivalence server is changed to "auto" instead of "localhost:0". The
   latter didn't make sense when the local server was using a Unix
   domain socket.
4) Clients are expected to keep a persistent connection to the server
   instead of creating a new connection each time a request is made for
   optimal performance.
5) Most of the client logic has been moved to the hashserve module in
   bitbake. This makes it easier to share the client code.
6) A new bitbake command has been added called 'bitbake-hashclient'.
   This command can be used to query a hash equivalence server, including
   fetching the statistics and running a performance stress test.
7) The table indexes in the SQLite database have been updated to
   optimize hash lookups. This change is backward compatible, as the
   database will delete the old indexes first if they exist.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient   | 170 ++++++++
 bitbake/bin/bitbake-hashserv     |  24 +-
 bitbake/bin/bitbake-worker       |   2 +-
 bitbake/lib/bb/cooker.py         |  17 +-
 bitbake/lib/bb/runqueue.py       |   4 +-
 bitbake/lib/bb/siggen.py         |  74 ++--
 bitbake/lib/bb/tests/runqueue.py |  12 +-
 bitbake/lib/hashserv/__init__.py | 727 ++++++++++++++++++++++++-------
 bitbake/lib/hashserv/tests.py    | 156 +++----
 9 files changed, 875 insertions(+), 311 deletions(-)
 create mode 100755 bitbake/bin/bitbake-hashclient

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
new file mode 100755
index 00000000000..29ab65f1774
--- /dev/null
+++ b/bitbake/bin/bitbake-hashclient
@@ -0,0 +1,170 @@
+#! /usr/bin/env python3
+#
+# Copyright (C) 2019 Garmin Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import argparse
+import hashlib
+import logging
+import os
+import pprint
+import sys
+import threading
+import time
+
+try:
+    import tqdm
+    ProgressBar = tqdm.tqdm
+except ImportError:
+    class ProgressBar(object):
+        def __init__(self, *args, **kwargs):
+            pass
+
+        def __enter__(self):
+            return self
+
+        def __exit__(self, *args, **kwargs):
+            pass
+
+        def update(self):
+            pass
+
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib'))
+
+import hashserv
+
+DEFAULT_ADDRESS = 'unix://./hashserve.sock'
+METHOD = 'stress.test.method'
+
+
+def main():
+    def handle_stats(args, client):
+        if args.reset:
+            s = client.reset_stats()
+        else:
+            s = client.get_stats()
+        pprint.pprint(s)
+        return 0
+
+    def handle_stress(args, client):
+        def thread_main(pbar, lock):
+            nonlocal found_hashes
+            nonlocal missed_hashes
+            nonlocal max_time
+
+            client = hashserv.create_client(args.address)
+
+            for i in range(args.requests):
+                taskhash = hashlib.sha256()
+                taskhash.update(args.taskhash_seed.encode('utf-8'))
+                taskhash.update(str(i).encode('utf-8'))
+
+                start_time = time.perf_counter()
+                l = client.get_unihash(METHOD, taskhash.hexdigest())
+                elapsed = time.perf_counter() - start_time
+
+                with lock:
+                    if l:
+                        found_hashes += 1
+                    else:
+                        missed_hashes += 1
+
+                    max_time = max(elapsed, max_time)
+                    pbar.update()
+
+        max_time = 0
+        found_hashes = 0
+        missed_hashes = 0
+        lock = threading.Lock()
+        total_requests = args.clients * args.requests
+        start_time = time.perf_counter()
+        with ProgressBar(total=total_requests) as pbar:
+            threads = [threading.Thread(target=thread_main, args=(pbar, lock), daemon=False) for _ in range(args.clients)]
+            for t in threads:
+                t.start()
+
+            for t in threads:
+                t.join()
+
+        elapsed = time.perf_counter() - start_time
+        with lock:
+            print("%d requests in %.1fs. %.1f requests per second" % (total_requests, elapsed, total_requests / elapsed))
+            print("Average request time %.8fs" % (elapsed / total_requests))
+            print("Max request time was %.8fs" % max_time)
+            print("Found %d hashes, missed %d" % (found_hashes, missed_hashes))
+
+        if args.report:
+            with ProgressBar(total=args.requests) as pbar:
+                for i in range(args.requests):
+                    taskhash = hashlib.sha256()
+                    taskhash.update(args.taskhash_seed.encode('utf-8'))
+                    taskhash.update(str(i).encode('utf-8'))
+
+                    outhash = hashlib.sha256()
+                    outhash.update(args.outhash_seed.encode('utf-8'))
+                    outhash.update(str(i).encode('utf-8'))
+
+                    client.report_unihash(taskhash.hexdigest(), METHOD, outhash.hexdigest(), taskhash.hexdigest())
+
+                    with lock:
+                        pbar.update()
+
+    parser = argparse.ArgumentParser(description='Hash Equivalence Client')
+    parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
+    parser.add_argument('--log', default='WARNING', help='Set logging level')
+
+    subparsers = parser.add_subparsers()
+
+    stats_parser = subparsers.add_parser('stats', help='Show server stats')
+    stats_parser.add_argument('--reset', action='store_true',
+                              help='Reset server stats')
+    stats_parser.set_defaults(func=handle_stats)
+
+    stress_parser = subparsers.add_parser('stress', help='Run stress test')
+    stress_parser.add_argument('--clients', type=int, default=10,
+                               help='Number of simultaneous clients')
+    stress_parser.add_argument('--requests', type=int, default=1000,
+                               help='Number of requests each client will perform')
+    stress_parser.add_argument('--report', action='store_true',
+                               help='Report new hashes')
+    stress_parser.add_argument('--taskhash-seed', default='',
+                               help='Include string in taskhash')
+    stress_parser.add_argument('--outhash-seed', default='',
+                               help='Include string in outhash')
+    stress_parser.set_defaults(func=handle_stress)
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
+    func = getattr(args, 'func', None)
+    if func:
+        client = hashserv.create_client(args.address)
+        # Try to establish a connection to the server now to detect failures
+        # early
+        client.connect()
+
+        return func(args, client)
+
+    return 0
+
+
+if __name__ == '__main__':
+    try:
+        ret = main()
+    except Exception:
+        ret = 1
+        import traceback
+        traceback.print_exc()
+    sys.exit(ret)
diff --git a/bitbake/bin/bitbake-hashserv b/bitbake/bin/bitbake-hashserv
index 6c911c098a7..1bc1f91f383 100755
--- a/bitbake/bin/bitbake-hashserv
+++ b/bitbake/bin/bitbake-hashserv
@@ -11,20 +11,26 @@ import logging
 import argparse
 import sqlite3
 
-sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),'lib'))
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib'))
 
 import hashserv
 
 VERSION = "1.0.0"
 
-DEFAULT_HOST = ''
-DEFAULT_PORT = 8686
+DEFAULT_BIND = 'unix://./hashserve.sock'
+
 
 def main():
-    parser = argparse.ArgumentParser(description='HTTP Equivalence Reference Server. Version=%s' % VERSION)
-    parser.add_argument('--address', default=DEFAULT_HOST, help='Bind address (default "%(default)s")')
-    parser.add_argument('--port', type=int, default=DEFAULT_PORT, help='Bind port (default %(default)d)')
-    parser.add_argument('--prefix', default='', help='HTTP path prefix (default "%(default)s")')
+    parser = argparse.ArgumentParser(description='Hash Equivalence Reference Server. Version=%s' % VERSION,
+                                     epilog='''The bind address is the path to a unix domain socket if it is
+                                               prefixed with "unix://". Otherwise, it is an IP address
+                                               and port in form ADDRESS:PORT. To bind to all addresses, leave
+                                               the ADDRESS empty, e.g. "--bind :8686". To bind to a specific
+                                               IPv6 address, enclose the address in "[]", e.g.
+                                               "--bind [::1]:8686"'''
+                                     )
+
+    parser.add_argument('--bind', default=DEFAULT_BIND, help='Bind address (default "%(default)s")')
     parser.add_argument('--database', default='./hashserv.db', help='Database file (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
 
@@ -41,10 +47,11 @@ def main():
     console.setLevel(level)
     logger.addHandler(console)
 
-    server = hashserv.create_server((args.address, args.port), args.database, args.prefix)
+    server = hashserv.create_server(args.bind, args.database)
     server.serve_forever()
     return 0
 
+
 if __name__ == '__main__':
     try:
         ret = main()
@@ -53,4 +60,3 @@ if __name__ == '__main__':
         import traceback
         traceback.print_exc()
     sys.exit(ret)
-
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 96369199f23..6776cadda3d 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -418,7 +418,7 @@ class BitbakeWorker(object):
         bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
         for mc in self.databuilder.mcdata:
             self.databuilder.mcdata[mc].setVar("PRSERV_HOST", self.workerdata["prhost"])
-            self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.workerdata["hashservport"])
+            self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.workerdata["hashservaddr"])
 
     def handle_newtaskhashes(self, data):
         self.workerdata["newhashes"] = pickle.loads(data)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5840aa75e0c..d1c419e21df 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -194,7 +194,7 @@ class BBCooker:
 
         self.ui_cmdline = None
         self.hashserv = None
-        self.hashservport = None
+        self.hashservaddr = None
 
         self.initConfigurationData()
 
@@ -392,19 +392,20 @@ class BBCooker:
         except prserv.serv.PRServiceConfigError as e:
             bb.fatal("Unable to start PR Server, exitting")
 
-        if self.data.getVar("BB_HASHSERVE") == "localhost:0":
+        if self.data.getVar("BB_HASHSERVE") == "auto":
+            # Create a new hash server bound to a unix domain socket
             if not self.hashserv:
                 dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
-                self.hashserv = hashserv.create_server(('localhost', 0), dbfile, '')
-                self.hashservport = "localhost:" + str(self.hashserv.server_port)
+                self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
+                self.hashserv = hashserv.create_server(self.hashservaddr, dbfile, sync=False)
                 self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
                 self.hashserv.process.daemon = True
                 self.hashserv.process.start()
-            self.data.setVar("BB_HASHSERVE", self.hashservport)
-            self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservport)
-            self.databuilder.data.setVar("BB_HASHSERVE", self.hashservport)
+            self.data.setVar("BB_HASHSERVE", self.hashservaddr)
+            self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservaddr)
+            self.databuilder.data.setVar("BB_HASHSERVE", self.hashservaddr)
             for mc in self.databuilder.mcdata:
-                self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.hashservport)
+                self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.hashservaddr)
 
         bb.parse.init_parser(self.data)
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index addb2bb82fd..e5fd8630c97 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1259,7 +1259,7 @@ class RunQueue:
             "buildname" : self.cfgData.getVar("BUILDNAME"),
             "date" : self.cfgData.getVar("DATE"),
             "time" : self.cfgData.getVar("TIME"),
-            "hashservport" : self.cooker.hashservport,
+            "hashservaddr" : self.cooker.hashservaddr,
         }
 
         worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
@@ -2173,7 +2173,7 @@ class RunQueueExecute:
             ret.add(dep)
         return ret
 
-    # We filter out multiconfig dependencies from taskdepdata we pass to the tasks 
+    # We filter out multiconfig dependencies from taskdepdata we pass to the tasks
     # as most code can't handle them
     def build_taskdepdata(self, task):
         taskdepdata = {}
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index b503559305b..31e6806871d 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -13,6 +13,7 @@ import difflib
 import simplediff
 from bb.checksum import FileChecksumCache
 from bb import runqueue
+import hashserv
 
 logger = logging.getLogger('BitBake.SigGen')
 
@@ -369,6 +370,11 @@ class SignatureGeneratorUniHashMixIn(object):
         self.server, self.method = data[:2]
         super().set_taskdata(data[2:])
 
+    def client(self):
+        if getattr(self, '_client', None) is None:
+            self._client = hashserv.create_client(self.server)
+        return self._client
+
     def __get_task_unihash_key(self, tid):
         # TODO: The key only *needs* to be the taskhash, the tid is just
         # convenient
@@ -389,9 +395,6 @@ class SignatureGeneratorUniHashMixIn(object):
         self.unitaskhashes[self.__get_task_unihash_key(tid)] = unihash
 
     def get_unihash(self, tid):
-        import urllib
-        import json
-
         taskhash = self.taskhash[tid]
 
         key = self.__get_task_unihash_key(tid)
@@ -418,36 +421,22 @@ class SignatureGeneratorUniHashMixIn(object):
         unihash = taskhash
 
         try:
-            url = '%s/v1/equivalent?%s' % (self.server,
-                    urllib.parse.urlencode({'method': self.method, 'taskhash': self.taskhash[tid]}))
-
-            request = urllib.request.Request(url)
-            response = urllib.request.urlopen(request)
-            data = response.read().decode('utf-8')
-
-            json_data = json.loads(data)
-
-            if json_data:
-                unihash = json_data['unihash']
+            data = self.client().get_unihash(self.method, self.taskhash[tid])
+            if data:
+                unihash = data
                 # A unique hash equal to the taskhash is not very interesting,
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
                 bb.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
             else:
                 bb.debug(2, 'No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
-        except urllib.error.URLError as e:
-            bb.warn('Failure contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
-        except (KeyError, json.JSONDecodeError) as e:
-            bb.warn('Poorly formatted response from %s: %s' % (self.server, str(e)))
+        except hashserv.HashConnectionError as e:
+            bb.warn('Error contacting Hash Equivalence Server %s: %s' (self.server, str(e)))
 
         self.unitaskhashes[key] = unihash
         return unihash
 
     def report_unihash(self, path, task, d):
-        import urllib
-        import json
-        import tempfile
-        import base64
         import importlib
 
         taskhash = d.getVar('BB_TASKHASH')
@@ -482,42 +471,31 @@ class SignatureGeneratorUniHashMixIn(object):
                 outhash = bb.utils.better_eval(self.method + '(path, sigfile, task, d)', locs)
 
             try:
-                url = '%s/v1/equivalent' % self.server
-                task_data = {
-                    'taskhash': taskhash,
-                    'method': self.method,
-                    'outhash': outhash,
-                    'unihash': unihash,
-                    'owner': d.getVar('SSTATE_HASHEQUIV_OWNER')
-                    }
+                extra_data = {}
+
+                owner = d.getVar('SSTATE_HASHEQUIV_OWNER')
+                if owner:
+                    extra_data['owner'] = owner
 
                 if report_taskdata:
                     sigfile.seek(0)
 
-                    task_data['PN'] = d.getVar('PN')
-                    task_data['PV'] = d.getVar('PV')
-                    task_data['PR'] = d.getVar('PR')
-                    task_data['task'] = task
-                    task_data['outhash_siginfo'] = sigfile.read().decode('utf-8')
-
-                headers = {'content-type': 'application/json'}
-
-                request = urllib.request.Request(url, json.dumps(task_data).encode('utf-8'), headers)
-                response = urllib.request.urlopen(request)
-                data = response.read().decode('utf-8')
+                    extra_data['PN'] = d.getVar('PN')
+                    extra_data['PV'] = d.getVar('PV')
+                    extra_data['PR'] = d.getVar('PR')
+                    extra_data['task'] = task
+                    extra_data['outhash_siginfo'] = sigfile.read().decode('utf-8')
 
-                json_data = json.loads(data)
-                new_unihash = json_data['unihash']
+                data = self.client().report_unihash(taskhash, self.method, outhash, unihash, extra_data)
+                new_unihash = data['unihash']
 
                 if new_unihash != unihash:
                     bb.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
                 else:
                     bb.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
-            except urllib.error.URLError as e:
-                bb.warn('Failure contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
-            except (KeyError, json.JSONDecodeError) as e:
-                bb.warn('Poorly formatted response from %s: %s' % (self.server, str(e)))
+            except hashserv.HashConnectionError as e:
+                bb.warn('Error contacting Hash Equivalence Server %s: %s' (self.server, str(e)))
         finally:
             if sigfile:
                 sigfile.close()
@@ -538,7 +516,7 @@ class SignatureGeneratorTestEquivHash(SignatureGeneratorUniHashMixIn, SignatureG
     name = "TestEquivHash"
     def init_rundepcheck(self, data):
         super().init_rundepcheck(data)
-        self.server = "http://" + data.getVar('BB_HASHSERVE')
+        self.server = data.getVar('BB_HASHSERVE')
         self.method = "sstate_output_hash"
 
 
diff --git a/bitbake/lib/bb/tests/runqueue.py b/bitbake/lib/bb/tests/runqueue.py
index c7f5e557262..3ccb53c53b8 100644
--- a/bitbake/lib/bb/tests/runqueue.py
+++ b/bitbake/lib/bb/tests/runqueue.py
@@ -235,7 +235,7 @@ class RunQueueTests(unittest.TestCase):
     def test_hashserv_single(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BB_HASHSERVE" : "localhost:0",
+                "BB_HASHSERVE" : "auto",
                 "BB_SIGNATURE_HANDLER" : "TestEquivHash"
             }
             cmd = ["bitbake", "a1", "b1"]
@@ -258,7 +258,7 @@ class RunQueueTests(unittest.TestCase):
     def test_hashserv_double(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BB_HASHSERVE" : "localhost:0",
+                "BB_HASHSERVE" : "auto",
                 "BB_SIGNATURE_HANDLER" : "TestEquivHash"
             }
             cmd = ["bitbake", "a1", "b1", "e1"]
@@ -282,7 +282,7 @@ class RunQueueTests(unittest.TestCase):
         # Runs e1:do_package_setscene twice
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BB_HASHSERVE" : "localhost:0",
+                "BB_HASHSERVE" : "auto",
                 "BB_SIGNATURE_HANDLER" : "TestEquivHash"
             }
             cmd = ["bitbake", "a1", "b1", "e1"]
@@ -312,7 +312,7 @@ class RunQueueTests(unittest.TestCase):
         # e1:do_package matches initial built but not second hash value
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BB_HASHSERVE" : "localhost:0",
+                "BB_HASHSERVE" : "auto",
                 "BB_SIGNATURE_HANDLER" : "TestEquivHash"
             }
             cmd = ["bitbake", "a1", "b1"]
@@ -340,7 +340,7 @@ class RunQueueTests(unittest.TestCase):
         # e1:do_package + e1:do_populate_sysroot matches initial built but not second hash value
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BB_HASHSERVE" : "localhost:0",
+                "BB_HASHSERVE" : "auto",
                 "BB_SIGNATURE_HANDLER" : "TestEquivHash"
             }
             cmd = ["bitbake", "a1", "b1"]
@@ -369,7 +369,7 @@ class RunQueueTests(unittest.TestCase):
         # with none of the intermediate tasks which is a serious bug
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BB_HASHSERVE" : "localhost:0",
+                "BB_HASHSERVE" : "auto",
                 "BB_SIGNATURE_HANDLER" : "TestEquivHash"
             }
             cmd = ["bitbake", "a1", "b1"]
diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index eb03c32213d..59463004a44 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -3,203 +3,561 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from http.server import BaseHTTPRequestHandler, HTTPServer
-import contextlib
-import urllib.parse
-import sqlite3
+from contextlib import closing
+from datetime import datetime
+import argparse
+import asyncio
 import json
-import traceback
 import logging
-import socketserver
-import queue
-import threading
+import math
+import os
+import re
 import signal
 import socket
-import struct
-from datetime import datetime
+import sqlite3
+import time
 
 logger = logging.getLogger('hashserv')
 
-class HashEquivalenceServer(BaseHTTPRequestHandler):
-    def log_message(self, f, *args):
-        logger.debug(f, *args)
+UNIX_PREFIX = "unix://"
 
-    def opendb(self):
-        self.db = sqlite3.connect(self.dbname)
-        self.db.row_factory = sqlite3.Row
-        self.db.execute("PRAGMA synchronous = OFF;")
-        self.db.execute("PRAGMA journal_mode = MEMORY;")
+ADDR_TYPE_UNIX = 0
+ADDR_TYPE_TCP = 1
 
-    def do_GET(self):
-        try:
-            if not self.db:
-                self.opendb()
 
-            p = urllib.parse.urlparse(self.path)
+class Measurement(object):
+    def __init__(self, sample):
+        self.sample = sample
 
-            if p.path != self.prefix + '/v1/equivalent':
-                self.send_error(404)
-                return
+    def start(self):
+        self.start_time = time.perf_counter()
 
-            query = urllib.parse.parse_qs(p.query, strict_parsing=True)
-            method = query['method'][0]
-            taskhash = query['taskhash'][0]
+    def end(self):
+        self.sample.add(time.perf_counter() - self.start_time)
 
-            d = None
-            with contextlib.closing(self.db.cursor()) as cursor:
-                cursor.execute('SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1',
-                        {'method': method, 'taskhash': taskhash})
+    def __enter__(self):
+        self.start()
+        return self
 
-                row = cursor.fetchone()
+    def __exit__(self, *args, **kwargs):
+        self.end()
 
-                if row is not None:
-                    logger.debug('Found equivalent task %s', row['taskhash'])
-                    d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
 
-            self.send_response(200)
-            self.send_header('Content-Type', 'application/json; charset=utf-8')
-            self.end_headers()
-            self.wfile.write(json.dumps(d).encode('utf-8'))
-        except:
-            logger.exception('Error in GET')
-            self.send_error(400, explain=traceback.format_exc())
-            return
+class Sample(object):
+    def __init__(self, stats):
+        self.stats = stats
+        self.num_samples = 0
+        self.elapsed = 0
+
+    def measure(self):
+        return Measurement(self)
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, *args, **kwargs):
+        self.end()
+
+    def add(self, elapsed):
+        self.num_samples += 1
+        self.elapsed += elapsed
+
+    def end(self):
+        if self.num_samples:
+            self.stats.add(self.elapsed)
+            self.num_samples = 0
+            self.elapsed = 0
+
+
+class Stats(object):
+    def __init__(self):
+        self.reset()
+
+    def reset(self):
+        self.num = 0
+        self.total_time = 0
+        self.max_time = 0
+        self.m = 0
+        self.s = 0
+        self.current_elapsed = None
+
+    def add(self, elapsed):
+        self.num += 1
+        if self.num == 1:
+            self.m = elapsed
+            self.s = 0
+        else:
+            last_m = self.m
+            self.m = last_m + (elapsed - last_m) / self.num
+            self.s = self.s + (elapsed - last_m) * (elapsed - self.m)
+
+        self.total_time += elapsed
+
+        if self.max_time < elapsed:
+            self.max_time = elapsed
+
+    def start_sample(self):
+        return Sample(self)
+
+    @property
+    def average(self):
+        if self.num == 0:
+            return 0
+        return self.total_time / self.num
+
+    @property
+    def stdev(self):
+        if self.num <= 1:
+            return 0
+        return math.sqrt(self.s / (self.num - 1))
 
-    def do_POST(self):
+    def todict(self):
+        return {k: getattr(self, k) for k in ('num', 'total_time', 'max_time', 'average', 'stdev')}
+
+
+class ServerClient(object):
+    def __init__(self, reader, writer, db, request_stats):
+        self.reader = reader
+        self.writer = writer
+        self.db = db
+        self.request_stats = request_stats
+
+    async def process_requests(self):
         try:
-            if not self.db:
-                self.opendb()
+            self.addr = self.writer.get_extra_info('peername')
+            logger.debug('Client %r connected' % (self.addr,))
 
-            p = urllib.parse.urlparse(self.path)
+            # Read protocol and version
+            protocol = await self.reader.readline()
+            if protocol is None:
+                return
 
-            if p.path != self.prefix + '/v1/equivalent':
-                self.send_error(404)
+            (proto_name, proto_version) = protocol.decode('utf-8').rstrip().split()
+            if proto_name != 'OEHASHEQUIV' or proto_version != '1.0':
                 return
 
-            length = int(self.headers['content-length'])
-            data = json.loads(self.rfile.read(length).decode('utf-8'))
-
-            with contextlib.closing(self.db.cursor()) as cursor:
-                cursor.execute('''
-                    -- Find tasks with a matching outhash (that is, tasks that
-                    -- are equivalent)
-                    SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND outhash=:outhash
-
-                    -- If there is an exact match on the taskhash, return it.
-                    -- Otherwise return the oldest matching outhash of any
-                    -- taskhash
-                    ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
-                        created ASC
-
-                    -- Only return one row
-                    LIMIT 1
-                    ''', {k: data[k] for k in ('method', 'outhash', 'taskhash')})
-
-                row = cursor.fetchone()
-
-                # If no matching outhash was found, or one *was* found but it
-                # wasn't an exact match on the taskhash, a new entry for this
-                # taskhash should be added
-                if row is None or row['taskhash'] != data['taskhash']:
-                    # If a row matching the outhash was found, the unihash for
-                    # the new taskhash should be the same as that one.
-                    # Otherwise the caller provided unihash is used.
-                    unihash = data['unihash']
-                    if row is not None:
-                        unihash = row['unihash']
-
-                    insert_data = {
-                            'method': data['method'],
-                            'outhash': data['outhash'],
-                            'taskhash': data['taskhash'],
-                            'unihash': unihash,
-                            'created': datetime.now()
-                            }
-
-                    for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
-                        if k in data:
-                            insert_data[k] = data[k]
-
-                    cursor.execute('''INSERT INTO tasks_v2 (%s) VALUES (%s)''' % (
-                            ', '.join(sorted(insert_data.keys())),
-                            ', '.join(':' + k for k in sorted(insert_data.keys()))),
-                        insert_data)
-
-                    logger.info('Adding taskhash %s with unihash %s', data['taskhash'], unihash)
-
-                    self.db.commit()
-                    d = {'taskhash': data['taskhash'], 'method': data['method'], 'unihash': unihash}
+            # Read headers. Currently, no headers are implemented, so look for
+            # an empty line to signal the end of the headers
+            while True:
+                line = await self.reader.readline()
+                if line is None:
+                    return
+
+                line = line.decode('utf-8').rstrip()
+                if not line:
+                    break
+
+            # Handle messages
+            handlers = {
+                'get': self.handle_get,
+                'report': self.handle_report,
+                'get-stream': self.handle_get_stream,
+                'get-stats': self.handle_get_stats,
+                'reset-stats': self.handle_reset_stats,
+            }
+
+            while True:
+                d = await self.read_message()
+                if d is None:
+                    break
+
+                for k in handlers.keys():
+                    if k in d:
+                        logger.debug('Handling %s' % k)
+                        if 'stream' in k:
+                            await handlers[k](d[k])
+                        else:
+                            with self.request_stats.start_sample() as self.request_sample, \
+                                    self.request_sample.measure():
+                                await handlers[k](d[k])
+                        break
                 else:
-                    d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
+                    logger.warning("Unrecognized command %r" % d)
+                    break
 
-                self.send_response(200)
-                self.send_header('Content-Type', 'application/json; charset=utf-8')
-                self.end_headers()
-                self.wfile.write(json.dumps(d).encode('utf-8'))
-        except:
-            logger.exception('Error in POST')
-            self.send_error(400, explain=traceback.format_exc())
-            return
+                await self.writer.drain()
+        finally:
+            self.writer.close()
 
-class ThreadedHTTPServer(HTTPServer):
-    quit = False
+    def write_message(self, msg):
+        self.writer.write(('%s\n' % json.dumps(msg)).encode('utf-8'))
 
-    def serve_forever(self):
-        self.requestqueue = queue.Queue()
-        self.handlerthread = threading.Thread(target=self.process_request_thread)
-        self.handlerthread.daemon = False
+    async def read_message(self):
+        l = await self.reader.readline()
+        if not l:
+            return None
 
-        self.handlerthread.start()
+        try:
+            message = l.decode('utf-8')
 
-        signal.signal(signal.SIGTERM, self.sigterm_exception)
-        super().serve_forever()
-        os._exit(0)
+            if not message.endswith('\n'):
+                return None
 
-    def sigterm_exception(self, signum, stackframe):
-        self.server_close()
-        os._exit(0)
+            return json.loads(message)
+        except (json.JSONDecodeError, UnicodeDecodeError) as e:
+            logger.error('Bad message from client: %r' % message)
+            raise e
 
-    def server_bind(self):
-        HTTPServer.server_bind(self)
-        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_LINGER, struct.pack('ii', 1, 0))
+    async def handle_get(self, request):
+        method = request['method']
+        taskhash = request['taskhash']
+
+        row = self.query_equivalent(method, taskhash)
+        if row is not None:
+            logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+            d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
+
+            self.write_message(d)
+        else:
+            self.write_message(None)
+
+    async def handle_get_stream(self, request):
+        self.write_message('ok')
+
+        while True:
+            l = await self.reader.readline()
+            if not l:
+                return
 
-    def process_request_thread(self):
-        while not self.quit:
-            try:
-                (request, client_address) = self.requestqueue.get(True)
-            except queue.Empty:
-                continue
-            if request is None:
-                continue
             try:
-                self.finish_request(request, client_address)
-            except Exception:
-                self.handle_error(request, client_address)
+                # This inner loop is very sensitive and must be as fast as
+                # possible (which is why the request sample is handled manually
+                # instead of using 'with', and also why logging statements are
+                # commented out.
+                self.request_sample = self.request_stats.start_sample()
+                request_measure = self.request_sample.measure()
+                request_measure.start()
+
+                l = l.decode('utf-8').rstrip()
+                if l == 'END':
+                    self.writer.write('ok\n'.encode('utf-8'))
+                    return
+
+                (method, taskhash) = l.split()
+                #logger.debug('Looking up %s %s' % (method, taskhash))
+                row = self.query_equivalent(method, taskhash)
+                if row is not None:
+                    msg = ('%s\n' % row['unihash']).encode('utf-8')
+                    #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+                else:
+                    msg = '\n'.encode('utf-8')
+
+                self.writer.write(msg)
             finally:
-                self.shutdown_request(request)
-        os._exit(0)
+                request_measure.end()
+                self.request_sample.end()
+
+            await self.writer.drain()
+
+    async def handle_report(self, data):
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute('''
+                -- Find tasks with a matching outhash (that is, tasks that
+                -- are equivalent)
+                SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND outhash=:outhash
+
+                -- If there is an exact match on the taskhash, return it.
+                -- Otherwise return the oldest matching outhash of any
+                -- taskhash
+                ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
+                    created ASC
+
+                -- Only return one row
+                LIMIT 1
+                ''', {k: data[k] for k in ('method', 'outhash', 'taskhash')})
+
+            row = cursor.fetchone()
+
+            # If no matching outhash was found, or one *was* found but it
+            # wasn't an exact match on the taskhash, a new entry for this
+            # taskhash should be added
+            if row is None or row['taskhash'] != data['taskhash']:
+                # If a row matching the outhash was found, the unihash for
+                # the new taskhash should be the same as that one.
+                # Otherwise the caller provided unihash is used.
+                unihash = data['unihash']
+                if row is not None:
+                    unihash = row['unihash']
 
-    def process_request(self, request, client_address):
-        self.requestqueue.put((request, client_address))
+                insert_data = {
+                    'method': data['method'],
+                    'outhash': data['outhash'],
+                    'taskhash': data['taskhash'],
+                    'unihash': unihash,
+                    'created': datetime.now()
+                }
 
-    def server_close(self):
-        super().server_close()
-        self.quit = True
-        self.requestqueue.put((None, None))
-        self.handlerthread.join()
+                for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
+                    if k in data:
+                        insert_data[k] = data[k]
 
-def create_server(addr, dbname, prefix=''):
-    class Handler(HashEquivalenceServer):
-        pass
+                cursor.execute('''INSERT INTO tasks_v2 (%s) VALUES (%s)''' % (
+                    ', '.join(sorted(insert_data.keys())),
+                    ', '.join(':' + k for k in sorted(insert_data.keys()))),
+                    insert_data)
 
-    db = sqlite3.connect(dbname)
-    db.row_factory = sqlite3.Row
+                self.db.commit()
+
+                logger.info('Adding taskhash %s with unihash %s',
+                            data['taskhash'], unihash)
+
+                d = {
+                    'taskhash': data['taskhash'],
+                    'method': data['method'],
+                    'unihash': unihash
+                }
+            else:
+                d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
+
+        self.write_message(d)
+
+    async def handle_get_stats(self, request):
+        d = {
+            'requests': self.request_stats.todict(),
+        }
 
-    Handler.prefix = prefix
-    Handler.db = None
-    Handler.dbname = dbname
+        self.write_message(d)
 
-    with contextlib.closing(db.cursor()) as cursor:
+    async def handle_reset_stats(self, request):
+        d = {
+            'requests': self.request_stats.todict(),
+        }
+
+        self.request_stats.reset()
+        self.write_message(d)
+
+    def query_equivalent(self, method, taskhash):
+        # This is part of the inner loop and must be as fast as possible
+        try:
+            cursor = self.db.cursor()
+            cursor.execute('SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1',
+                           {'method': method, 'taskhash': taskhash})
+            return cursor.fetchone()
+        except:
+            cursor.close()
+
+
+class Server(object):
+    def __init__(self, db, loop=None):
+        self.request_stats = Stats()
+        self.db = db
+
+        if loop is None:
+            self.loop = asyncio.new_event_loop()
+            self.close_loop = True
+        else:
+            self.loop = loop
+            self.close_loop = False
+
+        self._cleanup_socket = None
+
+    def start_tcp_server(self, host, port):
+        self.server = self.loop.run_until_complete(
+            asyncio.start_server(self.handle_client, host, port, loop=self.loop)
+        )
+
+        for s in self.server.sockets:
+            logger.info('Listening on %r' % (s.getsockname(),))
+            # Newer python does this automatically. Do it manually here for
+            # maximum compatibility
+            s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
+            s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
+
+        name = self.server.sockets[0].getsockname()
+        if self.server.sockets[0].family == socket.AF_INET6:
+            self.address = "[%s]:%d" % (name[0], name[1])
+        else:
+            self.address = "%s:%d" % (name[0], name[1])
+
+    def start_unix_server(self, path):
+        def cleanup():
+            os.unlink(path)
+
+        self.server = self.loop.run_until_complete(
+            asyncio.start_unix_server(self.handle_client, path, loop=self.loop)
+        )
+        logger.info('Listening on %r' % path)
+
+        self._cleanup_socket = cleanup
+        self.address = "%s%s" % (UNIX_PREFIX, os.path.abspath(path))
+
+    async def handle_client(self, reader, writer):
+        # writer.transport.set_write_buffer_limits(0)
+        try:
+            client = ServerClient(reader, writer, self.db, self.request_stats)
+            await client.process_requests()
+        except Exception as e:
+            import traceback
+            logger.error('Error from client: %s' % str(e), exc_info=True)
+            traceback.print_exc()
+            writer.close()
+        logger.info('Client disconnected')
+
+    def serve_forever(self):
+        def signal_handler():
+            self.loop.stop()
+
+        self.loop.add_signal_handler(signal.SIGTERM, signal_handler)
+
+        try:
+            self.loop.run_forever()
+        except KeyboardInterrupt:
+            pass
+
+        self.server.close()
+        self.loop.run_until_complete(self.server.wait_closed())
+        logger.info('Server shutting down')
+
+        if self.close_loop:
+            self.loop.close()
+
+        if self._cleanup_socket is not None:
+            self._cleanup_socket()
+
+
+class HashConnectionError(Exception):
+    pass
+
+
+class Client(object):
+    MODE_NORMAL = 0
+    MODE_GET_STREAM = 1
+
+    def __init__(self):
+        self._socket = None
+        self.reader = None
+        self.writer = None
+        self.mode = self.MODE_NORMAL
+
+    def connect_tcp(self, address, port):
+        def connect_sock():
+            s = socket.create_connection((address, port))
+
+            s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
+            s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
+            s.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
+            return s
+
+        self._connect_sock = connect_sock
+
+    def connect_unix(self, path):
+        def connect_sock():
+            s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+            s.connect(path)
+            return s
+
+        self._connect_sock = connect_sock
+
+    def connect(self):
+        if self._socket is None:
+            self._socket = self._connect_sock()
+
+            self.reader = self._socket.makefile('r', encoding='utf-8')
+            self.writer = self._socket.makefile('w', encoding='utf-8')
+
+            self.writer.write('OEHASHEQUIV 1.0\n\n')
+            self.writer.flush()
+
+            # Restore mode if the socket is being re-created
+            cur_mode = self.mode
+            self.mode = self.MODE_NORMAL
+            self._set_mode(cur_mode)
+
+        return self._socket
+
+    def close(self):
+        if self._socket is not None:
+            self._socket.close()
+            self._socket = None
+            self.reader = None
+            self.writer = None
+
+    def _send_wrapper(self, proc):
+        count = 0
+        while True:
+            try:
+                self.connect()
+                return proc()
+            except (OSError, HashConnectionError, json.JSONDecodeError, UnicodeDecodeError) as e:
+                logger.warning('Error talking to server: %s' % e)
+                if count >= 3:
+                    if not isinstance(e, HashConnectionError):
+                        raise HashConnectionError(str(e))
+                    raise e
+                self.close()
+                count += 1
+
+    def send_message(self, msg):
+        def proc():
+            self.writer.write('%s\n' % json.dumps(msg))
+            self.writer.flush()
+
+            l = self.reader.readline()
+            if not l:
+                raise HashConnectionError('Connection closed')
+
+            if not l.endswith('\n'):
+                raise HashConnectionError('Bad message %r' % message)
+
+            return json.loads(l)
+
+        return self._send_wrapper(proc)
+
+    def send_stream(self, msg):
+        def proc():
+            self.writer.write("%s\n" % msg)
+            self.writer.flush()
+            l = self.reader.readline()
+            if not l:
+                raise HashConnectionError('Connection closed')
+            return l.rstrip()
+
+        return self._send_wrapper(proc)
+
+    def _set_mode(self, new_mode):
+        if new_mode == self.MODE_NORMAL and self.mode == self.MODE_GET_STREAM:
+            r = self.send_stream('END')
+            if r != 'ok':
+                raise HashConnectionError('Bad response from server %r' % r)
+        elif new_mode == self.MODE_GET_STREAM and self.mode == self.MODE_NORMAL:
+            r = self.send_message({'get-stream': None})
+            if r != 'ok':
+                raise HashConnectionError('Bad response from server %r' % r)
+        elif new_mode != self.mode:
+            raise Exception('Undefined mode transition %r -> %r' % (self.mode, new_mode))
+
+        self.mode = new_mode
+
+    def get_unihash(self, method, taskhash):
+        self._set_mode(self.MODE_GET_STREAM)
+        r = self.send_stream('%s %s' % (method, taskhash))
+        if not r:
+            return None
+        return r
+
+    def report_unihash(self, taskhash, method, outhash, unihash, extra={}):
+        self._set_mode(self.MODE_NORMAL)
+        m = extra.copy()
+        m['taskhash'] = taskhash
+        m['method'] = method
+        m['outhash'] = outhash
+        m['unihash'] = unihash
+        return self.send_message({'report': m})
+
+    def get_stats(self):
+        self._set_mode(self.MODE_NORMAL)
+        return self.send_message({'get-stats': None})
+
+    def reset_stats(self):
+        self._set_mode(self.MODE_NORMAL)
+        return self.send_message({'reset-stats': None})
+
+
+def setup_database(database, sync=True):
+    db = sqlite3.connect(database)
+    db.row_factory = sqlite3.Row
+
+    with closing(db.cursor()) as cursor:
         cursor.execute('''
             CREATE TABLE IF NOT EXISTS tasks_v2 (
                 id INTEGER PRIMARY KEY AUTOINCREMENT,
@@ -220,11 +578,54 @@ def create_server(addr, dbname, prefix=''):
                 UNIQUE(method, outhash, taskhash)
                 )
             ''')
-        cursor.execute('CREATE INDEX IF NOT EXISTS taskhash_lookup ON tasks_v2 (method, taskhash)')
-        cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup ON tasks_v2 (method, outhash)')
+        cursor.execute('PRAGMA journal_mode = WAL')
+        cursor.execute('PRAGMA synchronous = %s' % ('NORMAL' if sync else 'OFF'))
+
+        # Drop old indexes
+        cursor.execute('DROP INDEX IF EXISTS taskhash_lookup')
+        cursor.execute('DROP INDEX IF EXISTS outhash_lookup')
+
+        # Create new indexes
+        cursor.execute('CREATE INDEX IF NOT EXISTS taskhash_lookup_v2 ON tasks_v2 (method, taskhash, created)')
+        cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup_v2 ON tasks_v2 (method, outhash)')
+
+    return db
+
+
+def parse_address(addr):
+    if addr.startswith(UNIX_PREFIX):
+        return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX):],))
+    else:
+        m = re.match(r'\[(?P<host>[^\]]*)\]:(?P<port>\d+)$', addr)
+        if m is not None:
+            host = m.group('host')
+            port = m.group('port')
+        else:
+            host, port = addr.split(':')
+
+        return (ADDR_TYPE_TCP, (host, int(port)))
+
+
+def create_server(addr, dbname, *, sync=True):
+    db = setup_database(dbname, sync=sync)
+    server = Server(db)
+
+    (typ, a) = parse_address(addr)
+    if typ == ADDR_TYPE_UNIX:
+        server.start_unix_server(*a)
+    else:
+        server.start_tcp_server(*a)
+
+    return server
+
 
-    ret = ThreadedHTTPServer(addr, Handler)
+def create_client(addr):
+    client = Client()
 
-    logger.info('Starting server on %s\n', ret.server_port)
+    (typ, a) = parse_address(addr)
+    if typ == ADDR_TYPE_UNIX:
+        client.connect_unix(*a)
+    else:
+        client.connect_tcp(*a)
 
-    return ret
+    return client
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index 6845b53884a..3540c46dddc 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -1,29 +1,37 @@
 #! /usr/bin/env python3
 #
-# Copyright (C) 2018 Garmin Ltd.
+# Copyright (C) 2018-2019 Garmin Ltd.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import unittest
-import multiprocessing
-import sqlite3
+from . import create_server, create_client
 import hashlib
-import urllib.request
-import json
+import logging
+import multiprocessing
+import sys
 import tempfile
-from . import create_server
+import threading
+import unittest
+
+
+class TestHashEquivalenceServer(object):
+    METHOD = 'TestMethod'
+
+    def _run_server(self):
+        # logging.basicConfig(level=logging.DEBUG, filename='bbhashserv.log', filemode='w',
+        #                     format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
+        self.server.serve_forever()
 
-class TestHashEquivalenceServer(unittest.TestCase):
     def setUp(self):
-        # Start a hash equivalence server in the background bound to
-        # an ephemeral port
-        self.dbfile = tempfile.NamedTemporaryFile(prefix="bb-hashserv-db-")
-        self.server = create_server(('localhost', 0), self.dbfile.name)
-        self.server_addr = 'http://localhost:%d' % self.server.socket.getsockname()[1]
-        self.server_thread = multiprocessing.Process(target=self.server.serve_forever)
+        self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-hashserv')
+        self.dbfile = os.path.join(self.temp_dir.name, 'db.sqlite')
+
+        self.server = create_server(self.get_server_addr(), self.dbfile)
+        self.server_thread = multiprocessing.Process(target=self._run_server)
         self.server_thread.daemon = True
         self.server_thread.start()
+        self.client = create_client(self.server.address)
 
     def tearDown(self):
         # Shutdown server
@@ -31,19 +39,8 @@ class TestHashEquivalenceServer(unittest.TestCase):
         if s is not None:
             self.server_thread.terminate()
             self.server_thread.join()
-
-    def send_get(self, path):
-        url = '%s/%s' % (self.server_addr, path)
-        request = urllib.request.Request(url)
-        response = urllib.request.urlopen(request)
-        return json.loads(response.read().decode('utf-8'))
-
-    def send_post(self, path, data):
-        headers = {'content-type': 'application/json'}
-        url = '%s/%s' % (self.server_addr, path)
-        request = urllib.request.Request(url, json.dumps(data).encode('utf-8'), headers)
-        response = urllib.request.urlopen(request)
-        return json.loads(response.read().decode('utf-8'))
+        self.client.close()
+        self.temp_dir.cleanup()
 
     def test_create_hash(self):
         # Simple test that hashes can be created
@@ -51,16 +48,11 @@ class TestHashEquivalenceServer(unittest.TestCase):
         outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
         unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
 
-        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
-        self.assertIsNone(d, msg='Found unexpected task, %r' % d)
+        result = self.client.get_unihash(self.METHOD, taskhash)
+        self.assertIsNone(result, msg='Found unexpected task, %r' % result)
 
-        d = self.send_post('v1/equivalent', {
-            'taskhash': taskhash,
-            'method': 'TestMethod',
-            'outhash': outhash,
-            'unihash': unihash,
-            })
-        self.assertEqual(d['unihash'], unihash, 'Server returned bad unihash')
+        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
     def test_create_equivalent(self):
         # Tests that a second reported task with the same outhash will be
@@ -68,25 +60,16 @@ class TestHashEquivalenceServer(unittest.TestCase):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
         unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
-        d = self.send_post('v1/equivalent', {
-            'taskhash': taskhash,
-            'method': 'TestMethod',
-            'outhash': outhash,
-            'unihash': unihash,
-            })
-        self.assertEqual(d['unihash'], unihash, 'Server returned bad unihash')
+
+        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
         # Report a different task with the same outhash. The returned unihash
         # should match the first task
         taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
-        d = self.send_post('v1/equivalent', {
-            'taskhash': taskhash2,
-            'method': 'TestMethod',
-            'outhash': outhash,
-            'unihash': unihash2,
-            })
-        self.assertEqual(d['unihash'], unihash, 'Server returned bad unihash')
+        result = self.client.report_unihash(taskhash2, self.METHOD, outhash, unihash2)
+        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
     def test_duplicate_taskhash(self):
         # Tests that duplicate reports of the same taskhash with different
@@ -95,38 +78,63 @@ class TestHashEquivalenceServer(unittest.TestCase):
         taskhash = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
         outhash = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
         unihash = '218e57509998197d570e2c98512d0105985dffc9'
-        d = self.send_post('v1/equivalent', {
-            'taskhash': taskhash,
-            'method': 'TestMethod',
-            'outhash': outhash,
-            'unihash': unihash,
-            })
+        self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
 
-        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
-        self.assertEqual(d['unihash'], unihash)
+        result = self.client.get_unihash(self.METHOD, taskhash)
+        self.assertEqual(result, unihash)
 
         outhash2 = '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d'
         unihash2 = 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
-        d = self.send_post('v1/equivalent', {
-            'taskhash': taskhash,
-            'method': 'TestMethod',
-            'outhash': outhash2,
-            'unihash': unihash2
-            })
+        self.client.report_unihash(taskhash, self.METHOD, outhash2, unihash2)
 
-        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
-        self.assertEqual(d['unihash'], unihash)
+        result = self.client.get_unihash(self.METHOD, taskhash)
+        self.assertEqual(result, unihash)
 
         outhash3 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
         unihash3 = '9217a7d6398518e5dc002ed58f2cbbbc78696603'
-        d = self.send_post('v1/equivalent', {
-            'taskhash': taskhash,
-            'method': 'TestMethod',
-            'outhash': outhash3,
-            'unihash': unihash3
-            })
+        self.client.report_unihash(taskhash, self.METHOD, outhash3, unihash3)
+
+        result = self.client.get_unihash(self.METHOD, taskhash)
+        self.assertEqual(result, unihash)
+
+    def test_stress(self):
+        def query_server(failures):
+            client = Client(self.server.address)
+            try:
+                for i in range(1000):
+                    taskhash = hashlib.sha256()
+                    taskhash.update(str(i).encode('utf-8'))
+                    taskhash = taskhash.hexdigest()
+                    result = client.get_unihash(self.METHOD, taskhash)
+                    if result != taskhash:
+                        failures.append("taskhash mismatch: %s != %s" % (result, taskhash))
+            finally:
+                client.close()
+
+        # Report hashes
+        for i in range(1000):
+            taskhash = hashlib.sha256()
+            taskhash.update(str(i).encode('utf-8'))
+            taskhash = taskhash.hexdigest()
+            self.client.report_unihash(taskhash, self.METHOD, taskhash, taskhash)
+
+        failures = []
+        threads = [threading.Thread(target=query_server, args=(failures,)) for t in range(100)]
+
+        for t in threads:
+            t.start()
+
+        for t in threads:
+            t.join()
+
+        self.assertFalse(failures)
+
 
-        d = self.send_get('v1/equivalent?method=TestMethod&taskhash=%s' % taskhash)
-        self.assertEqual(d['unihash'], unihash)
+class TestHashEquivalenceUnixServer(TestHashEquivalenceServer, unittest.TestCase):
+    def get_server_addr(self):
+        return "unix://" + os.path.join(self.temp_dir.name, 'sock')
 
 
+class TestHashEquivalenceTCPServer(TestHashEquivalenceServer, unittest.TestCase):
+    def get_server_addr(self):
+        return "localhost:0"
-- 
2.21.0


