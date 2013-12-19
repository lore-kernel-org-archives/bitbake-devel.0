Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8FAD960E97
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:41:04 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBJ9f0nE006238 for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:41:00 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vhyTcuxo-cgq for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:40:59 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBJ9euLe006231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:40:58 GMT
Message-ID: <1387446052.6402.66.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 19 Dec 2013 09:40:52 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Further extend bitbake -S output to view signature differences
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
X-List-Received-Date: Thu, 19 Dec 2013 09:41:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Based upon the list of difference starting points, we can use the siggen.find_siginfo()
function call and the difference printing code to provide a list of differences
between the current build target and whatever can be obtained from the sstate cache.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 37dc362..68c74fa 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -30,6 +30,7 @@ import stat
 import fcntl
 import errno
 import logging
+import re
 import bb
 from bb import msg, data, event
 from bb import monitordisk
@@ -43,6 +44,8 @@ except ImportError:
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
 
+__find_md5__ = re.compile( r'(?i)(?<![a-z0-9])[a-f0-9]{32}(?![a-z0-9])' )
+
 class RunQueueStats:
     """
     Holds statistics on the tasks handled by the associated runQueue
@@ -1026,8 +1029,10 @@ class RunQueue:
 
         if self.state is runQueueSceneInit:
             if self.cooker.configuration.dump_signatures:
-                self.print_diffscenetasks()
+                invalidtasks = self.print_diffscenetasks()
                 self.dump_signatures()
+                self.write_diffscenetasks(invalidtasks)
+                self.state = runQueueComplete
             else:
                 self.start_worker()
                 self.rqexe = RunQueueExecuteScenequeue(self)
@@ -1098,7 +1103,6 @@ class RunQueue:
             self.rqexe.finish()
 
     def dump_signatures(self):
-        self.state = runQueueComplete
         done = set()
         bb.note("Reparsing files to collect dependency data")
         for task in range(len(self.rqdata.runq_fnid)):
@@ -1188,6 +1192,46 @@ class RunQueue:
         if tasklist:
             bb.plain("The differences between the current build and any cached tasks start at the following tasks:\n" + "\n".join(tasklist))
 
+        return invalidtasks.difference(found)
+
+    def write_diffscenetasks(self, invalidtasks):
+
+        # Define recursion callback
+        def recursecb(key, hash1, hash2):
+            hashes = [hash1, hash2]
+            hashfiles = bb.siggen.find_siginfo(key, None, hashes, self.cfgData)
+
+            recout = []
+            if len(hashfiles) == 2:
+                out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb)
+                recout.extend(list('  ' + l for l in out2))
+            else:
+                recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
+
+            return recout
+
+
+        for task in invalidtasks:
+            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
+            pn = self.rqdata.dataCache.pkg_fn[fn]
+            taskname = self.rqdata.runq_task[task]
+            hashfn = self.rqdata.dataCache.hashfn[fn]
+            h = self.rqdata.runq_hash[task]
+            matches = bb.siggen.find_siginfo(pn, taskname, [], self.cfgData, hashfn)
+            match = None
+            for m in matches:
+                if h in m:
+                    match = m
+            if match is None:
+                bb.fatal("Can't find a task we're supposed to have written out? (hash: %s)?" % h)
+            matches = {k : v for k, v in matches.iteritems() if h not in k}
+            latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
+            prevh = __find_md5__.search(latestmatch).group(0)
+            output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
+            bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
+             
+
+
 class RunQueueExecute:
 
     def __init__(self, rq):



