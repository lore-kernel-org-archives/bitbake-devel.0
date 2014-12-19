Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 5E8BF72905
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 10:20:52 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 19 Dec 2014 02:20:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,606,1413270000"; d="scan'208";a="640218086"
Received: from khamid-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.31.61])
	by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2014 02:20:51 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Dec 2014 10:20:31 +0000
Message-Id: <4e5917581766cc0584ba0119e01333421c11c360.1418984377.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1418984377.git.paul.eggleton@linux.intel.com>
References: <cover.1418984377.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1418984377.git.paul.eggleton@linux.intel.com>
References: <cover.1418984377.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] bitbake-layers: add commands for adding and removing layers
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
X-List-Received-Date: Fri, 19 Dec 2014 10:20:53 -0000

Add add-layer and remove-layer commands for easily adding and removing
layers to/from bblayers.conf.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 9964040..edb4d2f 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -103,6 +103,60 @@ class Commands(cmd.Cmd):
             logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), layerpri))
 
 
+    def do_add_layer(self, dirname):
+        """Add a layer to bblayers.conf
+
+usage: add-layer <layerdir>
+"""
+        if not dirname:
+            sys.stderr.write("Please specify the layer directory to add\n")
+            return
+
+        layerdir = os.path.abspath(dirname)
+        if not os.path.exists(layerdir):
+            sys.stderr.write("Specified layer directory doesn't exist\n")
+            return
+
+        layer_conf = os.path.join(layerdir, 'conf', 'layer.conf')
+        if not os.path.exists(layer_conf):
+            sys.stderr.write("Specified layer directory doesn't contain a conf/layer.conf file\n")
+            return
+
+        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        if not os.path.exists(bblayers_conf):
+            sys.stderr.write("Unable to find bblayers.conf\n")
+            return
+
+        (notadded, _) = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
+        if notadded:
+            for item in notadded:
+                sys.stderr.write("Specified layer %s not in BBLAYERS\n" % item)
+
+
+    def do_remove_layer(self, dirname):
+        """Remove a layer from bblayers.conf
+
+usage: remove-layer <layerdir>
+"""
+        if not dirname:
+            sys.stderr.write("Please specify the layer directory to remove\n")
+            return
+
+        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        if not os.path.exists(bblayers_conf):
+            sys.stderr.write("Unable to find bblayers.conf\n")
+            return
+
+        if dirname.startswith('*'):
+            layerdir = dirname
+        else:
+            layerdir = os.path.abspath(dirname)
+        (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdir)
+        if notremoved:
+            for item in notremoved:
+                sys.stderr.write("No layers matching %s found in BBLAYERS\n" % item)
+
+
     def version_str(self, pe, pv, pr = None):
         verstr = "%s" % pv
         if pr:
-- 
1.9.3


