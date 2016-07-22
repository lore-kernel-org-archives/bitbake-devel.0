Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 315F2606BF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 12:19:06 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 22 Jul 2016 05:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,404,1464678000"; d="scan'208";a="1000482138"
Received: from lwong9-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.13])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2016 05:19:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Jul 2016 00:18:37 +1200
Message-Id: <90820629a3ff7b204b5e0e2dca9ab55ec59dd41e.1469189882.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1469189882.git.paul.eggleton@linux.intel.com>
References: <cover.1469189882.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1469189882.git.paul.eggleton@linux.intel.com>
References: <cover.1469189882.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] knotty: fix some minor bugs in BBProgress
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
X-List-Received-Date: Fri, 22 Jul 2016 12:19:06 -0000

If you specify custom widgets then we don't want to assume where the
"extra" position is - you should have to specify it, and if it isn't
specified it shouldn't just wipe out the last widget or you can start to
see odd behaviour if you're modifying the code.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index e8e169f..b92334b 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -40,9 +40,9 @@ logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 
 class BBProgress(progressbar.ProgressBar):
-    def __init__(self, msg, maxval, widgets=None):
+    def __init__(self, msg, maxval, widgets=None, extrapos=-1):
         self.msg = msg
-        self.extrapos = -1
+        self.extrapos = extrapos
         if not widgets:
             widgets = [progressbar.Percentage(), ' ', progressbar.Bar(), ' ',
             progressbar.ETA()]
@@ -69,15 +69,16 @@ class BBProgress(progressbar.ProgressBar):
         self.widgets[0] = msg
 
     def setextra(self, extra):
-        if extra:
-            extrastr = str(extra)
-            if extrastr[0] != ' ':
-                extrastr = ' ' + extrastr
-            if extrastr[-1] != ' ':
-                extrastr += ' '
-        else:
-            extrastr = ' '
-        self.widgets[self.extrapos] = extrastr
+        if self.extrapos > -1:
+            if extra:
+                extrastr = str(extra)
+                if extrastr[0] != ' ':
+                    extrastr = ' ' + extrastr
+                if extrastr[-1] != ' ':
+                    extrastr += ' '
+            else:
+                extrastr = ' '
+            self.widgets[self.extrapos] = extrastr
 
     def _need_update(self):
         # We always want the bar to print when update() is called
@@ -241,7 +242,7 @@ class TerminalFilter(object):
                 start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider()])
+                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2)
                         pbar.bouncing = True
                     else:
                         pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100)
-- 
2.5.5


