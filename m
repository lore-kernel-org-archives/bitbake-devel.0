Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkUIZ-0005rW-NG
	for bitbake-devel@lists.openembedded.org;
	Sat, 23 Jul 2011 06:58:47 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 21:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,251,1309762800"; d="scan'208";a="31029051"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.127])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 21:54:36 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 21:54:24 -0700
Message-Id: <4b98358d98b8f4c1a05fdcee562ddc78e1708c48.1311396521.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
Subject: [PATCH 5/8] hob: only add new layer's to the UI
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
X-List-Received-Date: Sat, 23 Jul 2011 04:58:47 -0000

If a user added the same layer more than once the underlying bblayers.conf
file would not have multiple entries but the UI would show an entry for
the layer for each time it was added. This patch changes the Configurator
to return None values if the layer wasn't added to bblayers.conf and the
LayerEditor to only update the UI if non-None values are returned.

Fixes [YOCTO #1275]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py |    4 +++-
 lib/bb/ui/crumbs/layereditor.py  |    5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index 5511799..e7c524a 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -139,7 +139,9 @@ class Configurator(gobject.GObject):
         name = self._getLayerName(layerpath)
         if name not in self.enabled_layers:
             self.addLayer(name, layerpath)
-        return name, layerpath
+            return name, layerpath
+        else:
+            return None, None
 
     def addLayer(self, name, path):
         self.enabled_layers[name] = path
diff --git a/lib/bb/ui/crumbs/layereditor.py b/lib/bb/ui/crumbs/layereditor.py
index 76a2eb5..7c581d6 100644
--- a/lib/bb/ui/crumbs/layereditor.py
+++ b/lib/bb/ui/crumbs/layereditor.py
@@ -132,5 +132,6 @@ class LayerEditor(gtk.Dialog):
             # FIXME: verify we've actually got a layer conf?
             if path.endswith(".conf"):
                 name, layerpath = self.configurator.addLayerConf(path)
-                self.newly_added[name] = layerpath
-                self.layer_store.append([name, layerpath, True])
+                if name:
+                    self.newly_added[name] = layerpath
+                    self.layer_store.append([name, layerpath, True])
-- 
1.7.6



