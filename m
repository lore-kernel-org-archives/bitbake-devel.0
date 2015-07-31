Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8625673D13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:35 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 31 Jul 2015 05:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; 
	d="scan'208,217";a="759163361"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2015 05:09:35 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id C34FF6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:49 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:04 +0300
Message-Id: <3655998b693cef79f58e9164d8a9602f9aeb66b4.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 03/22] bitbake: toastergui: base Fix html indentation
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:35 -0000

From: Michael Wood <michael.g.wood@intel.com>

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/templates/base.html | 240 ++++++++++++++---------------
 1 file changed, 120 insertions(+), 120 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 6c3e1a3..8def2da 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -10,54 +10,54 @@
 <link rel="stylesheet" href="{% static 'css/prettify.css' %}" type='text/css'/>
 <link rel="stylesheet" href="{% static 'css/default.css' %}" type='text/css'/>
 
-<meta name="viewport" content="width=device-width, initial-scale=1.0" />
-<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
-<script src="{% static 'js/jquery-2.0.3.min.js' %}">
-</script>
-<script src="{% static 'js/jquery.cookie.js' %}">
-</script>
-<script src="{% static 'js/bootstrap.min.js' %}">
-</script>
-<script src="{% static 'js/prettify.js' %}">
-</script>
-<script src="{% static 'js/libtoaster.js' %}">
-</script>
-{% if DEBUG %}
-<script>
-  libtoaster.debug = true;
- </script>
-{% endif %}
-<script>
-  libtoaster.ctx = {
-    jsUrl : "{% static 'js/' %}",
-    htmlUrl : "{% static 'html/' %}",
-    projectsUrl : "{% url 'all-projects' %}",
-    {% if project.id %}
-      projectId : {{project.id}},
-      projectPageUrl : {% url 'project' project.id as purl%}{{purl|json}},
-      projectName : {{project.name|json}},
-      projectTargetsUrl: {% url 'projectavailabletargets' project.id as paturl%}{{paturl|json}},
-      projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
-      projectId : {{project.id}},
-    {% else %}
-      projectId : undefined,
-      projectPageUrl : undefined,
-      projectName : undefined,
-      projectId : undefined,
+    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
+    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
+    <script src="{% static 'js/jquery-2.0.3.min.js' %}">
+    </script>
+    <script src="{% static 'js/jquery.cookie.js' %}">
+    </script>
+    <script src="{% static 'js/bootstrap.min.js' %}">
+    </script>
+    <script src="{% static 'js/prettify.js' %}">
+    </script>
+    <script src="{% static 'js/libtoaster.js' %}">
+    </script>
+    {% if DEBUG %}
+    <script>
+      libtoaster.debug = true;
+    </script>
     {% endif %}
-  };
-</script>
-<script src="{% static 'js/base.js' %}"></script>
-<script>
-  $(document).ready(function () {
-    /* Vars needed for base.js */
-    var ctx = {};
-    ctx.numProjects = {{projects|length}};
-    ctx.currentUrl = "{{request.path|escapejs}}";
+    <script>
+      libtoaster.ctx = {
+        jsUrl : "{% static 'js/' %}",
+        htmlUrl : "{% static 'html/' %}",
+        projectsUrl : "{% url 'all-projects' %}",
+        {% if project.id %}
+        projectId : {{project.id}},
+        projectPageUrl : {% url 'project' project.id as purl%}{{purl|json}},
+        projectName : {{project.name|json}},
+        projectTargetsUrl: {% url 'projectavailabletargets' project.id as paturl%}{{paturl|json}},
+        projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
+        projectId : {{project.id}},
+        {% else %}
+        projectId : undefined,
+        projectPageUrl : undefined,
+        projectName : undefined,
+        projectId : undefined,
+        {% endif %}
+      };
+    </script>
+    <script src="{% static 'js/base.js' %}"></script>
+    <script>
+      $(document).ready(function () {
+        /* Vars needed for base.js */
+        var ctx = {};
+        ctx.numProjects = {{projects|length}};
+        ctx.currentUrl = "{{request.path|escapejs}}";
 
-    basePageInit(ctx);
-  });
-</script>
+        basePageInit(ctx);
+      });
+    </script>
 
 {% block extraheadcontent %}
 {% endblock %}
@@ -69,80 +69,80 @@
     Loading <i class="fa-pulse icon-spinner"></i>
   </div>
 
-<div class="navbar navbar-fixed-top">
- <div class="navbar-inner">
-   <div class="container-fluid">
-            <a class="brand logo" href="#"><img src="{% static 'img/logo.png' %}" class="" alt="Yocto logo project"/></a>
-            <span class="brand">
-                <a href="/">Toaster</a>
-                {% if DEBUG %}
-                    <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
-                {% endif %}
-            </span>
-<ul class="nav">
-  <li {% if "builds" in  request.path  %}
-       class="active"
-      {% endif %}>
-    <a href="{% url 'all-builds' %}">
-      <i class="icon-tasks"></i>
-      All builds
-    </a>
-  </li>
-  <li {% if "projects" in  request.path  %}
-       class="active"
-      {% endif %}>
-    <a href="{% url 'all-projects' %}">
-      <i class="icon-folder-open"></i>
-      All projects
-    </a>
-  </li>                                                                         </ul>
-            <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
-                <i class="icon-book"></i>
-                Toaster manual
-            </a>
-            <div class="btn-group pull-right">
-                  <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
-            </div>
-            <!-- New build popover -->
-            <div class="btn-group pull-right" id="new-build-button" style="display:none">
-              <button class="btn dropdown-toggle" data-toggle="dropdown">
-                New build
-                <i class="icon-caret-down"></i>
-              </button>
-              <ul class="dropdown-menu new-build multi-select">
-                <li>
-                  <h3>New build</h3>
-                  <h6>Project:</h6>
-                  <span id="project">
-                    {% if project.id %}
-                      <a class="lead" href="{% url 'project' project.id %}">{{project.name}}</a>
-                      <i class="icon-pencil"></i>
-                    {% endif %}
-                  </span>
-                  <form id="change-project-form" style="display:none;">
-                    <div class="input-append">
-                      <input type="text" class="input-medium" id="project-name-input" placeholder="Type a project name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead"/>
-                        <button id="save-project-button" class="btn" type="button">Save</button>
-                        <a href="#" id="cancel-change-project" class="btn btn-link" style="display: none">Cancel</a>
-                      </div>
-                      <p><a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a></p>
-                    </form>
-                  </li>
-                  <li style="display: none">
-                    This project's configuration is incomplete,<br/>so you cannot run builds.<br/>
-                    <p><a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a></p>
-                  </li>
-                  <li id="targets-form">
-                    <h6>Recipe(s):</h6>
-                    <form>
-                      <input type="text" class="input-xlarge build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
-                      <div>
-                        <button class="btn btn-primary" id="build-button" disabled>Build</button>
-                      </div>
-                    </form>
-                  </li>
-              </ul>
-            </div>
+    <div class="navbar navbar-fixed-top">
+      <div class="navbar-inner">
+        <div class="container-fluid">
+          <a class="brand logo" href="#"><img src="{% static 'img/logo.png' %}" class="" alt="Yocto logo project"/></a>
+          <span class="brand">
+            <a href="/">Toaster</a>
+            {% if DEBUG %}
+            <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
+            {% endif %}
+          </span>
+          <ul class="nav">
+            <li {% if "builds" in  request.path  %}
+                class="active"
+                {% endif %}>
+              <a href="{% url 'all-builds' %}">
+                <i class="icon-tasks"></i>
+                All builds
+              </a>
+            </li>
+            <li {% if "projects" in  request.path  %}
+                class="active"
+                {% endif %}>
+              <a href="{% url 'all-projects' %}">
+                <i class="icon-folder-open"></i>
+                All projects
+              </a>
+            </li>                                                                         </ul>
+          <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
+            <i class="icon-book"></i>
+            Toaster manual
+          </a>
+          <div class="btn-group pull-right">
+            <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
+          </div>
+          <!-- New build popover -->
+          <div class="btn-group pull-right" id="new-build-button" style="display:none">
+            <button class="btn dropdown-toggle" data-toggle="dropdown">
+              New build
+              <i class="icon-caret-down"></i>
+            </button>
+            <ul class="dropdown-menu new-build multi-select">
+              <li>
+                <h3>New build</h3>
+                <h6>Project:</h6>
+                <span id="project">
+                  {% if project.id %}
+                  <a class="lead" href="{% url 'project' project.id %}">{{project.name}}</a>
+                  <i class="icon-pencil"></i>
+                  {% endif %}
+                </span>
+                <form id="change-project-form" style="display:none;">
+                  <div class="input-append">
+                    <input type="text" class="input-medium" id="project-name-input" placeholder="Type a project name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead"/>
+                    <button id="save-project-button" class="btn" type="button">Save</button>
+                    <a href="#" id="cancel-change-project" class="btn btn-link" style="display: none">Cancel</a>
+                  </div>
+                  <p><a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a></p>
+                </form>
+              </li>
+              <li style="display: none">
+                This project's configuration is incomplete,<br/>so you cannot run builds.<br/>
+                <p><a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a></p>
+              </li>
+              <li id="targets-form">
+                <h6>Recipe(s):</h6>
+                <form>
+                  <input type="text" class="input-xlarge build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
+                  <div>
+                    <button class="btn btn-primary" id="build-button" disabled>Build</button>
+                  </div>
+                </form>
+              </li>
+            </ul>
+          </div>
 
 
     </div>
-- 
2.1.4


