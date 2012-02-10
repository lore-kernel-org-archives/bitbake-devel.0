Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RvvC4-0003OU-NA
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Feb 2012 19:27:37 +0100
Received: by ghbf19 with SMTP id f19so1618297ghb.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Feb 2012 10:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references;
	bh=VlB7Rccsa018D+7fzqMWP7Z/2OJfuCRYvPyqmbR3C7s=;
	b=cZFwfQU0bmv9NyoW4SRZ8TpxDSu6q2VKhdddsPr+1BQ28NVGbkBI4O+lAxCih9xKJo
	/dVasXdZXHux6zz2E6FhMKoZ9b5gphBx4VxCHsIZWNgk9Jm8URb1pOGHqVb0kzrUazYf
	0bhLZwslsLwyOS8ONrmGds4vPEAwGtqcCTKCs=
Received: by 10.236.123.101 with SMTP id u65mr10378915yhh.34.1328897970320;
	Fri, 10 Feb 2012 10:19:30 -0800 (PST)
Received: from localhost.localdomain (hsvwanfw1-nat.mentorg.com.
	[139.181.24.34])
	by mx.google.com with ESMTPS id 34sm15352384anp.13.2012.02.10.10.19.29
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 10 Feb 2012 10:19:29 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Feb 2012 12:19:22 -0600
Message-Id: <7c39cfd8e060cca8753ac4114775447b18e13067.1328897859.git.chris_larson@mentor.com>
X-Mailer: git-send-email 1.7.7
In-Reply-To: <cover.1328897859.git.chris_larson@mentor.com>
References: <cover.1328897859.git.chris_larson@mentor.com>
In-Reply-To: <cover.1328897859.git.chris_larson@mentor.com>
References: <cover.1328897859.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/2] cooker: roll our own process pool
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
X-List-Received-Date: Fri, 10 Feb 2012 18:27:37 -0000

From: Christopher Larson <chris_larson@mentor.com>

This fixes the hang issue encountered with parse errors. The underlying issue
seems to have been the pool.terminate(). This sends SIGTERM to each of the
multiprocessing pool's processes, however, a python process terminating in
this fashion can corrupt any queues it's interacting with, causing a number of
problems for us (e.g. the queue that sends events to the UI).

So instead of using multiprocessing's pool, we roll our own, with the ability
to cancel the work. In the very long term, the python concurrent.futures
module introduced in python 3.2 could be used to resolve this as well.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/cooker.py |  155 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 129 insertions(+), 26 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index bb09dff..8188aae 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -36,6 +36,7 @@ from functools import wraps
 from collections import defaultdict
 import bb, bb.exceptions, bb.command
 from bb import utils, data, parse, event, cache, providers, taskdata, runqueue
+import Queue
 import prserv.serv
 
 logger      = logging.getLogger("BitBake")
@@ -1402,20 +1403,87 @@ class ParsingFailure(Exception):
         self.recipe = recipe
         Exception.__init__(self, realexception, recipe)
 
-def parse_file(task):
-    filename, appends, caches_array = task
-    try:
-        return True, bb.cache.Cache.parse(filename, appends, parse_file.cfg, caches_array)
-    except Exception as exc:
-        tb = sys.exc_info()[2]
-        exc.recipe = filename
-        exc.traceback = list(bb.exceptions.extract_traceback(tb, context=3))
-        raise exc
-    # Need to turn BaseExceptions into Exceptions here so we gracefully shutdown
-    # and for example a worker thread doesn't just exit on its own in response to
-    # a SystemExit event for example.
-    except BaseException as exc:
-        raise ParsingFailure(exc, filename)
+class Feeder(multiprocessing.Process):
+    def __init__(self, jobs, to_parsers, quit):
+        self.quit = quit
+        self.jobs = jobs
+        self.to_parsers = to_parsers
+        multiprocessing.Process.__init__(self)
+
+    def run(self):
+        while True:
+            try:
+                quit = self.quit.get_nowait()
+            except Queue.Empty:
+                pass
+            else:
+                if quit == 'cancel':
+                    self.to_parsers.cancel_join_thread()
+                break
+
+            try:
+                job = self.jobs.pop()
+            except IndexError:
+                break
+
+            try:
+                self.to_parsers.put(job, timeout=0.5)
+            except Queue.Full:
+                self.jobs.insert(0, job)
+                continue
+
+class Parser(multiprocessing.Process):
+    def __init__(self, jobs, results, quit, init):
+        self.jobs = jobs
+        self.results = results
+        self.quit = quit
+        self.init = init
+        multiprocessing.Process.__init__(self)
+
+    def run(self):
+        if self.init:
+            self.init()
+
+        pending = []
+        while True:
+            try:
+                self.quit.get_nowait()
+            except Queue.Empty:
+                pass
+            else:
+                self.results.cancel_join_thread()
+                break
+
+            if pending:
+                result = pending.pop()
+            else:
+                try:
+                    job = self.jobs.get(timeout=0.25)
+                except Queue.Empty:
+                    continue
+
+                if job is None:
+                    break
+                result = self.parse(*job)
+
+            try:
+                self.results.put(result, timeout=0.25)
+            except Queue.Full:
+                pending.append(result)
+
+    def parse(self, filename, appends, caches_array):
+        try:
+            return True, bb.cache.Cache.parse(filename, appends, self.cfg, caches_array)
+        except Exception as exc:
+            tb = sys.exc_info()[2]
+            exc.recipe = filename
+            exc.traceback = list(bb.exceptions.extract_traceback(tb, context=3))
+            return True, exc
+        # Need to turn BaseExceptions into Exceptions here so we gracefully shutdown
+        # and for example a worker thread doesn't just exit on its own in response to
+        # a SystemExit event for example.
+        except BaseException as exc:
+            return True, ParsingFailure(exc, filename)
 
 class CookerParser(object):
     def __init__(self, cooker, filelist, masked):
@@ -1452,22 +1520,28 @@ class CookerParser(object):
         self.start()
 
     def start(self):
-        def init(cfg):
-            parse_file.cfg = cfg
-            multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, args=(self.cooker.configuration.data, ), exitpriority=1)
-
         self.results = self.load_cached()
-
+        self.processes = []
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
+            def init():
+                Parser.cfg = self.cfgdata
+                multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, args=(self.cfgdata,), exitpriority=1)
 
-            self.pool = multiprocessing.Pool(self.num_processes, init, [self.cfgdata])
-            parsed = self.pool.imap(parse_file, self.willparse)
-            self.pool.close()
+            self.feeder_quit = multiprocessing.Queue(maxsize=1)
+            self.parser_quit = multiprocessing.Queue(maxsize=self.num_processes)
+            self.jobs = multiprocessing.Queue(maxsize=self.num_processes)
+            self.result_queue = multiprocessing.Queue()
+            self.feeder = Feeder(self.willparse, self.jobs, self.feeder_quit)
+            self.feeder.start()
+            for i in range(1, self.num_processes):
+                parser = Parser(self.jobs, self.result_queue, self.parser_quit, init)
+                parser.start()
+                self.processes.append(parser)
 
-            self.results = itertools.chain(self.results, parsed)
+            self.results = itertools.chain(self.results, self.parse_generator())
 
-    def shutdown(self, clean=True):
+    def shutdown(self, clean=True, force=False):
         if not self.toparse:
             return
 
@@ -1477,9 +1551,22 @@ class CookerParser(object):
                                             self.virtuals, self.error,
                                             self.total)
             bb.event.fire(event, self.cfgdata)
+            self.feeder_quit.put(None)
+            for process in self.processes:
+                self.jobs.put(None)
         else:
-            self.pool.terminate()
-        self.pool.join()
+            self.feeder_quit.put('cancel')
+
+            self.parser_quit.cancel_join_thread()
+            for process in self.processes:
+                self.parser_quit.put(None)
+
+            self.jobs.cancel_join_thread()
+            sys.exit(1)
+
+        for process in self.processes:
+            process.join()
+        self.feeder.join()
 
         sync = threading.Thread(target=self.bb_cache.sync)
         sync.start()
@@ -1491,6 +1578,22 @@ class CookerParser(object):
             cached, infos = self.bb_cache.load(filename, appends, self.cfgdata)
             yield not cached, infos
 
+    def parse_generator(self):
+        while True:
+            if self.parsed >= self.toparse:
+                break
+
+            try:
+                result = self.result_queue.get(timeout=0.25)
+            except Queue.Empty:
+                pass
+            else:
+                value = result[1]
+                if isinstance(value, BaseException):
+                    raise value
+                else:
+                    yield result
+
     def parse_next(self):
         try:
             parsed, result = self.results.next()
-- 
1.7.7



