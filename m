Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id B88AE77D24
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Apr 2017 23:19:23 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 02 Apr 2017 16:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,266,1486454400"; d="scan'208";a="243247994"
Received: from rbek-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.164.56])
	by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2017 16:19:23 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Apr 2017 11:19:03 +1200
Message-Id: <969d16a740607be9477d19ed9ef04dbbeae2548a.1491175014.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491175014.git.paul.eggleton@linux.intel.com>
References: <cover.1491175014.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] lib/bb/data: fix dependency handling for contains and multiple values
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
X-List-Received-Date: Sun, 02 Apr 2017 23:19:24 -0000

The code that determines variable dependencies uses the codeparser to
find references to "contains" type operations e.g. bb.utils.contains().
That function can take multiple items to check, and all specified items
have to be present. However this code didn't handle that - it assumed
that only one item would be specified and thus it was treating the
multiple items as a single item with spaces in between. Split the value
and check if all words are present in order to determine whether the
check is "set" or "unset".

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/data.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index a85cb3a..0403754 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -296,11 +296,13 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             newvalue = ""
             for k in sorted(contains):
                 l = (d.getVar(k) or "").split()
-                for word in sorted(contains[k]):
-                    if word in l:
-                        newvalue += "\n%s{%s} = Set" %  (k, word)
+                for item in sorted(contains[k]):
+                    for word in item.split():
+                        if not word in l:
+                            newvalue += "\n%s{%s} = Unset" % (k, item)
+                            break
                     else:
-                        newvalue += "\n%s{%s} = Unset" %  (k, word)
+                        newvalue += "\n%s{%s} = Set" % (k, item)
             if not newvalue:
                 return value
             if not value:
-- 
2.9.3


