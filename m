Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2F76960CEB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Mar 2014 16:55:16 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 03 Mar 2014 08:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,578,1389772800"; d="scan'208";a="465598574"
Received: from dmilliga-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.25])
	by orsmga001.jf.intel.com with ESMTP; 03 Mar 2014 08:54:36 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Mar 2014 16:54:31 +0000
Message-Id: <04bc679e9cd615a2149526c8442c48ec4a30aaa1.1393865613.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <cover.1393865613.git.paul.eggleton@linux.intel.com>
References: <cover.1393865613.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1393865613.git.paul.eggleton@linux.intel.com>
References: <cover.1393865613.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] data: add vardepvalueexclude varflag
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
X-List-Received-Date: Mon, 03 Mar 2014 16:55:18 -0000

On rare occasions it's useful to be able to exclude a part of a
variable's value from the variable's signature; for example if you want
to add an item to a list sometimes and not have the signature of the
variable change depending on whether the item is in the list or not. The
initial intended use case for this in OpenEmbedded is to allow adding a
function to SSTATEPOSTINSTFUNCS in buildhistory.bbclass and not have
that change any task signatures (so adding and removing
INHERIT += "buildhistory" won't lead to any rebuilds).

Part of the fix for [YOCTO #5897].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/data.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index a56b79c..db938be 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -295,7 +295,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             deps |= parser.references
             deps = deps | (keys & parser.execs)
             return deps, value
-        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "postfuncs", "prefuncs"]) or {}
+        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "vardepvalueexclude", "postfuncs", "prefuncs"]) or {}
         vardeps = varflags.get("vardeps")
         value = d.getVar(key, False)
 
@@ -345,6 +345,12 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             deps = deps | (keys & parser.execs)
             value = handle_contains(value, parser.contains, d)
 
+        if "vardepvalueexclude" in varflags:
+            exclude = varflags.get("vardepvalueexclude")
+            for excl in exclude.split('|'):
+                if excl:
+                    value = value.replace(excl, '')
+
         # Add varflags, assuming an exclusion list is set
         if varflagsexcl:
             varfdeps = []
-- 
1.8.5.3


