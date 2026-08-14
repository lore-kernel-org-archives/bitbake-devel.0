Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A965AC5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15785.1786721773449096641
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 08:36:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=lJwik8tl;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 458783D8185E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 11:36:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1saMAWK8khzD; Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 04CC43D818E9;
	Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 04CC43D818E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786721768; bh=fJVLWX8G1x8kU0shDbYZJQHJi2eKHblfJIgxyftUwWc=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=lJwik8tlu2G+6xk1fAPYdNq5V8vt3RujDLB4XtzekkqJo3+qNfKHBYXSnFzrbvo7Q
	 Tb6LjhxuKG9OACMrZNLIOdJbF9Mtf9avzacsH/fprc75ff/hJb4jlC+mzrODtYp2Bk
	 q02HHRELR2duOkS3107AsgsQpnCcvSKw/pXeCjQubJorQ1VAT0//4MhgheqKKxsCPe
	 4nI23MDOUzOq5mz2hBpTEuCUu2Y1c8siHiAoWyLwpoQyyixv1y2a3uRSNujpKR9YTn
	 PJearvhfDnfexkd9GZF+N7jjv9QHyj0Ve50FvU8/hAZzmxWPQ/DnyieP0Ht7CQUEkj
	 HxUCDE3dnDtqg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tU3ZQll3BR9I; Fri, 14 Aug 2026 11:36:07 -0400 (EDT)
Received: from pwattebled.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CED623D818A9;
	Fri, 14 Aug 2026 11:36:07 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Subject: [PATCH v2 1/5] cache_extra: Collect recipe variable snapshots
Date: Fri, 14 Aug 2026 11:35:54 -0400
Message-ID: <20260814153602.2107764-2-paolo.wattebled@savoirfairelinux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
References: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 15:36:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19944

Collect final values defined or modified by recipes, matching bbappends
and recipe include files. Preserve active override and variable flag
values while excluding inherited-only metadata and functions.

Enable variable tracking while recipe metadata is parsed, add focused
extraction tests and invalidate stale recipe information caches.

AI-Generated: Uses GitHub Copilot and OpenCode with GPT-5.6 Sol
Signed-off-by: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
---
 bin/bitbake-selftest        |   1 +
 lib/bb/cache.py             |   2 +-
 lib/bb/cache_extra.py       | 101 +++++++++++++++-
 lib/bb/cookerdata.py        |   5 +-
 lib/bb/tests/cache_extra.py | 235 ++++++++++++++++++++++++++++++++++++
 5 files changed, 340 insertions(+), 4 deletions(-)
 create mode 100644 lib/bb/tests/cache_extra.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index fb7c57dd8..1b09815cd 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -21,6 +21,7 @@ except RuntimeError as exc:
     sys.exit(str(exc))

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

 logger =3D logging.getLogger("BitBake.Cache")

-__cache_version__ =3D "156"
+__cache_version__ =3D "157"

 def getCacheFile(path, filename, mc, data_hash):
     mcspec =3D ''
diff --git a/lib/bb/cache_extra.py b/lib/bb/cache_extra.py
index bf4226d16..78ef6b638 100644
--- a/lib/bb/cache_extra.py
+++ b/lib/bb/cache_extra.py
@@ -13,7 +13,65 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #

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
+def _recipe_includes(metadata, filename):
+    includes =3D set()
+
+    def collect(node):
+        for child in node.children:
+            if child.filename.endswith('.bbclass'):
+                continue
+            if child.filename.endswith('.inc'):
+                includes.add(child.filename)
+            collect(child)
+
+    for child in metadata.inchistory.children:
+        if child.filename =3D=3D filename:
+            collect(child)
+    return includes
+
+
+def _recipe_value_event(metadata, event, recipe_includes):
+    event_file =3D event.get('file', '')
+    if (not event_file.endswith(('.bb', '.bbappend')) and
+            event_file not in recipe_includes):
+        return False
+    operation =3D event.get('op', '')
+    if '[' not in operation:
+        return True
+    override =3D operation.rsplit('[', 1)[1].removesuffix(']')
+    return set(override.split(':')).issubset(metadata.overridesset)
+

 class HobRecipeInfo(RecipeInfoCommon):
     __slots__ =3D ()
@@ -27,7 +85,7 @@ class HobRecipeInfo(RecipeInfoCommon):
     # that this class will provide
     cachefields =3D ['summary', 'license', 'section',
             'description', 'homepage', 'bugtracker',
-            'prevision', 'files_info']
+            'prevision', 'files_info', 'recipe_variables']

     def __init__(self, filename, metadata):

@@ -39,6 +97,45 @@ class HobRecipeInfo(RecipeInfoCommon):
         self.bugtracker =3D self.getvar('BUGTRACKER', metadata)
         self.prevision =3D self.getvar('PR', metadata)
         self.files_info =3D self.getvar('FILES_INFO', metadata)
+        recipe_variables =3D {}
+        recipe_includes =3D _recipe_includes(metadata, filename)
+        for variable_name in metadata:
+            try:
+                if ':' in variable_name:
+                    continue
+                winning_override =3D _winning_override(metadata, variabl=
e_name)
+                history =3D metadata.varhistory.variable(variable_name)
+                if winning_override:
+                    history +=3D metadata.varhistory.variable(winning_ov=
erride)
+                if not any(_recipe_value_event(metadata, event, recipe_i=
ncludes)
+                           for event in history):
+                    # Keep this snapshot limited to recipe metadata.
+                    continue
+                if (metadata.getVarFlag(variable_name, 'func', False) or
+                        winning_override and
+                        metadata.getVarFlag(winning_override, 'func', Fa=
lse)):
+                    continue
+                value =3D metadata.getVar(variable_name, True)
+                recipe_variables[variable_name] =3D '' if value is None =
else str(value)
+                flag_sources =3D [variable_name]
+                if winning_override and winning_override !=3D variable_n=
ame:
+                    flag_sources.append(winning_override)
+                for flag_source in flag_sources:
+                    for flag in metadata.getVarFlags(flag_source) or {}:
+                        if flag =3D=3D 'func':
+                            continue
+                        try:
+                            flag_value =3D metadata.getVarFlag(flag_sour=
ce, flag, True)
+                            if flag_value is not None:
+                                recipe_variables['%s[%s]' % (variable_na=
me, flag)] =3D str(flag_value)
+                        except Exception as exc:
+                            logger.debug("Omitting recipe variable flag =
%s[%s] from %s after %s",
+                                         variable_name, flag, filename, =
type(exc).__name__)
+            except Exception as exc:
+                logger.debug("Omitting recipe variable %s from %s after =
%s",
+                             variable_name, filename, type(exc).__name__=
)
+        self.recipe_variables =3D zlib.compress(
+            json.dumps(recipe_variables, separators=3D(',', ':')).encode=
('utf-8'))

     @classmethod
     def init_cacheData(cls, cachedata):
@@ -51,6 +148,7 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.bugtracker =3D {}
         cachedata.prevision =3D {}
         cachedata.files_info =3D {}
+        cachedata.recipe_variables =3D {}

     def add_cacheData(self, cachedata, fn):
         cachedata.summary[fn] =3D self.summary
@@ -61,3 +159,4 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.bugtracker[fn] =3D self.bugtracker
         cachedata.prevision[fn] =3D self.prevision
         cachedata.files_info[fn] =3D self.files_info
+        cachedata.recipe_variables[fn] =3D self.recipe_variables
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 59f808c96..e68829813 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -507,8 +507,9 @@ class CookerDataBuilder(object):

         return data

-    @staticmethod
-    def _parse_recipe(bb_data, bbfile, appends, mc, layername):
+    def _parse_recipe(self, bb_data, bbfile, appends, mc, layername):
+        if self.tracking:
+            bb_data.enableTracking()
         bb_data.setVar("__BBMULTICONFIG", mc)
         bb_data.setVar("FILE_LAYERNAME", layername)

diff --git a/lib/bb/tests/cache_extra.py b/lib/bb/tests/cache_extra.py
new file mode 100644
index 000000000..c695bb185
--- /dev/null
+++ b/lib/bb/tests/cache_extra.py
@@ -0,0 +1,235 @@
+#
+# BitBake Tests for extra cache data
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import unittest
+import json
+import os
+import tempfile
+import zlib
+
+import bb.data
+import bb.parse
+import bb.siggen
+from bb.cookerdata import CookerDataBuilder
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
+        metadata.setVar('INHERITED', 'global', file=3D'test.inc', line=3D=
1)
+        metadata.setVar('__INTERNAL', 'internal', file=3D'test.bbclass',=
 line=3D1)
+        metadata.setVar('FROM_CONFIG', 'config', file=3D'conf/local.conf=
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
+        self.assertNotIn('__INTERNAL', variables)
+        self.assertNotIn('FROM_CONFIG', variables)
+        self.assertNotIn('do_function', variables)
+
+    def test_parsed_recipe_variables_include_recipe_inc_but_not_class(se=
lf):
+        metadata =3D self.metadata()
+        metadata.setVar('__bbclasstype', 'recipe')
+        bb.parse.siggen =3D bb.siggen.init(metadata)
+        metadata.disableTracking()
+        builder =3D object.__new__(CookerDataBuilder)
+        builder.tracking =3D True
+
+        with tempfile.TemporaryDirectory() as tempdir:
+            recipe =3D os.path.join(tempdir, 'test.bb')
+            include =3D os.path.join(tempdir, 'test.inc')
+            classes =3D os.path.join(tempdir, 'classes')
+            os.mkdir(classes)
+            metadata.setVar('BBPATH', tempdir)
+            with open(include, 'w') as handle:
+                handle.write('FROM_INC =3D "inc"\n')
+            with open(os.path.join(tempdir, 'class.inc'), 'w') as handle=
:
+                handle.write('FROM_CLASS_INC =3D "class-inc"\n')
+            with open(os.path.join(classes, 'testclass.bbclass'), 'w') a=
s handle:
+                handle.write('require class.inc\nFROM_CLASS =3D "class"\=
n')
+            with open(recipe, 'w') as handle:
+                handle.write('require test.inc\ninherit testclass\nFROM_=
RECIPE =3D "recipe"\n')
+
+            parsed =3D builder._parse_recipe(metadata, recipe, [], '', '=
')['']
+            info =3D HobRecipeInfo(recipe, parsed)
+
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+        self.assertEqual(variables['FROM_RECIPE'], 'recipe')
+        self.assertEqual(variables['FROM_INC'], 'inc')
+        self.assertNotIn('FROM_CLASS', variables)
+        self.assertNotIn('FROM_CLASS_INC', variables)
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
+    def test_variable_flags_are_included(self):
+        metadata =3D self.metadata()
+        metadata.setVar('PACKAGECONFIG', 'feature', file=3D'test.bb', li=
ne=3D1)
+        metadata.setVarFlag('PACKAGECONFIG', 'feature', '--enable-featur=
e',
+                            file=3D'test.inc', line=3D1)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertEqual(variables['PACKAGECONFIG[feature]'], '--enable-=
feature')
+
+    def test_active_override_flags_are_included(self):
+        metadata =3D self.metadata()
+        metadata.setVar('OVERRIDES', 'machine', file=3D'test.inc', line=3D=
1)
+        metadata.setVar('PACKAGECONFIG:machine', 'feature',
+                        file=3D'test.bbappend', line=3D2)
+        metadata.setVarFlag('PACKAGECONFIG:machine', 'feature',
+                            '--enable-feature', file=3D'test.bbappend', =
line=3D3)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertEqual(variables['PACKAGECONFIG'], 'feature')
+        self.assertEqual(variables['PACKAGECONFIG[feature]'], '--enable-=
feature')
+
+    def test_active_override_flag_wins_over_base_flag(self):
+        metadata =3D self.metadata()
+        metadata.setVar('OVERRIDES', 'machine', file=3D'conf/local.conf'=
, line=3D1)
+        metadata.setVar('PACKAGECONFIG:machine', 'feature',
+                        file=3D'test.bb', line=3D2)
+        metadata.setVarFlag('PACKAGECONFIG', 'feature', '--base',
+                            file=3D'test.inc', line=3D3)
+        metadata.setVarFlag('PACKAGECONFIG:machine', 'feature', '--machi=
ne',
+                            file=3D'test.bbappend', line=3D4)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertEqual(variables['PACKAGECONFIG[feature]'], '--machine=
')
+
+    def test_inherited_only_values_are_excluded(self):
+        metadata =3D self.metadata()
+        metadata.setVar('FROM_INC', 'inc', file=3D'test.inc', line=3D1)
+        metadata.setVar('FROM_CLASS', 'class', file=3D'test.bbclass', li=
ne=3D2)
+        metadata.setVar('FROM_CONFIG', 'config', file=3D'conf/local.conf=
', line=3D3)
+
+        info =3D HobRecipeInfo('test.bb', metadata)
+        variables =3D json.loads(zlib.decompress(info.recipe_variables))
+
+        self.assertNotIn('FROM_INC', variables)
+        self.assertNotIn('FROM_CLASS', variables)
+        self.assertNotIn('FROM_CONFIG', variables)
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
+        self.assertEqual(variables['COMBINED'], 'recipe')
+        self.assertNotIn('OVERRIDES', variables)
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
--
2.55.0


