Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TEeAC-0006tS-96
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Sep 2012 12:39:20 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Sep 2012 03:25:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,453,1344236400"; d="scan'208";a="224499343"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2012 03:25:28 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Sep 2012 13:27:56 +0300
Message-Id: <1348136876-8840-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] [hob] Remove stray "distro" combobox from simple settings
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
X-List-Received-Date: Thu, 20 Sep 2012 10:39:20 -0000

The "distro" combobox was moved to advanced settings, but it
was also present in simple settings. This patch removed it
from simple settings.
This patch is meant to be applied over my previous "fix settings"
patch, version 1 only (version 2 of the patch already contains
this fix).

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index e043f93..f304a68 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -195,7 +195,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.max_threads = max_threads
 
         # class members for internal use
-        self.distro_combo = None
         self.dldir_text = None
         self.sstatedir_text = None
         self.sstatemirror_text = None
@@ -330,7 +329,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.refresh_proxy_components()
 
     def response_cb(self, dialog, response_id):        
-        #self.configuration.curr_distro = self.distro_combo.get_active_text()
         self.configuration.dldir = self.dldir_text.get_text()
         self.configuration.sstatedir = self.sstatedir_text.get_text()
         self.configuration.sstatemirror = self.sstatemirror_text.get_text()
@@ -358,14 +356,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select distro:</span>")
-        tooltip = "Selects the Yocto Project distribution you want"
-        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(distro_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">BB number threads:</span>")
         tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
-- 
1.7.9.5



