Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 48A0A60249
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 02:53:11 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 12 Jun 2016 19:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,464,1459839600"; d="scan'208";a="120682993"
Received: from ctan5-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.32])
	by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2016 19:53:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Jun 2016 14:52:23 +1200
Message-Id: <07af1a4f8aa5a11662fbb76e6f579269c8c3f013.1465786269.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 07/10] knotty: show task progress bar
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 13 Jun 2016 02:53:11 -0000

In addition to the "currently running n tasks (x of y)" message, show a
progress bar for another view on how much of the build is left. We have
to take care to reset it when moving from the scenequeue to the
runqueue, and explicitly don't include an ETA since not all tasks take
equal time and thus it isn't possible to estimate the time remaining
with the information available.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 6fdaafe..c245c22 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -89,6 +89,7 @@ class NonInteractiveProgress(object):
     def __init__(self, msg, maxval):
         self.msg = msg
         self.maxval = maxval
+        self.finished = False
 
     def start(self, update=True):
         self.fobj.write("%s..." % self.msg)
@@ -99,8 +100,11 @@ class NonInteractiveProgress(object):
         pass
 
     def finish(self):
+        if self.finished:
+            return
         self.fobj.write("done.\n")
         self.fobj.flush()
+        self.finished = True
 
 def new_progress(msg, maxval):
     if interactive:
@@ -204,6 +208,8 @@ class TerminalFilter(object):
         console.addFilter(InteractConsoleLogFilter(self, format))
         errconsole.addFilter(InteractConsoleLogFilter(self, format))
 
+        self.main_progress = None
+
     def clearFooter(self):
         if self.footer_present:
             lines = self.footer_present
@@ -246,11 +252,20 @@ class TerminalFilter(object):
 
         if self.main.shutdown:
             content = "Waiting for %s running tasks to finish:" % len(activetasks)
-        elif not len(activetasks):
-            content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
+            print(content)
         else:
-            content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
-        print(content)
+            if not len(activetasks):
+                content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
+            else:
+                content = "Currently %2s running tasks (%s of %s)" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
+            maxtask = self.helper.tasknumber_total + 1
+            if not self.main_progress or self.main_progress.maxval != maxtask:
+                widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
+                self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets)
+                self.main_progress.start(False)
+            self.main_progress.setmessage(content)
+            self.main_progress.update(self.helper.tasknumber_current)
+            print('')
         lines = 1 + int(len(content) / (self.columns + 1))
         for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
             if isinstance(task, tuple):
-- 
2.5.5


