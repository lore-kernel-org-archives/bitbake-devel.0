Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id CEB206CB7F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:13 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Sep 2013 09:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511906"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 40D5A5628D5; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:42 +0100
Message-Id: <1281301fd20df474d0bd8c7d47dc3e09dff217ae.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 73/94] bitbake: webhob: change database models and related
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We change the database models as to allow storage of
data based on new Package design:

* there is a separate Target model that will hold each
of the targets of a build.
* the package information from an image file is stored
in Target_Package model
* the package information from the build process is stored
in Build_Package model
* there is a provision to store dependency type between
Packages
* the code in the DSI has been altered to cope with the
new separate Targets for each build
* the code in Simple interface has been changed to provision
for the new model code.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py               | 153 +++++++++++----------
 bitbake/lib/bb/ui/dsi.py                           |   5 +-
 bitbake/lib/webhob/bldviewer/templates/build.html  |   2 +-
 .../lib/webhob/bldviewer/templates/package.html    |   4 +-
 bitbake/lib/webhob/bldviewer/urls.py               |   1 +
 bitbake/lib/webhob/bldviewer/views.py              |  11 +-
 bitbake/lib/webhob/orm/models.py                   |  71 +++++++---
 7 files changed, 151 insertions(+), 96 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 89d5f15..0860d2a 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -1,6 +1,5 @@
 import datetime
 import sys
-import uuid
 import bb
 import re
 
@@ -8,8 +7,9 @@ import re
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
-from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Package, LogMessage
-from webhob.orm.models import Task_Dependency, Package_Dependency, Variable
+from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
+from webhob.orm.models import Target_Package, Build_Package, Variable
+from webhob.orm.models import Task_Dependency, Build_Package_Dependency, Target_Package_Dependency
 from bb.msg import BBLogFormatter as format
 
 class ORMWrapper(object):
@@ -30,20 +30,30 @@ class ORMWrapper(object):
 
     def create_build_object(self, build_info):
 
-        build = Build.objects.create(uuid=build_info['uuid'],
-                                    target=build_info['target'],
+        build = Build.objects.create(
                                     machine=build_info['machine'],
                                     distro=build_info['distro'],
                                     distro_version=build_info['distro_version'],
                                     started_on=build_info['started_on'],
                                     completed_on=build_info['completed_on'],
-                                    image_fstypes=build_info['image_fstypes'],
                                     cooker_log_path=build_info['cooker_log_path'],
                                     build_name=build_info['build_name'],
                                     bitbake_version=build_info['bitbake_version'])
 
         return build
 
+    def create_target_objects(self, target_info):
+        targets = []
+        for tgt_name in target_info['targets']:
+            tgt_object = Target.objects.create( build = target_info['build'],
+                                    target = tgt_name,
+                                    is_image = False,
+                                    image_fstypes = "",
+                                    file_name = "",
+                                    file_size = 0);
+            targets.append(tgt_object)
+        return targets
+
     def update_build_object(self, build, errors, warnings, taskfailures):
 
         outcome = Build.SUCCEEDED
@@ -118,9 +128,9 @@ class ORMWrapper(object):
         return layer_object[0]
 
 
-    def save_package_information(self, build_obj, packagedict, bldpkgs, recipes):
+    def save_target_package_information(self, target_obj, packagedict, bldpkgs, recipes):
         for p in packagedict:
-            packagedict[p]['object'] = Package.objects.create( build = build_obj,
+            packagedict[p]['object'] = Target_Package.objects.create( target = target_obj,
                                         name = p,
                                         size = packagedict[p]['size'])
             if p in bldpkgs:
@@ -130,7 +140,7 @@ class ORMWrapper(object):
 
         for p in packagedict:
             for px in packagedict[p]['depends']:
-                Package_Dependency.objects.create( package = packagedict[p]['object'],
+                Target_Package_Dependency.objects.create( package = packagedict[p]['object'],
                                         depends_on = packagedict[px]['object'] );
 
 
@@ -165,7 +175,6 @@ class BuildInfoHelper(object):
     def __init__(self, server, has_build_history = False):
         self._configure_django()
         self.internal_state = {}
-        self.uuid = None
         self.task_order = 0
         self.server = server
         self.orm_wrapper = ORMWrapper()
@@ -252,7 +261,6 @@ class BuildInfoHelper(object):
         build_info = {}
         # Generate an identifier for each new build
 
-        build_info['uuid'] = self.uuid
         build_info['machine'] = machine_obj
         build_info['distro'] = self.server.runCommand(["getVariable", "DISTRO"])[0]
         build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
@@ -307,15 +315,17 @@ class BuildInfoHelper(object):
 
     def _get_path_information(self, task_object):
         build_stats_format = "{tmpdir}/buildstats/{target}-{machine}/{buildname}/{package}/"
+        build_stats_path = []
 
-        target = self.internal_state['target']
-        machine = self.internal_state['build'].machine.name
-        buildname = self.internal_state['build'].build_name
-        package = task_object.recipe.name + "-" + task_object.recipe.version.strip(":")
+        for t in self.internal_state['targets']:
+            target = t.target
+            machine = self.internal_state['build'].machine.name
+            buildname = self.internal_state['build'].build_name
+            package = task_object.recipe.name + "-" + task_object.recipe.version.strip(":")
 
-        build_stats_path = build_stats_format.format(tmpdir=self.tmp_dir, target=target,
+            build_stats_path.append(build_stats_format.format(tmpdir=self.tmp_dir, target=target,
                                                      machine=machine, buildname=buildname,
-                                                     package=package)
+                                                     package=package))
 
         return build_stats_path
 
@@ -364,14 +374,19 @@ class BuildInfoHelper(object):
 
         machine_information = self._get_machine_information()
         machine_obj = self.orm_wrapper.create_machine_object(machine_information)
-        self.uuid = str(uuid.uuid4())
 
         build_information = self._get_build_information(machine_obj)
-        build_information['target'] = ' '.join(event.getPkgs())
 
         build_obj = self.orm_wrapper.create_build_object(build_information)
         self.internal_state['build'] = build_obj
-        self.internal_state['target'] = build_information['target']
+
+        # create target information
+        target_information = {}
+        target_information['targets'] = event.getPkgs()
+        target_information['build'] = build_obj
+
+        self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
+
         # Load layer information for the build
         self.internal_state['layer_versions'] = []
         for layer_object in self.internal_state['layers']:
@@ -428,7 +443,7 @@ class BuildInfoHelper(object):
             task_information['message'] = event._message
 
         if isinstance(event, (bb.runqueue.runQueueTaskCompleted, bb.runqueue.sceneQueueTaskCompleted)):
-            task_information['outcome'] = Task.OUTCOME_SUCCESS     # TODO: needs to use constants
+            task_information['outcome'] = Task.OUTCOME_SUCCESS
             task_build_stats = self._get_task_build_stats(self.orm_wrapper.get_update_task_object(task_information))
             task_information['cpu_usage'] = task_build_stats['cpu_usage']
             task_information['disk_io'] = task_build_stats['disk_io']
@@ -438,54 +453,52 @@ class BuildInfoHelper(object):
             task_information['outcome'] = Task.OUTCOME_FAILED
             del self.internal_state[identifier]
 
-        #TODO: get error number
-        #TODO: get warnings number
-        #TODO: get warning information
-
-
         self.orm_wrapper.get_update_task_object(task_information)
 
 
-    def read_package_dep_data(self, event):
-        # verify that we have something to read
-        if not self.internal_state['build'].is_image or not self.has_build_history:
-            print "not collecting package info ", self.internal_state['build'].is_image, self.has_build_history
-            return
-
-        # fair warning: code correlates to buildhistory.bbclass; anything changes there, needs to chage here too
-        TOPDIR, error = self.server.runCommand(['getVariable', 'TOPDIR'])
-        MACHINE_ARCH, error = self.server.runCommand(['getVariable', 'MACHINE_ARCH'])
-        TCLIBC, error = self.server.runCommand(['getVariable', 'TCLIBC'])
-        MULTIMACH_TARGET_SYS, error = self.server.runCommand(['getVariable', 'MULTIMACH_TARGET_SYS'])
-        SDK_NAME, error = self.server.runCommand(['getVariable', 'SDK_NAME'])
-        BUILDHISTORY_DIR = "%s/buildhistory" % TOPDIR
-        BUILDHISTORY_DIR_IMAGE = "%s/images/%s/%s/%s" % (BUILDHISTORY_DIR, MACHINE_ARCH, TCLIBC, self.internal_state['build'].target)
-
-        self.internal_state['packages'] = {}
-
-        with open("%s/installed-package-sizes.txt" % BUILDHISTORY_DIR_IMAGE, "r") as fin:
-            for line in fin:
-                line = line.rstrip(";")
-                psize, px = line.split("\t")
-                punit, pname = px.split(" ")
-                self.internal_state['packages'][pname.strip()] = {'size':psize, 'depends' : []}
-
-        with open("%s/depends.dot" % BUILDHISTORY_DIR_IMAGE, "r") as fin:
-            p = re.compile(r' -> ')
-            for line in fin:
-                line = line.rstrip(';')
-                linesplit = p.split(line)
-                if len(linesplit) == 2:
-                    pname = linesplit[0]
-                    dependsname = linesplit[1].split(" ")[0].strip().strip(";")
-                    if not pname in self.internal_state['packages']:
-                        self.internal_state['packages'][pname] = {'size': 0, 'depends' : []}
-                    if not dependsname in self.internal_state['packages']:
-                        self.internal_state['packages'][dependsname] = {'size': 0, 'depends' : []}
-                    self.internal_state['packages'][pname]['depends'].append(dependsname)
-
-        self.orm_wrapper.save_package_information(self.internal_state['build'], self.internal_state['packages'],
-                    self.internal_state['bldpkgs'], self.internal_state['recipes'])
+    def read_target_package_dep_data(self, event):
+        # for all targets
+        for target in self.internal_state['targets']:
+            # verify that we have something to read
+            if not target.is_image or not self.has_build_history:
+                print "not collecting package info ", target.is_image, self.has_build_history
+                break
+
+            # fair warning: code correlates to buildhistory.bbclass; anything changes there, needs to chage here too
+            TOPDIR, error = self.server.runCommand(['getVariable', 'TOPDIR'])
+            MACHINE_ARCH, error = self.server.runCommand(['getVariable', 'MACHINE_ARCH'])
+            TCLIBC, error = self.server.runCommand(['getVariable', 'TCLIBC'])
+            MULTIMACH_TARGET_SYS, error = self.server.runCommand(['getVariable', 'MULTIMACH_TARGET_SYS'])
+            SDK_NAME, error = self.server.runCommand(['getVariable', 'SDK_NAME'])
+            BUILDHISTORY_DIR = "%s/buildhistory" % TOPDIR
+            BUILDHISTORY_DIR_IMAGE = "%s/images/%s/%s/%s" % (BUILDHISTORY_DIR, MACHINE_ARCH, TCLIBC, target.target)
+
+            self.internal_state['packages'] = {}
+
+            with open("%s/installed-package-sizes.txt" % BUILDHISTORY_DIR_IMAGE, "r") as fin:
+                for line in fin:
+                    line = line.rstrip(";")
+                    psize, px = line.split("\t")
+                    punit, pname = px.split(" ")
+                    self.internal_state['packages'][pname.strip()] = {'size':psize, 'depends' : []}
+
+            with open("%s/depends.dot" % BUILDHISTORY_DIR_IMAGE, "r") as fin:
+                p = re.compile(r' -> ')
+                for line in fin:
+                    line = line.rstrip(';')
+                    linesplit = p.split(line)
+                    if len(linesplit) == 2:
+                        pname = linesplit[0]
+                        dependsname = linesplit[1].split(" ")[0].strip().strip(";")
+                        if not pname in self.internal_state['packages']:
+                            self.internal_state['packages'][pname] = {'size': 0, 'depends' : []}
+                        if not dependsname in self.internal_state['packages']:
+                            self.internal_state['packages'][dependsname] = {'size': 0, 'depends' : []}
+                        self.internal_state['packages'][pname]['depends'].append(dependsname)
+
+            self.orm_wrapper.save_target_package_information(target,
+                        self.internal_state['packages'],
+                        self.internal_state['bldpkgs'], self.internal_state['recipes'])
 
 
     def store_dependency_information(self, event):
@@ -519,9 +532,11 @@ class BuildInfoHelper(object):
             recipe_info['file_path'] = file_name
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
             recipe.is_image = True in map(lambda x: x.endswith('image.bbclass'), event._depgraph['pn'][pn]['inherits'])
-            if recipe.is_image and pn == self.internal_state['build'].target:
-                self.internal_state['build'].is_image = True
-                self.internal_state['build'].save()
+            if recipe.is_image:
+                for t in self.internal_state['targets']:
+                    if pn == t.target:
+                        t.is_image = True
+                        t.save()
             self.internal_state['recipes'][pn] = recipe
 
         # save all task information
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index c139cd2..3284ea2 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -471,7 +471,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, (bb.event.BuildCompleted)):
-                buildinfohelper.read_package_dep_data(event)
+                buildinfohelper.read_target_package_dep_data(event)
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 continue
 
@@ -531,6 +531,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     logger.error("Unable to cleanly shutdown: %s" % error)
             main.shutdown = main.shutdown + 1
             pass
+        except Exception as e:
+            print(e)
+            pass
 
     summary = ""
     if taskfailures:
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index bbd283e..eed81a3 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -27,7 +27,7 @@
             <td><a href="/simple/build/{{build.id}}/configuration/">{{build.get_outcome_display}}</a></td>
             <td>{{build.started_on}}</td>
             <td>{{build.completed_on}}</td>
-            <td>{{build.target}}</td>
+            <td>{% for t in build.target_set.all %}<a href="/simple/build/{{build.id}}/target/{{t.id}}">{{t.target}}</a><br/>{% endfor %}</td>
             <td>{% if build.is_image %} <a href="/simple/build/{{build.id}}/package/">{{build.is_image}}</a>{% else %} {{build.is_image}} {% endif %}</td>
             <td>{{build.machine.name}}</td>
             <td>{% time_difference build.started_on build.completed_on %}</td>
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
index b4091c6..7764f05 100644
--- a/bitbake/lib/webhob/bldviewer/templates/package.html
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -7,12 +7,12 @@
   <li><a href="/simple/build/{{build}}/package/"> Package </a> </li>
   <li><a href="/simple/build/{{build}}/configuration/"> Configuration </a> </li>
 </ul>
-     <h1>Toaster - Packages</h1>
+     <h1>Toaster - Target Install Packages</h1>
 {% endblock %}
 
 {% block pagetable %}
     {% if not packages %}
-        <p>No packages were build in this build!</p>
+        <p>No packages were recorded for this target!</p>
     {% else %}
 
             <tr>
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index 8f9bc0d..11bdbe9 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -4,6 +4,7 @@ from django.views.generic.simple import redirect_to
 urlpatterns = patterns('bldviewer.views',
         url(r'^build/$', 'build', name='build'),
         url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
+        url(r'^build/(?P<build_id>\d+)/targets/$', 'task', name='task'),
         url(r'^build/(?P<build_id>\d+)/package/$', 'package', name='package'),
         url(r'^build/(?P<build_id>\d+)/configuration/$', 'configuration', name='configuration'),
         url(r'^layer/$', 'layer', name='layer'),
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index cb7cfc7..ab222ac 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -2,14 +2,15 @@ import operator
 
 from django.db.models import Q
 from django.shortcuts import render
-from orm.models import Build, Task, Layer, Layer_Version, Recipe, Package, LogMessage, Variable
-from orm.models import Task_Dependency, Package_Dependency
+from orm.models import Build, Task, Layer, Layer_Version, Recipe, Target_Package, LogMessage, Variable
+from orm.models import Task_Dependency, Target_Package_Dependency
 from django.views.decorators.cache import cache_control
 
 @cache_control(no_store=True)
 def build(request):
     template = 'build.html'
     build_info = Build.objects.all()
+
     logs = LogMessage.objects.all()
 
     context = {'builds': build_info, 'logs': logs ,
@@ -45,8 +46,8 @@ def configuration(request, build_id):
 def package(request, build_id):
     template = 'package.html'
 
-    packages = Package.objects.filter(build=build_id)
-    package_depends = Package_Dependency.objects.filter(package__in=packages)
+    packages = Target_Package.objects.filter(build=build_id)
+    package_depends = Target_Package_Dependency.objects.filter(package__in=packages)
 
     for t in packages:
         t.depends_on = []
@@ -96,7 +97,7 @@ def model_explorer(request, model_name):
     model_mapping = {
         'build': Build,
         'task': Task,
-        'package': Package,
+        'package': Target_Package,
         'layer': Layer,
         'layerversion': Layer_Version,
         'recipe': Recipe,
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 1d67e40..4b5c413 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -12,12 +12,9 @@ class Build(models.Model):
         (IN_PROGRESS, 'In Progress'),
     )
 
-    search_allowed_fields = ['target', 'machine__name',
-                             'cooker_log_path', 'image_fstypes']
+    search_allowed_fields = ['machine__name',
+                             'cooker_log_path']
 
-    uuid = models.CharField(max_length=100, unique=True)
-    target = models.CharField(max_length=100)
-    is_image = models.BooleanField(default = False)
     machine = models.ForeignKey('Machine', related_name='build_machine')
     distro = models.CharField(max_length=100)
     distro_version = models.CharField(max_length=100)
@@ -26,12 +23,21 @@ class Build(models.Model):
     outcome = models.IntegerField(choices=BUILD_OUTCOME, default=IN_PROGRESS)
     errors_no = models.IntegerField(default=0)
     warnings_no = models.IntegerField(default=0)
-    image_fstypes = models.CharField(max_length=100)
     cooker_log_path = models.CharField(max_length=500)
     build_name = models.CharField(max_length=100)
     bitbake_version = models.CharField(max_length=50)
 
 
+class Target(models.Model):
+    search_allowed_fields = ['target', 'image_fstypes', 'file_name']
+    build = models.ForeignKey(Build)
+    target = models.CharField(max_length=100)
+    is_image = models.BooleanField(default = False)
+    image_fstypes = models.CharField(max_length=100)
+    file_name = models.CharField(max_length=100)
+    file_size = models.IntegerField()
+
+
 class Task(models.Model):
 
     SSTATE_NA = 0
@@ -100,27 +106,56 @@ class Task_Dependency(models.Model):
     depends_on = models.ForeignKey(Task, related_name='task_dependencies_depends')
 
 
-class Artifact(models.Model):
-    build = models.ForeignKey(Build, related_name='artifact_build')
-    file_name = models.CharField(max_length=100)
-    file_size = models.IntegerField()
+class Build_Package(models.Model):
+    build = models.ForeignKey('Build')
+    recipe = models.ForeignKey('Recipe', null=True)
+    name = models.CharField(max_length=100)
+    version = models.CharField(max_length=100, default="")
+    size = models.IntegerField()
+    license = models.CharField(max_length=200, null=True)
+
+class Build_Package_Dependency(models.Model):
+    TYPE_DEPENDS = 0
+    TYPE_RDEPENDS = 1
+    DEPENDS_TYPE = (
+        (TYPE_DEPENDS, "depends"),
+        (TYPE_RDEPENDS, "rdepends"),
+    )
+    package = models.ForeignKey(Build_Package, related_name='bpackage_dependencies_package')
+    depends_on = models.ForeignKey(Build_Package, related_name='bpackage_dependencies_depends')
+    dep_type = models.IntegerField(choices=DEPENDS_TYPE)
 
 
-class Package(models.Model):
-    build = models.ForeignKey('Build', related_name='package_build')
-    recipe = models.ForeignKey('Recipe', related_name='package_recipe', null=True)
+class Target_Package(models.Model):
+    target = models.ForeignKey('Target')
+    recipe = models.ForeignKey('Recipe', null=True)
     name = models.CharField(max_length=100)
     version = models.CharField(max_length=100, default="")
     size = models.IntegerField()
 
 
-class Package_Dependency(models.Model):
-    package = models.ForeignKey(Package, related_name='package_dependencies_package')
-    depends_on = models.ForeignKey(Package, related_name='package_dependencies_depends')
+class Target_Package_Dependency(models.Model):
+    TYPE_DEPENDS = 0
+    TYPE_RDEPENDS = 1
+    TYPE_RECOMMENDS = 2
+
+    DEPENDS_TYPE = (
+        (TYPE_DEPENDS, "depends"),
+        (TYPE_RDEPENDS, "rdepends"),
+        (TYPE_RECOMMENDS, "recommends"),
+    )
+    package = models.ForeignKey(Target_Package, related_name='tpackage_dependencies_package')
+    depends_on = models.ForeignKey(Target_Package, related_name='tpackage_dependencies_depends')
+    dep_type = models.IntegerField(choices=DEPENDS_TYPE)
+
 
+class Build_Filelist(models.Model):
+    bpackage = models.ForeignKey(Build_Package, related_name='filelist_bpackage')
+    complete_file_path = models.FilePathField(max_length=255, blank=True)
+    file_size = models.IntegerField()
 
-class Filelist(models.Model):
-    package = models.ForeignKey(Package, related_name='filelist_package')
+class Target_Filelist(models.Model):
+    tpackage = models.ForeignKey(Target_Package, related_name='filelist_tpackage')
     complete_file_path = models.FilePathField(max_length=255, blank=True)
     file_size = models.IntegerField()
 
-- 
1.8.1.2


