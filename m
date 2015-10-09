Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B1A2A766DD
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Oct 2015 09:32:52 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Oct 2015 02:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,657,1437462000"; d="scan'208";a="788373698"
Received: from sarallen-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.21])
	by orsmga001.jf.intel.com with ESMTP; 09 Oct 2015 02:32:53 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Oct 2015 10:32:41 +0100
Message-Id: <5e1ea87efad25f398c0c45ca89bb1b545579e0bc.1444383025.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
References: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444383025.git.elliot.smith@intel.com>
References: <cover.1444383025.git.elliot.smith@intel.com>
Subject: [PATCH 3/5] toaster: tables Add the recipe filter back into the Recipe table
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
X-List-Received-Date: Fri, 09 Oct 2015 09:32:52 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add the "Is recipe currently available in the project" filter back to
the Recipe table which was removed when we had intermediate
AvailableRecipe tables.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/tables.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index a676ffa..4f24772 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -335,10 +335,23 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
 
         return context
 
+    def setup_filters(self, *args, **kwargs):
+        self.add_filter(title="Filter by project recipes",
+                        name="in_current_project",
+                        filter_actions=[
+                            self.make_filter_action("in_project", "Recipes provided by layers added to this project", self.filter_in_project),
+                            self.make_filter_action("not_in_project", "Recipes provided by layers not added to this project", self.filter_not_in_project)
+                        ])
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
 
+        # Project layers used by the filters
+        self.project_layers = prj.get_project_layer_versions(pk=True)
+
+        # Project layers used to switch the button states
+        self.static_context_extra['current_layers'] = self.project_layers
+
         self.queryset = prj.get_all_compatible_recipes()
         self.queryset = self.queryset.order_by(self.default_orderby)
 
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


