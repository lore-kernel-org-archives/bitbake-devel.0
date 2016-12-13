Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 3F45F71B59
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:51 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961485"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:50 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:09 +1300
Message-Id: <9782ae67dca8d419455fed1c27e2fc456d16736a.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 10/15] tinfoil: pass datastore to server when expanding python references
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:51 -0000

If you're expanding a value that refers to the value of a variable in
python code, we need to ensure that the datastore that gets used to get
the value of that variable is the client-side datastore and not just the
part of it that's on the server side. For example, suppose you are in
client code doing the following:

d.setVar('HELLO', 'there')
result = d.expand('${@d.getVar("HELLO", True)}')

result should be "there" but if the client part wasn't taken into
account, it would be whatever value HELLO had in the server portion of
the datastore (if any).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py    | 11 +++++------
 lib/bb/data_smart.py |  2 +-
 lib/bb/tests/data.py | 10 ++++++++--
 lib/bb/tinfoil.py    |  6 ++++--
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index b296b8c..352838b 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -483,14 +483,13 @@ class CommandsSync:
     dataStoreConnectorGetVarHistory.readonly = True
 
     def dataStoreConnectorExpandPythonRef(self, command, params):
-        dsindex = params[0]
+        config_data_dict = params[0]
         varname = params[1]
         expr = params[2]
-        if dsindex:
-            datastore = self.dataStores[dsindex]
-        else:
-            datastore = command.cooker.data
-        varparse = bb.data_smart.VariableParse(varname, datastore)
+
+        config_data = command.remotedatastores.receive_datastore(config_data_dict)
+
+        varparse = bb.data_smart.VariableParse(varname, config_data)
         return varparse.python_sub(expr)
 
     def dataStoreConnectorRelease(self, command, params):
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 5d0ed12..4d0a771 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -123,7 +123,7 @@ class VariableParse:
 
             if "_remote_data" in self.d:
                 connector = self.d["_remote_data"]
-                return connector.expandPythonRef(self.varname, code)
+                return connector.expandPythonRef(self.varname, code, self.d)
 
             codeobj = compile(code.strip(), self.varname or "<expansion>", "eval")
 
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 2bd481b..a17245f 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -458,8 +458,11 @@ class Remote(unittest.TestCase):
                 return self.d.localkeys()
             def getVarHistory(self, name):
                 return self.d.varhistory.variable(name)
-            def expandPythonRef(self, varname, expr):
-                varparse = bb.data_smart.VariableParse(varname, self.d)
+            def expandPythonRef(self, varname, expr, d):
+                localdata = self.d.createCopy()
+                for key in d.localkeys():
+                    localdata.setVar(d.getVar(key))
+                varparse = bb.data_smart.VariableParse(varname, localdata)
                 return varparse.python_sub(expr)
             def setVar(self, name, value):
                 self.d.setVar(name, value)
@@ -483,3 +486,6 @@ class Remote(unittest.TestCase):
         # Test setVar on client side affects server
         d2.setVar('HELLO', 'other-world')
         self.assertEqual(d1.getVar('HELLO'), 'other-world')
+        # Test client side data is incorporated in python expansion (which is done on server)
+        d2.setVar('FOO', 'bar')
+        self.assertEqual(d2.expand('${@d.getVar("FOO")}'), 'bar')
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index c551a9f..720bf4b 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -29,6 +29,7 @@ import bb.providers
 import bb.taskdata
 import bb.utils
 import bb.command
+import bb.remotedata
 from bb.cookerdata import CookerConfiguration, ConfigParameters
 from bb.main import setup_bitbake, BitBakeConfigParameters, BBMainException
 import bb.fetch2
@@ -69,8 +70,9 @@ class TinfoilDataStoreConnector:
         return set(self.tinfoil.run_command('dataStoreConnectorGetKeys', self.dsindex))
     def getVarHistory(self, name):
         return self.tinfoil.run_command('dataStoreConnectorGetVarHistory', self.dsindex, name)
-    def expandPythonRef(self, varname, expr):
-        ret = self.tinfoil.run_command('dataStoreConnectorExpandPythonRef', self.dsindex, varname, expr)
+    def expandPythonRef(self, varname, expr, d):
+        ds = bb.remotedata.RemoteDatastores.transmit_datastore(d)
+        ret = self.tinfoil.run_command('dataStoreConnectorExpandPythonRef', ds, varname, expr)
         return ret
     def setVar(self, varname, value):
         if self.dsindex is None:
-- 
2.5.5


