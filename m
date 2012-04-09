Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHF8u-0008Kv-Hd
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:00:28 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 09 Apr 2012 06:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="126874680"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2012 06:51:12 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:41 +0800
Message-Id: <e4a50b3704f97eef2cb21e261354d44ec0a740e7.1333980505.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 11/21] Hob: clean up to call clear_busy() in hobeventhandler.py
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
X-List-Received-Date: Mon, 09 Apr 2012 14:00:28 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    1 -
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 959d8c1..ddd93f6 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -542,7 +542,6 @@ class Builder(gtk.Window):
             HobButton.style_button(button)
             response = dialog.run()
             dialog.destroy()
-        self.handler.clear_busy()
         self.configuration.curr_mach = ""
         self.image_configuration_page.switch_machine_combo()
         self.switch_page(self.MACHINE_SELECTION)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index d608b5f..dd85530 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -202,6 +202,7 @@ class HobHandler(gobject.GObject):
 
         elif isinstance(event, bb.command.CommandFailed):
             self.commands_async = []
+            self.clear_busy()
             self.emit("command-failed", self.error_msg)
             self.error_msg = ""
         elif isinstance(event, (bb.event.ParseStarted,
-- 
1.7.6



