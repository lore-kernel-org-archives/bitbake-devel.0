Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 4CEB471DAA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 15:49:58 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 28 Oct 2016 08:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,410,1473145200"; d="scan'208";a="1060664044"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2016 08:49:50 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 2E7A16A4006;
	Fri, 28 Oct 2016 08:49:11 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 18:48:48 +0300
Message-Id: <5e8ad6a5f332f53cf2cc1557220fc9cfa09ff0ad.1477669487.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
References: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1477669486.git.ed.bartosh@linux.intel.com>
References: <cover.1477669486.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 7/8] toaster: tests builds Update buildtest
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
X-List-Received-Date: Fri, 28 Oct 2016 15:49:59 -0000

From: Michael Wood <michael.g.wood@intel.com>

Now that we're using fixtures for configuration just load these instead
of trying to search for a toasterconf json file.

Also for convenience add the ability for the tests to source the build
environment script. To use this test make sure that directories are in
the same layout as poky.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/tests/builds/buildtest.py | 129 +++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 48 deletions(-)

diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index fc7bd5b..bf147f0 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -24,16 +24,18 @@ import sys
 import time
 import unittest
 
-from orm.models import Project, Release, ProjectTarget, Build
+from orm.models import Project, Release, ProjectTarget, Build, ProjectVariable
 from bldcontrol.models import BuildEnvironment
 
-from bldcontrol.management.commands.loadconf import Command\
-    as LoadConfigCommand
-
 from bldcontrol.management.commands.runbuilds import Command\
     as RunBuildsCommand
 
+from django.core.management import call_command
+
 import subprocess
+import logging
+
+logger = logging.getLogger("toaster")
 
 # We use unittest.TestCase instead of django.test.TestCase because we don't
 # want to wrap everything in a database transaction as an external process
@@ -43,63 +45,92 @@ import subprocess
 class BuildTest(unittest.TestCase):
 
     PROJECT_NAME = "Testbuild"
+    BUILDDIR = "/tmp/build/"
 
     def build(self, target):
         # So that the buildinfo helper uses the test database'
         self.assertEqual(
             os.environ.get('DJANGO_SETTINGS_MODULE', ''),
-            'toastermain.settings-test',
+            'toastermain.settings_test',
             "Please initialise django with the tests settings:  "
-            "DJANGO_SETTINGS_MODULE='toastermain.settings-test'")
+            "DJANGO_SETTINGS_MODULE='toastermain.settings_test'")
 
-        if self.target_already_built(target):
-            return
+        built = self.target_already_built(target)
+        if built:
+            return built
 
-        # Take a guess at the location of the toasterconf
-        poky_toaster_conf = '../../../meta-poky/conf/toasterconf.json'
-        oe_toaster_conf = '../../../meta/conf/toasterconf.json'
-        env_toaster_conf = os.environ.get('TOASTER_CONF')
+        call_command('loaddata', 'settings.xml', app_label="orm")
+        call_command('loaddata', 'poky.xml', app_label="orm")
 
-        config_file = None
-        if env_toaster_conf:
-            config_file = env_toaster_conf
+        current_builddir = os.environ.get("BUILDDIR")
+        if current_builddir:
+            BuildTest.BUILDDIR = current_builddir
         else:
-            if os.path.exists(poky_toaster_conf):
-                config_file = poky_toaster_conf
-            elif os.path.exists(oe_toaster_conf):
-                config_file = oe_toaster_conf
-
-        self.assertIsNotNone(config_file,
-                             "Default locations for toasterconf not found"
-                             "please set $TOASTER_CONF manually")
-
-        # Setup the release information and default layers
-        print("\nImporting file: %s" % config_file)
-        os.environ['TOASTER_CONF'] = config_file
-        LoadConfigCommand()._import_layer_config(config_file)
-
-        os.environ['TOASTER_DIR'] = \
-            os.path.abspath(os.environ['BUILDDIR'] + "/../")
-
-        os.environ['BBBASEDIR'] = \
-            subprocess.check_output('which bitbake', shell=True)
+            # Setup a builddir based on default layout
+            # bitbake inside openebedded-core
+            oe_init_build_env_path = os.path.join(
+                os.path.dirname(os.path.abspath(__file__)),
+                os.pardir,
+                os.pardir,
+                os.pardir,
+                os.pardir,
+                os.pardir,
+                'oe-init-build-env'
+            )
+            if not os.path.exists(oe_init_build_env_path):
+                raise Exception("We had no BUILDDIR set and couldn't "
+                                "find oe-init-build-env to set this up "
+                                "ourselves please run oe-init-build-env "
+                                "before running these tests")
+
+            oe_init_build_env_path = os.path.realpath(oe_init_build_env_path)
+            cmd = "bash -c 'source oe-init-build-env %s'" % BuildTest.BUILDDIR
+            p = subprocess.Popen(
+                cmd,
+                cwd=os.path.dirname(oe_init_build_env_path),
+                shell=True,
+                stdout=subprocess.PIPE,
+                stderr=subprocess.PIPE)
+
+            output, err = p.communicate()
+            p.wait()
+
+            logger.info("oe-init-build-env %s %s" % (output, err))
+
+            os.environ['BUILDDIR'] = BuildTest.BUILDDIR
+
+        # Setup the path to bitbake we know where to find this
+        bitbake_path = os.path.join(
+            os.path.dirname(os.path.abspath(__file__)),
+            os.pardir,
+            os.pardir,
+            os.pardir,
+            os.pardir,
+            'bin',
+            'bitbake')
+        if not os.path.exists(bitbake_path):
+            raise Exception("Could not find bitbake at the expected path %s"
+                            % bitbake_path)
+
+        os.environ['BBBASEDIR'] = bitbake_path
 
         BuildEnvironment.objects.get_or_create(
             betype=BuildEnvironment.TYPE_LOCAL,
-            sourcedir=os.environ['TOASTER_DIR'],
-            builddir=os.environ['BUILDDIR']
+            sourcedir=BuildTest.BUILDDIR,
+            builddir=BuildTest.BUILDDIR
         )
 
         release = Release.objects.get(name='local')
 
         # Create a project for this build to run in
-        try:
-            project = Project.objects.get(name=BuildTest.PROJECT_NAME)
-        except Project.DoesNotExist:
-            project = Project.objects.create_project(
-                name=BuildTest.PROJECT_NAME,
-                release=release
-            )
+        project = Project.objects.create_project(name=BuildTest.PROJECT_NAME,
+                                                 release=release)
+
+        if os.environ.get("TOASTER_TEST_USE_SSTATE_MIRROR"):
+            ProjectVariable.objects.get_or_create(
+                name="SSTATE_MIRRORS",
+                value="file://.* http://autobuilder.yoctoproject.org/pub/sstate/PATH;downloadfilename=PATH",
+                project=project)
 
         ProjectTarget.objects.create(project=project,
                                      target=target,
@@ -118,9 +149,11 @@ class BuildTest(unittest.TestCase):
             sys.stdout.flush()
             time.sleep(1)
 
-        self.assertNotEqual(build_request.build.outcome,
-                            Build.SUCCEEDED, "Build did not SUCCEEDED")
-        print("\nBuild finished")
+        self.assertEqual(Build.objects.get(pk=build_pk).outcome,
+                         Build.SUCCEEDED,
+                         "Build did not SUCCEEDED")
+
+        logger.info("\nBuild finished %s" % build_request.build.outcome)
         return build_request.build
 
     def target_already_built(self, target):
@@ -129,6 +162,6 @@ class BuildTest(unittest.TestCase):
                 project__name=BuildTest.PROJECT_NAME):
             targets = build.target_set.values_list('target', flat=True)
             if target in targets:
-                return True
+                return build
 
-        return False
+        return None
-- 
2.1.4


