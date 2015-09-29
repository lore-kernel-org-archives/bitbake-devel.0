Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id DE15A76FDE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 07:15:44 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Sep 2015 00:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,606,1437462000"; d="scan'208";a="815244993"
Received: from bdrobeso-mobl3.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.197])
	by orsmga002.jf.intel.com with ESMTP; 29 Sep 2015 00:15:29 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Sep 2015 08:15:19 +0100
Message-Id: <1443510919-9224-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH] bitbake: toaster: display most recent builds for projects
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
X-List-Received-Date: Tue, 29 Sep 2015 07:15:48 -0000

From: David Reyna <David.Reyna@windriver.com>

Display the most recent builds in the given project's build page.

[YOCTO #8186]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../lib/toaster/toastergui/templates/mrb_section.html    | 16 +++++++++++-----
 .../lib/toaster/toastergui/templates/projectbuilds.html  | 10 +++++++---
 bitbake/lib/toaster/toastergui/views.py                  |  3 +++
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/mrb_section.html b/bitbake/lib/toaster/toastergui/templates/mrb_section.html
index b2c49fe..2fefe4b 100644
--- a/bitbake/lib/toaster/toastergui/templates/mrb_section.html
+++ b/bitbake/lib/toaster/toastergui/templates/mrb_section.html
@@ -3,13 +3,19 @@
 {% load humanize %}
 
 
-{%if mru.count > 0%}
+{%if mru and mru.count > 0%}
 
-  <div class="page-header">
+  {%if mrb_type == 'project' %}
+      <h2>
+      Latest project builds
+      </h2>
+  {% else %}
+    <div class="page-header">
       <h1>
-          Latest builds
-       </h1>
-  </div>
+      Latest builds
+      </h1>
+    </div>
+  {% endif %}
   <div id="latest-builds">
   {% for build in mru %}
     <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} project-name ">
diff --git a/bitbake/lib/toaster/toastergui/templates/projectbuilds.html b/bitbake/lib/toaster/toastergui/templates/projectbuilds.html
index fc659a0..fde7e3b 100644
--- a/bitbake/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/bitbake/lib/toaster/toastergui/templates/projectbuilds.html
@@ -21,13 +21,17 @@
     });
 </script>
 
+ {% with mrb_type='project' %}
+     {% include "mrb_section.html" %}
+ {% endwith %}
+
       <h2>
         {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
-            {{objects.paginator.count}} build{{objects.paginator.count|pluralize}} found
+            {{objects.paginator.count}} project build{{objects.paginator.count|pluralize}} found
         {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
-            No builds found
+            No project builds found
         {%else%}
-            Project builds
+            All project builds
         {%endif%}
         <i class="icon-question-sign get-help heading-help" title="This page lists all the builds for the current project"></i>
       </h2>
diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index 8689a12..beaa096 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -2733,6 +2733,9 @@ if True:
         context['project'] = prj
         _set_parameters_values(pagesize, orderby, request)
 
+        # add the most recent builds for this project
+        context['mru'] = _get_latest_builds(prj)
+
         return context
 
 
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


