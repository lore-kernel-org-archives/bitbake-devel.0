Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHFC6-0008SS-Sp
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:03:47 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 09 Apr 2012 06:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128716051"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 09 Apr 2012 06:54:28 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:45 +0800
Message-Id: <192125047fccc1a4448919f843dfa942959ddf0e.1333980506.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 15/21] Hob: clean up generate_configuration()
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
X-List-Received-Date: Mon, 09 Apr 2012 14:03:47 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 26e202e..b052d99 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -384,6 +384,9 @@ class Builder(gtk.Window):
     def cancel_build_sync(self, force=False):
         self.handler.cancel_build(force)
 
+    def generate_configuration_async(self):
+        self.handler.generate_configuration()
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -516,7 +519,7 @@ class Builder(gtk.Window):
             params = self.get_parameters_sync()
             self.configuration = Configuration(params)
             self.parameters = Parameters(params)
-            self.handler.generate_configuration()
+            self.generate_configuration_async()
         elif initcmd == self.handler.GENERATE_CONFIGURATION:
             params = self.get_parameters_sync()
             self.configuration.update(params)
-- 
1.7.6



