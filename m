Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 395F97422C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Sep 2015 15:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t87Ftk9m029202 for <bitbake-devel@lists.openembedded.org>;
	Mon, 7 Sep 2015 16:55:46 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ehGYZSKk-mJu for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Sep 2015 16:55:46 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t87FtY79029191
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 7 Sep 2015 16:55:46 +0100
Message-ID: <1441641334.24871.255.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 07 Sep 2015 16:55:34 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] server/process: Handle SIGTERM more gracefully
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
X-List-Received-Date: Mon, 07 Sep 2015 15:55:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if you send a SIGTERM to the bitbake UI process, the system basically
hangs if tasks are executing. This is because the server process doesn't
actually try any kind of shutdown before exiting.

This patch trys executing a stateForceShutdown command first, which is
enough to stop any active tasks before the system exits.

I also noticed that terminate can execute multiple times, once at SIGTERM
from the handler and once from the real exit. Double execution leads to
stack traces and potential hangs (writes to dead pipes), so ensure
the code only can run once.

With these fixes, bitbake much more correctly deals with SIGTERM to the
UI process.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index f022b86..5fca350 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -114,6 +114,10 @@ class ProcessServer(Process, BaseImplServer):
                 if self.quitout.poll():
                     self.quitout.recv()
                     self.quit = True
+                    try:
+                        self.runCommand(["stateForceShutdown"])
+                    except:
+                        pass
 
                 self.idle_commands(.1, [self.command_channel, self.quitout])
             except Exception:
@@ -123,6 +127,7 @@ class ProcessServer(Process, BaseImplServer):
         bb.event.unregister_UIHhandler(self.event_handle.value)
         self.command_channel.close()
         self.cooker.shutdown(True)
+        self.quitout.close()
 
     def idle_commands(self, delay, fds=None):
         nextsleep = delay
@@ -172,12 +177,16 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
         self.event_queue = event_queue
         self.connection = ServerCommunicator(self.ui_channel, self.procserver.event_handle, self.procserver)
         self.events = self.event_queue
+        self.terminated = False
 
     def sigterm_terminate(self):
         bb.error("UI received SIGTERM")
         self.terminate()
 
     def terminate(self):
+        if self.terminated:
+            return
+        self.terminated = True
         def flushevents():
             while True:
                 try:



