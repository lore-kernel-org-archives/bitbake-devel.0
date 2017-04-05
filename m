Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A652473122
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Apr 2017 07:22:23 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v357MN2M003278
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 5 Apr 2017 00:22:24 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 5 Apr 2017 00:22:22 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Apr 2017 00:12:48 -0700
Message-ID: <c5b3b3cbfc98fe031e1ead094ca08b2e6a5604a2.1491374730.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1491374730.git.David.Reyna@windriver.com>
References: <cover.1491374730.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Subject: [PATCH 1/1] toaster: toastergui: implement machine name validation
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
X-List-Received-Date: Wed, 05 Apr 2017 07:22:23 -0000
Content-Type: text/plain

From: "Belal, Awais" <Awais_Belal@mentor.com>

Valid machine names cannot include spaces anywhere
in the name and doing so will result in a build failure.
This implements a mechanism to alert the user against
such a misconfiguration and does not allow input of
such machine names.

[YOCTO #8721]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/js/projectpage.js | 17 +++++++++++++++++
 lib/toaster/toastergui/templates/project.html   |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index 4536703..21adf81 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -12,6 +12,8 @@ function projectPageInit(ctx) {
   var machineChangeFormToggle = $("#change-machine-toggle");
   var machineNameTitle = $("#project-machine-name");
   var machineChangeCancel = $("#cancel-machine-change");
+  var machineInputForm = $("#machine-input-form");
+  var invalidMachineNameHelp = $("#invalid-machine-name-help");
 
   var freqBuildBtn =  $("#freq-build-btn");
   var freqBuildList = $("#freq-build-list");
@@ -208,8 +210,23 @@ function projectPageInit(ctx) {
 
 
   /* Change machine functionality */
+  machineChangeInput.keyup(function(){
+    if ($(this).val().indexOf(' ') >= 0) {
+        machineChangeBtn.attr("disabled", "disabled");
+        invalidMachineNameHelp.show();
+        machineInputForm.addClass('has-error');
+    } else {
+        machineChangeBtn.removeAttr("disabled");
+        invalidMachineNameHelp.hide();
+        machineInputForm.removeClass('has-error');
+    }
+  });
 
   machineChangeFormToggle.click(function(){
+    machineChangeInput.val(machineNameTitle.text());
+    machineChangeBtn.removeAttr("disabled");
+    invalidMachineNameHelp.hide();
+    machineInputForm.removeClass('has-error');
     machineForm.slideDown();
     machineNameTitle.hide();
     $(this).hide();
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 5abe241..ab7e665 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -67,11 +67,12 @@
 
       <form id="select-machine-form" style="display:none;" class="form-inline">
         <span class="help-block">Machine suggestions come from the list of layers added to your project. If you don't see the machine you are looking for, <a href="{% url 'projectmachines' project.id %}">check the full list of machines</a></span>
-        <div class="form-group">
+        <div class="form-group" id="machine-input-form">
           <input class="form-control" id="machine-change-input" autocomplete="off" value="" data-provide="typeahead" data-minlength="1" data-autocomplete="off" type="text">
         </div>
         <button id="machine-change-btn" class="btn btn-default" type="button">Save</button>
         <a href="#" id="cancel-machine-change" class="btn btn-link">Cancel</a>
+        <span class="help-block text-danger" id="invalid-machine-name-help" style="display:none">A valid machine name cannot include spaces.</span>
         <p class="form-link"><a href="{% url 'projectmachines' project.id %}">View compatible machines</a></p>
       </form>
     </div>
-- 
1.9.1


