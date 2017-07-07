Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7775A71ABC
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jul 2017 14:48:57 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v67Emu5h006261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 7 Jul 2017 15:48:57 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dTUYy-0007bM-M8; Fri, 07 Jul 2017 15:48:56 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Jul 2017 15:48:54 +0100
Message-Id: <1499438935-29179-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 07 Jul 2017 15:48:57 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/2] event: Queue offline events for the UI
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
X-List-Received-Date: Fri, 07 Jul 2017 14:48:59 -0000

Messages printed when no UI is connected (e.g. memres) are currently lost.
Use the existing queue mechanism to queue these until a UI attaches, then
replay them. This isn't ideal but better than the current situation of
losing them entirely.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py          | 11 ++++++++++-
 lib/bb/server/process.py |  2 +-
 lib/bb/server/xmlrpc.py  |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 1462382..d5c5ef3 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -212,6 +212,12 @@ def fire(event, d):
     if worker_fire:
         worker_fire(event, d)
     else:
+        # If messages have been queued up, clear the queue
+        global _uiready, ui_queue
+        if _uiready and ui_queue:
+            for queue_event in ui_queue:
+                fire_ui_handlers(queue_event, d)
+            ui_queue = []
         fire_ui_handlers(event, d)
 
 def fire_from_worker(event, d):
@@ -291,7 +297,10 @@ def register_UIHhandler(handler, mainui=False):
     _ui_logfilters[_ui_handler_seq] = UIEventFilter(level, debug_domains)
     return _ui_handler_seq
 
-def unregister_UIHhandler(handlerNum):
+def unregister_UIHhandler(handlerNum, mainui=False):
+    if mainui:
+        global _uiready
+        _uiready = False
     if handlerNum in _ui_handlers:
         del _ui_handlers[handlerNum]
     return
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 9ca2b69..f8d6767 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -137,7 +137,7 @@ class ProcessServer(Process, BaseImplServer):
                 logger.exception('Running command %s', command)
 
         self.event_queue.close()
-        bb.event.unregister_UIHhandler(self.event_handle.value)
+        bb.event.unregister_UIHhandler(self.event_handle.value, True)
         self.command_channel.close()
         self.cooker.shutdown(True)
         self.quitout.close()
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index a06007f..d0f5a6d 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -125,7 +125,7 @@ class BitBakeServerCommands():
         """
         Unregister a remote UI Event Handler
         """
-        return bb.event.unregister_UIHhandler(handlerNum)
+        return bb.event.unregister_UIHhandler(handlerNum, True)
 
     def runCommand(self, command):
         """
-- 
2.7.4


