Return-Path: <valentin.popa@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id DE2F96B1A9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2013 11:54:22 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 21 Nov 2013 03:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,743,1378882800"; d="scan'208";a="412351549"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by orsmga001.jf.intel.com with ESMTP; 21 Nov 2013 03:54:21 -0800
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2013 13:55:13 +0200
Message-Id: <3766a4d9a15a56261fe139a9b332f9afbae966f0.1385034591.git.valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1385034591.git.valentin.popa@intel.com>
References: <cover.1385034591.git.valentin.popa@intel.com>
In-Reply-To: <cover.1385034591.git.valentin.popa@intel.com>
References: <cover.1385034591.git.valentin.popa@intel.com>
Subject: [PATCH 1/1] HOB: Show warnings in Issues tab
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
X-List-Received-Date: Thu, 21 Nov 2013 11:54:23 -0000

Proper update of warnings view during build.

[YOCTO #3496]

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/ui/crumbs/runningbuild.py | 48 ++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index abd3300..0a48a6b 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -174,6 +174,15 @@ class RunningBuild (gobject.GObject):
                       color,
                       0))
 
+            # if there are warnings, mark the task with warning
+            # color;
+            # in case there are errors, the updates will be
+            #  handled on TaskFailed.
+            if color == HobColors.WARNING:
+                self.model.set(parent, self.model.COL_COLOR, color)
+                if task: #then we have a parent, and update it's color
+                    self.model.set(self.tasks_to_iter[(package, None)], self.model.COL_COLOR, color)
+
         elif isinstance(event, bb.build.TaskStarted):
             (package, task) = (event._package, event._task)
 
@@ -201,9 +210,10 @@ class RunningBuild (gobject.GObject):
 
             # Because this parent package now has an active child mark it as
             # such.
-            # @todo if parent is already in error, don't mark it green
-            self.model.set(parent, self.model.COL_ICON, "gtk-execute",
-                           self.model.COL_COLOR, HobColors.RUNNING)
+            self.model.set(parent, self.model.COL_ICON, "gtk-execute")
+            parent_color = self.model.get(parent, self.model.COL_COLOR)[0]
+            if parent_color != HobColors.ERROR and parent_color != HobColors.WARNING:
+                self.model.set(parent, self.model.COL_COLOR, HobColors.RUNNING)
 
             # Add an entry in the model for this task
             i = self.model.append (parent, (None,
@@ -246,20 +256,28 @@ class RunningBuild (gobject.GObject):
                     self.model.set(i, self.model.COL_ICON, icon,
                                    self.model.COL_COLOR, color)
             else:
-                icon = None
-                color = HobColors.OK
+                # Mark the parent package and the task as inactive,
+                # but make sure to preserve error, warnings and active
+                # states
+                parent_color = self.model.get(parent, self.model.COL_COLOR)[0]
+                task_color = self.model.get(current, self.model.COL_COLOR)[0]
 
                 # Mark the task as inactive
-                self.model.set(current, self.model.COL_ICON, icon,
-                               self.model.COL_COLOR, color)
-
-                # Mark the parent package as inactive, but make sure to
-                # preserve error and active states
-                i = self.tasks_to_iter[(package, None)]
-                if self.model.get(parent, self.model.COL_ICON) != 'dialog-error':
-                    self.model.set(parent, self.model.COL_ICON, icon)
-                    if num_active == 0:
-                        self.model.set(parent, self.model.COL_COLOR, HobColors.OK)
+                self.model.set(current, self.model.COL_ICON, None)
+                if task_color != HobColors.ERROR:
+                    if task_color == HobColors.WARNING:
+                        self.model.set(current, self.model.COL_ICON, 'dialog-warning')
+                    else:
+                        self.model.set(current, self.model.COL_COLOR, HobColors.OK)
+
+                # Mark the parent as inactive
+                if parent_color != HobColors.ERROR:
+                    if parent_color == HobColors.WARNING:
+                        self.model.set(parent, self.model.COL_ICON, "dialog-warning")
+                    else:
+                        self.model.set(parent, self.model.COL_ICON, None)
+                        if num_active == 0:
+                            self.model.set(parent, self.model.COL_COLOR, HobColors.OK)
 
             # Clear the iters and the pids since when the task goes away the
             # pid will no longer be used for messages
-- 
1.8.3.2


