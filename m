Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5ECE1601D4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 16:44:40 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2015 08:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,347,1444719600"; d="scan'208";a="860355458"
Received: from snwijaya-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.69])
	by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2015 08:44:39 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2015 16:44:31 +0000
Message-Id: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1448556172.git.elliot.smith@intel.com>
References: <cover.1448556172.git.elliot.smith@intel.com>
Subject: [PATCH 1/5] toaster: machines table Fix missing layers information needed for filter
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
X-List-Received-Date: Thu, 26 Nov 2015 16:44:40 -0000

From: Michael Wood <michael.g.wood@intel.com>

The current layers information wasn't being passed to the template for
the Select/Add button for the Compatible machines filter.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/tables.py                  |  6 ++++--
 lib/toaster/toastergui/templates/machine_btn.html | 12 ++++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 9c9cda4..be8916c 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -217,12 +217,10 @@ class MachinesTable(ToasterTable, ProjectFiltersMixin):
     def get_context_data(self, **kwargs):
         context = super(MachinesTable, self).get_context_data(**kwargs)
         context['project'] = Project.objects.get(pk=kwargs['pid'])
-        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
         return context
 
     def setup_filters(self, *args, **kwargs):
         project = Project.objects.get(pk=kwargs['pid'])
-        self.project_layers = project.get_project_layer_versions()
 
         self.add_filter(title="Filter by project machines",
                         name="in_current_project",
@@ -236,6 +234,10 @@ class MachinesTable(ToasterTable, ProjectFiltersMixin):
         self.queryset = prj.get_all_compatible_machines()
         self.queryset = self.queryset.order_by(self.default_orderby)
 
+        self.static_context_extra['current_layers'] = \
+                self.project_layers = \
+                prj.get_project_layer_versions(pk=True)
+
     def setup_columns(self, *args, **kwargs):
 
         self.add_column(title="Machine",
diff --git a/lib/toaster/toastergui/templates/machine_btn.html b/lib/toaster/toastergui/templates/machine_btn.html
index d2cb55b..7b08f6a9a6 100644
--- a/lib/toaster/toastergui/templates/machine_btn.html
+++ b/lib/toaster/toastergui/templates/machine_btn.html
@@ -1,6 +1,14 @@
-<a href="{% url 'project' extra.pid %}?setMachine={{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.id}}" style="margin-top: 5px; display:none">
+<a href="{% url 'project' extra.pid %}?setMachine={{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.id}}"
+    {% if data.layer_version.pk not in extra.current_layers %}
+    style="display:none;"
+    {% endif %}
+>
   Select machine</a>
-<button class="btn btn-block layerbtn layer-add-{{data.layer_version.id}}" data-layer='{ "id": {{data.layer_version.id}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %}"}' data-directive="add">
+<button class="btn btn-block layerbtn layer-add-{{data.layer_version.id}}" data-layer='{ "id": {{data.layer_version.id}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %}"}' data-directive="add"
+    {% if data.layer_version.pk in extra.current_layers %}
+    style="display:none;"
+    {% endif %}
+>
   <i class="icon-plus"></i>
   Add layer
   <i title="" class="icon-question-sign get-help" data-original-title="To enable this machine, you must first add the {{data.layer_version.layer.name}} layer to your project"></i>
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


