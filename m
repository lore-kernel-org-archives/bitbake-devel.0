Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1ScN0e-0006aJ-Id
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 22:39:16 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q56KSmu0014050
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jun 2012 13:28:48 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 6 Jun 2012 13:28:48 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Jun 2012 15:28:32 -0500
Message-ID: <1339014519-9972-9-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339014519-9972-1-git-send-email-jason.wessel@windriver.com>
References: <1339014519-9972-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v3 08/15] knotty.py, knotty2, py: Flush and update footer on dynamic log level change
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
X-List-Received-Date: Wed, 06 Jun 2012 20:39:17 -0000
Content-Type: text/plain

This patch adds a call to update the task list after changing log
modes dynamically such that you can immediately see the remaining
tasks.  After adding this functionality, it became obvious there was a
problem flushing data loaded into stdout because the task list would
not appear immediately.  Doing something like "bitbake IMAGE | tee
/tmp/log" is where the flush problem manifests itself the most.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py  |   14 ++++++++++++--
 lib/bb/ui/knotty2.py |    4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index b4125f6..d7b1e19 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -82,9 +82,16 @@ class TerminalFilter(object):
     def clearFooter(self):
         return
 
+    def updateFooterForce(self):
+        self.printFooter(True)
+
     def updateFooter(self):
-        if not main.shutdown or not self.helper.needUpdate:
-            return
+        self.printFooter(False)
+
+    def printFooter(self, force_update):
+        if not force_update:
+            if not main.shutdown or not self.helper.needUpdate:
+                return
 
         activetasks = self.helper.running_tasks
         runningpids = self.helper.running_pids
@@ -238,6 +245,9 @@ def main(server, eventHandler, tf = TerminalFilter):
             if stdin_mgr.poll():
                 keyinput = sys.stdin.read(1)
                 rtloglevel.setLevel(keyinput, True)
+                termfilter.updateFooterForce()
+                sys.stdout.flush()
+
             # Always try printing any accumulated log files first
             rtloglevel.displayLogs()
             if event is None:
diff --git a/lib/bb/ui/knotty2.py b/lib/bb/ui/knotty2.py
index aa6a408..01693e9 100644
--- a/lib/bb/ui/knotty2.py
+++ b/lib/bb/ui/knotty2.py
@@ -73,6 +73,10 @@ class TerminalFilter2(object):
             sys.stdout.write(self.curses.tparm(self.ed))
         self.footer_present = False
 
+    def updateFooterForce(self):
+        self.footer_present = False
+        self.updateFooter()
+
     def updateFooter(self):
         if not self.cuu:
             return
-- 
1.7.10



