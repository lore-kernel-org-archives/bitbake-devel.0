Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBY-0003eQ-5B
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:53:49 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343655"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:17 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:26 +0200
Message-Id: <1362497791-30020-7-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 06/11] added entries for information dialogs
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
X-List-Received-Date: Tue, 05 Mar 2013 15:53:50 -0000

added information so that it would display correctly in the information dialogs.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index 5f316ae..e0fbdca 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -260,7 +260,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky reference manual</a> for information"
-        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
+        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads,"<b>BitBake prallalel threads</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
 
@@ -270,7 +270,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip = "Sets the maximum number of threads the host can use during the build. See the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky reference manual</a> for information"
-        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
+        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads,"<b>Make parallel threads</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
 
@@ -279,7 +279,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("Downloads directory")
         tooltip = "Select a folder that caches the upstream project source code"
-        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
+        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self,"<b>Downloaded source code</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
 
@@ -293,7 +293,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False, padding=24)
         content = "<span>Shared state directory</span>"
         tooltip = "Select a folder that caches your prebuilt results"
-        label = self.gen_label_info_widget(content, tooltip)
+        label = self.gen_label_info_widget(content,"<b>Shared state directory</b>" + "*" + tooltip)
         sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False, padding=6)
@@ -305,7 +305,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip += "For more information on shared state mirrors, check the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#shared-state\">Yocto Project Reference Manual</a>."
-        table = self.gen_label_info_widget(content, tooltip)
+        table = self.gen_label_info_widget(content,"Shared state mirrors" + "*" + tooltip)
         advanced_vbox.pack_start(table, expand=False, fill=False, padding=6)
 
         sub_vbox = gtk.VBox(False)
@@ -627,7 +627,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Set the proxies used when fetching source code</span>")
         tooltip = "Set the proxies used when fetching source code.  A blank field uses a direct internet connection."
-        info = HobInfoButton(tooltip, self)
+        info = HobInfoButton("<span weight=\"bold\">Set the proxies used when fetching source code</span>" + "*" + tooltip, self)
         hbox = gtk.HBox(False, 12)
         hbox.pack_start(label, expand=True, fill=True)
         hbox.pack_start(info, expand=False, fill=False)
@@ -875,7 +875,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=True, fill=True)
         label = self.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
         tooltip = "These are key/value pairs for your extra settings. Click \'Add\' and then directly edit the key and the value"
-        setting_widget, self.setting_store = self.gen_editable_settings(self.configuration.extra_setting, tooltip)
+        setting_widget, self.setting_store = self.gen_editable_settings(self.configuration.extra_setting,"<b>Add your own variables</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(setting_widget, expand=True, fill=True)
 
-- 
1.7.9.5



