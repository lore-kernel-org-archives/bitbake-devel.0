Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1S2DpI-0002wA-1I
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 04:34:08 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 27 Feb 2012 19:25:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="115499047"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.62])
	by orsmga002.jf.intel.com with ESMTP; 27 Feb 2012 19:24:39 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Feb 2012 11:22:40 +0800
Message-Id: <4b271df2df289b005593cf4f1e176434e6a6d852.1330399220.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1330399220.git.lianhao.lu@intel.com>
References: <cover.1330399220.git.lianhao.lu@intel.com>
Subject: [PATCH V2 1/1] bitbake: Added BBINCLUDED variable.
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
X-List-Received-Date: Tue, 28 Feb 2012 03:34:08 -0000

Added new variable BBINCLUDED indicating the file dependency
information. It exposes the internal variable '__base_depends' and
'__depends'.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 bitbake/lib/bb/cooker.py         |    1 +
 bitbake/lib/bb/parse/__init__.py |    9 +++++++++
 bitbake/lib/bb/parse/ast.py      |    2 ++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 12b526b..6ddd960 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -893,6 +893,7 @@ class BBCooker:
         bb.codeparser.parser_cache_init(data)
         bb.event.fire(bb.event.ConfigParsed(), data)
         bb.parse.init_parser(data)
+        data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
         self.configuration.data = data
         self.configuration.data_hash = data.get_hash()
 
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 8b7ec73..7b9c47e 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -131,4 +131,13 @@ def vars_from_file(mypkg, d):
     parts.extend(tmplist)
     return parts
 
+def get_file_depends(d):
+    '''Return the dependent files'''
+    dep_files = []
+    depends = d.getVar('__depends', True) or set()
+    depends = depends.union(d.getVar('__base_depends', True) or set())
+    for (fn, _) in depends:
+        dep_files.append(os.path.abspath(fn))
+    return " ".join(dep_files)
+
 from bb.parse.parse_py import __version__, ConfHandler, BBHandler
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 94fa175..7cef3d0 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -328,6 +328,8 @@ def finalize(fn, d, variant = None):
 
     bb.parse.siggen.finalise(fn, d, variant)
 
+    d.setVar('BBINCLUDED', bb.parse.get_file_depends(d))
+
     bb.event.fire(bb.event.RecipeParsed(fn), d)
 
 def _create_variants(datastores, names, function):
-- 
1.7.0.4



