Return-Path: <anibal.limon@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 7D59C60745
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Oct 2016 21:51:06 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga104.jf.intel.com with ESMTP; 06 Oct 2016 14:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,454,1473145200"; d="scan'208";a="887503140"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.33])
	by orsmga003.jf.intel.com with ESMTP; 06 Oct 2016 14:51:06 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Oct 2016 16:52:07 -0500
Message-Id: <1475790727-31154-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com, clarson@kergoth.com
Subject: [PATCH] ui/knotty.py: Fix signal handling of SIGWINCH in BBProgress
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
X-List-Received-Date: Thu, 06 Oct 2016 21:51:06 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the ability to pass default signal handler for SIGWINCH in BBProgress
because with multiple instace of BBProgress the original signal handler
set by TerminalFilter (sigwinch_handle) is lost.

This is a fix for stack trace due to multiple async calls of ProgressBar
_handle_resize (ioctl to terminal fd), see:

NOTE: Executing SetScene Tasks
Fatal Python error: Cannot recover from stack overflow.

Current thread 0x00007f70a4793700 (most recent call first):
  File
"/home/alimonb/repos/poky/bitbake/lib/progressbar/progressbar.py", line
183 in _handle_resize
  File "/home/alimonb/repos/poky/bitbake/lib/bb/ui/knotty.py", line 58
in _handle_resize
  File "/home/alimonb/repos/poky/bitbake/lib/bb/ui/knotty.py", line 60
in _handle_resize
...
  File "/home/alimonb/repos/poky/bitbake/lib/bb/ui/knotty.py", line 60
in _handle_resize
...
Aborted

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/ui/knotty.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index b31a8a1..948f527 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -32,6 +32,7 @@ import fcntl
 import struct
 import copy
 import atexit
+
 from bb.ui import uihelper
 
 featureSet = [bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
@@ -40,7 +41,7 @@ logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 
 class BBProgress(progressbar.ProgressBar):
-    def __init__(self, msg, maxval, widgets=None, extrapos=-1):
+    def __init__(self, msg, maxval, widgets=None, extrapos=-1, resize_handler=None):
         self.msg = msg
         self.extrapos = extrapos
         if not widgets:
@@ -48,10 +49,10 @@ class BBProgress(progressbar.ProgressBar):
             progressbar.ETA()]
             self.extrapos = 4
 
-        try:
+        if resize_handler:
+            self._resize_default = resize_handler
+        else:
             self._resize_default = signal.getsignal(signal.SIGWINCH)
-        except:
-            self._resize_default = None
         progressbar.ProgressBar.__init__(self, maxval, [self.msg + ": "] + widgets, fd=sys.stdout)
 
     def _handle_resize(self, signum=None, frame=None):
@@ -247,10 +248,10 @@ class TerminalFilter(object):
                 start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2)
+                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4)
+                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = False
                     activetasks[t]["progressbar"] = pbar
                 tasks.append((pbar, progress, rate, start_time))
@@ -274,7 +275,7 @@ class TerminalFilter(object):
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
-                self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets)
+                self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets, resize_handler=self.sigwinch_handle)
                 self.main_progress.start(False)
             self.main_progress.setmessage(content)
             progress = self.helper.tasknumber_current - 1
-- 
2.1.4


