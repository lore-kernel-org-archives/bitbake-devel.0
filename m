Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDahH-00034G-EJ
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 14:12:51 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 30 Mar 2012 05:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="123584334"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 30 Mar 2012 05:03:47 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 20:01:16 +0800
Message-Id: <28ccf8cd2d23a4cfc8e94fa1ad089dd68334bf35.1333108781.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333108781.git.dongxiao.xu@intel.com>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333108781.git.dongxiao.xu@intel.com>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
Subject: [PATCH 4/7] Revert "lib/bb/ui/crumbs/hig: fix layers_changed test"
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
X-List-Received-Date: Fri, 30 Mar 2012 12:12:51 -0000

We do not sort the layer list, therefore when response_cb, the ordering
is also not needed.

This reverts commit 71c1de347eef07a2059fc4544dc3cae090181f44.
---
 lib/bb/ui/crumbs/hig.py |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 9a38bc0..0ac4496 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -958,10 +958,7 @@ class LayerSelectionDialog (CrumbsDialog):
             layers.append(model.get_value(it, 0))
             it = model.iter_next(it)
 
-        orig_layers = sorted(self.layers)
-        layers.sort()
-
-        self.layers_changed = (orig_layers != layers)
+        self.layers_changed = (self.layers != layers)
         self.layers = layers
 
     """
-- 
1.7.4.1



