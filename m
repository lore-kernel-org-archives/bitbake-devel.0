Return-Path: <marius.avram@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B8A6D6EE3A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2014 14:35:02 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 18 Feb 2014 06:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,502,1389772800"; d="scan'208";a="477062490"
Received: from mavram-vostro.rb.intel.com ([10.237.105.158])
	by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2014 06:35:02 -0800
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Feb 2014 16:39:24 +0200
Message-Id: <1392734364-8388-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bb/ui: store_dependency_information optimization
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
X-List-Received-Date: Tue, 18 Feb 2014 14:35:03 -0000

This optimization is in support of the bug #5485. The function called
at the beginning of every build: store_dependency_information was taking
approximately 20sec and it was delaying the arrival of events from the
event queue. The change minimizes the calls to _save_a_task(),
reducing the time to half.

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 0a8073f..da777f1 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -605,11 +605,21 @@ class BuildInfoHelper(object):
             task_info['task_name'] = taskname
             task_obj = self.orm_wrapper.get_update_task_object(task_info)
             return task_obj
+ 
+        # create tasks
+        tasks = {}
+        for taskdesc in event._depgraph['tdepends']:
+            tasks[taskdesc] = _save_a_task(taskdesc)
 
+        # create dependencies between tasks
         for taskdesc in event._depgraph['tdepends']:
-            target = _save_a_task(taskdesc)
-            for taskdesc1 in event._depgraph['tdepends'][taskdesc]:
-                dep = _save_a_task(taskdesc1)
+            target = tasks[taskdesc]
+            for taskdep in event._depgraph['tdepends'][taskdesc]:
+                if taskdep not in tasks:
+                    # Fetch tasks info is not collected previously
+                    dep = _save_a_task(taskdep)
+                else:
+                    dep = tasks[taskdep]
                 Task_Dependency.objects.get_or_create( task = target, depends_on = dep )
 
     def store_build_package_information(self, event):
-- 
1.7.9.5


