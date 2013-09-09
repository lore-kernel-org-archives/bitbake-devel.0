Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 328176BF6D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:09 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 09 Sep 2013 09:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="357952879"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 09 Sep 2013 09:41:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 8F57D5612A8; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:41:04 +0100
Message-Id: <3155d41c6b20caebf7f7129f0e219eca4612022c.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 13/13] bitbake: cooker: add extra recipe information
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:09 -0000

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
index 1eb1768..bad930b 100644
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
+                except KeyError:
+                    pass
+
             for dep in rq.rqdata.runq_depends[task]:
                 depfn = taskdata.fn_index[rq.rqdata.runq_fnid[dep]]
                 deppn = self.recipecache.pkg_fn[depfn]
-- 
1.8.1.2


