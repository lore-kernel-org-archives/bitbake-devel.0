Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 914A76CB72
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:12 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511887"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id F3E7F562337; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:18 +0100
Message-Id: <dc4e4e27760b8d7320655993ca30406dc4bbb64e.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 49/94] bitbake: dsi: add feature to store package information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

I'm adding code to read package information and
package dependency off the buildhistory, if the
buildhistory feature is enabled, and the target is an image.

There are small changes to the events trapped since we
need to capture package information after the build is
completed.

Minor changes to internal state handling of BuildInfoHelper.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 75 ++++++++++++++++++++++++++++++++----
 bitbake/lib/bb/ui/dsi.py             | 30 +++++++--------
 bitbake/lib/webhob/orm/models.py     |  4 +-
 3 files changed, 85 insertions(+), 24 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 16e69c5..59b6fa3 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -8,7 +8,7 @@ import re
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
-from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Package
+from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Package, Package_Dependency
 from webhob.orm.models import Task_Dependency
 
 
@@ -42,16 +42,14 @@ class ORMWrapper(object):
                                     build_name=build_info['build_name'],
                                     bitbake_version=build_info['bitbake_version'])
 
-
         return build
 
-    def update_build_object(self, build_obj, errors, warnings, taskfailures):
+    def update_build_object(self, build, errors, warnings, taskfailures):
 
         outcome = Build.SUCCEEDED
         if errors or taskfailures:
             outcome = Build.FAILED
 
-        build = Build.objects.get(uuid=build_obj.uuid)
         build.completed_on = datetime.datetime.now()
         build.errors_no = errors
         build.warnings_no = warnings
@@ -116,6 +114,22 @@ class ORMWrapper(object):
         return layer_object[0]
 
 
+    def save_package_information(self, build_obj, packagedict, bldpkgs, recipes):
+        for p in packagedict:
+            packagedict[p]['object'] = Package.objects.create( build = build_obj,
+                                        name = p,
+                                        size = packagedict[p]['size'])
+            if p in bldpkgs:
+                packagedict[p]['object'].version = bldpkgs[p]['version']
+                packagedict[p]['object'].recipe =  recipes[bldpkgs[p]['pn']]
+                packagedict[p]['object'].save()
+
+        for p in packagedict:
+            for px in packagedict[p]['depends']:
+                Package_Dependency.objects.create( package = packagedict[p]['object'],
+                                        depends_on = packagedict[px]['object'] );
+
+
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
         towards the ORM wrapper for storing in the database
@@ -123,13 +137,14 @@ class BuildInfoHelper(object):
         Keeps in memory all data that needs matching before writing it to the database
     """
 
-    def __init__(self, server):
+    def __init__(self, server, has_build_history = False):
         self._configure_django()
         self.internal_state = {}
         self.uuid = None
         self.task_order = 0
         self.server = server
         self.orm_wrapper = ORMWrapper()
+        self.has_build_history = has_build_history
 
     def _configure_django(self):
         # Add webhob to sys path for importing modules
@@ -343,7 +358,6 @@ class BuildInfoHelper(object):
 
     def update_build_information(self, event, errors, warnings, taskfailures):
         self.orm_wrapper.update_build_object(self.internal_state['build'], errors, warnings, taskfailures)
-        del self.internal_state['build']
 
     def store_started_task(self, event):
         identifier = re.split(':', event.taskfile)[-1] + event.taskname
@@ -398,8 +412,56 @@ class BuildInfoHelper(object):
         self.orm_wrapper.get_update_task_object(task_information)
 
 
+    def read_package_dep_data(self, event):
+        # verify that we have something to read
+        if not self.internal_state['build'].is_image or not self.has_build_history:
+            print "not collecting package info ", self.internal_state['build'].is_image, self.has_build_history
+            return
+
+        # fair warning: code correlates to buildhistory.bbclass; anything changes there, needs to chage here too
+        TOPDIR, error = self.server.runCommand(['getVariable', 'TOPDIR'])
+        MACHINE_ARCH, error = self.server.runCommand(['getVariable', 'MACHINE_ARCH'])
+        TCLIBC, error = self.server.runCommand(['getVariable', 'TCLIBC'])
+        MULTIMACH_TARGET_SYS, error = self.server.runCommand(['getVariable', 'MULTIMACH_TARGET_SYS'])
+        SDK_NAME, error = self.server.runCommand(['getVariable', 'SDK_NAME'])
+        BUILDHISTORY_DIR = "%s/buildhistory" % TOPDIR
+        BUILDHISTORY_DIR_IMAGE = "%s/images/%s/%s/%s" % (BUILDHISTORY_DIR, MACHINE_ARCH, TCLIBC, self.internal_state['build'].target)
+
+        self.internal_state['packages'] = {}
+
+        with open("%s/installed-package-sizes.txt" % BUILDHISTORY_DIR_IMAGE, "r") as fin:
+            for line in fin:
+                line = line.rstrip(";")
+                psize, px = line.split("\t")
+                punit, pname = px.split(" ")
+                self.internal_state['packages'][pname.strip()] = {'size':psize, 'depends' : []}
+
+        with open("%s/depends.dot" % BUILDHISTORY_DIR_IMAGE, "r") as fin:
+            p = re.compile(r' -> ')
+            for line in fin:
+                line = line.rstrip(';')
+                linesplit = p.split(line)
+                if len(linesplit) == 2:
+                    pname = linesplit[0]
+                    dependsname = linesplit[1].split(" ")[0].strip().strip(";")
+                    if not pname in self.internal_state['packages']:
+                        self.internal_state['packages'][pname] = {'size': 0, 'depends' : []}
+                    if not dependsname in self.internal_state['packages']:
+                        self.internal_state['packages'][dependsname] = {'size': 0, 'depends' : []}
+                    self.internal_state['packages'][pname]['depends'].append(dependsname)
+
+        self.orm_wrapper.save_package_information(self.internal_state['build'], self.internal_state['packages'],
+                    self.internal_state['bldpkgs'], self.internal_state['recipes'])
+
 
     def store_dependency_information(self, event):
+
+        # save build time package information
+        self.internal_state['bldpkgs'] = {}
+        for pkg  in event._depgraph['packages']:
+            self.internal_state['bldpkgs'][pkg] = event._depgraph['packages'][pkg]
+
+        # save recipe information
         self.internal_state['recipes'] = {}
         for pn in event._depgraph['pn']:
 
@@ -447,4 +509,3 @@ class BuildInfoHelper(object):
                 dep = _save_a_task(taskdesc1)
                 Task_Dependency.objects.get_or_create( task = target, depends_on = dep )
 
-        del self.internal_state['recipes']
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index d03a7c5..98d225b 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -243,6 +243,14 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     includelogs, loglines, consolelogfile = _log_settings_from_server(server)
 
+
+    # verify and warn
+    build_history_enabled = True
+    inheritlist, error = server.runCommand(["getVariable", "INHERIT"])
+    if not "buildhistory" in inheritlist.split(" "):
+        logger.warn("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
+        build_history_enabled = False
+
     if sys.stdin.isatty() and sys.stdout.isatty():
         log_exec_tty = True
     else:
@@ -275,7 +283,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     warnings = 0
     taskfailures = []
 
-    buildinfohelper = BuildInfoHelper(server)
+    buildinfohelper = BuildInfoHelper(server, build_history_enabled)
     buildinfohelper.store_layer_info()
 
     termfilter = tf(main, helper, console, format)
@@ -453,28 +461,20 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 # timestamp should be added for this
                 continue
 
-            if isinstance(event, bb.event.OperationStarted):
-                # timestamp should be added for this
+            if isinstance(event, (bb.event.TreeDataPreparationStarted, bb.event.TreeDataPreparationCompleted)):
                 continue
 
-            if isinstance(event, bb.event.OperationCompleted):
-                # timestamp should be added for this
-                # signal a complete operation
-                # calculate timing
-                continue
-
-            if isinstance(event, bb.event.DiskFull):
-                # trigger an error
+            if isinstance(event, (bb.event.BuildCompleted)):
+                buildinfohelper.read_package_dep_data(event)
+                buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 continue
 
-            if isinstance(event, (bb.event.BuildCompleted,
-                                  bb.command.CommandCompleted,
+            if isinstance(event, (bb.command.CommandCompleted,
                                   bb.command.CommandFailed,
                                   bb.command.CommandExit)):
-                buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
 
                 # we start a new build info
-                buildinfohelper = BuildInfoHelper(server)
+                buildinfohelper = BuildInfoHelper(server, build_history_enabled)
                 buildinfohelper.store_layer_info()
                 continue
 
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index a4721db..774cdff 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -110,9 +110,9 @@ class Artifact(models.Model):
 
 class Package(models.Model):
     build = models.ForeignKey('Build', related_name='package_build')
-    recipe = models.ForeignKey('Recipe', related_name='package_recipe')
+    recipe = models.ForeignKey('Recipe', related_name='package_recipe', null=True)
     name = models.CharField(max_length=100)
-    version = models.CharField(max_length=100)
+    version = models.CharField(max_length=100, default="")
     size = models.IntegerField()
 
 
-- 
1.8.1.2


