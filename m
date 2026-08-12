Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B341CC5B56A
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 15:05:07 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10284.1786547101723764644
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2026 08:05:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=WHO9dxMM;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C63783D81738
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 11:05:00 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5n5JEomIhqnV; Wed, 12 Aug 2026 11:04:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C5D8B3D81867;
	Wed, 12 Aug 2026 11:04:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C5D8B3D81867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786547093; bh=sLv0TZlwj91YwK0A0quFiFtE7LvdxRrWLNfr79qKEfs=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=WHO9dxMMZylFNXh59mHMuFmMSWl4QRv3tjrN0p5T8A+I0a6CuAz12FEWiA35IPAgC
	 J1cL1SGKKCQBFE0h8hwoPtgHvJ/E5Fve9fIx6g0oUffpdb+9Bq/KgLPGjUKwTIFdyE
	 FNhY0wkTBY/CbNJOtxBl1pDdEfYyAt0HTrpt5pgBdwkLSEJXgpY11DYD0rMJFEq3v2
	 mErkf3u00WtqaTv2+UHGwTPTDH4MUzEYSamX+GlG2Xqq1tgHT+q2Snf0g5hZJiYASb
	 mmqj/RBoVrprfqLYFGCtU9GdhZLLLexpvfNqnCUBIFkcy7vBLU+HoZ+7G/GZ+YqD9p
	 gwO4tGLKmUMzA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fE-wznzsCo-R; Wed, 12 Aug 2026 11:04:53 -0400 (EDT)
Received: from pwattebled.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9A9A03D8185E;
	Wed, 12 Aug 2026 11:04:53 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Subject: [PATCH] toaster: Add recipe variables view
Date: Wed, 12 Aug 2026 11:04:47 -0400
Message-ID: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 15:05:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19915

Toaster records global build variables but does not expose the final
values associated with individual recipes.

Collect variables defined or modified by recipes and their bbappends,
resolve active overrides and expansions, and store one compressed JSON
snapshot in the database for each build and recipe. Keep the variable
count separately to avoid decompressing snapshots in recipe-list
queries.

Expose the values through a searchable and paginated Variables tab and
show their counts in the built-recipes table and recipe package view.
Preserve compatibility with older dependency payloads and invalidate
stale BitBake caches after extending the cached recipe information.

Tests cover variable collection, cache transport, database persistence,
backward compatibility, searching, pagination, escaping, and counts.

AI-Generated: Uses GitHub Copilot and OpenCode with GPT-5.6 Sol
Signed-off-by: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
---
 bin/bitbake-selftest                          |   1 +
 lib/bb/cache.py                               |   2 +-
 lib/bb/cache_extra.py                         |  66 +++++++-
 lib/bb/cooker.py                              |   6 +-
 lib/bb/tests/cache_extra.py                   | 141 ++++++++++++++++
 lib/bb/ui/buildinfohelper.py                  |  21 ++-
 .../orm/migrations/0022_recipevariable.py     |  27 +++
 lib/toaster/orm/models.py                     |  10 ++
 lib/toaster/tests/db/test_db.py               | 101 ++++++++++++
 lib/toaster/tests/views/test_views.py         | 155 +++++++++++++++++-
 lib/toaster/toastergui/buildtables.py         |  11 +-
 .../templates/detail_pagination_bottom.html   |   4 +-
 .../templates/detail_search_header.html       |   2 +-
 lib/toaster/toastergui/templates/recipe.html  |  32 ++++
 .../toastergui/templates/recipe_packages.html |   7 +
 lib/toaster/toastergui/views.py               |  68 +++++++-
 16 files changed, 642 insertions(+), 12 deletions(-)
 create mode 100644 lib/bb/tests/cache_extra.py
 create mode 100644 lib/toaster/orm/migrations/0022_recipevariable.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index fb7c57dd8..1b09815cd 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -21,6 +21,7 @@ except RuntimeError as exc:
     sys.exit(str(exc))
=20
 tests =3D ["bb.tests.codeparser",
+         "bb.tests.cache_extra",
          "bb.tests.color",
          "bb.tests.cooker",
          "bb.tests.cow",
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 2361c5684..33fa61936 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -28,7 +28,7 @@ import shutil
=20
 logger =3D logging.getLogger("BitBake.Cache")
=20
-__cache_version__ =3D "156"
+__cache_version__ =3D "157"
=20
 def getCacheFile(path, filename, mc, data_hash):
     mcspec =3D ''
diff --git a/lib/bb/cache_extra.py b/lib/bb/cache_extra.py
index bf4226d16..95a13c402 100644
--- a/lib/bb/cache_extra.py
+++ b/lib/bb/cache_extra.py
@@ -13,7 +13,47 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import logging
+import json
+import zlib
+
 from bb.cache import RecipeInfoCommon
+logger =3D logging.getLogger("BitBake.CacheExtra")
+
+
+def _winning_override(metadata, variable_name):
+    active =3D {}
+    metadata.need_overrides()
+    for override_variable, override in metadata.overridedata.get(variabl=
e_name, ()):
+        if (override in metadata.overridesset or
+                ':' in override and
+                set(override.split(':')).issubset(metadata.overridesset)=
):
+            active[override] =3D override_variable
+
+    match =3D None
+    modified =3D True
+    while modified:
+        modified =3D False
+        for override in metadata.overrides:
+            for candidate in active.copy():
+                if candidate.endswith(':' + override):
+                    active[candidate.removesuffix(':' + override)] =3D a=
ctive.pop(candidate)
+                    modified =3D True
+                elif candidate =3D=3D override:
+                    match =3D active.pop(candidate)
+    return match
+
+
+def _recipe_value_event(metadata, event):
+    if not event.get('file', '').endswith(('.bb', '.bbappend')):
+        return False
+    if event.get('flag') not in (None, '_defaultval'):
+        return False
+    operation =3D event.get('op', '')
+    if '[' not in operation:
+        return True
+    override =3D operation.rsplit('[', 1)[1].removesuffix(']')
+    return set(override.split(':')).issubset(metadata.overridesset)
=20
 class HobRecipeInfo(RecipeInfoCommon):
     __slots__ =3D ()
@@ -27,7 +67,7 @@ class HobRecipeInfo(RecipeInfoCommon):
     # that this class will provide
     cachefields =3D ['summary', 'license', 'section',
             'description', 'homepage', 'bugtracker',
-            'prevision', 'files_info']
+            'prevision', 'files_info', 'recipe_variables']
=20
     def __init__(self, filename, metadata):
=20
@@ -39,6 +79,28 @@ class HobRecipeInfo(RecipeInfoCommon):
         self.bugtracker =3D self.getvar('BUGTRACKER', metadata)
         self.prevision =3D self.getvar('PR', metadata)
         self.files_info =3D self.getvar('FILES_INFO', metadata)
+        recipe_variables =3D {}
+        for variable_name in metadata:
+            try:
+                if ':' in variable_name:
+                    continue
+                history =3D metadata.varhistory.variable(variable_name)
+                winning_override =3D _winning_override(metadata, variabl=
e_name)
+                if winning_override:
+                    history +=3D metadata.varhistory.variable(winning_ov=
erride)
+                if not any(_recipe_value_event(metadata, event) for even=
t in history):
+                    continue
+                if (metadata.getVarFlag(variable_name, 'func', False) or
+                        winning_override and
+                        metadata.getVarFlag(winning_override, 'func', Fa=
lse)):
+                    continue
+                value =3D metadata.getVar(variable_name, True)
+                recipe_variables[variable_name] =3D '' if value is None =
else str(value)
+            except Exception as exc:
+                logger.debug("Omitting recipe variable %s from %s after =
%s",
+                             variable_name, filename, type(exc).__name__=
)
+        self.recipe_variables =3D zlib.compress(
+            json.dumps(recipe_variables, separators=3D(',', ':')).encode=
('utf-8'))
=20
     @classmethod
     def init_cacheData(cls, cachedata):
@@ -51,6 +113,7 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.bugtracker =3D {}
         cachedata.prevision =3D {}
         cachedata.files_info =3D {}
+        cachedata.recipe_variables =3D {}
=20
     def add_cacheData(self, cachedata, fn):
         cachedata.summary[fn] =3D self.summary
@@ -61,3 +124,4 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.bugtracker[fn] =3D self.bugtracker
         cachedata.prevision[fn] =3D self.prevision
         cachedata.files_info[fn] =3D self.files_info
+        cachedata.recipe_variables[fn] =3D self.recipe_variables
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4b6ba3196..fe80af22d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -270,7 +270,8 @@ class BBCooker:
         if hasattr(self, "data"):
             consolelog =3D self.data.getVar("BB_CONSOLELOG")
=20
-        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
+        if (CookerFeatures.BASEDATASTORE_TRACKING in self.featureset or
+                CookerFeatures.HOB_EXTRA_CACHES in self.featureset):
             self.enableDataTracking()
=20
         caches_name_array =3D ['bb.cache:CoreRecipeInfo']
@@ -310,7 +311,8 @@ class BBCooker:
=20
         self.data.setVar('BB_CMDLINE', self.ui_cmdline)
=20
-        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
+        if (CookerFeatures.BASEDATASTORE_TRACKING in self.featureset and
+                CookerFeatures.HOB_EXTRA_CACHES not in self.featureset):
             self.disableDataTracking()
=20
         for mc in self.databuilder.mcdata.values():
diff --git a/lib/bb/tests/cache_extra.py b/lib/bb/tests/cache_extra.py
new file mode 100644
index 000000000..12a82f56a
--- /dev/null
+++ b/lib/bb/tests/cache_extra.py
@@ -0,0 +1,141 @@
+#
+# BitBake Tests for extra cache data
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import unittest
+import json
+import zlib
+
+import bb.data
+import bb.parse
+from bb.cache_extra import HobRecipeInfo
+
+
+class HobRecipeInfoTest(unittest.TestCase):
+
+    @staticmethod
+    def metadata():
+        metadata =3D bb.data.init()
+        metadata.enableTracking()
+        return metadata
+
+    def test_recipe_variables(self):
+        metadata =3D self.metadata()
+        metadata.setVar('TEXT', '${VALUE}', file=3D'test.bb', line=3D1)
+        metadata.setVar('VALUE', 'expanded', file=3D'test.bb', line=3D2)
+        metadata.setVar('EMPTY', '', file=3D'test.bb', line=3D3)
+        metadata.setVar('NUMBER', 7, file=3D'test.bbappend', line=3D1)
+        metadata.setVar('SPECIAL', 'caf=C3=A9\nline\x00end',
+                        file=3D'test.bb', line=3D4)
+        metadata.setVar('INHERITED', 'global', file=3D'conf/bitbake.conf=
', line=3D1)
+        metadata.setVar('do_function', 'echo test', file=3D'test.bb', li=
ne=3D5)
+        metadata.setVarFlag('do_function', 'func', True)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertEqual(variables['TEXT'], 'expanded')
+        self.assertEqual(variables['EMPTY'], '')
+        self.assertEqual(variables['NUMBER'], '7')
+        self.assertEqual(variables['SPECIAL'], 'caf=C3=A9\nline\x00end')
+        self.assertNotIn('INHERITED', variables)
+        self.assertNotIn('do_function', variables)
+
+    def test_recipe_variable_operations_are_included(self):
+        metadata =3D self.metadata()
+        metadata.setVar('TEXT', 'global', file=3D'conf/bitbake.conf', li=
ne=3D1)
+        metadata.setVar('TEXT:append', ' recipe', file=3D'test.bb', line=
=3D1)
+        metadata.setVar('TEXT:remove', 'global', file=3D'test.bbappend',=
 line=3D1)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertEqual(variables['TEXT'], ' recipe')
+
+    def test_only_effective_overrides_are_included(self):
+        metadata =3D self.metadata()
+        metadata.setVar('OVERRIDES', 'machine', file=3D'conf/bitbake.con=
f', line=3D1)
+        metadata.setVar('ACTIVE:machine', 'recipe', file=3D'test.bb', li=
ne=3D1)
+        metadata.setVar('INACTIVE:other', 'recipe', file=3D'test.bb', li=
ne=3D2)
+        metadata.setVar('GLOBAL', 'global', file=3D'conf/bitbake.conf', =
line=3D2)
+        metadata.setVar('GLOBAL:append:other', ' recipe', file=3D'test.b=
b', line=3D3)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertEqual(variables['ACTIVE'], 'recipe')
+        self.assertNotIn('ACTIVE:machine', variables)
+        self.assertNotIn('INACTIVE', variables)
+        self.assertNotIn('INACTIVE:other', variables)
+        self.assertNotIn('GLOBAL', variables)
+
+    def test_weak_default_is_included(self):
+        metadata =3D self.metadata()
+        metadata.setVarFlag('PACKAGECONFIG', '_defaultval', 'feature',
+                            file=3D'test.bb', line=3D1)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertEqual(variables['PACKAGECONFIG'], 'feature')
+
+    def test_combined_override_is_included_under_logical_name(self):
+        metadata =3D self.metadata()
+        metadata.setVar('OVERRIDES', 'foo:bar:local',
+                        file=3D'conf/bitbake.conf', line=3D1)
+        metadata.setVar('COMBINED:local:foo:bar', 'recipe',
+                        file=3D'test.bb', line=3D1)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertEqual(variables, {'COMBINED': 'recipe'})
+
+    def test_active_override_function_is_omitted(self):
+        metadata =3D self.metadata()
+        metadata.setVar('OVERRIDES', 'machine', file=3D'conf/bitbake.con=
f', line=3D1)
+        metadata.setVar('do_work:machine', 'echo test', file=3D'test.bb'=
, line=3D1)
+        metadata.setVarFlag('do_work:machine', 'func', True,
+                            file=3D'test.bb', line=3D1)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertNotIn('do_work', variables)
+
+    def test_recipe_variables_survive_extra_cache_mapping(self):
+        metadata =3D self.metadata()
+        metadata.setVar('EMPTY', '', file=3D'test.bb', line=3D1)
+        info =3D HobRecipeInfo('test.bb', metadata)
+        cachedata =3D type('CacheData', (), {})()
+
+        HobRecipeInfo.init_cacheData(cachedata)
+        info.add_cacheData(cachedata, 'test.bb')
+
+        self.assertIn('recipe_variables', HobRecipeInfo.cachefields)
+        variables =3D json.loads(zlib.decompress(
+            cachedata.recipe_variables['test.bb']))
+        self.assertEqual(variables['EMPTY'], '')
+
+    def test_recipe_variables_are_compressed_before_caching(self):
+        metadata =3D self.metadata()
+        metadata.setVar('LARGE', 'repeated-value-' * 1000,
+                        file=3D'test.bb', line=3D1)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+
+        self.assertLess(len(info.recipe_variables), len(metadata.getVar(=
'LARGE')))
+
+    def test_unexpandable_variable_is_omitted(self):
+        metadata =3D self.metadata()
+        metadata.setVar('BROKEN', '${BROKEN}', file=3D'test.bb', line=3D=
1)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+        self.assertNotIn('BROKEN', variables)
+
+if __name__ =3D=3D '__main__':
+    unittest.main()
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
diff --git a/lib/toaster/orm/migrations/0022_recipevariable.py b/lib/toas=
ter/orm/migrations/0022_recipevariable.py
new file mode 100644
index 000000000..455a8ce23
--- /dev/null
+++ b/lib/toaster/orm/migrations/0022_recipevariable.py
@@ -0,0 +1,27 @@
+# Generated by Django 4.2.5 on 2026-08-11 00:00
+
+from django.db import migrations, models
+import django.db.models.deletion
+
+
+class Migration(migrations.Migration):
+
+    dependencies =3D [
+        ('orm', '0021_eventlogsimports'),
+    ]
+
+    operations =3D [
+        migrations.CreateModel(
+            name=3D'RecipeVariable',
+            fields=3D[
+                ('id', models.BigAutoField(auto_created=3DTrue, primary_=
key=3DTrue, serialize=3DFalse, verbose_name=3D'ID')),
+                ('variables', models.BinaryField()),
+                ('variable_count', models.PositiveIntegerField(default=3D=
0)),
+                ('build', models.ForeignKey(on_delete=3Ddjango.db.models=
.deletion.CASCADE, to=3D'orm.build')),
+                ('recipe', models.ForeignKey(on_delete=3Ddjango.db.model=
s.deletion.CASCADE, to=3D'orm.recipe')),
+            ],
+            options=3D{
+                'unique_together': {('build', 'recipe')},
+            },
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index e2f488ed8..c240836cc 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1346,6 +1346,16 @@ class Recipe(models.Model):
         unique_together =3D (("layer_version", "file_path", "pathflags")=
, )
=20
=20
+class RecipeVariable(models.Model):
+    build =3D models.ForeignKey(Build, on_delete=3Dmodels.CASCADE)
+    recipe =3D models.ForeignKey(Recipe, on_delete=3Dmodels.CASCADE)
+    variables =3D models.BinaryField()
+    variable_count =3D models.PositiveIntegerField(default=3D0)
+
+    class Meta:
+        unique_together =3D (("build", "recipe"), )
+
+
 class Recipe_DependencyManager(models.Manager):
     use_for_related_fields =3D True
=20
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
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/vi=
ews/test_views.py
index e1adfcf86..78695a151 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -10,14 +10,16 @@
 """Test cases for Toaster GUI and ReST."""
=20
 import os
+import zlib
 import pytest
 from django.test import TestCase
 from django.test.client import RequestFactory
 from django.urls import reverse
 from django.db.models import Q
=20
-from orm.models import Project, Package
+from orm.models import Build, Project, Package
 from orm.models import Layer_Version, Recipe
+from orm.models import RecipeVariable
 from orm.models import CustomImageRecipe
 from orm.models import CustomImagePackage
=20
@@ -61,6 +63,14 @@ class ViewTests(TestCase):
         if BuildEnvironment.objects.count() =3D=3D 0:
             BuildEnvironment.objects.create(betype=3DBuildEnvironment.TY=
PE_LOCAL)
=20
+    @staticmethod
+    def _recipe_variables(build, recipe, values):
+        return RecipeVariable(
+            build=3Dbuild, recipe=3Drecipe,
+            variable_count=3Dlen(values),
+            variables=3Dzlib.compress(json.dumps(
+                values, separators=3D(',', ':')).encode('utf-8')))
+
=20
     def test_get_base_call_returns_html(self):
         """Basic test for all-projects view"""
@@ -90,6 +100,149 @@ class ViewTests(TestCase):
         self.assertTrue(name_found,
                         "project name not found in projects table")
=20
+    def test_recipe_variables_tab_scopes_searches_and_escapes(self):
+        build =3D Build.objects.get(pk=3D1)
+        other_build =3D Build.objects.get(pk=3D2)
+        other_recipe =3D Recipe.objects.exclude(pk=3Dself.recipe1.pk).fi=
rst()
+        RecipeVariable.objects.bulk_create([
+            self._recipe_variables(build, self.recipe1, {
+                'SRC_URI': 'git://example.invalid/src',
+                'SPECIAL': '<script>alert(1)</script>',
+            }),
+            self._recipe_variables(other_build, self.recipe1, {
+                'OTHER_BUILD': 'hidden',
+            }),
+            self._recipe_variables(build, other_recipe, {
+                'OTHER_RECIPE': 'hidden',
+            }),
+        ])
+        url =3D reverse('recipe', args=3D(build.pk, self.recipe1.pk, '5'=
))
+
+        response =3D self.client.get(url, {
+            'count': 100,
+            'page': 1,
+            'orderby': 'variable_name:+',
+            'search': 'SRC_URI',
+        })
+
+        self.assertEqual(response.status_code, 200)
+        self.assertTemplateUsed(response, 'recipe.html')
+        self.assertContains(response, 'SRC_URI')
+        self.assertContains(response, 'git://example.invalid/src')
+        self.assertNotContains(response, 'OTHER_BUILD')
+        self.assertNotContains(response, 'OTHER_RECIPE')
+
+        response =3D self.client.get(url, {
+            'count': 100,
+            'page': 1,
+            'orderby': 'variable_name:+',
+        })
+        self.assertContains(response, 'Variables (2)')
+        self.assertContains(response, '&lt;script&gt;alert(1)&lt;/script=
&gt;')
+        self.assertNotContains(response, '<script>alert(1)</script>')
+
+    def test_recipe_variables_tab_redirects_paginates_and_handles_empty(=
self):
+        build =3D Build.objects.get(pk=3D1)
+        url =3D reverse('recipe', args=3D(build.pk, self.recipe1.pk, '5'=
))
+
+        response =3D self.client.get(url)
+        self.assertEqual(response.status_code, 302)
+        self.assertIn('count=3D100', response.url)
+        self.assertIn('orderby=3Dvariable_name%3A%2B', response.url)
+
+        RecipeVariable.objects.bulk_create([
+            self._recipe_variables(build, self.recipe1, {
+                'VAR_%02d' % index: str(index) for index in range(12)
+            })
+        ])
+        response =3D self.client.get(url, {
+            'count': 10,
+            'page': 2,
+            'orderby': 'variable_name:+',
+        })
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual(response.context['objects'].paginator.count, 12=
)
+        self.assertEqual(response.context['objects'].number, 2)
+        self.assertContains(response, 'VAR_10')
+        self.assertContains(response, 'VAR_11')
+        self.assertNotContains(response, 'VAR_00')
+
+        RecipeVariable.objects.filter(build=3Dbuild, recipe=3Dself.recip=
e1).delete()
+        response =3D self.client.get(url, {
+            'count': 100,
+            'page': 1,
+            'orderby': 'variable_name:+',
+        })
+        self.assertContains(response, 'defines or modifies no variables'=
)
+
+    def test_recipe_variables_tab_bounds_query_parameters(self):
+        build =3D Build.objects.get(pk=3D1)
+        RecipeVariable.objects.bulk_create([
+            self._recipe_variables(build, self.recipe1, {'SRC_URI': 'val=
ue'})
+        ])
+        url =3D reverse('recipe', args=3D(build.pk, self.recipe1.pk, '5'=
))
+
+        response =3D self.client.get(url, {
+            'count': 'alert(document.domain)',
+            'page': 1,
+            'orderby': 'variable_value:+',
+            'filter': 'variable_value__regex:(a+)+$',
+        })
+
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual(response.context['objects'].paginator.per_page,=
 100)
+        self.assertNotContains(response, 'alert(document.domain)')
+        self.assertEqual(
+            [variable['variable_name']
+             for variable in response.context['objects'].object_list],
+            ['SRC_URI'])
+
+        response =3D self.client.get(url, {
+            'count': 100,
+            'page': 1,
+            'orderby': 'variable_name:+',
+            'search': ('SRC_URI ' * 20) + ('x' * 300),
+        })
+        self.assertLessEqual(len(response.context['search_term']), 256)
+        self.assertLessEqual(len(response.context['search_term'].split()=
), 16)
+
+    def test_built_recipes_table_shows_variable_count(self):
+        build =3D Build.objects.get(pk=3D1)
+        self._recipe_variables(build, self.recipe1, {
+            'FOO': 'one',
+            'BAR': 'two',
+        }).save()
+        url =3D reverse('recipes', args=3D(build.pk,))
+
+        response =3D self.client.get(url, {
+            'format': 'json',
+            'limit': 25,
+            'page': 1,
+        })
+        data =3D json.loads(response.content)
+        row =3D next(row for row in data['rows']
+                   if self.recipe1.name in row['name'])
+
+        self.assertIn('Variables', [column['title'] for column in data['=
columns']])
+        self.assertIn('>2</a>', row['variable_count'])
+
+    def test_recipe_packages_tab_shows_variable_count(self):
+        build =3D Build.objects.get(pk=3D1)
+        self._recipe_variables(build, self.recipe1, {
+            'FOO': 'one',
+            'BAR': 'two',
+        }).save()
+
+        response =3D self.client.get(reverse(
+            'recipe_packages', args=3D(build.pk, self.recipe1.pk)), {
+                'count': 10,
+                'page': 1,
+                'orderby': 'name:+',
+            })
+
+        self.assertEqual(response.status_code, 200)
+        self.assertContains(response, 'Variables (2)')
+
     def test_typeaheads(self):
         """Test typeahead ReST API"""
         layers_url =3D reverse('xhr_layerstypeahead', args=3D(self.proje=
ct.id,))
diff --git a/lib/toaster/toastergui/buildtables.py b/lib/toaster/toasterg=
ui/buildtables.py
index 327059d00..52c3dd779 100644
--- a/lib/toaster/toastergui/buildtables.py
+++ b/lib/toaster/toastergui/buildtables.py
@@ -239,7 +239,10 @@ class BuiltRecipesTable(BuildTablesMixin):
     def setup_queryset(self, *args, **kwargs):
         build =3D Build.objects.get(pk=3Dkwargs['build_id'])
         self.static_context_extra['build'] =3D build
-        self.queryset =3D build.get_recipes()
+        self.queryset =3D build.get_recipes().annotate(
+            variable_count=3DSum(
+                'recipevariable__variable_count',
+                filter=3DQ(recipevariable__build=3Dbuild), default=3D0))
         self.queryset =3D self.queryset.order_by(self.default_orderby)
=20
     def setup_columns(self, *args, **kwargs):
@@ -323,6 +326,12 @@ class BuiltRecipesTable(BuildTablesMixin):
                         hideable=3DFalse,
                         field_name=3D"version")
=20
+        self.add_column(
+            title=3D"Variables",
+            field_name=3D"variable_count",
+            static_data_name=3D"variable_count",
+            static_data_template=3D'<a href=3D"{% url "recipe" extra.bui=
ld.pk data.pk "5" %}">{{data.variable_count|default:0}}</a>')
+
         self.add_column(title=3D"Dependencies",
                         static_data_name=3D"dependencies",
                         static_data_template=3Ddepends_on_tmpl)
diff --git a/lib/toaster/toastergui/templates/detail_pagination_bottom.ht=
ml b/lib/toaster/toastergui/templates/detail_pagination_bottom.html
index 15adfbc91..ddcba133e 100644
--- a/lib/toaster/toastergui/templates/detail_pagination_bottom.html
+++ b/lib/toaster/toastergui/templates/detail_pagination_bottom.html
@@ -41,8 +41,8 @@
 <script>
  $(document).ready(function() {
     // load data for number of entries to be displayed on page
-    if ({{request.GET.count}} !=3D "") {
-      pagesize =3D {{request.GET.count}};
+    if ({{validated_pagesize|default:request.GET.count}} !=3D "") {
+      pagesize =3D {{validated_pagesize|default:request.GET.count}};
     }
     $('.pagesize option').prop('selected', false)
                          .filter('[value=3D"' + pagesize + '"]')
diff --git a/lib/toaster/toastergui/templates/detail_search_header.html b=
/lib/toaster/toastergui/templates/detail_search_header.html
index 7a9865908..0205b88f6 100644
--- a/lib/toaster/toastergui/templates/detail_search_header.html
+++ b/lib/toaster/toastergui/templates/detail_search_header.html
@@ -31,7 +31,7 @@ $(document).ready(function() {
         <div class=3D"form-group">
           <div class=3D"btn-group">
             <input id=3D"search" class=3D"form-control" type=3D"text" pl=
aceholder=3D"Search {{search_what}}" name=3D"search" value=3D"{% if reque=
st.GET.search %}{{request.GET.search}}{% endif %}">
-            <input type=3D"hidden" value=3D"name:+" name=3D"orderby">
+            <input type=3D"hidden" value=3D"{{search_orderby|default:'na=
me:+'}}" name=3D"orderby">
             <input type=3D"hidden" value=3D"l" name=3D"page">
             {% if request.GET.search %}
             <span class=3D"remove-search-btn-detail-search search-clear =
glyphicon glyphicon-remove-circle"></span>
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/t=
oastergui/templates/recipe.html
index 4b5301b54..be40b58d4 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -52,6 +52,13 @@
                 Reverse build dependencies ({{object.r_dependencies_depe=
nds.all.count}})
             </a>
         </li>
+        <li class=3D"{{tab_states.5}}">
+            <a href=3D"{% url "recipe" build.pk object.id "5" %}">
+                <span class=3D"glyphicon glyphicon-question-sign get-hel=
p" title=3D"Final values
+                    defined or modified by this recipe and its bbappends=
"></span>
+                Variables ({{recipe_variable_count}})
+            </a>
+        </li>
     </ul>
     <div class=3D"tab-content">
         <div class=3D"tab-pane {{tab_states.1}}" id=3D"information">
@@ -277,6 +284,31 @@
             {% endif %}
=20
         </div>
+        <div class=3D"tab-pane {{tab_states.5}}" id=3D"variables">
+            {% if not objects and not request.GET.search %}
+            <div class=3D"alert alert-info">
+                <strong>{{object.name}}_{{object.version}}</strong> defi=
nes or modifies no variables.
+            </div>
+            {% else %}
+                {% with "variables" as search_what %}
+                {% include "detail_search_header.html" %}
+                {% endwith %}
+                {% if objects %}
+                <table class=3D"table table-bordered table-hover tableso=
rter" id=3D"otable">
+                    {% include "detail_sorted_header.html" %}
+                    <tbody>
+                    {% for variable in objects %}
+                        <tr>
+                            <td>{{variable.variable_name}}</td>
+                            <td>{{variable.variable_value}}</td>
+                        </tr>
+                    {% endfor %}
+                    </tbody>
+                </table>
+                {% include "detail_pagination_bottom.html" %}
+                {% endif %}
+            {% endif %}
+        </div>
     </div>
 </div>
=20
diff --git a/lib/toaster/toastergui/templates/recipe_packages.html b/lib/=
toaster/toastergui/templates/recipe_packages.html
index 37a586f38..c39ae6b5e 100644
--- a/lib/toaster/toastergui/templates/recipe_packages.html
+++ b/lib/toaster/toastergui/templates/recipe_packages.html
@@ -51,6 +51,13 @@
                 Reverse build dependencies ({{recipe.r_dependencies_depe=
nds.all.count}})
             </a>
         </li>
+        <li>
+            <a href=3D"{% url "recipe" build.pk recipe.id "5" %}">
+                <span class=3D"glyphicon glyphicon-question-sign get-hel=
p" title=3D"Final values
+                    defined or modified by this recipe and its bbappends=
"></span>
+                Variables ({{variable_count}})
+            </a>
+        </li>
     </ul>
     <div class=3D"tab-content">
 {#        <div class=3D"tab-pane active" id=3D"packages-built" name=3D"p=
ackages-built">#}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/vie=
ws.py
index 061e6436c..26cf5ca26 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -10,6 +10,7 @@ import ast
 import re
 import subprocess
 import sys
+import zlib
=20
 import bb.cooker
 from bb.ui import toasterui
@@ -20,6 +21,7 @@ from django.db import IntegrityError
 from django.shortcuts import render, redirect, get_object_or_404, HttpRe=
sponseRedirect
 from django.utils.http import urlencode
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe
+from orm.models import RecipeVariable
 from orm.models import LogMessage, Variable, Package_Dependency, Package
 from orm.models import Task_Dependency, Package_File
 from orm.models import Target_Installed_Package, Target_File
@@ -619,10 +621,13 @@ def recipe(request, build_id, recipe_id, active_tab=
=3D"1"):
     layer  =3D Layer.objects.get(pk=3Dlayer_version.layer_id)
     tasks_list  =3D Task.objects.filter(recipe_id =3D recipe_id, build_i=
d =3D build_id).exclude(order__isnull=3DTrue).exclude(task_name__endswith=
=3D'_setscene').exclude(outcome=3DTask.OUTCOME_NA)
     package_count =3D Package.objects.filter(recipe_id =3D recipe_id).fi=
lter(build_id =3D build_id).filter(size__gte=3D0).count()
+    recipe_variable_count =3D RecipeVariable.objects.filter(
+        build_id=3Dbuild_id, recipe_id=3Drecipe_id).values_list(
+            'variable_count', flat=3DTrue).first() or 0
=20
-    if active_tab !=3D '1' and active_tab !=3D '3' and active_tab !=3D '=
4' :
+    if active_tab not in ('1', '3', '4', '5'):
         active_tab =3D '1'
-    tab_states =3D {'1': '', '3': '', '4': ''}
+    tab_states =3D {'1': '', '3': '', '4': '', '5': ''}
     tab_states[active_tab] =3D 'active'
=20
     context =3D {
@@ -632,8 +637,63 @@ def recipe(request, build_id, recipe_id, active_tab=3D=
"1"):
             'layer'   : layer,
             'tasks'   : tasks_list,
             'package_count' : package_count,
+            'recipe_variable_count' : recipe_variable_count,
             'tab_states' : tab_states,
     }
+
+    if active_tab =3D=3D '5':
+        (requested_pagesize, requested_orderby) =3D _get_parameters_valu=
es(
+            request, 100, 'variable_name:+')
+        pagesize =3D requested_pagesize \
+            if str(requested_pagesize) in ('10', '25', '50', '100', '150=
') \
+            else 100
+        orderby =3D requested_orderby \
+            if requested_orderby in ('variable_name:+', 'variable_name:-=
') \
+            else 'variable_name:+'
+        mandatory_parameters =3D {
+            'count': pagesize,
+            'page': 1,
+            'orderby': orderby,
+        }
+        if _verify_parameters(request.GET, mandatory_parameters):
+            return _redirect_parameters(
+                'recipe', request.GET, mandatory_parameters,
+                build_id=3Dbuild_id, recipe_id=3Drecipe_id, active_tab=3D=
'5')
+
+        search_term =3D request.GET.get('search', '')[:256]
+        search_term =3D ' '.join(search_term.split()[:16])
+        snapshot =3D RecipeVariable.objects.filter(
+            build_id=3Dbuild_id, recipe_id=3Drecipe_id).first()
+        variables =3D []
+        if snapshot:
+            values =3D json.loads(zlib.decompress(snapshot.variables).de=
code('utf-8'))
+            variables =3D [
+                {'variable_name': name, 'variable_value': value}
+                for name, value in values.items()
+                if not search_term or search_term.lower() in name.lower(=
)
+                or search_term.lower() in value.lower()
+            ]
+        variables.sort(
+            key=3Dlambda variable: variable['variable_name'],
+            reverse=3Dorderby.endswith(':-'))
+        context['variable_count'] =3D len(variables)
+        context['objects'] =3D _build_page_range(
+            Paginator(variables, pagesize), request.GET.get('page', 1))
+        context['object_count'] =3D context['variable_count']
+        context['validated_pagesize'] =3D pagesize
+        context['search_term'] =3D search_term
+        context['search_orderby'] =3D 'variable_name:+'
+        context['tablecols'] =3D [
+            {
+                'name': 'Variable',
+                'orderfield': _get_toggle_order(request, 'variable_name'=
),
+                'ordericon': _get_toggle_order_icon(request, 'variable_n=
ame'),
+                'orderkey': 'variable_name',
+            },
+            {'name': 'Value'},
+        ]
+        _set_parameters_values(pagesize, orderby, request)
+
     return toaster_render(request, template, context)
=20
 def recipe_packages(request, build_id, recipe_id):
@@ -651,6 +711,9 @@ def recipe_packages(request, build_id, recipe_id):
     recipe_object =3D Recipe.objects.get(pk=3Drecipe_id)
     queryset =3D Package.objects.filter(recipe_id =3D recipe_id).filter(=
build_id =3D build_id).filter(size__gte=3D0)
     package_count =3D queryset.count()
+    variable_count =3D RecipeVariable.objects.filter(
+        build_id=3Dbuild_id, recipe_id=3Drecipe_id).values_list(
+            'variable_count', flat=3DTrue).first() or 0
     queryset =3D _get_queryset(Package, queryset, filter_string, search_=
term, ordering_string, 'name')
=20
     packages =3D _build_page_range(Paginator(queryset, pagesize),request=
.GET.get('page', 1))
@@ -660,6 +723,7 @@ def recipe_packages(request, build_id, recipe_id):
             'recipe'  : recipe_object,
             'objects'  : packages,
             'object_count' : package_count,
+            'variable_count' : variable_count,
             'tablecols':[
                 {
                     'name':'Package',
--=20
2.55.0


