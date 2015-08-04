Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id D4CCB73231
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:46:46 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 04 Aug 2015 12:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,611,1432623600"; d="scan'208";a="761912938"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2015 12:46:47 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 591CD6A4083;
	Tue,  4 Aug 2015 12:46:00 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:30 +0300
Message-Id: <3af50d06b1f56cc8d64bc69bb26de075bd388dd5.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 02/12] bitbake: toaster: orm Add util functions to return common querysets
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
X-List-Received-Date: Tue, 04 Aug 2015 19:46:47 -0000

From: Michael Wood <michael.g.wood@intel.com>

We use these querysets when creating tables of results and also when we
want to have a typeahead search. These can also form the basis of future
API endpoints.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/orm/models.py | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3b72f80..4f07e37 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -20,7 +20,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.db import models
-from django.db.models import F, Q, Avg
+from django.db.models import F, Q, Avg, Max
 from django.utils import timezone
 
 from django.core.urlresolvers import reverse
@@ -195,6 +195,45 @@ class Project(models.Model):
     def projectlayer_equivalent_set(self):
         return self.compatible_layerversions().filter(layer__name__in = [x.layercommit.layer.name for x in self.projectlayer_set.all()]).select_related("up_branch")
 
+    def get_available_machines(self):
+        """ Returns QuerySet of all Machines which are provided by the
+        Layers currently added to the Project """
+        queryset = Machine.objects.filter(layer_version__in=self.projectlayer_equivalent_set)
+        return queryset
+
+    def get_all_compatible_machines(self):
+        """ Returns QuerySet of all the compatible machines available to the
+        project including ones from Layers not currently added """
+        compatible_layers = self.compatible_layerversions()
+
+        queryset = Machine.objects.filter(layer_version__in=compatible_layers)
+        return queryset
+
+    def get_available_recipes(self):
+        """ Returns QuerySet of all Recipes which are provided by the Layers
+        currently added to the Project """
+        project_layers = self.projectlayer_equivalent_set()
+        queryset = Recipe.objects.filter(layer_version__in = project_layers)
+
+        # Copied from get_all_compatible_recipes
+        search_maxids = map(lambda i: i[0], list(queryset.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
+        queryset = queryset.filter(id__in=search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
+        # End copy
+
+        return queryset
+
+    def get_all_compatible_recipes(self):
+        """ Returns QuerySet of all the compatible Recipes available to the
+        project including ones from Layers not currently added """
+        compatible_layerversions = self.compatible_layerversions()
+        queryset = Recipe.objects.filter(layer_version__in = compatible_layerversions)
+
+        search_maxids = map(lambda i: i[0], list(queryset.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
+
+        queryset = queryset.filter(id__in=search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
+        return queryset
+
+
     def schedule_build(self):
         from bldcontrol.models import BuildRequest, BRTarget, BRLayer, BRVariable, BRBitbake
         br = BuildRequest.objects.create(project = self)
-- 
2.1.4


