Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8765C76FD7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:23:00 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 07 Oct 2015 06:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="821306408"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 07 Oct 2015 06:23:00 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 2B72F6A4083;
	Wed,  7 Oct 2015 06:22:01 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:53 +0300
Message-Id: <dccd90f35aaa1d66eec03259fc14bce26fd2f1c2.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 08/10] toaster: Clean up template code
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
X-List-Received-Date: Wed, 07 Oct 2015 13:23:00 -0000

From: Elliot Smith <elliot.smith@intel.com>

Some errors in the HTML template didn't show up until
they were rendering command line builds.

One useless conditional was lingering in another template.

Clean up these issues to display the latest builds section
correctly.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/templates/builds.html      |  5 -----
 lib/toaster/toastergui/templates/mrb_section.html | 21 ++++++++++-----------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index 566c279..459fcb0 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -29,8 +29,6 @@
 
   {% include "mrb_section.html" %}
 
-
-  {% if 1 %}
   <div class="page-header top-air">
      <h1>
       {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
@@ -57,8 +55,6 @@
         </form>
       </div>
     </div>
-
-
   {% else %}
   {% include "basetable_top.html" %}
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
@@ -117,7 +113,6 @@
 
   {% include "basetable_bottom.html" %}
   {% endif %} {# objects.paginator.count #}
-{% endif %} {# empty #}
 </div><!-- end row-fluid-->
 
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 55687a1..bd8f991 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -22,19 +22,18 @@
   {% endif %}
   <div id="latest-builds">
   {% for build in mru %}
-  <div data-latest-build-result="{{ build.id }}" class="alert build-result {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}
-    {% if mrb_type != 'project' %}
-    project-name">
-       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
-         <a href={% project_url build.project %}>
-           {{build.project.name}}
-         </a>
-       </span>
-    {% endif %}
+  <div data-latest-build-result="{{ build.id }}" class="alert build-result {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}{% if mrb_type != 'project' %} project-name{% endif %}">
+      {% if mrb_type != 'project' %}
+        <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
+            <a href={% project_url build.project %}>
+                {{build.project.name}}
+            </a>
+        </span>
+      {% endif %}
         <div class="row-fluid">
-            <div class="span3 lead">
+          <div class="span3 lead">
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
-                <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
+              <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
     {% endif %}
             {% if build.target_set.all.count > 0 %}
                 <span data-toggle="tooltip"
-- 
2.1.4


