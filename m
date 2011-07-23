Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkUIZ-0005rW-0D
	for bitbake-devel@lists.openembedded.org;
	Sat, 23 Jul 2011 06:58:47 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 21:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,251,1309762800"; d="scan'208";a="31029044"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.127])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 21:54:35 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 21:54:22 -0700
Message-Id: <9046c131f167ccb451e245146fcbbe8bb7aed084.1311396521.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
Subject: [PATCH 3/8] ui/hob: clear the search entry when resetting
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
X-List-Received-Date: Sat, 23 Jul 2011 04:58:47 -0000

When resetting and clearing all selections the searched for term is no
longer the selected row in the packages list, clear the search entry to
prevent cognitive disconnect.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index b60ca2f..a8bbd73 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -282,6 +282,7 @@ class MainWindow (gtk.Window):
         dialog.destroy()
         if response == gtk.RESPONSE_OK:
             self.reset_build()
+            self.search.set_text("")
         return
 
     def reset_build(self):
@@ -576,12 +577,12 @@ class MainWindow (gtk.Window):
 
         hb = gtk.HBox(False, 0)
         hb.show()
-        search = gtk.Entry()
-        search.set_icon_from_stock(gtk.ENTRY_ICON_SECONDARY, "gtk-clear")
-        search.connect("icon-release", self.search_entry_clear_cb)
-        search.show()
-        self.pkgsaz_tree.set_search_entry(search)
-        hb.pack_end(search, False, False, 0)
+        self.search = gtk.Entry()
+        self.search.set_icon_from_stock(gtk.ENTRY_ICON_SECONDARY, "gtk-clear")
+        self.search.connect("icon-release", self.search_entry_clear_cb)
+        self.search.show()
+        self.pkgsaz_tree.set_search_entry(self.search)
+        hb.pack_end(self.search, False, False, 0)
         label = gtk.Label("Search packages:")
         label.show()
         hb.pack_end(label, False, False, 6)
-- 
1.7.6



