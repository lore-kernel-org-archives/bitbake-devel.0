Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SArcA-0001zq-7U
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 00:40:18 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 16:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124076813"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 16:31:14 -0700
Message-Id: <50a9f6ded13279e063a11464ad86fbd6e20c8ec0.1332458487.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
Subject: [PATCH 9/9] lib/bb/ui/crumbs/builder: change dialogue title to Layers
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
X-List-Received-Date: Thu, 22 Mar 2012 23:40:18 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index ce03834..2fe67d9 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -664,7 +664,7 @@ class Builder(gtk.Window):
         binb_dialog.destroy()
 
     def show_layer_selection_dialog(self):
-        dialog = LayerSelectionDialog(title = "Layer Selection",
+        dialog = LayerSelectionDialog(title = "Layers",
                      layers = copy.deepcopy(self.configuration.layers),
                      all_layers = self.parameters.all_layers,
                      parent = self,
-- 
1.7.7.6



