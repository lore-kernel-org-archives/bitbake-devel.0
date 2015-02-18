Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
	[74.125.82.176])
	by mail.openembedded.org (Postfix) with ESMTP id 613536B0CB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:04 +0000 (UTC)
Received: by wesx3 with SMTP id x3so3048165wes.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=WcYqm9wUnx6w1PjF28v8+hsZxGkqgxuHDgEJiu9atRQ=;
	b=SPvaa7Z38Ci2iedv/4SVE4Kqvx3QkcJEaRhh1SG1VNQqCuc7gL68MdVRDqCtipDadW
	2YEwC2b6btNI2NlOaM2HHTU8E1eYqki7OY4GoPUExReyQ51u9DGyMnz06LUa5CJwO/uB
	xmzER72MbCwyD8gh+qcABg7XjQJ9uAnOzaIglPp7yqqbrCUCNvD0Ez7gqxTE3m9WKjOq
	Iwym+eGkiPYxFUHjfOuZtx0qu5ESE9HRDjm28wCBSsORiaxcl9evZypbYlGi97yaJbEN
	dXYZB0Ja1km/fYOCGdcux0+HdRyeI34GgLBCLw3meB7K/q7X4f8GWmYjk8ElM1qqXNIG
	IFag==
X-Gm-Message-State: ALoCoQlIZ0k+jr3tU3/ubgiTcmiXpVqj9n4JQRXDyc++tymN8tr3p0YPPgOVprQoDXu+67TbBZII
X-Received: by 10.180.9.71 with SMTP id x7mr3293459wia.0.1424286665836;
	Wed, 18 Feb 2015 11:11:05 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	cb14sm26723362wib.22.2015.02.18.11.11.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:05 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 44E5A561F1A; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:10:57 +0000
Message-Id: <5fecfda0e47c2ecba9b7c903c6d258eefa431aa0.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 03/10] toasterui: fix time estimation in project page
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
X-List-Received-Date: Wed, 18 Feb 2015 19:11:05 -0000

From: Alexandru Damian <alexandru.damian@intel.com>

This patch fixes the time estimation to build completion
in project page. Additionally it fixes the Most Recent Builds
section used in various pages in managed mode, and proper
time to build estimation in all pages.

[YOCTO #7004]

Signed-off-by: Alexandru Damian <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py                          |  2 +-
 lib/toaster/toastergui/static/js/projectapp.js     | 24 +++++++++++++++++++---
 .../toastergui/templates/managed_mrb_section.html  |  3 +--
 lib/toaster/toastergui/templates/project.html      |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index f70c006..0f85c8f 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -194,7 +194,7 @@ class Build(models.Model):
         eta = timezone.now()
         completeper = self.completeper()
         if self.completeper() > 0:
-            eta = timezone.now() + ((timezone.now() - self.started_on)*(100-completeper)/completeper)
+            eta += ((eta - self.started_on)*100)/completeper
         return eta
 
 
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index bee3c56..4d00f40 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -136,6 +136,16 @@ projectApp.filter('timediff', function() {
     }
 });
 
+// add "time to future" eta that computes time from now to a point in the future
+projectApp.filter('toeta', function() {
+    return function(input) {
+       var crtmiliseconds = new Date().getTime();
+        diff = (parseInt(input) - crtmiliseconds ) / 1000;
+        console.log("Debug: future time ", input, "crt time", crtmiliseconds, ":", diff);
+        return diff < 0 ? 300 : diff;
+    }
+});
+
 /**
  * main controller for the project page
  */
@@ -259,7 +269,14 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                         var i = 0;
                         for (i = 0 ; i < $scope.builds.length; i ++) {
                             if ($scope.builds[i].id > elem.id) continue;
-                            if ($scope.builds[i].id == elem.id) { found=true; break;}
+                            if ($scope.builds[i].id == elem.id) {
+                                found=true;
+                                // do deep data copy
+                                for (var attr in elem) {
+                                    $scope.builds[i][attr] = elem[attr];
+                                }
+                                break;
+                            }
                             if ($scope.builds[i].id < elem.id) break;
                         }
                         if (!found) {
@@ -272,8 +289,8 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                         var found = false;
                         var i = 0;
                         for (i = 0; i < $scope.builds.length; i ++) {
-                           if ($scope.builds[i].id > elem.id) continue;
-                            if ($scope.builds[i].id == elem.id) { found=true; break;}
+                            if ($scope.builds[i].id > elem.id) continue;
+                            if ($scope.builds[i].id == elem.id) { found=true; break; }
                             if ($scope.builds[i].id < elem.id) break;
                         }
                         if (!found) {
@@ -281,6 +298,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                         }
                     });
 
+
                     $scope.fetchLayersForTargets();
                 }
                 if (_data.targets !== undefined) {
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index 6f31ee0..b8d087a 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -2,8 +2,7 @@
 {% load projecttags %}
 {% load humanize %}
 
-
-{%if len.mru > 0%}
+{%if mru|length > 0%}
   <div class="page-header top-air">
       <h1>
           Latest builds
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 7da2361..a1cce33 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -196,7 +196,7 @@ vim: expandtab tabstop=2
                       <div style="width: {[b.build[0].completeper]}%;" class="bar"></div>
                   </div>
                 </div>
-                <div class="text-right lead">ETA: {[b.build[0].eta|date:"HH:mm:ss"]}</div>
+                <div class="text-right lead">ETA in {[b.build[0].eta|toeta|timediff]}</div>
               </case>
           </case>
 
-- 
1.9.1


