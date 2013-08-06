Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1B61A621B1
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Aug 2013 11:13:28 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 06 Aug 2013 04:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,825,1367996400"; d="scan'208";a="358312281"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.203])
	by orsmga001.jf.intel.com with ESMTP; 06 Aug 2013 04:13:14 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Aug 2013 12:13:10 +0100
Message-Id: <59c6e523f10e24e0b6d2a230493b6f292215f38b.1375787400.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1375787400.git.paul.eggleton@linux.intel.com>
References: <cover.1375787400.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1375787400.git.paul.eggleton@linux.intel.com>
References: <cover.1375787400.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 10/21] hob: the saved image should be editable
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
X-List-Received-Date: Tue, 06 Aug 2013 11:13:28 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

Also, the image can be saved when the a name is filled.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index a20afcd..644a4a4 100644
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
1.8.1.2


