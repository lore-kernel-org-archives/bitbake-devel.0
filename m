Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9EFA06DEEA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 18:58:57 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 02 Dec 2013 10:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,812,1378882800"; d="scan'208";a="443340804"
Received: from pmcgurk-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.121.184])
	by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2013 10:58:55 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Dec 2013 18:58:46 +0000
Message-Id: <8b2ad1ee039f011adbba1f71d042a530c7d25ea4.1386010573.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386010573.git.paul.eggleton@linux.intel.com>
References: <cover.1386010573.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386010573.git.paul.eggleton@linux.intel.com>
References: <cover.1386010573.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] hob: name package files list variables appropriately
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 02 Dec 2013 18:58:57 -0000

This treeview code was obviously copy-pasted from one of the config
dialogs and the variables were never renamed. Rename them now to improve
readability.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/crumbs/hig/propertydialog.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig/propertydialog.py b/lib/bb/ui/crumbs/hig/propertydialog.py
index bc40741..9ab7d75 100644
--- a/lib/bb/ui/crumbs/hig/propertydialog.py
+++ b/lib/bb/ui/crumbs/hig/propertydialog.py
@@ -187,17 +187,17 @@ class PropertyDialog(CrumbsDialog):
                         self.textWindow.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
                         self.textWindow.set_size_request(100, 170)
 
-                        sstatemirrors_store = gtk.ListStore(str)
+                        packagefiles_store = gtk.ListStore(str)
 
-                        self.sstatemirrors_tv = gtk.TreeView()
-                        self.sstatemirrors_tv.set_rules_hint(True)
-                        self.sstatemirrors_tv.set_headers_visible(True)
-                        self.textWindow.add(self.sstatemirrors_tv)
+                        self.packagefiles_tv = gtk.TreeView()
+                        self.packagefiles_tv.set_rules_hint(True)
+                        self.packagefiles_tv.set_headers_visible(True)
+                        self.textWindow.add(self.packagefiles_tv)
 
                         self.cell1 = gtk.CellRendererText()
                         col1 = gtk.TreeViewColumn('Package files', self.cell1)
                         col1.set_cell_data_func(self.cell1, self.regex_field)
-                        self.sstatemirrors_tv.append_column(col1)
+                        self.packagefiles_tv.append_column(col1)
 
                         for items in file_list.split(']'):
                             if len(items) > 1:
@@ -223,15 +223,15 @@ class PropertyDialog(CrumbsDialog):
                                         items = items[:len(items)/2] + "..." + items[len(items)/2+3:]
                                         self.tooltip_items[items] = temp
 
-                                sstatemirrors_store.append([str(items)])
+                                packagefiles_store.append([str(items)])
                                 
                                 
-                        self.sstatemirrors_tv.set_model(sstatemirrors_store)
+                        self.packagefiles_tv.set_model(packagefiles_store)
 
                         tips = gtk.Tooltips()
-                        tips.set_tip(self.sstatemirrors_tv, "")
-                        self.sstatemirrors_tv.connect("motion-notify-event", self.treeViewTooltip, tips, 0)
-                        self.sstatemirrors_tv.set_events(gtk.gdk.POINTER_MOTION_MASK)
+                        tips.set_tip(self.packagefiles_tv, "")
+                        self.packagefiles_tv.connect("motion-notify-event", self.treeViewTooltip, tips, 0)
+                        self.packagefiles_tv.set_events(gtk.gdk.POINTER_MOTION_MASK)
                         
                         self.vbox.add(self.textWindow)                                      
 
-- 
1.8.1.2


