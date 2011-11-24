Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RThYN-0002BE-O9
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 23:13:59 +0100
Received: by opal (Postfix, from userid 111)
	id 71DE410333; Thu, 24 Nov 2011 22:09:55 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111124220955.71DE410333@opal>
Date: Thu, 24 Nov 2011 22:09:55 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : knotty: Add support for logging the console to logfile
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
X-List-Received-Date: Thu, 24 Nov 2011 22:14:00 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: a34ff490a46577a64345365fa1ac39c48d0861cd
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=a34ff490a46577a64345365fa1ac39c48d0861cd

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Nov 24 14:45:37 2011 +0000

knotty: Add support for logging the console to logfile

The BB_CONSOLELOG variable is used to specify the console log file
to use. This means people can look up things that happened during a
build by may have scrolled off the screen.

[YOCTO #1771]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/ui/knotty.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 7c645ad..38acb47 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -69,6 +69,7 @@ def main(server, eventHandler):
     # Get values of variables which control our output
     includelogs = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     loglines = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
+    consolelogfile = server.runCommand(["getVariable", "BB_CONSOLELOG"])
 
     helper = uihelper.BBUIHelper()
 
@@ -77,6 +78,11 @@ def main(server, eventHandler):
     bb.msg.addDefaultlogFilter(console)
     console.setFormatter(format)
     logger.addHandler(console)
+    if consolelogfile:
+        consolelog = logging.FileHandler(consolelogfile)
+        bb.msg.addDefaultlogFilter(consolelog)
+        consolelog.setFormatter(format)
+        logger.addHandler(consolelog)
 
     try:
         cmdline = server.runCommand(["getCmdLineAction"])



