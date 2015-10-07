Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 977D576FF2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:23:20 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 07 Oct 2015 06:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="659588619"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 07 Oct 2015 06:23:21 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 070B76A4083;
	Wed,  7 Oct 2015 06:22:22 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:55 +0300
Message-Id: <18decad837a86b220bc549eec432f94f55510fcb.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 10/10] toaster: Modify "New build" button behaviour for cli builds project
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
X-List-Received-Date: Wed, 07 Oct 2015 13:23:20 -0000

From: Elliot Smith <elliot.smith@intel.com>

The "New build" button should only be displayed if there are
user-generated projects, not if there is only the command-line
builds project. (Toaster can't run builds on behalf of the
command-line builds project.)

The "New build" form should also display as if no project has
been set (i.e. show the project and recipe text entries).

Add a variable which tracks the number of non-command-line projects,
then use this to hide the button when appropriate.

Also track whether the current project is the default one, and
use this to add extra conditions to when the "New build" text
entries are shown.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/base.js   |  6 +-
 lib/toaster/toastergui/templates/base.html | 95 +++++++++++++++---------------
 lib/toaster/toastergui/views.py            |  9 ++-
 3 files changed, 59 insertions(+), 51 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 6042a96..ed22a4e 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -121,14 +121,14 @@ function basePageInit(ctx) {
   });
 
   function _checkProjectBuildable() {
-    if (selectedProject.projectId === undefined) {
+    if (selectedProject.projectId === undefined || selectedProject.projectIsDefault) {
       return;
     }
 
     libtoaster.getProjectInfo(selectedProject.projectPageUrl,
       function (data) {
         if (data.machine === null || data.machine.name === undefined || data.layers.length === 0) {
-          /* we can't build anything with out a machine and some layers */
+          /* we can't build anything without a machine and some layers */
           $("#new-build-button #targets-form").hide();
           $("#new-build-button .alert").show();
         } else {
@@ -147,7 +147,7 @@ function basePageInit(ctx) {
     /* If we don't have a current project then present the set project
      * form.
      */
-    if (selectedProject.projectId === undefined) {
+    if (selectedProject.projectId === undefined || selectedProject.projectIsDefault) {
       $('#change-project-form').show();
       $('#project .icon-pencil').hide();
     }
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 3f27790..c1d0693 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -38,6 +38,7 @@
         projectId : {{project.id}},
         projectPageUrl : {% url 'project' project.id as purl %}{{purl|json}},
         projectName : {{project.name|json}},
+        projectIsDefault: {% if project.is_default %}true{% else %}false{% endif %},
         recipesTypeAheadUrl: {% url 'xhr_recipestypeahead' project.id as paturl%}{{paturl|json}},
         layersTypeAheadUrl: {% url 'xhr_layerstypeahead' project.id as paturl%}{{paturl|json}},
         machinesTypeAheadUrl: {% url 'xhr_machinestypeahead' project.id as paturl%}{{paturl|json}},
@@ -48,7 +49,7 @@
         projectId : undefined,
         projectPageUrl : undefined,
         projectName : undefined,
-        projectId : undefined,
+        projectIsDefault: false,
         {% endif %}
       };
     </script>
@@ -122,52 +123,54 @@
           <div class="btn-group pull-right">
             <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
           </div>
-          <!-- New build popover -->
-          <div class="btn-group pull-right" id="new-build-button" style="display:none">
-            <button class="btn dropdown-toggle" data-toggle="dropdown">
-              New build
-              <i class="icon-caret-down"></i>
-            </button>
-            <ul class="dropdown-menu new-build multi-select">
-              <li>
-                <h3>New build</h3>
-                <h6>Project:</h6>
-                <span id="project">
-                  {% if project.id %}
-                  <a class="lead" href="{% project_url project %}">{{project.name}}</a>
-                  {% else %}
-                  <a class="lead" href="#"></a>
-                  {% endif %}
-                  <i class="icon-pencil"></i>
-                </span>
-                <form id="change-project-form" style="display:none;">
-                  <div class="input-append">
-                    <input type="text" class="input-medium" id="project-name-input" placeholder="Type a project name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead"/>
-                    <button id="save-project-button" class="btn" type="button">Save</button>
-                    <a href="#" id="cancel-change-project" class="btn btn-link" style="display: none">Cancel</a>
-                  </div>
-                  <p><a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a></p>
-                </form>
-              </li>
-              <li>
-                <div class="alert" style="display:none;">
-                  <p>This project configuration is incomplete, so you cannot run builds.</p>
-                  <p><a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a></p>
-                </div>
-              </li>
-              <li id="targets-form">
-                <h6>Recipe(s):</h6>
-                <form>
-                  <input type="text" class="input-xlarge build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
-                  <div class="row-fluid">
-                    <button class="btn btn-primary build-button" disabled>Build</button>
+          <!-- New build popover; only shown if there is at least one user-created project -->
+          {% if non_cli_projects.count > 0 %}
+            <div class="btn-group pull-right" id="new-build-button" style="display:none">
+              <button class="btn dropdown-toggle" data-toggle="dropdown">
+                New build
+                <i class="icon-caret-down"></i>
+              </button>
+              <ul class="dropdown-menu new-build multi-select">
+                <li>
+                  <h3>New build</h3>
+                  <h6>
+                    Project:
+                    <span id="project">
+                      {% if project.id and not project.is_default %}
+                        <a class="lead" href="{% project_url project %}">{{project.name}}</a>
+                      {% else %}
+                        <a class="lead" href="#"></a>
+                      {% endif %}
+                      <i class="icon-pencil"></i>
+                    </span>
+                  </h6>
+                  <form id="change-project-form" style="display:none;">
+                    <div class="input-append">
+                      <input type="text" class="input-medium" id="project-name-input" placeholder="Type a project name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead"/>
+                      <button id="save-project-button" class="btn" type="button">Save</button>
+                      <a href="#" id="cancel-change-project" class="btn btn-link" style="display: none">Cancel</a>
+                    </div>
+                    <p><a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a></p>
+                  </form>
+                </li>
+                <li>
+                  <div class="alert" style="display:none;">
+                    <p>This project configuration is incomplete, so you cannot run builds.</p>
+                    <p><a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a></p>
                   </div>
-                </form>
-              </li>
-            </ul>
-          </div>
-
-
+                </li>
+                <li id="targets-form">
+                  <h6>Recipe(s):</h6>
+                  <form>
+                    <input type="text" class="input-xlarge build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
+                    <div class="row-fluid">
+                      <button class="btn btn-primary build-button" disabled>Build</button>
+                    </div>
+                  </form>
+                </li>
+              </ul>
+            </div>
+          {% endif %}
     </div>
  </div>
 </div>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 468cce3..fe13ddf 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1870,10 +1870,15 @@ def image_information_dir(request, build_id, target_id, packagefile_id):
     return redirect(builds)
     # the context processor that supplies data used across all the pages
 
-
+# a context processor which runs on every request; this provides the
+# projects and non_cli_projects (i.e. projects created by the user)
+# variables referred to in templates, which used to determine the
+# visibility of UI elements like the "New build" button
 def managedcontextprocessor(request):
+    projects = Project.objects.all()
     ret = {
-        "projects": Project.objects.all(),
+        "projects": projects,
+        "non_cli_projects": projects.exclude(is_default=True),
         "DEBUG" : toastermain.settings.DEBUG,
         "CUSTOM_IMAGE" : toastermain.settings.CUSTOM_IMAGE,
         "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
-- 
2.1.4


