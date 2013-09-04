Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 8DF786BD57
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Sep 2013 08:21:00 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Sep 2013 01:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,1019,1367996400"; d="scan'208";a="397973102"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga002.jf.intel.com with ESMTP; 04 Sep 2013 01:21:00 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Sep 2013 11:24:35 +0300
Message-Id: <1378283075-18080-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: limit the description size when a custom image is saved
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
X-List-Received-Date: Wed, 04 Sep 2013 08:21:00 -0000

[YOCTO #5003]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index 56c00bb..42a4f5b 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -70,7 +70,9 @@ class SaveImageDialog (CrumbsDialog):
         sub_label.set_alignment(0, 0)
         sub_label.set_markup("The description should be less than 150 characters long.")
         self.description_entry = gtk.TextView()
-        self.description_entry.get_buffer().set_text(self.description_field)
+        description_buffer = self.description_entry.get_buffer()
+        description_buffer.set_text(self.description_field)
+        description_buffer.connect("insert-text", self.limit_description_length)
         self.description_entry.set_wrap_mode(gtk.WRAP_WORD)
         self.description_entry.set_size_request(350,150)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -108,6 +110,13 @@ class SaveImageDialog (CrumbsDialog):
 
         self.show_all()
 
+    def limit_description_length(self, textbuffer, iter, text, length):
+        buffer_bounds = textbuffer.get_bounds()
+        entire_text = textbuffer.get_text(*buffer_bounds)
+        entire_text += text
+        if len(entire_text)>150:
+            textbuffer.emit_stop_by_name("insert-text")
+
     def name_entry_changed(self, entry):
         text = entry.get_text()
         if text == '':
-- 
1.7.9.5


