Return-Path: <valentin.popa@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id DFEDE6D775
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Dec 2013 15:52:09 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 03 Dec 2013 07:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,818,1378882800"; d="scan'208";a="437798210"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2013 07:52:09 -0800
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Dec 2013 17:52:58 +0200
Message-Id: <f825566bb6aafe972e58629e75bd9e1107adfb9d.1386085911.git.valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1386085911.git.valentin.popa@intel.com>
References: <cover.1386085911.git.valentin.popa@intel.com>
In-Reply-To: <cover.1386085911.git.valentin.popa@intel.com>
References: <cover.1386085911.git.valentin.popa@intel.com>
Subject: [PATCH 1/1] Hob: check if warnings are related to package build
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
X-List-Received-Date: Tue, 03 Dec 2013 15:52:10 -0000

If warnings come from recipes parsing
and not from package build, 'parent' object
will be None; so don't update the color for it.

[YOCTO #5621]

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/ui/crumbs/runningbuild.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 0a48a6b..16a955d 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -174,13 +174,13 @@ class RunningBuild (gobject.GObject):
                       color,
                       0))
 
-            # if there are warnings, mark the task with warning
-            # color;
+            # if there are warnings while processing a package
+            #  (parent), mark the task with warning color;
             # in case there are errors, the updates will be
             #  handled on TaskFailed.
-            if color == HobColors.WARNING:
+            if color == HobColors.WARNING and parent:
                 self.model.set(parent, self.model.COL_COLOR, color)
-                if task: #then we have a parent, and update it's color
+                if task: #then we have a parent (package), and update it's color
                     self.model.set(self.tasks_to_iter[(package, None)], self.model.COL_COLOR, color)
 
         elif isinstance(event, bb.build.TaskStarted):
-- 
1.8.3.2


