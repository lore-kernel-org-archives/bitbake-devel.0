Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 226BB71B56
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:39 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961422"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:34 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:04 +1300
Message-Id: <bb8218244f7f89c1318371d13883350d5af6aac8.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 05/15] data_smart: implement remote datastore functionality
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:39 -0000

This allows you to maintain a local reference to a remote datastore. The
actual implementation of the remote connection is delegated to a
connector object that the caller must define and supply. There is
support for getting variable values and expanding python references
(i.e. ${@...} remotely, however setting variables remotely is not
supported - any variable setting is done locally as if the datastore
were a copy (which it kind of is).

Loosely based on an earlier prototype implementation by Qing He.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/data_smart.py | 39 +++++++++++++++++++++++++++++++++------
 lib/bb/tests/data.py | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 17768c8..5d0ed12 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -116,7 +116,15 @@ class VariableParse:
                 return match.group()
 
     def python_sub(self, match):
-            code = match.group()[3:-1]
+            if isinstance(match, str):
+                code = match
+            else:
+                code = match.group()[3:-1]
+
+            if "_remote_data" in self.d:
+                connector = self.d["_remote_data"]
+                return connector.expandPythonRef(self.varname, code)
+
             codeobj = compile(code.strip(), self.varname or "<expansion>", "eval")
 
             parser = bb.codeparser.PythonParser(self.varname, logger)
@@ -247,10 +255,15 @@ class VariableHistory(object):
         self.variables[var].append(loginfo.copy())
 
     def variable(self, var):
-        if var in self.variables:
-            return self.variables[var]
+        remote_connector = self.dataroot.getVar('_remote_data', False)
+        if remote_connector:
+            varhistory = remote_connector.getVarHistory(var)
         else:
-            return []
+            varhistory = []
+
+        if var in self.variables:
+            varhistory.extend(self.variables[var])
+        return varhistory
 
     def emit(self, var, oval, val, o, d):
         history = self.variable(var)
@@ -449,6 +462,10 @@ class DataSmart(MutableMapping):
             if var in dest:
                 return dest[var]
 
+            if "_remote_data" in dest:
+                connector = dest["_remote_data"]["_content"]
+                return connector.getVar(var)
+
             if "_data" not in dest:
                 break
             dest = dest["_data"]
@@ -471,6 +488,12 @@ class DataSmart(MutableMapping):
         if 'parsing' in loginfo:
             parsing=True
 
+        if '_remote_data' in self.dict:
+            connector = self.dict["_remote_data"]["_content"]
+            res = connector.setVar(var, value)
+            if not res:
+                return
+
         if 'op' not in loginfo:
             loginfo['op'] = "set"
         self.expand_cache = {}
@@ -875,7 +898,7 @@ class DataSmart(MutableMapping):
 
     def localkeys(self):
         for key in self.dict:
-            if key != '_data':
+            if key not in ['_data', '_remote_data']:
                 yield key
 
     def __iter__(self):
@@ -884,7 +907,7 @@ class DataSmart(MutableMapping):
         def keylist(d):        
             klist = set()
             for key in d:
-                if key == "_data":
+                if key in ["_data", "_remote_data"]:
                     continue
                 if key in deleted:
                     continue
@@ -898,6 +921,10 @@ class DataSmart(MutableMapping):
             if "_data" in d:
                 klist |= keylist(d["_data"])
 
+            if "_remote_data" in d:
+                connector = d["_remote_data"]["_content"]
+                klist |= connector.getKeys()
+
             return klist
 
         self.need_overrides()
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 1a5a28a..2bd481b 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -444,3 +444,42 @@ class Contains(unittest.TestCase):
 
         self.assertFalse(bb.utils.contains_any("SOMEFLAG", "x", True, False, self.d))
         self.assertFalse(bb.utils.contains_any("SOMEFLAG", "x y z", True, False, self.d))
+
+
+class Remote(unittest.TestCase):
+    def test_remote(self):
+        class TestConnector:
+            d = None
+            def __init__(self, d):
+                self.d = d
+            def getVar(self, name):
+                return self.d._findVar(name)
+            def getKeys(self):
+                return self.d.localkeys()
+            def getVarHistory(self, name):
+                return self.d.varhistory.variable(name)
+            def expandPythonRef(self, varname, expr):
+                varparse = bb.data_smart.VariableParse(varname, self.d)
+                return varparse.python_sub(expr)
+            def setVar(self, name, value):
+                self.d.setVar(name, value)
+
+        d1 = bb.data.init()
+        d1.enableTracking()
+        d2 = bb.data.init()
+        d2.enableTracking()
+        connector = TestConnector(d1)
+
+        d2.setVar('_remote_data', connector)
+
+        d1.setVar('HELLO', 'world')
+        d1.setVarFlag('OTHER', 'flagname', 'flagvalue')
+        self.assertEqual(d2.getVar('HELLO'), 'world')
+        self.assertEqual(d2.expand('${HELLO}'), 'world')
+        self.assertEqual(d2.expand('${@d.getVar("HELLO")}'), 'world')
+        self.assertIn('flagname', d2.getVarFlags('OTHER'))
+        self.assertEqual(d2.getVarFlag('OTHER', 'flagname'), 'flagvalue')
+        self.assertEqual(d1.varhistory.variable('HELLO'), d2.varhistory.variable('HELLO'))
+        # Test setVar on client side affects server
+        d2.setVar('HELLO', 'other-world')
+        self.assertEqual(d1.getVar('HELLO'), 'other-world')
-- 
2.5.5


