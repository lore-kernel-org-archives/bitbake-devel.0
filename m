Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 9004D731BD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; 
	d="scan'208,217";a="1015672944"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:43 -0700
Message-Id: <02d0fe25d3c640048b3faecae4ddf44df9517c14.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 02/17] toaster: display Target targets in build dashboard
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:55 -0000

From: Elliot Smith <elliot.smith@intel.com>

The build dashboard was showing the targets for the build in the page
heading and title as "Target object".

Add a filter which extracts the "target" from each Target object
as a string so that the heading and title display correctly.

Also sort the image file suffixes alphabetically.

[YOCTO #8556]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/toastergui/templates/builddashboard.html   |  9 +++++----
 .../toastergui/templatetags/field_values_filter.py     | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templatetags/field_values_filter.py

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 04a57ef..dcda2a8 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -1,8 +1,9 @@
 {% extends "basebuildpage.html" %}
 {% load humanize %}
 {% load projecttags %}
+{% load field_values_filter %}
 
-{% block title %} {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
+{% block title %} {{build.get_sorted_target_list|field_values:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block parentbreadcrumb %}
 {% if build.get_sorted_target_list.count > 0 %}
   {{build.get_sorted_target_list.0.target}}
@@ -15,7 +16,7 @@
 <!-- page title -->
 <div class="col-md-10">
  <div class="page-header build-data">
-     <h1>{{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}}</h1>
+     <h1>{{build.get_sorted_target_list|field_values:"target"|join:", "}} {{build.machine}}</h1>
  </div>
 
 <!-- build result bar -->
@@ -113,7 +114,7 @@
             </dt>
             <dd>
                 <ul class="list-unstyled">
-                    {% for i in target.imageFiles %}
+                    {% for i in target.imageFiles|dictsort:"suffix" %}
                         <li>
                             <a href="{% url 'build_artifact' build.pk 'imagefile' i.id %}">
                                 {{i.suffix}}
@@ -261,7 +262,7 @@
         if (location.href.search('#warnings') > -1) {
             $('#warning-info').addClass('in');
         }
-	
+
 	//show warnings section when requested from the build outcome
 	$(".show-warnings").click(function() {
 	    $('#warning-info').addClass('in');
diff --git a/lib/toaster/toastergui/templatetags/field_values_filter.py b/lib/toaster/toastergui/templatetags/field_values_filter.py
new file mode 100644
index 0000000..5a73af7
--- /dev/null
+++ b/lib/toaster/toastergui/templatetags/field_values_filter.py
@@ -0,0 +1,18 @@
+from django import template
+
+register = template.Library()
+
+def field_values(iterable, field):
+    """
+    Convert an iterable of models into a list of strings, one for each model,
+    where the string for each model is the value of the field "field".
+    """
+    objects = []
+
+    if field:
+        for item in iterable:
+            objects.append(getattr(item, field))
+
+    return objects
+
+register.filter('field_values', field_values)
\ No newline at end of file
-- 
1.9.1


