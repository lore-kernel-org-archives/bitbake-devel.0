Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SA09G-0000xv-A1
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:34:54 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 07:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119558629"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 07:26:02 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 22:41:11 +0800
Message-Id: <a95b61d48bf92948ff5a21896e71ed3cb323ab38.1332254194.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
References: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
In-Reply-To: <cover.1332254194.git.shane.wang@intel.com>
References: <cover.1332254194.git.shane.wang@intel.com>
Subject: [PATCH 10/11] Hob: fix static variable "self.search" to parameter "search" in signal callback function
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
X-List-Received-Date: Tue, 20 Mar 2012 14:34:54 -0000

From: Liming An <limingx.l.an@intel.com>

To fix the signal callback function code, and make the temp parameter to replaced the static global variable, as required.

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index a5c52f7..0bb83d7 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -673,20 +673,17 @@ class HobNotebook(gtk.VBox):
 
     def blank_area_resize_cb(self, widget, request_x, request_y, request_width, request_height):
         self.search.set_size_request(request_width, request_height)
-        widget.modify_bg(gtk.STATE_SELECTED, gtk.gdk.color_parse(HobColors.YELLOW))
-
-    def set_search_entry_editable_cb(self, widget, event):
-        if self.search:
-            self.search.set_editable(True)
-            self.search.set_text("")
-            style = self.search.get_style()
-            style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.BLACK, False, False)
-            self.search.set_style(style)
-
-    def set_search_entry_reset_cb(self, widget, event):
-        if self.search:
-            style = self.search.get_style()
-            style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
-            self.search.set_style(style)
-            self.search.set_text(self.search_name)
-            self.search.set_editable(False)
+
+    def set_search_entry_editable_cb(self, search, event):
+        search.set_editable(True)
+        search.set_text("")
+        style = self.search.get_style()
+        style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.BLACK, False, False)
+        search.set_style(style)
+
+    def set_search_entry_reset_cb(self, search, event):
+        style = search.get_style()
+        style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
+        search.set_style(style)
+        search.set_text(self.search_name)
+        search.set_editable(False)
-- 
1.7.6



