Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QexHn-00015h-2T
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jul 2011 00:43:07 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 Jul 2011 15:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,496,1304319600"; d="scan'208";a="24664406"
Received: from vorpal.jf.intel.com ([10.7.199.170])
	by orsmga001.jf.intel.com with ESMTP; 07 Jul 2011 15:39:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Jul 2011 15:43:27 -0700
Message-Id: <d24a1e165aa32875c8cbaff70d5a66c8d3a8b2aa.1310078501.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1310078501.git.josh@linux.intel.com>
References: <cover.1310078501.git.josh@linux.intel.com>
In-Reply-To: <cover.1310078501.git.josh@linux.intel.com>
References: <cover.1310078501.git.josh@linux.intel.com>
Subject: [PATCH 3/3] lib/bb/ui/hob: don't error when dismissing save as dialog
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
X-List-Received-Date: Thu, 07 Jul 2011 22:43:07 -0000

If the user decides to cancel the save as dialog we should not try and save
regardless.

Fixes [YOCTO #1220]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 7647d21..06d936e 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -99,12 +99,15 @@ class MainWindow (gtk.Window):
             dialog.add_buttons(gtk.STOCK_NO, gtk.RESPONSE_NO,
                                gtk.STOCK_YES, gtk.RESPONSE_YES)
             resp = dialog.run()
+            dialog.destroy()
             if resp == gtk.RESPONSE_YES:
                 if not self.save_path:
                     self.get_save_path()
-                self.save_recipe_file()
-                rep = self.model.get_build_rep()
-                rep.writeRecipe(self.save_path, self.model)
+
+                if self.save_path:
+                    self.save_recipe_file()
+                    rep = self.model.get_build_rep()
+                    rep.writeRecipe(self.save_path, self.model)
 
         gtk.main_quit()
 
@@ -325,17 +328,22 @@ class MainWindow (gtk.Window):
         chooser.set_current_name("myimage.bb")
         response = chooser.run()
         if response == gtk.RESPONSE_OK:
-            self.save_path = chooser.get_filename()
+            save_path = chooser.get_filename()
+        else:
+            save_path = None
         chooser.destroy()
+        self.save_path = save_path
 
     def save_cb(self, action):
         if not self.save_path:
             self.get_save_path()
-        self.save_recipe_file()
+        if self.save_path:
+            self.save_recipe_file()
 
     def save_as_cb(self, action):
         self.get_save_path()
-        self.save_recipe_file()
+        if self.save_path:
+            self.save_recipe_file()
 
     def open_cb(self, action):
         chooser = gtk.FileChooserDialog(title=None, parent=self,
-- 
1.7.6



