Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id B61536F60F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:05:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29H4tYd020382
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:04:56 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id N_1fLue16HR4 for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:04:55 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29H4kXb020376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:04:51 GMT
Message-ID: <1394384681.7883.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 10:04:41 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/process: Deal more gracefully with SIGTERM
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
X-List-Received-Date: Sun, 09 Mar 2014 17:05:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently a SIGTERM to the UI process causes the UI simply to lock up.

By setting an exit flag, the waitEvent can raise a SIGINT, allowing the
UI to break out the event loop and exit. Currently this is results in a
traceback but that is more desirable than a hanging process.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 6db6a23..f9074fb 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -157,6 +157,10 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
         self.connection = ServerCommunicator(self.ui_channel, self.procserver.event_handle)
         self.events = self.event_queue
 
+    def sigterm_terminate(self):
+        bb.error("UI received SIGTERM")
+        self.terminate()
+
     def terminate(self):
         def flushevents():
             while True:
@@ -176,10 +180,20 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
 
         self.ui_channel.close()
         self.event_queue.close()
+        self.event_queue.setexit()
 
 # Wrap Queue to provide API which isn't server implementation specific
 class ProcessEventQueue(multiprocessing.queues.Queue):
+    def __init__(self, maxsize):
+        multiprocessing.queues.Queue.__init__(self, maxsize)
+        self.exit = False
+
+    def setexit(self):
+        self.exit = True
+
     def waitEvent(self, timeout):
+        if self.exit:
+            raise KeyboardInterrupt
         try:
             return self.get(True, timeout)
         except Empty:
@@ -214,5 +228,5 @@ class BitBakeServer(BitBakeBaseServer):
         if error:
             logger.error("Unable to set the cooker to the correct featureset: %s" % error)
             raise BaseException(error)
-        signal.signal(signal.SIGTERM, lambda i, s: self.connection.terminate())
+        signal.signal(signal.SIGTERM, lambda i, s: self.connection.sigterm_terminate())
         return self.connection



