Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 4F62F6E237
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:31 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359910"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:28 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:11 +0000
Message-Id: <f5d655bfaeb349c8680d74530617e34aa389d1f0.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 05/11] toaster: change package storage model
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:31 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Up until this patch, package information lived in two
places - one table for build packages and one table for
target installed packaged. This situation leads to
two problems: there is no direct link between a build
package and a installed package, and a lot of data is duplicated.

This change unifies all package types in a single table.
The SimpleUI remains the same for continuity sake,
but the REST API will be changed in a future patch.

The package dependencies and package files are now
kept in a single table.

Since we collect target installed package information at all times,
we need to expand it to supplement missing information if a
package is not actually built in the current build.

Small changes to the Simple UI reflect the updated database schema.

    [YOCTO #5565]
    [YOCTO #5269]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                  | 165 ++++++++++++--------------
 lib/bb/ui/toasterui.py                        |   3 +-
 lib/toaster/bldviewer/templates/bpackage.html |   6 +-
 lib/toaster/bldviewer/templates/package.html  |   2 +-
 lib/toaster/bldviewer/views.py                |  25 ++--
 lib/toaster/orm/models.py                     |  50 +++-----
 6 files changed, 108 insertions(+), 143 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index fef849d..0252efd 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -20,15 +20,16 @@ import datetime
 import sys
 import bb
 import re
+import ast
 
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "toaster.toastermain.settings")
 
 import toaster.toastermain.settings as toaster_django_settings
 from toaster.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
 from toaster.orm.models import Variable, VariableHistory
-from toaster.orm.models import Target_Package, Build_Package, Build_File
-from toaster.orm.models import Task_Dependency, Build_Package_Dependency
-from toaster.orm.models import Target_Package_Dependency, Recipe_Dependency
+from toaster.orm.models import Package, Package_File, Target_Installed_Package
+from toaster.orm.models import Task_Dependency, Package_Dependency
+from toaster.orm.models import Recipe_Dependency
 from bb.msg import BBLogFormatter as format
 
 class ORMWrapper(object):
@@ -148,21 +149,48 @@ class ORMWrapper(object):
         return layer_object[0]
 
 
-    def save_target_package_information(self, target_obj, packagedict, bldpkgs, recipes):
+    def save_target_package_information(self, build_obj, target_obj, packagedict, pkgpnmap, recipes):
         for p in packagedict:
-            packagedict[p]['object'] = Target_Package.objects.create( target = target_obj,
-                                        name = p,
-                                        size = packagedict[p]['size'])
-            if p in bldpkgs:
-                packagedict[p]['object'].version = bldpkgs[p]['version']
-                packagedict[p]['object'].recipe =  recipes[bldpkgs[p]['pn']]
-                packagedict[p]['object'].save()
+            packagedict[p]['object'], created = Package.objects.get_or_create( build = build_obj, name = p )
+            if created:
+                # package was not build in the current build, but
+                # fill in everything we can from the runtime-reverse package data
+                try:
+                    packagedict[p]['object'].recipe = recipes[pkgpnmap[p]['PN']]
+                    packagedict[p]['object'].version = pkgpnmap[p]['PV']
+                    packagedict[p]['object'].revision = pkgpnmap[p]['PR']
+                    packagedict[p]['object'].license = pkgpnmap[p]['LICENSE']
+                    packagedict[p]['object'].section = pkgpnmap[p]['SECTION']
+                    packagedict[p]['object'].summary = pkgpnmap[p]['SUMMARY']
+                    packagedict[p]['object'].description = pkgpnmap[p]['DESCRIPTION']
+                    packagedict[p]['object'].size = int(pkgpnmap[p]['PKGSIZE'])
+
+                # no files recorded for this package, so save files info
+                    for targetpath in pkgpnmap[p]['FILES_INFO']:
+                        targetfilesize = pkgpnmap[p]['FILES_INFO'][targetpath]
+                        Package_File.objects.create( package = packagedict[p]['object'],
+                            path = targetpath,
+                            size = targetfilesize)
+                except KeyError as e:
+                    print "Key error, package", p, "key", e
+
+            # save disk installed size
+            packagedict[p]['object'].installed_size = packagedict[p]['size']
+            packagedict[p]['object'].save()
+
+            Target_Installed_Package.objects.create(target = target_obj, package = packagedict[p]['object'])
 
         for p in packagedict:
             for (px,deptype) in packagedict[p]['depends']:
-                Target_Package_Dependency.objects.create( package = packagedict[p]['object'],
+                if deptype == 'depends':
+                    tdeptype = Package_Dependency.TYPE_TRDEPENDS
+                elif deptype == 'recommends':
+                    tdeptype = Package_Dependency.TYPE_TRECOMMENDS
+
+                Package_Dependency.objects.create( package = packagedict[p]['object'],
                                         depends_on = packagedict[px]['object'],
-                                        dep_type = deptype);
+                                        dep_type = tdeptype,
+                                        target = target_obj);
 
 
     def create_logmessage(self, log_information):
@@ -180,48 +208,53 @@ class ORMWrapper(object):
 
     def save_build_package_information(self, build_obj, package_info, recipes):
         # create and save the object
-        bp_object = Build_Package.objects.create( build = build_obj,
-                                       recipe = recipes[package_info['PN']],
-                                       name = package_info['PKG'],
-                                       version = package_info['PKGV'],
-                                       revision = package_info['PKGR'],
-                                       summary = package_info['SUMMARY'],
-                                       description = package_info['DESCRIPTION'],
-                                       size = int(package_info['PKGSIZE']),
-                                       section = package_info['SECTION'],
-                                       license = package_info['LICENSE'],
-                                       )
+        bp_object, created = Package.objects.get_or_create( build = build_obj,
+                                       name = package_info['PKG'] )
+
+        bp_object.recipe = recipes[package_info['PN']]
+        bp_object.version = package_info['PKGV']
+        bp_object.revision = package_info['PKGR']
+        bp_object.summary = package_info['SUMMARY']
+        bp_object.description = package_info['DESCRIPTION']
+        bp_object.size = int(package_info['PKGSIZE'])
+        bp_object.section = package_info['SECTION']
+        bp_object.license = package_info['LICENSE']
+        bp_object.save()
+
         # save any attached file information
         for path in package_info['FILES_INFO']:
-                fo = Build_File.objects.create( bpackage = bp_object,
+                fo = Package_File.objects.create( package = bp_object,
                                         path = path,
                                         size = package_info['FILES_INFO'][path] )
 
+        def _po_byname(p):
+            return Package.objects.get_or_create(build = build_obj, name = p)[0]
+
         # save soft dependency information
         if 'RDEPENDS' in package_info and package_info['RDEPENDS']:
             for p in bb.utils.explode_deps(package_info['RDEPENDS']):
-                Build_Package_Dependency.objects.get_or_create( package = bp_object,
-                    depends_on = p, dep_type = Build_Package_Dependency.TYPE_RDEPENDS)
+                Package_Dependency.objects.get_or_create( package = bp_object,
+                    depends_on = _po_byname(p), dep_type = Package_Dependency.TYPE_RDEPENDS)
         if 'RPROVIDES' in package_info and package_info['RPROVIDES']:
             for p in bb.utils.explode_deps(package_info['RPROVIDES']):
-                Build_Package_Dependency.objects.get_or_create( package = bp_object,
-                    depends_on = p, dep_type = Build_Package_Dependency.TYPE_RPROVIDES)
+                Package_Dependency.objects.get_or_create( package = bp_object,
+                    depends_on = _po_byname(p), dep_type = Package_Dependency.TYPE_RPROVIDES)
         if 'RRECOMMENDS' in package_info and package_info['RRECOMMENDS']:
             for p in bb.utils.explode_deps(package_info['RRECOMMENDS']):
-                Build_Package_Dependency.objects.get_or_create( package = bp_object,
-                    depends_on = p, dep_type = Build_Package_Dependency.TYPE_RRECOMMENDS)
+                Package_Dependency.objects.get_or_create( package = bp_object,
+                    depends_on = _po_byname(p), dep_type = Package_Dependency.TYPE_RRECOMMENDS)
         if 'RSUGGESTS' in package_info and package_info['RSUGGESTS']:
             for p in bb.utils.explode_deps(package_info['RSUGGESTS']):
-                Build_Package_Dependency.objects.get_or_create( package = bp_object,
-                    depends_on = p, dep_type = Build_Package_Dependency.TYPE_RSUGGESTS)
+                Package_Dependency.objects.get_or_create( package = bp_object,
+                    depends_on = _po_byname(p), dep_type = Package_Dependency.TYPE_RSUGGESTS)
         if 'RREPLACES' in package_info and package_info['RREPLACES']:
             for p in bb.utils.explode_deps(package_info['RREPLACES']):
-                Build_Package_Dependency.objects.get_or_create( package = bp_object,
-                    depends_on = p, dep_type = Build_Package_Dependency.TYPE_RREPLACES)
+                Package_Dependency.objects.get_or_create( package = bp_object,
+                    depends_on = _po_byname(p), dep_type = Package_Dependency.TYPE_RREPLACES)
         if 'RCONFLICTS' in package_info and package_info['RCONFLICTS']:
             for p in bb.utils.explode_deps(package_info['RCONFLICTS']):
-                Build_Package_Dependency.objects.get_or_create( package = bp_object,
-                    depends_on = p, dep_type = Build_Package_Dependency.TYPE_RCONFLICTS)
+                Package_Dependency.objects.get_or_create( package = bp_object,
+                    depends_on = _po_byname(p), dep_type = Package_Dependency.TYPE_RCONFLICTS)
 
         return bp_object
 
@@ -469,54 +502,13 @@ class BuildInfoHelper(object):
         self.orm_wrapper.get_update_task_object(task_information)
 
 
-    def read_target_package_dep_data(self, event):
-        # for all targets
+    def store_target_package_data(self, event):
+        # for all image targets
         for target in self.internal_state['targets']:
-            # verify that we have something to read
-            if not target.is_image or not self.has_build_history:
-                print "not collecting package info ", target.is_image, self.has_build_history
-                break
-
-            # TODO this is a temporary replication of the code in buildhistory.bbclass
-            # This MUST be changed to query the actual BUILD_DIR_IMAGE in the target context when
-            # the capability will be implemented in Bitbake
-
-            MACHINE_ARCH, error = self.server.runCommand(['getVariable', 'MACHINE_ARCH'])
-            TCLIBC, error = self.server.runCommand(['getVariable', 'TCLIBC'])
-            BUILDHISTORY_DIR, error = self.server.runCommand(['getVariable', 'BUILDHISTORY_DIR'])
-            BUILDHISTORY_DIR_IMAGE = "%s/images/%s/%s/%s" % (BUILDHISTORY_DIR, MACHINE_ARCH, TCLIBC, target.target)
-
-            self.internal_state['packages'] = {}
-
-            with open("%s/installed-package-sizes.txt" % BUILDHISTORY_DIR_IMAGE, "r") as fin:
-                for line in fin:
-                    line = line.rstrip(";")
-                    psize, px = line.split("\t")
-                    punit, pname = px.split(" ")
-                    self.internal_state['packages'][pname.strip()] = {'size':int(psize)*1024, 'depends' : []}
-
-            with open("%s/depends.dot" % BUILDHISTORY_DIR_IMAGE, "r") as fin:
-                p = re.compile(r' -> ')
-                dot = re.compile(r'.*style=dotted')
-                for line in fin:
-                    line = line.rstrip(';')
-                    linesplit = p.split(line)
-                    if len(linesplit) == 2:
-                        pname = linesplit[0].rstrip('"').strip('"')
-                        dependsname = linesplit[1].split(" ")[0].strip().strip(";").strip('"').rstrip('"')
-                        deptype = Target_Package_Dependency.TYPE_DEPENDS
-                        if dot.match(line):
-                            deptype = Target_Package_Dependency.TYPE_RECOMMENDS
-                        if not pname in self.internal_state['packages']:
-                            self.internal_state['packages'][pname] = {'size': 0, 'depends' : []}
-                        if not dependsname in self.internal_state['packages']:
-                            self.internal_state['packages'][dependsname] = {'size': 0, 'depends' : []}
-                        self.internal_state['packages'][pname]['depends'].append((dependsname, deptype))
-
-            self.orm_wrapper.save_target_package_information(target,
-                        self.internal_state['packages'],
-                        self.internal_state['bldpkgs'], self.internal_state['recipes'])
-
+            if target.is_image:
+                pkgdata = event.data['pkgdata']
+                imgdata = event.data['imgdata'][target.target]
+                self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'])
 
     def store_dependency_information(self, event):
         # save layer version priorities
@@ -528,11 +520,6 @@ class BuildInfoHelper(object):
                 layer_version_obj.priority = priority
                 layer_version_obj.save()
 
-        # save build time package information
-        self.internal_state['bldpkgs'] = {}
-        for pkg  in event._depgraph['packages']:
-            self.internal_state['bldpkgs'][pkg] = event._depgraph['packages'][pkg]
-
         # save recipe information
         self.internal_state['recipes'] = {}
         for pn in event._depgraph['pn']:
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 318fc28..e469d93 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -209,7 +209,6 @@ def main(server, eventHandler, params ):
                 continue
 
             if isinstance(event, (bb.event.BuildCompleted)):
-                buildinfohelper.read_target_package_dep_data(event)
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 continue
 
@@ -240,6 +239,8 @@ def main(server, eventHandler, params ):
                     buildinfohelper.store_layer_info(event)
                 if event.type == "BuildStatsList":
                     buildinfohelper.store_tasks_stats(event)
+                if event.type == "ImagePkgList":
+                    buildinfohelper.store_target_package_data(event)
                 continue
 
             # ignore
diff --git a/lib/toaster/bldviewer/templates/bpackage.html b/lib/toaster/bldviewer/templates/bpackage.html
index 4e6d9c6..ca092ca 100644
--- a/lib/toaster/bldviewer/templates/bpackage.html
+++ b/lib/toaster/bldviewer/templates/bpackage.html
@@ -23,7 +23,7 @@
             <tr class="data">
                 <td><a name="#{{package.name}}" href="{% url bfile build.pk package.pk %}">{{package.name}} ({{package.filelist_bpackage.count}} files)</a></td>
                 <td>{{package.version}}-{{package.revision}}</td>
-                <td><a href="{% url layer_versions_recipes package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
+                <td>{%if package.recipe%}<a href="{% url "layer_versions_recipes" package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a>{%endif%}</td>
 
             <td>{{package.summary}}</td>
             <td>{{package.section}}</td>
@@ -32,8 +32,8 @@
             <td>{{package.license}}</td>
             <td>
         <div style="height: 3em; overflow:auto">
-            {% for bpd in package.bpackage_dependencies_package.all %}
-                {{bpd.dep_type}}: {{bpd.depends_on}} <br/>
+            {% for bpd in package.package_dependencies_source.all %}
+                {{bpd.dep_type}}: {{bpd.depends_on.name}} <br/>
             {% endfor %}
         </div>
             </td>
diff --git a/lib/toaster/bldviewer/templates/package.html b/lib/toaster/bldviewer/templates/package.html
index c22e988..b1246e7 100644
--- a/lib/toaster/bldviewer/templates/package.html
+++ b/lib/toaster/bldviewer/templates/package.html
@@ -23,7 +23,7 @@
                 <a href="{% url layer_versions_recipes package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a>{%endif%}</td>
                 <td>
             <div style="height: 4em; overflow:auto">
-                    {% for d in package.tpackage_dependencies_package.all %}
+                    {% for d in package.package_dependencies_source.all %}
                     <a href="#{{d.name}}">{{d.depends_on.name}}</a><br/>
                     {% endfor %}
             </div>
diff --git a/lib/toaster/bldviewer/views.py b/lib/toaster/bldviewer/views.py
index 7be4d4b..3eb785b 100644
--- a/lib/toaster/bldviewer/views.py
+++ b/lib/toaster/bldviewer/views.py
@@ -20,8 +20,9 @@ import operator
 
 from django.db.models import Q
 from django.shortcuts import render
-from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, Target_Package, LogMessage, Variable
-from orm.models import Task_Dependency, Recipe_Dependency, Build_Package, Build_File, Build_Package_Dependency
+from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
+from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
+from orm.models import Target_Installed_Package
 from django.views.decorators.cache import cache_control
 
 @cache_control(no_store=True)
@@ -78,23 +79,20 @@ def configuration(request, build_id):
 
 def bpackage(request, build_id):
     template = 'bpackage.html'
-    packages = Build_Package.objects.filter(build = build_id)
+    packages = Package.objects.filter(build = build_id)
     context = {'build': Build.objects.filter(pk=build_id)[0], 'packages' : packages}
     return render(request, template, context)
 
 def bfile(request, build_id, package_id):
     template = 'bfile.html'
-    files = Build_File.objects.filter(bpackage = package_id)
+    files = Package_File.objects.filter(package = package_id)
     context = {'build': Build.objects.filter(pk=build_id)[0], 'files' : files}
     return render(request, template, context)
 
 def tpackage(request, build_id, target_id):
     template = 'package.html'
-
-    packages = Target_Package.objects.filter(target=target_id)
-
-    context = {'build' : Build.objects.filter(pk=build_id)[0],'packages': packages}
-
+    packages = map(lambda x: x.package, list(Target_Installed_Package.objects.filter(target=target_id)))
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'packages' : packages}
     return render(request, template, context)
 
 def layer(request):
@@ -135,17 +133,16 @@ def model_explorer(request, model_name):
     model_mapping = {
         'build': Build,
         'target': Target,
-        'target_package': Target_Package,
         'task': Task,
         'task_dependency': Task_Dependency,
-        'package': Build_Package,
+        'package': Package,
         'layer': Layer,
         'layerversion': Layer_Version,
         'recipe': Recipe,
         'recipe_dependency': Recipe_Dependency,
-        'build_package': Build_Package,
-        'build_package_dependency': Build_Package_Dependency,
-        'build_file': Build_File,
+        'package': Package,
+        'package_dependency': Package_Dependency,
+        'build_file': Package_File,
         'variable': Variable,
         'logmessage': LogMessage,
         }
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0bb048c..b30e405 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -130,7 +130,7 @@ class Task_Dependency(models.Model):
     depends_on = models.ForeignKey(Task, related_name='task_dependencies_depends')
 
 
-class Build_Package(models.Model):
+class Package(models.Model):
     build = models.ForeignKey('Build')
     recipe = models.ForeignKey('Recipe', null=True)
     name = models.CharField(max_length=100)
@@ -139,16 +139,19 @@ class Build_Package(models.Model):
     summary = models.CharField(max_length=200, blank=True)
     description = models.CharField(max_length=200, blank=True)
     size = models.IntegerField(default=0)
+    installed_size = models.IntegerField(default=0)
     section = models.CharField(max_length=80, blank=True)
     license = models.CharField(max_length=80, blank=True)
 
-class Build_Package_Dependency(models.Model):
+class Package_Dependency(models.Model):
     TYPE_RDEPENDS = 0
     TYPE_RPROVIDES = 1
     TYPE_RRECOMMENDS = 2
     TYPE_RSUGGESTS = 3
     TYPE_RREPLACES = 4
     TYPE_RCONFLICTS = 5
+    TYPE_TRDEPENDS = 6
+    TYPE_TRECOMMENDS = 7
     DEPENDS_TYPE = (
         (TYPE_RDEPENDS, "rdepends"),
         (TYPE_RPROVIDES, "rprovides"),
@@ -156,46 +159,23 @@ class Build_Package_Dependency(models.Model):
         (TYPE_RSUGGESTS, "rsuggests"),
         (TYPE_RREPLACES, "rreplaces"),
         (TYPE_RCONFLICTS, "rconflicts"),
+        (TYPE_TRDEPENDS, "trdepends"),
+        (TYPE_TRECOMMENDS, "trecommends"),
     )
-    package = models.ForeignKey(Build_Package, related_name='bpackage_dependencies_package')
-    depends_on = models.CharField(max_length=100)   # soft dependency
+    package = models.ForeignKey(Package, related_name='package_dependencies_source')
+    depends_on = models.ForeignKey(Package, related_name='package_dependencies_target')   # soft dependency
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
+    target = models.ForeignKey(Target, null=True)
 
+class Target_Installed_Package(models.Model):
+    target = models.ForeignKey(Target)
+    package = models.ForeignKey(Package)
 
-class Target_Package(models.Model):
-    target = models.ForeignKey('Target')
-    recipe = models.ForeignKey('Recipe', null=True)
-    name = models.CharField(max_length=100)
-    version = models.CharField(max_length=100, blank=True)
-    size = models.IntegerField()
-
-
-class Target_Package_Dependency(models.Model):
-    TYPE_DEPENDS = 0
-    TYPE_RDEPENDS = 1
-    TYPE_RECOMMENDS = 2
-
-    DEPENDS_TYPE = (
-        (TYPE_DEPENDS, "depends"),
-        (TYPE_RDEPENDS, "rdepends"),
-        (TYPE_RECOMMENDS, "recommends"),
-    )
-    package = models.ForeignKey(Target_Package, related_name='tpackage_dependencies_package')
-    depends_on = models.ForeignKey(Target_Package, related_name='tpackage_dependencies_depends')
-    dep_type = models.IntegerField(choices=DEPENDS_TYPE)
-
-
-class Build_File(models.Model):
-    bpackage = models.ForeignKey(Build_Package, related_name='filelist_bpackage')
+class Package_File(models.Model):
+    package = models.ForeignKey(Package, related_name='buildfilelist_package')
     path = models.FilePathField(max_length=255, blank=True)
     size = models.IntegerField()
 
-class Target_File(models.Model):
-    tpackage = models.ForeignKey(Target_Package, related_name='filelist_tpackage')
-    path = models.FilePathField(max_length=255, blank=True)
-    size = models.IntegerField()
-
-
 class Recipe(models.Model):
     name = models.CharField(max_length=100, blank=True)
     version = models.CharField(max_length=100, blank=True)
-- 
1.8.1.2


