Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 816856F7B1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 13:47:46 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2QDlfn9019084 for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 13:47:41 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id s4iddoACiw4H for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 13:47:41 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2QDlZBx019075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 13:47:37 GMT
Message-ID: <1395841649.24890.93.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Mar 2014 13:47:29 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue/siggen: Pass in commandline options to dump_sigs()
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
X-List-Received-Date: Wed, 26 Mar 2014 13:47:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This allows the commandline options to be processed in the dump signature
code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 423b03c..42b6c48 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1040,7 +1040,7 @@ class RunQueue:
             if dump:
                 if 'printdiff' in dump:
                     invalidtasks = self.print_diffscenetasks()
-                self.dump_signatures()
+                self.dump_signatures(dump)
                 if 'printdiff' in dump:
                     self.write_diffscenetasks(invalidtasks)
                 self.state = runQueueComplete
@@ -1113,7 +1113,7 @@ class RunQueue:
         else:
             self.rqexe.finish()
 
-    def dump_signatures(self):
+    def dump_signatures(self, options):
         done = set()
         bb.note("Reparsing files to collect dependency data")
         for task in range(len(self.rqdata.runq_fnid)):
@@ -1122,7 +1122,7 @@ class RunQueue:
                 the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn), self.cooker.data)
                 done.add(self.rqdata.runq_fnid[task])
 
-        bb.parse.siggen.dump_sigs(self.rqdata.dataCache)
+        bb.parse.siggen.dump_sigs(self.rqdata.dataCache, options)
 
         return
 
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index a54357a..a6d2859 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -59,7 +59,7 @@ class SignatureGenerator(object):
     def invalidate_task(self, task, d, fn):
         bb.build.del_stamp(task, d, fn)
 
-    def dump_sigs(self, dataCache):
+    def dump_sigs(self, dataCache, options):
         return
 
 class SignatureGeneratorBasic(SignatureGenerator):
@@ -251,7 +251,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 pass
             raise err
 
-    def dump_sigs(self, dataCache):
+    def dump_sigs(self, dataCache, options):
         for fn in self.taskdeps:
             for task in self.taskdeps[fn]:
                 k = fn + "." + task



