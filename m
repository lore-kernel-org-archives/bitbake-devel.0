Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8FC456A57A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:53:02 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3r557001298
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:53:05 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:53:03 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 22:59:11 -0500
Message-ID: <1369799955-1488-3-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
In-Reply-To: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
References: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 3/7] msg.py, knotty.py: Allow dynamic toggle of the debug log level
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
 lib/bb/msg.py       |  9 ++++++++-
 lib/bb/ui/knotty.py | 21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index e70daee..bb4833d 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -119,6 +119,13 @@ class BBLogFilter(object):
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
@@ -164,7 +171,7 @@ def addDefaultlogFilter(handler):
         dlevel = len(tuple(iterator))
         debug_domains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
 
-    BBLogFilter(handler, level, debug_domains)
+    return BBLogFilter(handler, level, debug_domains)
 
 #
 # Message handling functions
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 293572f..4f59e96 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -248,8 +248,11 @@ class StdinMgr:
             self.termios.tcsetattr(self.fd, self.termios.TCSANOW, new)
 
 class RtLogLevel:
-    def __init__(self, mlt):
+    def __init__(self, handler, logfilter, mlt):
         self.displaytail = False
+        self.handler = handler
+        self.logfilter = logfilter
+        self.defaultLevel = logfilter.getFiltLevel()
         self.mlt = mlt
 
     def displayLogs(self):
@@ -260,10 +263,22 @@ class RtLogLevel:
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
 
 def main(server, eventHandler, params, tf = TerminalFilter):
@@ -299,8 +314,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     console = logging.StreamHandler(sys.stdout)
     format_str = "%(levelname)s: %(message)s"
     format = bb.msg.BBLogFormatter(format_str)
-    bb.msg.addDefaultlogFilter(console)
-    rtloglevel = RtLogLevel(mlt)
+    logfilter = bb.msg.addDefaultlogFilter(console)
+    rtloglevel = RtLogLevel(console, logfilter, mlt)
     bb_rt_loglevel = server.runCommand(["getVariable", "BB_RT_LOGLEVEL"])
     if bb_rt_loglevel and bb_rt_loglevel != "":
         rtloglevel.setLevel(bb_rt_loglevel, False)
-- 
1.8.1.2.545.g2f19ada


