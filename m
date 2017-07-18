Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B9B33780E4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 21:37:03 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6ILb2aD012336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 18 Jul 2017 22:37:03 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dXaAw-0006T2-5c; Tue, 18 Jul 2017 22:37:02 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jul 2017 22:36:55 +0100
Message-Id: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 18 Jul 2017 22:37:03 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/6] event/command: Allow UI to request the UI eventhander ID
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
X-List-Received-Date: Tue, 18 Jul 2017 21:37:04 -0000

The UI may want to change its event mask however to do this, it needs the
event handler's ID. Tweak the code to allow this to be stored and add
a command to query it.

Use the new command in the process server backend.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        |  5 +++++
 lib/bb/event.py          | 11 ++++++++---
 lib/bb/server/process.py |  7 ++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 36891b9..eb7c86f 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -238,6 +238,11 @@ class CommandsSync:
         return command.cooker.matchFile(fMatch)
     matchFile.needconfig = False
 
+    def getUIHandlerNum(self, command, params):
+        return bb.event.get_uihandler()
+    getUIHandlerNum.needconfig = False
+    getUIHandlerNum.readonly = True
+
     def setEventMask(self, command, params):
         handlerNum = params[0]
         llevel = params[1]
diff --git a/lib/bb/event.py b/lib/bb/event.py
index d5c5ef3..92ee3e9 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -288,13 +288,13 @@ def set_eventfilter(func):
     _eventfilter = func
 
 def register_UIHhandler(handler, mainui=False):
-    if mainui:
-        global _uiready
-        _uiready = True
     bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
     _ui_handlers[_ui_handler_seq] = handler
     level, debug_domains = bb.msg.constructLogOptions()
     _ui_logfilters[_ui_handler_seq] = UIEventFilter(level, debug_domains)
+    if mainui:
+        global _uiready
+        _uiready = _ui_handler_seq
     return _ui_handler_seq
 
 def unregister_UIHhandler(handlerNum, mainui=False):
@@ -305,6 +305,11 @@ def unregister_UIHhandler(handlerNum, mainui=False):
         del _ui_handlers[handlerNum]
     return
 
+def get_uihandler():
+    if _uiready is False:
+        return None
+    return _uiready
+
 # Class to allow filtering of events and specific filtering of LogRecords *before* we put them over the IPC
 class UIEventFilter(object):
     def __init__(self, level, debug_domains):
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index a8ba468..cfcd764 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -63,7 +63,12 @@ class ServerCommunicator():
                 pass
 
     def getEventHandle(self):
-        return self.event_handle.value
+        handle, error = self.runCommand(["getUIHandlerNum"])
+        if error:
+            logger.error("Unable to get UI Handler Number: %s" % error)
+            raise BaseException(error)
+
+        return handle
 
 class EventAdapter():
     """
-- 
2.7.4


