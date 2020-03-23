Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.303.1584983839406610915
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2020 10:17:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ei522XzD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id a25so18124464wrd.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2020 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gbeO4foq9lO5Xk6Iolif2LiQHppfAPhmfq8G9jgo4Rs=;
        b=Ei522XzD6oZilcAca8ncyTSxSdCUiLV/s8NTjC0LPqah25H6I4/e/zHQULvvaFL2Y/
         MEQZQCe99ZAOcZZpLoNQGMYd+2iTFaKyCGzsn/sHCLaqHIMvYXJVVl+yVM1FjKjYZZhh
         obNOQ0tgm4FJjxYpRAGrGpk3ObBnl/1YDLx9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbeO4foq9lO5Xk6Iolif2LiQHppfAPhmfq8G9jgo4Rs=;
        b=TSCtZHwFwqAo9F1PDPZ9wLZsvzRq7KPMPwNjBZsRUoibKEKAQVFgKSovBw1b0mWUus
         I31GvjEH0ZU6A3TG0BbVDld3qrHtlDCx6l3tmBCmxc09IWTEgxjBG6mJbubveStYoeVz
         kXrrneo54IAIpw7MgkZ1fbqt6b6CG7nQp3K8XZXBO5aj4KcD/e7xNebyezN5BjpVVVV0
         xZZmGt/RPJ6S7gIWaRgNZoNm7SDCisKU18mZ3qWh9NOa1Ys6wmgLbNa+iTSA5be5e/0Q
         k2YrH2mZI0Ox3uTxGvDY0CpAuHoA1JxOWd8hhRrTpvhSc3GUnkymps9UviDsMRCYAtEh
         RSWg==
X-Gm-Message-State: ANhLgQ0/TeugoAd7DtUs7KRwTiIUm0ALeTIzZlm8pbRPcI5UyPe2kkl3
	imvBSRLj8F0ZFR6YeLUsLwvles3jyT8=
X-Google-Smtp-Source: ADFU+vvxpJlB3XWllFi2XI6NhcOpU7PWIThuGAHGWqvz3f61y31Rwc1llJIVbR+vSBOo0Ii1OqwXpg==
X-Received: by 2002:a5d:694e:: with SMTP id r14mr30711831wrw.312.1584983836728;
        Mon, 23 Mar 2020 10:17:16 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id q185sm342144wme.10.2020.03.23.10.17.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:17:15 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] tinfoil: Simplify remote datastore connections
Date: Mon, 23 Mar 2020 17:17:12 +0000
Message-Id: <20200323171712.434949-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323171712.434949-1-richard.purdie@linuxfoundation.org>
References: <20200323171712.434949-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current approach to remote datastores used in tinfoil is breaking. For
example, adding a devupstream extension to a recipe with a git upstream,
making it the preferred version and then running "devtool modify" on it
causes get_srcrev() circular dependency issues. The problem is the override
handling in the datastore is broken.

This gets broken since remotedata:recieve_datastore() sets d.dict but doesn't
update d.overridedata (or d.inchistory or d.varhistory). We could play
whack-a-mole but the current implementation seems to be flawed to me. It
also doesn't cover, or only partially covers some datastore operations and
each needs new dedicated command API.

Instead, step back and reimplement the way the datastore connector works.

With this change, the datastore is either remote or local but the data is not
spread on two sides of the connection. All the API is proxied over the connection
by a single function for the datastore (and two to support variable history
and include history).

This code does not support using the datastore as a parameter to any data store
functions. We did have one case of that but its just bad code and can be
replaced.

The result is something which is much simpler and less invasive to the datastore
code itself, meaning its behaviour should be much more consistent. The existing
tests for the remote data no longer make any sense and are removed.

The one bug this code would have is if key/value pairs are returned over the IPC
and those values contained a DataSmart object since we don't recurse into return
values to find such things. Nothing appears to do that currently so lets worry
about it if its ever an issue. This change should simplfy a ton of other issues
and avoid a ton of other bugs so is a huge net gain.

Tested with bitbake's and OE's selftests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py    |  91 ++++++++--------------------
 lib/bb/data_smart.py |  53 +----------------
 lib/bb/remotedata.py |  47 +--------------
 lib/bb/tests/data.py | 139 -------------------------------------------
 lib/bb/tinfoil.py    | 118 ++++++++++++++++++------------------
 5 files changed, 88 insertions(+), 360 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index b38c151b3d..2879950933 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -450,54 +450,38 @@ class CommandsSync:
         return all_p, best
     getRuntimeProviders.readonly = True
 
-    def dataStoreConnectorFindVar(self, command, params):
+    def dataStoreConnectorCmd(self, command, params):
         dsindex = params[0]
-        name = params[1]
-        datastore = command.remotedatastores[dsindex]
-        value, overridedata = datastore._findVar(name)
-
-        if value:
-            content = value.get('_content', None)
-            if isinstance(content, bb.data_smart.DataSmart):
-                # Value is a datastore (e.g. BB_ORIGENV) - need to handle this carefully
-                idx = command.remotedatastores.check_store(content, True)
-                return {'_content': DataStoreConnectionHandle(idx),
-                        '_connector_origtype': 'DataStoreConnectionHandle',
-                        '_connector_overrides': overridedata}
-            elif isinstance(content, set):
-                return {'_content': list(content),
-                        '_connector_origtype': 'set',
-                        '_connector_overrides': overridedata}
-            else:
-                value['_connector_overrides'] = overridedata
-        else:
-            value = {}
-            value['_connector_overrides'] = overridedata
-        return value
-    dataStoreConnectorFindVar.readonly = True
+        method = params[1]
+        args = params[2]
+        kwargs = params[3]
 
-    def dataStoreConnectorGetKeys(self, command, params):
-        dsindex = params[0]
-        datastore = command.remotedatastores[dsindex]
-        return list(datastore.keys())
-    dataStoreConnectorGetKeys.readonly = True
+        d = command.remotedatastores[dsindex]
+        ret = getattr(d, method)(*args, **kwargs)
+
+        if isinstance(ret, bb.data_smart.DataSmart):
+            idx = command.remotedatastores.store(ret)
+            return DataStoreConnectionHandle(idx)
 
-    def dataStoreConnectorGetVarHistory(self, command, params):
+        return ret
+
+    def dataStoreConnectorVarHistCmd(self, command, params):
         dsindex = params[0]
-        name = params[1]
-        datastore = command.remotedatastores[dsindex]
-        return datastore.varhistory.variable(name)
-    dataStoreConnectorGetVarHistory.readonly = True
+        method = params[1]
+        args = params[2]
+        kwargs = params[3]
 
-    def dataStoreConnectorExpandPythonRef(self, command, params):
-        config_data_dict = params[0]
-        varname = params[1]
-        expr = params[2]
+        d = command.remotedatastores[dsindex].varhistory
+        return getattr(d, method)(*args, **kwargs)
 
-        config_data = command.remotedatastores.receive_datastore(config_data_dict)
+    def dataStoreConnectorIncHistCmd(self, command, params):
+        dsindex = params[0]
+        method = params[1]
+        args = params[2]
+        kwargs = params[3]
 
-        varparse = bb.data_smart.VariableParse(varname, config_data)
-        return varparse.python_sub(expr)
+        d = command.remotedatastores[dsindex].inchistory
+        return getattr(d, method)(*args, **kwargs)
 
     def dataStoreConnectorRelease(self, command, params):
         dsindex = params[0]
@@ -505,31 +489,6 @@ class CommandsSync:
             raise CommandError('dataStoreConnectorRelease: invalid index %d' % dsindex)
         command.remotedatastores.release(dsindex)
 
-    def dataStoreConnectorSetVarFlag(self, command, params):
-        dsindex = params[0]
-        name = params[1]
-        flag = params[2]
-        value = params[3]
-        datastore = command.remotedatastores[dsindex]
-        datastore.setVarFlag(name, flag, value)
-
-    def dataStoreConnectorDelVar(self, command, params):
-        dsindex = params[0]
-        name = params[1]
-        datastore = command.remotedatastores[dsindex]
-        if len(params) > 2:
-            flag = params[2]
-            datastore.delVarFlag(name, flag)
-        else:
-            datastore.delVar(name)
-
-    def dataStoreConnectorRenameVar(self, command, params):
-        dsindex = params[0]
-        name = params[1]
-        newname = params[2]
-        datastore = command.remotedatastores[dsindex]
-        datastore.renameVar(name, newname)
-
     def parseRecipeFile(self, command, params):
         """
         Parse the specified recipe file (with or without bbappends)
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index b2dc9d9fd5..70257ab7f8 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -107,10 +107,6 @@ class VariableParse:
             else:
                 code = match.group()[3:-1]
 
-            if "_remote_data" in self.d:
-                connector = self.d["_remote_data"]
-                return connector.expandPythonRef(self.varname, code, self.d)
-
             if self.varname:
                 varname = 'Var <%s>' % self.varname
             else:
@@ -268,12 +264,7 @@ class VariableHistory(object):
             self.variables[newvar].append(i.copy())
 
     def variable(self, var):
-        remote_connector = self.dataroot.getVar('_remote_data', False)
-        if remote_connector:
-            varhistory = remote_connector.getVarHistory(var)
-        else:
-            varhistory = []
-
+        varhistory = []
         if var in self.variables:
             varhistory.extend(self.variables[var])
         return varhistory
@@ -471,10 +462,6 @@ class DataSmart(MutableMapping):
             if var in dest:
                 return dest[var], self.overridedata.get(var, None)
 
-            if "_remote_data" in dest:
-                connector = dest["_remote_data"]["_content"]
-                return connector.getVar(var)
-
             if "_data" not in dest:
                 break
             dest = dest["_data"]
@@ -499,12 +486,6 @@ class DataSmart(MutableMapping):
         if 'parsing' in loginfo:
             parsing=True
 
-        if '_remote_data' in self.dict:
-            connector = self.dict["_remote_data"]["_content"]
-            res = connector.setVar(var, value)
-            if not res:
-                return
-
         if 'op' not in loginfo:
             loginfo['op'] = "set"
 
@@ -612,12 +593,6 @@ class DataSmart(MutableMapping):
             bb.warn("Calling renameVar with equivalent keys (%s) is invalid" % key)
             return
 
-        if '_remote_data' in self.dict:
-            connector = self.dict["_remote_data"]["_content"]
-            res = connector.renameVar(key, newkey)
-            if not res:
-                return
-
         val = self.getVar(key, 0, parsing=True)
         if val is not None:
             self.varhistory.rename_variable_hist(key, newkey)
@@ -663,11 +638,6 @@ class DataSmart(MutableMapping):
 
     def delVar(self, var, **loginfo):
         self.expand_cache = {}
-        if '_remote_data' in self.dict:
-            connector = self.dict["_remote_data"]["_content"]
-            res = connector.delVar(var)
-            if not res:
-                return
 
         loginfo['detail'] = ""
         loginfo['op'] = 'del'
@@ -695,11 +665,6 @@ class DataSmart(MutableMapping):
 
     def setVarFlag(self, var, flag, value, **loginfo):
         self.expand_cache = {}
-        if '_remote_data' in self.dict:
-            connector = self.dict["_remote_data"]["_content"]
-            res = connector.setVarFlag(var, flag, value)
-            if not res:
-                return
 
         if 'op' not in loginfo:
             loginfo['op'] = "set"
@@ -850,11 +815,6 @@ class DataSmart(MutableMapping):
 
     def delVarFlag(self, var, flag, **loginfo):
         self.expand_cache = {}
-        if '_remote_data' in self.dict:
-            connector = self.dict["_remote_data"]["_content"]
-            res = connector.delVarFlag(var, flag)
-            if not res:
-                return
 
         local_var, _ = self._findVar(var)
         if not local_var:
@@ -972,7 +932,7 @@ class DataSmart(MutableMapping):
 
     def localkeys(self):
         for key in self.dict:
-            if key not in ['_data', '_remote_data']:
+            if key not in ['_data']:
                 yield key
 
     def __iter__(self):
@@ -981,7 +941,7 @@ class DataSmart(MutableMapping):
         def keylist(d):        
             klist = set()
             for key in d:
-                if key in ["_data", "_remote_data"]:
+                if key in ["_data"]:
                     continue
                 if key in deleted:
                     continue
@@ -995,13 +955,6 @@ class DataSmart(MutableMapping):
             if "_data" in d:
                 klist |= keylist(d["_data"])
 
-            if "_remote_data" in d:
-                connector = d["_remote_data"]["_content"]
-                for key in connector.getKeys():
-                    if key in deleted:
-                        continue
-                    klist.add(key)
-
             return klist
 
         self.need_overrides()
diff --git a/lib/bb/remotedata.py b/lib/bb/remotedata.py
index 7391e1b45c..7ed5169013 100644
--- a/lib/bb/remotedata.py
+++ b/lib/bb/remotedata.py
@@ -17,16 +17,14 @@ class RemoteDatastores:
         self.cooker = cooker
         self.datastores = {}
         self.locked = []
+        self.datastores[0] = self.cooker.data
         self.nextindex = 1
 
     def __len__(self):
         return len(self.datastores)
 
     def __getitem__(self, key):
-        if key is None:
-            return self.cooker.data
-        else:
-            return self.datastores[key]
+        return self.datastores[key]
 
     def items(self):
         return self.datastores.items()
@@ -63,44 +61,3 @@ class RemoteDatastores:
             raise Exception('Tried to release locked datastore %d' % idx)
         del self.datastores[idx]
 
-    def receive_datastore(self, remote_data):
-        """Receive a datastore object sent from the client (as prepared by transmit_datastore())"""
-        dct = dict(remote_data)
-        d = bb.data_smart.DataSmart()
-        d.dict = dct
-        while True:
-            if '_remote_data' in dct:
-                dsindex = dct['_remote_data']['_content']
-                del dct['_remote_data']
-                if dsindex is None:
-                    dct['_data'] = self.cooker.data.dict
-                else:
-                    dct['_data'] = self.datastores[dsindex].dict
-                break
-            elif '_data' in dct:
-                idct = dict(dct['_data'])
-                dct['_data'] = idct
-                dct = idct
-            else:
-                break
-        return d
-
-    @staticmethod
-    def transmit_datastore(d):
-        """Prepare a datastore object for sending over IPC from the client end"""
-        # FIXME content might be a dict, need to turn that into a list as well
-        def copy_dicts(dct):
-            if '_remote_data' in dct:
-                dsindex = dct['_remote_data']['_content'].dsindex
-                newdct = dct.copy()
-                newdct['_remote_data'] = {'_content': dsindex}
-                return list(newdct.items())
-            elif '_data' in dct:
-                newdct = dct.copy()
-                newdata = copy_dicts(dct['_data'])
-                if newdata:
-                    newdct['_data'] = newdata
-                return list(newdct.items())
-            return None
-        main_dict = copy_dicts(d.dict)
-        return main_dict
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 3e49984c93..2b137706dd 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -544,142 +544,3 @@ class Serialize(unittest.TestCase):
         self.assertEqual(newd.getVarFlag('HELLO', 'other'), 'planet')
 
 
-# Remote datastore tests
-# These really only test the interface, since in actual usage we have a
-# tinfoil connector that does everything over RPC, and this doesn't test
-# that.
-
-class TestConnector:
-    d = None
-    def __init__(self, d):
-        self.d = d
-    def getVar(self, name):
-        return self.d._findVar(name)
-    def getKeys(self):
-        return set(self.d.keys())
-    def getVarHistory(self, name):
-        return self.d.varhistory.variable(name)
-    def expandPythonRef(self, varname, expr, d):
-        localdata = self.d.createCopy()
-        for key in d.localkeys():
-            localdata.setVar(d.getVar(key))
-        varparse = bb.data_smart.VariableParse(varname, localdata)
-        return varparse.python_sub(expr)
-    def setVar(self, name, value):
-        self.d.setVar(name, value)
-    def setVarFlag(self, name, flag, value):
-        self.d.setVarFlag(name, flag, value)
-    def delVar(self, name):
-        self.d.delVar(name)
-        return False
-    def delVarFlag(self, name, flag):
-        self.d.delVarFlag(name, flag)
-        return False
-    def renameVar(self, name, newname):
-        self.d.renameVar(name, newname)
-        return False
-
-class Remote(unittest.TestCase):
-    def test_remote(self):
-
-        d1 = bb.data.init()
-        d1.enableTracking()
-        d2 = bb.data.init()
-        d2.enableTracking()
-        connector = TestConnector(d1)
-
-        d2.setVar('_remote_data', connector)
-
-        d1.setVar('HELLO', 'world')
-        d1.setVarFlag('OTHER', 'flagname', 'flagvalue')
-        self.assertEqual(d2.getVar('HELLO'), 'world')
-        self.assertEqual(d2.expand('${HELLO}'), 'world')
-        self.assertEqual(d2.expand('${@d.getVar("HELLO")}'), 'world')
-        self.assertIn('flagname', d2.getVarFlags('OTHER'))
-        self.assertEqual(d2.getVarFlag('OTHER', 'flagname'), 'flagvalue')
-        self.assertEqual(d1.varhistory.variable('HELLO'), d2.varhistory.variable('HELLO'))
-        # Test setVar on client side affects server
-        d2.setVar('HELLO', 'other-world')
-        self.assertEqual(d1.getVar('HELLO'), 'other-world')
-        # Test setVarFlag on client side affects server
-        d2.setVarFlag('HELLO', 'flagname', 'flagvalue')
-        self.assertEqual(d1.getVarFlag('HELLO', 'flagname'), 'flagvalue')
-        # Test client side data is incorporated in python expansion (which is done on server)
-        d2.setVar('FOO', 'bar')
-        self.assertEqual(d2.expand('${@d.getVar("FOO")}'), 'bar')
-        # Test overrides work
-        d1.setVar('FOO_test', 'baz')
-        d1.appendVar('OVERRIDES', ':test')
-        self.assertEqual(d2.getVar('FOO'), 'baz')
-
-
-# Remote equivalents of local test classes
-# Note that these aren't perfect since we only test in one direction
-
-class RemoteDataExpansions(DataExpansions):
-    def setUp(self):
-        self.d1 = bb.data.init()
-        self.d = bb.data.init()
-        self.d1["foo"] = "value_of_foo"
-        self.d1["bar"] = "value_of_bar"
-        self.d1["value_of_foo"] = "value_of_'value_of_foo'"
-        connector = TestConnector(self.d1)
-        self.d.setVar('_remote_data', connector)
-
-class TestRemoteNestedExpansions(TestNestedExpansions):
-    def setUp(self):
-        self.d1 = bb.data.init()
-        self.d = bb.data.init()
-        self.d1["foo"] = "foo"
-        self.d1["bar"] = "bar"
-        self.d1["value_of_foobar"] = "187"
-        connector = TestConnector(self.d1)
-        self.d.setVar('_remote_data', connector)
-
-class TestRemoteConcat(TestConcat):
-    def setUp(self):
-        self.d1 = bb.data.init()
-        self.d = bb.data.init()
-        self.d1.setVar("FOO", "foo")
-        self.d1.setVar("VAL", "val")
-        self.d1.setVar("BAR", "bar")
-        connector = TestConnector(self.d1)
-        self.d.setVar('_remote_data', connector)
-
-class TestRemoteConcatOverride(TestConcatOverride):
-    def setUp(self):
-        self.d1 = bb.data.init()
-        self.d = bb.data.init()
-        self.d1.setVar("FOO", "foo")
-        self.d1.setVar("VAL", "val")
-        self.d1.setVar("BAR", "bar")
-        connector = TestConnector(self.d1)
-        self.d.setVar('_remote_data', connector)
-
-class TestRemoteOverrides(TestOverrides):
-    def setUp(self):
-        self.d1 = bb.data.init()
-        self.d = bb.data.init()
-        self.d1.setVar("OVERRIDES", "foo:bar:local")
-        self.d1.setVar("TEST", "testvalue")
-        connector = TestConnector(self.d1)
-        self.d.setVar('_remote_data', connector)
-
-class TestRemoteKeyExpansion(TestKeyExpansion):
-    def setUp(self):
-        self.d1 = bb.data.init()
-        self.d = bb.data.init()
-        self.d1.setVar("FOO", "foo")
-        self.d1.setVar("BAR", "foo")
-        connector = TestConnector(self.d1)
-        self.d.setVar('_remote_data', connector)
-
-class TestRemoteFlags(TestFlags):
-    def setUp(self):
-        self.d1 = bb.data.init()
-        self.d = bb.data.init()
-        self.d1.setVar("foo", "value of foo")
-        self.d1.setVarFlag("foo", "flag1", "value of flag1")
-        self.d1.setVarFlag("foo", "flag2", "value of flag2")
-        connector = TestConnector(self.d1)
-        self.d.setVar('_remote_data', connector)
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 70b381e351..89ba9fc461 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -13,6 +13,7 @@ import sys
 import atexit
 import re
 from collections import OrderedDict, defaultdict
+from functools import partial
 
 import bb.cache
 import bb.cooker
@@ -44,66 +45,67 @@ class TinfoilUIException(Exception):
 class TinfoilCommandFailed(Exception):
     """Exception raised when run_command fails"""
 
+class TinfoilDataStoreConnectorVarHistory:
+    def __init__(self, tinfoil, dsindex):
+        self.tinfoil = tinfoil
+        self.dsindex = dsindex
+
+    def remoteCommand(self, cmd, *args, **kwargs):
+        return self.tinfoil.run_command('dataStoreConnectorVarHistCmd', self.dsindex, cmd, args, kwargs)
+
+    def __getattr__(self, name):
+        if not hasattr(bb.data_smart.VariableHistory, name):
+            raise AttributeError("VariableHistory has no such method %s" % name)
+
+        newfunc = partial(self.remoteCommand, name)
+        setattr(self, name, newfunc)
+        return newfunc
+
+class TinfoilDataStoreConnectorIncHistory:
+    def __init__(self, tinfoil, dsindex):
+        self.tinfoil = tinfoil
+        self.dsindex = dsindex
+
+    def remoteCommand(self, cmd, *args, **kwargs):
+        return self.tinfoil.run_command('dataStoreConnectorIncHistCmd', self.dsindex, cmd, args, kwargs)
+
+    def __getattr__(self, name):
+        if not hasattr(bb.data_smart.IncludeHistory, name):
+            raise AttributeError("IncludeHistory has no such method %s" % name)
+
+        newfunc = partial(self.remoteCommand, name)
+        setattr(self, name, newfunc)
+        return newfunc
+
 class TinfoilDataStoreConnector:
-    """Connector object used to enable access to datastore objects via tinfoil"""
+    """
+    Connector object used to enable access to datastore objects via tinfoil
+    Method calls are transmitted to the remote datastore for processing, if a datastore is
+    returned we return a connector object for the new store
+    """
 
     def __init__(self, tinfoil, dsindex):
         self.tinfoil = tinfoil
         self.dsindex = dsindex
-    def getVar(self, name):
-        value = self.tinfoil.run_command('dataStoreConnectorFindVar', self.dsindex, name)
-        overrides = None
-        if isinstance(value, dict):
-            if '_connector_origtype' in value:
-                value['_content'] = self.tinfoil._reconvert_type(value['_content'], value['_connector_origtype'])
-                del value['_connector_origtype']
-            if '_connector_overrides' in value:
-                overrides = value['_connector_overrides']
-                del value['_connector_overrides']
-        return value, overrides
-    def getKeys(self):
-        return set(self.tinfoil.run_command('dataStoreConnectorGetKeys', self.dsindex))
-    def getVarHistory(self, name):
-        return self.tinfoil.run_command('dataStoreConnectorGetVarHistory', self.dsindex, name)
-    def expandPythonRef(self, varname, expr, d):
-        ds = bb.remotedata.RemoteDatastores.transmit_datastore(d)
-        ret = self.tinfoil.run_command('dataStoreConnectorExpandPythonRef', ds, varname, expr)
+        self.varhistory = TinfoilDataStoreConnectorVarHistory(tinfoil, dsindex)
+        self.inchistory = TinfoilDataStoreConnectorIncHistory(tinfoil, dsindex)
+
+    def remoteCommand(self, cmd, *args, **kwargs):
+        #with open("/tmp/log", "a+") as f:
+        #    f.write("Here1 %s %s\n" % (args, kwargs))
+
+        ret = self.tinfoil.run_command('dataStoreConnectorCmd', self.dsindex, cmd, args, kwargs)
+        if isinstance(ret, bb.command.DataStoreConnectionHandle):
+            return TinfoilDataStoreConnector(self.tinfoil, ret.dsindex)
         return ret
-    def setVar(self, varname, value):
-        if self.dsindex is None:
-            self.tinfoil.run_command('setVariable', varname, value)
-        else:
-            # Not currently implemented - indicate that setting should
-            # be redirected to local side
-            return True
-    def setVarFlag(self, varname, flagname, value):
-        if self.dsindex is None:
-            self.tinfoil.run_command('dataStoreConnectorSetVarFlag', self.dsindex, varname, flagname, value)
-        else:
-            # Not currently implemented - indicate that setting should
-            # be redirected to local side
-            return True
-    def delVar(self, varname):
-        if self.dsindex is None:
-            self.tinfoil.run_command('dataStoreConnectorDelVar', self.dsindex, varname)
-        else:
-            # Not currently implemented - indicate that setting should
-            # be redirected to local side
-            return True
-    def delVarFlag(self, varname, flagname):
-        if self.dsindex is None:
-            self.tinfoil.run_command('dataStoreConnectorDelVar', self.dsindex, varname, flagname)
-        else:
-            # Not currently implemented - indicate that setting should
-            # be redirected to local side
-            return True
-    def renameVar(self, name, newname):
-        if self.dsindex is None:
-            self.tinfoil.run_command('dataStoreConnectorRenameVar', self.dsindex, name, newname)
-        else:
-            # Not currently implemented - indicate that setting should
-            # be redirected to local side
-            return True
+
+    def __getattr__(self, name):
+        if not hasattr(bb.data._dict_type, name):
+            raise AttributeError("Data store has no such method %s" % name)
+
+        newfunc = partial(self.remoteCommand, name)
+        setattr(self, name, newfunc)
+        return newfunc
 
 class TinfoilCookerAdapter:
     """
@@ -412,9 +414,7 @@ class Tinfoil:
                 self.run_actions(config_params)
                 self.recipes_parsed = True
 
-            self.config_data = bb.data.init()
-            connector = TinfoilDataStoreConnector(self, None)
-            self.config_data.setVar('_remote_data', connector)
+            self.config_data = TinfoilDataStoreConnector(self, 0)
             self.cooker = TinfoilCookerAdapter(self)
             self.cooker_data = self.cooker.recipecaches['']
         else:
@@ -842,9 +842,7 @@ class Tinfoil:
             newobj = origtype(obj)
 
         if isinstance(newobj, bb.command.DataStoreConnectionHandle):
-            connector = TinfoilDataStoreConnector(self, newobj.dsindex)
-            newobj = bb.data.init()
-            newobj.setVar('_remote_data', connector)
+            newobj = TinfoilDataStoreConnector(self, newobj.dsindex)
 
         return newobj
 
-- 
2.25.1

