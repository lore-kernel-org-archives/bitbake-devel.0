Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id EF1D27646B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:46:48 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 04 Aug 2015 12:46:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,611,1432623600"; d="scan'208";a="776778855"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2015 12:46:48 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id DC1D46A4083;
	Tue,  4 Aug 2015 12:46:01 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:31 +0300
Message-Id: <fdb965fbbcaa68b5b7a8cbb264cf9fb75cd188b5.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 03/12] bitbake: toastergui: tables Use util functions for the common querysets
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
X-List-Received-Date: Tue, 04 Aug 2015 19:46:49 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use the new utils functions on the project object to get the common querysets
that we also use in tables.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tables.py | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 8d5166be..e4cbec1 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -251,9 +251,8 @@ class MachinesTable(ToasterTable, ProjectFiltersMixin):
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
-        compatible_layers = prj.compatible_layerversions()
-
-        self.queryset = Machine.objects.filter(layer_version__in=compatible_layers).order_by(self.default_orderby)
+        self.queryset = prj.get_all_compatible_machines()
+        self.queryset = self.queryset.order_by(self.default_orderby)
 
     def setup_columns(self, *args, **kwargs):
 
@@ -363,11 +362,7 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
 
-        self.queryset = Recipe.objects.filter(layer_version__in = prj.compatible_layerversions())
-
-        search_maxids = map(lambda i: i[0], list(self.queryset.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
-
-        self.queryset = self.queryset.filter(id__in=search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
+        self.queryset = prj.get_all_compatible_recipes()
         self.queryset = self.queryset.order_by(self.default_orderby)
 
 
-- 
2.1.4


