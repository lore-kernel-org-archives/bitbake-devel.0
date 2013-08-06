Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8ECD56B1A0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Aug 2013 11:13:28 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 06 Aug 2013 04:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,825,1367996400"; d="scan'208";a="358312294"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.203])
	by orsmga001.jf.intel.com with ESMTP; 06 Aug 2013 04:13:15 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Aug 2013 12:13:11 +0100
Message-Id: <86a48ff3ebd368009a7d59f15ebf3287df73ab08.1375787400.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1375787400.git.paul.eggleton@linux.intel.com>
References: <cover.1375787400.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1375787400.git.paul.eggleton@linux.intel.com>
References: <cover.1375787400.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 20/21] depexp: insert data instead of append/set, for speed
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
X-List-Received-Date: Tue, 06 Aug 2013 11:13:30 -0000

From: Ross Burton <ross.burton@intel.com>

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/ui/depexp.py | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index b7e6f8f..03ed823 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -165,21 +165,15 @@ class DepExplorer(gtk.Window):
 
     def parse(self, depgraph):
         for package in depgraph["pn"]:
-            self.pkg_model.set(self.pkg_model.append(), COL_PKG_NAME, package)
+            self.pkg_model.insert(0, (package,))
 
         for package in depgraph["depends"]:
             for depend in depgraph["depends"][package]:
-                self.depends_model.set (self.depends_model.append(),
-                                        COL_DEP_TYPE, TYPE_DEP,
-                                        COL_DEP_PARENT, package,
-                                        COL_DEP_PACKAGE, depend)
+                self.depends_model.insert (0, (TYPE_DEP, package, depend))
 
         for package in depgraph["rdepends-pn"]:
             for rdepend in depgraph["rdepends-pn"][package]:
-                self.depends_model.set (self.depends_model.append(),
-                                        COL_DEP_TYPE, TYPE_RDEP,
-                                        COL_DEP_PARENT, package,
-                                        COL_DEP_PACKAGE, rdepend)
+                self.depends_model.insert (0, (TYPE_RDEP, package, rdepend))
 
 
 class gtkthread(threading.Thread):
-- 
1.8.1.2


