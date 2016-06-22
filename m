Return-Path: <elliot.smith@intel.com>
X-Greylist: delayed 1152 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 22 Jun 2016 09:30:02 UTC
Received: from gt-egress-002.mailchannels.net (bird.oak.relay.mailchannels.net
	[23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id AA7586010D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2016 09:30:02 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 23B9BE040D;
	Wed, 22 Jun 2016 09:10:50 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-11-165.us-west-2.compute.internal [10.229.11.165])
	by relay.mailchannels.net (Postfix) with ESMTPA id 413EAE02F8;
	Wed, 22 Jun 2016 09:10:49 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.132.194.146])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.14); Wed, 22 Jun 2016 09:10:50 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1466586649663:3045259265
X-MC-Ingress-Time: 1466586649663
Received: from [176.251.19.34] (port=42832 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bFeDe-0004w7-H9; Wed, 22 Jun 2016 05:13:10 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jun 2016 10:10:41 +0100
Message-Id: <1466586642-18896-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
X-AuthUser: elliot@townx.org
Subject: [PATCH 1/2] toaster: fix validation checks for DL_DIR and SSTATE_DIR
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
X-List-Received-Date: Wed, 22 Jun 2016 09:30:03 -0000

From: Sujith H <sujith.h@gmail.com>

Validation logic on the project configuration page
prevented a user from adding ${variable} to these paths.

Update validation so a user can see a better message
when they type characters into the text inputs.
Two types of validation are implemented.

Either:

* The value should start with a "/", to allow absolute paths.

or

* The value should start with a "$", to allow bitbake
   variables like ${TOPDIR}.

[YOCTO #9646]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/toastergui/templates/projectconf.html  | 71 +++++++++++++++-------
 1 file changed, 49 insertions(+), 22 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/projectconf.html b/bitbake/lib/toaster/toastergui/templates/projectconf.html
index bfa386d..82c5598 100644
--- a/bitbake/lib/toaster/toastergui/templates/projectconf.html
+++ b/bitbake/lib/toaster/toastergui/templates/projectconf.html
@@ -41,7 +41,8 @@
       </div>
       <button id="apply-change-dl_dir" class="btn btn-default" type="button">Save</button>
       <button id="cancel-change-dl_dir" type="button" class="btn btn-link">Cancel</button>
-      <p class="help-block" id="hintError-dl_dir">A valid directory cannot include spaces or any of these characters: . \ ? % * : | " " < ></p>
+      <p class="help-block" id="hintError-dl_dir" style="display:none;">The directory path cannot include spaces or any of these characters: . \ ? % * : | " " &lt; &gt;</p>
+      <p class="help-block" id="hintError-initialChar-dl_dir" style="display:none;">The directory path should either start with a /, e.g. /home/toaster/downloads; or with a variable, e.g. ${TOPDIR}/downloads.</p>
     </form>
     </dd>
     {% endif %}
@@ -88,7 +89,7 @@
         <input type="text" class="form-control" id="new-image_install" placeholder="Type one or more package names">
       </div>
       <button id="apply-change-image_install" class="btn btn-default" type="button">Save</button>
-      <button id="cancel-change-image_install" type="button" class="btn btn-link">Cancel</button>  
+      <button id="cancel-change-image_install" type="button" class="btn btn-link">Cancel</button>
     </form>
     </dd>
     {% endif %}
@@ -149,7 +150,8 @@
       </div>
       <button id="apply-change-sstate_dir" class="btn btn-default" type="button">Save</button>
       <button id="cancel-change-sstate_dir" type="button" class="btn btn-link">Cancel</button>
-      <p class="help-block" id="hintError-sstate_dir">A valid directory cannot include spaces or any of these characters: . \ ? % * : | " " < ></p>
+      <p class="help-block" id="hintError-sstate_dir" style="display:none;">The directory path cannot include spaces or any of these characters: . \ ? % * : | " " &lt; &gt;</p>
+      <p class="help-block" id="hintError-initialChar-sstate_dir" style="display:none;">The directory path should either start with a /, e.g. /home/toaster/sstate-cache; or with a variable, e.g. ${TOPDIR}/sstate-cache.</p>
     </form>
     </dd>
     {% endif %}
@@ -369,8 +371,8 @@ function setEventHandlersForDynamicElements() {
     $("#new-config_var_"+pk).val(current_val);
     if ( $("#new-config_var_"+pk).val().length ) {
       $("#apply-change-config_var_"+pk).removeAttr("disabled");
-    } 
-    else { 
+    }
+    else {
       $("#apply-change-config_var_"+pk).attr("disabled");
     }
   });
@@ -410,7 +412,7 @@ function setEventHandlersForDynamicElements() {
     var pk = $(this).attr("x-data");
 
     // fade out the variable+value div, then refresh the variable list
-    $(this).fadeOut(); 
+    $(this).fadeOut();
     $(this).tooltip("hide");
     $("config_var_entry_"+pk).fadeOut();
     $('#config_var_value_'+pk).parent("dd").fadeOut();
@@ -553,7 +555,6 @@ $(document).ready(function() {
 
   // change DL_DIR variable
   $('#change-dl_dir-icon').click(function() {
-    $('#hintError-dl_dir').hide();
     $('#change-dl_dir-form').removeClass('has-error');
     // preset the edit value
     var current_val = $("#dl_dir").text().trim();
@@ -575,6 +576,8 @@ $(document).ready(function() {
   });
 
   $('#cancel-change-dl_dir').click(function(){
+    $("#hintError-dl_dir").hide();
+    $("#hintError-initialChar-dl_dir").hide();
     $("#change-dl_dir-form").slideUp(function() {
       $('#dl_dir, #change-dl_dir-icon').show();
     });
@@ -583,20 +586,31 @@ $(document).ready(function() {
   $("#new-dl_dir").on('input', function(){
     if ($(this).val().trim().length == 0) {
       $("#apply-change-dl_dir").attr("disabled","disabled");
+      $('#change-dl_dir-form').addClass('has-error');
+      $('#hintError-dl_dir').hide();
+      $('#hintError-initialChar-dl_dir').hide();
     }
     else {
       var input = $(this);
-      var re = /^\/([^ <>\\|":\.%\?\*]+)$/;
+      var reBeginWithSlash = /^\//;
+      var reCheckVariable = /^\$/;
+      var re = /([ <>\\|":\.%\?\*]+)/;
       var invalidDir = re.test(input.val());
-      console.log(invalidDir);
-      if ( invalidDir ) {
-        $('#change-dl_dir-form').removeClass('has-error');
-        $("#apply-change-dl_dir").removeAttr("disabled");
-        $('#hintError-dl_dir').hide();
-      } else {
+      var invalidSlash = reBeginWithSlash.test(input.val());
+      var invalidVar = reCheckVariable.test(input.val());
+      if (!invalidSlash && !invalidVar) {
+        $('#change-dl_dir-form').addClass('has-error');
+        $("#apply-change-dl_dir").attr("disabled","disabled");
+        $('#hintError-initialChar-dl_dir').show();
+      } else if (invalidDir) {
         $('#change-dl_dir-form').addClass('has-error');
         $("#apply-change-dl_dir").attr("disabled","disabled");
         $('#hintError-dl_dir').show();
+      } else {
+        $('#change-dl_dir-form').removeClass('has-error');
+        $("#apply-change-dl_dir").removeAttr("disabled");
+        $('#hintError-dl_dir').hide();
+        $('#hintError-initialChar-dl_dir').hide();
       }
     }
   });
@@ -905,7 +919,7 @@ $(document).ready(function() {
 
   // change SSTATE_DIR variable
   $('#change-sstate_dir-icon').click(function() {
-    $('#hintError-sstate_dir').hide();
+    $('#change-sstate_dir-form').removeClass('has-error');
     // preset the edit value
     var current_val = $("span#sstate_dir").text().trim();
     if (current_val == "Not set") {
@@ -927,6 +941,8 @@ $(document).ready(function() {
   });
 
   $('#cancel-change-sstate_dir').click(function(){
+    $("#hintError-sstate_dir").hide();
+    $("#hintError-initialChar-sstate_dir").hide();
     $("#change-sstate_dir-form").slideUp(function() {
       $('#sstate_dir, #change-sstate_dir-icon').show();
     });
@@ -935,20 +951,31 @@ $(document).ready(function() {
   $("#new-sstate_dir").on('input', function(){
     if ($(this).val().trim().length == 0) {
       $("#apply-change-sstate_dir").attr("disabled","disabled");
+      $('#change-sstate_dir-form').addClass('has-error');
+      $('#hintError-sstate_dir').hide();
+      $('#hintError-initialChar-sstate_dir').hide();
     }
     else {
       var input = $(this);
-      var re = /^\/([^ <>\\|":\.%\?\*]+)$/;
+      var reBeginWithSlash = /^\//;
+      var reCheckVariable = /^\$/;
+      var re = /([ <>\\|":\.%\?\*]+)/;
       var invalidDir = re.test(input.val());
-      console.log(invalidDir);
-      if ( invalidDir ) {
+      var invalidSlash = reBeginWithSlash.test(input.val());
+      var invalidVar = reCheckVariable.test(input.val());
+      if (!invalidSlash && !invalidVar) {
+        $('#change-sstate_dir-form').addClass('has-error');
+        $("#apply-change-sstate_dir").attr("disabled","disabled");
+        $('#hintError-initialChar-sstate_dir').show();
+      } else if (invalidDir) {
+          $('#change-sstate_dir-form').addClass('has-error');
+          $("#apply-change-sstate_dir").attr("disabled","disabled");
+          $('#hintError-sstate_dir').show();
+      } else {
         $('#change-sstate_dir-form').removeClass('has-error');
         $("#apply-change-sstate_dir").removeAttr("disabled");
         $('#hintError-sstate_dir').hide();
-      } else {
-        $('#change-sstate_dir-form').addClass('has-error');
-        $("#apply-change-sstate_dir").attr("disabled","disabled");
-        $('#hintError-sstate_dir').show();
+        $('#hintError-initialChar-sstate_dir').hide();
       }
     }
   });
-- 
2.7.4


