Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qze0Z-0008Rw-BD
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Sep 2011 02:22:51 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Sep 2011 17:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,321,1312182000"; d="scan'208";a="47755010"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.9])
	by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2011 17:17:50 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Sep 2011 17:17:41 -0700
Message-Id: <fc08d8802c0d41f7f146deb2a1025414dfc02a9c.1315008498.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
Subject: [PATCH 6/6] hob: disable removal of packages
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
X-List-Received-Date: Sat, 03 Sep 2011 00:22:51 -0000

It's felt that the stability of package deselection is not sufficient for
the upcoming release and thus package removal should be disabled.

I'd actually like to see this patch, or its effects, reverted as soon as
the release bits have been frozen so that this issue can continue to be
worked on.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   42 ++++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 3b0cacc..76b03cd 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -544,14 +544,17 @@ class MainWindow (gtk.Window):
         """
         # Whether the item is currently included
         inc = self.model[opath][self.model.COL_INC]
+        # FIXME: due to inpredictability of the removal of packages we are
+        # temporarily disabling this feature
         # If the item is already included, mark it for removal then
         # the sweep_up() method finds affected items and marks them
         # appropriately
-        if inc:
-            self.model.mark(opath)
-            self.model.sweep_up()
-        # If the item isn't included, mark it for inclusion
-        else:
+        # if inc:
+        #     self.model.mark(opath)
+        #     self.model.sweep_up()
+        # # If the item isn't included, mark it for inclusion
+        # else:
+        if not inc:
             self.model.include_item(item_path=opath,
                                     binb="User Selected",
                                     image_contents=image)
@@ -563,19 +566,22 @@ class MainWindow (gtk.Window):
         inc = model[path][self.model.COL_INC]
         # Warn user before removing included packages
         if inc:
-            pn = model[path][self.model.COL_NAME]
-            revdeps = self.model.find_reverse_depends(pn)
-            if len(revdeps):
-                lbl = "<b>Remove %s?</b>\n\nThis action cannot be undone and all packages which depend on this will be removed\nPackages which depend on %s include %s." % (pn, pn, ", ".join(revdeps).rstrip(","))
-            else:
-                lbl = "<b>Remove %s?</b>\n\nThis action cannot be undone." % pn
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
-            dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
-            dialog.add_button("Remove", gtk.RESPONSE_OK)
-            response = dialog.run()
-            dialog.destroy()
-            if response == gtk.RESPONSE_CANCEL:
-                return
+            # FIXME: due to inpredictability of the removal of packages we are
+            # temporarily disabling this feature
+            return
+            # pn = model[path][self.model.COL_NAME]
+            # revdeps = self.model.find_reverse_depends(pn)
+            # if len(revdeps):
+            #     lbl = "<b>Remove %s?</b>\n\nThis action cannot be undone and all packages which depend on this will be removed\nPackages which depend on %s include %s." % (pn, pn, ", ".join(revdeps).rstrip(","))
+            # else:
+            #     lbl = "<b>Remove %s?</b>\n\nThis action cannot be undone." % pn
+            # dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            # dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
+            # dialog.add_button("Remove", gtk.RESPONSE_OK)
+            # response = dialog.run()
+            # dialog.destroy()
+            # if response == gtk.RESPONSE_CANCEL:
+            #     return
 
         self.set_busy_cursor()
         # Convert path to path in original model
-- 
1.7.6



