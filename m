Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UbQwH-0001uz-0c for bitbake-devel@lists.openembedded.org;
	Sun, 12 May 2013 09:43:28 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4C7RwYo007274 for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 May 2013 08:27:58 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BMNxaQgcvKdj for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 May 2013 08:27:58 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4C7RnoC007270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 May 2013 08:27:52 +0100
Message-ID: <1368343500.21569.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 12 May 2013 08:25:00 +0100
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Limit printed lines to terminal size
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
X-List-Received-Date: Sun, 12 May 2013 07:43:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you have a small terminal window with a large number of bitbake threads,
the scrollback output becomes corrupted since the footer is larger than
the height of the screen.

This patch ensures we limit the number of printed lines to match the
terminal height.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 6ea7d86..c9323d9 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -102,13 +102,14 @@ class InteractConsoleLogFilter(logging.Filter):
 
 class TerminalFilter(object):
     columns = 80
+    lines = 25
 
     def sigwinch_handle(self, signum, frame):
-        self.columns = self.getTerminalColumns()
+        (self.lines, self.columns) = self.getTerminalSize()
         if self._sigwinch_default:
             self._sigwinch_default(signum, frame)
 
-    def getTerminalColumns(self):
+    def getTerminalSize(self):
         def ioctl_GWINSZ(fd):
             try:
                 cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))
@@ -128,7 +129,7 @@ class TerminalFilter(object):
                 cr = (env['LINES'], env['COLUMNS'])
             except:
                 cr = (25, 80)
-        return cr[1]
+        return cr
 
     def __init__(self, main, helper, console, format):
         self.main = main
@@ -167,7 +168,7 @@ class TerminalFilter(object):
                 signal.signal(signal.SIGWINCH, self.sigwinch_handle)
             except:
                 pass
-            self.columns = self.getTerminalColumns()
+            (self.lines, self.columns) = self.getTerminalSize()
         except:
             self.cuu = None
         console.addFilter(InteractConsoleLogFilter(self, format))
@@ -195,18 +196,30 @@ class TerminalFilter(object):
         for t in runningpids:
             tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
 
+        display = []
+        def addline(content, display):
+            display.append(content)
+            extra = int(len(content) / (self.columns + 1))
+            for n in range(extra):
+                display.append(None)
+            return 1 + extra
+
         if self.main.shutdown:
             content = "Waiting for %s running tasks to finish:" % len(activetasks)
         elif not len(activetasks):
             content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
         else:
             content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
-        print(content)
-        lines = 1 + int(len(content) / (self.columns + 1))
+        lines = addline(content, display)
         for tasknum, task in enumerate(tasks):
             content = "%s: %s" % (tasknum, task)
-            print(content)
-            lines = lines + 1 + int(len(content) / (self.columns + 1))
+            lines = lines + addline(content, display)
+        if lines > (self.lines -1):
+            display = display[-(self.lines - 1):]
+            lines = self.lines - 1
+        for l in display:
+             if l:
+                print(l)
         self.footer_present = lines
         self.lastpids = runningpids[:]
         self.lastcount = self.helper.tasknumber_current




