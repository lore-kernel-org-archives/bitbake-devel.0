Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJlzx-0005h0-MY
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 15:29:41 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 16 Apr 2012 06:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="130139157"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 16 Apr 2012 06:20:15 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 21:17:18 +0800
Message-Id: <ba697b15a5b1b106ef7c4bdf1d145c37ea85c1e2.1334582048.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334582048.git.dongxiao.xu@intel.com>
References: <cover.1334582048.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334582048.git.dongxiao.xu@intel.com>
References: <cover.1334582048.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/2] bitbake: Retain order for __depends and __base_depends
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
X-List-Received-Date: Mon, 16 Apr 2012 13:29:41 -0000

Bitbake take seriously with variables order, therefore when setting
values to __depends and __base_depends, we need to retain its order.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/cache.py          |    6 ++++--
 lib/bb/cooker.py         |    6 ++++--
 lib/bb/parse/__init__.py |   12 ++++++++----
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 47e814b..a114582 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -391,12 +391,14 @@ class Cache(object):
         """Parse the specified filename, returning the recipe information"""
         infos = []
         datastores = cls.load_bbfile(filename, appends, configdata)
-        depends = set()
+        depends = []
         for variant, data in sorted(datastores.iteritems(),
                                     key=lambda i: i[0],
                                     reverse=True):
             virtualfn = cls.realfn2virtual(filename, variant)
-            depends |= (data.getVar("__depends", False) or set())
+            for dep in (data.getVar("__depends", False) or []):
+                if dep not in depends:
+                    depends.append(dep)
             if depends and not variant:
                 data.setVar("__depends", depends)
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index dea0aad..51341fa 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -680,8 +680,10 @@ class BBCooker:
         # Generate a list of parsed configuration files by searching the files
         # listed in the __depends and __base_depends variables with a .conf suffix.
         conffiles = []
-        dep_files = self.configuration.data.getVar('__depends') or set()
-        dep_files.union(self.configuration.data.getVar('__base_depends') or set())
+        dep_files = self.configuration.data.getVar('__depends') or []
+        for dep in (self.configuration.data.getVar('__base_depends') or []):
+            if dep not in dep_files:
+                dep_files.append(dep)
 
         for f in dep_files:
             if f[0].endswith(".conf"):
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 7b9c47e..f223ff9 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -73,8 +73,10 @@ def update_mtime(f):
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-    deps = d.getVar('__depends') or set()
-    deps.update([(f, cached_mtime(f))])
+    deps = d.getVar('__depends') or []
+    t = cached_mtime(f)
+    if (f, t) not in deps:
+        deps.append((f, t))
     d.setVar('__depends', deps)
 
 def supports(fn, data):
@@ -134,8 +136,10 @@ def vars_from_file(mypkg, d):
 def get_file_depends(d):
     '''Return the dependent files'''
     dep_files = []
-    depends = d.getVar('__depends', True) or set()
-    depends = depends.union(d.getVar('__base_depends', True) or set())
+    depends = d.getVar('__depends', True) or []
+    for dep in (d.getVar('__base_depends', True) or []):
+        if dep not in depends:
+            depends.append(dep)
     for (fn, _) in depends:
         dep_files.append(os.path.abspath(fn))
     return " ".join(dep_files)
-- 
1.7.4.1



