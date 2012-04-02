Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEcRx-0007iL-Uk
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 10:17:18 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Apr 2012 01:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="124390984"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 02 Apr 2012 01:08:08 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 16:29:20 +0800
Message-Id: <f4b102cdf2cd021a0b5acacb034dd568a8e73817.1333355236.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
References: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
In-Reply-To: <cover.1333355236.git.shane.wang@intel.com>
References: <cover.1333355236.git.shane.wang@intel.com>
Subject: [PATCH 6/6] Hob: a minor fix on pmake
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
X-List-Received-Date: Mon, 02 Apr 2012 08:17:18 -0000

params["pmake"] should be in the format "-j int".
When loading/saving "PARALLEL_MAKE" into templates, configuration.pmake will be
converted into "-j int", as "PACKAGE_CLASSES" and "BBLAYERS" do.

For "PACKAGE_CLASSES" and "BBLAYERS", params["pclass"] and params["layer"] are
also strings rather than the types of configuration.curr_package_format and
configuration.layers.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    4 ++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7a786a9..6587734 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -48,7 +48,7 @@ class Configuration:
         self.dldir = params["dldir"]
         self.sstatedir = params["sstatedir"]
         self.sstatemirror = params["sstatemirror"]
-        self.pmake = params["pmake"]
+        self.pmake = int(params["pmake"].split()[1])
         self.bbthread = params["bbthread"]
         self.curr_package_format = " ".join(params["pclass"].split("package_")).strip()
         self.image_rootfs_size = params["image_rootfs_size"]
@@ -83,7 +83,7 @@ class Configuration:
         self.dldir = params["dldir"]
         self.sstatedir = params["sstatedir"]
         self.sstatemirror = params["sstatemirror"]
-        self.pmake = params["pmake"]
+        self.pmake = int(params["pmake"].split()[1])
         self.bbthread = params["bbthread"]
         self.curr_package_format = " ".join(params["pclass"].split("package_")).strip()
         self.image_rootfs_size = params["image_rootfs_size"]
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index c1afa0b..61af131 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -429,7 +429,7 @@ class HobHandler(gobject.GObject):
                 pmake = int(pmake.lstrip("-j "))
             except:
                 pmake = num_threads
-        params["pmake"] = pmake
+        params["pmake"] = "-j %s" % pmake
 
         params["image_addr"] = self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"]) or ""
 
-- 
1.7.6



