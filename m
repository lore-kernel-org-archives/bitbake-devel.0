Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SKNuo-0004RD-TR
	for bitbake-devel@lists.openembedded.org;
	Wed, 18 Apr 2012 07:58:55 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 17 Apr 2012 22:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="90344536"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 17 Apr 2012 22:49:26 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Apr 2012 13:46:27 +0800
Message-Id: <4298ae4a73ae722713ae1c21258d15c2829d7866.1334727847.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334727847.git.dongxiao.xu@intel.com>
References: <cover.1334727847.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334727847.git.dongxiao.xu@intel.com>
References: <cover.1334727847.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/1] bitbake: Retain order for __depends and __base_depends
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
X-List-Received-Date: Wed, 18 Apr 2012 05:58:55 -0000

Bitbake take seriously with variables order, therefore when setting
values to __depends and __base_depends, we need to retain its order.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/cache.py          |   15 +++++++++++----
 lib/bb/cooker.py         |    4 ++--
 lib/bb/parse/__init__.py |    8 ++++----
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 47e814b..27d9be8 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -391,14 +391,21 @@ class Cache(object):
         """Parse the specified filename, returning the recipe information"""
         infos = []
         datastores = cls.load_bbfile(filename, appends, configdata)
-        depends = set()
+        depdict = {}
         for variant, data in sorted(datastores.iteritems(),
                                     key=lambda i: i[0],
                                     reverse=True):
             virtualfn = cls.realfn2virtual(filename, variant)
-            depends |= (data.getVar("__depends", False) or set())
-            if depends and not variant:
+            if not variant:
+                base = data.getVar("__depends", False) or []
+                depends = base[:]
+                for var in depdict.values():
+                    for item in var:
+                        if item not in base:
+                            depends.append(item)
                 data.setVar("__depends", depends)
+            else:
+                depdict[variant] = data.getVar("__depends", False) or []
 
             info_array = []
             for cache_class in caches_array:
@@ -497,7 +504,7 @@ class Cache(object):
         # Check dependencies are still valid
         depends = info_array[0].file_depends
         if depends:
-            for f, old_mtime in depends:
+            for f, old_mtime in set(depends):
                 fmtime = bb.parse.cached_mtime_noerror(f)
                 # Check if file still exists
                 if old_mtime != 0 and fmtime == 0:
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index dea0aad..8c2b35d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -680,8 +680,8 @@ class BBCooker:
         # Generate a list of parsed configuration files by searching the files
         # listed in the __depends and __base_depends variables with a .conf suffix.
         conffiles = []
-        dep_files = self.configuration.data.getVar('__depends') or set()
-        dep_files.union(self.configuration.data.getVar('__base_depends') or set())
+        dep_files = self.configuration.data.getVar('__base_depends') or []
+        dep_files += (self.configuration.data.getVar('__depends') or [])
 
         for f in dep_files:
             if f[0].endswith(".conf"):
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 7b9c47e..30f6254 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -73,8 +73,8 @@ def update_mtime(f):
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-    deps = d.getVar('__depends') or set()
-    deps.update([(f, cached_mtime(f))])
+    deps = d.getVar('__depends') or []
+    deps.append((f, cached_mtime(f)))
     d.setVar('__depends', deps)
 
 def supports(fn, data):
@@ -134,8 +134,8 @@ def vars_from_file(mypkg, d):
 def get_file_depends(d):
     '''Return the dependent files'''
     dep_files = []
-    depends = d.getVar('__depends', True) or set()
-    depends = depends.union(d.getVar('__base_depends', True) or set())
+    base_depends = d.getVar('__base_depends', True) or []
+    depends = base_depends + (d.getVar('__depends', True) or [])
     for (fn, _) in depends:
         dep_files.append(os.path.abspath(fn))
     return " ".join(dep_files)
-- 
1.7.4.1



