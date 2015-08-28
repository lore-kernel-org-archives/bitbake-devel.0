Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 0462871633
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 16:28:23 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 28 Aug 2015 09:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,425,1437462000"; d="scan'208";a="792839210"
Received: from abityuts-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.11.19])
	by orsmga002.jf.intel.com with ESMTP; 28 Aug 2015 09:28:00 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Aug 2015 17:27:54 +0100
Message-Id: <4ecc69540a5fc01212f45c8e2af91096fc89aa27.1440779114.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1440779114.git.elliot.smith@intel.com>
References: <cover.1440779114.git.elliot.smith@intel.com>
Subject: [PATCH 1/2] toaster: adjust spacing in project pages
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
X-List-Received-Date: Fri, 28 Aug 2015 16:28:24 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Mainly in the top of the page, by adjusting some classes
and the headings.

Also, it removes the commented out tab for the 'My image
recipes' section, since the final designs for image
customisation do not need it.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../templates/baseprojectbuildspage.html           |  2 +-
 .../toastergui/templates/projectbuilds.html        |  6 ++---
 .../toastergui/templates/projecttopbar.html        | 28 +++++++---------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/lib/toaster/toastergui/templates/baseprojectbuildspage.html b/lib/toaster/toastergui/templates/baseprojectbuildspage.html
index 8b043d1..229cd17 100644
--- a/lib/toaster/toastergui/templates/baseprojectbuildspage.html
+++ b/lib/toaster/toastergui/templates/baseprojectbuildspage.html
@@ -6,7 +6,7 @@
 {% include "projecttopbar.html" %}
 
 <!-- Begin main page container -->
-<div class="row-fluid">
+<div>
     {% block projectinfomain %}{% endblock %}
 </div>
 <!-- End main container -->
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index f1db2f1..df809de 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -21,8 +21,7 @@
     });
 </script>
 
-    <div class="page-header">
-      <h1>
+      <h2>
         {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
             {{objects.paginator.count}} build{{objects.paginator.count|pluralize}} found
         {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
@@ -31,8 +30,7 @@
             Project builds
         {%endif%}
         <i class="icon-question-sign get-help heading-help" title="This page lists all the builds for the current project"></i>
-      </h1>
-    </div>
+      </h2>
 
 
  {% if objects.paginator.count == 0 %}
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index 7412e4c..ca2741d 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -17,7 +17,7 @@
   </form>
 </div>
 
-<div class="row-fluid" id="project-topbar">
+<div id="project-topbar">
   <ul class="nav nav-pills">
     <li>
       <a href="{% url 'projectbuilds' project.id %}">
@@ -34,24 +34,14 @@
         Import layer
       </a>
     </li>
-    <!-- Coming soon
-    <li>
-      <a href="my-image-recipes.html">
-        My image recipes
-      </a>
-    </li>
-    -->
     <li class="pull-right">
-
-        <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to the recipe name, like so: <code>busybox:clean</code>">
-        </i>
+      <form class="form-inline" style="margin-bottom:0px;">
+        <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to the recipe name, like so: <code>busybox:clean</code>"></i>
         <div class="input-append">
-          <form class="form-inline" style="margin-bottom: 0">
-            <input id="build-input" type="text" class="input-xlarge input-lg build-target-input" placeholder="Type the recipe you want to build" autocomplete="off" disabled>
-              <button id="build-button" class="btn btn-primary btn-large build-button" data-project-id="{{project.id}}" disabled>Build
-              </button>
-            </form>
-          </div>
-        </li>
-      </ul>
+          <input id="build-input" type="text" class="input-xlarge input-lg build-target-input" placeholder="Type the recipe you want to build" autocomplete="off" disabled>
+          <button id="build-button" class="btn btn-primary btn-large build-button" data-project-id="{{project.id}}" disabled>Build</button>
+        </div>
+      </form>
+    </li>
+  </ul>
 </div>
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


