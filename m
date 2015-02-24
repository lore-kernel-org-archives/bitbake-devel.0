Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id D0A0673643
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:07 +0000 (UTC)
Received: by padfa1 with SMTP id fa1so37572099pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=7zKjjB7jg1YOHP7pJpZNElidZMuGxQt1oSHJM2kuF6U=;
	b=iuQQB0S3rZlZkHrp5te8cmtuftr9cRQ53Ryj/Mvr/WE/MaoPZ6MgGbE3hOlnXoW/lr
	erCITtZI3Myr7GvAxqOv3lHH/p0A+LaKanXI4D6hKdB1y7+eB6MWS+3SLB9XRhzE9oCy
	v5qICDCU1THgxfmQV8wzlhXJkPWqHVbnz/nibTuBmC1fVf5fOht3177+dDOsmxCE95DZ
	y94S76NAPKzBXNy+IFbwSvhpkZ8xYUs9f2C068tdkGo9rchT3uIDkwk9SxD7pQW0SU7N
	yT0zBF+OL+/neLsoPVA8IHGNMsS9RW1gXlQq51TsWHNl3hh/VCzBZs/3RNkkA4HtgV73
	4O2A==
X-Gm-Message-State: ALoCoQlO0yCdmCFEqyWTXsbRwp6aM4UlyZMCQXqZNNgWELD6gYK7i6DbyGMgviM94ZSSTp9k3Fji
X-Received: by 10.68.195.10 with SMTP id ia10mr5241543pbc.113.1424798468912;
	Tue, 24 Feb 2015 09:21:08 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	oq4sm25612174pdb.73.2015.02.24.09.21.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:08 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 977375618C2; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:54 +0000
Message-Id: <dbadecbdecc12ac7428f1a7485298d1bf189d7d7.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 06/12] toaster: Add machine selection notification
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:08 -0000

From: Michael Wood <michael.g.wood@intel.com>

This adds a notification to the project page to notify users of the
change in project configuration.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css    | 6 ++++++
 lib/toaster/toastergui/static/js/layerdetails.js | 2 +-
 lib/toaster/toastergui/static/js/machines.js     | 3 +--
 lib/toaster/toastergui/static/js/projectapp.js   | 9 +++++++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index f97e6c4..277888b 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -237,4 +237,10 @@ div.add-deps { margin-top: 15px; }
 .animate-repeat.ng-enter.ng-enter-active {
   opacity:1;
 }
+
+@keyframes machines-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
+@-webkit-keyframes machines-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
+
+.machines-highlight { -webkit-animation: machines-fade 7s 1; -moz-animation: machines-fade 7s 1; animation: machines-fade 7s 1; }
+
 .tab-pane table { margin-top: 10px; }
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 2e713d5..22c40d9 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -133,7 +133,7 @@ function layerDetailsPageInit (ctx) {
     var data =  { machineName : $(this).data('machine-name') };
     libtoaster.editProject(ctx.xhrEditProjectUrl, ctx.projectId, data,
       function (){
-        window.location.replace(ctx.projectPageUrl);
+        window.location.replace(ctx.projectPageUrl+"#/machineselected");
     }, null);
   });
 
diff --git a/lib/toaster/toastergui/static/js/machines.js b/lib/toaster/toastergui/static/js/machines.js
index ee8c980..973a037 100644
--- a/lib/toaster/toastergui/static/js/machines.js
+++ b/lib/toaster/toastergui/static/js/machines.js
@@ -77,7 +77,6 @@ function machinesPageInit (ctx) {
           show_layer_deps_modal(ctx.projectId, layer, data.list, null, null, true, function () {
             /* Success add deps and layer */
             setLayerInCurrentPrj(btn, data.list);
-            console.log ("TODO SUCCESS");
           });
         }
       }, null);
@@ -87,7 +86,7 @@ function machinesPageInit (ctx) {
     var data =  { machineName : $(this).data('machine-name') };
     libtoaster.editProject(ctx.xhrEditProjectUrl, ctx.projectId, data,
       function (){
-        window.location.replace(ctx.projectPageUrl);
+        window.location.replace(ctx.projectPageUrl+"#/machineselected");
     }, null);
   });
 
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 4d00f40..df811fb 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -665,6 +665,15 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                     "\">select targets</a> you want to build.", "alert-success");
         });
 
+        _cmdExecuteWithParam("/machineselected", function () {
+            $scope.displayAlert($scope.zone2alerts, "You have changed the machine to: <strong>" + $scope.machine.name + "</strong>", "alert-info");
+            var machineDistro = angular.element("#machine-distro");
+
+            angular.element("html, body").animate({ scrollTop: machineDistro.position().top }, 700).promise().done(function() {
+              $animate.addClass(machineDistro, "machines-highlight");
+            });
+        });
+
         _cmdExecuteWithParam("/layerimported", function (layer) {
           var imported = $cookieStore.get("layer-imported-alert");
           var text;
-- 
1.9.1


