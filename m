Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TEjB3-0003ue-4y
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Sep 2012 18:00:33 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 20 Sep 2012 08:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,454,1344236400"; d="scan'208";a="195074993"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.248])
	by azsmga001.ch.intel.com with ESMTP; 20 Sep 2012 08:47:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Sep 2012 16:47:37 +0100
Message-Id: <ec7f43d0fa2b9d3e276c196b4ab9e11935b315af.1348155869.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1348155869.git.paul.eggleton@linux.intel.com>
References: <cover.1348155869.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1348155869.git.paul.eggleton@linux.intel.com>
References: <cover.1348155869.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] hob: remove confirmation dialog on close
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
X-List-Received-Date: Thu, 20 Sep 2012 16:00:33 -0000

This is not necessary for modern applications.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 9e9d040..3dcb795 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1021,20 +1021,7 @@ class Builder(gtk.Window):
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
-            return True
+        gtk.main_quit()
 
     def build_packages(self):
         _, all_recipes = self.recipe_model.get_selected_recipes()
-- 
1.7.9.5



