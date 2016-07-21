Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 564416FFCD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 15:42:47 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2016 08:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,399,1464678000"; d="scan'208";a="737805608"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2016 08:42:48 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 9B9736A4006;
	Thu, 21 Jul 2016 08:42:37 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 18:42:35 +0300
Message-Id: <1469115755-12513-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] toaster: fix download URL for task logs
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
X-List-Received-Date: Thu, 21 Jul 2016 15:42:48 -0000

From: Elliot Smith <elliot.smith@intel.com>

The task display template formatting had split the Django
url template tag across two lines and broken it. This resulted
in a gibberish URL for task logs.

Fix by placing the tag and its arguments on a single line.

[YOCTO #9837]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/templates/task.html | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/task.html b/bitbake/lib/toaster/toastergui/templates/task.html
index 86789bd..214c777 100644
--- a/bitbake/lib/toaster/toastergui/templates/task.html
+++ b/bitbake/lib/toaster/toastergui/templates/task.html
@@ -25,8 +25,10 @@
 {%if task.task_executed %}
     {# executed tasks outcome #}
     {% if task.logfile %}
-            <a class="btn btn-default btn-lg" href="{% url 'build_artifact' build.id
-                "tasklogfile" task.pk %}">Download task log</a>
+            <a class="btn btn-default btn-lg"
+               href="{% url 'build_artifact' build.id 'tasklogfile' task.pk %}">
+              Download task log
+            </a>
     {% endif %}
         {# show stack trace for failed task #}
         {% if task.outcome == task.OUTCOME_FAILED and log_head %}
@@ -156,8 +158,10 @@ this prebuilt task is reusing"></span></a>
     {%elif task.outcome == task.OUTCOME_CACHED%}
             {% for t in task.get_related_setscene %}
                 {% if forloop.last %}
-                    <a class="btn btn-default btn-lg" href="{% url
-                        'build_artifact' build.id "tasklogfile" t.pk %}">Download task log</a>
+                    <a class="btn btn-default btn-lg"
+                       href="{% url 'build_artifact' build.id "tasklogfile" t.pk %}">
+                      Download task log
+                    </a>
                 {% endif %}
             {% endfor %}
 
-- 
2.6.6


