Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5F320778A7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Mar 2017 04:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489982763; x=1521518763;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=lcjd/TuWh6/Vs02zxQheLqrqsl4Y2aeoonhOwn0Pf0M=;
	b=HhDoPqIy8BG2gmXhYcAvCRzcWpz9q5BXPj3igDTXGCIGNxyaauJii9sQ
	4J6AO8thvMAmcLUYyNwQnAtN0UryMw==;
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Mar 2017 21:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,191,1486454400"; d="scan'208";a="78840431"
Received: from cloy-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.161.201])
	by fmsmga006.fm.intel.com with ESMTP; 19 Mar 2017 21:06:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Mar 2017 17:05:53 +1300
Message-Id: <353c04475f2a42f09e6b2a54db9f48af8a8525ef.1489982696.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1489982696.git.paul.eggleton@linux.intel.com>
References: <cover.1489982696.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] data_smart: implement missing remote datastore operations
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
X-List-Received-Date: Mon, 20 Mar 2017 04:06:01 -0000

Enable the following operations from a remote datastore to affect the
other end:

* setVarFlag()
* delVar()
* delVarFlag()
* renameVar()

In practice I don't expect these to be used much, but they should be
present so that the implementation is at least reasonably filled out
and that the tests pass.

Also add tests for the interface, mostly by subclassing the existing
local test classes so that they are using a remote datastore. (These
don't actually test remote usage via tinfoil, just that the
datastore's interface can be used.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py    |  25 ++++++++++
 lib/bb/data_smart.py |  29 +++++++++++-
 lib/bb/tests/data.py | 128 +++++++++++++++++++++++++++++++++++++++++++--------
 lib/bb/tinfoil.py    |  30 +++++++++++-
 4 files changed, 192 insertions(+), 20 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 222a76e..78a86ac 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -505,6 +505,31 @@ class CommandsSync:
             raise CommandError('dataStoreConnectorRelease: invalid index %d' % dsindex)
         command.remotedatastores.release(dsindex)
 
+    def dataStoreConnectorSetVarFlag(self, command, params):
+        dsindex = params[0]
+        name = params[1]
+        flag = params[2]
+        value = params[3]
+        datastore = command.remotedatastores[dsindex]
+        datastore.setVarFlag(name, flag, value)
+
+    def dataStoreConnectorDelVar(self, command, params):
+        dsindex = params[0]
+        name = params[1]
+        datastore = command.remotedatastores[dsindex]
+        if len(params) > 2:
+            flag = params[2]
+            datastore.delVarFlag(name, flag)
+        else:
+            datastore.delVar(name)
+
+    def dataStoreConnectorRenameVar(self, command, params):
+        dsindex = params[0]
+        name = params[1]
+        newname = params[2]
+        datastore = command.remotedatastores[dsindex]
+        datastore.renameVar(name, newname)
+
     def parseRecipeFile(self, command, params):
         """
         Parse the specified recipe file (with or without bbappends)
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 5777d54..d6dd698 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -609,6 +609,12 @@ class DataSmart(MutableMapping):
         """
         Rename the variable key to newkey
         """
+        if '_remote_data' in self.dict:
+            connector = self.dict["_remote_data"]["_content"]
+            res = connector.renameVar(key, newkey)
+            if not res:
+                return
+
         val = self.getVar(key, 0, parsing=True)
         if val is not None:
             loginfo['variable'] = newkey
@@ -652,6 +658,12 @@ class DataSmart(MutableMapping):
         self.setVar(var + "_prepend", value, ignore=True, parsing=True)
 
     def delVar(self, var, **loginfo):
+        if '_remote_data' in self.dict:
+            connector = self.dict["_remote_data"]["_content"]
+            res = connector.delVar(var)
+            if not res:
+                return
+
         loginfo['detail'] = ""
         loginfo['op'] = 'del'
         self.varhistory.record(**loginfo)
@@ -678,6 +690,12 @@ class DataSmart(MutableMapping):
                          override = None
 
     def setVarFlag(self, var, flag, value, **loginfo):
+        if '_remote_data' in self.dict:
+            connector = self.dict["_remote_data"]["_content"]
+            res = connector.setVarFlag(var, flag, value)
+            if not res:
+                return
+
         self.expand_cache = {}
         if 'op' not in loginfo:
             loginfo['op'] = "set"
@@ -796,6 +814,12 @@ class DataSmart(MutableMapping):
         return value
 
     def delVarFlag(self, var, flag, **loginfo):
+        if '_remote_data' in self.dict:
+            connector = self.dict["_remote_data"]["_content"]
+            res = connector.delVarFlag(var, flag)
+            if not res:
+                return
+
         self.expand_cache = {}
         local_var, _ = self._findVar(var)
         if not local_var:
@@ -938,7 +962,10 @@ class DataSmart(MutableMapping):
 
             if "_remote_data" in d:
                 connector = d["_remote_data"]["_content"]
-                klist |= connector.getKeys()
+                for key in connector.getKeys():
+                    if key in deleted:
+                        continue
+                    klist.add(key)
 
             return klist
 
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index da3f4e6..fe947f5 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -460,26 +460,43 @@ class Serialize(unittest.TestCase):
         self.assertEqual(newd.getVarFlag('HELLO', 'other'), 'planet')
 
 
+# Remote datastore tests
+# These really only test the interface, since in actual usage we have a
+# tinfoil connector that does everything over RPC, and this doesn't test
+# that.
+
+class TestConnector:
+    d = None
+    def __init__(self, d):
+        self.d = d
+    def getVar(self, name):
+        return self.d._findVar(name)
+    def getKeys(self):
+        return set(self.d.keys())
+    def getVarHistory(self, name):
+        return self.d.varhistory.variable(name)
+    def expandPythonRef(self, varname, expr, d):
+        localdata = self.d.createCopy()
+        for key in d.localkeys():
+            localdata.setVar(d.getVar(key))
+        varparse = bb.data_smart.VariableParse(varname, localdata)
+        return varparse.python_sub(expr)
+    def setVar(self, name, value):
+        self.d.setVar(name, value)
+    def setVarFlag(self, name, flag, value):
+        self.d.setVarFlag(name, flag, value)
+    def delVar(self, name):
+        self.d.delVar(name)
+        return False
+    def delVarFlag(self, name, flag):
+        self.d.delVarFlag(name, flag)
+        return False
+    def renameVar(self, name, newname):
+        self.d.renameVar(name, newname)
+        return False
+
 class Remote(unittest.TestCase):
     def test_remote(self):
-        class TestConnector:
-            d = None
-            def __init__(self, d):
-                self.d = d
-            def getVar(self, name):
-                return self.d._findVar(name)
-            def getKeys(self):
-                return self.d.localkeys()
-            def getVarHistory(self, name):
-                return self.d.varhistory.variable(name)
-            def expandPythonRef(self, varname, expr, d):
-                localdata = self.d.createCopy()
-                for key in d.localkeys():
-                    localdata.setVar(d.getVar(key))
-                varparse = bb.data_smart.VariableParse(varname, localdata)
-                return varparse.python_sub(expr)
-            def setVar(self, name, value):
-                self.d.setVar(name, value)
 
         d1 = bb.data.init()
         d1.enableTracking()
@@ -500,6 +517,9 @@ class Remote(unittest.TestCase):
         # Test setVar on client side affects server
         d2.setVar('HELLO', 'other-world')
         self.assertEqual(d1.getVar('HELLO'), 'other-world')
+        # Test setVarFlag on client side affects server
+        d2.setVarFlag('HELLO', 'flagname', 'flagvalue')
+        self.assertEqual(d1.getVarFlag('HELLO', 'flagname'), 'flagvalue')
         # Test client side data is incorporated in python expansion (which is done on server)
         d2.setVar('FOO', 'bar')
         self.assertEqual(d2.expand('${@d.getVar("FOO")}'), 'bar')
@@ -507,3 +527,75 @@ class Remote(unittest.TestCase):
         d1.setVar('FOO_test', 'baz')
         d1.appendVar('OVERRIDES', ':test')
         self.assertEqual(d2.getVar('FOO'), 'baz')
+
+
+# Remote equivalents of local test classes
+# Note that these aren't perfect since we only test in one direction
+
+class RemoteDataExpansions(DataExpansions):
+    def setUp(self):
+        self.d1 = bb.data.init()
+        self.d = bb.data.init()
+        self.d1["foo"] = "value_of_foo"
+        self.d1["bar"] = "value_of_bar"
+        self.d1["value_of_foo"] = "value_of_'value_of_foo'"
+        connector = TestConnector(self.d1)
+        self.d.setVar('_remote_data', connector)
+
+class TestRemoteNestedExpansions(TestNestedExpansions):
+    def setUp(self):
+        self.d1 = bb.data.init()
+        self.d = bb.data.init()
+        self.d1["foo"] = "foo"
+        self.d1["bar"] = "bar"
+        self.d1["value_of_foobar"] = "187"
+        connector = TestConnector(self.d1)
+        self.d.setVar('_remote_data', connector)
+
+class TestRemoteConcat(TestConcat):
+    def setUp(self):
+        self.d1 = bb.data.init()
+        self.d = bb.data.init()
+        self.d1.setVar("FOO", "foo")
+        self.d1.setVar("VAL", "val")
+        self.d1.setVar("BAR", "bar")
+        connector = TestConnector(self.d1)
+        self.d.setVar('_remote_data', connector)
+
+class TestRemoteConcatOverride(TestConcatOverride):
+    def setUp(self):
+        self.d1 = bb.data.init()
+        self.d = bb.data.init()
+        self.d1.setVar("FOO", "foo")
+        self.d1.setVar("VAL", "val")
+        self.d1.setVar("BAR", "bar")
+        connector = TestConnector(self.d1)
+        self.d.setVar('_remote_data', connector)
+
+class TestRemoteOverrides(TestOverrides):
+    def setUp(self):
+        self.d1 = bb.data.init()
+        self.d = bb.data.init()
+        self.d1.setVar("OVERRIDES", "foo:bar:local")
+        self.d1.setVar("TEST", "testvalue")
+        connector = TestConnector(self.d1)
+        self.d.setVar('_remote_data', connector)
+
+class TestRemoteKeyExpansion(TestKeyExpansion):
+    def setUp(self):
+        self.d1 = bb.data.init()
+        self.d = bb.data.init()
+        self.d1.setVar("FOO", "foo")
+        self.d1.setVar("BAR", "foo")
+        connector = TestConnector(self.d1)
+        self.d.setVar('_remote_data', connector)
+
+class TestRemoteFlags(TestFlags):
+    def setUp(self):
+        self.d1 = bb.data.init()
+        self.d = bb.data.init()
+        self.d1.setVar("foo", "value of foo")
+        self.d1.setVarFlag("foo", "flag1", "value of flag1")
+        self.d1.setVarFlag("foo", "flag2", "value of flag2")
+        connector = TestConnector(self.d1)
+        self.d.setVar('_remote_data', connector)
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 00cec59..19b41be 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -1,6 +1,6 @@
 # tinfoil: a simple wrapper around cooker for bitbake-based command-line utilities
 #
-# Copyright (C) 2012-2016 Intel Corporation
+# Copyright (C) 2012-2017 Intel Corporation
 # Copyright (C) 2011 Mentor Graphics Corporation
 #
 # This program is free software; you can redistribute it and/or modify
@@ -84,6 +84,34 @@ class TinfoilDataStoreConnector:
             # Not currently implemented - indicate that setting should
             # be redirected to local side
             return True
+    def setVarFlag(self, varname, flagname, value):
+        if self.dsindex is None:
+            self.tinfoil.run_command('dataStoreConnectorSetVarFlag', self.dsindex, varname, flagname, value)
+        else:
+            # Not currently implemented - indicate that setting should
+            # be redirected to local side
+            return True
+    def delVar(self, varname):
+        if self.dsindex is None:
+            self.tinfoil.run_command('dataStoreConnectorDelVar', self.dsindex, varname)
+        else:
+            # Not currently implemented - indicate that setting should
+            # be redirected to local side
+            return True
+    def delVarFlag(self, varname, flagname):
+        if self.dsindex is None:
+            self.tinfoil.run_command('dataStoreConnectorDelVar', self.dsindex, varname, flagname)
+        else:
+            # Not currently implemented - indicate that setting should
+            # be redirected to local side
+            return True
+    def renameVar(self, name, newname):
+        if self.dsindex is None:
+            self.tinfoil.run_command('dataStoreConnectorRenameVar', self.dsindex, name, newname)
+        else:
+            # Not currently implemented - indicate that setting should
+            # be redirected to local side
+            return True
 
 class TinfoilCookerAdapter:
     """
-- 
2.9.3


