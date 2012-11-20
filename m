Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1Taj6a-0008OK-9O
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Nov 2012 09:22:52 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 20 Nov 2012 00:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,284,1352102400"; d="scan'208";a="251735300"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.152])
	by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2012 00:08:46 -0800
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Nov 2012 10:09:18 +0200
Message-Id: <1353398958-2699-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.11.7
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/builder: Don't rerun sanity checks
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
X-List-Received-Date: Tue, 20 Nov 2012 08:22:52 -0000

Run the sanity check only once

[YOCTO #3377]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index ecf5371..0804721 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -439,6 +439,9 @@ class Builder(gtk.Window):
         # Indicate whether the UI is working
         self.sensitive = True
 
+        # Indicate whether the sanity check ran
+        self.sanity_checked = False
+
         # create visual elements
         self.create_visual_elements()
 
@@ -541,7 +544,8 @@ class Builder(gtk.Window):
           sanity_check_post_func = func
 
     def generate_configuration(self):
-        self.show_sanity_check_page()
+        if not self.sanity_checked:
+            self.show_sanity_check_page()
         self.handler.generate_configuration()
 
     def initiate_new_build_async(self):
@@ -833,7 +837,9 @@ class Builder(gtk.Window):
             if not self.configuration.curr_mach:
                 self.configuration.curr_mach = self.handler.runCommand(["getVariable", "HOB_MACHINE"]) or ""
             self.update_configuration_parameters(self.get_parameters_sync())
-            self.sanity_check()
+            if not self.sanity_checked:
+                self.sanity_check()
+                self.sanity_checked = True
         elif initcmd == self.handler.SANITY_CHECK:
             if self.had_network_error:
                 self.had_network_error = False
-- 
1.7.11.7



