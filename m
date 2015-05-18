Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 39F2265C9C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 15:08:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 18 May 2015 08:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,453,1427785200"; d="scan'208";a="696616661"
Received: from jmcmill1-mobl3.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.0.158])
	by orsmga001.jf.intel.com with ESMTP; 18 May 2015 08:08:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2015 16:08:34 +0100
Message-Id: <7e2b5f6edd9291dca072e872f2a5597d5a1c7e22.1431961693.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1431961693.git.paul.eggleton@linux.intel.com>
References: <cover.1431961693.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1431961693.git.paul.eggleton@linux.intel.com>
References: <cover.1431961693.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] lib/bb/utils: add function to get layer containing a file
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
X-List-Received-Date: Mon, 18 May 2015 15:08:49 -0000

In certain contexts it can be useful to find the layer that a file (e.g.
a recipe) appears in.

Implements [YOCTO #7723].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index c97f3ef..1681efd 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1097,3 +1097,19 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
 
     return (notadded, notremoved)
 
+
+def get_file_layer(filename, d):
+    """Determine the collection (as defined by a layer's layer.conf file) containing the specified file"""
+    collections = (d.getVar('BBFILE_COLLECTIONS', True) or '').split()
+    collection_res = {}
+    for collection in collections:
+        collection_res[collection] = d.getVar('BBFILE_PATTERN_%s' % collection, True) or ''
+
+    # Use longest path so we handle nested layers
+    matchlen = 0
+    match = None
+    for collection, regex in collection_res.iteritems():
+        if len(regex) > matchlen and re.match(regex, filename):
+            matchlen = len(regex)
+            match = collection
+    return match
-- 
2.1.0


