Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 328 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 07 Dec 2017 14:44:01 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 558A3784EB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 14:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id C445318463
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id mWpG4oiz4JSV for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 958681845F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8442A1A067
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 790E91A040
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 6D7122E4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id vB7EcXYW020912
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 7 Dec 2017 15:38:33 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id vB7EcXnI020911
	for bitbake-devel@lists.openembedded.org; Thu, 7 Dec 2017 15:38:33 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Dec 2017 15:38:31 +0100
Message-Id: <20171207143832.20865-2-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20171207143832.20865-1-pkj@axis.com>
References: <20171207143832.20865-1-pkj@axis.com>
X-TM-AS-GCONF: 00
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
X-List-Received-Date: Thu, 07 Dec 2017 14:44:01 -0000

When creating a new progress bar (using BBProgress), a colon was
appended to the supplied message. However, when updating the message,
no colon was appended.

Change this so that the colon is instead part of the widgets that make
up the progress bar so that it does not matter when and how the
message is updated, it always displays the same.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index fa88e6ccdd..a945fc1994 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -45,15 +45,15 @@ class BBProgress(progressbar.ProgressBar):
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
@@ -248,10 +248,10 @@ class TerminalFilter(object):
                 start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s (pid %s)" % (activetasks[t]["title"], t), 100, widgets=[' ', progressbar.BouncingSlider(), ''], extrapos=3, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s (pid %s)" % (activetasks[t]["title"], t), 100, widgets=[' ', progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=5, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = False
                     activetasks[t]["progressbar"] = pbar
                 tasks.append((pbar, progress, rate, start_time))
-- 
2.12.0


