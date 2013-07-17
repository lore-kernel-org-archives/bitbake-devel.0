Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B135E6B10E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2013 10:33:43 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 17 Jul 2013 03:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,683,1367996400"; d="scan'208";a="366549967"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2013 03:33:43 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Jul 2013 13:35:38 +0300
Message-Id: <1374057344-19708-9-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 08/14] hob: the saved image should be editable
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 17 Jul 2013 10:33:43 -0000

Also, the image can be saved when the a name is filled.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index 6ebbca6..f8bf39f 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -99,7 +99,8 @@ class SaveImageDialog (CrumbsDialog):
         self.save_button.set_label("Save")
         self.save_button.connect("clicked", self.save_button_cb)
         self.save_button.set_size_request(110, 30)
-        self.save_button.set_sensitive(False)
+        if self.name_entry.get_text() == '':
+            self.save_button.set_sensitive(False)
 
         table.attach(cancel_button, 2, 3, 0, 1)
         table.attach(self.save_button, 3, 4, 0, 1)
@@ -124,6 +125,7 @@ class SaveImageDialog (CrumbsDialog):
         description = description_buffer.get_text(description_buffer.get_start_iter(),description_buffer.get_end_iter())
         if new_text.islower() and new_text.isalnum():
             self.builder.image_details_page.image_saved = True
+            self.builder.customized = False
             self.builder.generate_new_image(self.directory+text, description)
             self.builder.recipe_model.set_in_list(text, description)
             self.builder.recipe_model.set_selected_image(text)
-- 
1.7.9.5


