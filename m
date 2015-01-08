Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id C472B72B3D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 13:15:27 +0000 (UTC)
Received: by mail-pd0-f173.google.com with SMTP id ft15so11195856pdb.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 Jan 2015 05:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=/Va14F7wlT5Kl9IdyMRmXQ5BmoyDqsoaGB1LNVyzoKU=;
	b=cP6CuasEnS5KjIPLxhwMFv7IGJZvnRfiU8ETWfsmadf8wyBqLDbKXFm25ZywJ0g5jM
	1GLTYuiaktVoE2sFPYJRqdwkvbxrzy7PpAOU8eAuXQ3vSdmGMagmvQQLqkmpZUFfqmKX
	27qikU83BYNOEnD5k09/GeyZbMYTiNpRdu9xMWP9EIHWycU1Wt3I/C41BiSPNtGgn4hW
	pO7Q7axRZWn42ay1VAX3B4+cPHrUCIMpMbdUhCAQ3W+0Dx9fVyk2wMzbeqIexXbd+HHw
	X+V/KmGgDjbo9q8pppe2xvC3BJwF2StkJAdpmOS6LVClva0tXoAz2S92uo+qnha48Ori
	oP0Q==
X-Gm-Message-State: ALoCoQmIOBR8GZ/mEhtUPcS8YDzeaJEsZl59VRZOqDylVFROZU7i0Bk7u8LAFBMrioyo0AqSx9yp
X-Received: by 10.66.162.105 with SMTP id xz9mr14704428pab.77.1420722927852;
	Thu, 08 Jan 2015 05:15:27 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ih10sm4499933pbc.1.2015.01.08.05.15.25
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 Jan 2015 05:15:27 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0E4C4562594; Thu,  8 Jan 2015 13:15:16 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Jan 2015 13:15:14 +0000
Message-Id: <a6c1f9991f387e6b9d1b5ae9a1cb049542a58c0b.1420722767.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
References: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1420722767.git.alexandru.damian@intel.com>
References: <cover.1420722767.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/5] toaster: implementation of project page
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
X-List-Received-Date: Thu, 08 Jan 2015 13:15:27 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings the project page in line with the design,
including build error handling and suggestions.

Includes some refactoring for already existing code.

[YOCTO #6587]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js | 234 ++++++++++++++++++-------
 lib/toaster/toastergui/templates/project.html  |  50 ++++--
 lib/toaster/toastergui/views.py                |  97 +++++-----
 3 files changed, 246 insertions(+), 135 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 767ea13..0bdc55a 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -100,6 +100,16 @@ function _diffArrays(existingArray, newArray, compareElements, onAdded, onDelete
 
 }
 
+// add Array findIndex if not there
+
+if (Array.prototype.findIndex === undefined) {
+    Array.prototype.findIndex = function (callback) {
+        var i = 0;
+        for ( i = 0; i < this.length; i++ )
+            if (callback(this[i], i, this)) return i;
+        return -1;
+    }
+}
 
 var projectApp = angular.module('project', ['ngCookies', 'ngAnimate', 'ui.bootstrap', 'ngRoute', 'ngSanitize'],  angular_formpost);
 
@@ -126,11 +136,17 @@ projectApp.filter('timediff', function() {
     }
 });
 
+/**
+ * main controller for the project page
+ */
 
-// main controller for the project page
 projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $location, $cookies, $cookieStore, $q, $sce, $anchorScroll, $animate, $sanitize) {
 
-    $scope.getSuggestions = function(type, currentValue) {
+    /**
+     * Retrieves text suggestions for text-edit drop down autocomplete boxes
+     */
+
+    $scope.getAutocompleteSuggestions = function(type, currentValue) {
         var deffered = $q.defer();
 
         $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: type, value: currentValue}})
@@ -147,17 +163,19 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
     var inXHRcall = false;
 
-    // default handling of XHR calls that handles errors and updates commonly-used pages
+    /**
+     * XHR call wrapper that automatically handles errors and auto-updates the page content to reflect project state on server side.
+     */
     $scope._makeXHRCall = function(callparams) {
         if (inXHRcall) {
             if (callparams.data === undefined) {
                 // we simply skip the data refresh calls
-                console.warn("race on XHR, aborted");
+                console.warn("TRC1: race on XHR, aborted");
                 return;
             } else {
                 // we return a promise that we'll solve by reissuing the command later
                 var delayed = $q.defer();
-                console.warn("race on XHR, delayed");
+                console.warn("TRC2: race on XHR, delayed");
                 $interval(function () {$scope._makeXHRCall(callparams).then(function (d) { delayed.resolve(d); });}, 100, 1);
 
                 return delayed.promise;
@@ -178,33 +196,6 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                 deffered.reject(_data.error);
             }
             else {
-
-                if (_data.builds !== undefined) {
-                    var toDelete = [];
-                    // step 1 - delete entries not found
-                    $scope.builds.forEach(function (elem) {
-                        if (-1 == _data.builds.findIndex(function (elemX) { return elemX.id == elem.id && elemX.status == elem.status; })) {
-                            toDelete.push(elem);
-                        }
-                    });
-                    toDelete.forEach(function (elem) {
-                        $scope.builds.splice($scope.builds.indexOf(elem),1);
-                    });
-                    // step 2 - merge new entries
-                    _data.builds.forEach(function (elem) {
-                        var found = false;
-                        var i = 0;
-                        for (i = 0 ; i < $scope.builds.length; i ++) {
-                            if ($scope.builds[i].id > elem.id) continue;
-                            if ($scope.builds[i].id == elem.id) { found=true; break;}
-                            if ($scope.builds[i].id < elem.id) break;
-                        }
-                        if (!found) {
-                            $scope.builds.splice(i, 0, elem);
-                        }
-                    });
-
-                }
                 if (_data.layers !== undefined) {
 
                     var addedLayers = [];
@@ -239,12 +230,59 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                     // step 3 - display alerts.
                     if (addedLayers.length > 0) {
                         $scope.displayAlert($scope.zone2alerts, "You have added <b>"+addedLayers.length+"</b> layer" + ((addedLayers.length>1)?"s: ":": ") + addedLayers.map(function (e) { return "<a href=\""+e.layerdetailurl+"\">"+e.name+"</a>" }).join(", "), "alert-info");
+                        // invalidate error layer data based on current layers
+                        $scope.layersForTargets = {};
                     }
                     if (deletedLayers.length > 0) {
                         $scope.displayAlert($scope.zone2alerts, "You have deleted <b>"+deletedLayers.length+"</b> layer" + ((deletedLayers.length>1)?"s: ":": ") + deletedLayers.map(function (e) { return "<a href=\""+e.layerdetailurl+"\">"+e.name+"</a>" }).join(", "), "alert-info");
+                        // invalidate error layer data based on current layers
+                        $scope.layersForTargets = {};
                     }
 
                 }
+
+
+                if (_data.builds !== undefined) {
+                    var toDelete = [];
+                    // step 1 - delete entries not found
+                    $scope.builds.forEach(function (elem) {
+                        if (-1 == _data.builds.findIndex(function (elemX) { return elemX.id == elem.id && elemX.status == elem.status; })) {
+                            toDelete.push(elem);
+                        }
+                    });
+                    toDelete.forEach(function (elem) {
+                        $scope.builds.splice($scope.builds.indexOf(elem),1);
+                    });
+                    // step 2 - merge new entries
+                    _data.builds.forEach(function (elem) {
+                        var found = false;
+                        var i = 0;
+                        for (i = 0 ; i < $scope.builds.length; i ++) {
+                            if ($scope.builds[i].id > elem.id) continue;
+                            if ($scope.builds[i].id == elem.id) { found=true; break;}
+                            if ($scope.builds[i].id < elem.id) break;
+                        }
+                        if (!found) {
+                            $scope.builds.splice(i, 0, elem);
+                        }
+                    });
+                    // step 3 - merge "Canceled" builds
+                    $scope.canceledBuilds.forEach(function (elem) {
+                        // mock the build object
+                        var found = false;
+                        var i = 0;
+                        for (i = 0; i < $scope.builds.length; i ++) {
+                           if ($scope.builds[i].id > elem.id) continue;
+                            if ($scope.builds[i].id == elem.id) { found=true; break;}
+                            if ($scope.builds[i].id < elem.id) break;
+                        }
+                        if (!found) {
+                            $scope.builds.splice(i, 0, elem);
+                        }
+                    });
+
+                    $scope.fetchLayersForTargets();
+                }
                 if (_data.targets !== undefined) {
                     $scope.targets = _data.targets;
                 }
@@ -267,17 +305,26 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                 deffered.resolve(_data);
             }
         }).error(function(_data, _status, _headers, _config) {
-                console.warn("Failed HTTP XHR request (" + _status + ")" + _data);
+            if (_status == 0) {
+                // the server has gone away
+                alert("The server is not responding. The application will terminate now")
+                $interval.cancel($scope.pollHandle);
+            }
+            else {
                 console.error("Failed HTTP XHR request: ", _data, _status, _headers, _config);
                 inXHRcall = false;
                 deffered.reject(_data.error);
+            }
         });
 
         return deffered.promise;
     }
 
     $scope.layeralert = undefined;
-    // shows user alerts on invalid project data
+    /**
+     * Verifies and shows user alerts on invalid project data
+     */
+
     $scope.validateData = function () {
         if ($scope.layers.length == 0) {
             $scope.layeralert = $scope.displayAlert($scope.zone1alerts, "You need to add some layers to this project. <a href=\""+$scope.urls.layers+"\">View all layers available in Toaster</a> or <a href=\""+$scope.urls.importlayer+"\">import a layer</a>");
@@ -289,14 +336,14 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         }
     }
 
-    $scope.targetExistingBuild = function(targets) {
+    $scope.buildExistingTarget = function(targets) {
         var oldTargetName = $scope.targetName;
         $scope.targetName = targets.map(function(v,i,a){return v.target}).join(' ');
         $scope.targetNamedBuild();
         $scope.targetName = oldTargetName;
     }
 
-    $scope.targetNamedBuild = function(target) {
+    $scope.buildNamedTarget = function(target) {
         if ($scope.targetName === undefined && $scope.targetName1 === undefined){
             console.warn("No target defined, please type in a target name");
             return;
@@ -310,7 +357,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                 targets: $scope.safeTargetName,
             }
         }).then(function (data) {
-            console.warn("received ", data);
+            console.warn("TRC3: received ", data);
             $scope.targetName = undefined;
             $scope.targetName1 = undefined;
             $location.hash('buildslist');
@@ -329,22 +376,20 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         $scope.safeTargetName = $scope.safeTargetName.replace(/\[.*\]/, '').trim();
     }
 
-    $scope.buildCancel = function(id) {
+    $scope.buildCancel = function(build) {
         $scope._makeXHRCall({
             method: "POST", url: $scope.urls.xhr_build,
             data: {
-                buildCancel: id,
+                buildCancel: build.id,
             }
+        }).then( function () {
+            build['status'] = "deleted";
+            $scope.canceledBuilds.push(build);
         });
     }
 
-    $scope.buildDelete = function(id) {
-        $scope._makeXHRCall({
-            method: "POST", url: $scope.urls.xhr_build,
-            data: {
-                buildDelete: id,
-            }
-        });
+    $scope.buildDelete = function(build) {
+        $scope.canceledBuilds.splice($scope.canceledBuilds.indexOf(build), 1);
     }
 
 
@@ -352,6 +397,12 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         $scope.layerAddId = item.id;
     }
 
+
+    $scope.layerAddById = function (id) {
+        $scope.layerAddId = id;
+        $scope.layerAdd();
+    }
+
     $scope.layerAdd = function() {
 
         $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: "layerdeps", value: $scope.layerAddId }})
@@ -369,7 +420,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                          $scope.selectedItems = (function () { s = {}; for (var i = 0; i < items.length; i++) { s[items[i].id] = true; };return s; })();
 
                          $scope.ok = function() {
-                            console.warn("scope selected is ", $scope.selectedItems);
+                            console.warn("TRC4: scope selected is ", $scope.selectedItems);
                             $modalInstance.close(Object.keys($scope.selectedItems).filter(function (e) { return $scope.selectedItems[e];}));
                          };
 
@@ -378,7 +429,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                          };
 
                          $scope.update = function() {
-                            console.warn("updated ", $scope.selectedItems);
+                            console.warn("TRC5: updated ", $scope.selectedItems);
                          };
                        },
                        resolve: {
@@ -393,7 +444,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
                      modalInstance.result.then(function (selectedArray) {
                          selectedArray.push($scope.layerAddId);
-                         console.warn("selected", selectedArray);
+                         console.warn("TRC6: selected", selectedArray);
 
                          $scope._makeXHRCall({
                              method: "POST", url: $scope.urls.xhr_edit,
@@ -429,7 +480,16 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     }
 
 
-    $scope.test = function(elementid) {
+    /**
+     * Verifies if a project settings change would trigger layer updates. If user confirmation is needed,
+     * a modal dialog will prompt the user to ack the changes. If not, the editProjectSettings() function is called directly.
+     *
+     * Only "versionlayers" change for is supported (and hardcoded) for now.
+     */
+
+    $scope.testProjectSettingsChange = function(elementid) {
+        if (elementid != '#change-project-version') throw "Not implemented";
+
         $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: "versionlayers", value: $scope.projectVersion }}).
         success(function (_data) {
             if (_data.error != "ok") {
@@ -463,17 +523,21 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                        }
                      });
 
-                     modalInstance.result.then(function () { $scope.edit(elementid)});
+                     modalInstance.result.then(function () { $scope.editProjectSettings(elementid)});
                  } else {
-                    $scope.edit(elementid);
+                    $scope.editProjectSettings(elementid);
                  }
             }
         });
     }
 
-    $scope.edit = function(elementid) {
+    /**
+     * Performs changes to project settings, and updates the user interface accordingly.
+     */
+
+    $scope.editProjectSettings = function(elementid) {
         var data = {};
-        console.warn("edit with ", elementid);
+        console.warn("TRC7: editProjectSettings with ", elementid);
         var alertText = undefined;
         var alertZone = undefined;
         var oldLayers = [];
@@ -508,10 +572,14 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                 alertText += "<strong>" + $scope.project.release.desc + "</strong>. ";
             }
             if (elementid == '#change-project-version') {
+                $scope.layersForTargets = {};   // invalidate error layers for the targets, since layers changed
+
                 // requirement https://bugzilla.yoctoproject.org/attachment.cgi?id=2229, notification for changed version to include layers
                 $scope.zone2alerts.forEach(function (e) { e.close() });
                 alertText += "This has caused the following changes in your project layers:<ul>"
 
+
+                // warnings - this is executed AFTER the generic XHRCall handling is done; at this point,
                 if (_data.layers !== undefined) {
                     // show added/deleted layer notifications; scope.layers is already updated by this point.
                     var addedLayers = [];
@@ -547,6 +615,10 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     }
 
 
+    /**
+     * Extracts a command passed through the local path in location, and executes/updates UI based on the command
+     */
+
     $scope.updateDisplayWithCommands = function() {
         cmd = $location.path();
 
@@ -630,6 +702,10 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         });
     }
 
+    /**
+     * Utility function to display an alert to the user
+     */
+
     $scope.displayAlert = function(zone, text, type) {
         if (zone.maxid === undefined) { zone.maxid = 0; }
         var crtid = zone.maxid ++;
@@ -644,6 +720,10 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         return o;
     }
 
+    /**
+     * Toggles display items between label and input box (the edit pencil icon) on selected settings in project page
+     */
+
     $scope.toggle = function(id) {
         $scope.projectName = $scope.project.name;
         $scope.projectVersion = $scope.project.release.id;
@@ -657,34 +737,52 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         keys = Object.keys($scope.mostBuiltTargets);
         keys = keys.filter(function (e) { if ($scope.mostBuiltTargets[e]) return e });
         return keys.length == 0;
+    }
+
+    /**
+     * Helper function to deal with error string recognition and manipulation
+     */
 
+    $scope.getTargetNameFromErrorMsg = function (msg) {
+        targets = msg.split(" ").splice(2).map(function (v) { return v.replace(/'/g, '')})
+        return targets;
     }
 
-    // init code
-    //
-    $scope.init = function() {
-        $scope.pollHandle = $interval(function () { $scope._makeXHRCall({method: "GET", url: $scope.urls.xhr_edit, data: undefined});}, 2000, 0);
+    $scope.fetchLayersForTargets = function () {
+        $scope.builds.forEach(function (buildrequest) {
+            buildrequest.errors.forEach(function (error) {
+                if (error.msg.indexOf("Nothin") == 0) {
+                    $scope.getTargetNameFromErrorMsg(error.msg).forEach(function (target) {
+                        if ($scope.layersForTargets[target] === undefined)
+                        $scope.getAutocompleteSuggestions("layers4target", target).then( function (list) {
+                            $scope.layersForTargets[target] = list;
+                        })
+                    })
+                }
+            })
+        })
     }
 
-    $scope.init();
-});
 
+    /**
+     * Page init code - just init variables and set the automated refresh
+     */
 
-/**
-    TESTING CODE
-*/
+    $scope.init = function() {
+        $scope.canceledBuilds = [];
+        $scope.layersForTargets = {};
+        $scope.fetchLayersForTargets();
+        $scope.pollHandle = $interval(function () { $scope._makeXHRCall({method: "GET", url: $scope.urls.xhr_edit, data: undefined});}, 2000, 0);
+    }
 
-function test_diff_arrays() {
-    _diffArrays([1,2,3], [2,3,4], function(e,f) { return e==f; }, function(e) {console.warn("added", e)}, function(e) {console.warn("deleted", e);})
-}
+});
 
-// test_diff_arrays();
 
 var s = undefined;
 
 function test_set_alert(text) {
     s = angular.element("div#main").scope();
     s.displayAlert(s.zone3alerts, text);
-    console.warn(s.zone3alerts);
+    console.warn("TRC8: zone3alerts", s.zone3alerts);
     s.$digest();
 }
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 2979db7..67b2672 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -89,9 +89,9 @@ vim: expandtab tabstop=2
 
   <!-- build form -->
   <div class="well">
-    <form class="build-form" ng-submit="targetNamedBuild()">
+    <form class="build-form" ng-submit="buildNamedTarget()">
       <div class="input-append controls">
-        <input type="text" class="huge span7" placeholder="Type the target(s) you want to build" autocomplete="off" ng-model="targetName" typeahead="e.name for e in getSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length"/>
+        <input type="text" class="huge span7" placeholder="Type the target(s) you want to build" autocomplete="off" ng-model="targetName" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length"/>
         <button type="submit" id="build-button" class="btn btn-large btn-primary" ng-disabled="!targetName.length">
         Build
         </button>
@@ -108,6 +108,9 @@ vim: expandtab tabstop=2
     </form>
   </div>
 
+
+  <!-- latest builds list -->
+
   <a id="buildslist"></a>
   <h2 class="air" ng-if="builds.length">Latest builds</h2>
   <div class="animate-repeat alert"  ng-repeat="b in builds track by b.id" ng-class="{'queued':'alert-info', 'deleted':'alert-info', 'in progress': 'alert-info', 'failed':'alert-error', 'completed':{'In Progress':'alert-info', 'Succeeded':'alert-success', 'Failed':'alert-error'}[b.build[0].status]}[b.status]">
@@ -116,9 +119,27 @@ vim: expandtab tabstop=2
 
           <case ng-switch-when="failed">
             <div class="lead span3"> <span ng-repeat="t in b.targets" ng-include src="'target_display'"></span></div>
+            <div >
+                <button class="btn pull-right btn-danger" ng-click="buildExistingTarget(b.targets)">Run again</button>
+            </div>
             <div class="row-fluid">
               <div class="air well" ng-repeat="e in b.errors">
-                Error type {[e.type]}: <pre>{[e.msg]}</pre>
+                    <pre>{[e.msg]}</pre>
+                  <ngif ng-if="e.msg.indexOf('Nothin') == 0">
+                    <div ng-repeat="t in getTargetNameFromErrorMsg(e.msg)">
+                     <p class="lead">The target <strong>{[t]}</strong> is not provided by any of your project layers.</p>
+                     <p> Your build has failed because the target <strong>{[t]}</strong> is not provided by any of your project layers.</p>
+                     <ngif ng-if="layersForTargets[t].length > 0">
+                       <p>The following layers provide this target. You could add one of them to your project.</p>
+                       <button class="btn btn-danger add-layer-with-dependencies" ng-repeat="l in layersForTargets[t]" ng-click="layerAddById(l.id)">Add {[l.name]}</button>
+                     </ngif>
+                    </div>
+                  </ngif>
+                  <ngif ng-if="e.msg.indexOf('Nothin') != 0">
+                    <p>
+                    Please contact your system administrator to help troubleshoot this error.
+                    </p>
+                  </ngif>
               </div>
             </div>
           </case>
@@ -128,7 +149,7 @@ vim: expandtab tabstop=2
             <div class="span4 lead" >Build queued
               <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
             </div>
-            <button class="btn pull-right btn-info" ng-click="buildCancel(b.id)">Cancel</button>
+            <button class="btn pull-right btn-info" ng-click="buildCancel(b)">Cancel</button>
           </case>
 
           <case ng-switch-when="created">
@@ -136,7 +157,7 @@ vim: expandtab tabstop=2
             <div class="span6" >
               <span class="lead">Creating build</span>
             </div>
-            <button class="btn pull-right btn-info" ng-click="buildCancel(b.id)">Cancel</button>
+            <button class="btn pull-right btn-info" ng-click="buildCancel(b)">Cancel</button>
           </case>
 
           <case ng-switch-when="deleted">
@@ -144,7 +165,7 @@ vim: expandtab tabstop=2
             <div class="span6" id="{[b.id]}-deleted" >
               <span class="lead">Build deleted</span>
             </div>
-            <button class="btn pull-right btn-info" ng-click="buildDelete(b.id)">Close</button>
+            <button class="btn pull-right btn-info" ng-click="buildDelete(b)">Close</button>
           </case>
 
 
@@ -198,7 +219,7 @@ vim: expandtab tabstop=2
             </div>
             <div> <span class="lead">Build time: <a href="{[b.build[0].build_time_page_url]}">{[b.build[0].build_time|timediff]}</a></span>
                 <button class="btn pull-right" ng-class="{'Succeeded':  'btn-success', 'Failed': 'btn-danger'}[b.build[0].status]"
-                    ng-click="targetExistingBuild(b.targets)">Run again</button>
+                    ng-click="buildExistingTarget(b.targets)">Run again</button>
 
             </div>
           </case>
@@ -244,7 +265,7 @@ vim: expandtab tabstop=2
       </div>
       <form ng-submit="layerAdd()">
         <div class="input-append">
-          <input type="text" class="input-xlarge" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" ng-model="layerAddName" typeahead="e.name for e in getSuggestions('layers', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" typeahead-on-select="onLayerSelect($item, $model, $label)" typeahead-editable="false" ng-class="{ 'has-error': layerAddName.$invalid }" />
+          <input type="text" class="input-xlarge" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" ng-model="layerAddName" typeahead="e.name for e in getAutocompleteSuggestions('layers', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" typeahead-on-select="onLayerSelect($item, $model, $label)" typeahead-editable="false" ng-class="{ 'has-error': layerAddName.$invalid }" />
           <input type="submit" id="add-layer" class="btn" value="Add" ng-disabled="!layerAddName.length"/>
         </div>
         {% csrf_token %}
@@ -265,9 +286,9 @@ vim: expandtab tabstop=2
         Targets
         <i class="icon-question-sign get-help heading-help" title="What you build, often a recipe producing a root file system file (an image). Something like <code>core-image-minimal</code> or <code>core-image-sato</code>"></i>
       </h3>
-        <form ng-submit="targetNamedBuild()">
+        <form ng-submit="buildNamedTarget()">
           <div class="input-append">
-            <input type="text" class="input-xlarge" placeholder="Type the target(s) you want to build" autocomplete="off" data-minLength="1"  ng-model="targetName1" typeahead="e.name for e in getSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length">
+            <input type="text" class="input-xlarge" placeholder="Type the target(s) you want to build" autocomplete="off" data-minLength="1"  ng-model="targetName1" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length">
             <button type="submit" id="build-button" class="btn btn-primary" ng-disabled="!targetName1.length">
               Build </button>
           </div>
@@ -304,8 +325,8 @@ vim: expandtab tabstop=2
           <strong>Machine changes have a big impact on build outcome.</strong>
               You cannot really compare the builds for the new machine with the previous ones.
         </div>
-        <form ng-submit="edit('#select-machine')" class="input-append">
-              <input type="text" id="machine" autocomplete="off" ng-model="machineName" typeahead="m.name for m in getSuggestions('machines', $viewValue)"/>
+        <form ng-submit="editProjectSettings('#select-machine')" class="input-append">
+              <input type="text" id="machine" autocomplete="off" ng-model="machineName" typeahead="m.name for m in getAutocompleteSuggestions('machines', $viewValue)"/>
               <input type="submit" id="apply-change-machine" class="btn" type="button" ng-disabled="machineName == machine.name || machineName.length == 0" value="Save"></input>
               <input type="reset" id="cancel-machine" class="btn btn-link" ng-click="toggle('#select-machine')" value="Cancel"></input>
               {% csrf_token %}
@@ -337,7 +358,7 @@ vim: expandtab tabstop=2
       <i class="icon-pencil" ng-click="toggle('#change-project-name')" ></i>
     </p>
     <div id="change-project-name" style="display:none;">
-      <form ng-submit="edit('#change-project-name')" class="input-append">
+      <form ng-submit="editProjectSettings('#change-project-name')" class="input-append">
         <input type="text" class="input-xlarge" id="type-project-name" ng-model="projectName">
         <input type="submit" class="btn" value="Save" ng-disabled="project.name == projectName"/>
         <input type="reset" class="btn btn-link" value="Cancel" ng-click="toggle('#change-project-name')">
@@ -354,7 +375,7 @@ vim: expandtab tabstop=2
       <i id="change-version" class="icon-pencil" ng-click="toggle('#change-project-version')" ></i>
     </p>
     <div class="div-inline" id="change-project-version" style="display:none;">
-      <form ng-submit="test('#change-project-version')" class="input-append">
+      <form ng-submit="testProjectSettingsChange('#change-project-version')" class="input-append">
         <select id="select-version" ng-model="projectVersion">
           <option ng-repeat="r in releases" value="{[r.id]}" ng-selected="r.id == project.release.id">{[r.description]}</option>
         </select>
@@ -404,6 +425,7 @@ angular.element(document).ready(function() {
   scope.updateDisplayWithCommands();
   scope.validateData();
 
+  scope.init();
   scope.$digest();
 
   });
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 420b37c..8c21ca4 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -40,7 +40,6 @@ from django.utils import formats
 from toastergui.templatetags.projecttags import json as jsonfilter
 import json
 
-
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
 def landing(request):
@@ -52,37 +51,25 @@ def landing(request):
 
     return render(request, 'landing.html')
 
+# returns a list for most recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
 def _project_recent_build_list(prj):
-        # build requests not yet started
-        return (map(lambda x: {
-                "id":  x.pk,
-                "targets" : map(lambda y: {"target": y.target }, x.brtarget_set.all()),
-                "status": x.get_state_display(),
-            }, prj.buildrequest_set.filter(state__lt = BuildRequest.REQ_INPROGRESS).order_by("-pk")) +
-        # build requests started, but with no build yet
-            map(lambda x: {
-                "id":  x.pk,
-                "targets" : map(lambda y: {"target": y.target }, x.brtarget_set.all()),
-                "status": x.get_state_display(),
-            }, prj.buildrequest_set.filter(state = BuildRequest.REQ_INPROGRESS, build = None).order_by("-pk")) +
-        # build requests that failed
-            map(lambda x: {
-                "id":  x.pk,
-                "targets" : map(lambda y: {"target": y.target }, x.brtarget_set.all()),
-                "status": x.get_state_display(),
-                "errors": map(lambda y: {"type": y.errtype, "msg": y.errmsg, "tb": y.traceback}, x.brerror_set.all()),
-            }, prj.buildrequest_set.filter(state = BuildRequest.REQ_FAILED).order_by("-pk")) +
-        # and already made builds
-            map(lambda x: {
-                "id": x.pk,
-                "targets": map(lambda y: {"target": y.target }, x.target_set.all()),
-                "status": x.get_outcome_display(),
-                "completed_on" : x.completed_on.strftime('%s')+"000",
-                "build_time" : (x.completed_on - x.started_on).total_seconds(),
-                "build_page_url" : reverse('builddashboard', args=(x.pk,)),
-                "completeper": x.completeper(),
-                "eta": x.eta().ctime(),
-            }, prj.build_set.all()))
+    return map(lambda x: {
+            "id":  x.pk,
+            "targets" : map(lambda y: {"target": y.target, "task": y.task }, x.brtarget_set.all()),
+            "status": x.get_state_display(),
+            "errors": map(lambda y: {"type": y.errtype, "msg": y.errmsg, "tb": y.traceback}, x.brerror_set.exclude(errmsg__contains="Command Failed")),
+            "build" : map( lambda y: {"id": y.pk,
+                        "status": y.get_outcome_display(),
+                        "completed_on" : y.completed_on.strftime('%s')+"000",
+                        "build_time" : (y.completed_on - y.started_on).total_seconds(),
+                        "build_page_url" : reverse('builddashboard', args=(y.pk,)),
+                        'build_time_page_url': reverse('buildtime', args=(y.pk,)),
+                        "errors": y.errors_no,
+                        "warnings": y.warnings_no,
+                        "completeper": y.completeper(),
+                        "eta": y.eta().strftime('%s')+"000"}, Build.objects.filter(buildrequest = x)),
+        }, list(prj.buildrequest_set.filter(Q(state__lt=BuildRequest.REQ_COMPLETED) or Q(state=BuildRequest.REQ_DELETED)).order_by("-pk")) +
+            list(prj.buildrequest_set.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3]))
 
 
 def _build_page_range(paginator, index = 1):
@@ -1959,25 +1946,6 @@ if toastermain.settings.MANAGED:
 
         raise Exception("Invalid HTTP method for this page")
 
-    # returns a list for most recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
-    def _project_recent_build_list(prj):
-        return map(lambda x: {
-                "id":  x.pk,
-                "targets" : map(lambda y: {"target": y.target, "task": y.task }, x.brtarget_set.all()),
-                "status": x.get_state_display(),
-                "errors": map(lambda y: {"type": y.errtype, "msg": y.errmsg, "tb": y.traceback}, x.brerror_set.all()),
-                "build" : map( lambda y: {"id": y.pk,
-                            "status": y.get_outcome_display(),
-                            "completed_on" : y.completed_on.strftime('%s')+"000",
-                            "build_time" : (y.completed_on - y.started_on).total_seconds(),
-                            "build_page_url" : reverse('builddashboard', args=(y.pk,)),
-                            'build_time_page_url': reverse('buildtime', args=(y.pk,)),
-                            "errors": y.errors_no,
-                            "warnings": y.warnings_no,
-                            "completeper": y.completeper(),
-                            "eta": y.eta().strftime('%s')+"000"}, Build.objects.filter(buildrequest = x)),
-            }, list(prj.buildrequest_set.filter(Q(state__lt=BuildRequest.REQ_COMPLETED) or Q(state=BuildRequest.REQ_DELETED)).order_by("-pk")) +
-                list(prj.buildrequest_set.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3]))
 
 
     # Shows the edit project page
@@ -2177,7 +2145,7 @@ if toastermain.settings.MANAGED:
                 # all layers for the current project
                 queryset_all = prj.compatible_layerversions().filter(layer__name__icontains=request.GET.get('value',''))
 
-                # but not layers with equivalent layers already in project               
+                # but not layers with equivalent layers already in project
                 if not request.GET.has_key('include_added'):
                     queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])[:8]
 
@@ -2192,7 +2160,9 @@ if toastermain.settings.MANAGED:
                 queryset = prj.compatible_layerversions().exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()]).filter(
                     layer__name__in = [ x.depends_on.layer.name for x in LayerVersionDependency.objects.filter(layer_version_id = request.GET['value'])])
 
-                return HttpResponse(jsonfilter( { "error":"ok", "list" : map( _lv_to_dict, queryset) }), content_type = "application/json")
+                final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset])
+
+                return HttpResponse(jsonfilter( { "error":"ok", "list" : map( _lv_to_dict, final_list) }), content_type = "application/json")
 
 
 
@@ -2213,16 +2183,36 @@ if toastermain.settings.MANAGED:
                     }), content_type = "application/json")
 
 
+            # returns layer versions that provide the named targets
+            if request.GET['type'] == "layers4target":
+                # we returnd ata only if the recipe can't be provided by the current project layer set
+                if reduce(lambda x, y: x + y, [x.recipe_layer_version.filter(name="anki").count() for x in prj.projectlayer_equivalent_set()], 0):
+                    final_list = []
+                else:
+                    queryset_all = prj.compatible_layerversions().filter(recipe_layer_version__name = request.GET.get('value', '__none__'))
+
+                    # exclude layers in the project
+                    queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])
+
+                    # and show only the selected layers for this project
+                    final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
+
+                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, final_list) }), content_type = "application/json")
+
             # returns targets provided by current project layers
             if request.GET['type'] == "targets":
                 queryset_all = Recipe.objects.all()
-                queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set())
+                layer_equivalent_set = []
+                for i in prj.projectlayer_set.all():
+                    layer_equivalent_set += i.layercommit.get_equivalents_wpriority(prj)
+                queryset_all = queryset_all.filter(layer_version__in =  layer_equivalent_set)
                 return HttpResponse(jsonfilter({ "error":"ok",
                     "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
                         queryset_all.filter(name__icontains=request.GET.get('value',''))[:8]),
 
                     }), content_type = "application/json")
 
+            # returns machines provided by the current project layers
             if request.GET['type'] == "machines":
                 queryset_all = Machine.objects.all()
                 if 'project_id' in request.session:
@@ -2234,6 +2224,7 @@ if toastermain.settings.MANAGED:
 
                     }), content_type = "application/json")
 
+            # returns all projects
             if request.GET['type'] == "projects":
                 queryset_all = Project.objects.all()
                 ret = { "error": "ok",
-- 
1.9.1


