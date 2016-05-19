Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id F26EB65CC3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 May 2016 12:59:47 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 19 May 2016 05:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,334,1459839600"; d="scan'208";a="106841810"
Received: from gfois-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.121])
	by fmsmga004.fm.intel.com with ESMTP; 19 May 2016 05:59:49 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 May 2016 13:59:31 +0100
Message-Id: <1463662773-31389-4-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
References: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 4/6] toaster: tests Add a BuildTest helper class
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
X-List-Received-Date: Thu, 19 May 2016 12:59:48 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add a helper class for running build tests. Subclass this and call the
build method to get setup for running tests on the resulting data from a
build.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/tests/builds/README       |  14 +++
 bitbake/lib/toaster/tests/builds/__init__.py  |   0
 bitbake/lib/toaster/tests/builds/buildtest.py | 134 ++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 bitbake/lib/toaster/tests/builds/README
 create mode 100644 bitbake/lib/toaster/tests/builds/__init__.py
 create mode 100644 bitbake/lib/toaster/tests/builds/buildtest.py

diff --git a/bitbake/lib/toaster/tests/builds/README b/bitbake/lib/toaster/tests/builds/README
new file mode 100644
index 0000000..98e3e2e
--- /dev/null
+++ b/bitbake/lib/toaster/tests/builds/README
@@ -0,0 +1,14 @@
+# Running build tests
+
+These tests are to test the running of builds and the data produced by the builds.
+Your oe build environment must be sourced/initialised for these tests to run.
+
+The simplest way to run the tests are the following commands:
+
+$ . oe-init-build-env
+$ cd bitbake/lib/toaster/ # path my vary but this is into toaster's directory
+$ DJANGO_SETTINGS_MODULE='toastermain.settings-test' ./manage.py test tests.builds
+
+Optional environment variables:
+ - TOASTER_DIR (where toaster keeps it's artifacts)
+ - TOASTER_CONF a path to the toasterconf.json file. This will need to be set if you don't execute the tests from toaster's own directory.
diff --git a/bitbake/lib/toaster/tests/builds/__init__.py b/bitbake/lib/toaster/tests/builds/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/toaster/tests/builds/buildtest.py b/bitbake/lib/toaster/tests/builds/buildtest.py
new file mode 100644
index 0000000..fc7bd5b
--- /dev/null
+++ b/bitbake/lib/toaster/tests/builds/buildtest.py
@@ -0,0 +1,134 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2016 Intel Corporation
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
+import os
+import sys
+import time
+import unittest
+
+from orm.models import Project, Release, ProjectTarget, Build
+from bldcontrol.models import BuildEnvironment
+
+from bldcontrol.management.commands.loadconf import Command\
+    as LoadConfigCommand
+
+from bldcontrol.management.commands.runbuilds import Command\
+    as RunBuildsCommand
+
+import subprocess
+
+# We use unittest.TestCase instead of django.test.TestCase because we don't
+# want to wrap everything in a database transaction as an external process
+# (bitbake needs access to the database)
+
+
+class BuildTest(unittest.TestCase):
+
+    PROJECT_NAME = "Testbuild"
+
+    def build(self, target):
+        # So that the buildinfo helper uses the test database'
+        self.assertEqual(
+            os.environ.get('DJANGO_SETTINGS_MODULE', ''),
+            'toastermain.settings-test',
+            "Please initialise django with the tests settings:  "
+            "DJANGO_SETTINGS_MODULE='toastermain.settings-test'")
+
+        if self.target_already_built(target):
+            return
+
+        # Take a guess at the location of the toasterconf
+        poky_toaster_conf = '../../../meta-poky/conf/toasterconf.json'
+        oe_toaster_conf = '../../../meta/conf/toasterconf.json'
+        env_toaster_conf = os.environ.get('TOASTER_CONF')
+
+        config_file = None
+        if env_toaster_conf:
+            config_file = env_toaster_conf
+        else:
+            if os.path.exists(poky_toaster_conf):
+                config_file = poky_toaster_conf
+            elif os.path.exists(oe_toaster_conf):
+                config_file = oe_toaster_conf
+
+        self.assertIsNotNone(config_file,
+                             "Default locations for toasterconf not found"
+                             "please set $TOASTER_CONF manually")
+
+        # Setup the release information and default layers
+        print("\nImporting file: %s" % config_file)
+        os.environ['TOASTER_CONF'] = config_file
+        LoadConfigCommand()._import_layer_config(config_file)
+
+        os.environ['TOASTER_DIR'] = \
+            os.path.abspath(os.environ['BUILDDIR'] + "/../")
+
+        os.environ['BBBASEDIR'] = \
+            subprocess.check_output('which bitbake', shell=True)
+
+        BuildEnvironment.objects.get_or_create(
+            betype=BuildEnvironment.TYPE_LOCAL,
+            sourcedir=os.environ['TOASTER_DIR'],
+            builddir=os.environ['BUILDDIR']
+        )
+
+        release = Release.objects.get(name='local')
+
+        # Create a project for this build to run in
+        try:
+            project = Project.objects.get(name=BuildTest.PROJECT_NAME)
+        except Project.DoesNotExist:
+            project = Project.objects.create_project(
+                name=BuildTest.PROJECT_NAME,
+                release=release
+            )
+
+        ProjectTarget.objects.create(project=project,
+                                     target=target,
+                                     task="")
+        build_request = project.schedule_build()
+
+        # run runbuilds command to dispatch the build
+        # e.g. manage.py runubilds
+        RunBuildsCommand().runbuild()
+
+        build_pk = build_request.build.pk
+        while Build.objects.get(pk=build_pk).outcome == Build.IN_PROGRESS:
+            sys.stdout.write("\rBuilding %s %d%%" %
+                             (target,
+                              build_request.build.completeper()))
+            sys.stdout.flush()
+            time.sleep(1)
+
+        self.assertNotEqual(build_request.build.outcome,
+                            Build.SUCCEEDED, "Build did not SUCCEEDED")
+        print("\nBuild finished")
+        return build_request.build
+
+    def target_already_built(self, target):
+        """ If the target is already built no need to build it again"""
+        for build in Build.objects.filter(
+                project__name=BuildTest.PROJECT_NAME):
+            targets = build.target_set.values_list('target', flat=True)
+            if target in targets:
+                return True
+
+        return False
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


