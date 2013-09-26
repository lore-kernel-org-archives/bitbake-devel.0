Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id EB79F61626
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2013 12:09:52 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Sep 2013 05:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,985,1371106800"; d="scan'208";a="409753402"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 26 Sep 2013 05:09:51 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 23F12560681; Thu, 26 Sep 2013 13:09:51 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Sep 2013 13:09:47 +0100
Message-Id: <1380197387-15773-2-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1380197387-15773-1-git-send-email-alexandru.damian@intel.com>
References: <1380197387-15773-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/3] bitbake: add DSI UI interface
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
X-List-Received-Date: Thu, 26 Sep 2013 12:09:53 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding a new bitbake UI interface named DSI.

DSI listens for events and data coming from a
bitbake server during a run, and records it
in a data store using the webhob object model.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 696 +++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/ui/dsi.py             | 569 ++++++++++++++++++++++++++++
 2 files changed, 1265 insertions(+)
 create mode 100644 bitbake/lib/bb/ui/buildinfohelper.py
 create mode 100644 bitbake/lib/bb/ui/dsi.py

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
new file mode 100644
index 0000000..a8b568e
--- /dev/null
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -0,0 +1,696 @@
+#
+# BitBake DSI Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import datetime
+import sys
+import bb
+import re
+
+
+os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
+
+import webhob.whbmain.settings as whb_django_settings
+from webhob.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
+from webhob.orm.models import Target_Package, Build_Package, Variable, Build_File
+from webhob.orm.models import Task_Dependency, Build_Package_Dependency, Target_Package_Dependency, Recipe_Dependency
+from bb.msg import BBLogFormatter as format
+
+class ORMWrapper(object):
+    """ This class creates the dictionaries needed to store information in the database
+        following the format defined by the Django models. It is also used to save this
+        information in the database.
+    """
+
+    def __init__(self):
+        pass
+
+
+    def create_build_object(self, build_info):
+
+        build = Build.objects.create(
+                                    machine=build_info['machine'],
+                                    distro=build_info['distro'],
+                                    distro_version=build_info['distro_version'],
+                                    started_on=build_info['started_on'],
+                                    completed_on=build_info['completed_on'],
+                                    cooker_log_path=build_info['cooker_log_path'],
+                                    build_name=build_info['build_name'],
+                                    bitbake_version=build_info['bitbake_version'])
+
+        return build
+
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
+    def update_build_object(self, build, errors, warnings, taskfailures):
+
+        outcome = Build.SUCCEEDED
+        if errors or taskfailures:
+            outcome = Build.FAILED
+
+        build.completed_on = datetime.datetime.now()
+        build.errors_no = errors
+        build.warnings_no = warnings
+        build.outcome = outcome
+        build.save()
+
+
+    def get_update_task_object(self, task_information):
+        task_object, created = Task.objects.get_or_create(
+                                build=task_information['build'],
+                                recipe=task_information['recipe'],
+                                task_name=task_information['task_name'],
+                                )
+
+        for v in vars(task_object):
+            if v in task_information.keys():
+                vars(task_object)[v] = task_information[v]
+        # if we got covered by a setscene task, we're SSTATE
+        if task_object.outcome == Task.OUTCOME_COVERED and 1 == Task.objects.filter(task_executed=True, build = task_object.build, recipe = task_object.recipe, task_name=task_object.task_name+"_setscene").count():
+            task_object.outcome = Task.OUTCOME_SSTATE
+
+        # mark down duration if we have a start time
+        if 'start_time' in task_information.keys():
+            duration = datetime.datetime.now() - task_information['start_time']
+            task_object.elapsed_time = duration.total_seconds()
+
+        task_object.save()
+        return task_object
+
+
+    def get_update_recipe_object(self, recipe_information):
+
+        recipe_object, created = Recipe.objects.get_or_create(
+                                         layer_version=recipe_information['layer_version'],
+                                         file_path=recipe_information['file_path'])
+
+        for v in vars(recipe_object):
+            if v in recipe_information.keys():
+                vars(recipe_object)[v] = recipe_information[v]
+
+        recipe_object.save()
+
+        return recipe_object
+
+    def get_layer_version_object(self, layer_version_information):
+
+        layer_version_object = Layer_Version.objects.get_or_create(
+                                    layer = layer_version_information['layer'],
+                                    branch = layer_version_information['branch'],
+                                    commit = layer_version_information['commit'],
+                                    priority = layer_version_information['priority']
+                                    )
+
+        layer_version_object[0].save()
+
+        return layer_version_object[0]
+
+    def get_update_layer_object(self, layer_information):
+
+        layer_object = Layer.objects.get_or_create(
+                                name=layer_information['name'],
+                                local_path=layer_information['local_path'],
+                                layer_index_url=layer_information['layer_index_url'])
+        layer_object[0].save()
+
+        return layer_object[0]
+
+
+    def save_target_package_information(self, target_obj, packagedict, bldpkgs, recipes):
+        for p in packagedict:
+            packagedict[p]['object'] = Target_Package.objects.create( target = target_obj,
+                                        name = p,
+                                        size = packagedict[p]['size'])
+            if p in bldpkgs:
+                packagedict[p]['object'].version = bldpkgs[p]['version']
+                packagedict[p]['object'].recipe =  recipes[bldpkgs[p]['pn']]
+                packagedict[p]['object'].save()
+
+        for p in packagedict:
+            for px in packagedict[p]['depends']:
+                Target_Package_Dependency.objects.create( package = packagedict[p]['object'],
+                                        depends_on = packagedict[px]['object'] );
+
+
+    def create_logmessage(self, log_information):
+        log_object = LogMessage.objects.create(
+                        build = log_information['build'],
+                        level = log_information['level'],
+                        message = log_information['message'])
+
+        for v in vars(log_object):
+            if v in log_information.keys():
+                vars(log_object)[v] = log_information[v]
+
+        return log_object.save()
+
+
+    def save_build_package_information(self, build_obj, package_info, recipes, files):
+        # create and save the object
+        bp_object = Build_Package.objects.create( build = build_obj,
+                                       recipe = recipes[package_info['PN']],
+                                       name = package_info['PKG'],
+                                       version = package_info['PKGV'],
+                                       revision = package_info['PKGR'],
+                                       summary = package_info['SUMMARY'],
+                                       description = package_info['DESCRIPTION'],
+                                       size = package_info['PKGSIZE'],
+                                       section = package_info['SECTION'],
+                                       license = package_info['LICENSE'],
+                                       )
+        # save any attached file information
+        if bp_object.name in files.keys():
+            for path, size in files[bp_object.name]:
+                fo = Build_File.objects.create( bpackage = bp_object,
+                                        path = path,
+                                        size = size )
+            del files[bp_object.name]
+
+        # save soft dependency information
+        if package_info['RDEPENDS'] is not None:
+            for p in package_info['RDEPENDS'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RDEPENDS)
+        if package_info['RPROVIDES'] is not None:
+            for p in package_info['RPROVIDES'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RPROVIDES)
+        if package_info['RRECOMMENDS'] is not None:
+            for p in package_info['RRECOMMENDS'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RRECOMMENDS)
+        if package_info['RSUGGESTS'] is not None:
+            for p in package_info['RSUGGESTS'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RSUGGESTS)
+        if package_info['RREPLACES'] is not None:
+            for p in package_info['RREPLACES'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RREPLACES)
+        if package_info['RCONFLICTS'] is not None:
+            for p in package_info['RCONFLICTS'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RCONFLICTS)
+
+        return bp_object
+
+    def save_build_variables(self, build_obj, vardump):
+        for k in vardump:
+            if not bool(vardump[k]['func']):
+                Variable.objects.create( build = build_obj,
+                    variable_name = k,
+                    variable_value = vardump[k]['v'],
+                    description = vardump[k]['doc'])
+
+
+class BuildInfoHelper(object):
+    """ This class gathers the build information from the server and sends it
+        towards the ORM wrapper for storing in the database
+        It is instantiated once per build
+        Keeps in memory all data that needs matching before writing it to the database
+    """
+
+    def __init__(self, server, has_build_history = False):
+        self._configure_django()
+        self.internal_state = {}
+        self.task_order = 0
+        self.server = server
+        self.orm_wrapper = ORMWrapper()
+        self.has_build_history = has_build_history
+        self.tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
+
+    def _configure_django(self):
+        # Add webhob to sys path for importing modules
+        sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
+
+    ###################
+    ## methods to convert event/external info into objects that the ORM layer uses
+
+    def _get_layer_dict(self, layer_path):
+
+        layer_info = {}
+        layer_name = layer_path.split('/')[-1]
+        layer_url = 'http://layers.openembedded.org/layerindex/layer/{layer}/'
+        layer_url_name = self._get_url_map_name(layer_name)
+
+        layer_info['name'] = layer_name
+        layer_info['local_path'] = layer_path
+        layer_info['layer_index_url'] = layer_url.format(layer=layer_url_name)
+
+        return layer_info
+
+    def _get_url_map_name(self, layer_name):
+        """ Some layers have a different name on openembedded.org site,
+            this method returns the correct name to use in the URL
+        """
+
+        url_name = layer_name
+        url_mapping = {'meta': 'openembedded-core'}
+
+        for key in url_mapping.keys():
+            if key == layer_name:
+                url_name = url_mapping[key]
+
+        return url_name
+
+    def _get_layer_information(self):
+
+        layer_info = {}
+
+        return layer_info
+
+    def _get_layer_version_information(self, layer_object):
+
+        layer_version_info = {}
+        layer_version_info['build'] = self.internal_state['build']
+        layer_version_info['layer'] = layer_object
+        layer_version_info['branch'] = self._get_git_branch(layer_object.local_path)
+        layer_version_info['commit'] = self._get_git_revision(layer_object.local_path)
+        layer_version_info['priority'] = 0
+
+        return layer_version_info
+
+
+    def _get_git_branch(self, layer_path):
+        branch = os.popen('cd {path}; git branch 2>&1 | grep "^* " | tr -d "* "'.format(path=layer_path)).read()
+
+        if len(branch) != 0:
+            return branch
+        return "<unknown>"
+
+    def _get_git_revision(self, layer_path):
+        f = os.popen("cd {path}; git log -n 1 --pretty=oneline -- 2>&1".format(path=layer_path))
+        data = f.read()
+        if f.close() is None:
+            rev = data.split(" ")[0]
+            if len(rev) != 0:
+                return rev
+        return "<unknown>"
+
+
+    def _get_build_information(self):
+        build_info = {}
+        # Generate an identifier for each new build
+
+        build_info['machine'] = self.server.runCommand(["getVariable", "MACHINE"])[0]
+        build_info['distro'] = self.server.runCommand(["getVariable", "DISTRO"])[0]
+        build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
+        build_info['started_on'] = datetime.datetime.now()
+        build_info['completed_on'] = datetime.datetime.now()
+        build_info['image_fstypes'] = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
+        build_info['cooker_log_path'] = self.server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
+        build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
+        build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
+
+        return build_info
+
+    def _get_task_information(self, event, recipe):
+
+
+        task_information = {}
+        task_information['build'] = self.internal_state['build']
+        task_information['outcome'] = Task.OUTCOME_NA
+        task_information['recipe'] = recipe
+        task_information['task_name'] = event.taskname
+        try:
+            # some tasks don't come with a hash. and that's ok
+            task_information['sstate_checksum'] = event.taskhash
+        except AttributeError:
+            pass
+        return task_information
+
+    def _get_layer_version_for_path(self, path):
+        def _slkey(layer_version):
+            return len(layer_version.layer.local_path)
+
+        # Heuristics: we always match recipe to the deepest layer path that
+        # we can match to the recipe file path
+        for bl in sorted(self.internal_state['layer_versions'], reverse=True, key=_slkey):
+            if (path.startswith(bl.layer.local_path)):
+                return bl
+
+        #TODO: if we get here, we didn't read layers correctly
+        assert False
+        return None
+
+    def _get_recipe_information_from_build_event(self, event):
+
+        layer_version_obj = self._get_layer_version_for_path(re.split(':', event.taskfile)[-1])
+
+        recipe_info = {}
+        recipe_info['layer_version'] = layer_version_obj
+        recipe_info['file_path'] = re.split(':', event.taskfile)[-1]
+
+        return recipe_info
+
+    def _get_task_build_stats(self, task_object):
+        bs_path = self._get_path_information(task_object)
+        task_build_stats = self._get_build_stats_from_file(bs_path, task_object.task_name)
+
+        return task_build_stats
+
+    def _get_path_information(self, task_object):
+        build_stats_format = "{tmpdir}/buildstats/{target}-{machine}/{buildname}/{package}/"
+        build_stats_path = []
+
+        for t in self.internal_state['targets']:
+            target = t.target
+            machine = self.internal_state['build'].machine
+            buildname = self.internal_state['build'].build_name
+            package = task_object.recipe.name + "-" + task_object.recipe.version.strip(":")
+
+            build_stats_path.append(build_stats_format.format(tmpdir=self.tmp_dir, target=target,
+                                                     machine=machine, buildname=buildname,
+                                                     package=package))
+
+        return build_stats_path
+
+    def _get_build_stats_from_file(self, bs_path, task_name):
+
+        task_bs_filename = str(bs_path) + str(task_name)
+        task_bs = open(task_bs_filename, 'r')
+
+        cpu_usage = 0
+        disk_io = 0
+        startio = ''
+        endio = ''
+
+        for line in task_bs.readlines():
+            if line.startswith('CPU usage: '):
+                cpu_usage = line[11:]
+            elif line.startswith('EndTimeIO: '):
+                endio = line[11:]
+            elif line.startswith('StartTimeIO: '):
+                startio = line[13:]
+
+        task_bs.close()
+
+        if startio and endio:
+            disk_io = int(endio.strip('\n ')) - int(startio.strip('\n '))
+
+        if cpu_usage:
+            cpu_usage = float(cpu_usage.strip('% \n'))
+
+        task_build_stats = {'cpu_usage': cpu_usage, 'disk_io': disk_io}
+
+        return task_build_stats
+
+
+    ################################
+    ## external available methods to store information
+
+    def store_layer_info(self):
+        layers = self.server.runCommand(["getVariable", "BBLAYERS"])[0].strip().split(" ")
+        self.internal_state['layers'] = []
+        for layer_path in { l for l in layers if len(l) }:
+            layer_information = self._get_layer_dict(layer_path)
+            self.internal_state['layers'].append(self.orm_wrapper.get_update_layer_object(layer_information))
+
+    def store_started_build(self, event):
+
+        build_information = self._get_build_information()
+
+        build_obj = self.orm_wrapper.create_build_object(build_information)
+        self.internal_state['build'] = build_obj
+
+        # create target information
+        target_information = {}
+        target_information['targets'] = event.getPkgs()
+        target_information['build'] = build_obj
+
+        self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
+
+        # Load layer information for the build
+        self.internal_state['layer_versions'] = []
+        for layer_object in self.internal_state['layers']:
+            layer_version_information = self._get_layer_version_information(layer_object)
+            self.internal_state['layer_versions'].append(self.orm_wrapper.get_layer_version_object(layer_version_information))
+
+        del self.internal_state['layers']
+        # Save build configuration
+        self.orm_wrapper.save_build_variables(build_obj, self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0])
+
+
+    def update_build_information(self, event, errors, warnings, taskfailures):
+        if 'build' in self.internal_state:
+            self.orm_wrapper.update_build_object(self.internal_state['build'], errors, warnings, taskfailures)
+
+    def store_started_task(self, event):
+        identifier = re.split(':', event.taskfile)[-1] + event.taskname
+
+        recipe_information = self._get_recipe_information_from_build_event(event)
+        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
+
+        task_information = self._get_task_information(event, recipe)
+        task_information['outcome'] = Task.OUTCOME_NA
+
+        if isinstance(event, bb.runqueue.runQueueTaskSkipped):
+            task_information['task_executed'] = False
+            if event.reason == "covered":
+                task_information['outcome'] = Task.OUTCOME_COVERED
+            if event.reason == "existing":
+                task_information['outcome'] = Task.OUTCOME_EXISTING
+        else:
+            task_information['task_executed'] = True
+
+        self.task_order += 1
+        task_information['order'] = self.task_order
+        task_obj = self.orm_wrapper.get_update_task_object(task_information)
+
+        self.internal_state[identifier] = {'start_time': datetime.datetime.now()}
+
+    def update_and_store_task(self, event):
+        identifier = re.split(':', event.taskfile)[-1] + event.taskname
+        recipe_information = self._get_recipe_information_from_build_event(event)
+        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
+        task_information = self._get_task_information(event,recipe)
+        try:
+            task_information['start_time'] = self.internal_state[identifier]['start_time']
+        except:
+            pass
+
+        if 'logfile' in vars(event):
+            task_information['logfile'] = event.logfile
+
+        if '_message' in vars(event):
+            task_information['message'] = event._message
+
+        if isinstance(event, (bb.runqueue.runQueueTaskCompleted, bb.runqueue.sceneQueueTaskCompleted)):
+            task_information['outcome'] = Task.OUTCOME_SUCCESS
+            task_build_stats = self._get_task_build_stats(self.orm_wrapper.get_update_task_object(task_information))
+            task_information['cpu_usage'] = task_build_stats['cpu_usage']
+            task_information['disk_io'] = task_build_stats['disk_io']
+            del self.internal_state[identifier]
+
+        if isinstance(event, bb.runqueue.runQueueTaskFailed):
+            task_information['outcome'] = Task.OUTCOME_FAILED
+            del self.internal_state[identifier]
+
+        self.orm_wrapper.get_update_task_object(task_information)
+
+
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
+
+
+    def store_dependency_information(self, event):
+        # save layer version priorities
+        for lv in event._depgraph['layer-priorities']:
+            (name, path, regexp, priority) = lv
+            layer_version_obj = self._get_layer_version_for_path(path[1:]) # paths start with a ^
+            assert layer_version_obj is not None
+            layer_version_obj.priority = priority
+            layer_version_obj.save()
+
+        # save build time package information
+        self.internal_state['bldpkgs'] = {}
+        for pkg  in event._depgraph['packages']:
+            self.internal_state['bldpkgs'][pkg] = event._depgraph['packages'][pkg]
+
+        # save recipe information
+        self.internal_state['recipes'] = {}
+        for pn in event._depgraph['pn']:
+
+            file_name = re.split(':', event._depgraph['pn'][pn]['filename'])[-1]
+            layer_version_obj = self._get_layer_version_for_path(re.split(':', file_name)[-1])
+
+            assert layer_version_obj is not None
+
+            recipe_info = {}
+            recipe_info['name'] = pn
+            recipe_info['version'] = event._depgraph['pn'][pn]['version']
+            recipe_info['layer_version'] = layer_version_obj
+            recipe_info['summary'] = event._depgraph['pn'][pn]['summary']
+            recipe_info['license'] = event._depgraph['pn'][pn]['license']
+            recipe_info['description'] = event._depgraph['pn'][pn]['description']
+            recipe_info['section'] = event._depgraph['pn'][pn]['section']
+            recipe_info['licensing_info'] = 'Not Available'
+            recipe_info['homepage'] = event._depgraph['pn'][pn]['homepage']
+            recipe_info['bugtracker'] = event._depgraph['pn'][pn]['bugtracker']
+            recipe_info['author'] = 'Not Available'
+            recipe_info['file_path'] = file_name
+            recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
+            recipe.is_image = True in map(lambda x: x.endswith('image.bbclass'), event._depgraph['pn'][pn]['inherits'])
+            if recipe.is_image:
+                for t in self.internal_state['targets']:
+                    if pn == t.target:
+                        t.is_image = True
+                        t.save()
+            self.internal_state['recipes'][pn] = recipe
+
+        # save recipe dependency
+        try:
+            # buildtime
+            for recipe in event._depgraph['depends']:
+                target = self.internal_state['recipes'][recipe]
+                for dep in event._depgraph['depends'][recipe]:
+                    dependency = self.internal_state['recipes'][dep]
+                    Recipe_Dependency.objects.get_or_create( recipe = target,
+                            depends_on = dependency, dep_type = Recipe_Dependency.TYPE_DEPENDS)
+
+            # runtime
+            for recipe in event._depgraph['rdepends-pn']:
+                target = self.internal_state['recipes'][recipe]
+                for dep in event._depgraph['rdepends-pn'][recipe]:
+                    dependency = self.internal_state['recipes'][dep]
+                    Recipe_Dependency.objects.get_or_create( recipe = target,
+                            depends_on = dependency, dep_type = Recipe_Dependency.TYPE_RDEPENDS)
+
+        except KeyError:    # we'll not get recipes for key w/ values listed in ASSUME_PROVIDED
+            pass
+
+        # save all task information
+        def _save_a_task(taskdesc):
+            spec = re.split(r'\.', taskdesc);
+            pn = ".".join(spec[0:-1])
+            taskname = spec[-1]
+            e = event
+            e.taskname = pn
+            recipe = self.internal_state['recipes'][pn]
+            task_info = self._get_task_information(e, recipe)
+            task_info['task_name'] = taskname
+            task_obj = self.orm_wrapper.get_update_task_object(task_info)
+            return task_obj
+
+        for taskdesc in event._depgraph['tdepends']:
+            target = _save_a_task(taskdesc)
+            for taskdesc1 in event._depgraph['tdepends'][taskdesc]:
+                dep = _save_a_task(taskdesc1)
+                Task_Dependency.objects.get_or_create( task = target, depends_on = dep )
+
+    def store_build_package_information(self, event):
+        package_info = event.data
+        self.orm_wrapper.save_build_package_information(self.internal_state['build'],
+                            package_info,
+                            self.internal_state['recipes'],
+                            self.internal_state['package_files'])
+
+
+    def store_package_file_information(self, event):
+        if not 'package_files' in self.internal_state.keys():
+            self.internal_state['package_files'] = {}
+
+        data = event.data
+        self.internal_state['package_files'][data['PKG']] = data['FILES']
+
+    def store_log_information(self, level, text):
+        log_information = {}
+        log_information['build'] = self.internal_state['build']
+        log_information['level'] = level
+        log_information['message'] = text
+        self.orm_wrapper.create_logmessage(log_information)
+
+    def store_log_event(self, event):
+        # look up license files info from insane.bbclass
+        m = re.match("([^:]*): md5 checksum matched for ([^;]*)", event.msg)
+        if m:
+            (pn, fn) = m.groups()
+            self.internal_state['recipes'][pn].licensing_info = fn
+            self.internal_state['recipes'][pn].save()
+
+        if event.levelno < format.WARNING:
+            return
+        if not 'build' in self.internal_state:
+            return
+        log_information = {}
+        log_information['build'] = self.internal_state['build']
+        if event.levelno >= format.ERROR:
+            log_information['level'] = LogMessage.ERROR
+        elif event.levelno == format.WARNING:
+            log_information['level'] = LogMessage.WARNING
+        log_information['message'] = event.msg
+        log_information['pathname'] = event.pathname
+        log_information['lineno'] = event.lineno
+        self.orm_wrapper.create_logmessage(log_information)
+
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
new file mode 100644
index 0000000..434a6dd
--- /dev/null
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -0,0 +1,569 @@
+#
+# BitBake DSI Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from __future__ import division
+try:
+    import bb
+except RuntimeError as exc:
+    sys.exit(str(exc))
+
+from bb.ui import uihelper
+from bb.ui.buildinfohelper import BuildInfoHelper
+
+import bb.msg
+import copy
+import fcntl
+import logging
+import os
+import progressbar
+import signal
+import struct
+import sys
+import time
+import xmlrpclib
+
+featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES, bb.cooker.CookerFeatures.SEND_DEPENDS_TREE]
+
+logger = logging.getLogger("BitBake")
+interactive = sys.stdout.isatty()
+
+
+class BBProgress(progressbar.ProgressBar):
+    def __init__(self, msg, maxval):
+        self.msg = msg
+        widgets = [progressbar.Percentage(), ' ', progressbar.Bar(), ' ',
+           progressbar.ETA()]
+
+        try:
+            self._resize_default = signal.getsignal(signal.SIGWINCH)
+        except:
+            self._resize_default = None
+        progressbar.ProgressBar.__init__(self, maxval, [self.msg + ": "] + widgets)
+
+    def _handle_resize(self, signum, frame):
+        progressbar.ProgressBar._handle_resize(self, signum, frame)
+        if self._resize_default:
+            self._resize_default(signum, frame)
+    def finish(self):
+        progressbar.ProgressBar.finish(self)
+        if self._resize_default:
+            signal.signal(signal.SIGWINCH, self._resize_default)
+
+class NonInteractiveProgress(object):
+    fobj = sys.stdout
+
+    def __init__(self, msg, maxval):
+        self.msg = msg
+        self.maxval = maxval
+
+    def start(self):
+        self.fobj.write("%s..." % self.msg)
+        self.fobj.flush()
+        return self
+
+    def update(self, value):
+        pass
+
+    def finish(self):
+        self.fobj.write("done.\n")
+        self.fobj.flush()
+
+def new_progress(msg, maxval):
+    if interactive:
+        return BBProgress(msg, maxval)
+    else:
+        return NonInteractiveProgress(msg, maxval)
+
+def pluralise(singular, plural, qty):
+    if(qty == 1):
+        return singular % qty
+    else:
+        return plural % qty
+
+
+class InteractConsoleLogFilter(logging.Filter):
+    def __init__(self, tf, format):
+        self.tf = tf
+        self.format = format
+
+    def filter(self, record):
+        if record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ")):
+            return False
+        self.tf.clearFooter()
+        return True
+
+class TerminalFilter(object):
+    columns = 80
+
+    def sigwinch_handle(self, signum, frame):
+        self.columns = self.getTerminalColumns()
+        if self._sigwinch_default:
+            self._sigwinch_default(signum, frame)
+
+    def getTerminalColumns(self):
+        def ioctl_GWINSZ(fd):
+            try:
+                cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))
+            except:
+                return None
+            return cr
+        cr = ioctl_GWINSZ(sys.stdout.fileno())
+        if not cr:
+            try:
+                fd = os.open(os.ctermid(), os.O_RDONLY)
+                cr = ioctl_GWINSZ(fd)
+                os.close(fd)
+            except:
+                pass
+        if not cr:
+            try:
+                cr = (env['LINES'], env['COLUMNS'])
+            except:
+                cr = (25, 80)
+        return cr[1]
+
+    def __init__(self, main, helper, console, format):
+        self.main = main
+        self.helper = helper
+        self.cuu = None
+        self.stdinbackup = None
+        self.interactive = sys.stdout.isatty()
+        self.footer_present = False
+        self.lastpids = []
+
+        if not self.interactive:
+            return
+
+        try:
+            import curses
+        except ImportError:
+            sys.exit("FATAL: The knotty ui could not load the required curses python module.")
+
+        import termios
+        self.curses = curses
+        self.termios = termios
+        try:
+            fd = sys.stdin.fileno()
+            self.stdinbackup = termios.tcgetattr(fd)
+            new = copy.deepcopy(self.stdinbackup)
+            new[3] = new[3] & ~termios.ECHO
+            termios.tcsetattr(fd, termios.TCSADRAIN, new)
+            curses.setupterm()
+            if curses.tigetnum("colors") > 2:
+                format.enable_color()
+            self.ed = curses.tigetstr("ed")
+            if self.ed:
+                self.cuu = curses.tigetstr("cuu")
+            try:
+                self._sigwinch_default = signal.getsignal(signal.SIGWINCH)
+                signal.signal(signal.SIGWINCH, self.sigwinch_handle)
+            except:
+                pass
+            self.columns = self.getTerminalColumns()
+        except:
+            self.cuu = None
+        console.addFilter(InteractConsoleLogFilter(self, format))
+
+    def clearFooter(self):
+        if self.footer_present:
+            lines = self.footer_present
+            sys.stdout.write(self.curses.tparm(self.cuu, lines))
+            sys.stdout.write(self.curses.tparm(self.ed))
+        self.footer_present = False
+
+    def updateFooter(self):
+        if not self.cuu:
+            return
+        activetasks = self.helper.running_tasks
+        failedtasks = self.helper.failed_tasks
+        runningpids = self.helper.running_pids
+        if self.footer_present and (self.lastcount == self.helper.tasknumber_current) and (self.lastpids == runningpids):
+            return
+        if self.footer_present:
+            self.clearFooter()
+        if (not self.helper.tasknumber_total or self.helper.tasknumber_current == self.helper.tasknumber_total) and not len(activetasks):
+            return
+        tasks = []
+        for t in runningpids:
+            tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
+
+        if self.main.shutdown:
+            content = "Waiting for %s running tasks to finish:" % len(activetasks)
+        elif not len(activetasks):
+            content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
+        else:
+            content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
+        print(content)
+        lines = 1 + int(len(content) / (self.columns + 1))
+        for tasknum, task in enumerate(tasks):
+            content = "%s: %s" % (tasknum, task)
+            print(content)
+            lines = lines + 1 + int(len(content) / (self.columns + 1))
+        self.footer_present = lines
+        self.lastpids = runningpids[:]
+        self.lastcount = self.helper.tasknumber_current
+
+    def finish(self):
+        if self.stdinbackup:
+            fd = sys.stdin.fileno()
+            self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
+
+def _log_settings_from_server(server):
+    # Get values of variables which control our output
+    includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
+    if error:
+        logger.error("Unable to get the value of BBINCLUDELOGS variable: %s" % error)
+        raise BaseException(error)
+    loglines, error = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
+    if error:
+        logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
+        raise BaseException(error)
+    consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    if error:
+        logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
+        raise BaseException(error)
+    return includelogs, loglines, consolelogfile
+
+def main(server, eventHandler, params, tf = TerminalFilter):
+
+    includelogs, loglines, consolelogfile = _log_settings_from_server(server)
+
+
+    # verify and warn
+    build_history_enabled = True
+    inheritlist, error = server.runCommand(["getVariable", "INHERIT"])
+    if not "buildhistory" in inheritlist.split(" "):
+        logger.warn("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
+        build_history_enabled = False
+
+    if sys.stdin.isatty() and sys.stdout.isatty():
+        log_exec_tty = True
+    else:
+        log_exec_tty = False
+
+    helper = uihelper.BBUIHelper()
+
+    console = logging.StreamHandler(sys.stdout)
+    format_str = "%(levelname)s: %(message)s"
+    format = bb.msg.BBLogFormatter(format_str)
+    bb.msg.addDefaultlogFilter(console)
+    console.setFormatter(format)
+    logger.addHandler(console)
+
+    if consolelogfile and not params.options.show_environment:
+        bb.utils.mkdirhier(os.path.dirname(consolelogfile))
+        conlogformat = bb.msg.BBLogFormatter(format_str)
+        consolelog = logging.FileHandler(consolelogfile)
+        bb.msg.addDefaultlogFilter(consolelog)
+        consolelog.setFormatter(conlogformat)
+        logger.addHandler(consolelog)
+
+
+    parseprogress = None
+    cacheprogress = None
+    main.shutdown = 0
+    interrupted = False
+    return_value = 0
+    errors = 0
+    warnings = 0
+    taskfailures = []
+
+    buildinfohelper = BuildInfoHelper(server, build_history_enabled)
+    buildinfohelper.store_layer_info()
+
+    termfilter = tf(main, helper, console, format)
+
+    while True:
+        try:
+            termfilter.updateFooter()
+            event = eventHandler.waitEvent(0.25)
+
+            if event is None:
+                if main.shutdown > 1:
+                    break
+                continue
+
+            helper.eventHandler(event)
+
+            if isinstance(event, bb.event.BuildStarted):
+                buildinfohelper.store_started_build(event)
+
+            if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
+                buildinfohelper.update_and_store_task(event)
+                continue
+
+            if isinstance(event, bb.event.LogExecTTY):
+                if log_exec_tty:
+                    tries = event.retries
+                    while tries:
+                        print("Trying to run: %s" % event.prog)
+                        if os.system(event.prog) == 0:
+                            break
+                        time.sleep(event.sleep_delay)
+                        tries -= 1
+                    if tries:
+                        continue
+                logger.warn(event.msg)
+                continue
+
+            if isinstance(event, logging.LogRecord):
+                buildinfohelper.store_log_event(event)
+                if event.levelno >= format.ERROR:
+                    errors = errors + 1
+                    return_value = 1
+                elif event.levelno == format.WARNING:
+                    warnings = warnings + 1
+                # For "normal" logging conditions, don't show note logs from tasks
+                # but do show them if the user has changed the default log level to
+                # include verbose/debug messages
+                if event.taskpid != 0 and event.levelno <= format.NOTE:
+                    continue
+
+                logger.handle(event)
+                continue
+
+            if isinstance(event, bb.build.TaskFailed):
+                buildinfohelper.update_and_store_task(event)
+                return_value = 1
+                logfile = event.logfile
+                if logfile and os.path.exists(logfile):
+                    termfilter.clearFooter()
+                    bb.error("Logfile of failure stored in: %s" % logfile)
+                    if includelogs and not event.errprinted:
+                        print("Log data follows:")
+                        f = open(logfile, "r")
+                        lines = []
+                        while True:
+                            l = f.readline()
+                            if l == '':
+                                break
+                            l = l.rstrip()
+                            if loglines:
+                                lines.append(' | %s' % l)
+                                if len(lines) > int(loglines):
+                                    lines.pop(0)
+                            else:
+                                print('| %s' % l)
+                        f.close()
+                        if lines:
+                            for line in lines:
+                                print(line)
+
+            if isinstance(event, bb.build.TaskBase):
+                logger.info(event._message)
+                continue
+            if isinstance(event, bb.event.ParseStarted):
+                if event.total == 0:
+                    continue
+                parseprogress = new_progress("Parsing recipes", event.total).start()
+                continue
+            if isinstance(event, bb.event.ParseProgress):
+                parseprogress.update(event.current)
+                continue
+            if isinstance(event, bb.event.ParseCompleted):
+                if not parseprogress:
+                    continue
+
+                parseprogress.finish()
+                print(("Parsing of %d .bb files complete (%d cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
+                    % ( event.total, event.cached, event.parsed, event.virtuals, event.skipped, event.masked, event.errors)))
+                continue
+
+            if isinstance(event, bb.event.CacheLoadStarted):
+                cacheprogress = new_progress("Loading cache", event.total).start()
+                continue
+            if isinstance(event, bb.event.CacheLoadProgress):
+                cacheprogress.update(event.current)
+                continue
+            if isinstance(event, bb.event.CacheLoadCompleted):
+                cacheprogress.finish()
+                print("Loaded %d entries from dependency cache." % event.num_entries)
+                continue
+
+            if isinstance(event, bb.event.MultipleProviders):
+                logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
+                            event._item,
+                            ", ".join(event._candidates))
+                logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
+                continue
+            if isinstance(event, bb.event.NoProvider):
+                return_value = 1
+                errors = errors + 1
+                if event._runtime:
+                    r = "R"
+                else:
+                    r = ""
+
+                if event._dependees:
+                    text = "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
+                else:
+                    text = "Nothing %sPROVIDES '%s'" % (r, event._item)
+
+                logger.error(text)
+                buildinfohelper.store_log_information(2, text)  # don't judge me
+                if event._reasons:
+                    for reason in event._reasons:
+                        logger.error("%s", reason)
+                continue
+
+            if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+                buildinfohelper.store_started_task(event)
+                logger.info("Running setscene task %d of %d (%s)" % (event.stats.completed + event.stats.active + event.stats.failed + 1, event.stats.total, event.taskstring))
+                continue
+
+            if isinstance(event, bb.runqueue.runQueueTaskStarted):
+                if event.noexec:
+                    tasktype = 'noexec task'
+                else:
+                    tasktype = 'task'
+                logger.info("Running %s %s of %s (ID: %s, %s)",
+                            tasktype,
+                            event.stats.completed + event.stats.active +
+                                event.stats.failed + 1,
+                            event.stats.total, event.taskid, event.taskstring)
+                buildinfohelper.store_started_task(event)
+                continue
+
+            if isinstance(event, (bb.runqueue.runQueueTaskStarted, bb.runqueue.runQueueTaskSkipped)):
+                buildinfohelper.store_started_task(event)
+                continue
+
+            if isinstance(event, bb.runqueue.runQueueTaskCompleted):
+                buildinfohelper.update_and_store_task(event)
+                continue
+
+            if isinstance(event, bb.runqueue.runQueueTaskFailed):
+                buildinfohelper.update_and_store_task(event)
+                taskfailures.append(event.taskstring)
+                logger.error("Task %s (%s) failed with exit code '%s'",
+                             event.taskid, event.taskstring, event.exitcode)
+                continue
+
+            if isinstance(event, (bb.runqueue.sceneQueueTaskCompleted, bb.runqueue.sceneQueueTaskFailed)):
+                buildinfohelper.update_and_store_task(event)
+                continue
+
+
+            if isinstance(event, bb.event.ConfigParsed):
+                # timestamp should be added for this
+                continue
+
+            if isinstance(event, bb.event.RecipeParsed):
+                # timestamp should be added for this
+                continue
+
+            if isinstance(event, (bb.event.TreeDataPreparationStarted, bb.event.TreeDataPreparationCompleted)):
+                continue
+
+            if isinstance(event, (bb.event.BuildCompleted)):
+                buildinfohelper.read_target_package_dep_data(event)
+                buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
+                continue
+
+            if isinstance(event, (bb.command.CommandCompleted,
+                                  bb.command.CommandFailed,
+                                  bb.command.CommandExit)):
+
+                buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
+
+                # we start a new build info
+                errors = 0
+                warnings = 0
+                taskfailures = []
+                buildinfohelper = BuildInfoHelper(server, build_history_enabled)
+                buildinfohelper.store_layer_info()
+                continue
+
+            if isinstance(event, bb.event.MetadataEvent):
+                if event.type == "SinglePackageInfo":
+                    buildinfohelper.store_build_package_information(event)
+                elif event.type == "PackageFileSize":
+                    buildinfohelper.store_package_file_information(event)
+                continue
+
+            # ignore
+            if isinstance(event, (bb.event.BuildBase,
+                                  bb.event.StampUpdate,
+                                  bb.event.RecipePreFinalise,
+                                  bb.runqueue.runQueueEvent,
+                                  bb.runqueue.runQueueExitWait,
+                                  bb.event.OperationProgress,
+                                  bb.command.CommandFailed,
+                                  bb.command.CommandExit,
+                                  bb.command.CommandCompleted,
+                                  bb.cooker.CookerExit)):
+                continue
+
+            if isinstance(event, bb.event.DepTreeGenerated):
+                buildinfohelper.store_dependency_information(event)
+                continue
+
+            logger.error("Unknown event: %s", event)
+
+        except EnvironmentError as ioerror:
+            termfilter.clearFooter()
+            # ignore interrupted io
+            if ioerror.args[0] == 4:
+                pass
+        except KeyboardInterrupt:
+            termfilter.clearFooter()
+            if params.observe_only:
+                print("\nKeyboard Interrupt, exiting observer...")
+                main.shutdown = 2
+            if not params.observe_only and main.shutdown == 1:
+                print("\nSecond Keyboard Interrupt, stopping...\n")
+                _, error = server.runCommand(["stateStop"])
+                if error:
+                    logger.error("Unable to cleanly stop: %s" % error)
+            if not params.observe_only and main.shutdown == 0:
+                print("\nKeyboard Interrupt, closing down...\n")
+                interrupted = True
+                _, error = server.runCommand(["stateShutdown"])
+                if error:
+                    logger.error("Unable to cleanly shutdown: %s" % error)
+            main.shutdown = main.shutdown + 1
+            pass
+        except Exception as e:
+            print(e)
+            import traceback
+            traceback.print_exc()
+            pass
+
+    summary = ""
+    if taskfailures:
+        summary += pluralise("\nSummary: %s task failed:",
+                             "\nSummary: %s tasks failed:", len(taskfailures))
+        for failure in taskfailures:
+            summary += "\n  %s" % failure
+    if warnings:
+        summary += pluralise("\nSummary: There was %s WARNING message shown.",
+                             "\nSummary: There were %s WARNING messages shown.", warnings)
+    if return_value:
+        summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
+                             "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
+    if summary:
+        print(summary)
+
+    if interrupted:
+        print("Execution was interrupted, returning a non-zero exit code.")
+        if return_value == 0:
+            return_value = 1
+
+    termfilter.finish()
+
+    return return_value
-- 
1.8.1.2


