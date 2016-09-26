Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id C2ABA60807
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:32 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga104.fm.intel.com with ESMTP; 26 Sep 2016 04:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="13747610"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga004.jf.intel.com with ESMTP; 26 Sep 2016 04:00:33 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id E78616A4082
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 04:00:06 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:37 +0300
Message-Id: <71c4ec55fffe7d59774e48d711b5eb1f89d4f232.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 10/10] toaster: layerdetails Update implementation of delete imported layer
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:34 -0000

From: Michael Wood <michael.g.wood@intel.com>

Update the implementation of delete an imported layer so that it is
consistent with the other delete messages and wording. Also use the new
libtoaster way of setting a notification that the delete was successful.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/api.py                      | 2 +-
 lib/toaster/toastergui/static/js/layerdetails.js   | 7 +++++--
 lib/toaster/toastergui/templates/layerdetails.html | 9 ++++++---
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 149abf7..3a05d66 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -221,7 +221,7 @@ class XhrLayer(View):
 
         return JsonResponse({
             "error": "ok",
-            "redirect": reverse('project', args=(kwargs['pid'],))
+            "gotoUrl": reverse('project', args=(kwargs['pid'],))
         })
 
 
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 8165bad..4c0d042 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -391,7 +391,9 @@ function layerDetailsPageInit (ctx) {
   });
 
   $("#layer-delete-confirmed").click(function(){
-    $.cookie("layer-deleted", ctx.layerVersion.name, { path: '/'});
+
+    var message = $('<span>You have deleted <strong>1</strong> layer from your project: <strong id="deleted-layer-name"></strong>');
+    message.find("#deleted-layer-name").text(ctx.layerVersion.name);
 
     $.ajax({
         type: "DELETE",
@@ -401,7 +403,8 @@ function layerDetailsPageInit (ctx) {
           if (data.error != "ok") {
             console.warn(data.error);
           } else {
-            window.location = data.redirect + "?notify=layer-deleted";
+            libtoaster.setNotification("layer-deleted", message.html());
+            window.location.replace(data.gotoUrl);
           }
         },
         error: function(data) {
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 0594b55..f1569bd 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -6,14 +6,16 @@
 {% block title %} {{layerversion.layer.name}} - {{project.name}} - Toaster {% endblock %}
 {% block pagecontent %}
 
-<div id="delete-layer-modal" class="modal fade" tabindex="-1" role="dialog">
+<div id="delete-layer-modal" class="modal fade" tabindex="-1" role="dialog"
+    data-keyboard="false" data-backdrop="static">
   <div class="modal-dialog" role="document">
     <div class="modal-content">
       <div class="modal-body">
 		  Are you sure you want to delete the <strong>{{layerversion.layer.name}}</strong> layer?
       </div>
       <div class="modal-footer">
-        <button type="button" id="layer-delete-confirmed" class="btn btn-primary">Delete</button>
+        <button type="button" id="layer-delete-confirmed" class="btn
+            btn-primary">Delete layer</button>
         <button type="button" class="btn btn-default btn-link" data-dismiss="modal">Cancel</button>
       </div>
     </div>
@@ -358,7 +360,8 @@
           {# Only show delete link for imported layers #}
           {% if layerversion.layer_source == layer_source.TYPE_IMPORTED %}
           <i class="icon-trash text-danger"></i>
-          <a href="#delete-layer-modal"  role="button" class="text-danger" data-toggle="modal" data-target="#delete-layer-modal">Delete {{layerversion.layer.name}}</a>
+          <a href="#delete-layer-modal"  role="button" class="text-danger"
+              data-toggle="modal" data-target="#delete-layer-modal">Delete layer</a>
           {% endif %}
         </div>
       </div>
-- 
2.6.6


