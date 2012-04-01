Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJr3-00042E-Pn
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:25:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 01 Apr 2012 05:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="136234461"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2012 05:16:49 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:09 +0800
Message-Id: <6675e6fd885912348817400adbb5d18ad2ce4146.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
Subject: [PATCH 01/10] Hob: Fix MACHINE setting
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
X-List-Received-Date: Sun, 01 Apr 2012 12:25:58 -0000

Define the empty curr_mach to be "" instead of None.
Fix the judgement for ' if self.curr_mach == "" ' to be
' if self.curr_mach '.
Also set machine to bitbake server when "MACHINE" is not empty.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    4 ++--
 lib/bb/ui/crumbs/hobeventhandler.py |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index c1a75bd..02c9a9c 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -519,7 +519,7 @@ class Builder(gtk.Window):
             response = dialog.run()
             dialog.destroy()
         self.handler.clear_busy()
-        self.configuration.curr_mach = None
+        self.configuration.curr_mach = ""
         self.image_configuration_page.switch_machine_combo()
         self.switch_page(self.MACHINE_SELECTION)
 
@@ -868,7 +868,7 @@ class Builder(gtk.Window):
 
     def reparse_post_adv_settings(self):
         # DO reparse recipes
-        if self.configuration.curr_mach == "":
+        if not self.configuration.curr_mach:
             self.switch_page(self.MACHINE_SELECTION)
         else:
             self.switch_page(self.RCPPKGINFO_POPULATING)
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index a329380..3d5df9e 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -256,7 +256,8 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["setVariable", "BBLAYERS", " ".join(bblayers)])
 
     def set_machine(self, machine):
-        self.server.runCommand(["setVariable", "MACHINE", machine])
+        if machine:
+            self.server.runCommand(["setVariable", "MACHINE", machine])
 
     def set_sdk_machine(self, sdk_machine):
         self.server.runCommand(["setVariable", "SDKMACHINE", sdk_machine])
-- 
1.7.4.1



