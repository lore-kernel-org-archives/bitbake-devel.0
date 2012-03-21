Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SA9Lb-0004j2-Do
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 01:24:15 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 17:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119778614"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.207])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 17:15:20 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 17:15:15 -0700
Message-Id: <b507b4285ca743267b2fa28f373ed9783f05cb5a.1332288516.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332288516.git.josh@linux.intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
In-Reply-To: <cover.1332288516.git.josh@linux.intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
Subject: [PATCH 2/5] ui/crumbs/hobwidget: add clear icon to search entries in HobNotebook
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
X-List-Received-Date: Wed, 21 Mar 2012 00:24:15 -0000

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



