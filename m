Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A41F0731B9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Apr 2016 13:22:00 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Apr 2016 06:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,551,1455004800"; d="scan'208";a="965382995"
Received: from jdobrzan-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.9.231])
	by orsmga002.jf.intel.com with ESMTP; 29 Apr 2016 06:22:00 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 29 Apr 2016 14:21:55 +0100
Message-Id: <1461936115-6932-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH] toaster: tweaks to recipe file downloads
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
X-List-Received-Date: Fri, 29 Apr 2016 13:22:03 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

* In the custom images table, show the recipe file and download icon
only when the recipe file exists and can be downloaded.

* Also in the custom images table, make sure the download icon tooltip
shows on hover.

* In the custom image details page, show the correct icon (download)
next to the recipe file in the right hand column.

* In the custom image details page, show the recipe file and download
icon in the right hand column only when the recipe file exists and can
be downloaded

* Also in the custom image details page, simplify the help text we show
when the 'download' button is disabled: it gave so much information about
what's actually happening under the hood that it was a bit hard to
follow.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/tables.py                   | 7 ++-----
 bitbake/lib/toaster/toastergui/templates/customrecipe.html | 8 ++++----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index d375da4..eb876ec 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -507,12 +507,9 @@ class CustomImagesTable(ToasterTable):
                         static_data_template=name_link_template)
 
         recipe_file_template = '''
-        <code>{{data.name}}_{{data.version}}.bb</code>
         {% if data.get_base_recipe_file %}
-        <a href="{% url 'customrecipedownload' extra.pid data.pk %}">
-        <i class="icon-download-alt" data-original-title="Download recipe
-        file"></i>
-        </a>
+        <code>{{data.name}}_{{data.version}}.bb</code>
+        <a href="{% url 'customrecipedownload' extra.pid data.pk %}" class="icon-download-alt get-help" title="Download recipe file"></a>
         {% endif %}'''
 
         self.add_column(title="Recipe file",
diff --git a/bitbake/lib/toaster/toastergui/templates/customrecipe.html b/bitbake/lib/toaster/toastergui/templates/customrecipe.html
index aeb4466..4b1ef66 100644
--- a/bitbake/lib/toaster/toastergui/templates/customrecipe.html
+++ b/bitbake/lib/toaster/toastergui/templates/customrecipe.html
@@ -107,7 +107,7 @@
         Download recipe file
         {% if not base_recipe_file %}
         <i class="icon-question-sign get-help"
-          data-original-title="The {{recipe.name}} recipe cannot yet be downloaded as the Based on recipe '{{recipe.base_recipe.name}}' has not yet been fetched"></i>
+          data-original-title="The recipe file doesn't exist yet, so you cannot download it. You need to build your custom image first"></i>
         {% endif %}
       </a>
     </div>
@@ -182,13 +182,13 @@
         </dd>
         {% endwith %}
         {% endif %}
+        {% if base_recipe_file %}
         <dt>Recipe file</dt>
         <dd>
           <code>{{recipe.name}}_{{recipe.version}}.bb</code>
-          {% if base_recipe_path %}
-          <a href="{% url 'customrecipedownload' project.pk recipe.pk %}"><i class="icon-share" title="" data-original-title="View recipe file"></i></a>
-          {% endif %}
+          <a href="{% url 'customrecipedownload' project.pk recipe.pk %}"><i class="icon-download-alt" title="Download recipe file"></i></a>
         </dd>
+        {% endif %}
         <dt>Layer</dt>
         <dd><a href="{% url 'layerdetails' project.id recipe.layer_version.pk %}">{{recipe.layer_version.layer.name}}</a></dd>
         {% if recipe.summary %}
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


