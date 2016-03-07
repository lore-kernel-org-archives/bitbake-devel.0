Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 7DFF16FFD4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 12:03:39 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP; 07 Mar 2016 04:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,551,1449561600"; d="scan'208";a="665145850"
Received: from vivienne-mobl3.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.236])
	by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2016 04:03:38 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Mar 2016 12:03:34 +0000
Message-Id: <1457352214-30836-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH] toaster: change 'revision' to 'Git revision'
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
X-List-Received-Date: Mon, 07 Mar 2016 12:03:40 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

I've received some feedback on the 'Revision' label we use in the import
layer page. It is not quite communicating that what's required is a Git
revision. Changing it to 'Git revision' to make it a bit more specific.

The change applies not only to the import layer page, but to all pages
showing revision information in the project configuration section.

For more on the feedback received, check

https://bugzilla.yoctoproject.org/show_bug.cgi?id=8429#c3

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/tables.py                   | 6 +++---
 bitbake/lib/toaster/toastergui/templates/base.html         | 2 +-
 bitbake/lib/toaster/toastergui/templates/importlayer.html  | 2 +-
 bitbake/lib/toaster/toastergui/templates/layerdetails.html | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 71892e2..67a6592 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -158,7 +158,7 @@ class LayersTable(ToasterTable):
         {% endwith %}
         '''
 
-        self.add_column(title="Revision",
+        self.add_column(title="Git revision",
                         help_text="The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project",
                         static_data_name="revision",
                         static_data_template=revision_template)
@@ -269,7 +269,7 @@ class MachinesTable(ToasterTable):
                         static_data_template=layer_link_template,
                         orderable=True)
 
-        self.add_column(title="Revision",
+        self.add_column(title="Git revision",
                         help_text="The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project",
                         hidden=True,
                         field_name="layer_version__get_vcs_reference")
@@ -428,7 +428,7 @@ class RecipesTable(ToasterTable):
                         orderable=True,
                         field_name="license")
 
-        self.add_column(title="Revision",
+        self.add_column(title="Git revision",
                         hidden=True,
                         field_name="layer_version__get_vcs_reference")
 
diff --git a/bitbake/lib/toaster/toastergui/templates/base.html b/bitbake/lib/toaster/toastergui/templates/base.html
index 6994bcc..121a75c 100644
--- a/bitbake/lib/toaster/toastergui/templates/base.html
+++ b/bitbake/lib/toaster/toastergui/templates/base.html
@@ -77,7 +77,7 @@
           <span class="brand">
             <a href="/">Toaster</a>
             {% if DEBUG %}
-            <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
+            <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Git branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Git revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
             {% endif %}
           </span>
           {% if request.resolver_match.url_name != 'landing' and request.resolver_match.url_name != 'newproject' %}
diff --git a/bitbake/lib/toaster/toastergui/templates/importlayer.html b/bitbake/lib/toaster/toastergui/templates/importlayer.html
index 033f0ae..1848f41 100644
--- a/bitbake/lib/toaster/toastergui/templates/importlayer.html
+++ b/bitbake/lib/toaster/toastergui/templates/importlayer.html
@@ -89,7 +89,7 @@
                         <input type="text"  id="layer-subdir">
 
                           <div class="control-group" id="layer-revision-ctrl">
-                            <label class="control-label project-form" for="layer-git-ref">Revision
+                            <label class="control-label project-form" for="layer-git-ref">Git revision
                               <span class="icon-question-sign get-help" title="You can provide a Git branch, a tag or a commit SHA as the revision"></span>
                             </label>
                             <div class="controls">
diff --git a/bitbake/lib/toaster/toastergui/templates/layerdetails.html b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
index f960061..82be370 100644
--- a/bitbake/lib/toaster/toastergui/templates/layerdetails.html
+++ b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
@@ -154,7 +154,7 @@
             </dd>
             <dt>
               <i class="icon-question-sign get-help" title="The Git branch, tag or commit"></i>
-              Revision
+              Git revision
             </dt>
             <dd>
               <span class="current-value">{{layerversion.get_vcs_reference}}</span>
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


