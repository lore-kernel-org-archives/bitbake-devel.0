Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <sgw@linux.intel.com>) id 1SHm18-0002S9-8q
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 03:06:40 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 10 Apr 2012 17:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="152167275"
Received: from unknown (HELO swold-mobl.bigsur.com) ([10.255.12.159])
	by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2012 17:57:15 -0700
From: Saul Wold <sgw@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Apr 2012 17:57:15 -0700
Message-Id: <1334105835-433-1-git-send-email-sgw@linux.intel.com>
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
X-List-Received-Date: Wed, 11 Apr 2012 01:06:42 -0000

Also adjusted the cmdline ordering to work correctly
with both xterm and vte.

Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py |   11 +++++++----
 lib/bb/ui/crumbs/hig.py     |    8 +++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index a3410d4..6ff16ed 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -37,6 +37,7 @@ from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
                              AdvancedSettingDialog, LayerSelectionDialog, \
                              DeployImageDialog
 from bb.ui.crumbs.persistenttooltip import PersistentTooltip
+import bb.ui.crumbs.utils
 
 class Configuration:
     '''Represents the data structure of configuration.'''
@@ -944,12 +945,13 @@ class Builder(gtk.Window):
         if response == gtk.RESPONSE_YES:
             source_env_path = os.path.join(self.parameters.core_base, "oe-init-build-env")
             tmp_path = self.parameters.tmpdir
+            cmdline = bb.ui.crumbs.utils.which_terminal()
             if os.path.exists(image_path) and os.path.exists(kernel_path) \
-               and os.path.exists(source_env_path) and os.path.exists(tmp_path):
-                cmdline = "/usr/bin/xterm -e "
-                cmdline += "\" export OE_TMPDIR=" + tmp_path + "; "
+               and os.path.exists(source_env_path) and os.path.exists(tmp_path)
+               and cmdline:
+                cmdline += "\' bash -c \"export OE_TMPDIR=" + tmp_path + "; "
                 cmdline += "source " + source_env_path + " " + os.getcwd() + "; "
-                cmdline += "runqemu " + kernel_path + " " + image_path + "; bash\""
+                cmdline += "runqemu " + kernel_path + " " + image_path + "\"\'"
                 subprocess.Popen(shlex.split(cmdline))
             else:
                 lbl = "<b>Path error</b>\nOne of your paths is wrong,"
@@ -958,6 +960,7 @@ class Builder(gtk.Window):
                 lbl = lbl + "kernel path:" + kernel_path + "\n"
                 lbl = lbl + "source environment path:" + source_env_path + "\n"
                 lbl = lbl + "tmp path: " + tmp_path + "."
+                lbl = lbl + "You may be missing either xterm or vte for terminal services."
                 dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
                 button = dialog.add_button("Close", gtk.RESPONSE_OK)
                 HobButton.style_button(button)
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 9adb281..402892e 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -30,6 +30,7 @@ import shlex
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
 from bb.ui.crumbs.progressbar import HobProgressBar
+import bb.ui.crumbs.utils
 
 """
 The following are convenience classes for implementing GNOME HIG compliant
@@ -737,9 +738,10 @@ class DeployImageDialog (CrumbsDialog):
         if response_id == gtk.RESPONSE_YES:
             combo_item = self.usb_combo.get_active_text()
             if combo_item and combo_item != self.__dummy_usb__:
-                cmdline = "/usr/bin/xterm -e "
-                cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "; bash\""
-                subprocess.Popen(args=shlex.split(cmdline))
+                cmdline = bb.ui.crumbs.utils.which_terminal()
+                if cmdline:
+                    cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
+                    subprocess.Popen(args=shlex.split(cmdline))
 
     def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
-- 
1.7.5.4



