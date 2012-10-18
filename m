Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TOmIN-0007O6-Ci
	for bitbake-devel@lists.openembedded.org;
	Thu, 18 Oct 2012 11:21:39 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 18 Oct 2012 02:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,606,1344236400"; d="scan'208";a="229136878"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 18 Oct 2012 02:08:17 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Oct 2012 12:09:51 +0300
Message-Id: <1350551391-4596-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/settings: add a scroll bar for the box with mirrors
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
X-List-Received-Date: Thu, 18 Oct 2012 09:21:39 -0000

- added a scroll bar in the shared state tab from settings
- added a signal on it, so when you add a new mirror, it will
auto-scroll to the end of the list

[YOCTO #3229]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index ccd9f39..e1aa84c 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -546,8 +546,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False, padding=12)
 
-        sub_vbox = gtk.VBox(False)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         content = "<span weight=\"bold\">Shared state mirrors</span>"
         tooltip = "URLs pointing to pre-built mirrors that will speed your build. "
         tooltip += "Select the \'Standard\' configuration if the structure of your "
@@ -556,8 +554,14 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#shared-state\">Yocto Project Reference Manual</a>."
         table = self.gen_label_info_widget(content, tooltip)
-        sub_vbox.pack_start(table, expand=False, fill=False)
+        advanced_vbox.pack_start(table, expand=False, fill=False)
 
+        sub_vbox = gtk.VBox(False)
+        scroll = gtk.ScrolledWindow()
+        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
+        scroll.add_with_viewport(sub_vbox)
+        scroll.connect('size-allocate', self.scroll_changed)
+        advanced_vbox.pack_start(scroll, gtk.TRUE, gtk.TRUE, 0)
         searched_string = "file://"
 
         if self.sstatemirrors_changed == 0:
@@ -608,6 +612,9 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.show_all()
         self.nb.set_current_page(page_num)
 
+    def scroll_changed(self, widget, event, data=None):
+        adj = widget.get_vadjustment()
+        adj.set_value(adj.upper - adj.page_size)
 
     def create_proxy_page(self):
         advanced_vbox = gtk.VBox(False, 6)
-- 
1.7.9.5



