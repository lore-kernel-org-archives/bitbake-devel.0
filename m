Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id 927B172C34
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:00 +0000 (UTC)
Received: by mail-we0-f169.google.com with SMTP id p10so21215432wes.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=/whzxfEBHhiQdTqflOxgkyKFZH4fOOhgcvgy+1dNqmU=;
	b=Uo6LX76ycXpeDcY9SBNd4PLmAa6YzZXNk/tAuRfZ+YBo9WEzjvol+4IkGcurQC/qIT
	2U7qi7Gd28XUzbg5JzSNuptCfeGdispL5ZdwgL/kMI8Weayi+xGkyQI6j0c5Qk7AAwwR
	UuLt3nKx1qxYu3pr2e8OlaqD4feS0ApwfdNyKSAuBPWjSS1lVxQ8iRfMhChfMb3liIrR
	nrXDlYSHBJYe0WFSeMmcp/XtDdrEsdC9GPYAAeRTyHK2toGbJ4pOi5SvJdQ6jFivFazn
	YSmWXYURDdi/r/ptE20DaZdWaOdttgXEgr5tQCtdW0Hy3WjxqmRW87O6qsVzn6Gihccq
	NUVA==
X-Gm-Message-State: ALoCoQmLASHvq/mjwImmdCghcEkxKU8/JCjTjK8cIaXrCHust35LBe5RNvaR32i3xg/t1MzO/Q6D
X-Received: by 10.180.103.231 with SMTP id fz7mr57094208wib.49.1421864519533; 
	Wed, 21 Jan 2015 10:21:59 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id c10sm825206wjy.4.2015.01.21.10.21.56
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:21:57 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EC5725640FA; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:38 +0000
Message-Id: <1aef19f67a2a5382128ba9207b516c3f7a053ef3.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 08/12] toastegui: project page build selected targets
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Fixing the action on the "Build selected targets" button.
Remove "build-button" duplicate id from the build page.

[YOCTO #7047]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js | 25 ++++++++++++++++++++++---
 lib/toaster/toastergui/templates/project.html  |  6 +++---
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 74471a1..bee3c56 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -337,8 +337,12 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     }
 
     $scope.buildExistingTarget = function(targets) {
+         $scope.buildTargetList(targets.map(function(v,i,a){return v.target}));
+    }
+
+    $scope.buildTargetList = function(targetlist) {
         var oldTargetName = $scope.targetName;
-        $scope.targetName = targets.map(function(v,i,a){return v.target}).join(' ');
+        $scope.targetName = targetlist.join(' ');
         $scope.buildNamedTarget();
         $scope.targetName = oldTargetName;
     }
@@ -733,12 +737,27 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         angular.element(id+"-opposite").toggle();
     }
 
-    $scope.selectedMostBuildTargets = function () {
-        keys = Object.keys($scope.mostBuiltTargets);
+    /**
+     * Functionality related to "Most build targets"
+     */
+
+    $scope.enableBuildSelectedTargets = function () {
+        var keys = Object.keys($scope.mostBuiltTargets);
         keys = keys.filter(function (e) { if ($scope.mostBuiltTargets[e]) return e });
         return keys.length == 0;
     }
 
+    $scope.buildSelectedTargets = function () {
+        var keys = Object.keys($scope.mostBuiltTargets);
+        keys = keys.filter(function (e) { if ($scope.mostBuiltTargets[e]) return e });
+
+        $scope.buildTargetList(keys);
+        for (var i = 0; i < keys.length; i++)
+        {
+            $scope.mostBuiltTargets[keys[i]] = 0;
+        }
+    }
+
     /**
      * Helper function to deal with error string recognition and manipulation
      */
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 815c24c..fe3bcf2 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -92,7 +92,7 @@ vim: expandtab tabstop=2
     <form class="build-form" ng-submit="buildNamedTarget()">
       <div class="input-append controls">
         <input type="text" class="huge span7" placeholder="Type the target(s) you want to build" autocomplete="off" ng-model="targetName" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length"/>
-        <button type="submit" id="build-button" class="btn btn-large btn-primary" ng-disabled="!targetName.length">
+        <button type="submit" class="btn btn-large btn-primary" ng-disabled="!targetName.length">
         Build
         </button>
       </div>
@@ -289,7 +289,7 @@ vim: expandtab tabstop=2
         <form ng-submit="buildNamedTarget()">
           <div class="input-append">
             <input type="text" class="input-xlarge" placeholder="Type the target(s) you want to build" autocomplete="off" data-minLength="1"  ng-model="targetName1" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length">
-            <button type="submit" id="build-button" class="btn btn-primary" ng-disabled="!targetName1.length">
+            <button type="submit" class="btn btn-primary" ng-disabled="!targetName1.length">
               Build </button>
           </div>
           {% csrf_token %}
@@ -306,7 +306,7 @@ vim: expandtab tabstop=2
             </label>
           </li>
         </ul>
-        <button class="btn btn-large btn-primary" ng-disabled="selectedMostBuildTargets()">Build selected targets</button>
+        <button class="btn btn-large btn-primary" ng-disabled="enableBuildSelectedTargets()" ng-click="buildSelectedTargets()">Build selected targets</button>
         </div>
     </div>
 
-- 
1.9.1


