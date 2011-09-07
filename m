Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R1Pj9-0000hA-Jb
	for bitbake-devel@lists.openembedded.org;
	Wed, 07 Sep 2011 23:32:11 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 07 Sep 2011 14:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,347,1312182000"; d="scan'208";a="49049539"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.159])
	by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2011 14:27:07 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Sep 2011 14:27:01 -0700
Message-Id: <0238d6b802f0620dcda8c8997a1b2988b71408dc.1315406971.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315406971.git.josh@linux.intel.com>
References: <cover.1315406971.git.josh@linux.intel.com>
In-Reply-To: <cover.1315406971.git.josh@linux.intel.com>
References: <cover.1315406971.git.josh@linux.intel.com>
Subject: [PATCH 1/1] cache|cooker|parse: switch __depends from a set to a dict
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
X-List-Received-Date: Wed, 07 Sep 2011 21:32:11 -0000

The set container cannot be marshalled by Python's xmlrpclib meaning that
we cannot interact with the __depends variable via the [get|set]Variable
command API.

This patch changes the code to use a dict instead of a set to store the
__depends mapping of filename to mtime.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cache.py          |   11 ++++++-----
 lib/bb/cooker.py         |    8 ++++----
 lib/bb/parse/__init__.py |    4 ++--
 lib/bb/ui/hob.py         |    8 ++++----
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index d495f9e..ba77f50 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -43,7 +43,7 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "142"
+__cache_version__ = "143"
 
 def getCacheFile(path, filename):
     return os.path.join(path, filename)
@@ -282,7 +282,7 @@ class Cache(object):
         newest_mtime = 0
         deps = bb.data.getVar("__base_depends", data)
 
-        old_mtimes = [old_mtime for _, old_mtime in deps]
+        old_mtimes = deps.values()
         old_mtimes.append(newest_mtime)
         newest_mtime = max(old_mtimes)
 
@@ -406,12 +406,12 @@ class Cache(object):
         """Parse the specified filename, returning the recipe information"""
         infos = []
         datastores = cls.load_bbfile(filename, appends, configdata)
-        depends = set()
+        depends = {}
         for variant, data in sorted(datastores.iteritems(),
                                     key=lambda i: i[0],
                                     reverse=True):
             virtualfn = cls.realfn2virtual(filename, variant)
-            depends |= (data.getVar("__depends", False) or set())
+            depends.update(data.getVar("__depends", False) or {})
             if depends and not variant:
                 data.setVar("__depends", depends)
 
@@ -512,8 +512,9 @@ class Cache(object):
         # Check dependencies are still valid
         depends = info_array[0].file_depends
         if depends:
-            for f, old_mtime in depends:
+            for f in depends:
                 fmtime = bb.parse.cached_mtime_noerror(f)
+                old_mtime = depends[f]
                 # Check if file still exists
                 if old_mtime != 0 and fmtime == 0:
                     logger.debug(2, "Cache: %s's dependency %s was removed",
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a0fcc15..e2bbb48 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -627,12 +627,12 @@ class BBCooker:
         # Generate a list of parsed configuration files by searching the files
         # listed in the __depends and __base_depends variables with a .conf suffix.
         conffiles = []
-        dep_files = bb.data.getVar('__depends', self.configuration.data) or set()
-        dep_files.union(bb.data.getVar('__base_depends', self.configuration.data) or set())
+        dep_files = bb.data.getVar('__depends', self.configuration.data) or {}
+        dep_files.update(bb.data.getVar('__base_depends', self.configuration.data) or {})
 
         for f in dep_files:
-            if f[0].endswith(".conf"):
-                conffiles.append(f[0])
+            if f.endswith(".conf"):
+                conffiles.append(f)
 
         _, conf, conffile = path.rpartition("conf/")
         match = os.path.join(conf, conffile)
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index eee8d9c..31a35f9 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -62,8 +62,8 @@ def update_mtime(f):
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-    deps = bb.data.getVar('__depends', d) or set()
-    deps.update([(f, cached_mtime(f))])
+    deps = bb.data.getVar('__depends', d) or {}
+    deps[f] =  cached_mtime(f)
     bb.data.setVar('__depends', deps, d)
 
 def supports(fn, data):
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 84df37d..39731fa 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -994,12 +994,12 @@ def main (server, eventHandler):
     # We hope to adjust this long term as tracked in Yocto Bugzilla #1441
     # http://bugzilla.pokylinux.org/show_bug.cgi?id=1441
     reqfiles = 0
-    dep_files = server.runCommand(["getVariable", "__depends"]) or set()
-    dep_files.union(server.runCommand(["getVariable", "__base_depends"]) or set())
+    dep_files = server.runCommand(["getVariable", "__depends"]) or {}
+    dep_files.update(server.runCommand(["getVariable", "__base_depends"]) or {})
     for f in dep_files:
-        if f[0].endswith("hob-pre.conf"):
+        if f.endswith("hob-pre.conf"):
             reqfiles = reqfiles + 1
-        elif f[0].endswith("hob-post.conf"):
+        elif f.endswith("hob-post.conf"):
             reqfiles = reqfiles + 1
         if reqfiles == 2:
             break
-- 
1.7.6



