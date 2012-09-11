Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TBTtF-0002uw-Gl
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Sep 2012 19:04:45 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Sep 2012 09:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,406,1344236400"; d="scan'208";a="191458841"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.206])
	by azsmga001.ch.intel.com with ESMTP; 11 Sep 2012 09:52:09 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Sep 2012 17:51:59 +0100
Message-Id: <1d0b24190ed3cc08ef87691665ddc24cbe46dec6.1347382193.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1347382193.git.paul.eggleton@linux.intel.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1347382193.git.paul.eggleton@linux.intel.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] hob: don't reorder layers list
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
X-List-Received-Date: Tue, 11 Sep 2012 17:04:45 -0000

We cannot reorder this list - it must stay in the order shown in the
dialog (which may in future be configurable by the user).

Fixes [YOCTO #2649].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 3695fa0..d41a6b5 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1029,14 +1029,8 @@ class LayerSelectionDialog (CrumbsDialog):
         table_layer.attach(scroll, 0, 10, 0, 1)
 
         layer_store = gtk.ListStore(gobject.TYPE_STRING)
-        core_iter = None
         for layer in layers:
-            if layer.endswith("/meta"):
-                core_iter = layer_store.prepend([layer])
-            elif layer.endswith("/meta-hob") and core_iter:
-                layer_store.insert_after(core_iter, [layer])
-            else:
-                layer_store.append([layer])
+            layer_store.append([layer])
 
         col1 = gtk.TreeViewColumn('Enabled')
         layer_tv.append_column(col1)
@@ -1110,10 +1104,7 @@ class LayerSelectionDialog (CrumbsDialog):
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
1.7.9.5



