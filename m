Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id D638B76E04
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Oct 2015 14:22:16 +0000 (UTC)
Received: by wikq8 with SMTP id q8so254834879wik.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Oct 2015 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel_com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=qN/K7FoCJcPUMVNkGzHENxCfTX0DIEoxrTgqVkoyoMA=;
	b=bv/sjXqHjZ4kDSapvKvyVMsgHF7Bft9Rc5iCMCYmrbYgZ60B1ZCR6AEfXdDnvxeht0
	I3YCr4klQUW4/yciOMjKG8WjkLKhzYJ4wA7SDUmle02CMezhuGsC4KKwWvVpMUSdT7iC
	rpWtqE0xzXCoqsPr+Y2aQiMdKGiutydtwIR3rRLJvzx9Q1OfHS+XVKORqyvdZ1UUnu4r
	5iGi3JWwxNKlTnYczOfgXyuKLtQaqmm1lu2pXOS73a8yVM4ygCXO1oyOfCDprtRS21eI
	ZtDwbbWhuvV9UK//e037WsQ3VpuEQqpKE6qSlFYrD3HWLouM50Pos6lwLIx+nSvGN3BY
	85Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qN/K7FoCJcPUMVNkGzHENxCfTX0DIEoxrTgqVkoyoMA=;
	b=fp+aikBfw9uanau7q7q/H0379+CJKz1ajP26/lX56Vvg61i4Du8i42ozQ8NpYydRqc
	zXVhDPk03240iCKvI4XuUd+vH5GhrkiK7F0yRLLgZmhGHDpplpCI4HsQ7Hcp+IiOYxUm
	b74K5kJMimmCvgfSYIY7gFeE4L5cJ0OAiucmA2PRJqYpLGHeZVlGmIAK+2XHDdUv641L
	qib8Z/K60TTSB3SlciCzNGA1ULO8eRvGaZXJ2K7R2tCc8M36ta4X11thzSVqj2uPYZcd
	JK9Ua7X1oFw+861y9Pctf7EzzPv6IS8iiltX0GgXJIkjplh1YhLg0ZVEVtiBf71PmRFb
	qlyg==
X-Gm-Message-State: ALoCoQlox2bzNY3KPErO4nT2zXcvI/nfXjTmOA9luOAUcdmIgC/RMyw0EZPqqxfYyxscqahg5Pui
X-Received: by 10.194.116.42 with SMTP id jt10mr33521528wjb.117.1446042136771; 
	Wed, 28 Oct 2015 07:22:16 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	d10sm17862545wje.14.2015.10.28.07.22.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 28 Oct 2015 07:22:16 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Oct 2015 14:22:05 +0000
Message-Id: <1446042126-13719-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] toaster: templates Add meaningful title tags
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
X-List-Received-Date: Wed, 28 Oct 2015 14:22:18 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Our title tags are all over the place, and have no relation to the page
content. This commit adds a meaningful title tag to each Toaster page.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/base.html                |  4 +++-
 lib/toaster/toastergui/templates/baseprojectpage.html     |  3 +++
 lib/toaster/toastergui/templates/bpackage.html            |  1 +
 lib/toaster/toastergui/templates/builddashboard.html      |  1 +
 lib/toaster/toastergui/templates/builds.html              |  1 +
 lib/toaster/toastergui/templates/configuration.html       |  1 +
 lib/toaster/toastergui/templates/configvars.html          |  1 +
 lib/toaster/toastergui/templates/dirinfo.html             |  1 +
 lib/toaster/toastergui/templates/importlayer.html         |  1 +
 lib/toaster/toastergui/templates/landing.html             |  1 +
 lib/toaster/toastergui/templates/landing_not_managed.html |  2 ++
 lib/toaster/toastergui/templates/layerdetails.html        |  1 +
 lib/toaster/toastergui/templates/newproject.html          |  3 +++
 lib/toaster/toastergui/templates/package_detail_base.html | 11 +++++++++--
 .../templates/package_included_dependencies.html          |  4 ++--
 .../toastergui/templates/package_included_detail.html     |  4 ++--
 .../templates/package_included_reverse_dependencies.html  |  4 ++--
 lib/toaster/toastergui/templates/project.html             |  1 +
 lib/toaster/toastergui/templates/projectbuilds.html       |  2 +-
 lib/toaster/toastergui/templates/projectconf.html         |  2 +-
 lib/toaster/toastergui/templates/projects.html            |  2 ++
 lib/toaster/toastergui/templates/recipe.html              |  1 +
 lib/toaster/toastergui/templates/recipes.html             |  1 +
 lib/toaster/toastergui/templates/target.html              |  1 +
 lib/toaster/toastergui/templates/task.html                |  1 +
 lib/toaster/toastergui/templates/tasks.html               | 15 ++++++++-------
 .../toastergui/templates/unavailable_artifact.html        |  2 ++
 lib/toaster/toastergui/views.py                           |  2 +-
 28 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index dfa6bba..11ac2a0 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -4,7 +4,9 @@
 {% load project_url_tag %}
 <html lang="en">
     <head>
-        <title>{% if objectname %} {{objectname|title}} - {% endif %}Toaster</title>
+        <title>
+          {% block title %} Toaster {% endblock %}
+        </title>
 <link rel="stylesheet" href="{% static 'css/bootstrap.min.css' %}" type="text/css"/>
 <link rel="stylesheet" href="{% static 'css/bootstrap-responsive.min.css' %}" type='text/css'/>
 <link rel="stylesheet" href="{% static 'css/font-awesome.min.css' %}" type='text/css'/>
diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index 88bf859..1f45be4 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -1,6 +1,9 @@
 {% extends "base.html" %}
 {% load projecttags %}
 {% load humanize %}
+
+{% block title %} {{title}} - {{project.name}} - Toaster {% endblock %}
+
 {% block pagecontent %}
 
 {% include "projecttopbar.html" %}
diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index d775fec..81973cb 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -2,6 +2,7 @@
 
 {% load projecttags %}
 
+{% block title %} Packages built - {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block localbreadcrumb %}
 <li>Packages</li>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index c39fe34..323bbbb 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -2,6 +2,7 @@
 {% load humanize %}
 {% load projecttags %}
 
+{% block title %} {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block parentbreadcrumb %}
 {% if build.get_sorted_target_list.count > 0 %}
   {{build.get_sorted_target_list.0.target}}
diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index 459fcb0..a27a121 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -5,6 +5,7 @@
 {% load project_url_tag %}
 {% load humanize %}
 
+{% block title %} All builds - Toaster {% endblock %}
 {% block extraheadcontent %}
 <link rel="stylesheet" href="/static/css/jquery-ui.min.css" type='text/css'>
 <link rel="stylesheet" href="/static/css/jquery-ui.structure.min.css" type='text/css'>
diff --git a/lib/toaster/toastergui/templates/configuration.html b/lib/toaster/toastergui/templates/configuration.html
index 3e48991..85d6a62 100644
--- a/lib/toaster/toastergui/templates/configuration.html
+++ b/lib/toaster/toastergui/templates/configuration.html
@@ -1,6 +1,7 @@
 {% extends "basebuildpage.html" %}
 {% load projecttags %}
 
+{% block title %} Configuration summary - {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block localbreadcrumb %}
 <li>Configuration</li>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index 8a572ae..e40c225 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -1,6 +1,7 @@
 {% extends "basebuildpage.html" %}
 {% load projecttags %}
 
+{% block title %} BitBake variables - {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block localbreadcrumb %}
 <li>Configuration</li>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/dirinfo.html b/lib/toaster/toastergui/templates/dirinfo.html
index 7819894..ecb46bf 100644
--- a/lib/toaster/toastergui/templates/dirinfo.html
+++ b/lib/toaster/toastergui/templates/dirinfo.html
@@ -1,4 +1,5 @@
 {% extends "basebuildpage.html" %}
+{% block title %} Directory structure - {{ target.target }} {{ build.machine }} - {{ build.project.name }} - Toaster {% endblock %}
 {% block extraheadcontent %}
 {% load static %}
 <link rel="stylesheet" href="{% static 'css/jquery.treetable.css' %}" type="text/css">
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index ce3d724..033f0ae 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -2,6 +2,7 @@
 {% load projecttags %}
 {% load humanize %}
 {% load static %}
+{% block title %} Import layer - {{project.name}} - Toaster {% endblock %}
 {% block pagecontent %}
 
 {% include "projecttopbar.html" %}
diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index 65d8c3c..cafaa1a 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -4,6 +4,7 @@
 {% load projecttags %}
 {% load humanize %}
 
+{% block title %} Welcome to Toaster {% endblock %}
 {% block pagecontent %}
 
   {% if BUILD_MODE %}
diff --git a/lib/toaster/toastergui/templates/landing_not_managed.html b/lib/toaster/toastergui/templates/landing_not_managed.html
index 5bc435d..9b37f55 100644
--- a/lib/toaster/toastergui/templates/landing_not_managed.html
+++ b/lib/toaster/toastergui/templates/landing_not_managed.html
@@ -4,6 +4,8 @@
 {% load projecttags %}
 {% load humanize %}
 
+{% block title %} Welcome to Toaster {% endblock %}
+
 {% block pagecontent %}
 
   <div class="container-fluid">
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 7dd3db2..7fe365d 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -3,6 +3,7 @@
 {% load humanize %}
 {% load static %}
 
+{% block title %} {{layerversion.layer.name}} - {{project.name}} - Toaster {% endblock %}
 {% block pagecontent %}
 
 <div class="section">
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index 997390b..e83b2be 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -1,6 +1,9 @@
 {% extends "base.html" %}
 {% load projecttags %}
 {% load humanize %}
+
+{% block title %} Create a new project - Toaster {% endblock %}
+
 {% block pagecontent %}
 <div class="row-fluid">
     <div class="page-header">
diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index a24bc8e..9fa28a8 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -1,6 +1,13 @@
 {% extends "basebuilddetailpage.html" %}
 {% load projecttags %}
 
+{% block title %}
+  {% if target %}
+    {{package.fullpackagespec}} - {{ target.target }} {{ build.machine }} - {{ build.project.name }} - Toaster
+  {% else %}
+    {{package.fullpackagespec}} - {{ build.target_set.all|dictsort:"target"|join:", " }} {{ build.machine }} - {{ build.project.name }} - Toaster
+  {% endif %}
+{% endblock %}
 {% block extraheadcontent %}
     <!-- functions to format package 'installed_package' alias -->
     <script>
@@ -38,9 +45,9 @@
 {% block pagedetailinfomain %}
     <div class="row span11">
         <div class="page-header">
-            {% block title %}
+            {% block mainheading %}
             <h1>{{package.fullpackagespec}}</h1>
-            {% endblock title %}
+            {% endblock %}
         </div> <!-- page-header -->
     </div> <!-- row span11 page-header -->
 
diff --git a/lib/toaster/toastergui/templates/package_included_dependencies.html b/lib/toaster/toastergui/templates/package_included_dependencies.html
index 642ca69..8a0508e 100644
--- a/lib/toaster/toastergui/templates/package_included_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_dependencies.html
@@ -1,13 +1,13 @@
 {% extends "package_detail_base.html" %}
 {% load projecttags %}
 
-{% block title %}
+{% block mainheading %}
     <h1>
         {{package.fullpackagespec}}
         <script> fmtAliasHelp("{{package.name}}", "{{package.alias}}", false) </script>
         <small>({{target.target}})</small>
     </h1>
-{% endblock title %}
+{% endblock %}
 
 {% block tabcontent %}
     {% with packageFileCount=package.buildfilelist_package.count %}
diff --git a/lib/toaster/toastergui/templates/package_included_detail.html b/lib/toaster/toastergui/templates/package_included_detail.html
index d2aa26e..568e2f2 100644
--- a/lib/toaster/toastergui/templates/package_included_detail.html
+++ b/lib/toaster/toastergui/templates/package_included_detail.html
@@ -1,7 +1,7 @@
 {% extends "package_detail_base.html" %}
 {% load projecttags %}
 
-{% block title %}
+{% block mainheading %}
         <h1>
             {{package.fullpackagespec}}
             <script>
@@ -9,7 +9,7 @@
             </script>
             <small>({{target.target}})</small>
         </h1>
-{% endblock title %}
+{% endblock %}
 
 {% block tabcontent %}
 {% with packageFileCount=package.buildfilelist_package.count %}
diff --git a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
index 5cc8b47..fb310c7 100644
--- a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
@@ -1,13 +1,13 @@
 {% extends "package_detail_base.html" %}
 {% load projecttags %}
 
-{% block title %}
+{% block mainheading %}
         <h1>
             {{package.fullpackagespec}}
             <script> fmtAliasHelp("{{package.name}}", "{{package.alias}}", false) </script>
             <small>({{target.target}})</small>
         </h1>
-{% endblock title %}
+{% endblock %}
 
 {% block tabcontent %}
     {% with packageFileCount=package.buildfilelist_package.count %}
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 2f978bc..4e83981 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -4,6 +4,7 @@
 {% load humanize %}
 {% load static %}
 
+{% block title %} Configuration - {{project.name}} - Toaster {% endblock %}
 {% block projectinfomain %}
 
 <script src="{% static 'js/layerDepsModal.js' %}"></script>
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index fde7e3b..bb38284 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -2,7 +2,7 @@
 {% load projecttags %}
 {% load humanize %}
 
-
+{% block title %} Builds - {{project.name}} - Toaster {% endblock %}
 {% block extraheadcontent %}
 <link rel="stylesheet" href="/static/css/jquery-ui.min.css" type='text/css'>
 <link rel="stylesheet" href="/static/css/jquery-ui.structure.min.css" type='text/css'>
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 5333ec5..30fd03e 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -2,7 +2,7 @@
 {% load projecttags %}
 {% load humanize %}
 
-
+{% block title %} BitBake variables - {{project.name}} - Toaster {% endblock %}
 {% block projectinfomain %}
 
 <h2>Bitbake variables</h2>
diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index 7c612e8..678a796 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -5,6 +5,8 @@
 {% load project_url_tag %}
 {% load humanize %}
 
+{% block title %} All projects - Toaster {% endblock %}
+
 {% block pagecontent %}
 
 
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index b5e4192..c6ae2f3 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -2,6 +2,7 @@
 
 {% load projecttags %}
 
+{% block title %} {{object.name}}_{{object.version}} - {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block localbreadcrumb %}
 <li><a href="{% url 'recipes' build.pk %}">Recipes</a></li>
 <li>{{object.name}}_{{object.version}} </li>
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 5cdac43..d144893 100644
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -2,6 +2,7 @@
 
 {% load projecttags %}
 
+{% block title %} Recipes - {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block localbreadcrumb %}
 <li>Recipes</li>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index 65e6c4a..4c33eaa 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -1,4 +1,5 @@
 {% extends "basebuildpage.html" %}
+{% block title %} Packages included - {{ target.target }} {{ target.build.machine }} - {{ target.build.project.name }} - Toaster {% endblock %}
 {% block localbreadcrumb %}
 <li>{{target.target}}</li>
 {% endblock localbreadcrumb%}
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 635098a..ef628d9 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -3,6 +3,7 @@
 {% load projecttags %}
 {% load humanize %}
 
+{% block title %} {{task.recipe.name}}_{{task.recipe.version}} {{task.task_name}} - {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block localbreadcrumb %}
 <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
 <li>{{task.recipe.name}}_{{task.recipe.version}} {{task.task_name}}</li>
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index b18b5c7..353410f 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -1,33 +1,34 @@
 {% extends "basebuildpage.html" %}
 {% load projecttags %}
 
+{% block title %} {{mainheading}} - {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster{% endblock %}
 {% block localbreadcrumb %}
-<li>{{title}}</li>
+<li>{{mainheading}}</li>
 {% endblock %}
 
 {% block nav-tasks %}
-  {% if 'Tasks' == title %}
+  {% if 'Tasks' == mainheading %}
     <li class="active"><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
   {% else %}
     <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
   {% endif %}
 {% endblock %}
 {% block nav-buildtime %}
-  {% if 'Time' == title %}
+  {% if 'Time' == mainheading %}
     <li class="active"><a href="{% url 'buildtime' build.pk %}">Time</a></li>
   {% else %}
     <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
   {% endif %}
 {% endblock %}
 {% block nav-cpuusage %}
-  {% if 'CPU usage' == title %}
+  {% if 'CPU usage' == mainheading %}
     <li class="active"><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
   {% else %}
     <li><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
   {% endif %}
 {% endblock %}
 {% block nav-diskio %}
-  {% if 'Disk I/O' == title %}
+  {% if 'Disk I/O' == mainheading %}
     <li class="active"><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
   {% else %}
     <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
@@ -39,7 +40,7 @@
 {% if not request.GET.filter and not request.GET.search and not objects.paginator.count %}
   <!-- Empty - no data in database -->
   <div class="page-header">
-  <h1>{{title}}</h1>
+  <h1>{{mainheading}}</h1>
   </div>
   <div class="alert alert-info lead">
   No data was recorded for this build.
@@ -54,7 +55,7 @@
   {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
       No tasks found
   {%else%}
-      {{title}}
+      {{mainheading}}
   {%endif%}
   </h1>
   </div>
diff --git a/lib/toaster/toastergui/templates/unavailable_artifact.html b/lib/toaster/toastergui/templates/unavailable_artifact.html
index b9f8fee..0301a6c 100644
--- a/lib/toaster/toastergui/templates/unavailable_artifact.html
+++ b/lib/toaster/toastergui/templates/unavailable_artifact.html
@@ -3,6 +3,8 @@
 {% load humanize %}
 {% load static %}
 
+{% block title %} Build artifact no longer exists - Toaster {% endblock %}
+
 {% block pagecontent %}
 
 <div class="row-fluid air">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6ebb6a9..0e255f1 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1236,7 +1236,7 @@ def tasks_common(request, build_id, variant, task_anchor):
     context = { 'objectname': variant,
                 'object_search_display': object_search_display,
                 'filter_search_display': filter_search_display,
-                'title': title_variant,
+                'mainheading': title_variant,
                 'build': build,
                 'objects': task_objects,
                 'default_orderby' : orderby,
-- 
2.1.4


