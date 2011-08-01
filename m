Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QnxG9-0001pg-Gz
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 20:30:37 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="34344107"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 11:30:48 -0700
Message-Id: <906854d75a12c8752efb1e4065eaf1a10b191612.1312216779.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
Subject: [PATCH 6/8] ui/crumbs/configurator: tweak addLayerConf return values
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
X-List-Received-Date: Mon, 01 Aug 2011 18:30:37 -0000

Use different return types when adding failed versus when the layer is
already enabled.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index e558c95..e17d555 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -158,11 +158,14 @@ class Configurator(gobject.GObject):
     def addLayerConf(self, confpath):
         layerpath = self._splitLayer(confpath)
         name = self._getLayerName(layerpath)
-        if name not in self.enabled_layers:
+
+        if not layerpath or not name:
+            return None, None
+        elif name not in self.enabled_layers:
             self.addLayer(name, layerpath)
             return name, layerpath
         else:
-            return None, None
+            return name, None
 
     def addLayer(self, name, path):
         self.enabled_layers[name] = path
-- 
1.7.6



