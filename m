Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <sgw@linux.intel.com>) id 1SHjaI-0001D6-Ab
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 00:30:46 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 10 Apr 2012 15:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="127498332"
Received: from unknown (HELO swold-mobl.bigsur.com) ([10.255.12.159])
	by orsmga001.jf.intel.com with ESMTP; 10 Apr 2012 15:20:22 -0700
From: Saul Wold <sgw@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Apr 2012 15:20:22 -0700
Message-Id: <1334096422-28007-1-git-send-email-sgw@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 2/2] hig/builder: use the new which_terminal() function
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
X-List-Received-Date: Tue, 10 Apr 2012 22:30:46 -0000

Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py |    7 ++++---
 lib/bb/ui/crumbs/hig.py     |    3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index a3410d4..e48afde 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -37,6 +37,7 @@ from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
                              AdvancedSettingDialog, LayerSelectionDialog, \
                              DeployImageDialog
 from bb.ui.crumbs.persistenttooltip import PersistentTooltip
+import bb.ui.crumbs.utils
 
 class Configuration:
     '''Represents the data structure of configuration.'''
@@ -946,10 +947,10 @@ class Builder(gtk.Window):
             tmp_path = self.parameters.tmpdir
             if os.path.exists(image_path) and os.path.exists(kernel_path) \
                and os.path.exists(source_env_path) and os.path.exists(tmp_path):
-                cmdline = "/usr/bin/xterm -e "
-                cmdline += "\" export OE_TMPDIR=" + tmp_path + "; "
+                cmdline = bb.ui.crumbs.utils.which_terminal()
+                cmdline += "\' bash -c \"export OE_TMPDIR=" + tmp_path + "; "
                 cmdline += "source " + source_env_path + " " + os.getcwd() + "; "
-                cmdline += "runqemu " + kernel_path + " " + image_path + "; bash\""
+                cmdline += "runqemu " + kernel_path + " " + image_path + "\"\'"
                 subprocess.Popen(shlex.split(cmdline))
             else:
                 lbl = "<b>Path error</b>\nOne of your paths is wrong,"
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 9adb281..508503c 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -30,6 +30,7 @@ import shlex
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
 from bb.ui.crumbs.progressbar import HobProgressBar
+import bb.ui.crumbs.utils
 
 """
 The following are convenience classes for implementing GNOME HIG compliant
@@ -737,7 +738,7 @@ class DeployImageDialog (CrumbsDialog):
         if response_id == gtk.RESPONSE_YES:
             combo_item = self.usb_combo.get_active_text()
             if combo_item and combo_item != self.__dummy_usb__:
-                cmdline = "/usr/bin/xterm -e "
+                cmdline = bb.ui.crumbs.utils.which_terminal()
                 cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "; bash\""
                 subprocess.Popen(args=shlex.split(cmdline))
 
-- 
1.7.5.4



