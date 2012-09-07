Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1T9xQ2-00050q-0U
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 14:12:18 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 07 Sep 2012 04:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,385,1344236400"; d="scan'208";a="198843720"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 07 Sep 2012 04:59:50 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2012 15:00:11 +0300
Message-Id: <1347019211-24363-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: print message when DISPLAY is not set
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
X-List-Received-Date: Fri, 07 Sep 2012 12:12:18 -0000

If DISPLAY wasn't set, launching hob has printed a traceback
difficult to understand. Now, the exception is caught and it
shows a human message.

[YOCTO #2596]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7de4798..f9e54a8 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -28,6 +28,7 @@ import subprocess
 import shlex
 import re
 import logging
+import sys
 from bb.ui.crumbs.template import TemplateMgr
 from bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage
 from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
@@ -457,8 +458,14 @@ class Builder(gtk.Window):
         self.set_title("Hob")
         self.set_icon_name("applications-development")
         self.set_resizable(True)
-        window_width = self.get_screen().get_width()
-        window_height = self.get_screen().get_height()
+
+        try:
+            window_width = self.get_screen().get_width()
+            window_height = self.get_screen().get_height()
+        except AttributeError:
+            print "Please set DISPLAY variable before running Hob."
+            sys.exit(1)
+
         if window_width >= hwc.MAIN_WIN_WIDTH:
             window_width = hwc.MAIN_WIN_WIDTH
             window_height = hwc.MAIN_WIN_HEIGHT
@@ -1334,4 +1341,4 @@ class Builder(gtk.Window):
             format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
             self.consolelog.setFormatter(format)
 
-            self.logger.addHandler(self.consolelog)
\ No newline at end of file
+            self.logger.addHandler(self.consolelog)
-- 
1.7.9.5



