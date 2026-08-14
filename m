Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB9CC5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:13 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15592.1786721771881735523
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 08:36:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=c9WOacvR;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B50B23D818B5
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 11:36:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id e36tCeD_58ua; Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1CC153D8189E;
	Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1CC153D8189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786721768; bh=XOBMhM+S2ZKrr+mNE+gJGdSSS+j34S6CWB/WROb2uQA=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=c9WOacvRBKDLD3fxdW6kgJN3c0AbMnpCplRKOizi9DCwL2iVyXs9hgftXOGj+MH3d
	 pSRwg4UeRLo+WF20WMQZGSt8Bq6TwRP9bx9gnS//IEC2DW0BxtYPzHVsdgNIwYc6em
	 opOo+KUvq1loCFi+KZHNqZcwVJWLVSIXmZXQgnzMpSXkioG82tlUtOPC1HeNO7G4R1
	 HbWPVrhEJsu5YefIT+TWF763QtIO11l560oUcIOd0IMlxlRlRjlFm4jp+Bjw67KbPd
	 zHifYS715hEETC+qAPWOFNeiw1T7fNZcr+ZYWWezeqIb2kAPhPhpVEpN6jSBGIW90f
	 CMrf2SpaLbAJw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id OhoucXlKwotJ; Fri, 14 Aug 2026 11:36:07 -0400 (EDT)
Received: from pwattebled.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E3F663D818BB;
	Fri, 14 Aug 2026 11:36:07 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Subject: [PATCH v2 3/5] toaster: Store recipe variable snapshots
Date: Fri, 14 Aug 2026 11:35:56 -0400
Message-ID: <20260814153602.2107764-4-paolo.wattebled@savoirfairelinux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
References: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 15:36:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19942

Persist compressed recipe variable snapshots from dependency graph data
and replace each build's snapshot set atomically.

Keep existing data when older dependency payloads omit the field, remove
stale rows on refresh and cover rollback behavior with database tests.

AI-Generated: Uses GitHub Copilot and OpenCode with GPT-5.6 Sol
Signed-off-by: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
---
 lib/bb/ui/buildinfohelper.py    |  21 ++++++-
 lib/toaster/tests/db/test_db.py | 101 ++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 4ee45d67a..679f016bd 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -8,8 +8,10 @@
=20
 import sys
 import bb
+import json
 import re
 import os
+import zlib
=20
 import django
 from django.utils import timezone
@@ -31,7 +33,7 @@ from orm.models import Target_Image_File, TargetKernelF=
ile, TargetSDKFile
 from orm.models import Variable, VariableHistory
 from orm.models import Package, Package_File, Target_Installed_Package, =
Target_File
 from orm.models import Task_Dependency, Package_Dependency
-from orm.models import Recipe_Dependency, Provides
+from orm.models import Recipe_Dependency, RecipeVariable, Provides
 from orm.models import Project, CustomImagePackage
 from orm.models import signal_runbuilds
=20
@@ -1459,6 +1461,23 @@ class BuildInfoHelper(object):
                         t.save()
             self.internal_state['recipes'][pn] =3D recipe
=20
+        if any('recipe_variables' in recipe_data
+               for recipe_data in event._depgraph['pn'].values()):
+            recipe_variables =3D []
+            for pn, recipe_data in event._depgraph['pn'].items():
+                variables =3D recipe_data.get('recipe_variables')
+                if variables is None:
+                    continue
+                recipe_variables.append(RecipeVariable(
+                    build=3Dself.internal_state['build'],
+                    recipe=3Dself.internal_state['recipes'][pn],
+                    variables=3Dvariables,
+                    variable_count=3Dlen(json.loads(zlib.decompress(vari=
ables)))))
+            with transaction.atomic():
+                RecipeVariable.objects.filter(
+                    build=3Dself.internal_state['build']).delete()
+                RecipeVariable.objects.bulk_create(recipe_variables)
+
         # we'll not get recipes for key w/ values listed in ASSUME_PROVI=
DED
=20
         assume_provided =3D self.server.runCommand(["getVariable", "ASSU=
ME_PROVIDED"])[0].split()
diff --git a/lib/toaster/tests/db/test_db.py b/lib/toaster/tests/db/test_=
db.py
index 072ab9436..7c48b1de3 100644
--- a/lib/toaster/tests/db/test_db.py
+++ b/lib/toaster/tests/db/test_db.py
@@ -24,6 +24,10 @@
=20
 import sys
 import pytest
+from types import SimpleNamespace
+from unittest.mock import Mock, patch
+import json
+import zlib
=20
 try:
     from StringIO import StringIO
@@ -34,6 +38,11 @@ from contextlib import contextmanager
=20
 from django.core import management
 from django.test import TestCase
+from django.utils import timezone
+
+from bb.ui.buildinfohelper import BuildInfoHelper, ORMWrapper
+from orm.models import Build, Layer, Layer_Version, Project, Recipe
+from orm.models import RecipeVariable
=20
=20
 @contextmanager
@@ -56,3 +65,95 @@ class MigrationTest(TestCase):
=20
         with capture(makemigrations) as output:
             self.assertEqual(output, "No changes detected\n")
+
+
+class RecipeVariableTest(TestCase):
+
+    def setUp(self):
+        now =3D timezone.now()
+        project =3D Project.objects.get_or_create_default_project()
+        self.build =3D Build.objects.create(
+            project=3Dproject, machine=3D'', distro=3D'', distro_version=
=3D'',
+            started_on=3Dnow, completed_on=3Dnow, cooker_log_path=3D'',
+            bitbake_version=3D'', progress_item=3D'')
+        layer =3D Layer.objects.create(name=3D'test', layer_index_url=3D=
'')
+        self.layer_version =3D Layer_Version.objects.create(
+            build=3Dself.build, layer=3Dlayer, branch=3D'', commit=3D'',
+            local_path=3D'/layer')
+
+    def _store(self, recipe_data):
+        if 'recipe_variables' in recipe_data:
+            recipe_data =3D dict(recipe_data)
+            recipe_data['recipe_variables'] =3D zlib.compress(json.dumps=
(
+                recipe_data['recipe_variables'], separators=3D(',', ':')
+            ).encode('utf-8'))
+        helper =3D BuildInfoHelper.__new__(BuildInfoHelper)
+        helper.internal_state =3D {'build': self.build, 'targets': []}
+        helper.orm_wrapper =3D ORMWrapper()
+        helper.server =3D Mock()
+        helper.server.runCommand.return_value =3D ['', None]
+        helper._get_layer_version_for_path =3D Mock(return_value=3Dself.=
layer_version)
+        event =3D SimpleNamespace(_depgraph=3D{
+            'layer-priorities': [],
+            'pn': {'test': dict({'filename': '/layer/test.bb'}, **recipe=
_data)},
+            'depends': {'test': []},
+            'tdepends': {},
+        })
+
+        helper.store_dependency_information(event)
+
+        return helper.internal_state['recipes']['test']
+
+    def test_dependency_information_stores_recipe_variables(self):
+        recipe =3D self._store({'recipe_variables': {'EMPTY': '', 'FOO':=
 'bar'}})
+
+        snapshot =3D RecipeVariable.objects.get(build=3Dself.build, reci=
pe=3Drecipe)
+        self.assertEqual(
+            json.loads(zlib.decompress(snapshot.variables)),
+            {'EMPTY': '', 'FOO': 'bar'})
+        self.assertEqual(snapshot.variable_count, 2)
+
+    def test_old_payload_does_not_delete_recipe_variables(self):
+        recipe =3D self._store({'recipe_variables': {'FOO': 'bar'}})
+        self._store({})
+
+        snapshot =3D RecipeVariable.objects.get(build=3Dself.build, reci=
pe=3Drecipe)
+        self.assertEqual(
+            json.loads(zlib.decompress(snapshot.variables)), {'FOO': 'ba=
r'})
+
+    def test_dependency_information_replaces_recipe_variables(self):
+        recipe =3D self._store({'recipe_variables': {'FOO': 'old'}})
+        self._store({'recipe_variables': {'BAR': 'new'}})
+
+        snapshot =3D RecipeVariable.objects.get(build=3Dself.build, reci=
pe=3Drecipe)
+        self.assertEqual(
+            json.loads(zlib.decompress(snapshot.variables)), {'BAR': 'ne=
w'})
+        self.assertEqual(snapshot.variable_count, 1)
+
+    def test_dependency_information_removes_stale_recipe_snapshot(self):
+        stale_recipe =3D Recipe.objects.create(
+            name=3D'stale', version=3D'', layer_version=3Dself.layer_ver=
sion,
+            file_path=3D'stale.bb')
+        RecipeVariable.objects.create(
+            build=3Dself.build, recipe=3Dstale_recipe,
+            variables=3Dzlib.compress(b'{"STALE":"value"}'))
+
+        current_recipe =3D self._store({'recipe_variables': {'FOO': 'bar=
'}})
+
+        self.assertFalse(RecipeVariable.objects.filter(
+            build=3Dself.build, recipe=3Dstale_recipe).exists())
+        self.assertTrue(RecipeVariable.objects.filter(
+            build=3Dself.build, recipe=3Dcurrent_recipe).exists())
+
+    def test_dependency_information_rolls_back_failed_bulk_create(self):
+        recipe =3D self._store({'recipe_variables': {'FOO': 'old'}})
+        with patch.object(RecipeVariable.objects, 'bulk_create',
+                          side_effect=3DRuntimeError('injected failure')=
):
+            with self.assertRaisesRegex(RuntimeError, 'injected failure'=
):
+                self._store({'recipe_variables': {'FOO': 'new'}})
+
+        snapshots =3D RecipeVariable.objects.filter(build=3Dself.build)
+        self.assertEqual(snapshots.count(), 1)
+        snapshot =3D snapshots.get(recipe=3Drecipe)
+        self.assertEqual(
+            json.loads(zlib.decompress(snapshot.variables)), {'FOO': 'ol=
d'})
--=20
2.55.0


