Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 59D816F60F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:03:07 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29H329U020331
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:03:02 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id toVCVT7_zM1L for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:03:02 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29H2uk7020317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:03:00 GMT
Message-ID: <1394384570.7883.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 10:02:50 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/process: Use the setFeatures command on the server instead of a manger
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
X-List-Received-Date: Sun, 09 Mar 2014 17:03:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The use of a manager in the process server causes some issues since it remains
around for the lifetime of the server even though its only used during
initialisation and the system doesn't respond well to SIGTERM events
to the extra process (and two threads) the implementation involves.

Switching to a dedicated command simplifies the server process structure.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index aa07202..6db6a23 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -80,7 +80,7 @@ class ProcessServer(Process, BaseImplServer):
 
     def __init__(self, command_channel, event_queue, featurelist):
         BaseImplServer.__init__(self)
-        Process.__init__(self, args=(featurelist))
+        Process.__init__(self)
         self.command_channel = command_channel
         self.event_queue = event_queue
         self.event = EventAdapter(event_queue)
@@ -96,13 +96,6 @@ class ProcessServer(Process, BaseImplServer):
             self.event_queue.put(event)
         self.event_handle.value = bb.event.register_UIHhandler(self)
 
-        # process any feature changes based on what UI requested
-        original_featureset = list(self.cooker.featureset)
-        while len(self.featurelist)> 0:
-            self.cooker.featureset.setFeature(self.featurelist.pop())
-        if (original_featureset != list(self.cooker.featureset)):
-            self.cooker.reset()
-
         bb.cooker.server_main(self.cooker, self.main)
 
     def main(self):
@@ -207,17 +200,19 @@ class BitBakeServer(BitBakeBaseServer):
         #
         self.ui_channel, self.server_channel = Pipe()
         self.event_queue = ProcessEventQueue(0)
-        manager = Manager()
-        self.featurelist = manager.list()
-        self.serverImpl = ProcessServer(self.server_channel, self.event_queue, self.featurelist)
+        self.serverImpl = ProcessServer(self.server_channel, self.event_queue, None)
 
     def detach(self):
         self.serverImpl.start()
         return
 
     def establishConnection(self, featureset):
-        for f in featureset:
-            self.featurelist.append(f)
+
         self.connection = BitBakeProcessServerConnection(self.serverImpl, self.ui_channel, self.event_queue)
+
+        _, error = self.connection.connection.runCommand(["setFeatures", featureset])
+        if error:
+            logger.error("Unable to set the cooker to the correct featureset: %s" % error)
+            raise BaseException(error)
         signal.signal(signal.SIGTERM, lambda i, s: self.connection.terminate())
         return self.connection



