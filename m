Return-Path: <elliot.smith@intel.com>
Received: from burlywood.birch.relay.mailchannels.net
	(burlywood.birch.relay.mailchannels.net [23.83.209.26])
	by mail.openembedded.org (Postfix) with ESMTP id A1D2F731B9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:42:44 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 75B70A249A;
	Mon, 22 Aug 2016 15:42:42 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-10-199.us-west-2.compute.internal [10.229.10.199])
	by relay.mailchannels.net (Postfix) with ESMTPA id B40ACA2739;
	Mon, 22 Aug 2016 15:42:41 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.45.13.172])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:42 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880562064:821329112
X-MC-Ingress-Time: 1471880562064
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrN2-0002ZA-FF; Mon, 22 Aug 2016 11:42:40 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:28 +0100
Message-Id: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
X-AuthUser: elliot@townx.org
Subject: [PATCH 1/9] toaster: add switch of git and not-git layers imported
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
X-List-Received-Date: Mon, 22 Aug 2016 15:42:45 -0000

From: Sujith H <sujith.h@gmail.com>

This patch updates the layerdetails html file to
add the feature of switching imported layers between
directories and git repositories.

[YOCTO #9913]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/toastergui/templates/layerdetails.html | 125 +++++++++++++++++----
 1 file changed, 101 insertions(+), 24 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/layerdetails.html b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
index 029c93b..3e13756 100644
--- a/bitbake/lib/toaster/toastergui/templates/layerdetails.html
+++ b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
@@ -84,11 +84,16 @@
     </script>
 
     <div class="page-header">
+      {% if layerversion.layer.local_source_dir %}
+      <h1>{{layerversion.layer.name}} <small class="commit" style="display:none;"></small>
+      </h1>
+      {% else %}
       <h1>{{layerversion.layer.name}} <small class="commit"
         {% if layerversion.get_vcs_reference|length > 13 %}
            data-toggle="tooltip" title="{{layerversion.get_vcs_reference}}"
         {% endif %}>({{layerversion.get_vcs_reference|truncatechars:13}})</small>
       </h1>
+      {% endif %}
     </div>
     <div class="row">
       <!-- container for tabs -->
@@ -97,6 +102,21 @@
           <button type="button" class="close" id="dismiss-alert">&times;</button>
           <span id="alert-msg"></span>
         </div>
+
+        <span class="button-place">
+        {% if layerversion.id not in projectlayers %}
+         <button id="add-remove-layer-btn" data-directive="add" class="btn btn-default btn-lg btn-block">
+           <span class="glyphicon glyphicon-plus"></span>
+           Add the {{layerversion.layer.name}} layer to your project
+         </button>
+         {% else %}
+         <button id="add-remove-layer-btn" data-directive="remove" class="btn btn-default btn-block btn-lg btn-danger">
+           <span class="glyphicon glyphicon-trash"></span>
+           Remove the {{layerversion.layer.name}} layer from your project
+         </button>
+         {% endif %}
+       </span>
+
         <ul class="nav nav-tabs">
           <li class="active">
             <a data-toggle="tab" href="#information" id="details-tab">Layer details</a>
@@ -109,23 +129,21 @@
           </li>
         </ul>
         <div class="tab-content">
-          <span class="button-place">
-            {% if layerversion.id not in projectlayers %}
-            <button id="add-remove-layer-btn" data-directive="add" class="btn btn-default btn-lg btn-block">
-              <span class="glyphicon glyphicon-plus"></span>
-              Add the {{layerversion.layer.name}} layer to your project
-            </button>
-            {% else %}
-            <button id="add-remove-layer-btn" data-directive="remove" class="btn btn-default btn-block btn-lg btn-danger">
-              <span class="glyphicon glyphicon-trash"></span>
-              Remove the {{layerversion.layer.name}} layer from your project
-            </button>
-            {% endif %}
-          </span>
 
           <!-- layer details pane -->
           <div id="information" class="tab-pane active">
-            <dl class="dl-horizontal">
+           {% if layerversion.layer.local_source_dir %}
+           <h3>Layer source code location</h3>
+           <dl class="dl-horizontal" id="directory-info">
+             <dt>
+               Path to the layer directory
+             </dt>
+             <dd>
+               <code>{{layerversion.layer.local_source_dir}}</code>
+             </dd>
+           </dl>
+           {% else %}
+            <dl class="dl-horizontal" id="git-repo-info">
               <dt class="">
               <span class="glyphicon glyphicon-question-sign get-help" title="Fetch/clone URL of the repository"></span>
               Repository URL
@@ -139,11 +157,9 @@
                 <div class="form-group">
                   <input type="text" class="form-control" value="{{layerversion.layer.vcs_url}}">
                 </div>
-                <button data-layer-prop="vcs_url" class="btn btn-default change-btn" type="button">Save</button>
-                <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
               </form>
-              <span class="glyphicon glyphicon-edit"></span>
               </dd>
+	      {% if layerversion.dirpath %}
               <dt>
               <span class="glyphicon glyphicon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></span>
               Repository subdirectory
@@ -158,12 +174,9 @@
                 <div class="form-group">
                   <input type="text" class="form-control" value="{{layerversion.dirpath}}">
                 </div>
-                <button data-layer-prop="dirpath" class="btn btn-default change-btn" type="button">Save</button>
-                <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
               </form>
-              <span id="change-subdir" class="glyphicon glyphicon-edit"></span>
-              <span class="glyphicon glyphicon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
               </dd>
+	      {% endif %}
               <dt>
               <span class="glyphicon glyphicon-question-sign get-help" title="The Git branch, tag or commit"></span>
               Git revision
@@ -174,11 +187,75 @@
                 <div class="form-group">
                   <input type="text" class="form-control" value="{{layerversion.get_vcs_reference}}">
                 </div>
-                <button  data-layer-prop="commit" class="btn btn-default change-btn" type="button">Save</button>
-                <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
               </form>
-              <span class="glyphicon glyphicon-edit"></i>
               </dd>
+            </dl>
+            {% endif %}
+            {% if layerversion.layer_source == layer_source.TYPE_IMPORTED %}
+            <button class="btn btn-default btn-lg" id="edit-layer-source" style="margin-left:220px;">Edit layer source code location</button>
+            {% endif %}
+           <form id="edit-layer-source-form" style="display:none;">
+             <fieldset>
+               <legend class="radioLegend">Where is the layer source code?</legend>
+               <div class="radio">
+                 <label>
+                   <input type="radio" name="source-location" id="repo" value="repo">
+                   In a <strong>Git repository</strong>
+                 </label>
+                 <p class="help-block" style="margin-left:20px;width:70%;">To build the layer Toaster must be able to access the Git repository, otherwise builds will fail. Toaster will\
+                   fetch and checkout your chosen Git revision every time you start a build.</p>
+               </div>
+               <div class="radio" style="margin-top:15px;">
+                 <label>
+                   <input type="radio" name="source-location" id="dir" value="dir" checked>
+                   In a <strong>directory</strong>
+                 </label>
+                 <p class="help-block" style="margin-left:20px;width:70%;">Use this option for quick layer development, by simply providing the path to the layer source code.</p>
+               </div>
+             </fieldset>
+
+             <fieldset id="layer-git">
+               <legend>Git repository information</legend>
+               <div class="form-group">
+                 <label for="layer-git-repo-url">
+                   Git repository URL
+                   <span class="glyphicon glyphicon-question-sign get-help" title="Fetch/clone URL of the repository. Currently, Toaster only supports Git repositories." ></span>
+                 </label>
+                 <input type="text" id="layer-git-repo-url" class="form-control">
+               </div>
+               <div class="form-group">
+                 <label for="layer-subdir">
+                   Repository subdirectory
+                   <span class="text-muted">(optional)</span>
+                   <span class="glyphicon glyphicon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></span>
+                 </label>
+                 <input type="text" class="form-control" id="layer-subdir">
+               </div>
+               <div class="form-group" id="layer-revision-ctrl">
+                 <label for="layer-git-ref">Git revision
+                   <span class="glyphicon glyphicon-question-sign get-help" title="You can provide a Git branch, a tag or a commit SHA as the revision"></span>
+                 </label>
+                 <input type="text" class="form-control" id="layer-git-ref">
+                 <span class="help-inline" style="display:none;" id="invalid-layer-revision-hint"></span>
+               </div>
+             </fieldset>
+
+             <fieldset id="layer-dir">
+               <legend>Layer directory information</legend>
+               <div class="form-group">
+                 <label for="layer-dir-path">
+                   Enter the absolute path to the layer directory
+                 </label>
+                 <input type="text" id="layer-dir-path-in-details" class="form-control" value="{{layerversion.layer.local_source_dir}}" required>
+               </div>
+             </fieldset>
+
+             <div style="margin-top:25px;">
+               <a href="#" class="btn btn-primary btn-lg" id="save-changes-for-switch">Save changes</a>
+               <a href="#" class="btn btn-link btn-lg" id="cancel-changes-for-switch">Cancel</a>
+             </div>
+           </form>
+
               <dt>
               <span class="glyphicon glyphicon-question-sign get-help" title="Other layers this layer depends upon"></span>
               Layer dependencies
-- 
2.7.4


