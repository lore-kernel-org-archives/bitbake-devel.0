Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D125D75C60
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:19 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 15 Jan 2016 04:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="861139075"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 15 Jan 2016 04:58:22 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 22AE86A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:16 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:52 +0200
Message-Id: <c287a9ef6e92482a64d4bb8bb225a6e26376c997.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 09/23] toaster: toastergui: show recent builds on all builds page
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:20 -0000

From: Elliot Smith <elliot.smith@intel.com>

The recent builds section was disabled while converting the
all builds page to ToasterTable.

Re-enable the recent builds area and add the data it requires
to the ToasterTable context.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tables.py                       | 18 +++++++++++++++++-
 .../toastergui/templates/builds-toastertable.html      | 10 +++++-----
 lib/toaster/toastergui/templates/mrb_section.html      |  2 +-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index a0991ec..0941637 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -27,6 +27,7 @@ from django.db.models import Q, Max, Count
 from django.conf.urls import url
 from django.core.urlresolvers import reverse
 from django.views.generic import TemplateView
+import itertools
 
 from toastergui.tablefilter import TableFilter, TableFilterActionToggle
 
@@ -887,7 +888,22 @@ class BuildsTable(ToasterTable):
         self.static_context_extra['Task'] = Task
 
     def get_context_data(self, **kwargs):
-        return super(BuildsTable, self).get_context_data(**kwargs)
+        context = super(BuildsTable, self).get_context_data(**kwargs)
+
+        # for the latest builds section
+        queryset = Build.objects.all()
+
+        finished_criteria = Q(outcome=Build.SUCCEEDED) | Q(outcome=Build.FAILED)
+
+        latest_builds = itertools.chain(
+            queryset.filter(outcome=Build.IN_PROGRESS).order_by("-started_on"),
+            queryset.filter(finished_criteria).order_by("-completed_on")[:3]
+        )
+
+        context['mru'] = list(latest_builds)
+        context['mrb_type'] = 'all'
+
+        return context
 
     def setup_queryset(self, *args, **kwargs):
         queryset = Build.objects.all()
diff --git a/lib/toaster/toastergui/templates/builds-toastertable.html b/lib/toaster/toastergui/templates/builds-toastertable.html
index 419d2b5..f7604fd 100644
--- a/lib/toaster/toastergui/templates/builds-toastertable.html
+++ b/lib/toaster/toastergui/templates/builds-toastertable.html
@@ -3,13 +3,13 @@
 {% block title %} All builds - Toaster {% endblock %}
 
 {% block pagecontent %}
-  <div class="page-header top-air">
-    <h1 data-role="page-title"></h1>
-  </div>
 
   <div class="row-fluid">
-    {# TODO need to pass this data to context #}
-    {#% include 'mrb_section.html' %#}
+    {% with mru=mru mrb_type=mrb_type %}
+      {% include 'mrb_section.html' %}
+    {% endwith %}
+
+    <h1  class="page-header top-air" data-role="page-title"></h1>
 
     {% url 'builds' as xhr_table_url %}
     {% include 'toastertable.html' %}
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index bd8f991..52b3f1a 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -14,7 +14,7 @@
       {% endif %}
       </h2>
   {% else %}
-    <div class="page-header">
+    <div class="page-header top-air">
       <h1>
       Latest builds
       </h1>
-- 
2.1.4


