Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 41E5777DC8
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Aug 2017 22:48:57 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v79MmuCd031944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 9 Aug 2017 23:48:57 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dfZmZ-0007SC-W5; Wed, 09 Aug 2017 23:48:55 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Aug 2017 23:48:53 +0100
Message-Id: <1502318935-28608-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502318935-28608-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1502318935-28608-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 09 Aug 2017 23:48:57 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/4] cooker: Ensure we handle inotify before running the next command
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
X-List-Received-Date: Wed, 09 Aug 2017 22:48:58 -0000

The inotify watch events are handled "at idle" which could in theory mean
a command could run before any preceeding inotify events have been processed.
This leads to a theoretical race window where those events may have a
signficicant effect on the command.

Add a mechanism to allow us to ensure all pending events are processed before
running commands.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py |  2 ++
 lib/bb/cooker.py  | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index c44c7a6..a923245 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -78,6 +78,7 @@ class Command:
                 if not hasattr(command_method, 'readonly') or False == getattr(command_method, 'readonly'):
                     return None, "Not able to execute not readonly commands in readonly mode"
             try:
+                self.cooker.process_inotify_updates()
                 if getattr(command_method, 'needconfig', False):
                     self.cooker.updateCacheSync()
                 result = command_method(self, commandline)
@@ -98,6 +99,7 @@ class Command:
 
     def runAsyncCommand(self):
         try:
+            self.cooker.process_inotify_updates()
             if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
                 # updateCache will trigger a shutdown of the parser
                 # and then raise BBHandledException triggering an exit
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ea4df26..77b7f3d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -205,15 +205,11 @@ class BBCooker:
 
         self.inotify_modified_files = []
 
-        def _process_inotify_updates(server, notifier_list, abort):
-            for n in notifier_list:
-                if n.check_events(timeout=0):
-                    # read notified events and enqeue them
-                    n.read_events()
-                    n.process_events()
+        def _process_inotify_updates(server, cooker, abort):
+            cooker.process_inotify_updates()
             return 1.0
 
-        self.configuration.server_register_idlecallback(_process_inotify_updates, [self.confignotifier, self.notifier])
+        self.configuration.server_register_idlecallback(_process_inotify_updates, self)
 
         # TOSTOP must not be set or our children will hang when they output
         try:
@@ -241,6 +237,13 @@ class BBCooker:
             os.write(readypipe, b"ready")
             os.close(readypipe)
 
+    def process_inotify_updates(self):
+        for n in [self.confignotifier, self.notifier]:
+            if n.check_events(timeout=0):
+                # read notified events and enqeue them
+                n.read_events()
+                n.process_events()
+
     def config_notifications(self, event):
         if event.maskname == "IN_Q_OVERFLOW":
             bb.warn("inotify event queue overflowed, invalidating caches.")
-- 
2.7.4


