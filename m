Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 5529575894
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 11:17:24 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 08 Jan 2016 03:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,538,1444719600"; d="scan'208";a="722947288"
Received: from deryaeke-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.84])
	by orsmga003.jf.intel.com with ESMTP; 08 Jan 2016 03:17:24 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jan 2016 11:17:15 +0000
Message-Id: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1452251694.git.elliot.smith@intel.com>
References: <cover.1452251694.git.elliot.smith@intel.com>
Subject: [PATCH 1/8] taskdata: refactor get_providermap
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
X-List-Received-Date: Fri, 08 Jan 2016 11:17:25 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added optional parameter 'prefix' to filter out names that
don't start with specified prefix. Changed existing call
of get_providermap according to changed API.

Optimized the code: got rid of extra loop and temporary
list variable virts.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/runqueue.py |  2 +-
 lib/bb/taskdata.py | 17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ee06f0e..7fd0044 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -808,7 +808,7 @@ class RunQueueData:
                     invalidate_task(fn, st, True)
 
         # Create and print to the logs a virtual/xxxx -> PN (fn) table
-        virtmap = taskData.get_providermap()
+        virtmap = taskData.get_providermap(prefix="virtual/")
         virtpnmap = {}
         for v in virtmap:
             virtpnmap[v] = self.dataCache.pkg_fn[virtmap[v]]
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 4d12b33..b083870 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -612,17 +612,14 @@ class TaskData:
                 break
         # self.dump_data()
 
-    def get_providermap(self):
-        virts = []
-        virtmap = {}
-
+    def get_providermap(self, prefix=None):
+        provmap = {}
         for name in self.build_names_index:
-            if name.startswith("virtual/"):
-                virts.append(name)
-        for v in virts:
-            if self.have_build_target(v):
-                virtmap[v] = self.fn_index[self.get_provider(v)[0]]
-        return virtmap
+            if prefix and not name.startswith(prefix):
+                continue
+            if self.have_build_target(name):
+                provmap[name] = self.fn_index[self.get_provider(name)[0]]
+        return provmap
 
     def dump_data(self):
         """
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


