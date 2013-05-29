Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id E815C6A57A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:53:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3r3ds019823
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:53:03 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:53:02 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 22:59:10 -0500
Message-ID: <1369799955-1488-2-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
In-Reply-To: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
References: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 2/7] knotty.py: Add the ability to dynamically select loglevel from stdin
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 May 2013 03:53:02 -0000
Content-Type: text/plain

From: Jason Wessel <jason.wessel@windriver.com>

If stdin is a controlling terminal, make it possible to dynamically
select a log level with the keys 1 and 2.

1 = normal bitbake knotty logs
2 = realtime multiple tail of task logs

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 34ca678..293572f 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -218,6 +218,35 @@ class TerminalFilter(object):
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
@@ -317,11 +346,15 @@ def main(server, eventHandler, params, tf = TerminalFilter):
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
@@ -512,6 +545,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
+            stdin_mgr.restore()
             termfilter.clearFooter()
             if main.shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
@@ -527,6 +561,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             main.shutdown = main.shutdown + 1
             pass
 
+    stdin_mgr.restore()
     summary = ""
     if taskfailures:
         summary += pluralise("\nSummary: %s task failed:",
-- 
1.8.1.2.545.g2f19ada


