Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdC-0004ae-DN
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:38 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q58Dh8xE015523
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:08 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:07 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:38 -0500
Message-ID: <1339162913-23759-4-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 03/18] knotty: Add the ability to dynamically select loglevel from stdin
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:38 -0000
Content-Type: text/plain

If stdin is a controlling terminal, make it possible to dynamically
select a log level with the keys 1 and 2.

1 = normal bitbake knotty logs
2 = realtime multiple tail of task logs

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index fd86ed5..f72f0ad 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -108,6 +108,32 @@ class TerminalFilter(object):
     def finish(self):
         return
 
+class StdinMgr:
+    def __init__(self):
+        self.stdinbackup = None
+        self.fd = None
+        if sys.stdin.isatty():
+            self.fd = sys.stdin.fileno()
+            self.stdinbackup = termios.tcgetattr(self.fd)
+            new = termios.tcgetattr(self.fd)
+            new[3] = new[3] & ~termios.ICANON & ~termios.ECHO
+            termios.tcsetattr(self.fd, termios.TCSANOW, new)
+
+    def poll(self):
+        if not self.stdinbackup:
+            return False
+        return select.select([sys.stdin], [], [], 0) == ([sys.stdin], [], [])
+
+    def restore(self):
+        if self.stdinbackup:
+            termios.tcsetattr(self.fd, termios.TCSADRAIN, self.stdinbackup)
+            self.stdinbackup = None
+        # Force echo back on "just in case" something went haywire with an exception
+        if sys.stdin.isatty():
+            new = termios.tcgetattr(self.fd)
+            new[3] = new[3] | termios.ECHO
+            termios.tcsetattr(self.fd, termios.TCSANOW, new)
+
 class RtLogLevel:
     def __init__(self, mlt):
         self.displaytail = False
@@ -184,11 +210,15 @@ def main(server, eventHandler, tf = TerminalFilter):
     taskfailures = []
 
     termfilter = tf(main, helper, console, format)
+    stdin_mgr = StdinMgr()
 
     while True:
         try:
             termfilter.updateFooter()
             event = eventHandler.waitEvent(0.25)
+            if stdin_mgr.poll():
+                keyinput = sys.stdin.read(1)
+                rtloglevel.setLevel(keyinput, True)
             # Always try printing any accumulated log files first
             rtloglevel.displayLogs()
             if event is None:
@@ -364,6 +394,7 @@ def main(server, eventHandler, tf = TerminalFilter):
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
+            stdin_mgr.restore()
             termfilter.clearFooter()
             if main.shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
@@ -375,6 +406,7 @@ def main(server, eventHandler, tf = TerminalFilter):
             main.shutdown = main.shutdown + 1
             pass
 
+    stdin_mgr.restore()
     summary = ""
     if taskfailures:
         summary += pluralise("\nSummary: %s task failed:",
-- 
1.7.10



