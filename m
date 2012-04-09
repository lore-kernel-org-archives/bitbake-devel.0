Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHF93-0008OD-WF
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:00:38 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 09 Apr 2012 06:51:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128715243"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 09 Apr 2012 06:51:16 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:43 +0800
Message-Id: <a7aaad78b98592281d0aa1122c46d82a4df4e951.1333980505.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 13/21] Hob: clean up request_package_info_async()
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
X-List-Received-Date: Mon, 09 Apr 2012 14:00:38 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    5 ++++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index d8c420e..f069215 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -378,6 +378,9 @@ class Builder(gtk.Window):
     def get_parameters_sync(self):
         return self.handler.get_parameters()
 
+    def request_package_info_async(self):
+        self.handler.request_package_info()
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -520,7 +523,7 @@ class Builder(gtk.Window):
                          self.handler.GENERATE_IMAGE]:
             params = self.get_parameters_sync()
             self.configuration.update(params)
-            self.handler.request_package_info_async()
+            self.request_package_info_async()
         elif initcmd == self.handler.POPULATE_PACKAGEINFO:
             if self.current_step == self.RCPPKGINFO_POPULATING:
                 self.switch_page(self.RCPPKGINFO_POPULATED)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index dd85530..1a7427a 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -325,7 +325,7 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["setVariable", "CVS_PROXY_HOST", host])
         self.server.runCommand(["setVariable", "CVS_PROXY_PORT", port])
 
-    def request_package_info_async(self):
+    def request_package_info(self):
         self.commands_async.append(self.SUB_GENERATE_PKGINFO)
         self.run_next_command(self.POPULATE_PACKAGEINFO)
 
-- 
1.7.6



