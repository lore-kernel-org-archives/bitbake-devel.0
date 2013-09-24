Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 3D84A6CB2E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:21 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948561"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 4B90A5629F0; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:46 +0100
Message-Id: <cf531652e5b7946a0db756732995fdac2e5885ff.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 77/94] bitbake: webhob: store file size information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:25 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding code to store file size information for each
of the build package. Reassembling information from
a pair of events for each package - first contains
file and size information, and the second contains
package metadata.

Cleanup of the database models to hold file size info.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 24 +++++++++++++++++++++---
 bitbake/lib/bb/ui/dsi.py             |  2 ++
 bitbake/lib/webhob/orm/models.py     | 12 ++++++------
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 06ca703..8b0e720 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -8,7 +8,7 @@ os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
 from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
-from webhob.orm.models import Target_Package, Build_Package, Variable
+from webhob.orm.models import Target_Package, Build_Package, Variable, Build_File
 from webhob.orm.models import Task_Dependency, Build_Package_Dependency, Target_Package_Dependency
 from bb.msg import BBLogFormatter as format
 
@@ -157,7 +157,8 @@ class ORMWrapper(object):
         return log_object.save()
 
 
-    def save_build_package_information(self, build_obj, package_info, recipes):
+    def save_build_package_information(self, build_obj, package_info, recipes, files):
+        # create and save the object
         bp_object = Build_Package.objects.create( build = build_obj,
                                        recipe = recipes[package_info['PN']],
                                        name = package_info['PKG'],
@@ -168,6 +169,14 @@ class ORMWrapper(object):
                                        section = package_info['SECTION'],
                                        license = package_info['LICENSE'],
                                        )
+        # save any attached file information
+        if bp_object.name in files.keys():
+            for path, size in files[bp_object.name]:
+                fo = Build_File.objects.create( bpackage = bp_object,
+                                        path = path,
+                                        size = size )
+            del files[bp_object.name]
+
         return bp_object
 
     def save_build_variables(self, build_obj, vardump):
@@ -575,8 +584,17 @@ class BuildInfoHelper(object):
     def store_build_package_information(self, event):
         package_info = event.data
         self.orm_wrapper.save_build_package_information(self.internal_state['build'],
-                            package_info, self.internal_state['recipes'])
+                            package_info,
+                            self.internal_state['recipes'],
+                            self.internal_state['package_files'])
+
+
+    def store_package_file_information(self, event):
+        if not 'package_files' in self.internal_state.keys():
+            self.internal_state['package_files'] = {}
 
+        data = event._data
+        self.internal_state['package_files'][data['PKG']] = data['FILES']
 
     def store_log_information(self, level, text):
         log_information = {}
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 643e98e..e5447ec 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -492,6 +492,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.event.MetadataEvent):
                 if event.type == "SinglePackageInfo":
                     buildinfohelper.store_build_package_information(event)
+                elif event.type == "PackageFileSize":
+                    buildinfohelper.store_package_file_information(event)
                 continue
 
             # ignore
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 7e57c1d..aa368fe 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -157,15 +157,15 @@ class Target_Package_Dependency(models.Model):
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
 
 
-class Build_Filelist(models.Model):
+class Build_File(models.Model):
     bpackage = models.ForeignKey(Build_Package, related_name='filelist_bpackage')
-    complete_file_path = models.FilePathField(max_length=255, blank=True)
-    file_size = models.IntegerField()
+    path = models.FilePathField(max_length=255, blank=True)
+    size = models.IntegerField()
 
-class Target_Filelist(models.Model):
+class Target_File(models.Model):
     tpackage = models.ForeignKey(Target_Package, related_name='filelist_tpackage')
-    complete_file_path = models.FilePathField(max_length=255, blank=True)
-    file_size = models.IntegerField()
+    path = models.FilePathField(max_length=255, blank=True)
+    size = models.IntegerField()
 
 
 class Recipe(models.Model):
-- 
1.8.1.2


