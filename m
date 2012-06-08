Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdE-0004at-6A
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:41 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhAEN015526
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:10 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:09 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:40 -0500
Message-ID: <1339162913-23759-6-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 05/18] knotty.py: Add the ability to spawn screen directly from knotty with OE_TERMINAL=screen_inline
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:41 -0000
Content-Type: text/plain

The oe-core has a change pending to add the screen_inline class.

This change allows the simple use case of directly using a devshell
from the controlling terminal that started bitbake which is a
significant convience for some use cases.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 7a7a1b2..b4125f6 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -174,6 +174,10 @@ def main(server, eventHandler, tf = TerminalFilter):
     includelogs = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     loglines = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
     consolelogfile = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    if sys.stdin.isatty() and sys.stdout.isatty():
+        runscreen = True
+    else:
+        runscreen = False
 
     # MultiTail affected varialbles
     numthreads = server.runCommand(["getVariable", "BB_NUMBER_THREADS"])
@@ -260,6 +264,12 @@ def main(server, eventHandler, tf = TerminalFilter):
                     errors = errors + 1
                     return_value = 1
                 elif event.levelno == format.WARNING:
+                    msg = event.getMessage()
+                    if runscreen and event.name == "BitBake.OE.Terminal" and msg.startswith("Screen Connect Command: "):
+                        msg = msg[24:]
+                        print "Starting terminal with: %s" % msg
+                        os.system(msg)
+                        continue
                     warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to 
-- 
1.7.10



