Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
	[74.125.82.181])
	by mail.openembedded.org (Postfix) with ESMTP id C216D6F8DF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:03 +0000 (UTC)
Received: by mail-we0-f181.google.com with SMTP id q58so1881729wes.26
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vHqDydnxsDo1h5fzOJd6CRjNCvXZGY+6h2vyfIV1asU=;
	b=YKuh4u13Cao2Gw8uRsGsymi2rxrljkjYChhyvX7FctHZgJR5pdTYM8EdNMpXD0nS3q
	yKs7+5wsavjwwz3wCjjb5OtEUZAgMQFVt+Pxsno/iPxJ0J+w5ukSxMVWCn7pHWdMWFpa
	OUMJMmP2XhmyCsmo6Zdu8Ol5pU4eiPHnn5Fifdl3YQWne4mH8auDN+nKCeEg0uFzGMSQ
	G5qN6BDF+zK1xm40FwGqMLLYvYZIbKT5Cl9R9d5ix5RpWwH4SiamdareLiFzqn50TC9p
	xX860qOgyJcII/udIVLMuq/SdBOkyvNntjg1w0+IwvWWesvMD0nTWzuWjrb6TOIBfal+
	i8Bg==
X-Gm-Message-State: ALoCoQna2FfXPj47QtdsfY6VUDxkxURIEvAiVarEHszsMNa6r9e+eEIHkewTXuB8ruSJR2B/hPU/
X-Received: by 10.180.100.169 with SMTP id ez9mr41608639wib.15.1395939004390; 
	Thu, 27 Mar 2014 09:50:04 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fo6sm8808880wib.7.2014.03.27.09.50.02
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:03 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 7C5DD56098A; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:49:54 +0000
Message-Id: <2cb1b8be0d3e6df3b9f46fd52d8b51e25b6d84ee.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
References: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 2/9] toaster: blocks for custom/highlighted navigation and breadcrumb links
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:05 -0000

From: David Reyna <David.Reyna@windriver.com>

Implement the navigation links as blocks so that each page can override and have
its respective link appear highlighted. Make the build breadcrumb a block so that
it is customizable to not be a link for the dashboard page. Reorder the page headers
to be consistent order for extends, projecttags, localbreadcrumb, nav-links.

[YOCTO #5916]
[YOCTO #4258]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 .../toastergui/templates/basebuildpage.html        | 50 ++++++++++++++++------
 lib/toaster/toastergui/templates/bpackage.html     |  6 ++-
 .../toastergui/templates/builddashboard.html       |  4 ++
 .../toastergui/templates/configuration.html        |  6 ++-
 lib/toaster/toastergui/templates/configvars.html   | 10 +++--
 lib/toaster/toastergui/templates/recipes.html      |  4 ++
 lib/toaster/toastergui/templates/target.html       | 10 +++++
 lib/toaster/toastergui/templates/tasks.html        | 30 +++++++++++++
 8 files changed, 101 insertions(+), 19 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 0ce5dbd..778c4d4 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -9,7 +9,13 @@
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
 <li><a href="{% url 'all-builds' %}">All builds</a></li>
-<li><a href="{%url 'builddashboard' build.pk%}">{{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
+            <li>
+            {% block parentbreadcrumb %}
+            <a href="{%url 'builddashboard' build.pk%}">
+                {{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
+            </a>
+            {% endblock %}
+            </li>
             {% block localbreadcrumb %}{% endblock %}
         </ul>
         <script>
@@ -28,19 +34,35 @@
             <ul class="nav nav-list well">
               {% if build.target_set.all.0.is_image %}
                 <li class="nav-header">Images</li>
-            {% for t in build.get_sorted_target_list %}
-                <li><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
-            {% endfor %}
-                  {% endif %}
-                <li class="nav-header">Build</li>
-                <li><a href="{% url 'configuration' build.pk %}">Configuration</a></li>
-                <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
-                <li><a href="{% url 'recipes' build.pk %}">Recipes</a></li>
-                <li><a href="{% url 'packages' build.pk %}">Packages</a></li>
-                <li class="nav-header">Performance</li>
-                <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
-                <li><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
-                <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
+                {% block nav-target %}
+                  {% for t in build.get_sorted_target_list %}
+                    <li><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
+                  {% endfor %}
+                {% endblock %}
+              {% endif %}
+              <li class="nav-header">Build</li>
+              {% block nav-configuration %}
+                  <li><a href="{% url 'configuration' build.pk %}">Configuration</a></li>
+              {% endblock %}
+              {% block nav-tasks %}
+                  <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
+              {% endblock %}
+              {% block nav-recipes %}
+                  <li><a href="{% url 'recipes' build.pk %}">Recipes</a></li>
+              {% endblock %}
+              {% block nav-packages %}
+                  <li><a href="{% url 'packages' build.pk %}">Packages</a></li>
+              {% endblock %}
+                  <li class="nav-header">Performance</li>
+              {% block nav-buildtime %}
+                  <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
+              {% endblock %}
+              {% block nav-cpuusage %}
+                  <li><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
+              {% endblock %}
+              {% block nav-diskio %}
+                  <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
+              {% endblock %}
             </ul>
         </div>
         <!-- end left sidebar container -->
diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index dad0d7f..77f7894 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -6,6 +6,10 @@
 <li>Packages</li>
 {% endblock %}
 
+{% block nav-packages %}
+  <li class="active"><a href="{% url 'packages' build.pk %}">Packages</a></li>
+{% endblock %}
+
 {% block buildinfomain %}
 <div class="span10">
 <div class="page-header">
@@ -30,7 +34,7 @@
         </form>
       </div>
   </div>
-  
+
 {% else %}
 {% include "basetable_top.html" %}
 
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 9d91f40..6563128 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -2,6 +2,10 @@
 {% load humanize %}
 {% load projecttags %}
 
+{% block parentbreadcrumb %}
+{{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
+{% endblock %}
+
 {% block buildinfomain %}
 <!-- page title -->
 <div class="row-fluid span10">
diff --git a/lib/toaster/toastergui/templates/configuration.html b/lib/toaster/toastergui/templates/configuration.html
index 674f896..49a6a89 100644
--- a/lib/toaster/toastergui/templates/configuration.html
+++ b/lib/toaster/toastergui/templates/configuration.html
@@ -1,9 +1,13 @@
 {% extends "basebuildpage.html" %}
+{% load projecttags %}
+
 {% block localbreadcrumb %}
 <li>Configuration</li>
 {% endblock %}
 
-{% load projecttags %}
+{% block nav-configuration %}
+  <li class="active"><a href="{% url 'configuration' build.pk %}">Configuration</a></li>
+{% endblock %}
 
 {% block buildinfomain %}
 <!-- page title -->
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index 24cb2a5..de4940e 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -1,9 +1,13 @@
 {% extends "basebuildpage.html" %}
+{% load projecttags %}
+
 {% block localbreadcrumb %}
 <li>Configuration</li>
 {% endblock %}
 
-{% load projecttags %}
+{% block nav-configuration %}
+  <li class="active"><a href="{% url 'configuration' build.pk %}">Configuration</a></li>
+{% endblock %}
 
 {% block buildinfomain %}
 <!-- page title -->
@@ -30,7 +34,7 @@
 
   <!-- variables -->
   <div id="variables" class="tab-pane">
-  
+
   {% if objects.paginator.count == 0 %}
   <div class="row-fluid">
       <div class="alert">
@@ -41,7 +45,7 @@
         </form>
       </div>
   </div>
-  
+
   {% else %}
   {% include "basetable_top.html" %}
 
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 22c3d1a..907b83d 100755
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -6,6 +6,10 @@
 <li>Recipes</li>
 {% endblock %}
 
+{% block nav-recipes %}
+  <li class="active"><a href="{% url 'recipes' build.pk %}">Recipes</a></li>
+{% endblock %}
+
 {% block buildinfomain %}
 <div class="span10">
 <div class="page-header">
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index 5396b17..ceffada 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -5,6 +5,16 @@
 
 {% load projecttags %}
 
+{% block nav-target %}
+  {% for t in build.get_sorted_target_list %}
+    {% ifequal target.pk t.pk %}
+      <li class="active"><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
+    {% else %}
+      <li><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
+    {% endifequal %}
+  {% endfor %}
+{% endblock %}
+
 {% block buildinfomain %}
 
 <div class="row-fluid span10">
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index ace30de..8c73dc2 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -1,9 +1,39 @@
 {% extends "basebuildpage.html" %}
 {% load projecttags %}
+
 {% block localbreadcrumb %}
 <li>{{title}}</li>
 {% endblock %}
 
+{% block nav-tasks %}
+  {% if 'Tasks' == title %}
+    <li class="active"><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
+  {% else %}
+    <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
+  {% endif %}
+{% endblock %}
+{% block nav-buildtime %}
+  {% if 'Time' == title %}
+    <li class="active"><a href="{% url 'buildtime' build.pk %}">Time</a></li>
+  {% else %}
+    <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
+  {% endif %}
+{% endblock %}
+{% block nav-cpuusage %}
+  {% if 'CPU usage' == title %}
+    <li class="active"><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
+  {% else %}
+    <li><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
+  {% endif %}
+{% endblock %}
+{% block nav-diskio %}
+  {% if 'Disk I/O' == title %}
+    <li class="active"><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
+  {% else %}
+    <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
+  {% endif %}
+{% endblock %}
+
 {% block buildinfomain %}
 <div class="span10">
 <div class="page-header">
-- 
1.8.3.2


