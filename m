Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 058F276AC5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:22:09 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 07 Oct 2015 06:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="821409068"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2015 06:22:09 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id CFDC46A4083;
	Wed,  7 Oct 2015 06:21:11 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:50 +0300
Message-Id: <ef5c6194ac5d7c67c7840fb43a23ef93f4f8f28b.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 05/10] toaster: Hide tabs and add info popups for command line builds
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
X-List-Received-Date: Wed, 07 Oct 2015 13:22:10 -0000

From: Elliot Smith <elliot.smith@intel.com>

Command line builds don't have a configuration or
layers which can be modified through Toaster.

Change the project builds page for the command line builds project,
to hide the tabs and add some info popups in appropriate places on
that page.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/base.js           | 12 ++--
 lib/toaster/toastergui/templates/mrb_section.html  |  4 ++
 .../toastergui/templates/projecttopbar.html        | 80 ++++++++++++----------
 lib/toaster/toastergui/tests.py                    | 41 +++++++++++
 4 files changed, 94 insertions(+), 43 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 895e61b..6042a96 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -6,6 +6,7 @@ function basePageInit(ctx) {
   var newBuildTargetInput;
   var newBuildTargetBuildBtn;
   var projectNameForm = $("#project-name-change-form");
+  var projectNameContainer = $("#project-name-container");
   var projectName = $("#project-name");
   var projectNameFormToggle = $("#project-change-form-toggle");
   var projectNameChangeCancel = $("#project-name-change-cancel");
@@ -23,24 +24,21 @@ function basePageInit(ctx) {
   /* Project name change functionality */
   projectNameFormToggle.click(function(e){
     e.preventDefault();
-
-    $(this).add(projectName).hide();
+    projectNameContainer.hide();
     projectNameForm.fadeIn();
   });
 
   projectNameChangeCancel.click(function(e){
     e.preventDefault();
-
     projectNameForm.hide();
-    projectName.add(projectNameFormToggle).fadeIn();
+    projectNameContainer.fadeIn();
   });
 
   $("#project-name-change-btn").click(function(e){
     var newProjectName = $("#project-name-change-input").val();
 
-    libtoaster.editCurrentProject({ projectName: newProjectName },function (){
-
-      projectName.text(newProjectName);
+    libtoaster.editCurrentProject({ projectName: newProjectName }, function (){
+      projectName.html(newProjectName);
       libtoaster.ctx.projectName = newProjectName;
       projectNameChangeCancel.click();
     });
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index b29f650..53f40d0 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -8,6 +8,10 @@
   {%if mrb_type == 'project' %}
       <h2>
       Latest project builds
+
+      {% if project.is_default %}
+          <i class="icon-question-sign get-help heading-help" title="" data-original-title="Builds in this project cannot be started from Toaster: they are started from the command line"></i>
+      {% endif %}
       </h2>
   {% else %}
     <div class="page-header">
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index a3d1b88..ee86b54 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -5,8 +5,14 @@
 
 <!-- project name -->
 <div class="page-header">
-  <h1><span id="project-name">{{project.name}}</span>
+  <h1 id="project-name-container">
+    <span id="project-name">{{project.name}}</span>
+
     <i class="icon-pencil" data-original-title="" id="project-change-form-toggle" title=""></i>
+
+    {% if project.is_default %}
+        <i class="icon-question-sign get-help heading-help" title="" data-original-title="This project shows information about the builds you start from the command line while Toaster is running"></i>
+    {% endif %}
   </h1>
   <form id="project-name-change-form" style="margin-bottom: 0px; display: none;">
     <div class="input-append">
@@ -17,38 +23,40 @@
   </form>
 </div>
 
-<div id="project-topbar">
-  <ul class="nav nav-pills">
-    <li>
-      <a href="{% url 'projectbuilds' project.id %}">
-        Builds (<span class="total-builds">0</span>)
-      </a>
-    </li>
-    <li id="topbar-configuration-tab">
-      <a href="{% url 'project' project.id %}">
-        Configuration
-      </a>
-    </li>
-    <li>
-      <a href="{% url 'importlayer' project.id %}">
-        Import layer
-      </a>
-    </li>
-    {% if CUSTOM_IMAGE %}
-    <li>
-      <a href="{% url 'newcustomimage' project.id %}">
-        New custom image
-      </a>
-    </li>
-    {% endif %}
-    <li class="pull-right">
-      <form class="form-inline" style="margin-bottom:0px;">
-        <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to the recipe name, like so: <code>busybox:clean</code>"></i>
-        <div class="input-append">
-          <input id="build-input" type="text" class="input-xlarge input-lg build-target-input" placeholder="Type the recipe you want to build" autocomplete="off" disabled>
-          <button id="build-button" class="btn btn-primary btn-large build-button" data-project-id="{{project.id}}" disabled>Build</button>
-        </div>
-      </form>
-    </li>
-  </ul>
-</div>
+{% if not project.is_default %}
+  <div id="project-topbar">
+    <ul class="nav nav-pills">
+      <li>
+        <a href="{% url 'projectbuilds' project.id %}">
+          Builds (<span class="total-builds">0</span>)
+        </a>
+      </li>
+      <li id="topbar-configuration-tab">
+        <a href="{% url 'project' project.id %}">
+          Configuration
+        </a>
+      </li>
+      <li>
+        <a href="{% url 'importlayer' project.id %}">
+          Import layer
+        </a>
+      </li>
+      {% if CUSTOM_IMAGE %}
+      <li>
+        <a href="{% url 'newcustomimage' project.id %}">
+          New custom image
+        </a>
+      </li>
+      {% endif %}
+      <li class="pull-right">
+        <form class="form-inline" style="margin-bottom:0px;">
+          <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to the recipe name, like so: <code>busybox:clean</code>"></i>
+          <div class="input-append">
+            <input id="build-input" type="text" class="input-xlarge input-lg build-target-input" placeholder="Type the recipe you want to build" autocomplete="off" disabled>
+            <button id="build-button" class="btn btn-primary btn-large build-button" data-project-id="{{project.id}}" disabled>Build</button>
+          </div>
+        </form>
+      </li>
+    </ul>
+  </div>
+{% endif %}
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 12a91c3..0d56ab2 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -596,8 +596,18 @@ class ProjectBuildsPageTests(TestCase):
                                          bitbake_version=bbv)
         self.project1 = Project.objects.create_project(name=PROJECT_NAME,
                                                        release=release)
+        self.project1.save()
+
         self.project2 = Project.objects.create_project(name=PROJECT_NAME,
                                                        release=release)
+        self.project2.save()
+
+        self.default_project = Project.objects.create_project(
+            name=CLI_BUILDS_PROJECT_NAME,
+            release=release
+        )
+        self.default_project.is_default = True
+        self.default_project.save()
 
         # parameters for builds to associate with the projects
         now = timezone.now()
@@ -630,6 +640,13 @@ class ProjectBuildsPageTests(TestCase):
             "outcome": Build.IN_PROGRESS
         }
 
+        self.default_project_build_success = {
+            "project": self.default_project,
+            "started_on": now,
+            "completed_on": now,
+            "outcome": Build.SUCCEEDED
+        }
+
     def _get_rows_for_project(self, project_id):
         """ Helper to retrieve HTML rows for a project """
         url = reverse("projectbuilds", args=(project_id,))
@@ -681,6 +698,30 @@ class ProjectBuildsPageTests(TestCase):
         result = re.findall('^ +bash:clean$', response.content, re.MULTILINE)
         self.assertEqual(len(result), 2)
 
+    def test_cli_builds_hides_tabs(self):
+        """
+        Display for command line builds should hide tabs;
+        note that the latest builds section is already tested in
+        AllBuildsPageTests, as the template is the same
+        """
+        url = reverse("projectbuilds", args=(self.default_project.id,))
+        response = self.client.get(url, follow=True)
+        soup = BeautifulSoup(response.content)
+        tabs = soup.select('#project-topbar')
+        self.assertEqual(len(tabs), 0,
+                         'should be no top bar shown for command line builds')
+
+    def test_non_cli_builds_has_tabs(self):
+        """
+        Non-command-line builds projects should show the tabs
+        """
+        url = reverse("projectbuilds", args=(self.project1.id,))
+        response = self.client.get(url, follow=True)
+        soup = BeautifulSoup(response.content)
+        tabs = soup.select('#project-topbar')
+        self.assertEqual(len(tabs), 1,
+                         'should be a top bar shown for non-command-line builds')
+
 class AllBuildsPageTests(TestCase):
     """ Tests for all builds page /builds/ """
 
-- 
2.1.4


