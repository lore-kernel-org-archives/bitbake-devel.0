Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHPd-0003U1-I6
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:34:02 +0100
Received: by opal (Postfix, from userid 111)
	id 203AE10335; Fri, 20 Jan 2012 16:35:56 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120163556.203AE10335@opal>
Date: Fri, 20 Jan 2012 16:35:56 +0000 (UTC)
From: git@git.openembedded.org
Subject: Christopher Larson : cooker: use futures rather than a multiprocessing pool
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 20 Jan 2012 16:34:02 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: d104f29871c04a5a36600a35b2568b49e5b21ca0
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=d104f29871c04a5a36600a35b2568b49e5b21ca0

Author: Christopher Larson <chris_larson@mentor.com>
Date:   Sun Jan  8 23:21:27 2012 -0600

cooker: use futures rather than a multiprocessing pool

This avoids some silent parser hangs we were seeing which were
near impossible to debug as no user feedback was given.

[RP: Tweak commit message]
Signed-off-by: Christopher Larson <chris_larson@mentor.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4197a02..cbac1f7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -32,6 +32,7 @@ import sre_constants
 import threading
 from cStringIO import StringIO
 from contextlib import closing
+from concurrent import futures
 from functools import wraps
 from collections import defaultdict
 import bb, bb.exceptions, bb.command
@@ -1462,20 +1463,16 @@ class CookerParser(object):
         self.start()
 
     def start(self):
-        def init(cfg):
-            parse_file.cfg = cfg
-            multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, args=(self.cooker.configuration.data, ), exitpriority=1)
-
         self.results = self.load_cached()
 
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
 
-            self.pool = multiprocessing.Pool(self.num_processes, init, [self.cfgdata])
-            parsed = self.pool.imap(parse_file, self.willparse)
-            self.pool.close()
-
-            self.results = itertools.chain(self.results, parsed)
+            parse_file.cfg = self.cfgdata
+            multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, args=(self.cfgdata,), exitpriority=1)
+            self.executor = futures.ProcessPoolExecutor(max_workers=self.num_processes)
+            self.futures = dict((self.executor.submit(parse_file, task), task) for task in self.willparse)
+            self.results = itertools.chain(self.results, self.parse_gen())
 
     def shutdown(self, clean=True):
         if not self.toparse:
@@ -1488,8 +1485,9 @@ class CookerParser(object):
                                             self.total)
             bb.event.fire(event, self.cfgdata)
         else:
-            self.pool.terminate()
-        self.pool.join()
+            for future in self.futures:
+                future.cancel()
+        self.executor.shutdown()
 
         sync = threading.Thread(target=self.bb_cache.sync)
         sync.start()
@@ -1501,6 +1499,15 @@ class CookerParser(object):
             cached, infos = self.bb_cache.load(filename, appends, self.cfgdata)
             yield not cached, infos
 
+    def parse_gen(self):
+        for future in futures.as_completed(self.futures):
+            task = self.futures[future]
+            exc = future.exception()
+            if exc:
+                raise exc
+            else:
+                yield future.result()
+
     def parse_next(self):
         try:
             parsed, result = self.results.next()



