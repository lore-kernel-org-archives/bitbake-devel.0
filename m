Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>) id 1T4Ec9-000384-Gt
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 19:21:09 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id q7MH8tu5029240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2012 19:08:56 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1T4EQf-0004OS-Pt; Wed, 22 Aug 2012 19:09:17 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Aug 2012 19:09:13 +0200
Message-Id: <1345655353-13549-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 1.7.11.4
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.995
X-Spam-Score: -5.5
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,RP_MATCHES_RCVD,SPF_NEUTRAL,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] ui/knotty: give out start time of task
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
X-List-Received-Date: Wed, 22 Aug 2012 17:21:09 -0000

For long running tasks like compiling qt it might be interesting to know
when the task has been started.  Patch prints this information by using
the %X modifier (locale dependent presentation of time without date).

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/ui/knotty.py   | 3 ++-
 lib/bb/ui/uihelper.py | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 858cacf..60d5886 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -190,7 +190,8 @@ class TerminalFilter(object):
             return
         tasks = []
         for t in runningpids:
-            tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
+            tasks.append("%s - %s (pid %s)" %
+                         (activetasks[t]["started_str"], activetasks[t]["title"], t))
 
         if self.main.shutdown:
             content = "Waiting for %s running tasks to finish:" % len(activetasks)
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index e408b04..ae97c78 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -18,6 +18,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import bb.build
+import time
 
 class BBUIHelper:
     def __init__(self):
@@ -31,7 +32,8 @@ class BBUIHelper:
 
     def eventHandler(self, event):
         if isinstance(event, bb.build.TaskStarted):
-            self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task) }
+            self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task),
+                                              'started_str' : time.strftime("%X") }
             self.running_pids.append(event.pid)
             self.needUpdate = True
         if isinstance(event, bb.build.TaskSucceeded):
-- 
1.7.11.4



