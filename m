Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1Tyl16-0002XS-86
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 16:16:32 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 25 Jan 2013 06:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,538,1355126400"; d="scan'208";a="276606933"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 25 Jan 2013 07:00:55 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2013 17:05:26 +0200
Message-Id: <1359126326-9551-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: small fixes to parsing warnings dialog
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
X-List-Received-Date: Fri, 25 Jan 2013 15:16:32 -0000

Set the labels selectable; reset the warnings list when another machine is selected;
changed a label name

[YOCTO #3215]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/parsingwarningsdialog.py  |    6 ++++--
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py
index 5cddd65..33bac39 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py
@@ -105,8 +105,10 @@ class ParsingWarningsDialog (CrumbsDialog):
     def create_visual_elements(self):
         self.set_size_request(350, 350)
         self.heading_label = gtk.Label()
-        self.heading_label.set_alignment(0.1, 0)
+        self.heading_label.set_alignment(0, 0)
         self.warning_label = gtk.Label()
+        self.warning_label.set_selectable(True)
+        self.warning_label.set_alignment(0, 0)
         self.textWindow = gtk.ScrolledWindow()
 
         table = gtk.Table(1, 10, False)
@@ -155,7 +157,7 @@ class ParsingWarningsDialog (CrumbsDialog):
             self.vbox.pack_start(self.heading_label, expand=False, fill=False)
             self.vbox.pack_start(self.warning_label, expand=False, fill=False)
             self.vbox.pack_start(self.textWindow, expand=False, fill=False)
-            cancel_button = self.add_button("Cancel", gtk.RESPONSE_CANCEL)
+            cancel_button = self.add_button("Close", gtk.RESPONSE_CANCEL)
             HobAltButton.style_button(cancel_button)
 
         self.refresh_components()
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index a0cbe85..df7a017 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -298,6 +298,7 @@ class ImageConfigurationPage (HobPage):
 
     def machine_combo_changed_cb(self, machine_combo):
         self.stopping = False
+        self.builder.parsing_warnings = []
         combo_item = machine_combo.get_active_text()
         if not combo_item or combo_item == self.__dummy_machine__:
             return
-- 
1.7.9.5



