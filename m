Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4DFC86AFCD
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Aug 2013 12:07:34 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OCJZgV016973; Sat, 24 Aug 2013 13:19:35 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KASTxvTh7G5e; Sat, 24 Aug 2013 13:19:35 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OCJVxY016967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sat, 24 Aug 2013 13:19:33 +0100
Message-ID: <1377346040.6762.186.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 24 Aug 2013 13:07:20 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] process: Improve exit handling and hangs
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
X-List-Received-Date: Sat, 24 Aug 2013 12:07:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

It turns out we have a number of different ways the process server termination can
hang. If we call cancel_join_thread() on the event queue, it means that it can be left
containing partial data. This means the reading of the event queue in the terminate()
function can hang, the timeout and block parameters to Queue.get() don't make any
difference.

Equally, if we don't call cancel_join_thread(), the join_thread in terminate()
will hang giving a different deadlock.

The best solution I could find is to loop over the process is_alive() after requesting
it stops,  trying to join the thread and if that fails, try and flush the event
queue again.

It wasn't clear what difference a force option should make in this case, we're
gracefully trying to empty queues and shut down regardless of whether its a SIGTERM
so I've simply removed the force option.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---

Jason: Not sure if this or the other patch will help the hang you are
seeing or not but they seem like good changes regardless and fix real
world issues.

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 0d4a26c..99a6bf5 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -105,7 +105,7 @@ class ProcessServer(Process, BaseImplServer):
             except Exception:
                 logger.exception('Running command %s', command)
 
-        self.event_queue.cancel_join_thread()
+        self.event_queue.close()
         bb.event.unregister_UIHhandler(self.event_handle)
         self.command_channel.close()
         self.cooker.stop()
@@ -150,27 +150,25 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
         self.connection = ServerCommunicator(self.ui_channel)
         self.events = self.event_queue
 
-    def terminate(self, force = False):
+    def terminate(self):
+        def flushevents():
+            while True:
+                try:
+                    event = self.event_queue.get(block=False)
+                except (Empty, IOError):
+                    break
+                if isinstance(event, logging.LogRecord):
+                    logger.handle(event)
+
         signal.signal(signal.SIGINT, signal.SIG_IGN)
         self.procserver.stop()
-        if force:
-            self.procserver.join(0.5)
-            if self.procserver.is_alive():
-                self.procserver.terminate()
-                self.procserver.join()
-        else:
-            self.procserver.join()
-        while True:
-            try:
-                event = self.event_queue.get(block=False)
-            except (Empty, IOError):
-                break
-            if isinstance(event, logging.LogRecord):
-                logger.handle(event)
+
+        while self.procserver.is_alive():
+            flushevents()
+            self.procserver.join(0.1)
+
         self.ui_channel.close()
         self.event_queue.close()
-        if force:
-            sys.exit(1)
 
 # Wrap Queue to provide API which isn't server implementation specific
 class ProcessEventQueue(multiprocessing.queues.Queue):
@@ -203,5 +201,5 @@ class BitBakeServer(BitBakeBaseServer):
 
     def establishConnection(self):
         self.connection = BitBakeProcessServerConnection(self.serverImpl, self.ui_channel, self.event_queue)
-        signal.signal(signal.SIGTERM, lambda i, s: self.connection.terminate(force=True))
+        signal.signal(signal.SIGTERM, lambda i, s: self.connection.terminate())
         return self.connection



