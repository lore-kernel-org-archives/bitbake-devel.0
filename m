Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHF93-0008Mq-W0
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:00:38 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 09 Apr 2012 06:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128715232"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 09 Apr 2012 06:51:15 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:42 +0800
Message-Id: <3e323c38769cf0dd8662613283b9d1c82a126363.1333980505.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 12/21] Hob: clean up and unify get_parameters() to be get_parameters_sync()
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
 bitbake/lib/bb/ui/crumbs/builder.py |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index ddd93f6..d8c420e 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -375,6 +375,9 @@ class Builder(gtk.Window):
                                     self.hob_toolchain,
                                     toolchain_packages)
 
+    def get_parameters_sync(self):
+        return self.handler.get_parameters()
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -504,18 +507,18 @@ class Builder(gtk.Window):
     def handler_command_succeeded_cb(self, handler, initcmd):
         if initcmd == self.handler.PARSE_CONFIG:
             # settings
-            params = self.handler.get_parameters()
+            params = self.get_parameters_sync()
             self.configuration = Configuration(params)
             self.parameters = Parameters(params)
             self.handler.generate_configuration()
         elif initcmd == self.handler.GENERATE_CONFIGURATION:
-            params = self.handler.get_parameters()
+            params = self.get_parameters_sync()
             self.configuration.update(params)
             self.image_configuration_page.switch_machine_combo()
         elif initcmd in [self.handler.GENERATE_RECIPES,
                          self.handler.GENERATE_PACKAGES,
                          self.handler.GENERATE_IMAGE]:
-            params = self.handler.get_parameters()
+            params = self.get_parameters_sync()
             self.configuration.update(params)
             self.handler.request_package_info_async()
         elif initcmd == self.handler.POPULATE_PACKAGEINFO:
-- 
1.7.6



