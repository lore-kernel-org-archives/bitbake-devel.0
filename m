Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0855678425
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Aug 2017 10:27:31 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7EARVx5025671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 14 Aug 2017 11:27:32 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dhCap-0001QP-7h; Mon, 14 Aug 2017 11:27:31 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 Aug 2017 11:27:30 +0100
Message-Id: <1502706450-5439-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Mon, 14 Aug 2017 11:27:32 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] process: Improve client disconnects
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
X-List-Received-Date: Mon, 14 Aug 2017 10:27:32 -0000

There have been cases where the server could loop indefinitely and incorrectly
handle client disconnects. In the EOFError case, ensure a full disconnect
happens in the alternative disconnect path to avoid this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index ee8b14e..a7a6fbf 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -134,6 +134,26 @@ class ProcessServer(multiprocessing.Process):
         if self.xmlrpc:
             fds.append(self.xmlrpc)
         print("Entering server connection loop")
+
+        def disconnect_client(self, fds):
+            if not self.haveui:
+                return
+            print("Disconnecting Client")
+            fds.remove(self.controllersock)
+            fds.remove(self.command_channel)
+            bb.event.unregister_UIHhandler(self.event_handle, True)
+            self.command_channel_reply.writer.close()
+            self.event_writer.writer.close()
+            del self.event_writer
+            self.controllersock.close()
+            self.controllersock = False
+            self.haveui = False
+            self.lastui = time.time()
+            self.cooker.clientComplete()
+            if self.timeout is None:
+                print("No timeout, exiting.")
+                self.quit = True
+
         while not self.quit:
             if self.sock in ready:
                 self.controllersock, address = self.sock.accept()
@@ -165,21 +185,8 @@ class ProcessServer(multiprocessing.Process):
                     self.haveui = True
 
                 except (EOFError, OSError):
-                    print("Disconnecting Client")
-                    fds.remove(self.controllersock)
-                    fds.remove(self.command_channel)
-                    bb.event.unregister_UIHhandler(self.event_handle, True)
-                    self.command_channel_reply.writer.close()
-                    self.event_writer.writer.close()
-                    del self.event_writer
-                    self.controllersock.close()
-                    self.controllersock = False
-                    self.haveui = False
-                    self.lastui = time.time()
-                    self.cooker.clientComplete()
-                    if self.timeout is None:
-                        print("No timeout, exiting.")
-                        self.quit = True
+                    disconnect_client(self, fds)
+
             if not self.timeout == -1.0 and not self.haveui and self.lastui and self.timeout and \
                     (self.lastui + self.timeout) < time.time():
                 print("Server timeout, exiting.")
@@ -191,6 +198,7 @@ class ProcessServer(multiprocessing.Process):
                 except EOFError:
                     # Client connection shutting down
                     ready = []
+                    disconnect_client(self, fds)
                     continue
                 if command[0] == "terminateServer":
                     self.quit = True
-- 
2.7.4


