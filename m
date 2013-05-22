Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7ADCB6968C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2013 14:25:29 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 22 May 2013 07:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,721,1363158000"; d="scan'208";a="338233578"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.181])
	by fmsmga001.fm.intel.com with ESMTP; 22 May 2013 07:25:21 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2013 15:25:13 +0100
Message-Id: <197234bc28fcf7439aac087625e540bbaea22af6.1369232029.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1369232029.git.paul.eggleton@linux.intel.com>
References: <cover.1369232029.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1369232029.git.paul.eggleton@linux.intel.com>
References: <cover.1369232029.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] cookerdata: rename _parse to parse_config_file
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 May 2013 14:25:29 -0000

We use this externally in the OE layer index update script, so it
shouldn't really be named as an internal function.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cookerdata.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 70e22b4..c4a28c8 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -147,7 +147,7 @@ def catch_parse_error(func):
     return wrapped
 
 @catch_parse_error
-def _parse(fn, data, include=True):
+def parse_config_file(fn, data, include=True):
     return bb.parse.handle(fn, data, include)
 
 @catch_parse_error
@@ -211,12 +211,12 @@ class CookerDataBuilder(object):
 
         # Parse files for loading *before* bitbake.conf and any includes
         for f in prefiles:
-            data = _parse(f, data)
+            data = parse_config_file(f, data)
 
         layerconf = self._findLayerConf()
         if layerconf:
             parselog.debug(2, "Found bblayers.conf (%s)", layerconf)
-            data = _parse(layerconf, data)
+            data = parse_config_file(layerconf, data)
 
             layers = (data.getVar('BBLAYERS', True) or "").split()
 
@@ -224,7 +224,7 @@ class CookerDataBuilder(object):
             for layer in layers:
                 parselog.debug(2, "Adding layer %s", layer)
                 data.setVar('LAYERDIR', layer)
-                data = _parse(os.path.join(layer, "conf", "layer.conf"), data)
+                data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
                 data.expandVarref('LAYERDIR')
 
             data.delVar('LAYERDIR')
@@ -232,11 +232,11 @@ class CookerDataBuilder(object):
         if not data.getVar("BBPATH", True):
             raise SystemExit("The BBPATH variable is not set")
 
-        data = _parse(os.path.join("conf", "bitbake.conf"), data)
+        data = parse_config_file(os.path.join("conf", "bitbake.conf"), data)
 
         # Parse files for loading *after* bitbake.conf and any includes
         for p in postfiles:
-            data = _parse(p, data)
+            data = parse_config_file(p, data)
 
         # Handle any INHERITs and inherit the base class
         bbclasses  = ["base"] + (data.getVar('INHERIT', True) or "").split()
-- 
1.8.1.2


