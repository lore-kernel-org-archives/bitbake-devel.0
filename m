Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDEeO-00082t-7i
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:40:24 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Mar 2012 05:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126526646"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 29 Mar 2012 05:31:19 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:54:50 +0800
Message-Id: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1333025490.git.shane.wang@intel.com>
References: <cover.1333025490.git.shane.wang@intel.com>
Subject: [PATCH 1/8] Hob: clear the building state after a successful build, as a failed build does
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
X-List-Received-Date: Thu, 29 Mar 2012 12:40:24 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    1 +
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 0c00d2a..a651bdb 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -605,6 +605,7 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 1.0
         self.build_details_page.update_progress_bar("Build Completed: ", fraction)
+        self.handler.build_succeeded_async()
         self.stopping = False
 
     def build_failed(self):
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 9c5dc77..f1f6168 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -365,6 +365,9 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
 
+    def build_succeeded_async(self):
+        self.building = False
+
     def build_failed_async(self):
         self.initcmd = None
         self.commands_async = []
-- 
1.7.6



