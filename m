Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9E39573D13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:32 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 31 Jul 2015 05:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="773999946"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2015 05:09:32 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 759986A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:47 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:02 +0300
Message-Id: <98ee3faca3fc39be91912267c633a7a2830e6ce5.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 01/22] bitbake: toastergui: Implement new top navigation design
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:33 -0000

From: Michael Wood <michael.g.wood@intel.com>

Additional items for top level navigation. This is part of a wider
navigation redesign.

[YOCTO #7329]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/css/default.css      |  8 +++++--
 lib/toaster/toastergui/templates/base.html         | 28 +++++++++++++++++++---
 .../templates/basetable_top_projectbuilds.html     | 14 -----------
 lib/toaster/toastergui/templates/projects.html     |  2 +-
 4 files changed, 32 insertions(+), 20 deletions(-)
 delete mode 100644 bitbake/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 9acf1e1..da78f47 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -22,7 +22,7 @@
 .get-help-red { color: #B94A48; font-size: 16px; padding-left: 2px; }
 .get-help-red:hover { color: #943A38; cursor: pointer; }
 .build-form>i:first-of-type { margin-left: 5px; }
-.manual { margin: 11px 15px;}
+.manual { margin: 11px 15px 0 11px;}
 .heading-help { font-size: 14px; }
 
 /* Styles for the external link */
@@ -163,7 +163,7 @@ table { table-layout: fixed; word-wrap: break-word; }
 /* Configuration styles */
 .icon-trash { color: #B94A48; font-size: 16px; padding-left: 5px; }
 .icon-trash:hover { color: #943A38; text-decoration: none; cursor: pointer; }
-.icon-pencil, .icon-download-alt, .icon-refresh, .icon-star-empty, .icon-star, .icon-tasks { font-size: 16px; color: #0088CC; padding-left: 2px; }
+.icon-pencil, .icon-download-alt, .icon-refresh, .icon-star-empty, .icon-star  { font-size: 16px; color: #0088CC; padding-left: 2px; }
 .icon-pencil:hover, .icon-download-alt:hover, .icon-refresh:hover, .icon-star-empty:hover, .icon-star:hover, .icon-tasks:hover { color: #005580; text-decoration: none; cursor: pointer; }
 .icon-share { padding-left: 2px; }
 .alert-success .icon-refresh, .alert-success .icon-tasks { color: #468847; }
@@ -308,3 +308,7 @@ thead .add-del-layers { width: 124px; }
   }
 }
 /* End copied in from newer version of Font-Awesome 4.3.0 */
+
+.top-padded {
+  padding-top: 60px;
+}
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 7430338..b34e6c3 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -69,8 +69,9 @@
     Loading <i class="fa-pulse icon-spinner"></i>
   </div>
 
-<div class="navbar navbar-static-top">
-    <div class="navbar-inner">
+<div class="navbar navbar-fixed-top">
+ <div class="navbar-inner">
+   <div class="container-fluid">
             <a class="brand logo" href="#"><img src="{% static 'img/logo.png' %}" class="" alt="Yocto logo project"/></a>
             <span class="brand">
                 <a href="/">Toaster</a>
@@ -78,6 +79,24 @@
                     <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
                 {% endif %}
             </span>
+<ul class="nav">
+
+  <li {% if "builds" in  request.path  %}
+       class="active"
+      {% endif %}>
+    <a href="{% url 'all-builds' %}">
+      <i class="icon-tasks"></i>
+      All builds
+    </a>
+  </li>
+  <li {% if "projects" in  request.path  %}
+       class="active"
+      {% endif %}>
+    <a href="{% url 'all-projects' %}">
+      <i class="icon-folder-open"></i>
+      All projects
+    </a>
+  </li>                                                                         </ul>
             <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
                 <i class="icon-book"></i>
                 Toaster manual
@@ -128,12 +147,15 @@
 
 
     </div>
+ </div>
 </div>
 
-<div class="container-fluid">
+<div class="container-fluid top-padded">
+<div class="row-fluid">
 {% block pagecontent %}
 {% endblock %}
 </div>
+</div>
 </body>
 </html>
 
diff --git a/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html b/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
deleted file mode 100644
index f5b01c8..0000000
--- a/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
+++ /dev/null
@@ -1,14 +0,0 @@
-{% extends "basetable_top.html" %}
-
-{%block custombuttons %}
-  <div class="btn-group builds-projects">
-    <button class="btn dropdown-toggle" data-toggle="dropdown">
-        <span class="selection">Show all projects</span>
-        <i class="icon-caret-down"></i>
-    </button>
-    <ul class="dropdown-menu">
-        <li><a href="{% url 'all-builds'%}">Show all builds</a></li>
-        <li><a href="{% url 'all-projects'%}">Show all projects</a></li>
-    </ul>
-  </div>
-{%endblock%}
diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index efc3349..c2d77b5 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -34,7 +34,7 @@
     </div>
 
   {% else %} {# We have builds to display #}
-  {% include "basetable_top_projectbuilds.html" %}
+  {% include "basetable_top.html" %}
   {% for o in objects %}
     <tr class="data">
       <td><a href="{% url 'project' o.id %}">{{o.name}}</a></td>
-- 
2.1.4


