Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDs-0007Rt-6z
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:13:00 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 29 Mar 2012 05:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="83037973"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 29 Mar 2012 05:03:53 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:15 +0800
Message-Id: <8746d37276785f56d72fdde42ac6f00878ab0c8b.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 09/14] Hob: Update configuration after parsing
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
X-List-Received-Date: Thu, 29 Mar 2012 12:13:01 -0000

We need to update the parameters stored in Hob side after
configuration is parsed.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 0621600..924529f 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -78,6 +78,25 @@ class Configuration:
         self.cvs_proxy_host = params["cvs_proxy_host"]
         self.cvs_proxy_port = params["cvs_proxy_port"]
 
+    def update(self, params):
+        self.curr_distro = params["distro"]
+        self.dldir = params["dldir"]
+        self.sstatedir = params["sstatedir"]
+        self.sstatemirror = params["sstatemirror"]
+        self.pmake = params["pmake"]
+        self.bbthread = params["bbthread"]
+        self.curr_package_format = " ".join(params["pclass"].split("package_")).strip()
+        self.image_rootfs_size = params["image_rootfs_size"]
+        self.image_extra_size = params["image_extra_size"]
+        self.image_overhead_factor = params['image_overhead_factor']
+        self.incompat_license = params["incompat_license"]
+        self.curr_sdk_machine = params["sdk_machine"]
+        self.conf_version = params["conf_version"]
+        self.lconf_version = params["lconf_version"]
+        self.image_fstypes = params["image_fstypes"].split()
+        # bblayers.conf
+        self.layers = params["layer"].split()
+
     def load(self, template):
         self.curr_mach = template.getVar("MACHINE")
         self.curr_package_format = " ".join(template.getVar("PACKAGE_CLASSES").split("package_")).strip()
@@ -465,10 +484,14 @@ class Builder(gtk.Window):
             self.parameters = Parameters(params)
             self.handler.generate_configuration()
         elif initcmd == self.handler.GENERATE_CONFIGURATION:
+            params = self.handler.get_parameters()
+            self.configuration.update(params)
             self.image_configuration_page.switch_machine_combo()
         elif initcmd in [self.handler.GENERATE_RECIPES,
                          self.handler.GENERATE_PACKAGES,
                          self.handler.GENERATE_IMAGE]:
+            params = self.handler.get_parameters()
+            self.configuration.update(params)
             self.handler.request_package_info_async()
         elif initcmd == self.handler.POPULATE_PACKAGEINFO:
             if self.current_step == self.RCPPKGINFO_POPULATING:
-- 
1.7.4.1



