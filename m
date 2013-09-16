Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 63EB86C802
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 13:33:17 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 16 Sep 2013 06:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,915,1371106800"; d="scan'208";a="378890905"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 16 Sep 2013 06:33:18 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 4C0F25606E0; Mon, 16 Sep 2013 14:33:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 14:33:14 +0100
Message-Id: <039a39382824feb5ed5e28a8beb40855a6657170.1379338189.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/7] bitbake: cooker: add extra recipe information
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
X-List-Received-Date: Mon, 16 Sep 2013 13:33:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding in the extra recipe information when creating
the dependency tree information.

This works in server-mode because the HOB extra_cache
is already enabled. In normal mode, it will do nothing
with no performance impact.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/cooker.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 68a3c01..cb0e3e5 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -439,6 +439,29 @@ class BBCooker:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
                 depend_tree["pn"][pn]["version"] = version
+
+                # This data is needed for webhob;
+                # it's here if the bitbake runs in server mode
+                try:
+                    summary = self.recipecache.summary[fn]
+                    lic = self.recipecache.license[fn]
+                    section = self.recipecache.section[fn]
+                    description = self.recipecache.description[fn]
+                    homepage = self.recipecache.homepage[fn]
+                    bugtracker = self.recipecache.bugtracker[fn]
+                    inherits = self.recipecache.inherits.get(fn, None)
+                    depend_tree["pn"][pn]["filename"] = fn
+                    depend_tree["pn"][pn]["version"] = version
+                    depend_tree["pn"][pn]["summary"] = summary
+                    depend_tree["pn"][pn]["license"] = lic
+                    depend_tree["pn"][pn]["section"] = section
+                    depend_tree["pn"][pn]["description"] = description
+                    depend_tree["pn"][pn]["inherits"] = inherits
+                    depend_tree["pn"][pn]["homepage"] = homepage
+                    depend_tree["pn"][pn]["bugtracker"] = bugtracker
+                except:
+                    pass
+
             for dep in rq.rqdata.runq_depends[task]:
                 depfn = taskdata.fn_index[rq.rqdata.runq_fnid[dep]]
                 deppn = self.recipecache.pkg_fn[depfn]
-- 
1.8.1.2


