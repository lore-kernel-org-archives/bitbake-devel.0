Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T1gD7-0002fz-Ln for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 18:12:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FG0moG002970
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 17:00:48 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01979-07 for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 17:00:43 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FG0eRh002964
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 17:00:41 +0100
Message-ID: <1345046440.14667.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Aug 2012 17:00:40 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] knotty2: Handle long lines of text and terminal window size changes
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
X-List-Received-Date: Wed, 15 Aug 2012 16:12:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Long lines of text which wrapped on the terminal corrupted the output shown by
knotty2. This patch catches such errors by becomming aware of the terminal size.

It also catches terminal window size change events and adapting to those
changes using a signal handler.

Based on a patch from Jason Wessel with several tweaks and enhancements
such as use of chained signal handlers and covering all output messages.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty2.py b/bitbake/lib/bb/ui/knotty2.py
index 65e941b..57ad67f 100644
--- a/bitbake/lib/bb/ui/knotty2.py
+++ b/bitbake/lib/bb/ui/knotty2.py
@@ -21,6 +21,10 @@
 from bb.ui import knotty
 import logging
 import sys
+import os
+import fcntl
+import struct
+import copy
 logger = logging.getLogger("BitBake")
 
 class InteractConsoleLogFilter(logging.Filter):
@@ -35,6 +39,35 @@ class InteractConsoleLogFilter(logging.Filter):
         return True
 
 class TerminalFilter2(object):
+    columns = 80
+
+    def sigwinch_handle(self, signum, frame):
+        self.columns = self.getTerminalColumns()
+        if self._sigwinch_default:
+            self._sigwinch_default(signum, frame)
+
+    def getTerminalColumns(self):
+        def ioctl_GWINSZ(fd):
+            try:
+                cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))
+            except:
+                return None
+            return cr
+        cr = ioctl_GWINSZ(sys.stdout.fileno())
+        if not cr:
+            try:
+                fd = os.open(os.ctermid(), os.O_RDONLY)
+                cr = ioctl_GWINSZ(fd)
+                os.close(fd)
+            except:
+                pass
+        if not cr:
+            try:
+                cr = (env['LINES'], env['COLUMNS'])
+            except:
+                cr = (25, 80)
+        return cr[1]
+
     def __init__(self, main, helper, console, format):
         self.main = main
         self.helper = helper
@@ -49,7 +82,6 @@ class TerminalFilter2(object):
 
         import curses
         import termios
-        import copy
         self.curses = curses
         self.termios = termios
         try:
@@ -62,6 +94,12 @@ class TerminalFilter2(object):
             self.ed = curses.tigetstr("ed")
             if self.ed:
                 self.cuu = curses.tigetstr("cuu")
+            try:
+                self._sigwinch_default = signal.getsignal(signal.SIGWINCH)
+                signal.signal(signal.SIGWINCH, self.sigwinch_handle)
+            except:
+                pass
+            self.columns = self.getTerminalColumns()
         except:
             self.cuu = None
         console.addFilter(InteractConsoleLogFilter(self, format))
@@ -85,18 +123,20 @@ class TerminalFilter2(object):
             self.clearFooter()
         if not activetasks:
             return
-        lines = 1
         tasks = []
         for t in runningpids:
             tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
 
         if self.main.shutdown:
-            print("Waiting for %s running tasks to finish:" % len(activetasks))
+            content = "Waiting for %s running tasks to finish:" % len(activetasks)
         else:
-            print("Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total))
+            content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
+        print content
+        lines = 1 + int(len(content) / (self.columns + 1))
         for tasknum, task in enumerate(tasks):
-            print("%s: %s" % (tasknum, task))
-            lines = lines + 1
+            content = "%s: %s" % (tasknum, task)
+            print content
+            lines = lines + 1 + int(len(content) / (self.columns + 1))
         self.footer_present = lines
         self.lastpids = runningpids[:]
 




