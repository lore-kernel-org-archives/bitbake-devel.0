Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8d-0003R2-Sc
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:00 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbK2f009854
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:20 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:20 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:33 -0500
Message-ID: <1347921818-60562-4-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/8] knotty.py: Add the ability to dynamically select loglevel from stdin
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:00 -0000
Content-Type: text/plain

If stdin is a controlling terminal, make it possible to dynamically
select a log level with the keys 1 and 2.

1 = normal bitbake knotty logs
2 = realtime multiple tail of task logs

(LOCAL REV: NOT UPSTREAM)

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index d412192..0ec1b30 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -213,6 +213,35 @@ class TerminalFilter(object):
             fd = sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
+class StdinMgr:
+    def __init__(self):
+        import termios
+        self.termios = termios
+        self.stdinbackup = None
+        self.fd = None
+        if sys.stdin.isatty():
+            self.fd = sys.stdin.fileno()
+            self.stdinbackup = self.termios.tcgetattr(self.fd)
+            new = self.termios.tcgetattr(self.fd)
+            new[3] = new[3] & ~self.termios.ICANON & ~self.termios.ECHO
+            self.termios.tcsetattr(self.fd, self.termios.TCSANOW, new)
+
+    def poll(self):
+        if not self.stdinbackup:
+            return False
+        return select.select([sys.stdin], [], [], 0) == ([sys.stdin], [], [])
+
+    def restore(self):
+        if self.stdinbackup:
+            self.termios.tcsetattr(self.fd, self.termios.TCSADRAIN,
+                                   self.stdinbackup)
+            self.stdinbackup = None
+        # Force echo back on "just in case" something went haywire with an exception
+        if sys.stdin.isatty():
+            new = self.termios.tcgetattr(self.fd)
+            new[3] = new[3] | self.termios.ECHO
+            self.termios.tcsetattr(self.fd, self.termios.TCSANOW, new)
+
 class RtLogLevel:
     def __init__(self, mlt):
         self.displaytail = False
@@ -294,11 +323,15 @@ def main(server, eventHandler, tf = TerminalFilter):
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
@@ -488,6 +521,7 @@ def main(server, eventHandler, tf = TerminalFilter):
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
+            stdin_mgr.restore()
             termfilter.clearFooter()
             if main.shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
@@ -499,6 +533,7 @@ def main(server, eventHandler, tf = TerminalFilter):
             main.shutdown = main.shutdown + 1
             pass
 
+    stdin_mgr.restore()
     summary = ""
     if taskfailures:
         summary += pluralise("\nSummary: %s task failed:",
-- 
1.7.1



