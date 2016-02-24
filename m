Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 61CC177212
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Feb 2016 13:50:05 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 24 Feb 2016 05:50:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,494,1449561600"; 
	d="scan'208,217";a="752399235"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.1.217])
	by orsmga003.jf.intel.com with ESMTP; 24 Feb 2016 05:50:02 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 24 Feb 2016 13:49:38 +0000
Message-Id: <1456321778-542-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: custom breadcrumb for the default project
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
X-List-Received-Date: Wed, 24 Feb 2016 13:50:06 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The default "Command line builds" project does not have a Configuration
page. It therefore needs a custom breadcrumb where the project name goes
to the project builds page, instead of the project configuration page.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html | 7 +++++--
 bitbake/lib/toaster/toastergui/templates/basebuildpage.html       | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html b/bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html
index e350c1a..a62e0b1 100644
--- a/bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html
+++ b/bitbake/lib/toaster/toastergui/templates/basebuilddetailpage.html
@@ -1,4 +1,5 @@
 {% extends "base.html" %}
+{% load project_url_tag %}
 {% load humanize %}
 {% block pagecontent %}
 
@@ -6,8 +7,10 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-            <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
-            <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
+            <li><a href="{% project_url build.project %}">{{build.project.name}}</a></li>
+            {% if not build.project.is_default %}
+                <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
+            {% endif %}
             <li><a href="{%url 'builddashboard' build.pk%}">{{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+{{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
             {% block localbreadcrumb %}{% endblock %}
         </ul>
diff --git a/bitbake/lib/toaster/toastergui/templates/basebuildpage.html b/bitbake/lib/toaster/toastergui/templates/basebuildpage.html
index 3571869..0dc71f5 100644
--- a/bitbake/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/bitbake/lib/toaster/toastergui/templates/basebuildpage.html
@@ -1,5 +1,6 @@
 {% extends "base.html" %}
 {% load projecttags %}
+{% load project_url_tag %}
 {% load humanize %}
 {% block pagecontent %}
 
@@ -8,8 +9,10 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-            <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
-            <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
+            <li><a href="{% project_url build.project %}">{{build.project.name}}</a></li>
+            {% if not build.project.is_default %}
+                <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
+            {% endif %}
             <li>
             {% block parentbreadcrumb %}
             <a href="{%url 'builddashboard' build.pk%}">
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


