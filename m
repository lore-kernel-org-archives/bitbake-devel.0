Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R0YOc-0002f2-4X
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Sep 2011 14:35:26 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Sep 2011 05:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="45362403"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.53])
	by orsmga001.jf.intel.com with ESMTP; 05 Sep 2011 05:30:18 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2011 13:30:11 +0100
Message-Id: <def7176ad3376131b7ef8404f3f223d9708f5a6d.1315225427.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1315225427.git.paul.eggleton@linux.intel.com>
References: <cover.1315225427.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1315225427.git.paul.eggleton@linux.intel.com>
References: <cover.1315225427.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] hob: fix segfault on second build
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 05 Sep 2011 12:35:26 -0000

Some internal lists were not being cleared, resulting in incorrect
program flow on the second build, causing a structure to be accessed
incorrectly which resulted in a segfault.

Fixes [YOCTO #1332]

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/runningbuild.py |    5 +++++
 bitbake/lib/bb/ui/hob.py                 |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 97d1ebd..c18bd87 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -68,6 +68,11 @@ class RunningBuild (gobject.GObject):
         self.model = RunningBuildModel()
         self.sequential = sequential
 
+    def reset (self):
+        self.pids_to_task.clear()
+        self.tasks_to_iter.clear()
+        self.model.clear()
+
     def handle_event (self, event, pbar=None):
         # Handle an event from the event queue, this may result in updating
         # the model and thus the UI. Or it may be to tell us that the build
diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index f2a9ee5..76e9237 100644
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -484,7 +484,7 @@ class MainWindow (gtk.Window):
 
     def toggle_createview(self):
         self.set_menus_sensitive(True)
-        self.build.model.clear()
+        self.build.reset()
         self.nb.set_current_page(0)
 
     def build_complete_cb(self, running_build):
-- 
1.7.4.1



