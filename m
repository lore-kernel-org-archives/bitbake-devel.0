Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kEE-0005In-5C
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:10:02 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 29 Feb 2012 06:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130967053"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 29 Feb 2012 06:01:32 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:07 +0800
Message-Id: <36bbfae6e2a84015b39e4a7fa4ed6e0aff5036c0.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 10/32] Hob: add ignore_all_errors to avoid showing error dialog multiple times
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
X-List-Received-Date: Wed, 29 Feb 2012 14:10:02 -0000

when parsing recipes, if there are some errors, the error dialog will be shown again and again for each error, add "Ignore All" to allow users to ignore those errors.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 819b79f..fc231ef 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -178,6 +178,8 @@ class Builder(gtk.Window):
 
         self.template = None
 
+        self.ignore_all_errors = False
+
         # settings
         params = self.handler.get_parameters()
         self.configuration = Configuration(params)
@@ -315,6 +317,8 @@ class Builder(gtk.Window):
 
         elif next_step == self.RCPPKGINFO_POPULATING:
             # MACHINE CHANGED action or SETTINGS CHANGED
+            # reset the "ignore all errors" var
+            self.ignore_all_errors = False
             # show the progress bar
             self.image_configuration_page.show_info_populating()
             self.generate_recipes()
@@ -440,12 +444,16 @@ class Builder(gtk.Window):
                 self.switch_page(self.IMAGE_GENERATED)
 
     def handler_command_failed_cb(self, handler, msg):
-        lbl = "<b>Error</b>\n"
-        lbl = lbl + "%s\n\n" % msg
-        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
-        dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
-        response = dialog.run()
-        dialog.destroy()
+        if self.ignore_all_errors == False:
+            lbl = "<b>Error</b>\n"
+            lbl = lbl + "%s\n\n" % msg
+            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            dialog.add_button("Ignore All", gtk.RESPONSE_REJECT)
+            response = dialog.run()
+            if response == gtk.RESPONSE_REJECT:
+                self.ignore_all_errors = True
+            dialog.destroy()
         self.handler.clear_busy()
         self.configuration.curr_mach = None
         self.image_configuration_page.switch_machine_combo()
-- 
1.7.6



