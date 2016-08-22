Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id 7843C6E64A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:49:13 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 692F7128753;
	Mon, 22 Aug 2016 15:42:43 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-120-4-226.us-west-2.compute.internal [10.120.4.226])
	by relay.mailchannels.net (Postfix) with ESMTPA id 9111012815D;
	Mon, 22 Aug 2016 15:42:42 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.107.128.240])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:43 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880562942:2175265105
X-MC-Ingress-Time: 1471880562942
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrN3-0002ZA-EU; Mon, 22 Aug 2016 11:42:41 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:29 +0100
Message-Id: <1471880556-9232-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 2/9] toaster: layerdetails js changes for switching layers
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
X-List-Received-Date: Mon, 22 Aug 2016 15:49:13 -0000

From: Sujith H <sujith.h@gmail.com>

This patch helps to implement the switching of layers
between directories and git repositories. Specifically
selection of git and local directory. Also enabling
form to view the selection.

[YOCTO #9913]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/toastergui/static/js/layerdetails.js   | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
index 0d4240b..2ff8e59 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
@@ -10,6 +10,7 @@ function layerDetailsPageInit (ctx) {
   var targetTab = $("#targets-tab");
   var machineTab = $("#machines-tab");
   var detailsTab = $("#details-tab");
+  var editLayerSource = $("#edit-layer-source");
 
   /* setup the dependencies typeahead */
   libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.layersTypeAheadUrl, { include_added: "true" }, function(item){
@@ -423,4 +424,101 @@ function layerDetailsPageInit (ctx) {
   $(".glyphicon-trash").tooltip();
   $(".commit").tooltip();
 
+  editLayerSource.click(function() {
+    // Kindly bring the git layers imported from layerindex to normal page and not this new page :(
+    $(this).hide();
+    $("#save-changes-for-switch").attr("disabled", "disabled");
+
+    $("#git-repo-info", "#directory-info").hide();
+    $("#edit-layer-source-form").fadeIn();
+    if ($("#layer-dir-path-in-details").val() == "") {
+      //Local dir path is empty...
+      $("#repo").prop("checked", true);
+      $("#layer-git").fadeIn();
+      $("#layer-dir").hide();
+    } else {
+      $("#layer-git").hide();
+      $("#layer-dir").fadeIn();
+    }
+  });
+
+  $('input:radio[name="source-location"]').change(function() {
+    if ($('input[name=source-location]:checked').val() == "repo") {
+      $("#layer-git").fadeIn();
+      $("#layer-dir").hide();
+	if ($("#layer-git-repo-url").val().length === 0 && $("#layer-git-ref").val().length === 0) {
+	    $("#save-changes-for-switch").attr("disabled", "disabled");
+	}
+    } else {
+      $("#layer-dir").fadeIn();
+      $("#layer-git").hide();
+    }
+  });
+
+  $("#layer-dir-path-in-details").keyup(function() {
+    $("#save-changes-for-switch").removeAttr("disabled");
+  });
+
+  $("#layer-git-repo-url").keyup(function() {
+    if ($("#layer-git-repo-url").val().length > 0 && $("#layer-git-ref").val().length > 0) {
+      $("#save-changes-for-switch").removeAttr("disabled");
+    }
+  });
+
+  $("#layer-git-ref").keyup(function() {
+    if ($("#layer-git-repo-url").val().length > 0 && $("#layer-git-ref").val().length > 0) {
+      $("#save-changes-for-switch").removeAttr("disabled");
+    }
+  });
+
+  $('#cancel-changes-for-switch').click(function() {
+    editLayerSource.show();
+    $("#git-repo-info", "#directory-info").fadeIn();
+    $("#edit-layer-source-form").fadeOut();
+
+    if ($("#layer-dir-path-in-details").val().length) {
+      $("#dir").prop("checked", true);
+      $("#layer-git").fadeOut();
+      $("#layer-dir").fadeIn();
+    } else {
+      $("#layer-git").fadeIn();
+      $("#layer-dir").fadeOut();
+    }
+  });
+
+  $('#save-changes-for-switch').click(function() {
+
+    var layerData = {
+      vcs_url: $('#layer-git-repo-url').val(),
+      commit: $('#layer-git-ref').val(),
+      dirpath: $('#layer-subdir').val(),
+      local_source_dir: $('#layer-dir-path-in-details').val(),
+    };
+
+    if ($('input[name=source-location]:checked').val() == "repo") {
+      layerData.local_source_dir = "";
+    } else {
+      layerData.vcs_url = "";
+      layerData.git_ref = "";
+    }
+
+    $.ajax({
+        type: "POST",
+        url: ctx.xhrUpdateLayerUrl,
+        data: layerData,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (data) {
+          if (data.error != "ok") {
+            console.warn(data.error);
+          } else {
+            /* success layer property changed */
+            window.location.reload();
+          }
+        },
+        error: function (data) {
+          console.warn("Call failed");
+          console.warn(data);
+        }
+    });
+  });
 }
-- 
2.7.4


