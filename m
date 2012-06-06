Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1ScN0b-0006Zj-Rv
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 22:39:14 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q56KSkcm014044
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jun 2012 13:28:46 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 6 Jun 2012 13:28:45 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Jun 2012 15:28:28 -0500
Message-ID: <1339014519-9972-5-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339014519-9972-1-git-send-email-jason.wessel@windriver.com>
References: <1339014519-9972-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v3 04/15] msg.py, knotty.py: Allow dynamic toggle of the debug log level
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
X-List-Received-Date: Wed, 06 Jun 2012 20:39:14 -0000
Content-Type: text/plain

If stdin is a controlling tty, make it possible to have
log levels 1-4 where you can press a key to dynamically
change the log level, while bitbake is running to see
what is going on.

1 = default log level
2 = multiple log tail of bitbake tasks
3 = bit bake debug messages
4 = bitbake debug messages + multiple lot tail of bitbake tasks

In order to make this possible a slight modification to
the msg logfilter was needed to make it possible to get
an object so as to change the filter log level.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/msg.py       |    9 ++++++++-
 lib/bb/ui/knotty.py |   21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 9b39325..4b2f90e 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -86,6 +86,13 @@ class BBLogFilter(object):
         handler.setLevel(loglevel)
         handler.addFilter(self)
 
+    def setFiltLevel(self, handler, level):
+        self.stdlevel = level
+        handler.setLevel(level)
+
+    def getFiltLevel(self):
+        return self.stdlevel
+
     def filter(self, record):
         if record.levelno >= self.stdlevel:
             return True
@@ -131,7 +138,7 @@ def addDefaultlogFilter(handler):
         dlevel = len(tuple(iterator))
         debug_domains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
 
-    BBLogFilter(handler, level, debug_domains)
+    return BBLogFilter(handler, level, debug_domains)
 
 #
 # Message handling functions
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index f72f0ad..7a7a1b2 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -135,8 +135,11 @@ class StdinMgr:
             termios.tcsetattr(self.fd, termios.TCSANOW, new)
 
 class RtLogLevel:
-    def __init__(self, mlt):
+    def __init__(self, handler, logfilter, mlt):
         self.displaytail = False
+        self.handler = handler
+        self.logfilter = logfilter
+        self.defaultLevel = logfilter.getFiltLevel()
         self.mlt = mlt
 
     def displayLogs(self):
@@ -147,10 +150,22 @@ class RtLogLevel:
         if input == "1":
             if verbose:
                 print "NOTE: Turning off real time log tail"
+            self.logfilter.setFiltLevel(self.handler, self.defaultLevel)
             self.displaytail = False
         elif input == "2":
             if verbose:
                 print "NOTE: Turning on real time log tail"
+            self.logfilter.setFiltLevel(self.handler, self.defaultLevel)
+            self.displaytail = True
+        elif input == "3":
+            if verbose:
+                print "NOTE: Turning on DEBUG logging"
+            self.logfilter.setFiltLevel(self.handler, logging.DEBUG)
+            self.displaytail = False
+        elif input == "4":
+            if verbose:
+                print "NOTE: Turning on DEBUG logging + real time log tail"
+            self.logfilter.setFiltLevel(self.handler, logging.DEBUG)
             self.displaytail = True
 
 def main(server, eventHandler, tf = TerminalFilter):
@@ -171,8 +186,8 @@ def main(server, eventHandler, tf = TerminalFilter):
 
     console = logging.StreamHandler(sys.stdout)
     format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
-    bb.msg.addDefaultlogFilter(console)
-    rtloglevel = RtLogLevel(mlt)
+    logfilter = bb.msg.addDefaultlogFilter(console)
+    rtloglevel = RtLogLevel(console, logfilter, mlt)
     bb_rt_loglevel = server.runCommand(["getVariable", "BB_RT_LOGLEVEL"])
     if bb_rt_loglevel and bb_rt_loglevel != "":
         rtloglevel.setLevel(bb_rt_loglevel, False)
-- 
1.7.10



