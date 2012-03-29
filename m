Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDl-0007Oa-5g
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:12:53 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 29 Mar 2012 05:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="123067303"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 29 Mar 2012 05:03:51 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:13 +0800
Message-Id: <893aac88ee768e46434d18978ff993da43508dbd.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 07/14] Hob: Fix MACHINE setting
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
X-List-Received-Date: Thu, 29 Mar 2012 12:12:54 -0000

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
index eeaa278..b651643 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -493,7 +493,7 @@ class Builder(gtk.Window):
             response = dialog.run()
             dialog.destroy()
         self.handler.clear_busy()
-        self.configuration.curr_mach = None
+        self.configuration.curr_mach = ""
         self.image_configuration_page.switch_machine_combo()
         self.switch_page(self.MACHINE_SELECTION)
 
@@ -826,7 +826,7 @@ class Builder(gtk.Window):
             self.configuration = dialog.configuration
             # DO reparse recipes
             if dialog.settings_changed:
-                if self.configuration.curr_mach == "":
+                if not self.configuration.curr_mach:
                     self.switch_page(self.MACHINE_SELECTION)
                 else:
                     self.switch_page(self.RCPPKGINFO_POPULATING)
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index e5e0b42..6efb9b0 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -258,7 +258,8 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["setVariable", "BBLAYERS", " ".join(bblayers)])
 
     def set_machine(self, machine):
-        self.server.runCommand(["setVariable", "MACHINE", machine])
+        if machine:
+            self.server.runCommand(["setVariable", "MACHINE", machine])
 
     def set_sdk_machine(self, sdk_machine):
         self.server.runCommand(["setVariable", "SDKMACHINE", sdk_machine])
-- 
1.7.4.1



