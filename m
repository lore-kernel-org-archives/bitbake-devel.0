Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 9ACB477BF0
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Apr 2017 23:19:25 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 02 Apr 2017 16:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,266,1486454400"; d="scan'208";a="243247995"
Received: from rbek-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.164.56])
	by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2017 16:19:25 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Apr 2017 11:19:04 +1200
Message-Id: <38848c9f98d5e3cd4694385ead3f2eb4a1d7ed0b.1491175014.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491175014.git.paul.eggleton@linux.intel.com>
References: <cover.1491175014.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] codeparser: improve handling of contains_any() and filter()
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
X-List-Received-Date: Sun, 02 Apr 2017 23:19:25 -0000

Ensure we handle bb.utils.contains_any() as separate items, rather than
how we handle contains() where every item must be in the list.
Additionally, enable handling bb.utils.filter() which for the purposes
of looking at dependencies is the same as contains_any().

Additionally bump the codeparser cache and recipe cache versions to
invalidate the user's existing caches (ensuring that the changes take
effect and avoiding "taskhash mismatch" errors respectively).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cache.py      |  2 +-
 lib/bb/codeparser.py | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index c04ac13..28e8a87 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -37,7 +37,7 @@ import bb.utils
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "150"
+__cache_version__ = "151"
 
 def getCacheFile(path, filename, data_hash):
     return os.path.join(path, filename + "." + data_hash)
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 89d24ab..f76b478 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -117,7 +117,7 @@ class shellCacheLine(object):
 
 class CodeParserCache(MultiProcessCache):
     cache_file_name = "bb_codeparser.dat"
-    CACHE_VERSION = 8
+    CACHE_VERSION = 9
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -193,7 +193,8 @@ class BufferedLogger(Logger):
 class PythonParser():
     getvars = (".getVar", ".appendVar", ".prependVar")
     getvarflags = (".getVarFlag", ".appendVarFlag", ".prependVarFlag")
-    containsfuncs = ("bb.utils.contains", "base_contains", "bb.utils.contains_any")
+    containsfuncs = ("bb.utils.contains", "base_contains")
+    containsanyfuncs = ("bb.utils.contains_any",  "bb.utils.filter")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
     def warn(self, func, arg):
@@ -212,13 +213,17 @@ class PythonParser():
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
-        if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs):
+        if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
             if isinstance(node.args[0], ast.Str):
                 varname = node.args[0].s
                 if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
                     if varname not in self.contains:
                         self.contains[varname] = set()
                     self.contains[varname].add(node.args[1].s)
+                elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Str):
+                    if varname not in self.contains:
+                        self.contains[varname] = set()
+                    self.contains[varname].update(node.args[1].s.split())
                 elif name.endswith(self.getvarflags):
                     if isinstance(node.args[1], ast.Str):
                         self.references.add('%s[%s]' % (varname, node.args[1].s))
-- 
2.9.3


