Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id D1B4875D1A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 17:50:47 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 07 Jul 2015 10:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,425,1432623600"; d="scan'208";a="742336489"
Received: from yctb05.ostc.intel.com (HELO yctb05.otcr.jf.intel.com)
	([10.23.219.54])
	by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2015 10:50:47 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jul 2015 09:45:59 +0000
Message-Id: <90428731ffcb76ab7061fcca2987f0359318ba39.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
References: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
In-Reply-To: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
References: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
Subject: [PATCH 1/3] cooker.py: Lock/Unlock members function into BBCooker
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 07 Jul 2015 17:50:48 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f31bca6..b4c5de0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -151,9 +151,7 @@ class BBCooker:
 
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
-        lockfile = self.data.expand("${TOPDIR}/bitbake.lock")
-        self.lock = bb.utils.lockfile(lockfile, False, False)
-        if not self.lock:
+        if not self.lockBitbake():
             bb.fatal("Only one copy of bitbake should be run against a build directory")
         try:
             self.lock.seek(0)
@@ -1544,6 +1542,19 @@ class BBCooker:
     def reset(self):
         self.initConfigurationData()
 
+    def lockBitbake(self):
+        if not hasattr(self, 'lock'):
+            self.lock = None
+            if self.data:
+                lockfile = self.data.expand("${TOPDIR}/bitbake.lock")
+                if lockfile:
+                    self.lock = bb.utils.lockfile(lockfile, False, False)
+        return self.lock
+
+    def unlockBitbake(self):
+        if hasattr(self, 'lock') and self.lock:
+            bb.utils.unlockfile(self.lock)
+
 def server_main(cooker, func, *args):
     cooker.pre_serve()
 
-- 
1.8.4.5


