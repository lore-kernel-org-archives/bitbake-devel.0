Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXcj-0000Mz-GI
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:33 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778606"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:37 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:26 -0700
Message-Id: <c794348a764a458d7ae3b5fee9849ba2f95bc724.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
Subject: [PATCH 01/10] ui/crumbs/hobwidget: add clear icon to search entries in HobNotebook
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
X-List-Received-Date: Thu, 22 Mar 2012 02:19:33 -0000

It's a common pattern on Gtk+ desktops to be able to clear a search/filter
entry using an icon in that entry.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 4b0a0cf..db52c47 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -622,6 +622,8 @@ class HobNotebook(gtk.VBox):
         self.search.set_style(style)
         self.search.set_text(name)
         self.search.set_editable(False)
+        self.search.set_icon_from_stock(gtk.ENTRY_ICON_SECONDARY, gtk.STOCK_CLEAR)
+        self.search.connect("icon-release", self.set_search_entry_clear_cb)
         self.search.show()
         self.align = gtk.Alignment(xalign=1.0, yalign=0.7)
         self.align.add(self.search)
@@ -682,9 +684,16 @@ class HobNotebook(gtk.VBox):
         style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.BLACK, False, False)
         search.set_style(style)
 
-    def set_search_entry_reset_cb(self, search, event):
-        style = search.get_style()
+    def reset_entry(self, entry):
+        style = entry.get_style()
         style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
-        search.set_style(style)
-        search.set_text(self.search_name)
-        search.set_editable(False)
+        entry.set_style(style)
+        entry.set_text(self.search_name)
+        entry.set_editable(False)
+
+    def set_search_entry_reset_cb(self, search, event):
+        self.reset_entry(search)
+
+    def set_search_entry_clear_cb(self, search, icon_pos, event):
+        self.reset_entry(search)
+
-- 
1.7.7.6



