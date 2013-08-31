Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A024F6BD80
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 22:41:11 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMrqUU008513 for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:53:53 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HeVgQDf53_x0 for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:53:52 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMrk3S008509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:53:47 +0100
Message-ID: <1377988855.1059.129.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 31 Aug 2013 23:40:55 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/process, server/xmlrpc, runqueue: Use select.select() on fds, not time.sleep()
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
X-List-Received-Date: Sat, 31 Aug 2013 22:41:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The existing backend server implementations were inefficient since they
were sleeping for the full length of the timeouts rather than being woken when
there was data ready for them. It was assumed they would wake and perhaps did
when we forked processes directory but that is no longer the case.

This updates both the process and xmlrpc backends to wait using select(). This
does mean we need to pass the file descriptors to wait on from the internals
who know which these file descriptors are but this is a logical improvement.

Tests of a pathaolgical load on the process server of ~420 rapid tasks
executed on a server with BB_NUMBER_THREAD=48  went from a wall clock
measurement of the overall command execution time of 75s to a much more
reasonable 24s.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 075c849..197308f 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -895,6 +895,14 @@ class RunQueue:
         if self.fakeworkerpipe:
             self.fakeworkerpipe.read()
 
+    def active_fds(self):
+        fds = []
+        if self.workerpipe:
+            fds.append(self.workerpipe.input)
+        if self.fakeworkerpipe:
+            fds.append(self.fakeworkerpipe.input)
+        return fds
+
     def check_stamp_task(self, task, taskname = None, recurse = False, cache = None):
         def get_timestamp(f):
             try:
@@ -972,7 +980,7 @@ class RunQueue:
         (if the abort on failure configuration option isn't set)
         """
 
-        retval = 0.5
+        retval = True
 
         if self.state is runQueuePrepare:
             self.rqexe = RunQueueExecuteDummy(self)
@@ -1375,7 +1383,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         if self.stats.active > 0:
             self.rq.read_workers()
-            return 0.5
+            return self.rq.active_fds()
 
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index e2cec49..c0af052 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -29,6 +29,7 @@ import os
 import signal
 import sys
 import time
+import select
 from Queue import Empty
 from multiprocessing import Event, Process, util, Queue, Pipe, queues
 
@@ -105,7 +106,7 @@ class ProcessServer(Process, BaseImplServer):
                     command = self.command_channel.recv()
                     self.runCommand(command)
 
-                self.idle_commands(.1)
+                self.idle_commands(.1, [self.event_queue._reader, self.command_channel])
             except Exception:
                 logger.exception('Running command %s', command)
 
@@ -115,7 +116,7 @@ class ProcessServer(Process, BaseImplServer):
         self.cooker.stop()
         self.idle_commands(.1)
 
-    def idle_commands(self, delay):
+    def idle_commands(self, delay, fds = []):
         nextsleep = delay
 
         for function, data in self._idlefuns.items():
@@ -127,15 +128,15 @@ class ProcessServer(Process, BaseImplServer):
                     nextsleep = None
                 elif nextsleep is None:
                     continue
-                elif retval < nextsleep:
-                    nextsleep = retval
+                else:
+                    fds = fds + retval
             except SystemExit:
                 raise
             except Exception:
                 logger.exception('Running idle function')
 
         if nextsleep is not None:
-            time.sleep(nextsleep)
+            select.select(fds,[],[],nextsleep)
 
     def runCommand(self, command):
         """
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 641e15e..cca569d 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -264,12 +264,9 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         Serve Requests. Overloaded to honor a quit command
         """
         self.quit = False
-        self.timeout = 0 # Run Idle calls for our first callback
         while not self.quit:
-            #print "Idle queue length %s" % len(self._idlefuns)
-            self.handle_request()
-            #print "Idle timeout, running idle functions"
-            nextsleep = None
+            fds = [self]
+            nextsleep = 0.1
             for function, data in self._idlefuns.items():
                 try:
                     retval = function(self, data, False)
@@ -277,21 +274,22 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
                         del self._idlefuns[function]
                     elif retval is True:
                         nextsleep = 0
-                    elif nextsleep is 0:
-                        continue
-                    elif nextsleep is None:
-                        nextsleep = retval
-                    elif retval < nextsleep:
-                        nextsleep = retval
+                    else:
+                        fds = fds + retval
                 except SystemExit:
                     raise
                 except:
                     import traceback
                     traceback.print_exc()
                     pass
-            if nextsleep is None and len(self._idlefuns) > 0:
-                nextsleep = 0
-            self.timeout = nextsleep
+
+            socktimeout = self.socket.gettimeout() or nextsleep
+            socktimeout = min(socktimeout, nextsleep)
+            # Mirror what BaseServer handle_request would do
+            fd_sets = select.select(fds, [], [], socktimeout)
+            if fd_sets[0] and self in fd_sets[0]:
+                self._handle_request_noblock()
+
         # Tell idle functions we're exiting
         for function, data in self._idlefuns.items():
             try:



