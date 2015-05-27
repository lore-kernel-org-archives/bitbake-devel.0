Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B767372D64
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 16:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGVNFX024845 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:31:23 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WcrL1xpSrnYs for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:31:23 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGVAUA024842
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:31:21 +0100
Message-ID: <1432744270.404.51.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 May 2015 17:31:10 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] cooker/utils: Improve parsing profiling
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
X-List-Received-Date: Wed, 27 May 2015 16:31:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently the cooker parsing processes each dump an individual profile
which is ok, but means absolute numbers of function calls for a given load
can be tricky to determine as parsing of recipes may go to different pool
threads on different runs.

This change collects up the individual thread parsing results and processes
them into one profile output. The profile processing function in utils
needed tweaks to allow this to work.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ddf5fed..577d808 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1798,8 +1798,6 @@ class Parser(multiprocessing.Process):
         finally:
             logfile = "profile-parse-%s.log" % multiprocessing.current_process().name
             prof.dump_stats(logfile)
-            bb.utils.process_profilelog(logfile)
-            print("Raw profiling information saved to %s and processed statistics to %s.processed" % (logfile, logfile))
 
     def realrun(self):
         if self.init:
@@ -1869,6 +1867,7 @@ class CookerParser(object):
         self.current = 0
         self.num_processes = int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS", True) or
                                  multiprocessing.cpu_count())
+        self.process_names = []
 
         self.bb_cache = bb.cache.Cache(self.cfgdata, self.cfghash, cooker.caches_array)
         self.fromcache = []
@@ -1904,6 +1903,7 @@ class CookerParser(object):
             for i in range(0, self.num_processes):
                 parser = Parser(self.jobs, self.result_queue, self.parser_quit, init, self.cooker.configuration.profile)
                 parser.start()
+                self.process_names.append(parser.name)
                 self.processes.append(parser)
 
             self.results = itertools.chain(self.results, self.parse_generator())
@@ -1947,6 +1947,16 @@ class CookerParser(object):
         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
         bb.codeparser.parser_cache_savemerge(self.cooker.data)
         bb.fetch.fetcher_parse_done(self.cooker.data)
+        if self.cooker.configuration.profile:
+            profiles = []
+            for i in self.process_names:
+                logfile = "profile-parse-%s.log" % i
+                if os.path.exists(logfile):
+                    profiles.append(logfile)
+
+            pout = "profile-parse.log.processed"
+            bb.utils.process_profilelog(profiles, pout = pout)
+            print("Processed parsing statistics saved to %s" % (pout))
 
     def load_cached(self):
         for filename, appends in self.fromcache:
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 988b845..857f5bc 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -908,11 +908,17 @@ def cpu_count():
 def nonblockingfd(fd):
     fcntl.fcntl(fd, fcntl.F_SETFL, fcntl.fcntl(fd, fcntl.F_GETFL) | os.O_NONBLOCK)
 
-def process_profilelog(fn):
-    pout = open(fn + '.processed', 'w')
+def process_profilelog(fn, pout = None):
+    # Either call with a list of filenames and set pout or a filename and optionally pout.
+    if not pout:
+        pout = fn + '.processed'
+    pout = open(pout, 'w')
    
     import pstats
-    p = pstats.Stats(fn, stream=pout)
+    if isinstance(fn, list):
+        p = pstats.Stats(*fn, stream=pout)
+    else:
+        p = pstats.Stats(fn, stream=pout)
     p.sort_stats('time')
     p.print_stats()
     p.print_callers()



