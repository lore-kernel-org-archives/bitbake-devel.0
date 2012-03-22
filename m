Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SAjpu-0003NQ-HW
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 16:21:58 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 22 Mar 2012 08:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="122001561"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 22 Mar 2012 08:13:02 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 23:38:10 +0800
Message-Id: <7d3e77fcd31137d24e3c9782f0cfcc30ebc80a01.1332430442.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
References: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
In-Reply-To: <cover.1332430442.git.shane.wang@intel.com>
References: <cover.1332430442.git.shane.wang@intel.com>
Subject: [PATCH 8/8] Hob: add auto scroll to rows which be new appended in hob building log page
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
X-List-Received-Date: Thu, 22 Mar 2012 15:21:58 -0000

From: Liming An <limingx.l.an@intel.com>

For make the building screen to provide clear information about task in progress by request, so add this function.

At the beginning of building, the vertical scroll bar will go to the active area automatically.
Once the user moves the scroll bar in the middle, the automatic move of the bar is disabled.
However, once the user moves it to the bottom again, it will be kept to the bottom even though more logs come.

[Yocto #2098]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 92ca176..5f1524f 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -38,7 +38,7 @@ class BuildDetailsPage (HobPage):
         super(BuildDetailsPage, self).__init__(builder, "Building ...")
 
         self.num_of_issues = 0
-
+        self.endpath = (0,)
         # create visual elements
         self.create_visual_elements()
 
@@ -77,6 +77,8 @@ class BuildDetailsPage (HobPage):
         self.scrolled_view_build.add(self.build_tv)
         self.notebook.append_page(self.scrolled_view_build, gtk.Label("Log"))
 
+        self.builder.handler.build.model.connect_after("row-changed", self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(), self.build_tv)
+
         self.button_box = gtk.HBox(False, 6)
         self.back_button = HobAltButton("Back to image configuration")
         self.back_button.connect("clicked", self.back_button_clicked_cb)
@@ -138,3 +140,10 @@ class BuildDetailsPage (HobPage):
 
     def hide_stop_button(self):
         self.stop_button.hide()
+
+    def scroll_to_present_row(self, model, path, iter, v_adj, treeview):
+        if treeview and v_adj:
+            if path[0] > self.endpath[0]: # check the event is a new row append or not
+                self.endpath = path
+                if v_adj.value == (v_adj.upper - v_adj.page_size): # check the gtk.adjustment position is at end boundary or not
+                    treeview.scroll_to_cell(path)
-- 
1.7.6



