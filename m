Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1AB316CE3F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337415"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:40 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:28 +0000
Message-Id: <f75332f8b33d77df059d68ea8d85309e8b7ec98f.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/8] toaster: fixes for null values from events
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Some of the data values may come of as None through the event system,
and the UI would encounter a problem saving the Configuration.
It would be trying to save these values as NULL in the
database, which is not allowed.

This patch adds more verification for data coming through
the event system.

Other minor updates:
* update for the event model from toaster.bbclass
* minor code flow fix in the event system

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 40 ++++++++++++++++++----------------------
 lib/bb/ui/toasterui.py       |  3 +--
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index fbb2620..5881d13 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -171,7 +171,7 @@ class ORMWrapper(object):
         return log_object.save()
 
 
-    def save_build_package_information(self, build_obj, package_info, recipes, files):
+    def save_build_package_information(self, build_obj, package_info, recipes):
         # create and save the object
         bp_object = Build_Package.objects.create( build = build_obj,
                                        recipe = recipes[package_info['PN']],
@@ -185,35 +185,33 @@ class ORMWrapper(object):
                                        license = package_info['LICENSE'],
                                        )
         # save any attached file information
-        if bp_object.name in files.keys():
-            for path, size in files[bp_object.name]:
+        for path in package_info['FILES_INFO']:
                 fo = Build_File.objects.create( bpackage = bp_object,
                                         path = path,
-                                        size = size )
-            del files[bp_object.name]
+                                        size = package_info['FILES_INFO'][path] )
 
         # save soft dependency information
-        if package_info['RDEPENDS']:
+        if 'RDEPENDS' in package_info and package_info['RDEPENDS']:
             for p in bb.utils.explode_deps(package_info['RDEPENDS']):
                 Build_Package_Dependency.objects.get_or_create( package = bp_object,
                     depends_on = p, dep_type = Build_Package_Dependency.TYPE_RDEPENDS)
-        if package_info['RPROVIDES']:
+        if 'RPROVIDES' in package_info and package_info['RPROVIDES']:
             for p in bb.utils.explode_deps(package_info['RPROVIDES']):
                 Build_Package_Dependency.objects.get_or_create( package = bp_object,
                     depends_on = p, dep_type = Build_Package_Dependency.TYPE_RPROVIDES)
-        if package_info['RRECOMMENDS']:
+        if 'RRECOMMENDS' in package_info and package_info['RRECOMMENDS']:
             for p in bb.utils.explode_deps(package_info['RRECOMMENDS']):
                 Build_Package_Dependency.objects.get_or_create( package = bp_object,
                     depends_on = p, dep_type = Build_Package_Dependency.TYPE_RRECOMMENDS)
-        if package_info['RSUGGESTS']:
+        if 'RSUGGESTS' in package_info and package_info['RSUGGESTS']:
             for p in bb.utils.explode_deps(package_info['RSUGGESTS']):
                 Build_Package_Dependency.objects.get_or_create( package = bp_object,
                     depends_on = p, dep_type = Build_Package_Dependency.TYPE_RSUGGESTS)
-        if package_info['RREPLACES']:
+        if 'RREPLACES' in package_info and package_info['RREPLACES']:
             for p in bb.utils.explode_deps(package_info['RREPLACES']):
                 Build_Package_Dependency.objects.get_or_create( package = bp_object,
                     depends_on = p, dep_type = Build_Package_Dependency.TYPE_RREPLACES)
-        if package_info['RCONFLICTS']:
+        if 'RCONFLICTS' in package_info and package_info['RCONFLICTS']:
             for p in bb.utils.explode_deps(package_info['RCONFLICTS']):
                 Build_Package_Dependency.objects.get_or_create( package = bp_object,
                     depends_on = p, dep_type = Build_Package_Dependency.TYPE_RCONFLICTS)
@@ -223,10 +221,16 @@ class ORMWrapper(object):
     def save_build_variables(self, build_obj, vardump):
         for k in vardump:
             if not bool(vardump[k]['func']):
+                value = vardump[k]['v'];
+                if value is None:
+                    value = ''
+                desc = vardump[k]['doc'];
+                if desc is None:
+                    desc = ''
                 Variable.objects.create( build = build_obj,
                     variable_name = k,
-                    variable_value = vardump[k]['v'],
-                    description = vardump[k]['doc'])
+                    variable_value = value,
+                    description = desc)
 
 
 class BuildInfoHelper(object):
@@ -668,15 +672,7 @@ class BuildInfoHelper(object):
         self.orm_wrapper.save_build_package_information(self.internal_state['build'],
                             package_info,
                             self.internal_state['recipes'],
-                            self.internal_state['package_files'])
-
-
-    def store_package_file_information(self, event):
-        if not 'package_files' in self.internal_state.keys():
-            self.internal_state['package_files'] = {}
-
-        data = event.data
-        self.internal_state['package_files'][data['PKG']] = data['FILES']
+                            )
 
     def _store_log_information(self, level, text):
         log_information = {}
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index ab87092..6c5b152 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -140,6 +140,7 @@ def main(server, eventHandler, params ):
                 logfile = event.logfile
                 if logfile and os.path.exists(logfile):
                     bb.error("Logfile of failure stored in: %s" % logfile)
+                continue
 
             # these events are unprocessed now, but may be used in the future to log
             # timing and error informations from the parsing phase in Toaster
@@ -230,8 +231,6 @@ def main(server, eventHandler, params ):
             if isinstance(event, bb.event.MetadataEvent):
                 if event.type == "SinglePackageInfo":
                     buildinfohelper.store_build_package_information(event)
-                elif event.type == "PackageFileSize":
-                    buildinfohelper.store_package_file_information(event)
                 continue
 
             # ignore
-- 
1.8.1.2


