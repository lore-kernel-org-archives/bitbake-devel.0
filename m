Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4943470149
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Apr 2016 16:18:20 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 26 Apr 2016 09:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,537,1455004800"; 
	d="scan'208,217";a="963133155"
Received: from mkamins1-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.29.92])
	by orsmga002.jf.intel.com with ESMTP; 26 Apr 2016 09:18:19 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Apr 2016 17:18:07 +0100
Message-Id: <1461687487-31757-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1461687487-31757-1-git-send-email-elliot.smith@intel.com>
References: <1461687487-31757-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 2/2] toaster: customrecipe Only show download icon or button if it's possible
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
X-List-Received-Date: Tue, 26 Apr 2016 16:18:21 -0000

From: Michael Wood <michael.g.wood@intel.com>

If the based on recipe has not yet been checked out/cloned we cannot
generate the custom image recipe file that uses it. So disable/remove
the option to download it.

[YOCTO #9425]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/tables.py                   |  4 +++-
 bitbake/lib/toaster/toastergui/templates/customrecipe.html | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 2cc2f4e..d375da4 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -508,10 +508,12 @@ class CustomImagesTable(ToasterTable):
 
         recipe_file_template = '''
         <code>{{data.name}}_{{data.version}}.bb</code>
+        {% if data.get_base_recipe_file %}
         <a href="{% url 'customrecipedownload' extra.pid data.pk %}">
         <i class="icon-download-alt" data-original-title="Download recipe
         file"></i>
-        </a>'''
+        </a>
+        {% endif %}'''
 
         self.add_column(title="Recipe file",
                         static_data_name='recipe_file_download',
diff --git a/bitbake/lib/toaster/toastergui/templates/customrecipe.html b/bitbake/lib/toaster/toastergui/templates/customrecipe.html
index ea3c9c7..aeb4466 100644
--- a/bitbake/lib/toaster/toastergui/templates/customrecipe.html
+++ b/bitbake/lib/toaster/toastergui/templates/customrecipe.html
@@ -4,6 +4,7 @@
 {% load static %}
 {% block pagecontent %}
 
+{% with recipe.get_base_recipe_file as base_recipe_file %}
 <div class="section">
   <ul class="breadcrumb">
     <li>
@@ -99,8 +100,15 @@
       <a class="btn btn-large span6 build-custom-image" href="#" style="width: 50%">
         Build {{recipe.name}}
       </a>
-      <a href="{% url 'customrecipedownload' project.id recipe.id %}" class="btn btn-large span6" style="width: 50%">
+      <a href="{% url 'customrecipedownload' project.id recipe.id %}" class="btn btn-large span6" style="width: 50%"
+        {% if not base_recipe_file %}
+        disabled="disabled"
+        {% endif %}>
         Download recipe file
+        {% if not base_recipe_file %}
+        <i class="icon-question-sign get-help"
+          data-original-title="The {{recipe.name}} recipe cannot yet be downloaded as the Based on recipe '{{recipe.base_recipe.name}}' has not yet been fetched"></i>
+        {% endif %}
       </a>
     </div>
     <div id="no-results-special-{{table_name}}" class="air" style="display:none;">
@@ -177,7 +185,9 @@
         <dt>Recipe file</dt>
         <dd>
           <code>{{recipe.name}}_{{recipe.version}}.bb</code>
+          {% if base_recipe_path %}
           <a href="{% url 'customrecipedownload' project.pk recipe.pk %}"><i class="icon-share" title="" data-original-title="View recipe file"></i></a>
+          {% endif %}
         </dd>
         <dt>Layer</dt>
         <dd><a href="{% url 'layerdetails' project.id recipe.layer_version.pk %}">{{recipe.layer_version.layer.name}}</a></dd>
@@ -220,4 +230,5 @@
     </div>
   </div>
 
+{% endwith %}{# end base_recipe_file #}
   {% endblock %}
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


