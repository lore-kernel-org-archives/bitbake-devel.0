Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 4DD6D731BC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 02:31:52 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 18 Sep 2016 19:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,360,1470726000"; d="scan'208";a="1032847457"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga001.jf.intel.com with ESMTP; 18 Sep 2016 19:31:53 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 18 Sep 2016 19:33:13 -0700
Message-Id: <b5b92903847dc0eb537848585ee338a1a8bcb15f.1474252113.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1474252113.git.brian.avery@intel.com>
References: <cover.1474252113.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 1/3] toaster: Fix links to tasks with specific outcome
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
X-List-Received-Date: Mon, 19 Sep 2016 02:31:53 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

The build dashboard provides a count of tasks that were executed and not
executed, and of tasks that failed (if any). The number is a link to the
list of tasks.

Fix the links so that they filter the tasks table by the selected
criteria (executed, not executed or failed).

[YOCTO #9832]

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/toastergui/templates/builddashboard.html | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 9e6e1c1..1c390cd 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -235,7 +235,7 @@
                           </a>
 
                   {% elif exectask.count > 1%}
-                      <a class="text-danger" href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}}</a>
+                      <a class="text-danger" href="{% url "tasks" build.id %}?limit=25&amp;page=1&amp;orderby=order&amp;filter=task_outcome:failed&amp;default_orderby=order&amp;filter_value=on&amp;">{{exectask.count}}</a>
                   {% endif %}
                   </dd>
               {% endif %}
@@ -244,12 +244,12 @@
               Tasks executed
               <span class="glyphicon glyphicon-question-sign get-help" title="'Executed' tasks are those that need to be run in order to generate the task output"></span>
           </dt>
-          <dd><a href="{% url 'tasks' build.pk %}?filter=task_executed%3A1&amp;count=25&amp;search=&amp;page=1&amp;orderby=order%3A%2B">{% query build.task_build task_executed=1 order__gt=0 as exectask%}{{exectask.count}}</a></dd>
+          <dd><a href="{% url 'tasks' build.pk %}?limit=25&amp;page=1&amp;orderby=order&amp;filter=execution_outcome:executed&amp;default_orderby=order&amp;filter_value=on&amp;">{% query build.task_build task_executed=1 order__gt=0 as exectask%}{{exectask.count}}</a></dd>
           <dt>
               Tasks not executed
               <span class="glyphicon glyphicon-question-sign get-help" title="'Not executed' tasks don't need to run because their outcome is provided by another task"></span>
           </dt>
-          <dd><a href="{% url 'tasks' build.pk %}?filter=task_executed%3A0&amp;count=25&amp;search=&amp;page=1&amp;orderby=order%3A%2B">{% query build.task_build task_executed=0 order__gt=0 as noexectask%}{{noexectask.count}}</a></dd>
+          <dd><a href="{% url 'tasks' build.pk %}?limit=25&amp;page=1&amp;orderby=order&amp;filter=execution_outcome:not_executed&amp;default_orderby=order&amp;filter_value=on&amp;">{% query build.task_build task_executed=0 order__gt=0 as noexectask%}{{noexectask.count}}</a></dd>
           <dt>
               Reuse
               <span class="glyphicon glyphicon-question-sign get-help" title="The percentage of 'not executed' tasks over the total number of tasks, which is a measure of the efficiency of your build"></span>
-- 
1.9.1


