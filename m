Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SBEtr-0001JU-2K
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:32:07 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 17:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121096255"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.82])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:23:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 17:22:59 -0700
Message-Id: <dda67dfb43279c2f605ce88a84c0adb9a83f9dfd.1332545580.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
Subject: [PATCH 1/9] lib/bb/ui/crumbs/hig: sort layers in Layer Selection dialogue
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
X-List-Received-Date: Sat, 24 Mar 2012 00:32:07 -0000

The two layers which cannot be removed, meta and meta-hob, should be the
first two items in the tree view.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 1db93ea..3a66e7c 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -803,8 +803,14 @@ class LayerSelectionDialog (CrumbsDialog):
         table_layer.attach(scroll, 0, 10, 0, 1)
 
         layer_store = gtk.ListStore(gobject.TYPE_STRING)
+        core_iter = None
         for layer in layers:
-            layer_store.set(layer_store.append(), 0, layer)
+            if layer.endswith("/meta"):
+                core_iter = layer_store.prepend([layer])
+            elif layer.endswith("/meta-hob") and core_iter:
+                layer_store.insert_after(core_iter, [layer])
+            else:
+                layer_store.append([layer])
 
         col1 = gtk.TreeViewColumn('Enabled')
         layer_tv.append_column(col1)
-- 
1.7.7.6



