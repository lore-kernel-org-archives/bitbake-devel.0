Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 639656EE8A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 13:47:09 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2QDl4gk019068 for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 13:47:04 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2P1H5c_NIBcU for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 13:47:04 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2QDl0GH019054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 13:47:02 GMT
Message-ID: <1395841614.24890.92.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Mar 2014 13:46:54 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: Force -S option to take a parameter
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
X-List-Received-Date: Wed, 26 Mar 2014 13:47:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There is no easy way to make this change. We really need parameters for the -S
(dump signatures) handling code. Such a parameter can then be used within the
codebase to handle the signatures in different ways.

For now, "none" is the recommended default and "printdiff" will execute the
new (and more expensive) comparison algorithms.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 5c0b2d4..b173f16 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -139,8 +139,8 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-n", "--dry-run", help = "Don't execute, just go through the motions.",
                    action = "store_true", dest = "dry_run", default = False)
 
-        parser.add_option("-S", "--dump-signatures", help = "Don't execute, just dump out the signature construction information.",
-                   action = "store_true", dest = "dump_signatures", default = False)
+        parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. Parameters are passed to the signature handling code, use 'none' if no specific handler is required.",
+                   action = "append", dest = "dump_signatures", default = [])
 
         parser.add_option("-p", "--parse-only", help = "Quit after parsing the BB recipes.",
                    action = "store_true", dest = "parse_only", default = False)
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 6200b0e..b9b9e16 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -124,7 +124,7 @@ class CookerConfiguration(object):
         self.profile = False
         self.nosetscene = False
         self.invalidate_stamp = False
-        self.dump_signatures = False
+        self.dump_signatures = []
         self.dry_run = False
         self.tracking = False
         self.interface = []
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 90fe40b..423b03c 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1036,10 +1036,13 @@ class RunQueue:
                     bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
 
         if self.state is runQueueSceneInit:
-            if self.cooker.configuration.dump_signatures:
-                invalidtasks = self.print_diffscenetasks()
+            dump = self.cooker.configuration.dump_signatures
+            if dump:
+                if 'printdiff' in dump:
+                    invalidtasks = self.print_diffscenetasks()
                 self.dump_signatures()
-                self.write_diffscenetasks(invalidtasks)
+                if 'printdiff' in dump:
+                    self.write_diffscenetasks(invalidtasks)
                 self.state = runQueueComplete
             else:
                 self.start_worker()



