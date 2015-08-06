Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id C9A3F766E7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:24:06 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 06 Aug 2015 09:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="743540498"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 06 Aug 2015 09:24:02 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 6AEBA6A4083;
	Thu,  6 Aug 2015 09:23:13 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:23:48 +0300
Message-Id: <742c64994a8ecb8b6c8de62bc67c14b46515fddc.1438877744.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <5d76198acb4ff2606733eecf82debb8b3221adba.1438877744.git.ed.bartosh@linux.intel.com>
References: <5d76198acb4ff2606733eecf82debb8b3221adba.1438877744.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438877744.git.ed.bartosh@linux.intel.com>
References: <cover.1438877744.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 3/4] bitbake: toastergui: Fix typo on layers in project filter condition
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
X-List-Received-Date: Thu, 06 Aug 2015 16:24:06 -0000

From: Michael Wood <michael.g.wood@intel.com>

Should be & rather than "and" which was returning the truth'd value of
the and condition.

[YOCTO #8114]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/tables.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 1187244..51fe4b6 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -312,7 +312,7 @@ class LayerMachinesTable(MachinesTable):
         MachinesTable.setup_queryset(self, *args, **kwargs)
 
         self.queryset = self.queryset.filter(layer_version__pk=int(kwargs['layerid']))
-        self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) and Q(layercommit=kwargs['layerid'])).count()
+        self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) & Q(layercommit=kwargs['layerid'])).count()
 
     def setup_columns(self, *args, **kwargs):
         self.add_column(title="Machine",
@@ -452,7 +452,7 @@ class LayerRecipesTable(RecipesTable):
         RecipesTable.setup_queryset(self, *args, **kwargs)
         self.queryset = self.queryset.filter(layer_version__pk=int(kwargs['layerid']))
 
-        self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) and Q(layercommit=kwargs['layerid'])).count()
+        self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) & Q(layercommit=kwargs['layerid'])).count()
 
     def setup_columns(self, *args, **kwargs):
         self.add_column(title="Recipe",
-- 
2.1.4


