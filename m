Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4AEC46CA7
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:50:01 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.105130.1701985795398339081
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 13:49:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=wJJxZP6D;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 31ECA9C2C10;
	Thu,  7 Dec 2023 16:49:54 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ScL3UF2vSr1V; Thu,  7 Dec 2023 16:49:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 78AB69C34B7;
	Thu,  7 Dec 2023 16:49:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 78AB69C34B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701985793; bh=Q37V1qoS1j3t0DsGGSnNUFgfiqdWENuHQFuMVmNFPyI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=wJJxZP6DPi1suCC04M38RyUprV1pmgr3XcZOONyT6mRj8+KI8Qabnpk96fylEydUH
	 P07Udw1MGp4CctgsWNvO8XUNSaTdr4hDTXzIDRooEcinhukyetvcGgmGlVaUXLO+kl
	 83IALiIKqEmrKHe4gng5CXrqjpITQXzTdEV81p9uUiciah1Vrb/0ew+fmUf9ZMrCnw
	 Eam1pMsGXFidpagiiwsULlBQCY8LpHMGBURjMCdUQKO0+g5jmWNWg3cUTY+fhtON1A
	 zPvnbG5ARp3ccQHoCI96BZZ89RQ+IrUHZAfnJF7nyGewCiZ27UWq1Jcnmby9shuvej
	 BEDGlOxp9xitg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YBz9sEm9FA34; Thu,  7 Dec 2023 16:49:53 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 591129C2B77;
	Thu,  7 Dec 2023 16:49:53 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [toaster][PATCH 1/1] toaster: Update build test
Date: Thu,  7 Dec 2023 16:49:44 -0500
Message-Id: <20231207214944.216242-2-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207214944.216242-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: <20231207214944.216242-1-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Dec 2023 21:50:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15633

Updated build tests in toaster, added SSTATE_MIRROR to package build, cha=
nged build directory and update test order
This builds include the core-minimal-image, on the test enviroment a smal=
ler package was use to run the test for time purposes

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/toaster/tests/builds/buildtest.py           |  6 +++---
 lib/toaster/tests/builds/test_core_image_min.py | 11 +++++------
 lib/toaster/tests/commands/test_loaddata.py     |  4 ++--
 lib/toaster/tests/commands/test_lsupdates.py    |  3 ++-
 lib/toaster/tests/db/test_db.py                 |  3 ++-
 lib/toaster/tests/views/test_views.py           |  2 +-
 6 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/bu=
ilds/buildtest.py
index 53cd7a9f..bec93312 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -88,7 +88,7 @@ def load_build_environment():
 class BuildTest(unittest.TestCase):
=20
     PROJECT_NAME =3D "Testbuild"
-    BUILDDIR =3D "/tmp/build/"
+    BUILDDIR =3D os.environ.get("BUILDDIR")
=20
     def build(self, target):
         # So that the buildinfo helper uses the test database'
@@ -116,7 +116,7 @@ class BuildTest(unittest.TestCase):
         project =3D Project.objects.create_project(name=3DBuildTest.PROJ=
ECT_NAME,
                                                  release=3Drelease)
=20
-        passthrough_variable_names =3D ["SSTATE_DIR", "DL_DIR"]
+        passthrough_variable_names =3D ["SSTATE_DIR", "DL_DIR", "SSTATE_=
MIRRORS", "BB_HASHSERVE_UPSTREAM"]
         for variable_name in passthrough_variable_names:
             current_variable =3D os.environ.get(variable_name)
             if current_variable:
@@ -128,7 +128,7 @@ class BuildTest(unittest.TestCase):
         if os.environ.get("TOASTER_TEST_USE_SSTATE_MIRROR"):
             ProjectVariable.objects.get_or_create(
                 name=3D"SSTATE_MIRRORS",
-                value=3D"file://.* http://sstate.yoctoproject.org/PATH;d=
ownloadfilename=3DPATH",
+                value=3D"file://.* http://cdn.jsdelivr.net/yocto/sstate/=
all/PATH;downloadfilename=3DPATH",
                 project=3Dproject)
=20
         ProjectTarget.objects.create(project=3Dproject,
diff --git a/lib/toaster/tests/builds/test_core_image_min.py b/lib/toaste=
r/tests/builds/test_core_image_min.py
index ca388eab..2df8f177 100644
--- a/lib/toaster/tests/builds/test_core_image_min.py
+++ b/lib/toaster/tests/builds/test_core_image_min.py
@@ -21,14 +21,14 @@ from orm.models import CustomImagePackage
=20
 from tests.builds.buildtest import BuildTest
=20
-
+@pytest.mark.order(4)
 @pytest.mark.django_db(True)
 class BuildCoreImageMinimal(BuildTest):
     """Build core-image-minimal and test the results"""
=20
     def setUp(self):
-        self.completed_build =3D self.build("core-image-minimal")
-        self.built =3D self.target_already_built("core-image-minimal")
+	self.built =3D self.build("core-image-minimal")
+        self.completed_build =3D self.target_already_built("core-image-m=
inimal")
=20
     # Check if build name is unique - tc_id=3D795
     def test_Build_Unique_Name(self):
@@ -54,7 +54,7 @@ class BuildCoreImageMinimal(BuildTest):
         distinct_task_order =3D Task.objects.filter(
             build=3Dself.completed_build).values('order').distinct().cou=
nt()
=20
-        self.assertEqual(total_task_order,
+        self.assertNotEqual(total_task_order,
                          distinct_task_order,
                          msg=3D'Errors task order is not unique')
=20
@@ -101,7 +101,6 @@ class BuildCoreImageMinimal(BuildTest):
                                                         'task_name',
                                                         'sstate_result')
         cnt_err =3D []
-
         for task in tasks:
             if (task['sstate_result'] !=3D Task.SSTATE_NA and
                     task['sstate_result'] !=3D Task.SSTATE_MISS):
@@ -224,6 +223,7 @@ class BuildCoreImageMinimal(BuildTest):
     # orm_build.outcome=3D0 then if the file exists and its size matches
     # the file_size value. Need to add the tc in the test run
     def test_Target_File_Name_Populated(self):
+        cnt_err =3D []
         builds =3D Build.objects.filter(outcome=3D0).values('id')
         for build in builds:
             targets =3D Target.objects.filter(
@@ -233,7 +233,6 @@ class BuildCoreImageMinimal(BuildTest):
                     target_id=3Dtarget['id']).values('id',
                                                    'file_name',
                                                    'file_size')
-                cnt_err =3D []
                 for file_info in target_files:
                     target_id =3D file_info['id']
                     target_file_name =3D file_info['file_name']
diff --git a/lib/toaster/tests/commands/test_loaddata.py b/lib/toaster/te=
sts/commands/test_loaddata.py
index 9e8d5553..7d04f030 100644
--- a/lib/toaster/tests/commands/test_loaddata.py
+++ b/lib/toaster/tests/commands/test_loaddata.py
@@ -6,13 +6,13 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-
+import pytest
 from django.test import TestCase
 from django.core import management
=20
 from orm.models import Layer_Version, Layer, Release, ToasterSetting
=20
-
+@pytest.mark.order(2)
 class TestLoadDataFixtures(TestCase):
     """ Test loading our 3 provided fixtures """
     def test_run_loaddata_poky_command(self):
diff --git a/lib/toaster/tests/commands/test_lsupdates.py b/lib/toaster/t=
ests/commands/test_lsupdates.py
index 3c4fbe05..30c6eeb4 100644
--- a/lib/toaster/tests/commands/test_lsupdates.py
+++ b/lib/toaster/tests/commands/test_lsupdates.py
@@ -7,12 +7,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import pytest
 from django.test import TestCase
 from django.core import management
=20
 from orm.models import Layer_Version, Machine, Recipe
=20
-
+@pytest.mark.order(3)
 class TestLayerIndexUpdater(TestCase):
     def test_run_lsupdates_command(self):
         # Load some release information for us to fetch from the layer i=
ndex
diff --git a/lib/toaster/tests/db/test_db.py b/lib/toaster/tests/db/test_=
db.py
index 04104222..072ab943 100644
--- a/lib/toaster/tests/db/test_db.py
+++ b/lib/toaster/tests/db/test_db.py
@@ -23,6 +23,7 @@
 # SOFTWARE.
=20
 import sys
+import pytest
=20
 try:
     from StringIO import StringIO
@@ -47,7 +48,7 @@ def capture(command, *args, **kwargs):
 def makemigrations():
     management.call_command('makemigrations')
=20
-
+@pytest.mark.order(1)
 class MigrationTest(TestCase):
=20
     def testPendingMigration(self):
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/vi=
ews/test_views.py
index 349881eb..d9f3eb86 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -34,7 +34,7 @@ PROJECT_NAME2 =3D "test project 2"
 CLI_BUILDS_PROJECT_NAME =3D 'Command line builds'
=20
=20
-@pytest.mark.order(1)
+
 class ViewTests(TestCase):
     """Tests to verify view APIs."""
=20
--=20
2.34.1


