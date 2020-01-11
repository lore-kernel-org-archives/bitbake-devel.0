Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id CEC157FFB5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Jan 2020 03:01:45 +0000 (UTC)
IronPort-SDR: d2XPQr4jWbqCunavQcowPr3kCMzUsHbxOU3+NV+nFc15drd+/zEjubI5sMnI85CZ9EUr05HywC
	lXWwX99cJH4jN4gnN+by/5QUCtopMcwcwPA+74zuKHUcUi/Pntp4HhB3sWUwXxn44ViRNekJtz
	T/XtEQXkYZ90b4CmX7FIwD0GVOK2a/9QfiUs9DgxdgQ/W6gi7CNi+1gsCPRScM7UCIcHIwxRGV
	PbpBG+XOutXYNQq35iwzrJIgNBFSzsnueBhJeKKD0QreSw4jm2ly+RBhSGwbiuwx/U9YcSUwba
	Cok=
X-IronPort-AV: E=Sophos;i="5.69,419,1571695200"; 
   d="scan'208";a="4204864"
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 11 Jan 2020 04:01:44 +0100
Message-ID: <20200111030144.19773-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Subject: [PATCH] knotty: Be consistent when creating/updating progress bars
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
X-List-Received-Date: Sat, 11 Jan 2020 03:01:46 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When creating a new progress bar (using BBProgress), a colon was
appended to the supplied message. However, when updating the message,
no colon was appended.

Change this so that the colon is instead part of the widgets that make
up the progress bar so that it does not matter when and how the
message is updated, it always displays the same.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

This is actually a resend of a patch I sent two years ago, which was
left without comments or action. It only applies to master (the
original patch from two years ago should still apply to Zeus, but I do
not see it as necessary to apply it there).

 bitbake/lib/bb/ui/knotty.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index bd9911cf6f..fcc6cddc60 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -35,15 +35,15 @@ class BBProgress(progressbar.ProgressBar):
         self.msg = msg
         self.extrapos = extrapos
         if not widgets:
-            widgets = [progressbar.Percentage(), ' ', progressbar.Bar(), ' ',
-            progressbar.ETA()]
-            self.extrapos = 4
+            widgets = [': ', progressbar.Percentage(), ' ', progressbar.Bar(),
+                       ' ', progressbar.ETA()]
+            self.extrapos = 5
 
         if resize_handler:
             self._resize_default = resize_handler
         else:
             self._resize_default = signal.getsignal(signal.SIGWINCH)
-        progressbar.ProgressBar.__init__(self, maxval, [self.msg + ": "] + widgets, fd=sys.stdout)
+        progressbar.ProgressBar.__init__(self, maxval, [self.msg] + widgets, fd=sys.stdout)
 
     def _handle_resize(self, signum=None, frame=None):
         progressbar.ProgressBar._handle_resize(self, signum, frame)
@@ -255,10 +255,10 @@ class TerminalFilter(object):
                 start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[' ', progressbar.BouncingSlider(), ''], extrapos=3, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[' ', progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=5, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = False
                     activetasks[t]["progressbar"] = pbar
                 tasks.append((pbar, progress, rate, start_time))
-- 
2.21.1


