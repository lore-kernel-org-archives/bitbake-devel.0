Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TRNuB-0001LS-NE
	for bitbake-devel@lists.openembedded.org;
	Thu, 25 Oct 2012 15:55:27 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 25 Oct 2012 06:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,646,1344236400"; d="scan'208";a="232417265"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 25 Oct 2012 06:41:56 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Oct 2012 16:43:44 +0300
Message-Id: <1351172624-25566-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: during recipe parsing, progress bar text provides details about the process state
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
X-List-Received-Date: Thu, 25 Oct 2012 13:55:28 -0000

- indicating on progress bar that hob has gone from parsing
recipes to "Generating dependency tree"; this will provide
some visibility of what has caused the "stop" button state
to change

[YOCTO #3282]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 2fc4a29..67d7de8 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -962,7 +962,10 @@ class Builder(gtk.Window):
         else:
             self.image_configuration_page.stop_button.set_sensitive(True)
 
-        self.image_configuration_page.update_progress_bar(message["title"], fraction)
+        if message["eventname"] == "TreeDataPreparationProgress":
+            self.image_configuration_page.update_progress_bar("Generating dependency tree", fraction)
+        else:
+            self.image_configuration_page.update_progress_bar(message["title"], fraction)
 
     def handler_parsing_cb(self, handler, message):
         if self.current_step != self.RCPPKGINFO_POPULATING:
@@ -973,7 +976,10 @@ class Builder(gtk.Window):
             fraction = 0.6 + 0.38 * fraction
         else:
             fraction = 0.6 * fraction
-        self.image_configuration_page.update_progress_bar(message["title"], fraction)
+        if message["eventname"] == "TreeDataPreparationProgress":
+            self.image_configuration_page.update_progress_bar("Generating dependency tree", fraction)
+        else: 
+            self.image_configuration_page.update_progress_bar(message["title"], fraction)
 
     def handler_parsing_completed_cb(self, handler, message):
         if self.current_step != self.RCPPKGINFO_POPULATING:
-- 
1.7.9.5



