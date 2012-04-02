Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEcOo-0007fX-RM
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 10:14:03 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 02 Apr 2012 01:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="127700073"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 02 Apr 2012 01:04:53 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 16:29:16 +0800
Message-Id: <cdb1e91988c26e79a8c38a2aa96de3d8b5cbfd4a.1333355236.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
References: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
In-Reply-To: <cover.1333355236.git.shane.wang@intel.com>
References: <cover.1333355236.git.shane.wang@intel.com>
Subject: [PATCH 2/6] Hob: handle exceptions when loading templates
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
X-List-Received-Date: Mon, 02 Apr 2012 08:14:03 -0000

Handle exceptions during type conversion to integers.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index c1a75bd..151bec4 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -104,10 +104,22 @@ class Configuration:
         self.dldir = template.getVar("DL_DIR")
         self.sstatedir = template.getVar("SSTATE_DIR")
         self.sstatemirror = template.getVar("SSTATE_MIRROR")
-        self.pmake = int(template.getVar("PARALLEL_MAKE").split()[1])
-        self.bbthread = int(template.getVar("BB_NUMBER_THREADS"))
-        self.image_rootfs_size = int(template.getVar("IMAGE_ROOTFS_SIZE"))
-        self.image_extra_size = int(template.getVar("IMAGE_EXTRA_SPACE"))
+        try:
+            self.pmake = int(template.getVar("PARALLEL_MAKE").split()[1])
+        except:
+            pass
+        try:
+            self.bbthread = int(template.getVar("BB_NUMBER_THREADS"))
+        except:
+            pass
+        try:
+            self.image_rootfs_size = int(template.getVar("IMAGE_ROOTFS_SIZE"))
+        except:
+            pass
+        try:
+            self.image_extra_size = int(template.getVar("IMAGE_EXTRA_SPACE"))
+        except:
+            pass
         # image_overhead_factor is read-only.
         self.incompat_license = template.getVar("INCOMPATIBLE_LICENSE")
         self.curr_sdk_machine = template.getVar("SDKMACHINE")
-- 
1.7.6



