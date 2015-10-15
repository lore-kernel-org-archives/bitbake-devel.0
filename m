Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 4E5CE77046
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 12:49:09 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga102.fm.intel.com with ESMTP; 15 Oct 2015 05:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,685,1437462000"; d="scan'208";a="827342645"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 15 Oct 2015 05:49:10 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 1D7A76A4083
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 05:48:10 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 15:45:15 +0300
Message-Id: <78954d97f52e69d47241e8ffb19e5c712b823733.1444910218.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 3/4] toaster: Guard against builds with no targets
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
X-List-Received-Date: Thu, 15 Oct 2015 12:49:10 -0000

From: Elliot Smith <elliot.smith@intel.com>

Although this probably can't happen in practice (builds without
targets), this constraint is not currently enforced in the data model.

In the unlikely event that a build has no target (e.g. in test cases),
this causes a template rendering error.

Rather than rework the data model, add a guard to the template
to prevent it from rendering the target name if there are no
targets associated with the build.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/templates/builddashboard.html | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 75ca8bc..c39fe34 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -3,7 +3,12 @@
 {% load projecttags %}
 
 {% block parentbreadcrumb %}
-{{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
+{% if build.get_sorted_target_list.count > 0 %}
+  {{build.get_sorted_target_list.0.target}}
+  &nbsp;
+{% endif %}
+
+{%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
 {% endblock %}
 
 {% block buildinfomain %}
@@ -62,7 +67,7 @@
       <div class="accordion-inner">
         <div class="span10">
           {% for error in build.errors %}
-            <div class="alert alert-error">
+            <div class="alert alert-error" data-error="{{ error.id }}">
               <pre>{{error.message}}</pre>
             </div>
           {% endfor %}
-- 
2.1.4


