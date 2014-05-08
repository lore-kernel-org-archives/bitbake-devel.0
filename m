Return-Path: <alexandru.damian@intel.com>
X-Greylist: delayed 313 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 08 May 2014 13:29:45 UTC
Received: from mail-wi0-f169.google.com (unknown [209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 94863609A7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 May 2014 13:29:45 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id hi2so1001336wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 May 2014 06:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jP3rmJyV4zU3/vi+cvI591gnLZZspVi24Mg2cvljiak=;
	b=YFmvQRpnlTlKUO1tqFHhyhUqpQSVwXE+kQGReX0YpZu2lqE0HkwxFRRWjtU23p+62p
	A1/N5sLnYJBKPqWRtywnBTcpRVtLzad2GxOMfxAx9KA1eEPztO210Yfh4C9e3WWmmeVv
	n/5UMnAQjLBUA9LOcF5X9EecaZhitB3o4yKmlbL+W67nu54ZveaobUCZM2SnTXY9JgGp
	JAaZs03GnSgBsR3ws5YrfjqVO+x97AaWITGDfdkeslnZLKwBwF18mvR7PeYfQAxkU8vV
	JIFf6d6Rv2tW5sT+OT1EGPt5mRpbbsPHy53e/o3zX1/x9h7H3reFiv4tNiucYh61+6l7
	5khg==
X-Gm-Message-State: ALoCoQlWi4NPA9vcQ9GpiTSAxKU4l2mN8bMqaSz1TEqxZophufk0ty/VeidjGy8Ibq2ohnqs5wB5
X-Received: by 10.180.218.35 with SMTP id pd3mr12955005wic.26.1399555480059;
	Thu, 08 May 2014 06:24:40 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id gi8sm4203755wib.8.2014.05.08.06.24.37
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 May 2014 06:24:37 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id EE3915603E9; Thu,  8 May 2014 21:24:36 +0800 (HKT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 May 2014 14:24:32 +0100
Message-Id: <e48fcf1750ee6d5d7a070d88be6ab21066873724.1399555312.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
References: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1399555312.git.alexandru.damian@intel.com>
References: <cover.1399555312.git.alexandru.damian@intel.com>
Subject: [PATCH 2/5] toaster: Make sure layer branch only shows when not empty
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
X-List-Received-Date: Thu, 08 May 2014 13:29:50 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the recipe details and package details pages, the layer branch
definition list elements should only show when the branch field in
the database is populated. If the branch field is empty, we don't
show them.

The patch also removes all unnecessary data-toggle and
data-original-title attributes.

[YP #6152]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/dirinfo.html      |  4 ++--
 .../templates/package_built_dependencies.html      |  4 ++--
 .../toastergui/templates/package_built_detail.html |  4 ++--
 .../toastergui/templates/package_detail_base.html  | 21 +++++++++++----------
 .../templates/package_included_tabs.html           |  4 ++--
 lib/toaster/toastergui/templates/recipe.html       | 22 ++++++++++++----------
 lib/toaster/toastergui/templates/target.html       |  4 ++--
 lib/toaster/toastergui/templates/task.html         |  2 +-
 lib/toaster/toastergui/templates/tasks.html        |  2 +-
 9 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/lib/toaster/toastergui/templates/dirinfo.html b/lib/toaster/toastergui/templates/dirinfo.html
index 749ae24..11c709a 100644
--- a/lib/toaster/toastergui/templates/dirinfo.html
+++ b/lib/toaster/toastergui/templates/dirinfo.html
@@ -189,13 +189,13 @@
     <ul class="nav nav-pills">
         <li class="">
             <a href="{% url 'target' build.id target.id %}">
-            <i class="icon-question-sign get-help" data-toggle="tooltip" title="Of all the packages built, the subset installed in the root file system of this image"></i>
+            <i class="icon-question-sign get-help" title="Of all the packages built, the subset installed in the root file system of this image"></i>
                 Packages included ({{target.package_count}} - {{packages_sum|filtered_filesizeformat}})
             </a>
         </li>
         <li class="active">
             <a href="{% url 'dirinfo' build.id target.id %}">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The directories and files in the root file system of this image"></i>
+                <i class="icon-question-sign get-help" title="The directories and files in the root file system of this image"></i>
                 Directory structure
             </a>
         </li>
diff --git a/lib/toaster/toastergui/templates/package_built_dependencies.html b/lib/toaster/toastergui/templates/package_built_dependencies.html
index a0c5a1e..e6f20c3 100644
--- a/lib/toaster/toastergui/templates/package_built_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_built_dependencies.html
@@ -5,13 +5,13 @@
         <ul class="nav nav-pills">
             <li class="">
                 <a href="{% url 'package_built_detail' build.id package.id %}">
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Shows the files produced by this package."></i>
+                    <i class="icon-question-sign get-help" title="Shows the files produced by this package."></i>
                     Generated files ({{package.buildfilelist_package.count}})
                 </a>
             </li>
             <li class="active">
                 <a href="{% url 'package_built_dependencies' build.id package.id %}">
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Shows the runtime packages required by this package."></i>
+                    <i class="icon-question-sign get-help" title="Shows the runtime packages required by this package."></i>
                     Runtime dependencies ({{dependency_count}})
                 </a>
             </li>
diff --git a/lib/toaster/toastergui/templates/package_built_detail.html b/lib/toaster/toastergui/templates/package_built_detail.html
index 0fe0116..9be8ccb 100644
--- a/lib/toaster/toastergui/templates/package_built_detail.html
+++ b/lib/toaster/toastergui/templates/package_built_detail.html
@@ -8,11 +8,11 @@
             {# Not included case #}
             <ul class="nav nav-pills">
                 <li class="active"> <a href="#">
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Files added to a root file system when you include {{package.name}} in an image"></i>
+                    <i class="icon-question-sign get-help" title="Files added to a root file system when you include {{package.name}} in an image"></i>
                     Generated files ({{packageFileCount}})
                 </a></li>
                 <li class=""><a href="{% url 'package_built_dependencies' build.id package.id %}">
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Projected runtime dependencies when you include {{package.name}} in an image"></i>
+                    <i class="icon-question-sign get-help" title="Projected runtime dependencies when you include {{package.name}} in an image"></i>
                     Runtime dependencies ({{dependency_count}})
                 </a></li>
             </ul>
diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index 5888513..cd015d3 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -57,7 +57,7 @@
         <dl>
             <dt>
                 Size
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The size of the package"></i>
+                <i class="icon-question-sign get-help" title="The size of the package"></i>
             </dt>
             <dd>
                 {% comment %}
@@ -74,7 +74,7 @@
 
             <dt>
                 License
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The license under which this package is distributed"></i>
+                <i class="icon-question-sign get-help" title="The license under which this package is distributed"></i>
             </dt>
             <dd>{{package.license}}</dd>
 
@@ -83,14 +83,14 @@
             # problemse are resolved.
             <dt>
                 License files
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="Path to the license files that apply to the package"></i>
+                <i class="icon-question-sign get-help" title="Path to the license files that apply to the package"></i>
             </dt>
             <dd></dd>
             {% endcomment %}
 
             <dt>
                 Recipe
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The name of the recipe building this package"></i>
+                <i class="icon-question-sign get-help" title="The name of the recipe building this package"></i>
             </dt>
             <dd>
                 {% if package.recipe_id > 0 %}
@@ -102,13 +102,13 @@
 
             <dt>
                 Recipe version
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The version of the recipe building this package"></i>
+                <i class="icon-question-sign get-help" title="The version of the recipe building this package"></i>
             </dt>
             <dd>{{package.recipe.version}}</dd>
 
             <dt>
                 Layer
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The name of the layer providing the recipe that builds this package"></i>
+                <i class="icon-question-sign get-help" title="The name of the layer providing the recipe that builds this package"></i>
             </dt>
             <dd>
                 {{package.recipe.layer_version.layer.name}}
@@ -122,21 +122,22 @@
                     {% endcomment %}
                 {% endif %}
             </dd>
-
+            {% if package.recipe.layer_version.branch %}
             <dt>
                 Layer branch
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The Git branch of the layer providing the recipe that builds this package"></i>
+                <i class="icon-question-sign get-help" title="The Git branch of the layer providing the recipe that builds this package"></i>
             </dt>
             <dd>{{package.recipe.layer_version.branch}}</dd>
+            {% endif %}
             <dt>
                 Layer commit
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The Git commit of the layer providing the recipe that builds this package"></i>
+                <i class="icon-question-sign get-help" title="The Git commit of the layer providing the recipe that builds this package"></i>
             </dt>
 
             <dd class="iscommit">{{package.recipe.layer_version.commit}}</dd>
             <dt>
                 Layer directory
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="Path to the layer providing the recipe that builds this package"></i>
+                <i class="icon-question-sign get-help" title="Path to the layer providing the recipe that builds this package"></i>
             </dt>
             <dd><code>{{package.recipe.layer_version.layer.local_path}}</code></dd>
         </dl>
diff --git a/lib/toaster/toastergui/templates/package_included_tabs.html b/lib/toaster/toastergui/templates/package_included_tabs.html
index 0140b03..958aa88 100644
--- a/lib/toaster/toastergui/templates/package_included_tabs.html
+++ b/lib/toaster/toastergui/templates/package_included_tabs.html
@@ -16,7 +16,7 @@
         <li class="">
     {% endif %}
             <a href="{% url 'package_included_dependencies' build.id target.id package.id %}">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="Package runtime dependencies"></i>
+                <i class="icon-question-sign get-help" title="Package runtime dependencies"></i>
                 Runtime dependencies ({{dependency_count}})
             </a>
         </li>
@@ -26,7 +26,7 @@
         <li class="">
     {% endif %}
             <a href="{% url 'package_included_reverse_dependencies' build.id target.id package.id %}">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The package runtime reverse dependencies (i.e. the packages in this image that depend on this package). Reverse dependencies reflect only the 'depends' dependency type"></i>
+                <i class="icon-question-sign get-help" title="The package runtime reverse dependencies (i.e. the packages in this image that depend on this package). Reverse dependencies reflect only the 'depends' dependency type"></i>
                 Reverse runtime dependencies ({{reverse_count}})
             </a>
         </li>
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index 6e9cd23..a830ba9 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -21,25 +21,25 @@
     <ul class="nav nav-pills">
         <li class="active">
             <a href="#information" data-toggle="tab">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="Build-related information about the recipe"></i>
+                <i class="icon-question-sign get-help" title="Build-related information about the recipe"></i>
                 Recipe details
             </a>
         </li>
         <li>
             <a href="#packages-built" data-toggle="tab">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The packaged output resulting from building the recipe"></i>
+                <i class="icon-question-sign get-help" title="The packaged output resulting from building the recipe"></i>
                 Packages ({{packages.count}})
             </a>
         </li>
         <li>
             <a href="#dependencies" data-toggle="tab">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The recipe build-time dependencies (i.e. other recipes)"></i>
+                <i class="icon-question-sign get-help" title="The recipe build-time dependencies (i.e. other recipes)"></i>
                 Build dependencies ({{object.r_dependencies_recipe.all.count}})
             </a>
         </li>
         <li>
             <a href="#brought-in-by" data-toggle="tab">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The recipe build-time reverse dependencies (i.e. the recipes that depend on this recipe)"></i>
+                <i class="icon-question-sign get-help" title="The recipe build-time reverse dependencies (i.e. the recipes that depend on this recipe)"></i>
                 Reverse build dependencies ({{object.r_dependencies_depends.all.count}})
             </a>
         </li>
@@ -48,27 +48,29 @@
         <div class="tab-pane active" id="information" name="information">
             <dl class="dl-horizontal">
                 <dt>
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="The name of the layer providing the recipe"></i>
+                    <i class="icon-question-sign get-help" title="The name of the layer providing the recipe"></i>
                     Layer
                 </dt>
                 <dd>{{layer.name}}</dd>
                 <dt>
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Path to the layer providing the recipe"></i>
+                    <i class="icon-question-sign get-help" title="Path to the layer providing the recipe"></i>
                     Layer directory
                 </dt>
                 <dd><code>{{layer.local_path}}</code></dd>
                 <dt>
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Path to the recipe .bb file"></i>
+                    <i class="icon-question-sign get-help" title="Path to the recipe .bb file"></i>
                     Recipe file
                 </dt>
                 <dd><code>{{object.file_path}}</code></dd>
+                {% if layer_version.branch %}
                 <dt>
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="The Git branch of the layer providing the recipe"></i>
+                    <i class="icon-question-sign get-help" title="The Git branch of the layer providing the recipe"></i>
                     Layer branch
                 </dt>
                 <dd>{{layer_version.branch}}</dd>
+                {% endif %}
                 <dt>
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="The Git commit of the layer providing the recipe"></i>
+                    <i class="icon-question-sign get-help" title="The Git commit of the layer providing the recipe"></i>
                     Layer commit
                 </dt>
                 <dd class="iscommit">{{layer_version.commit}}</dd>
@@ -259,7 +261,7 @@
         {% if object.section %}
             <dt>
             Section
-            <i class="icon-question-sign get-help" data-toggle="tooltip" title="The section in which recipes should be categorized"></i>
+            <i class="icon-question-sign get-help" title="The section in which recipes should be categorized"></i>
             </dt>
             <dd>{{object.section}}</dd>
         {% endif %}
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index 3a0c4d7..86e46dc 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -35,13 +35,13 @@
     <ul class="nav nav-pills">
         <li class="active">
             <a href="#target">
-            <i class="icon-question-sign get-help" data-toggle="tooltip" title="Of all the packages built, the subset installed in the root file system of this image"></i>
+            <i class="icon-question-sign get-help" title="Of all the packages built, the subset installed in the root file system of this image"></i>
                 Packages included ({{target.package_count}} - {{packages_sum|filtered_filesizeformat}})
             </a>
         </li>
         <li>
             <a href="{% url 'dirinfo' build.id target.id %}">
-                <i class="icon-question-sign get-help" data-toggle="tooltip" title="The directories and files in the root file system of this image"></i>
+                <i class="icon-question-sign get-help" title="The directories and files in the root file system of this image"></i>
                 Directory structure
             </a>
         </li>
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 4555999..3c4a3d4 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -46,7 +46,7 @@
 {# not executed tasks outcome #}
     {% if task.outcome == task.OUTCOME_PREBUILT %}
         {% if not showing_matches %}
-            <a class="btn" href="javascript:reload_params({'show_matches' : 'true' })">Match to tasks in previous builds <i class="icon-question-sign get-help" style="margin-top:20px;" data-toggle="tooltip" title="This shows you a list of tasks from previous builds with the same signature generated from the same inputs as used in the prebuilt task. Any of them could be the task that generated the output this prebuilt task is reusing"></i></a>
+            <a class="btn" href="javascript:reload_params({'show_matches' : 'true' })">Match to tasks in previous builds <i class="icon-question-sign get-help" style="margin-top:20px;" title="This shows you a list of tasks from previous builds with the same signature generated from the same inputs as used in the prebuilt task. Any of them could be the task that generated the output this prebuilt task is reusing"></i></a>
         {% elif matching_tasks %}
             <h3 class="details">Prebuilt task could be based on
                 <i class="icon-question-sign get-help heading-help" title="This table shows a list of tasks from previous builds with the same signature generated from the same inputs as used in the prebuilt task. Any of them could be the task that generated the output this prebuilt task is reusing"></i>
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index 77d38b0..d0c6f4e 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -86,7 +86,7 @@
                 <a href="{% url "recipe" build.pk task.recipe.pk %}">{{task.recipe.version}}</a>
             </td>
             <td class="task_name">
-                <a href="{%url "task" build.pk task.pk%} ">{{task.task_name}}</a> {% if task.get_description %}<i class="icon-question-sign get-help hover-help" title="" data-original-title="{{task.get_description}}"></i> {% endif %}
+                <a href="{%url "task" build.pk task.pk%} ">{{task.task_name}}</a> {% if task.get_description %}<i class="icon-question-sign get-help hover-help" title="{{task.get_description}}"></i> {% endif %}
             </td>
             <td class="executed">
                 <a href="{%url "task" build.pk task.pk%} ">{{task.get_executed_display}}</a>
-- 
1.9.1


