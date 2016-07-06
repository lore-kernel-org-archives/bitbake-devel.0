Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id 31CC260119
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 17:31:55 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 11D4110039B;
	Wed,  6 Jul 2016 17:22:47 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-213-0-221.us-west-2.compute.internal [10.213.0.221])
	by relay.mailchannels.net (Postfix) with ESMTPA id 634D91001FA;
	Wed,  6 Jul 2016 17:22:46 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.132.194.146])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 17:22:47 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467825766722:167993082
X-MC-Ingress-Time: 1467825766722
Received: from [176.251.41.101] (port=34404 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKqZn-0000gg-BM; Wed, 06 Jul 2016 13:25:31 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 18:22:38 +0100
Message-Id: <bd6d1bd75e98dbbd6f6787227be4fdbe3ca52b58.1467825407.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2554ed0be16cfdf0f1cdbe2911c21cf4396cb156.1467825407.git.elliot.smith@intel.com>
References: <2554ed0be16cfdf0f1cdbe2911c21cf4396cb156.1467825407.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467825407.git.elliot.smith@intel.com>
References: <cover.1467825407.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 3/4] toaster: add Layer delete front end feature to layerdetails
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
X-List-Received-Date: Wed, 06 Jul 2016 17:31:56 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add the front end feature to delete a layer from the layer details page.

[YOCO #9184]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js   | 20 ++++++++++++++++++++
 lib/toaster/toastergui/static/js/projectpage.js    | 18 ++++++++++++++++++
 lib/toaster/toastergui/templates/layerdetails.html | 20 +++++++++++++++++++-
 lib/toaster/toastergui/urls.py                     |  2 +-
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index a56087b..683486e 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -397,6 +397,26 @@ function layerDetailsPageInit (ctx) {
     $(this).parents("form").submit();
   });
 
+  $("#layer-delete-confirmed").click(function(){
+    $.cookie("layer-deleted", ctx.layerVersion.name, { path: '/'});
+
+    $.ajax({
+        type: "DELETE",
+        url: ctx.xhrUpdateLayerUrl,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function(data) {
+          if (data.error != "ok") {
+            console.warn(data.error);
+          } else {
+            window.location = data.redirect + "?notify=layer-deleted";
+          }
+        },
+        error: function(data) {
+          console.warn("Call failed");
+          console.warn(data);
+        }
+    });
+  });
 
   layerDepsList.find(".glyphicon-trash").click(layerDepRemoveClick);
   layerDepsList.find("a").tooltip();
diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index 6d92490..df79849 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -58,12 +58,30 @@ function projectPageInit(ctx) {
         case 'layer-imported':
           layerImportedNotification();
           break;
+        case 'layer-deleted':
+          layerDeletedNotification();
         default:
           break;
       }
     }
   })();
 
+  /* Layer deleted notification */
+  function layerDeletedNotification(){
+    var layer = $.cookie("layer-deleted");
+
+    if (!layer)
+      return;
+
+    var message = "You have deleted <strong>1</strong> layer from your ";
+    message += "project: <strong>" + layer + "</strong>";
+
+    libtoaster.showChangeNotification(message);
+
+    $.removeCookie("layer-deleted", { path: "/"});
+  }
+
+
   /* Layer imported notification */
   function layerImportedNotification(){
     var imported = $.cookie("layer-imported-alert");
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 143ec25..4b51d1a 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -6,6 +6,20 @@
 {% block title %} {{layerversion.layer.name}} - {{project.name}} - Toaster {% endblock %}
 {% block pagecontent %}
 
+<div id="delete-layer-modal" class="modal fade" tabindex="-1" role="dialog">
+  <div class="modal-dialog" role="document">
+    <div class="modal-content">
+      <div class="modal-body">
+		  Are you sure you want to delete the <strong>{{layerversion.layer.name}}</strong> layer?
+      </div>
+      <div class="modal-footer">
+        <button type="button" id="layer-delete-confirmed" class="btn btn-primary">Delete</button>
+        <button type="button" class="btn btn-default btn-link" data-dismiss="modal">Cancel</button>
+      </div>
+    </div>
+  </div>
+</div>
+
 <div class="row">
   <div class="col-md-12">
     <ul class="breadcrumb">
@@ -44,7 +58,7 @@
 
     $(document).ready(function(){
       var ctx = {
-        xhrUpdateLayerUrl : "{% url 'xhr_layer' layerversion.pk %}",
+        xhrUpdateLayerUrl : "{% url 'xhr_layer' project.id layerversion.pk %}",
         layerVersion : {
           name : "{{layerversion.layer.name}}",
           id : {{layerversion.id}},
@@ -271,6 +285,10 @@
             </dd>
             {% endif %}
           </dl>
+          {% if layerversion.layer_source_id and layerversion.layer_source.sourcetype == layerversion.layer_source.TYPE_IMPORTED %}
+          <i class="icon-trash text-danger"></i>
+          <a href="#delete-layer-modal"  role="button" class="text-danger" data-toggle="modal" data-target="#delete-layer-modal">Delete {{layerversion.layer.name}}</a>
+          {% endif %}
         </div>
       </div>
     </div>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 15b1063..1c0ccbb 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -191,7 +191,7 @@ urlpatterns = patterns('toastergui.views',
 
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
 
-        url(r'^xhr_layer/(?P<layerversion_id>\d+)$',
+        url(r'^xhr_layer/(?P<pid>\d+)/(?P<layerversion_id>\d+)$',
             api.XhrLayer.as_view(),
             name='xhr_layer'),
 
-- 
2.7.4


