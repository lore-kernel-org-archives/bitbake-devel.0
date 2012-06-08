Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdH-0004br-PR
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:44 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhDMX023975
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:13 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:13 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:45 -0500
Message-ID: <1339162913-23759-11-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 10/18] knotty2: Properly adjust for lines longer than terminal size
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:44 -0000
Content-Type: text/plain

knotty2 does not handle being resized nor does it work properly
if a task line is longer than the terminal size.

The filter handler relies on the sigwinch to properly
handle a terminal resize.  The cache and parse tasks will
try to take over the sigwinch handler, so it must be restored
when either of these tasks completes.
---
 lib/bb/ui/knotty.py  |    5 +++++
 lib/bb/ui/knotty2.py |   42 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index d7b1e19..58fb8f1 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -82,6 +82,9 @@ class TerminalFilter(object):
     def clearFooter(self):
         return
 
+    def sigUpdate(self):
+        return
+
     def updateFooterForce(self):
         self.printFooter(True)
 
@@ -332,6 +335,7 @@ def main(server, eventHandler, tf = TerminalFilter):
                 parseprogress.finish()
                 print(("Parsing of %d .bb files complete (%d cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
                     % ( event.total, event.cached, event.parsed, event.virtuals, event.skipped, event.masked, event.errors)))
+                termfilter.sigUpdate()
                 continue
 
             if isinstance(event, bb.event.CacheLoadStarted):
@@ -343,6 +347,7 @@ def main(server, eventHandler, tf = TerminalFilter):
             if isinstance(event, bb.event.CacheLoadCompleted):
                 cacheprogress.finish()
                 print("Loaded %d entries from dependency cache." % event.num_entries)
+                termfilter.sigUpdate()
                 continue
 
             if isinstance(event, bb.command.CommandFailed):
diff --git a/lib/bb/ui/knotty2.py b/lib/bb/ui/knotty2.py
index 9e3619b..cfa4bf7 100644
--- a/lib/bb/ui/knotty2.py
+++ b/lib/bb/ui/knotty2.py
@@ -35,6 +35,39 @@ class InteractConsoleLogFilter(logging.Filter):
         return True
 
 class TerminalFilter2(object):
+    columns = 80
+
+    def sigwinch_handle(self, sig, data):
+        self.columns = self.getTerminalColumns()
+
+    def sigUpdate(self):
+        import signal
+        if self.interactive and self.cuu:
+            signal.signal(signal.SIGWINCH, self.sigwinch_handle)
+
+    def getTerminalColumns(self):
+        def ioctl_GWINSZ(fd):
+            try:
+                import fcntl, termios, struct, os
+                cr = struct.unpack('hh', fcntl.ioctl(fd, termios.TIOCGWINSZ, '1234'))
+            except:
+                return None
+            return cr
+        cr = ioctl_GWINSZ(0) or ioctl_GWINSZ(1) or ioctl_GWINSZ(2)
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
@@ -62,7 +95,9 @@ class TerminalFilter2(object):
             self.ed = curses.tigetstr("ed")
             if self.ed:
                 self.cuu = curses.tigetstr("cuu")
-        except:
+            self.columns = self.getTerminalColumns()
+            self.sigUpdate()
+        except Exception:
             self.cuu = None
         console.addFilter(InteractConsoleLogFilter(self, format))
 
@@ -102,8 +137,9 @@ class TerminalFilter2(object):
             else:
                 print("Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total))
         for tasknum, task in enumerate(tasks):
-            print("%s: %s" % (tasknum, task))
-            lines = lines + 1
+            content = "%s: %s" % (tasknum, task)
+            print content
+            lines = lines + 1 + int(len(content) / (self.columns + 1))
         self.footer_present = lines
         self.lastpids = runningpids[:]
 
-- 
1.7.10



