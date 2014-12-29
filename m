Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 3DA11724D8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Dec 2014 11:14:55 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 29 Dec 2014 03:14:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,659,1413270000"; d="scan'208";a="630312987"
Received: from brvijay-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.0.132])
	by orsmga001.jf.intel.com with ESMTP; 29 Dec 2014 03:14:32 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Dec 2014 11:14:26 +0000
Message-Id: <49ccd5d8ad0d87b5610301d38e6af28d87016b80.1419851448.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1419851448.git.paul.eggleton@linux.intel.com>
References: <cover.1419851448.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1419851448.git.paul.eggleton@linux.intel.com>
References: <cover.1419851448.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake-layers: fix error handling in add-layer / remove-layer
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
X-List-Received-Date: Mon, 29 Dec 2014 11:14:57 -0000

* Fix add-layer error message when a layer is already in BBLAYERS
* Ensure we show an error message if we can't find BBLAYERS at all

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 2 +-
 lib/bb/utils.py    | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index edb4d2f..9879498 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -130,7 +130,7 @@ usage: add-layer <layerdir>
         (notadded, _) = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
         if notadded:
             for item in notadded:
-                sys.stderr.write("Specified layer %s not in BBLAYERS\n" % item)
+                sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
 
 
     def do_remove_layer(self, dirname):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f26349f..ef8cd4d 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1012,7 +1012,11 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
     addlayers = layerlist_param(add)
     removelayers = layerlist_param(remove)
 
+    # Need to use a list here because we can't set non-local variables from a callback in python 2.x
+    bblayercalls = []
+
     def handle_bblayers(varname, origvalue):
+        bblayercalls.append(varname)
         updated = False
         bblayers = [remove_trailing_sep(x) for x in origvalue.split()]
         if removelayers:
@@ -1040,5 +1044,9 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
             return (origvalue, 2, False)
 
     edit_metadata_file(bblayers_conf, ['BBLAYERS'], handle_bblayers)
+
+    if not bblayercalls:
+        raise Exception('Unable to find BBLAYERS in %s' % bblayers_conf)
+
     return (notadded, notremoved)
 
-- 
1.9.3


