Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 0B676767FB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Oct 2015 13:31:54 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 06 Oct 2015 06:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,644,1437462000"; d="scan'208";a="820553377"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2015 06:31:53 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Oct 2015 14:31:50 +0100
Message-Id: <1444138310-5219-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Set default columns in recipes tables
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
X-List-Received-Date: Tue, 06 Oct 2015 13:31:56 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The compatible image recipes and software recipes tables
show pretty much all their columns by default. That's a few
too many columns. The default columns in both tables should
be: recipe, version, description, layer and build.

This patch sets the above as the default columns. It also
changes the table heading 'Recipe Version' to just 'Version',
which is shorter and self-explanatory.

[YOCTO #8421]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/tables.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 5cc04a2..a676ffa 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -345,8 +345,8 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
 
     def setup_columns(self, *args, **kwargs):
 
-        self.add_column(title="Recipe Version",
-                        hidden=True,
+        self.add_column(title="Version",
+                        hidden=False,
                         field_name="version")
 
         self.add_column(title="Description",
@@ -367,6 +367,7 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
 
         self.add_column(title="Section",
                         help_text="The section in which recipes should be categorized",
+                        hidden=True,
                         orderable=True,
                         field_name="section")
 
@@ -383,10 +384,12 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
 
         self.add_column(title="License",
                         help_text="The list of source licenses for the recipe. Multiple license names separated by the pipe character indicates a choice between licenses. Multiple license names separated by the ampersand character indicates multiple licenses exist that cover different parts of the source",
+                        hidden=True,
                         orderable=True,
                         field_name="license")
 
         self.add_column(title="Revision",
+                        hidden=True,
                         field_name="layer_version__get_vcs_reference")
 
 
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


