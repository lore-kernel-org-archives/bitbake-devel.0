Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id CA4EF6E237
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:28 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359905"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:27 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:10 +0000
Message-Id: <4930ff5b471761c2a8d16c1935cdab9cf141d2d8.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 04/11] toaster: update build stats reading
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:28 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In the processes of removing local system accesses
from toaster UI, we remove the build stats
code that was moved to toaster.bbclass, and
adapt the database writing code to read the data
from BuildStatsList event sent by the toaster.bbclass

    [YOCTO #5604]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 64 +++++++++++++-------------------------------
 lib/bb/ui/toasterui.py       |  2 ++
 2 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index b2e21ef..fef849d 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -319,23 +319,16 @@ class BuildInfoHelper(object):
         assert False
         return None
 
-    def _get_recipe_information_from_build_event(self, event):
+    def _get_recipe_information_from_taskfile(self, taskfile):
 
-        layer_version_obj = self._get_layer_version_for_path(re.split(':', event.taskfile)[-1])
+        layer_version_obj = self._get_layer_version_for_path(re.split(':', taskfile)[-1])
 
         recipe_info = {}
         recipe_info['layer_version'] = layer_version_obj
-        recipe_info['file_path'] = re.split(':', event.taskfile)[-1]
+        recipe_info['file_path'] = re.split(':', taskfile)[-1]
 
         return recipe_info
 
-    def _get_task_build_stats(self, task_object):
-        bs_path = self._get_path_information(task_object)
-        for bp in bs_path:  # TODO: split for each target
-            task_build_stats = self._get_build_stats_from_file(bp, task_object.task_name)
-
-        return task_build_stats
-
     def _get_path_information(self, task_object):
         build_stats_format = "{tmpdir}/buildstats/{target}-{machine}/{buildname}/{package}/"
         build_stats_path = []
@@ -356,36 +349,6 @@ class BuildInfoHelper(object):
 
         return build_stats_path
 
-    def _get_build_stats_from_file(self, bs_path, task_name):
-
-        task_bs_filename = str(bs_path) + str(task_name)
-        task_bs = open(task_bs_filename, 'r')
-
-        cpu_usage = 0
-        disk_io = 0
-        startio = ''
-        endio = ''
-
-        for line in task_bs.readlines():
-            if line.startswith('CPU usage: '):
-                cpu_usage = line[11:]
-            elif line.startswith('EndTimeIO: '):
-                endio = line[11:]
-            elif line.startswith('StartTimeIO: '):
-                startio = line[13:]
-
-        task_bs.close()
-
-        if startio and endio:
-            disk_io = int(endio.strip('\n ')) - int(startio.strip('\n '))
-
-        if cpu_usage:
-            cpu_usage = float(cpu_usage.strip('% \n'))
-
-        task_build_stats = {'cpu_usage': cpu_usage, 'disk_io': disk_io}
-
-        return task_build_stats
-
     def _remove_redundant(self, string):
         ret = []
         for i in string.split():
@@ -435,7 +398,7 @@ class BuildInfoHelper(object):
     def store_started_task(self, event):
         identifier = event.taskfile + event.taskname
 
-        recipe_information = self._get_recipe_information_from_build_event(event)
+        recipe_information = self._get_recipe_information_from_taskfile(event.taskfile)
         recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
 
         task_information = self._get_task_information(event, recipe)
@@ -458,9 +421,23 @@ class BuildInfoHelper(object):
 
         self.internal_state[identifier] = {'start_time': datetime.datetime.now()}
 
+
+    def store_tasks_stats(self, event):
+        for (taskfile, taskname, taskstats) in event.data:
+            recipe_information = self._get_recipe_information_from_taskfile(taskfile)
+            recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
+
+            task_information = {}
+            task_information['build'] = self.internal_state['build']
+            task_information['recipe'] = recipe
+            task_information['task_name'] = taskname
+            task_information['cpu_usage'] = taskstats['cpu_usage']
+            task_information['disk_io'] = taskstats['disk_io']
+            task_obj = self.orm_wrapper.get_update_task_object(task_information)
+
     def update_and_store_task(self, event):
         identifier = event.taskfile + event.taskname
-        recipe_information = self._get_recipe_information_from_build_event(event)
+        recipe_information = self._get_recipe_information_from_taskfile(event.taskfile)
         recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
         task_information = self._get_task_information(event,recipe)
         try:
@@ -483,9 +460,6 @@ class BuildInfoHelper(object):
 
         if isinstance(event, (bb.runqueue.runQueueTaskCompleted, bb.runqueue.sceneQueueTaskCompleted)):
             task_information['outcome'] = Task.OUTCOME_SUCCESS
-            task_build_stats = self._get_task_build_stats(self.orm_wrapper.get_update_task_object(task_information))
-            task_information['cpu_usage'] = task_build_stats['cpu_usage']
-            task_information['disk_io'] = task_build_stats['disk_io']
             del self.internal_state[identifier]
 
         if isinstance(event, (bb.runqueue.runQueueTaskFailed, bb.runqueue.sceneQueueTaskFailed)):
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 50493e7..318fc28 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -238,6 +238,8 @@ def main(server, eventHandler, params ):
                     buildinfohelper.store_build_package_information(event)
                 if event.type == "LayerInfo":
                     buildinfohelper.store_layer_info(event)
+                if event.type == "BuildStatsList":
+                    buildinfohelper.store_tasks_stats(event)
                 continue
 
             # ignore
-- 
1.8.1.2


