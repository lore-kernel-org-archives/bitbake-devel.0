Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TF4iG-0004KZ-1d
	for bitbake-devel@lists.openembedded.org;
	Fri, 21 Sep 2012 17:00:16 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Sep 2012 07:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,463,1344236400"; d="scan'208";a="209599926"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.241])
	by orsmga002.jf.intel.com with ESMTP; 21 Sep 2012 07:47:31 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2012 15:47:25 +0100
Message-Id: <e2b5212da3d9bda16f843bdf38fbe6321fc68a85.1348238757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 3/4] hob: remove confirmation dialog on close
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
X-List-Received-Date: Fri, 21 Sep 2012 15:00:16 -0000

This is not necessary for modern applications - instead we just need to
check if we're in the middle of a build and if so, do the same thing as
pressing the "Stop" button.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 3e96a3b..ff49227 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1023,20 +1023,11 @@ class Builder(gtk.Window):
     def destroy_window_cb(self, widget, event):
         if not self.sensitive:
             return True
-        lbl = "<b>Do you really want to exit the Hob image creator?</b>"
-        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
-        HobAltButton.style_button(button)
-        button = dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
-        HobButton.style_button(button)
-        dialog.set_default_response(gtk.RESPONSE_YES)
-        response = dialog.run()
-        dialog.destroy()
-        if response == gtk.RESPONSE_YES:
-            gtk.main_quit()
-            return False
-        else:
+        elif self.handler.building:
+            self.stop_build()
             return True
+        else:
+            gtk.main_quit()
 
     def build_packages(self):
         _, all_recipes = self.recipe_model.get_selected_recipes()
-- 
1.7.9.5



