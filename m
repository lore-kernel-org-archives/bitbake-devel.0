Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SMR4T-0000Ho-Hh
	for bitbake-devel@lists.openembedded.org;
	Mon, 23 Apr 2012 23:45:21 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Apr 2012 14:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="132995959"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.56])
	by orsmga001.jf.intel.com with ESMTP; 23 Apr 2012 14:35:46 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Apr 2012 14:35:44 -0700
Message-Id: <f547f934aea9c4aec5f84403cb27904bd4a4e6b9.1335216391.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1335216391.git.josh@linux.intel.com>
References: <cover.1335216391.git.josh@linux.intel.com>
In-Reply-To: <cover.1335216391.git.josh@linux.intel.com>
References: <cover.1335216391.git.josh@linux.intel.com>
Subject: [PATCH 1/1] hob: enable sanity checks after launch
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
X-List-Received-Date: Mon, 23 Apr 2012 21:45:21 -0000

To ensure the users configuration is sanity tested enable the sanity
checks after the GUI has started but before any parsing is done.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    2 ++
 lib/bb/ui/crumbs/hobeventhandler.py |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index dd3ea95..cbcb3f1 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -557,6 +557,8 @@ class Builder(gtk.Window):
         self.handler.init_cooker()
         # set bb layers
         self.handler.set_bblayers(self.configuration.layers)
+        # Re-enable sanity checks
+        self.handler.enable_sanity()
         # set local configuration
         self.handler.set_machine(self.configuration.curr_mach)
         self.handler.set_package_format(self.configuration.curr_package_format)
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index ebfc388..c918aad 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -233,6 +233,9 @@ class HobHandler(gobject.GObject):
         inherits = inherits + " " + bbclass
         self.runCommand(["setVariable", "INHERIT", inherits])
 
+    def enable_sanity(self):
+        self.runCommand(["setVariable", "DISABLE_SANITY_CHECKS", "0"])
+
     def set_bblayers(self, bblayers):
         self.runCommand(["setVariable", "BBLAYERS_HOB", " ".join(bblayers)])
 
-- 
1.7.7.6



