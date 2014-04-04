Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id B20646E221
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:11:01 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id hm4so2722719wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=UYALM8rpX9/WV0Gzcf1CB+vkDznfOBdmt3ltfI4o1WI=;
	b=OtVK6vu5HhWo7BM70Ew2t7u5rqfVoXbw66A/QHQfRBqqdLsU0X/A4eRntHp0UbZC2v
	fCR3cJ+WjuLVCnBLrlfAzwEI/3XCXPuOb0qIQEKpttaTJRObArwjBGcjPYzBy8efgGpT
	J0tnHXDCLVXwEQW7wOpFIM/cYsIVxG6ecPW7uJrdd43aWEJUaXhA/Md0NlhShxH6SUAw
	Vc7qtgdUT/3uSY69mOWC2tLnCn7QcCG9d1nLWPf8oa+QgwltH+U4C1RrUthrMMgctWKH
	uGcDwMsQ16KlPb6vH1Chq4rLDHGOJUdNEZR2IntCitWmi4SV3VnJUPn+GvIoG5/Sk523
	9HQQ==
X-Gm-Message-State: ALoCoQkzP1i6AND4Mi4OhYO+xxWJEqlLA3paAbR7kNQdcFr5CzktmKNuMNWPs25/Nz6HRo6ny43m
X-Received: by 10.180.98.165 with SMTP id ej5mr4837399wib.33.1396620661668;
	Fri, 04 Apr 2014 07:11:01 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id b2sm4903581wiz.15.2014.04.04.07.10.57
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:11:00 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 95410560D8F; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:51 +0100
Message-Id: <e4bb38e9db3948f6cb9677730c92f09093582228.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Subject: [PATCH 12/14] toaster: Fixes to the build dashboard
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
X-List-Received-Date: Fri, 04 Apr 2014 14:11:03 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

* Add "on" before the date in the build status

* Get rid of the extra space before the "and" in the
build status

* Make the errors and warnings links in the build
status show the message content

* Make sure that the "Images" section in the left navigation
appears only for successful builds

* Link the number of packages installed to the "Packages
included" tab in the image information page

* Remove unnecessary inline styles in the dashboard
template

* Make sure target names in the h1 are listed in
alphabetical order

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css      |  1 +
 .../toastergui/templates/basebuildpage.html        |  2 +-
 .../toastergui/templates/builddashboard.html       | 30 +++++++++++-----------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index baf70fb..e33f177 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -108,6 +108,7 @@ select { width: auto; }
 .hero-unit { margin: 20px 0 30px; }
 .hero-unit > .close { font-size:40px; }
 .hero-actions { margin-top: 30px; }
+.dashboard-section { background-color: transparent; }
 
 /* make tables Chrome-happy (me, not so much) */
 #otable { table-layout: fixed; word-wrap: break-word; }
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 778c4d4..4611051 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -32,7 +32,7 @@
         <!-- begin left sidebar container -->
         <div id="nav" class="span2">
             <ul class="nav nav-list well">
-              {% if build.target_set.all.0.is_image %}
+              {% if build.target_set.all.0.is_image and build.outcome == 0 %}
                 <li class="nav-header">Images</li>
                 {% block nav-target %}
                   {% for t in build.get_sorted_target_list %}
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index cc92af5..891d860 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -10,7 +10,7 @@
 <!-- page title -->
 <div class="row-fluid span10">
  <div class="page-header">
-     <h1>{{build.target_set.all|join:", "}} {{build.machine}}</h1>
+     <h1>{{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}}</h1>
  </div>
 </div>
 
@@ -20,7 +20,7 @@
     <div class="row-fluid lead">
             <span class="pull-left"><strong>
                 {%if build.outcome == build.SUCCEEDED%}Completed{%elif build.outcome == build.FAILED%}Failed{%else%}{%endif%}
-              </strong>
+              </strong> on
             {{build.completed_on|date:"d/m/y H:i"}}
 </span>
 {% if  build.warnings_no or build.errors_no %}
@@ -28,13 +28,13 @@
 {% endif %}
 {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
 {% if  build.errors_no %}
-     <span > <i class="icon-minus-sign red"></i><strong><a href="#errors" class="error"> {{build.errors_no}} error{{build.errors_no|pluralize}}</a></strong></span>
+     <span > <i class="icon-minus-sign red"></i><strong><a href="#errors" class="error show-errors"> {{build.errors_no}} error{{build.errors_no|pluralize}}</a></strong></span>
 {% endif %}
 {% if  build.warnings_no %}
 {% if  build.errors_no %}
-&nbsp;and
+    and
 {% endif %}
-    <span > <i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
+    <span > <i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning show-warnings"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
 {% endif %}
             <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a></span>
 {%endif%}
@@ -75,27 +75,27 @@
 	<h2>Images</h2>
 	{% for target in targets %}
         {% if target.target.is_image %}
-	<div class="well" style="background-color:transparent;">
+	<div class="well dashboard-section">
 		<h3><a href="{% url 'target' build.pk target.target.pk %}">{{target.target}}</a>
                 </h3>
 		<dl class="dl-horizontal">
 			<dt>Packages included</dt>
-			<dd><a href="{% url 'packages' build.pk %}">{{target.npkg}}</a></dd>
+			<dd><a href="{% url 'target' build.pk target.target.pk %}">{{target.npkg}}</a></dd>
 			<dt>Total package size</dt>
 			<dd>{{target.pkgsz|filtered_filesizeformat}}</dd>
 			<dt>
-				<i class="icon-question-sign get-help" title="Path to the license manifest, which is a document listing all packages installed in your image and their licenses"></i>
-				License manifest
+				<i class="icon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></i>
+				<a href="{% url 'target' build.pk target.target.pk %}">License manifest</a>
 			</dt>
-			<dd><a href="{% url 'targetpackages' build.pk target.target.pk %}"><code>{{target.target.license_manifest_path}}</code></a></dd>
+			<dd><code>{{target.target.license_manifest_path}}</code></dd>
 			<dt>
-				<i class="icon-question-sign get-help" title="Image files are stored in <code style='background-color:transparent;color:#FFFFFF;font-weight:normal;border:none;'>/build/tmp/deploy/images/</code>"></i>
+				<i class="icon-question-sign get-help" title="Image files are stored in <code>/build/tmp/deploy/images/</code>"></i>
 				Image files
 			</dt>
 			<dd>
 				<ul>
                                   {% for i in target.imageFiles %}
-					<li><strong>{{i.path}}</strong>
+					<li>{{i.path}}
 					({{i.size|filtered_filesizeformat}})</li>
                                   {% endfor %}
 				</ul>
@@ -114,7 +114,7 @@
 <!-- build summary -->
 <div class="row-fluid span10 pull-right">
 <h2>Build summary</h2>
-    <div class="well span4" style="margin-left:0px; background-color:transparent;">
+    <div class="well span4 dashboard-section" style="margin-left:0px;">
         <h4><a href="{%url 'configuration' build.pk%}">Configuration</a></h4>
             <dl>
         <dt>Machine</dt><dd>{{build.machine}}</dd>
@@ -122,7 +122,7 @@
         <dt>Layers</dt>{% for i in build.layer_version_build.all|dictsort:"layer.name" %}<dd>{{i.layer.name}}</dd>{%endfor%}
             </dl>
     </div>
-    <div class="well span4" style="background-color:transparent;">
+    <div class="well span4 dashboard-section">
         <h4><a href="{%url 'tasks' build.pk%}">Tasks</a></h4>
             <dl>
         <dt>Total number of tasks</dt><dd><a href="{% url 'tasks' build.pk %}">{{build.task_build.all.count}}</a></dd>
@@ -151,7 +151,7 @@
         </dd>
             </dl>
     </div>
-    <div class="well span4" style="background-color:transparent;">
+    <div class="well span4 dashboard-section">
         <h4><a href="{% url 'recipes' build.pk %}">Recipes</a> & <a href="{% url 'packages' build.pk %}">Packages</a></h4>
             <dl>
         <dt>Recipes built</dt><dd><a href="{% url 'recipes' build.pk %}">{{recipecount}}</a></dd>
-- 
1.9.1


