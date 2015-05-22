Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 5F22474230
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 May 2015 15:42:37 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 May 2015 08:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,476,1427785200"; d="scan'208";a="575490665"
Received: from cestaunt-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.15.40])
	by orsmga003.jf.intel.com with ESMTP; 22 May 2015 08:42:38 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 May 2015 16:42:21 +0100
Message-Id: <b640c924c0a87945cb8ab42dae9c90435d03c084.1432309249.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1432309249.git.paul.eggleton@linux.intel.com>
References: <cover.1432309249.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1432309249.git.paul.eggleton@linux.intel.com>
References: <cover.1432309249.git.paul.eggleton@linux.intel.com>
Subject: [1.26][PATCH 1/2] lib/bb/utils: add function to get layer containing a file
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
X-List-Received-Date: Fri, 22 May 2015 15:42:37 -0000

In certain contexts it can be useful to find the layer that a file (e.g.
a recipe) appears in.

Implements [YOCTO #7723].

(Bitbake master rev: 3bf9c8830c5d5eea5502230d5af84ebd87ad5849)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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


