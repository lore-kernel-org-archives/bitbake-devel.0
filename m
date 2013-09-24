Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5D4336CB6D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:12 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="400405775"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 6178E562CF7; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:55 +0100
Message-Id: <65c8e913c39fcaed29ed8917b7e9e6dc60814c40.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 86/94] bitbake: cooker: add the inherits attribute to the dependency tree
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The built dependency tree has to have the inherits attribute
so that the UIs can use and save this information.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ff2af69..9ed22c7 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -481,6 +481,7 @@ class BBCooker:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
                 depend_tree["pn"][pn]["version"] = version
+                depend_tree["pn"][pn]["inherits"] = self.recipecache.inherits.get(fn, None)
 
                 # if we have extra caches, list all attributes they bring in
                 extra_info = []
-- 
1.8.1.2


