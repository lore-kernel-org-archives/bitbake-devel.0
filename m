Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DAEC177002
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 14:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t83EKHUK031677 for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Sep 2015 15:20:17 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0mDEaskcqh4b for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 15:20:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t83EK5O5031661
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Sep 2015 15:20:16 +0100
Message-ID: <1441290005.24871.116.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 03 Sep 2015 15:20:05 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] event/server: Add _uiready flag to handle missing error messages
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
X-List-Received-Date: Thu, 03 Sep 2015 14:20:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you start and suspend a bitbake execution so the bitbake lock is held,
then try and run "bitbake -w '' X", you will see bitbake return an error exit
code but print no message about what happened at all.

The reason is that the -w option creates a "UI" which swallows the messages. The
code which handles this exit failure mode thinks a UI has printed the messages
and therefore doesn't do so.

This adds in an extra parameter to the UI registration code so that we
can figure out whether its a primary UI or not and base decisions on whether
to display information on that instead. This fixes the error shown above and
some bizarre failures on the Yocto Project Autobuilder.

[YOCTO #8239]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index da20fbf..059229e 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -69,6 +69,7 @@ _ui_handler_seq = 0
 _event_handler_map = {}
 _catchall_handlers = {}
 _eventfilter = None
+_uiready = False
 
 def execute_handler(name, handler, event, d):
     event.data = d
@@ -113,7 +117,7 @@ def print_ui_queue():
     """If we're exiting before a UI has been spawned, display any queued
     LogRecords to the console."""
     logger = logging.getLogger("BitBake")
-    if not _ui_handlers:
+    if not _uiready:
         from bb.msg import BBLogFormatter
         console = logging.StreamHandler(sys.stdout)
         console.setFormatter(BBLogFormatter("%(levelname)s: %(message)s"))
@@ -135,7 +139,7 @@ def print_ui_queue():
                 logger.handle(event)
 
 def fire_ui_handlers(event, d):
-    if not _ui_handlers:
+    if not _uiready:
         # No UI handlers registered yet, queue up the messages
         ui_queue.append(event)
         return
@@ -219,7 +223,9 @@ def set_eventfilter(func):
     global _eventfilter
     _eventfilter = func
 
-def register_UIHhandler(handler):
+def register_UIHhandler(handler, mainui=False):
+    if mainui:
+        _uiready = True
     bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
     _ui_handlers[_ui_handler_seq] = handler
     level, debug_domains = bb.msg.constructLogOptions()
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 3198635..f022b86 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -97,7 +97,7 @@ class ProcessServer(Process, BaseImplServer):
     def run(self):
         for event in bb.event.ui_queue:
             self.event_queue.put(event)
-        self.event_handle.value = bb.event.register_UIHhandler(self)
+        self.event_handle.value = bb.event.register_UIHhandler(self, True)
 
         bb.cooker.server_main(self.cooker, self.main)
 
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index f1a2067..b7647c1 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -99,7 +99,7 @@ class BitBakeServerCommands():
         if (self.cooker.state in [bb.cooker.state.parsing, bb.cooker.state.running]):
             return None
 
-        self.event_handle = bb.event.register_UIHhandler(s)
+        self.event_handle = bb.event.register_UIHhandler(s, True)
         return self.event_handle
 
     def unregisterEventHandler(self, handlerNum):



