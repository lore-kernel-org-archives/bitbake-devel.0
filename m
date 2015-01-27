Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id BB9AD72D23
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:34 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id em10so2729706wid.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=9i+mCo8jl+nvlakn/42WI7+9++IzgHN6Mo/MMHMHFs8=;
	b=Aeyl5OO2/SOxuzvMQ9YIXIVvuI3rmHQE8WLVbBWBRXOpGPf5qXksW7V5cNUrKqjxUX
	rmaSEKziZiBHj/QOaCSO8SGCZQnFTyI0usa+q1O/v+NnzyW1g8PULxtRmP0nBCWSnX3y
	feyMWMeMWGHFOEmwNd7EFVCJ5iX9TZn9ipsLXnBY/IfDD9Cm2uIcnKOYQyfKgLvKJkql
	m9Ow72AqZBNV5FoFIoEfQWNzfstq83PQJzdLrze7i2OOXX3n+AqXXxWmWsEGuQwkFt3g
	/WC2mxi4hcC1iomeBxmAQa3v7ex28jqOWfeaa7c/QqgMGdE6AQtfIaUG5R3dyzrl5ipy
	1rnA==
X-Gm-Message-State: ALoCoQmPvKd1BtxzgcrpZ1ty8qcB6QOXGUVypDUAHWsQwScYCEjCPlguEqyw0TlFAUO0XfkOuS7f
X-Received: by 10.194.250.5 with SMTP id yy5mr2975189wjc.133.1422368854538;
	Tue, 27 Jan 2015 06:27:34 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id e18sm2030942wjz.27.2015.01.27.06.27.32
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:33 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A38E35617F6; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:22 +0000
Message-Id: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 01/14] toaster: make layouts consistent
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The layer details page should have the same layout as all
other detail pages (recipes, packages). For this to happen,
the basebuilddetailpage.html and baseprojectpage.html
templates should use the same layout, and so should the
layerdetails.html and recipe.html templates.

This patch also capitalises the string 'All layers' in the
breadcrumb of layerdetails.html as all other breadcrumb elements.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/baseprojectpage.html | 12 ++++--------
 lib/toaster/toastergui/templates/layerdetails.html    | 17 ++++-------------
 lib/toaster/toastergui/templates/project.html         |  4 ++--
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index 95a9f47..e140925 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -4,7 +4,7 @@
 {% block pagecontent %}
 
 
- <div class="">
+ <div class="row-fluid">
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
@@ -28,14 +28,10 @@
         </script>
     </div>
 
-    <div>
+    <!-- Begin main page container -->
+    {% block projectinfomain %}{% endblock %}
+    <!-- End main container -->
 
-        <!-- Begin main page container -->
-        {% block projectinfomain %}{% endblock %}
-        <!-- End main container -->
-
-
-    </div>
   </div>
 
 
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 5bed0f8..22e99e0 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -3,7 +3,7 @@
 {% load humanize %}
 {% load static %}
 {% block localbreadcrumb %}
-<li><a href="{% url 'layers' %}">All Layers</a></li>
+<li><a href="{% url 'layers' %}">All layers</a></li>
 <li>
   {{layerversion.layer.name}} ({{layerversion.commit|truncatechars:13}})
 </li>
@@ -63,18 +63,13 @@
 {% endif %}
 
 {% include "layers_dep_modal.html" %}
- <div class="container-fluid top-padded">
-  <div class="row-fluid">
-    <div class="span11">
+  <div class="row-fluid span11">
       <div class="page-header">
         <h1>{{layerversion.layer.name}} <small class="commit" data-toggle="tooltip" title="{{layerversion.commit}}">({{layerversion.commit|truncatechars:13}})</small></h1>
       </div>
-    </div>
   </div>
 
-    <div class="row-fluid">
-    <div class="span7">
-      <div class="tabbable">
+    <div class="row-fluid span7 tabbable">
         <div class="alert alert-info lead" id="alert-area" style="display:none">
           <button type="button" class="close" id="dismiss-alert" data-dismiss="alert">&times;</button>
           <span id="alert-msg"></span>
@@ -91,7 +86,6 @@
             <a data-toggle="tab" href="#machines" id="machines-tab">Machines ({{total_machines}})</a>
           </li>
         </ul>
-      </div>
       <div class="tab-content">
         <span class="button-place">
           {% if layer_in_project == 0 %}
@@ -435,7 +429,7 @@
                   </div>
               </div>
             </div>
-            <div class="row span4 well">
+            <div class="row-fluid span4 well">
               <h2>About {{layerversion.layer.name}}</h2>
               <dl>
 
@@ -480,7 +474,4 @@
            </dl>
          </div>
 
-          </div>
-       </div>
-   </div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index b8579e4..3b75d19 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -91,7 +91,7 @@ vim: expandtab tabstop=2
   <div class="well">
     <form class="build-form" ng-submit="buildNamedTarget()">
       <div class="input-append controls">
-        <input type="text" class="huge span7" placeholder="Type the target(s) you want to build" autocomplete="off" ng-model="targetName" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length"/>
+        <input type="text" class="huge input-xxlarge" placeholder="Type the target(s) you want to build" autocomplete="off" ng-model="targetName" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length"/>
         <button type="submit" class="btn btn-large btn-primary" ng-disabled="!targetName.length">
         Build
         </button>
@@ -337,7 +337,7 @@ vim: expandtab tabstop=2
       <p class="link-action">
             <a href="{% url 'projectconf' project.id %}" class="link">Edit configuration variables</a>
             <i data-original-title="You can set other project configuration options here. Each option, like everything else in the build system, is a variable - value pair" class="icon-question-sign get-help heading-help" title=""></i>
-			</p>
+            </p>
     </div>
   </div>
 
-- 
1.9.1


