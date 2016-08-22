Return-Path: <elliot.smith@intel.com>
Received: from nov-007-i512.relay.mailchannels.net
	(nov-007-i512.relay.mailchannels.net [46.232.183.66])
	by mail.openembedded.org (Postfix) with ESMTP id 7A5F8731B9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:42:48 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 547D3120FD0;
	Mon, 22 Aug 2016 15:42:45 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-27-139-41.us-west-2.compute.internal [10.27.139.41])
	by relay.mailchannels.net (Postfix) with ESMTPA id 8E793120B25;
	Mon, 22 Aug 2016 15:42:44 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.45.13.172])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:45 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880564997:3541384632
X-MC-Ingress-Time: 1471880564997
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrN5-0002ZA-At; Mon, 22 Aug 2016 11:42:43 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:31 +0100
Message-Id: <1471880556-9232-4-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 4/9] toaster: layerdetails clean ups after integrating local layer changes
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
X-List-Received-Date: Mon, 22 Aug 2016 15:42:52 -0000

From: Michael Wood <michael.g.wood@intel.com>

A few clean ups for the work done to integrate editing imported local layers
into the layer detail page.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/api.py              |  6 +-
 .../lib/toaster/toastergui/static/css/default.css  |  2 +
 .../toaster/toastergui/static/js/layerdetails.js   | 86 ++++++++++------------
 .../toaster/toastergui/templates/layerdetails.html | 59 +++++++--------
 4 files changed, 72 insertions(+), 81 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/api.py b/bitbake/lib/toaster/toastergui/api.py
index 8dde128..09fb02b 100644
--- a/bitbake/lib/toaster/toastergui/api.py
+++ b/bitbake/lib/toaster/toastergui/api.py
@@ -135,7 +135,8 @@ class XhrLayer(View):
           Method: POST
 
           Args:
-              vcs_url, dirpath, commit, up_branch, summary, description, local_source_dir
+              vcs_url, dirpath, commit, up_branch, summary, description,
+              local_source_dir
 
               add_dep = append a layerversion_id as a dependency
               rm_dep = remove a layerversion_id as a depedency
@@ -167,7 +168,8 @@ class XhrLayer(View):
         if "description" in request.POST:
             layer_version.layer.description = request.POST["description"]
         if "local_source_dir" in request.POST:
-            layer_version.layer.local_source_dir = request.POST["local_source_dir"]
+            layer_version.layer.local_source_dir = \
+                request.POST["local_source_dir"]
 
         if "add_dep" in request.POST:
             lvd = LayerVersionDependency(
diff --git a/bitbake/lib/toaster/toastergui/static/css/default.css b/bitbake/lib/toaster/toastergui/static/css/default.css
index f71b37e..a56bb8c 100644
--- a/bitbake/lib/toaster/toastergui/static/css/default.css
+++ b/bitbake/lib/toaster/toastergui/static/css/default.css
@@ -316,6 +316,8 @@ h2.panel-title { font-size: 30px; }
 /* Make the help in tables insivisble until you hover over the right cell */
 .hover-help { visibility: hidden; }
 
+#add-remove-layer-btn { margin-bottom: 20px; }
+
 /* Blue hightlight animation for tasks and directory structure tables */
 .highlight { -webkit-animation: target-fade 15s 1; -moz-animation: target-fade 15s 1; animation: target-fade 15s 1; }
 @-webkit-keyframes target-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
diff --git a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
index 2ff8e59..5fd7274 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
@@ -11,11 +11,19 @@ function layerDetailsPageInit (ctx) {
   var machineTab = $("#machines-tab");
   var detailsTab = $("#details-tab");
   var editLayerSource = $("#edit-layer-source");
+  var saveSourceChangesBtn = $("#save-changes-for-switch");
+  var layerGitRefInput = $("#layer-git-ref");
+  var layerSubDirInput = $('#layer-subdir');
+
+  targetTab.on('show.bs.tab', targetsTabShow);
+  detailsTab.on('show.bs.tab', detailsTabShow);
+  machineTab.on('show.bs.tab', machinesTabShow);
 
   /* setup the dependencies typeahead */
-  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.layersTypeAheadUrl, { include_added: "true" }, function(item){
+  libtoaster.makeTypeahead(layerDepInput,
+                           libtoaster.ctx.layersTypeAheadUrl,
+                           { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
-
     layerDepBtn.removeAttr("disabled");
   });
 
@@ -26,20 +34,6 @@ function layerDetailsPageInit (ctx) {
     }
   });
 
-  $(window).on('hashchange', function(e){
-    switch(window.location.hash){
-      case '#machines':
-        machineTab.tab('show');
-        break;
-      case '#recipes':
-        targetTab.tab('show');
-        break;
-      default:
-        detailsTab.tab('show');
-        break;
-    }
-  });
-
   function addRemoveDep(depLayerId, add, doneCb) {
     var data = { layer_version_id : ctx.layerVersion.id };
     if (add)
@@ -151,6 +145,7 @@ function layerDetailsPageInit (ctx) {
     });
   });
 
+
   function defaultAddBtnText(){
       var text = " Add the "+ctx.layerVersion.name+" layer to your project";
       addRmLayerBtn.text(text);
@@ -158,12 +153,12 @@ function layerDetailsPageInit (ctx) {
       addRmLayerBtn.removeClass("btn-danger");
   }
 
-  detailsTab.on('show', function(){
+  function detailsTabShow(){
     if (!ctx.layerVersion.inCurrentPrj)
       defaultAddBtnText();
 
-    window.location.hash = "details";
-  });
+    window.location.hash = "information";
+  }
 
   function targetsTabShow(){
     if (!ctx.layerVersion.inCurrentPrj){
@@ -217,7 +212,6 @@ function layerDetailsPageInit (ctx) {
 
   });
 
-  targetTab.on('show.bs.tab', targetsTabShow);
 
   function machinesTabShow(){
     if (!ctx.layerVersion.inCurrentPrj) {
@@ -234,8 +228,6 @@ function layerDetailsPageInit (ctx) {
     window.location.hash = "machines";
   }
 
-  machineTab.on('show.bs.tab', machinesTabShow);
-
   $(".pagesize").change(function(){
     var search = libtoaster.parseUrlParams();
     search.limit = this.value;
@@ -425,9 +417,11 @@ function layerDetailsPageInit (ctx) {
   $(".commit").tooltip();
 
   editLayerSource.click(function() {
-    // Kindly bring the git layers imported from layerindex to normal page and not this new page :(
+    /* Kindly bring the git layers imported from layerindex to normal page
+     * and not this new page :(
+     */
     $(this).hide();
-    $("#save-changes-for-switch").attr("disabled", "disabled");
+    saveSourceChangesBtn.attr("disabled", "disabled");
 
     $("#git-repo-info", "#directory-info").hide();
     $("#edit-layer-source-form").fadeIn();
@@ -446,9 +440,9 @@ function layerDetailsPageInit (ctx) {
     if ($('input[name=source-location]:checked').val() == "repo") {
       $("#layer-git").fadeIn();
       $("#layer-dir").hide();
-	if ($("#layer-git-repo-url").val().length === 0 && $("#layer-git-ref").val().length === 0) {
-	    $("#save-changes-for-switch").attr("disabled", "disabled");
-	}
+      if ($("#layer-git-repo-url").val().length === 0 && layerGitRefInput.val().length === 0) {
+        saveSourceChangesBtn.attr("disabled", "disabled");
+      }
     } else {
       $("#layer-dir").fadeIn();
       $("#layer-git").hide();
@@ -456,42 +450,40 @@ function layerDetailsPageInit (ctx) {
   });
 
   $("#layer-dir-path-in-details").keyup(function() {
-    $("#save-changes-for-switch").removeAttr("disabled");
+    saveSourceChangesBtn.removeAttr("disabled");
   });
 
   $("#layer-git-repo-url").keyup(function() {
-    if ($("#layer-git-repo-url").val().length > 0 && $("#layer-git-ref").val().length > 0) {
-      $("#save-changes-for-switch").removeAttr("disabled");
+    if ($("#layer-git-repo-url").val().length > 0 && layerGitRefInput.val().length > 0) {
+      saveSourceChangesBtn.removeAttr("disabled");
     }
   });
 
-  $("#layer-git-ref").keyup(function() {
-    if ($("#layer-git-repo-url").val().length > 0 && $("#layer-git-ref").val().length > 0) {
-      $("#save-changes-for-switch").removeAttr("disabled");
+  layerGitRefInput.keyup(function() {
+    if ($("#layer-git-repo-url").val().length > 0 && layerGitRefInput.val().length > 0) {
+      saveSourceChangesBtn.removeAttr("disabled");
     }
   });
 
-  $('#cancel-changes-for-switch').click(function() {
-    editLayerSource.show();
-    $("#git-repo-info", "#directory-info").fadeIn();
-    $("#edit-layer-source-form").fadeOut();
 
-    if ($("#layer-dir-path-in-details").val().length) {
-      $("#dir").prop("checked", true);
-      $("#layer-git").fadeOut();
-      $("#layer-dir").fadeIn();
-    } else {
-      $("#layer-git").fadeIn();
-      $("#layer-dir").fadeOut();
+  layerSubDirInput.keyup(function(){
+    if ($(this).val().length > 0){
+      saveSourceChangesBtn.removeAttr("disabled");
     }
   });
 
-  $('#save-changes-for-switch').click(function() {
+  $('#cancel-changes-for-switch').click(function() {
+    $("#edit-layer-source-form").add("#layer-git").add("#layer-dir").fadeOut().promise().done(function(){
+      editLayerSource.show();
+    });
+  });
+
+  saveSourceChangesBtn.click(function() {
 
     var layerData = {
       vcs_url: $('#layer-git-repo-url').val(),
-      commit: $('#layer-git-ref').val(),
-      dirpath: $('#layer-subdir').val(),
+      commit: layerGitRefInput.val(),
+      dirpath: layerSubDirInput.val(),
       local_source_dir: $('#layer-dir-path-in-details').val(),
     };
 
diff --git a/bitbake/lib/toaster/toastergui/templates/layerdetails.html b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
index 3e13756..08e41ce 100644
--- a/bitbake/lib/toaster/toastergui/templates/layerdetails.html
+++ b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
@@ -103,7 +103,6 @@
           <span id="alert-msg"></span>
         </div>
 
-        <span class="button-place">
         {% if layerversion.id not in projectlayers %}
          <button id="add-remove-layer-btn" data-directive="add" class="btn btn-default btn-lg btn-block">
            <span class="glyphicon glyphicon-plus"></span>
@@ -115,7 +114,6 @@
            Remove the {{layerversion.layer.name}} layer from your project
          </button>
          {% endif %}
-       </span>
 
         <ul class="nav nav-tabs">
           <li class="active">
@@ -159,7 +157,7 @@
                 </div>
               </form>
               </dd>
-	      {% if layerversion.dirpath %}
+             {% if layerversion.dirpath %}
               <dt>
               <span class="glyphicon glyphicon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></span>
               Repository subdirectory
@@ -176,7 +174,7 @@
                 </div>
               </form>
               </dd>
-	      {% endif %}
+              {% endif %}
               <dt>
               <span class="glyphicon glyphicon-question-sign get-help" title="The Git branch, tag or commit"></span>
               Git revision
@@ -221,7 +219,7 @@
                    Git repository URL
                    <span class="glyphicon glyphicon-question-sign get-help" title="Fetch/clone URL of the repository. Currently, Toaster only supports Git repositories." ></span>
                  </label>
-                 <input type="text" id="layer-git-repo-url" class="form-control">
+                 <input type="text" id="layer-git-repo-url" class="form-control" value="{{layerversion.layer.vcs_url|default_if_none:''}}">
                </div>
                <div class="form-group">
                  <label for="layer-subdir">
@@ -229,13 +227,13 @@
                    <span class="text-muted">(optional)</span>
                    <span class="glyphicon glyphicon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></span>
                  </label>
-                 <input type="text" class="form-control" id="layer-subdir">
+                 <input type="text" class="form-control" id="layer-subdir" value="{{layerversion.dirpath|default_if_none:''}}">
                </div>
                <div class="form-group" id="layer-revision-ctrl">
                  <label for="layer-git-ref">Git revision
                    <span class="glyphicon glyphicon-question-sign get-help" title="You can provide a Git branch, a tag or a commit SHA as the revision"></span>
                  </label>
-                 <input type="text" class="form-control" id="layer-git-ref">
+                 <input type="text" class="form-control" id="layer-git-ref" value="{{layerversion.get_vcs_reference|default_if_none:''}}">
                  <span class="help-inline" style="display:none;" id="invalid-layer-revision-hint"></span>
                </div>
              </fieldset>
@@ -256,31 +254,28 @@
              </div>
            </form>
 
-              <dt>
-              <span class="glyphicon glyphicon-question-sign get-help" title="Other layers this layer depends upon"></span>
-              Layer dependencies
-              </dt>
-              <dd>
-              <ul class="list-unstyled current-value" id="layer-deps-list">
-                {% for ld in layerversion.dependencies.all %}
-                <li data-layer-id="{{ld.depends_on.id}}">
-                  <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.get_vcs_reference}}" href="{% url 'layerdetails' project.id ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
-                  <span class="glyphicon glyphicon-trash " data-toggle="tooltip" title="Delete"></span>
-                </li>
-                {% endfor %}
-              </ul>
-              <form class="form-inline add-deps">
-                <div class="form-group">
-                  <input class="form-control" type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"  placeholder="Type a layer name" id="layer-dep-input">
-                </div>
-                <a class="btn btn-default" id="add-layer-dependency-btn" disabled="disabled">
-                  Add layer
-                </a>
-                <span class="help-block add-deps">You can only add layers Toaster knows about</span>
-              </form>
-              </dd>
-            </dl>
-          </div>
+           <h3 class="top-air">Layer dependencies
+             <span class="glyphicon glyphicon-question-sign get-help" title="Other layers this layer depends upon"></span>
+           </h3>
+
+           <ul class="list-unstyled current-value" id="layer-deps-list">
+             {% for ld in layerversion.dependencies.all %}
+             <li data-layer-id="{{ld.depends_on.id}}">
+             <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.get_vcs_reference}}" href="{% url 'layerdetails' project.id ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
+             <span class="glyphicon glyphicon-trash " data-toggle="tooltip" title="Delete"></span>
+             </li>
+             {% endfor %}
+           </ul>
+           <form class="form-inline add-deps">
+             <div class="form-group">
+               <input class="form-control" type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"  placeholder="Type a layer name" id="layer-dep-input">
+             </div>
+             <a class="btn btn-default" id="add-layer-dependency-btn" disabled="disabled">
+               Add layer
+             </a>
+             <span class="help-block add-deps">You can only add layers Toaster knows about</span>
+           </form>
+         </div>
           <!-- end layerdetails tab -->
           <!-- targets tab -->
           <div id="recipes" class="tab-pane">
-- 
2.7.4


