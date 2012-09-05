Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1T9AZR-0008In-Jn
	for bitbake-devel@lists.openembedded.org;
	Wed, 05 Sep 2012 10:02:45 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 05 Sep 2012 00:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,372,1344236400"; d="scan'208";a="188971226"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 05 Sep 2012 00:50:20 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Sep 2012 10:50:33 +0300
Message-Id: <1346831433-30061-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: The 'run image' and 'deploy image' dialogs text and alignment corrections
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
X-List-Received-Date: Wed, 05 Sep 2012 08:02:45 -0000

-changed the text shown by both dialogs text
-make small tweaks to alignment

[YOCTO #2999]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 40eb7a4..f4d142a 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -389,7 +389,13 @@ class ImageDetailsPage (HobPage):
         label = gtk.Label()
         label.set_use_markup(True)
         label.set_alignment(0.0, 0.5)
-        label.set_markup("<span font_desc='12'>Select the image file you want to %s</span>" % primary_action)
+        label.set_padding(12,0)
+        if primary_action == "Run image":
+            label.set_markup("<span font_desc='12'>Select the image file you want to run:</span>")
+        elif primary_action == "Deploy image":
+            label.set_markup("<span font_desc='12'>Select the image file you want to deploy:</span>")
+        else:
+            label.set_markup("<span font_desc='12'>Select the image file you want to %s</span>" % primary_action)
         dialog.vbox.pack_start(label, expand=False, fill=False)
 
         # filter created images as action attribution (deploy or run)
@@ -418,12 +424,12 @@ class ImageDetailsPage (HobPage):
             sel_btn.set_active(fileitem['is_toggled'])
             sel_btn.connect('toggled', self.table_selected_cb, fileitem)
             if curr_row < 10:
-                table.attach(sel_btn, 2, 5, curr_row, curr_row + 1)
+                table.attach(sel_btn, 0, 4, curr_row, curr_row + 1, xpadding=24)
             else:
-                table.attach(sel_btn, 7, 10, curr_row - 10, curr_row - 9)
+                table.attach(sel_btn, 5, 9, curr_row - 10, curr_row - 9, xpadding=24)
             curr_row += 1
 
-        dialog.vbox.pack_start(table, expand=False, fill=False, padding = 6)
+        dialog.vbox.pack_start(table, expand=False, fill=False, padding=6)
 
         button = dialog.add_button("Cancel", gtk.RESPONSE_CANCEL)
         HobAltButton.style_button(button)
-- 
1.7.9.5



