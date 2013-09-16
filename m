Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 02474605F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:53:57 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM85kA029314; Mon, 16 Sep 2013 23:08:05 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3-9ZUzO74A19; Mon, 16 Sep 2013 23:08:05 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM7wlT029295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:00 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjl-0002Z5-4o; Mon, 16 Sep 2013 22:53:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:18 +0100
Message-Id: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 01/16] cooker: Allow profiling of the parser in profile mode
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:00 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a07615b..2c8d4dc 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1480,7 +1480,7 @@ class Feeder(multiprocessing.Process):
                 continue
 
 class Parser(multiprocessing.Process):
-    def __init__(self, jobs, results, quit, init):
+    def __init__(self, jobs, results, quit, init, profile):
         self.jobs = jobs
         self.results = results
         self.quit = quit
@@ -1488,8 +1488,28 @@ class Parser(multiprocessing.Process):
         multiprocessing.Process.__init__(self)
         self.context = bb.utils.get_context().copy()
         self.handlers = bb.event.get_class_handlers().copy()
+        self.profile = profile
 
     def run(self):
+
+        if not self.profile:
+            self.realrun()
+            return
+
+        try:
+            import cProfile as profile
+        except:
+            import profile
+        prof = profile.Profile()
+        try:
+            profile.Profile.runcall(prof, self.realrun)
+        finally:
+            logfile = "profile-parse-%s.log" % multiprocessing.current_process().name
+            prof.dump_stats(logfile)
+            bb.utils.process_profilelog(logfile)
+            print("Raw profiling information saved to %s and processed statistics to %s.processed" % (logfile, logfile))
+
+    def realrun(self):
         if self.init:
             self.init()
 
@@ -1590,7 +1610,7 @@ class CookerParser(object):
             self.feeder = Feeder(self.willparse, self.jobs, self.feeder_quit)
             self.feeder.start()
             for i in range(0, self.num_processes):
-                parser = Parser(self.jobs, self.result_queue, self.parser_quit, init)
+                parser = Parser(self.jobs, self.result_queue, self.parser_quit, init, self.cooker.configuration.profile)
                 parser.start()
                 self.processes.append(parser)
 
-- 
1.8.1.2


