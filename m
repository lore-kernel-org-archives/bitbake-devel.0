Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 93587610F7
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  6 Oct 2013 12:42:54 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r96Cgo9X024549 for <bitbake-devel@lists.openembedded.org>;
	Sun, 6 Oct 2013 13:42:50 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hHlLqG51rQZl for <bitbake-devel@lists.openembedded.org>;
	Sun,  6 Oct 2013 13:42:50 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r96Cgi2W024541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sun, 6 Oct 2013 13:42:45 +0100
Message-ID: <1381063359.30971.21.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 06 Oct 2013 13:42:39 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker/command: Add error state for the server and use for pre_serve errors
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
X-List-Received-Date: Sun, 06 Oct 2013 12:42:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if errors occur when starting the PR service, there is a race that
occurs since the UI runs various commands including starting builds before
processing the CookerExit(). By adding the error state and refusing to run
async commands in this mode, builds are prevented from starting and the
UI reaches the exit code with the system shutting down cleanly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 3ca27a6..a2795ce 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -86,6 +86,8 @@ class Command:
 
     def runAsyncCommand(self):
         try:
+            if self.cooker.state == bb.cooker.state.error:
+                return False
             if self.currentAsyncCommand is not None:
                 (command, options) = self.currentAsyncCommand
                 commandmethod = getattr(CommandsAsync, command)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index d17716d..870b18e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -61,7 +61,7 @@ class CollectionError(bb.BBHandledException):
     """
 
 class state:
-    initial, parsing, running, shutdown, forceshutdown, stopped = range(6)
+    initial, parsing, running, shutdown, forceshutdown, stopped, error = range(7)
 
 
 class SkippedPackage:
@@ -1321,6 +1321,7 @@ class BBCooker:
             self.prhost = prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError:
             bb.event.fire(CookerExit(), self.event_data)
+            self.state = state.error
         return
 
     def post_serve(self):



