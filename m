Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C732C771A3
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Feb 2017 23:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v19N6nTi001522; Thu, 9 Feb 2017 23:06:49 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HnGWsRM3ianV; Thu,  9 Feb 2017 23:06:49 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v19N6mZ9001474
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 9 Feb 2017 23:06:49 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cbxnc-0002Ge-9X; Thu, 09 Feb 2017 23:06:48 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Feb 2017 23:06:46 +0000
Message-Id: <1486681606-8677-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] lib: Drop now unneeded update_data calls
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
X-List-Received-Date: Thu, 09 Feb 2017 23:06:51 -0000

Now that the datastore works dynamically we don't need the update_data calls
so we can just remove them. They're not actually done anything at all for
a while.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     |  3 ---
 lib/bb/data_smart.py |  1 -
 lib/bb/parse/ast.py  |  3 ---
 lib/bb/providers.py  |  1 -
 lib/bb/tests/data.py | 18 +-----------------
 5 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e654a60..3968e19 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -642,7 +642,6 @@ class BBCooker:
             logger.plain(env.getvalue())
 
         # emit variables and shell functions
-        data.update_data(envdata)
         with closing(StringIO()) as env:
             data.emit_env(env, envdata, True)
             logger.plain(env.getvalue())
@@ -703,7 +702,6 @@ class BBCooker:
         for mc in self.multiconfigs:
             taskdata[mc] = bb.taskdata.TaskData(abort, skiplist=self.skiplist, allowincomplete=allowincomplete)
             localdata[mc] = data.createCopy(self.databuilder.mcdata[mc])
-            bb.data.update_data(localdata[mc])
             bb.data.expandKeys(localdata[mc])
 
         current = 0
@@ -992,7 +990,6 @@ class BBCooker:
 
         for mc in self.multiconfigs:
             localdata = data.createCopy(self.databuilder.mcdata[mc])
-            bb.data.update_data(localdata)
             bb.data.expandKeys(localdata)
 
             # Handle PREFERRED_PROVIDERS
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 0cd4168..4d56081 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -976,7 +976,6 @@ class DataSmart(MutableMapping):
         data = {}
         d = self.createCopy()
         bb.data.expandKeys(d)
-        bb.data.update_data(d)
 
         config_whitelist = set((d.getVar("BB_HASHCONFIG_WHITELIST") or "").split())
         keys = set(key for key in iter(d) if not key.startswith("__"))
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 8b5b366..dba4540 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -130,7 +130,6 @@ class DataNode(AstNode):
                 val = groupd["value"]
         elif "colon" in groupd and groupd["colon"] != None:
             e = data.createCopy()
-            bb.data.update_data(e)
             op = "immediate"
             val = e.expand(groupd["value"], key + "[:=]")
         elif "append" in groupd and groupd["append"] != None:
@@ -350,12 +349,10 @@ def finalize(fn, d, variant = None):
     bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
     bb.data.expandKeys(d)
-    bb.data.update_data(d)
     code = []
     for funcname in d.getVar("__BBANONFUNCS", False) or []:
         code.append("%s(d)" % funcname)
     bb.utils.better_exec("\n".join(code), {"d": d})
-    bb.data.update_data(d)
 
     tasklist = d.getVar('__BBTASKS', False) or []
     bb.event.fire(bb.event.RecipeTaskPreProcess(fn, list(tasklist)), d)
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 0e9c834..443187e 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -48,7 +48,6 @@ def findProviders(cfgData, dataCache, pkg_pn = None):
 
     # Need to ensure data store is expanded
     localdata = data.createCopy(cfgData)
-    bb.data.update_data(localdata)
     bb.data.expandKeys(localdata)
 
     preferred_versions = {}
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 0903ba7..be46ffc 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -258,13 +258,11 @@ class TestConcatOverride(unittest.TestCase):
     def test_prepend(self):
         self.d.setVar("TEST", "${VAL}")
         self.d.setVar("TEST_prepend", "${FOO}:")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "foo:val")
 
     def test_append(self):
         self.d.setVar("TEST", "${VAL}")
         self.d.setVar("TEST_append", ":${BAR}")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "val:bar")
 
     def test_multiple_append(self):
@@ -272,47 +270,40 @@ class TestConcatOverride(unittest.TestCase):
         self.d.setVar("TEST_prepend", "${FOO}:")
         self.d.setVar("TEST_append", ":val2")
         self.d.setVar("TEST_append", ":${BAR}")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "foo:val:val2:bar")
 
     def test_append_unset(self):
         self.d.setVar("TEST_prepend", "${FOO}:")
         self.d.setVar("TEST_append", ":val2")
         self.d.setVar("TEST_append", ":${BAR}")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "foo::val2:bar")
 
     def test_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.d.setVar("TEST_remove", "val")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "bar")
 
     def test_doubleref_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.d.setVar("TEST_remove", "val")
         self.d.setVar("TEST_TEST", "${TEST} ${TEST}")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST_TEST"), "bar bar")
 
     def test_empty_remove(self):
         self.d.setVar("TEST", "")
         self.d.setVar("TEST_remove", "val")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "")
 
     def test_remove_expansion(self):
         self.d.setVar("BAR", "Z")
         self.d.setVar("TEST", "${BAR}/X Y")
         self.d.setVar("TEST_remove", "${BAR}/X")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "Y")
 
     def test_remove_expansion_items(self):
         self.d.setVar("TEST", "A B C D")
         self.d.setVar("BAR", "B D")
         self.d.setVar("TEST_remove", "${BAR}")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "A C")
 
 class TestOverrides(unittest.TestCase):
@@ -322,17 +313,15 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TEST", "testvalue")
 
     def test_no_override(self):
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "testvalue")
 
     def test_one_override(self):
         self.d.setVar("TEST_bar", "testvalue2")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "testvalue2")
 
     def test_one_override_unset(self):
         self.d.setVar("TEST2_bar", "testvalue2")
-        bb.data.update_data(self.d)
+
         self.assertEqual(self.d.getVar("TEST2"), "testvalue2")
         self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST2', 'OVERRIDES', 'TEST2_bar'])
 
@@ -340,18 +329,15 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TEST_bar", "testvalue2")
         self.d.setVar("TEST_local", "testvalue3")
         self.d.setVar("TEST_foo", "testvalue4")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
         self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST_foo', 'OVERRIDES', 'TEST_bar', 'TEST_local'])
 
     def test_multiple_combined_overrides(self):
         self.d.setVar("TEST_local_foo_bar", "testvalue3")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
     def test_multiple_overrides_unset(self):
         self.d.setVar("TEST2_local_foo_bar", "testvalue3")
-        bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST2"), "testvalue3")
 
     def test_keyexpansion_override(self):
@@ -359,14 +345,12 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TEST_bar", "testvalue2")
         self.d.setVar("TEST_${LOCAL}", "testvalue3")
         self.d.setVar("TEST_foo", "testvalue4")
-        bb.data.update_data(self.d)
         bb.data.expandKeys(self.d)
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
     def test_rename_override(self):
         self.d.setVar("ALTERNATIVE_ncurses-tools_class-target", "a")
         self.d.setVar("OVERRIDES", "class-target")
-        bb.data.update_data(self.d)
         self.d.renameVar("ALTERNATIVE_ncurses-tools", "ALTERNATIVE_lib32-ncurses-tools")
         self.assertEqual(self.d.getVar("ALTERNATIVE_lib32-ncurses-tools"), "a")
 
-- 
2.7.4


