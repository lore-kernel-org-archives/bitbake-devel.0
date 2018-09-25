Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id CC26878D34
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 15:07:38 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8PF7dLn007210
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 08:07:39 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 25 Sep 2018 08:07:38 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Sep 2018 11:07:08 -0400
Message-ID: <20180925150708.2983-4-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180925150708.2983-1-mark.hatle@windriver.com>
References: <20180925150708.2983-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] lib/layerindexlib/tests/restapi.py: Fix test cases when BB_SKIP_NETTETS=yes
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
X-List-Received-Date: Tue, 25 Sep 2018 15:07:38 -0000
Content-Type: text/plain

Change the way the network related tests are skipped, based on how the
fetch tests are handled.  We introduce a 'skipIfNoNetwork()' function that
will report skipped tests through the standard unit test reporting system.

[YOCTO #12928]

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/layerindexlib/tests/restapi.py | 164 ++++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 77 deletions(-)

diff --git a/lib/layerindexlib/tests/restapi.py b/lib/layerindexlib/tests/restapi.py
index bfaac43..5876695 100644
--- a/lib/layerindexlib/tests/restapi.py
+++ b/lib/layerindexlib/tests/restapi.py
@@ -23,113 +23,122 @@ from layerindexlib.tests.common import LayersTest
 
 import logging
 
-class LayerIndexWebRestApiTest(LayersTest):
-
+def skipIfNoNetwork():
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-        print("Unset BB_SKIP_NETTESTS to run network tests")
-    else:
-        def setUp(self):
-            LayersTest.setUp(self)
-            self.layerindex = layerindexlib.LayerIndex(self.d)
-            self.layerindex.load_layerindex('http://layers.openembedded.org/layerindex/api/;branch=sumo', load=['layerDependencies'])
+        return unittest.skip("Network tests being skipped")
+    return lambda f: f
 
-        def test_layerindex_is_empty(self):
-            self.assertFalse(self.layerindex.is_empty(), msg="Layerindex is empty")
+class LayerIndexWebRestApiTest(LayersTest):
 
-        def test_layerindex_store_file(self):
-            self.layerindex.store_layerindex('file://%s/file.json' % self.tempdir, self.layerindex.indexes[0])
+    @skipIfNoNetwork()
+    def setUp(self):
+        self.assertFalse(os.environ.get("BB_SKIP_NETTESTS") == "yes", msg="BB_SKIP_NETTESTS set, but we tried to test anyway")
+        LayersTest.setUp(self)
+        self.layerindex = layerindexlib.LayerIndex(self.d)
+        self.layerindex.load_layerindex('http://layers.openembedded.org/layerindex/api/;branch=sumo', load=['layerDependencies'])
 
-            self.assertTrue(os.path.isfile('%s/file.json' % self.tempdir), msg="Temporary file was not created by store_layerindex")
+    @skipIfNoNetwork()
+    def test_layerindex_is_empty(self):
+        self.assertFalse(self.layerindex.is_empty(), msg="Layerindex is empty")
 
-            reload = layerindexlib.LayerIndex(self.d)
-            reload.load_layerindex('file://%s/file.json' % self.tempdir)
+    @skipIfNoNetwork()
+    def test_layerindex_store_file(self):
+        self.layerindex.store_layerindex('file://%s/file.json' % self.tempdir, self.layerindex.indexes[0])
 
-            self.assertFalse(reload.is_empty(), msg="Layerindex is empty")
+        self.assertTrue(os.path.isfile('%s/file.json' % self.tempdir), msg="Temporary file was not created by store_layerindex")
 
-            # Calculate layerItems in original index that should NOT be in reload
-            layerItemNames = []
-            for itemId in self.layerindex.indexes[0].layerItems:
-                layerItemNames.append(self.layerindex.indexes[0].layerItems[itemId].name)
+        reload = layerindexlib.LayerIndex(self.d)
+        reload.load_layerindex('file://%s/file.json' % self.tempdir)
 
-            for layerBranchId in self.layerindex.indexes[0].layerBranches:
-                layerItemNames.remove(self.layerindex.indexes[0].layerBranches[layerBranchId].layer.name)
+        self.assertFalse(reload.is_empty(), msg="Layerindex is empty")
 
-            for itemId in reload.indexes[0].layerItems:
-                self.assertFalse(reload.indexes[0].layerItems[itemId].name in layerItemNames, msg="Item reloaded when it shouldn't have been")
+        # Calculate layerItems in original index that should NOT be in reload
+        layerItemNames = []
+        for itemId in self.layerindex.indexes[0].layerItems:
+            layerItemNames.append(self.layerindex.indexes[0].layerItems[itemId].name)
 
-            # Compare the original to what we wrote...
-            for type in self.layerindex.indexes[0]._index:
-                if type == 'apilinks' or \
-                   type == 'layerItems' or \
-                   type in self.layerindex.indexes[0].config['local']:
-                    continue
-                for id in getattr(self.layerindex.indexes[0], type):
-                    self.logger.debug(1, "type %s" % (type))
+        for layerBranchId in self.layerindex.indexes[0].layerBranches:
+            layerItemNames.remove(self.layerindex.indexes[0].layerBranches[layerBranchId].layer.name)
 
-                    self.assertTrue(id in getattr(reload.indexes[0], type), msg="Id number not in reloaded index")
+        for itemId in reload.indexes[0].layerItems:
+            self.assertFalse(reload.indexes[0].layerItems[itemId].name in layerItemNames, msg="Item reloaded when it shouldn't have been")
 
-                    self.logger.debug(1, "%s ? %s" % (getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id]))
+        # Compare the original to what we wrote...
+        for type in self.layerindex.indexes[0]._index:
+            if type == 'apilinks' or \
+               type == 'layerItems' or \
+               type in self.layerindex.indexes[0].config['local']:
+                continue
+            for id in getattr(self.layerindex.indexes[0], type):
+                self.logger.debug(1, "type %s" % (type))
 
-                    self.assertEqual(getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id], msg="Reloaded contents different")
+                self.assertTrue(id in getattr(reload.indexes[0], type), msg="Id number not in reloaded index")
 
-        def test_layerindex_store_split(self):
-            self.layerindex.store_layerindex('file://%s' % self.tempdir, self.layerindex.indexes[0])
+                self.logger.debug(1, "%s ? %s" % (getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id]))
 
-            reload = layerindexlib.LayerIndex(self.d)
-            reload.load_layerindex('file://%s' % self.tempdir)
+                self.assertEqual(getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id], msg="Reloaded contents different")
 
-            self.assertFalse(reload.is_empty(), msg="Layer index is empty")
+    @skipIfNoNetwork()
+    def test_layerindex_store_split(self):
+        self.layerindex.store_layerindex('file://%s' % self.tempdir, self.layerindex.indexes[0])
 
-            for type in self.layerindex.indexes[0]._index:
-                if type == 'apilinks' or \
-                   type == 'layerItems' or \
-                   type in self.layerindex.indexes[0].config['local']:
-                    continue
-                for id in getattr(self.layerindex.indexes[0] ,type):
-                    self.logger.debug(1, "type %s" % (type))
+        reload = layerindexlib.LayerIndex(self.d)
+        reload.load_layerindex('file://%s' % self.tempdir)
 
-                    self.assertTrue(id in getattr(reload.indexes[0], type), msg="Id number missing from reloaded data")
+        self.assertFalse(reload.is_empty(), msg="Layer index is empty")
 
-                    self.logger.debug(1, "%s ? %s" % (getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id]))
+        for type in self.layerindex.indexes[0]._index:
+            if type == 'apilinks' or \
+               type == 'layerItems' or \
+               type in self.layerindex.indexes[0].config['local']:
+                continue
+            for id in getattr(self.layerindex.indexes[0] ,type):
+                self.logger.debug(1, "type %s" % (type))
 
-                    self.assertEqual(getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id], msg="reloaded data does not match original")
+                self.assertTrue(id in getattr(reload.indexes[0], type), msg="Id number missing from reloaded data")
 
-        def test_dependency_resolution(self):
-            # Verify depth first searching...
-            (dependencies, invalidnames) = self.layerindex.find_dependencies(names=['meta-python'])
+                self.logger.debug(1, "%s ? %s" % (getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id]))
 
-            first = True
-            for deplayerbranch in dependencies:
-                layerBranch = dependencies[deplayerbranch][0]
-                layerDeps = dependencies[deplayerbranch][1:]
+                self.assertEqual(getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id], msg="reloaded data does not match original")
 
-                if not first:
-                    continue
+    @skipIfNoNetwork()
+    def test_dependency_resolution(self):
+        # Verify depth first searching...
+        (dependencies, invalidnames) = self.layerindex.find_dependencies(names=['meta-python'])
 
-                first = False
+        first = True
+        for deplayerbranch in dependencies:
+            layerBranch = dependencies[deplayerbranch][0]
+            layerDeps = dependencies[deplayerbranch][1:]
 
-                # Top of the deps should be openembedded-core, since everything depends on it.
-                self.assertEqual(layerBranch.layer.name, "openembedded-core", msg='OpenEmbedded-Core is no the first dependency')
+            if not first:
+                continue
 
-                # meta-python should cause an openembedded-core dependency, if not assert!
-                for dep in layerDeps:
-                    if dep.layer.name == 'meta-python':
-                        break
-                else:
-                    self.logger.debug(1, "meta-python was not found")
-                    self.assetTrue(False)
+            first = False
 
-                # Only check the first element...
-                break
+            # Top of the deps should be openembedded-core, since everything depends on it.
+            self.assertEqual(layerBranch.layer.name, "openembedded-core", msg='OpenEmbedded-Core is no the first dependency')
+
+            # meta-python should cause an openembedded-core dependency, if not assert!
+            for dep in layerDeps:
+                if dep.layer.name == 'meta-python':
+                    break
             else:
-                # Empty list, this is bad.
-                self.logger.debug(1, "Empty list of dependencies")
-                self.assertIsNotNone(first, msg="Empty list of dependencies")
+                self.logger.debug(1, "meta-python was not found")
+                self.assetTrue(False)
+
+            # Only check the first element...
+            break
+        else:
+            # Empty list, this is bad.
+            self.logger.debug(1, "Empty list of dependencies")
+            self.assertIsNotNone(first, msg="Empty list of dependencies")
 
-                # Last dep should be the requested item
-                layerBranch = dependencies[deplayerbranch][0]
-                self.assertEqual(layerBranch.layer.name, "meta-python", msg="Last dependency not meta-python")
+            # Last dep should be the requested item
+            layerBranch = dependencies[deplayerbranch][0]
+            self.assertEqual(layerBranch.layer.name, "meta-python", msg="Last dependency not meta-python")
 
+    @skipIfNoNetwork()
     def test_find_collection(self):
         def _check(collection, expected):
             self.logger.debug(1, "Looking for collection %s..." % collection)
@@ -149,6 +158,7 @@ class LayerIndexWebRestApiTest(LayersTest):
         for collection,result in tests:
             _check(collection, result)
 
+    @skipIfNoNetwork()
     def test_find_layerbranch(self):
         def _check(name, expected):
             self.logger.debug(1, "Looking for layerbranch %s..." % name)
-- 
1.8.3.1


