Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rkfnx-0005Td-1S
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:48:13 +0100
Received: by opal (Postfix, from userid 111)
	id C3F2510335; Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120110174903.C3F2510335@opal>
Date: Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : bitbake/knotty: Show summary of warning/ error messages shown
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 10 Jan 2012 17:48:13 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 9943bad611a974e4d37a00c7a4de1752250370c5
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=9943bad611a974e4d37a00c7a4de1752250370c5

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Mon Jan  9 17:00:53 2012 +0000

bitbake/knotty: Show summary of warning/error messages shown

Show a summary count of warning/errors messages shown to the user during the
build and make it clear when an error exit code is being set.

[YOCTO #1540]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/ui/knotty.py |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 38acb47..0340619 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -105,6 +105,8 @@ def main(server, eventHandler):
     cacheprogress = None
     shutdown = 0
     return_value = 0
+    errors = 0
+    warnings = 0
     while True:
         try:
             event = eventHandler.waitEvent(0.25)
@@ -123,13 +125,15 @@ def main(server, eventHandler):
 
             if isinstance(event, logging.LogRecord):
                 if event.levelno >= format.ERROR:
+                    errors = errors + 1
                     return_value = 1
+                if event.levelno >= format.WARNING:
+                    warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to 
                 # include verbose/debug messages
-                #if logger.getEffectiveLevel() > format.VERBOSE:
                 if event.taskpid != 0 and event.levelno <= format.NOTE:
-                        continue
+                    continue
                 logger.handle(event)
                 continue
 
@@ -208,6 +212,7 @@ def main(server, eventHandler):
                 continue
             if isinstance(event, bb.event.NoProvider):
                 return_value = 1
+                errors = errors + 1
                 if event._runtime:
                     r = "R"
                 else:
@@ -267,4 +272,8 @@ def main(server, eventHandler):
                 server.runCommand(["stateShutdown"])
             shutdown = shutdown + 1
             pass
+    if warnings:
+        print("Summary: There were %s WARNING messages shown.\n" % warnings)
+    if return_value:
+        print("Summary: There were %s ERROR messages shown, returning a non-zero exit code.\n" % errors)
     return return_value



