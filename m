Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id A5272728A8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 13:15:19 +0000 (UTC)
Received: by mail-pd0-f171.google.com with SMTP id y13so11209855pdi.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 Jan 2015 05:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=E7ILfcSHTAp5Crhf8dXs37I06UO+PN0uivSkvRitEDU=;
	b=LnyKXZIAC9QzHg1c4t1adRuiQkcgQQJdOLt9E8N7h7dCH1G9gjV+ggT886w+9Yc1TG
	Vn9evphQwuLPMFyKQ38CNiu1z/u7n/LFAt5HYEBvKUgLSUvPdSrvUfYmOMMs7I/SxOg3
	yEZn424MPO97byoSuZNysQjSWheNDKN8pikxhDJln+9c4HAUC2L6xO6Ox2c5dGwxXz/m
	6gSZoNpo0gdEvM5TB9aVXPh/rae6TOmZXB9G8CGVTmKmQjySKOAeI4mewD6knrksVjKI
	zUXEqCkbMtW0+seZ9HDWIKYebzvKHqEIUZaKY6asy/l/gp++ZEvlCuCO0QJNdb2ttOx9
	wyoA==
X-Gm-Message-State: ALoCoQmj5WbXznVEINiFD2dyPt4zGOWmB3Ou7yKMNUB7+85j+KUhzx0VpOrgmt/SYNU9NmFnyuLE
X-Received: by 10.66.139.129 with SMTP id qy1mr14698672pab.21.1420722920061;
	Thu, 08 Jan 2015 05:15:20 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fu17sm4554769pdb.5.2015.01.08.05.15.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 Jan 2015 05:15:19 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 07DC85622F5; Thu,  8 Jan 2015 13:15:16 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Jan 2015 13:15:10 +0000
Message-Id: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1420722767.git.alexandru.damian@intel.com>
References: <cover.1420722767.git.alexandru.damian@intel.com>
Subject: [PATCH 1/5] toaster: Improve client side error handling
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
X-List-Received-Date: Thu, 08 Jan 2015 13:15:20 -0000

From: Michael Wood <michael.g.wood@intel.com>

Make use of the toastermain.settings.DEBUG flag to toggle the client
side error logging. Make the error logging consistent by using
console.warn/error across the project, this adds traceability to the
warnings. Also handles the case where console is not available by
stubbing it in libtoaster.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js    | 39 ++++++++++++++++++++---
 lib/toaster/toastergui/static/js/projectapp.js    | 28 ++++++++--------
 lib/toaster/toastergui/templates/base.html        |  5 +++
 lib/toaster/toastergui/templates/layers.html      |  8 ++---
 lib/toaster/toastergui/templates/mrb_section.html |  8 ++---
 lib/toaster/toastergui/templates/targets.html     |  8 ++---
 lib/toaster/toastergui/views.py                   |  6 ++--
 7 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 15815b3..a2a0abd 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -81,14 +81,14 @@ var libtoaster = (function (){
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
           if (_data.error != "ok") {
-            console.log(_data.error);
+            console.warn(_data.error);
           } else {
             if (onsuccess != undefined) onsuccess(_data);
           }
         },
         error: function (_data) {
-          console.log("Call failed");
-          console.log(_data);
+          console.warn("Call failed");
+          console.warn(_data);
           if (onfail) onfail(data);
     } });
   };
@@ -102,13 +102,13 @@ var libtoaster = (function (){
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
           if (_data.error != "ok") {
-            console.log(_data.error);
+            console.warn(_data.error);
           } else {
             if (onsuccess != undefined) onsuccess(_data);
           }
         },
         error: function (_data) {
-          console.log(_data);
+          console.warn(_data);
           if (onfail) onfail(data);
         }
     });
@@ -168,6 +168,7 @@ var libtoaster = (function (){
     getProjectInfo: _getProjectInfo,
     getLayerDepsForProject : _getLayerDepsForProject,
     editProject : _editProject,
+    debug: false,
   }
 })();
 
@@ -203,6 +204,15 @@ function reload_params(params) {
 /* Things that happen for all pages */
 $(document).ready(function() {
 
+    /* If we don't have a console object which might be the case in some
+     * browsers, no-op it to avoid undefined errors.
+     */
+    if (!window.console) {
+      window.console = {};
+      window.console.warn = function() {};
+      window.console.error = function() {};
+    }
+
     /*
      * PrettyPrint plugin.
      *
@@ -320,4 +330,23 @@ $(document).ready(function() {
     if (location.href.search('#warnings') > -1) {
         $('#collapse-warnings').addClass('in');
     }
+
+    function check_for_duplicate_ids () {
+      /* warn about duplicate element ids */
+      var ids = {};
+      $("[id]").each(function() {
+        if (this.id && ids[this.id]) {
+          console.warn('Duplicate element id #'+this.id);
+        }
+        ids[this.id] = true;
+      });
+    }
+
+    if (libtoaster.debug) {
+      check_for_duplicate_ids();
+    } else {
+      /* Debug is false so supress warnings by overriding the functions */
+      window.console.warn = function () {};
+      window.console.error = function () {};
+   }
 });
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index bb97f32..767ea13 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -136,7 +136,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: type, value: currentValue}})
             .success(function (_data) {
                 if (_data.error != "ok") {
-                    alert(_data.error);
+                    console.warn(_data.error);
                     deffered.reject(_data.error);
                 }
                 deffered.resolve(_data.list);
@@ -152,12 +152,12 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         if (inXHRcall) {
             if (callparams.data === undefined) {
                 // we simply skip the data refresh calls
-                console.log("race on XHR, aborted");
+                console.warn("race on XHR, aborted");
                 return;
             } else {
                 // we return a promise that we'll solve by reissuing the command later
                 var delayed = $q.defer();
-                console.log("race on XHR, delayed");
+                console.warn("race on XHR, delayed");
                 $interval(function () {$scope._makeXHRCall(callparams).then(function (d) { delayed.resolve(d); });}, 100, 1);
 
                 return delayed.promise;
@@ -171,7 +171,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
         $http(callparams).success(function(_data, _status, _headers, _config) {
             if (_data.error != "ok") {
-                alert("Failed XHR request (" + _status + "): " + _data.error);
+                console.warn("Failed XHR request (" + _status + "): " + _data.error);
                 console.error("Failed XHR request: ", _data, _status, _headers, _config);
                 // stop refreshing hte page
                 $interval.cancel($scope.pollHandle);
@@ -267,7 +267,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                 deffered.resolve(_data);
             }
         }).error(function(_data, _status, _headers, _config) {
-                alert("Failed HTTP XHR request (" + _status + ")" + _data);
+                console.warn("Failed HTTP XHR request (" + _status + ")" + _data);
                 console.error("Failed HTTP XHR request: ", _data, _status, _headers, _config);
                 inXHRcall = false;
                 deffered.reject(_data.error);
@@ -298,7 +298,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
     $scope.targetNamedBuild = function(target) {
         if ($scope.targetName === undefined && $scope.targetName1 === undefined){
-            alert("No target defined, please type in a target name");
+            console.warn("No target defined, please type in a target name");
             return;
         }
 
@@ -310,7 +310,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                 targets: $scope.safeTargetName,
             }
         }).then(function (data) {
-            console.log("received ", data);
+            console.warn("received ", data);
             $scope.targetName = undefined;
             $scope.targetName1 = undefined;
             $location.hash('buildslist');
@@ -357,7 +357,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         $http({method:"GET", url: $scope.urls.xhr_datatypeahead, params : { type: "layerdeps", value: $scope.layerAddId }})
         .success(function (_data) {
              if (_data.error != "ok") {
-                 alert(_data.error);
+                 console.warn(_data.error);
              } else {
                  if (_data.list.length > 0) {
                      // activate modal
@@ -369,7 +369,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                          $scope.selectedItems = (function () { s = {}; for (var i = 0; i < items.length; i++) { s[items[i].id] = true; };return s; })();
 
                          $scope.ok = function() {
-                            console.log("scope selected is ", $scope.selectedItems);
+                            console.warn("scope selected is ", $scope.selectedItems);
                             $modalInstance.close(Object.keys($scope.selectedItems).filter(function (e) { return $scope.selectedItems[e];}));
                          };
 
@@ -378,7 +378,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                          };
 
                          $scope.update = function() {
-                            console.log("updated ", $scope.selectedItems);
+                            console.warn("updated ", $scope.selectedItems);
                          };
                        },
                        resolve: {
@@ -393,7 +393,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
                      modalInstance.result.then(function (selectedArray) {
                          selectedArray.push($scope.layerAddId);
-                         console.log("selected", selectedArray);
+                         console.warn("selected", selectedArray);
 
                          $scope._makeXHRCall({
                              method: "POST", url: $scope.urls.xhr_edit,
@@ -473,7 +473,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 
     $scope.edit = function(elementid) {
         var data = {};
-        console.log("edit with ", elementid);
+        console.warn("edit with ", elementid);
         var alertText = undefined;
         var alertZone = undefined;
         var oldLayers = [];
@@ -675,7 +675,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
 */
 
 function test_diff_arrays() {
-    _diffArrays([1,2,3], [2,3,4], function(e,f) { return e==f; }, function(e) {console.log("added", e)}, function(e) {console.log("deleted", e);})
+    _diffArrays([1,2,3], [2,3,4], function(e,f) { return e==f; }, function(e) {console.warn("added", e)}, function(e) {console.warn("deleted", e);})
 }
 
 // test_diff_arrays();
@@ -685,6 +685,6 @@ var s = undefined;
 function test_set_alert(text) {
     s = angular.element("div#main").scope();
     s.displayAlert(s.zone3alerts, text);
-    console.log(s.zone3alerts);
+    console.warn(s.zone3alerts);
     s.$digest();
 }
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index bc7a0ee..e95b5e0 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -21,6 +21,11 @@
 </script>
 <script src="{% static 'js/libtoaster.js' %}">
 </script>
+{% if DEBUG %}
+<script>
+  libtoaster.debug = true;
+ </script>
+{% endif %}
 <script src="{% static 'js/base.js' %}"></script>
 {%if MANAGED %}
 <script>
diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index ced54c2..33160e5 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -126,15 +126,15 @@ function _makeXHREditCall(data, onsuccess, onfail) {
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
             if (_data.error != "ok") {
-                alert(_data.error);
+                console.warn(_data.error);
             } else {
                 updateButtons(_data.layers.map(function (e) {return e.id}));
                 if (onsuccess != undefined) onsuccess(_data);
             }
         },
         error: function (_data) {
-            alert("Call failed");
-            console.log(_data);
+            console.warn("Call failed");
+            console.warn(_data);
         }
     });
 }
@@ -215,7 +215,7 @@ function layerAdd(layerId, layerName, layerURL) {
         data: {'type': 'layerdeps','value':layerId},
         success: function(_data) {
                 if (_data.error != "ok") {
-                    alert(_data.error);
+                    console.warn(_data.error);
                 } else {
                     updateLayerCountLabels(_data.list.length+1);
 
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 73031e2..432955a 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -79,21 +79,21 @@ function _makeXHRBuildCall(url, data, onsuccess, onfail) {
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
             if (_data.error != "ok") {
-                alert(_data.error);
+                console.warn(_data.error);
             } else {
                 if (onsuccess != undefined) onsuccess(_data);
             }
         },
         error: function (_data) {
-            alert("Call failed");
-            console.log(_data);
+            console.warn("Call failed");
+            console.warn(_data);
             if (onfail) onfail(data);
         } });
 }
 
 
 function scheduleBuild(url, projectName, buildlist) {
-  console.log("scheduleBuild");
+  console.warn("scheduleBuild");
   _makeXHRBuildCall(url, {targets: buildlist.join(" ")}, function (_data) {
 
       $('#latest-builds').prepend('<div class="alert alert-info" style="padding-top:0px">' + '<span class="label label-info" style="font-weight: normal; margin-bottom: 5px; margin-left:-15px; padding-top:5px;">'+projectName+'</span><div class="row-fluid">' +
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index f4313f9..cc339fb 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -119,15 +119,15 @@ function _makeXHREditCall(data, onsuccess, onfail) {
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
             if (_data.error != "ok") {
-                alert(_data.error);
+                console.warn(_data.error);
             } else {
                 updateButtons(_data.layers.map(function (e) {return e.id}));
                 if (onsuccess != undefined) onsuccess(_data);
             }
         },
         error: function (_data) {
-            alert("Call failed");
-            console.log(_data);
+            console.warn("Call failed");
+            console.warn(_data);
         }
     });
 }
@@ -202,7 +202,7 @@ function layerAdd(layerId, layerName, layerURL, pressedButtonId) {
         data: {'type': 'layerdeps','value':layerId},
         success: function(_data) {
                 if (_data.error != "ok") {
-                    alert(_data.error);
+                    console.warn(_data.error);
                 } else {
                     updateLayerCountLabels(_data.list.length+1);
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 679c1e9..420b37c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1898,7 +1898,8 @@ if toastermain.settings.MANAGED:
     def managedcontextprocessor(request):
         ret = {
             "projects": Project.objects.all(),
-            "MANAGED" : toastermain.settings.MANAGED
+            "MANAGED" : toastermain.settings.MANAGED,
+            "DEBUG" : toastermain.settings.DEBUG
         }
         if 'project_id' in request.session:
             try:
@@ -2923,7 +2924,8 @@ else:
     def managedcontextprocessor(request):
         return {
             "projects": [],
-            "MANAGED" : toastermain.settings.MANAGED
+            "MANAGED" : toastermain.settings.MANAGED,
+            "DEBUG" : toastermain.settings.DEBUG
         }
 
     def newproject(request):
-- 
1.9.1


