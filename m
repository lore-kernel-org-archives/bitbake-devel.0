Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEcLk-0007dd-GK
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 10:10:52 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 02 Apr 2012 01:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="124389454"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 02 Apr 2012 01:01:43 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 16:29:15 +0800
Message-Id: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1333355236.git.shane.wang@intel.com>
References: <cover.1333355236.git.shane.wang@intel.com>
Subject: [PATCH 1/6] Hob: handle exceptions in get_parameters() from the bitbake
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
X-List-Received-Date: Mon, 02 Apr 2012 08:10:52 -0000

Handle exceptions during type conversion into integers.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   33 +++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index a329380..c1afa0b 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -401,15 +401,22 @@ class HobHandler(gobject.GObject):
             num_threads = 1
             max_threads = 65536
         else:
-            num_threads = int(num_threads)
-            max_threads = 16 * num_threads
+            try:
+                num_threads = int(num_threads)
+                max_threads = 16 * num_threads
+            except:
+                num_threads = 1
+                max_threads = 65536
         params["max_threads"] = max_threads
 
         bbthread = self.server.runCommand(["getVariable", "BB_NUMBER_THREADS"])
         if not bbthread:
             bbthread = num_threads
         else:
-            bbthread = int(bbthread)
+            try:
+                bbthread = int(bbthread)
+            except:
+                bbthread = num_threads
         params["bbthread"] = bbthread
 
         pmake = self.server.runCommand(["getVariable", "PARALLEL_MAKE"])
@@ -418,7 +425,10 @@ class HobHandler(gobject.GObject):
         elif isinstance(pmake, int):
             pass
         else:
-            pmake = int(pmake.lstrip("-j "))
+            try:
+                pmake = int(pmake.lstrip("-j "))
+            except:
+                pmake = num_threads
         params["pmake"] = pmake
 
         params["image_addr"] = self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"]) or ""
@@ -427,21 +437,30 @@ class HobHandler(gobject.GObject):
         if not image_extra_size:
             image_extra_size = 0
         else:
-            image_extra_size = int(image_extra_size)
+            try:
+                image_extra_size = int(image_extra_size)
+            except:
+                image_extra_size = 0
         params["image_extra_size"] = image_extra_size
 
         image_rootfs_size = self.server.runCommand(["getVariable", "IMAGE_ROOTFS_SIZE"])
         if not image_rootfs_size:
             image_rootfs_size = 0
         else:
-            image_rootfs_size = int(image_rootfs_size)
+            try:
+                image_rootfs_size = int(image_rootfs_size)
+            except:
+                image_rootfs_size = 0
         params["image_rootfs_size"] = image_rootfs_size
 
         image_overhead_factor = self.server.runCommand(["getVariable", "IMAGE_OVERHEAD_FACTOR"])
         if not image_overhead_factor:
             image_overhead_factor = 1
         else:
-            image_overhead_factor = float(image_overhead_factor)
+            try:
+                image_overhead_factor = float(image_overhead_factor)
+            except:
+                image_overhead_factor = 1
         params['image_overhead_factor'] = image_overhead_factor
 
         params["incompat_license"] = self.server.runCommand(["getVariable", "INCOMPATIBLE_LICENSE"]) or ""
-- 
1.7.6



