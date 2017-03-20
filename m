Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 8AA13774EC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Mar 2017 04:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489982761; x=1521518761;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=3H7vlF6ZMbf8EWMpxYJs6t9aVsnzvIUO4xW5bM2AKCQ=;
	b=UvGeQJzM1oOF7EdYfLynevXWCg+/IyYOxS28Kuy9LXSBWBV3lgkmDDPU
	VfyypX6qn3QuDplPQxar30rUGtlK6w==;
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Mar 2017 21:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,191,1486454400"; d="scan'208";a="78840420"
Received: from cloy-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.161.201])
	by fmsmga006.fm.intel.com with ESMTP; 19 Mar 2017 21:05:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Mar 2017 17:05:52 +1300
Message-Id: <c7cb5b46c384fad5b04dce8f6d0db8f6a525297e.1489982696.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1489982696.git.paul.eggleton@linux.intel.com>
References: <cover.1489982696.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] tinfoil: fix override handling in remote datastores
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
X-List-Received-Date: Mon, 20 Mar 2017 04:05:59 -0000

There was a huge gap in the remote datastore code introduced in the
tinfoil2 rework - we weren't handling overrides at all, since these are
stored separately from the actual data in the DataSmart object. Thus,
when a datastore actually represents a remote datastore we need to go
back to that remote datastore to get the override data as well, so
introduce code to do that.

To avoid a second round-trip I had to modify the _findVar() function to
return the override data as well. This will increase the overhead a
little when that data is superfluous, but without making the function
even uglier I don't think there's a way to avoid that.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py    | 12 +++++++++---
 lib/bb/data_smart.py | 15 ++++++++-------
 lib/bb/tests/data.py |  4 ++++
 lib/bb/tinfoil.py    |  7 +++++--
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index db20f3f..222a76e 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -457,16 +457,22 @@ class CommandsSync:
         dsindex = params[0]
         name = params[1]
         datastore = command.remotedatastores[dsindex]
-        value = datastore._findVar(name)
+        value, overridedata = datastore._findVar(name)
 
         if value:
             content = value.get('_content', None)
             if isinstance(content, bb.data_smart.DataSmart):
                 # Value is a datastore (e.g. BB_ORIGENV) - need to handle this carefully
                 idx = command.remotedatastores.check_store(content, True)
-                return {'_content': DataStoreConnectionHandle(idx), '_connector_origtype': 'DataStoreConnectionHandle'}
+                return {'_content': DataStoreConnectionHandle(idx),
+                        '_connector_origtype': 'DataStoreConnectionHandle',
+                        '_connector_overrides': overridedata}
             elif isinstance(content, set):
-                return {'_content': list(content), '_connector_origtype': 'set'}
+                return {'_content': list(content),
+                        '_connector_origtype': 'set',
+                        '_connector_overrides': overridedata}
+            else:
+                value['_connector_overrides'] = overridedata
         return value
     dataStoreConnectorFindVar.readonly = True
 
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4d56081..5777d54 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -473,7 +473,7 @@ class DataSmart(MutableMapping):
         dest = self.dict
         while dest:
             if var in dest:
-                return dest[var]
+                return dest[var], self.overridedata.get(var, None)
 
             if "_remote_data" in dest:
                 connector = dest["_remote_data"]["_content"]
@@ -482,12 +482,13 @@ class DataSmart(MutableMapping):
             if "_data" not in dest:
                 break
             dest = dest["_data"]
+        return None, self.overridedata.get(var, None)
 
     def _makeShadowCopy(self, var):
         if var in self.dict:
             return
 
-        local_var = self._findVar(var)
+        local_var, _ = self._findVar(var)
 
         if local_var:
             self.dict[var] = copy.copy(local_var)
@@ -699,13 +700,13 @@ class DataSmart(MutableMapping):
             self.dict["__exportlist"]["_content"].add(var)
 
     def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False):
-        local_var = self._findVar(var)
+        local_var, overridedata = self._findVar(var)
         value = None
-        if flag == "_content" and var in self.overridedata and not parsing:
+        if flag == "_content" and overridedata is not None and not parsing:
             match = False
             active = {}
             self.need_overrides()
-            for (r, o) in self.overridedata[var]:
+            for (r, o) in overridedata:
                 # What about double overrides both with "_" in the name?
                 if o in self.overridesset:
                     active[o] = r
@@ -796,7 +797,7 @@ class DataSmart(MutableMapping):
 
     def delVarFlag(self, var, flag, **loginfo):
         self.expand_cache = {}
-        local_var = self._findVar(var)
+        local_var, _ = self._findVar(var)
         if not local_var:
             return
         if not var in self.dict:
@@ -839,7 +840,7 @@ class DataSmart(MutableMapping):
             self.dict[var][i] = flags[i]
 
     def getVarFlags(self, var, expand = False, internalflags=False):
-        local_var = self._findVar(var)
+        local_var, _ = self._findVar(var)
         flags = {}
 
         if local_var:
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 895489e..da3f4e6 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -503,3 +503,7 @@ class Remote(unittest.TestCase):
         # Test client side data is incorporated in python expansion (which is done on server)
         d2.setVar('FOO', 'bar')
         self.assertEqual(d2.expand('${@d.getVar("FOO")}'), 'bar')
+        # Test overrides work
+        d1.setVar('FOO_test', 'baz')
+        d1.appendVar('OVERRIDES', ':test')
+        self.assertEqual(d2.getVar('FOO'), 'baz')
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 940f9ab..00cec59 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -60,12 +60,15 @@ class TinfoilDataStoreConnector:
         self.dsindex = dsindex
     def getVar(self, name):
         value = self.tinfoil.run_command('dataStoreConnectorFindVar', self.dsindex, name)
+        overrides = None
         if isinstance(value, dict):
             if '_connector_origtype' in value:
                 value['_content'] = self.tinfoil._reconvert_type(value['_content'], value['_connector_origtype'])
                 del value['_connector_origtype']
-
-        return value
+            if '_connector_overrides' in value:
+                overrides = value['_connector_overrides']
+                del value['_connector_overrides']
+        return value, overrides
     def getKeys(self):
         return set(self.tinfoil.run_command('dataStoreConnectorGetKeys', self.dsindex))
     def getVarHistory(self, name):
-- 
2.9.3


