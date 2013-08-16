Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 836EE60698
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2013 08:44:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 16 Aug 2013 01:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,893,1367996400"; d="scan'208";a="388084939"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga002.jf.intel.com with ESMTP; 16 Aug 2013 01:44:55 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2013 11:48:00 +0300
Message-Id: <1376642880-25878-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/retrieveimagedialog: change labels
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
X-List-Received-Date: Fri, 16 Aug 2013 08:44:56 -0000

Some labels needed to be changed in order to respect the convention.

[YOCTO #4999]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/retrieveimagedialog.py    |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
index 060b4fd..9017139 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
@@ -43,7 +43,9 @@ class RetrieveImageDialog (gtk.FileChooserDialog):
             vbox.get_children()[0].get_children()[0].get_children()[0].remove(child)
 
         label1 = gtk.Label()
-        label1.set_text("File system:  " + self.directory)
+        label1.set_text("File system" + self.directory)
         label1.show()
         vbox.get_children()[0].get_children()[0].get_children()[0].pack_start(label1, expand=False, fill=False, padding=0)
         vbox.get_children()[0].get_children()[1].get_children()[0].hide()
+
+        self.get_children()[0].get_children()[1].get_children()[0].set_label("Select")
-- 
1.7.9.5


