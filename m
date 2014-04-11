Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 4561E65ED7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Apr 2014 16:32:42 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 11 Apr 2014 09:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,842,1389772800"; d="scan'208";a="511562438"
Received: from pmeel-ivm.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.171])
	by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2014 09:32:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Apr 2014 17:32:30 +0100
Message-Id: <0cb598029aae2d9a9bade51bc2c545dc577f250c.1397233921.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1397233921.git.paul.eggleton@linux.intel.com>
References: <cover.1397233921.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1397233921.git.paul.eggleton@linux.intel.com>
References: <cover.1397233921.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake: toaster: Fix total number of tasks in build dashboard
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
X-List-Received-Date: Fri, 11 Apr 2014 16:32:44 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The total number of tasks in the build dashboard was counting
_setscene tasks, which are not exposed by Toaster as separate
tasks. This patch makes sure that _setscene tasks are not
counted when calculating that number.

[YOCTO #6145]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/builddashboard.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index fa4b194..a01ef3d 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -125,7 +125,7 @@
     <div class="well span4 dashboard-section">
         <h4><a href="{%url 'tasks' build.pk%}">Tasks</a></h4>
             <dl>
-        <dt>Total number of tasks</dt><dd><a href="{% url 'tasks' build.pk %}">{{build.task_build.all.count}}</a></dd>
+        <dt>Total number of tasks</dt><dd><a href="{% url 'tasks' build.pk %}">{% query build.task_build order__gt=0 as alltasks %}{{alltasks.count}}</a></dd>
         <dt>
             Tasks executed
             <i class="icon-question-sign get-help" title="'Executed' tasks are those that need to be run in order to generate the task output"></i>
-- 
1.9.0


