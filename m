Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id C98C577126
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 09:20:03 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 16 Oct 2015 02:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,688,1437462000"; d="scan'208";a="828379998"
Received: from bbryczek-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.107])
	by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2015 02:18:47 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Oct 2015 10:18:29 +0100
Message-Id: <1444987109-22763-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Allow any text input to machine configuration variable
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
X-List-Received-Date: Fri, 16 Oct 2015 09:20:06 -0000

From: Michael Wood <michael.g.wood@intel.com>

Allow any text input to the machine variable; as we may not have discovered
all the available machines until after a build.

[YOCTO #8418]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../lib/toaster/toastergui/static/js/projectpage.js  | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/projectpage.js b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
index b0fe451..e742ef2 100644
--- a/bitbake/lib/toaster/toastergui/static/js/projectpage.js
+++ b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
@@ -23,7 +23,7 @@ function projectPageInit(ctx) {
   var cancelReleaseChange = $("#cancel-release-change");
 
   var currentLayerAddSelection;
-  var currentMachineAddSelection = {};
+  var currentMachineAddSelection = "";
 
   var urlParams = libtoaster.parseUrlParams();
 
@@ -38,7 +38,7 @@ function projectPageInit(ctx) {
      */
     if (urlParams.hasOwnProperty('setMachine') &&
         urlParams.setMachine !== prjInfo.machine.name){
-        currentMachineAddSelection.name = urlParams.setMachine;
+        machineChangeInput.val(urlParams.setMachine);
         machineChangeBtn.click();
     } else {
       updateMachineName(prjInfo.machine.name);
@@ -254,29 +254,33 @@ function projectPageInit(ctx) {
   }
 
   libtoaster.makeTypeahead(machineChangeInput, libtoaster.ctx.machinesTypeAheadUrl, { }, function(item){
-    currentMachineAddSelection = item;
+    currentMachineAddSelection = item.name;
     machineChangeBtn.removeAttr("disabled");
   });
 
   machineChangeBtn.click(function(e){
     e.preventDefault();
-    if (currentMachineAddSelection.name === undefined)
+    /* We accept any value regardless of typeahead selection or not */
+    if (machineChangeInput.val().length === 0)
       return;
 
-    libtoaster.editCurrentProject({ machineName : currentMachineAddSelection.name },
+    currentMachineAddSelection = machineChangeInput.val();
+
+    libtoaster.editCurrentProject(
+      { machineName : currentMachineAddSelection },
       function(){
         /* Success machine changed */
-        updateMachineName(currentMachineAddSelection.name);
+        updateMachineName(currentMachineAddSelection);
         machineChangeCancel.click();
 
         /* Show the alert message */
         var message = $('<span class="lead">You have changed the machine to: <strong><span id="notify-machine-name"></span></strong></span>');
-        message.find("#notify-machine-name").text(currentMachineAddSelection.name);
+        message.find("#notify-machine-name").text(currentMachineAddSelection);
         libtoaster.showChangeNotification(message);
     },
       function(){
         /* Failed machine changed */
-        console.log("failed to change machine");
+        console.warn("Failed to change machine");
     });
   });
 
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


