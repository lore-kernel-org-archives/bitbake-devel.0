Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Ey-0006BC-BY
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:40:56 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 15 Mar 2012 01:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="119200601"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 15 Mar 2012 01:32:08 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:57 +0800
Message-Id: <f4b5a9f243fcfb48cf01fa6f8bce35897debbd20.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 09/12] Hob: Emit command-failed signal even if error msg is None
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
X-List-Received-Date: Thu, 15 Mar 2012 08:40:56 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   13 +++++++------
 lib/bb/ui/crumbs/hobeventhandler.py |    5 ++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index f52b475..1363475 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -430,12 +430,13 @@ class Builder(gtk.Window):
                 self.switch_page(self.IMAGE_GENERATED)
 
     def handler_command_failed_cb(self, handler, msg):
-        lbl = "<b>Error</b>\n"
-        lbl = lbl + "%s\n\n" % msg
-        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
-        dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
-        response = dialog.run()
-        dialog.destroy()
+        if msg:
+            lbl = "<b>Error</b>\n"
+            lbl = lbl + "%s\n\n" % msg
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            response = dialog.run()
+            dialog.destroy()
         self.handler.clear_busy()
         self.configuration.curr_mach = None
         self.image_configuration_page.switch_machine_combo()
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 9c82bfe..cd25754 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -238,9 +238,8 @@ class HobHandler(gobject.GObject):
 
         elif isinstance(event, bb.command.CommandFailed):
             self.commands_async = []
-            if self.error_msg:
-                self.emit("command-failed", self.error_msg)
-                self.error_msg = ""
+            self.emit("command-failed", self.error_msg)
+            self.error_msg = ""
         elif isinstance(event, (bb.event.ParseStarted,
                  bb.event.CacheLoadStarted,
                  bb.event.TreeDataPreparationStarted,
-- 
1.7.4.1



