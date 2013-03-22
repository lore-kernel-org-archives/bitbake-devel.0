Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UJ42L-0001bg-Uw
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Mar 2013 16:37:46 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 22 Mar 2013 08:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,892,1355126400"; d="scan'208";a="274635712"
Received: from adinu-vostro-460.rb.intel.com (HELO localhost.localdomain)
	([10.237.105.45])
	by azsmga001.ch.intel.com with ESMTP; 22 Mar 2013 08:19:34 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Mar 2013 17:20:10 +0200
Message-Id: <1363965610-9866-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] Adjust spacing on information windows
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
X-List-Received-Date: Fri, 22 Mar 2013 15:37:49 -0000

[Hob #4070]

- tweaked the spacing on info windows

- fixed text bolding in simple settings dialog

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py     |   14 +++++++-------
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
index d68ef3a..4420f97 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
@@ -56,7 +56,7 @@ class PropertyDialog(CrumbsDialog):
                 HOB_ICON_BASE_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), ("icons/"))
                 ICON_PACKAGES_DISPLAY_FILE    = os.path.join(HOB_ICON_BASE_DIR, ('info/info_display.png'))
 
-                self.table = gtk.Table(2,2,False)
+                self.table = gtk.Table(1,1,False)
                 self.table.set_row_spacings(0)
                 self.table.set_col_spacings(0)
 
@@ -68,21 +68,21 @@ class PropertyDialog(CrumbsDialog):
                 image_info = self.properties.split("*")[0]
                 info = self.properties.split("*")[1]
                 
-                vbox = gtk.VBox(True, spacing=0)        
+                vbox = gtk.VBox(True, spacing=30)        
                 
                 self.label_short = gtk.Label()
                 self.label_short.set_line_wrap(False)
-                self.label_short.set_markup("          " + image_info)
+                self.label_short.set_markup(image_info)
                 self.label_short.set_property("xalign", 0)
 
                 self.info_label = gtk.Label()
                 self.info_label.set_line_wrap(True)
                 self.info_label.set_markup(info)
-                self.info_label.set_property("xalign", 1)
+                self.info_label.set_property("yalign", 0.5)
 
-                self.table.attach(self.image, 0,1,0,1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL)
-                self.table.attach(self.label_short, 0,1,0,1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL)
-                self.table.attach(self.info_label, 0,1,1,2, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL)
+                self.table.attach(self.image, 0,1,0,1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL,xpadding=5,ypadding=5)
+                self.table.attach(self.label_short, 0,1,0,1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL,xpadding=40,ypadding=5)
+                self.table.attach(self.info_label, 0,1,1,2, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL,xpadding=40,ypadding=10)
         
                 self.vbox.add(self.table)
 
diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index e0fbdca..8ac82ed 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -305,7 +305,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip += "For more information on shared state mirrors, check the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#shared-state\">Yocto Project Reference Manual</a>."
-        table = self.gen_label_info_widget(content,"Shared state mirrors" + "*" + tooltip)
+        table = self.gen_label_info_widget(content,"<b>Shared state mirrors</b>" + "*" + tooltip)
         advanced_vbox.pack_start(table, expand=False, fill=False, padding=6)
 
         sub_vbox = gtk.VBox(False)
-- 
1.7.9.5



