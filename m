Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SWUPb-0001Je-Hj
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 17:20:44 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4LFAYxM024798
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 08:10:35 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Mon, 21 May 2012 08:10:34 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 May 2012 10:10:31 -0500
Message-ID: <8f414516a8e65bb78c24dcd88fe2640381ba85a2.1337612802.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1337612802.git.peter.seebach@windriver.com>
References: <cover.1337612802.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] data_smart.py: Provide (optional) logging of variable modifications
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 21 May 2012 15:20:44 -0000
Content-Type: text/plain

This is very preliminary, and probably not very good, but it
provides a much-wanted feature:  An explanation of how variables
got their current values.

How it works:

1.  We create a history dict in the data_smart object, the
members of which are lists of tuples.  It's three, count them,
THREE unrelated data types in a single object!
2.  There is an eventLog(...) function which allows recording
things which happen to variables.
3.  All over the place, tons of setVar and related functions
are updated with two optional arguments, filename and lineno.
4.  We log pretty much everything if logging is enabled.
5.  You can query the history of a thing with data.getHistory(var)

Tracking must be specifically turned on.  If it's not, the
history object is a single empty table (cheap) and the calls
to eventLog() and extra argument passing are also probably
quite cheap.  As a proof of concept, the showEnvironment function
used by bitbake -e now uses this if available.

Signed-off-by: Peter Seebach (peter.seebach@windriver.com)
---
 lib/bb/cooker.py     |    2 +
 lib/bb/data.py       |   49 +++++++++++++++++-------
 lib/bb/data_smart.py |  103 ++++++++++++++++++++++++++++++++++++++------------
 lib/bb/parse/ast.py  |   65 +++++++++++++++++--------------
 4 files changed, 152 insertions(+), 67 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index dea0aad..a3b2bd5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -825,6 +825,8 @@ class BBCooker:
 
     def parseConfigurationFiles(self, prefiles, postfiles):
         data = self.configuration.data
+        if self.configuration.show_environment:
+            data.enableTracking()
         bb.parse.init_parser(data)
 
         # Parse files for loading *before* bitbake.conf and any includes
diff --git a/lib/bb/data.py b/lib/bb/data.py
index c0636e1..aeb678c 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -74,14 +74,22 @@ def createCopy(source):
     """
     return source.createCopy()
 
+# These are used in dataSmart, here as protection against KeyErrors.
+def enableTracking():
+    pass
+
+def disableTracking():
+    pass
+
 def initVar(var, d):
     """Non-destructive var init for data structure"""
     d.initVar(var)
 
 
-def setVar(var, value, d):
+def setVar(var, value, d, filename = None, lineno = None):
     """Set a variable to a given value"""
-    d.setVar(var, value)
+    filename, lineno = d.infer_file_and_line(filename, lineno)
+    d.setVar(var, value, filename, lineno)
 
 
 def getVar(var, d, exp = 0):
@@ -89,27 +97,31 @@ def getVar(var, d, exp = 0):
     return d.getVar(var, exp)
 
 
-def renameVar(key, newkey, d):
+def renameVar(key, newkey, d, filename = None, lineno = None):
     """Renames a variable from key to newkey"""
-    d.renameVar(key, newkey)
+    filename, lineno = d.infer_file_and_line(filename, lineno)
+    d.renameVar(key, newkey, filename, lineno)
 
-def delVar(var, d):
+def delVar(var, d, filename = None, lineno = None):
     """Removes a variable from the data set"""
-    d.delVar(var)
+    filename, lineno = d.infer_file_and_line(filename, lineno)
+    d.delVar(var, filename, lineno)
 
-def setVarFlag(var, flag, flagvalue, d):
+def setVarFlag(var, flag, flagvalue, d, filename = None, lineno = None):
     """Set a flag for a given variable to a given value"""
-    d.setVarFlag(var, flag, flagvalue)
+    filename, lineno = d.infer_file_and_line(filename, lineno)
+    d.setVarFlag(var, flag, flagvalue, filename, lineno)
 
 def getVarFlag(var, flag, d):
     """Gets given flag from given var"""
     return d.getVarFlag(var, flag)
 
-def delVarFlag(var, flag, d):
+def delVarFlag(var, flag, d, filename = None, lineno = None):
     """Removes a given flag from the variable's flags"""
-    d.delVarFlag(var, flag)
+    filename, lineno = d.infer_file_and_line(filename, lineno)
+    d.delVarFlag(var, flag, filename, lineno)
 
-def setVarFlags(var, flags, d):
+def setVarFlags(var, flags, d, filename = None, lineno = None):
     """Set the flags for a given variable
 
     Note:
@@ -117,15 +129,17 @@ def setVarFlags(var, flags, d):
         flags. Think of this method as
         addVarFlags
     """
-    d.setVarFlags(var, flags)
+    filename, lineno = d.infer_file_and_line(filename, lineno)
+    d.setVarFlags(var, flags, filename, lineno)
 
 def getVarFlags(var, d):
     """Gets a variable's flags"""
     return d.getVarFlags(var)
 
-def delVarFlags(var, d):
+def delVarFlags(var, d, filename = None, lineno = None):
     """Removes a variable's flags"""
-    d.delVarFlags(var)
+    filename, lineno = d.infer_file_and_line(filename, lineno)
+    d.delVarFlags(var, filename, lineno)
 
 def keys(d):
     """Return a list of keys in d"""
@@ -195,6 +209,13 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
 
     if all:
         commentVal = re.sub('\n', '\n#', str(oval))
+        history = d.getHistory(var)
+        if history:
+            o.write('#\n# %s [%d]\n' % (var, len(history)))
+            for events in history:
+                events = (events[0], events[1], events[2], re.sub('\n', '\n#     ', str(events[3])))
+                o.write('#   %s %s:%s:\n#     <%s>\n' % events)
+            o.write('#\n')
         o.write('# %s=%s\n' % (var, commentVal))
 
     if (var.find("-") != -1 or var.find(".") != -1 or var.find('{') != -1 or var.find('}') != -1 or var.find('+') != -1) and not all:
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 27fb7d9..4a7b56c 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -28,6 +28,7 @@ BitBake build tools.
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
+import traceback
 import copy, re
 from collections import MutableMapping
 import logging
@@ -111,13 +112,30 @@ class ExpansionError(Exception):
 class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
         self.dict = {}
+        self.history = {}
 
         # cookie monster tribute
         self._special_values = special
         self._seen_overrides = seen
+        self._tracking_enabled = False
 
         self.expand_cache = {}
 
+    def tracking(self):
+        return self._tracking_enabled
+
+    def enableTracking(self):
+        self._tracking_enabled = True
+
+    def disableTracking(self):
+        self._tracking_enabled = False
+
+    def eventLog(self, var, event, value, filename = None, lineno = None):
+        if self._tracking_enabled:
+            if var not in self.history:
+                self.history[var] = []
+            self.history[var].append((event, filename, lineno, value))
+
     def expandWithRefs(self, s, varname):
 
         if not isinstance(s, basestring): # sanity check
@@ -150,6 +168,14 @@ class DataSmart(MutableMapping):
     def expand(self, s, varname = None):
         return self.expandWithRefs(s, varname).value
 
+    # Figure out how to describe the caller when file/line weren't
+    # specified.
+    def infer_file_and_line(self, filename, lineno):
+        details = lineno
+        if self._tracking_enabled and not filename:
+            filename, lineno, func, line = traceback.extract_stack(limit=3)[0]
+            details = "%d [%s]" % (lineno, func)
+        return filename, details
 
     def finalize(self):
         """Performs final steps upon the datastore, including application of overrides"""
@@ -183,10 +209,12 @@ class DataSmart(MutableMapping):
             for var in vars:
                 name = var[:-l]
                 try:
-                    self.setVar(name, self.getVar(var, False))
+                    for event in self.getHistory(var):
+                        self.eventLog(name, 'override:%s' % var, event[3], event[1], event[2])
+                    self.setVar(name, self.getVar(var, False), '${%s}' % var, 'N/A', 'override')
                     self.delVar(var)
-                except Exception:
-                    logger.info("Untracked delVar")
+                except Exception, e:
+                    logger.info("Untracked delVar %s: %s" % (var, e))
 
         # now on to the appends and prepends
         for op in __setvar_keyword__:
@@ -239,7 +267,8 @@ class DataSmart(MutableMapping):
         else:
             self.initVar(var)
 
-    def setVar(self, var, value):
+    def setVar(self, var, value, filename = None, lineno = None, op = 'set'):
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         self.expand_cache = {}
         match  = __setvar_regexp__.match(var)
         if match and match.group("keyword") in __setvar_keyword__:
@@ -248,7 +277,7 @@ class DataSmart(MutableMapping):
             override = match.group('add')
             l = self.getVarFlag(base, keyword) or []
             l.append([value, override])
-            self.setVarFlag(base, keyword, l)
+            self.setVarFlag(base, keyword, l, filename, lineno)
 
             # todo make sure keyword is not __doc__ or __module__
             # pay the cookie monster
@@ -257,6 +286,7 @@ class DataSmart(MutableMapping):
             except KeyError:
                 self._special_values[keyword] = set()
                 self._special_values[keyword].add( base )
+            self.eventLog(base, keyword, base, filename, lineno)
 
             return
 
@@ -273,6 +303,12 @@ class DataSmart(MutableMapping):
 
         # setting var
         self.dict[var]["content"] = value
+        self.eventLog(var, op, value, filename, lineno)
+
+    def getHistory(self, var):
+        if var in self.history:
+            return self.history[var]
+        return []
 
     def getVar(self, var, expand=False, noweakdefault=False):
         value = self.getVarFlag(var, "content", False, noweakdefault)
@@ -282,13 +318,14 @@ class DataSmart(MutableMapping):
             return self.expand(value, var)
         return value
 
-    def renameVar(self, key, newkey):
+    def renameVar(self, key, newkey, filename = None, lineno = None):
         """
         Rename the variable key to newkey
         """
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         val = self.getVar(key, 0)
         if val is not None:
-            self.setVar(newkey, val)
+            self.setVar(newkey, val, filename, lineno, 'rename-create')
 
         for i in ('_append', '_prepend'):
             src = self.getVarFlag(key, i)
@@ -297,34 +334,41 @@ class DataSmart(MutableMapping):
 
             dest = self.getVarFlag(newkey, i) or []
             dest.extend(src)
-            self.setVarFlag(newkey, i, dest)
+            self.setVarFlag(newkey, i, dest, filename, lineno, 'rename')
 
             if i in self._special_values and key in self._special_values[i]:
                 self._special_values[i].remove(key)
                 self._special_values[i].add(newkey)
 
-        self.delVar(key)
+        self.delVar(key, filename, lineno, 'rename-delete')
 
-    def appendVar(self, key, value):
+    def appendVar(self, key, value, filename = None, lineno = None):
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         value = (self.getVar(key, False) or "") + value
-        self.setVar(key, value)
+        self.setVar(key, value, filename, lineno, 'append')
 
-    def prependVar(self, key, value):
+    def prependVar(self, key, value, filename = None, lineno = None):
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         value = value + (self.getVar(key, False) or "")
-        self.setVar(key, value)
+        self.setVar(key, value, filename, lineno, 'prepend')
 
-    def delVar(self, var):
+    def delVar(self, var, filename = None, lineno = None, op = 'del'):
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         self.expand_cache = {}
         self.dict[var] = {}
+        self.eventLog(var, op, '', filename, lineno)
         if '_' in var:
             override = var[var.rfind('_')+1:]
             if override and override in self._seen_overrides and var in self._seen_overrides[override]:
                 self._seen_overrides[override].remove(var)
+                self.eventLog(var, 'del', '', filename, lineno)
 
-    def setVarFlag(self, var, flag, flagvalue):
+    def setVarFlag(self, var, flag, flagvalue, filename = None, lineno = None, op = 'set'):
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         if not var in self.dict:
             self._makeShadowCopy(var)
         self.dict[var][flag] = flagvalue
+        self.eventLog(var, '%s flag %s' % (op, flag), flagvalue, filename, lineno)
 
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
         local_var = self._findVar(var)
@@ -338,31 +382,37 @@ class DataSmart(MutableMapping):
             value = self.expand(value, None)
         return value
 
-    def delVarFlag(self, var, flag):
+    def delVarFlag(self, var, flag, filename = None, lineno = None):
         local_var = self._findVar(var)
         if not local_var:
             return
         if not var in self.dict:
             self._makeShadowCopy(var)
 
+        filename, lineno = self.infer_file_and_line(filename, lineno)
+        self.eventLog(var, 'del flag %s' % flag, '', filename, lineno)
         if var in self.dict and flag in self.dict[var]:
             del self.dict[var][flag]
 
-    def appendVarFlag(self, key, flag, value):
+    def appendVarFlag(self, key, flag, value, filename = None, lineno = None):
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         value = (self.getVarFlag(key, flag, False) or "") + value
-        self.setVarFlag(key, flag, value)
+        self.setVarFlag(key, flag, value, filename, lineno, 'append')
 
-    def prependVarFlag(self, key, flag, value):
+    def prependVarFlag(self, key, flag, value, filename = None, lineno = None):
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         value = value + (self.getVarFlag(key, flag, False) or "")
-        self.setVarFlag(key, flag, value)
+        self.setVarFlag(key, flag, value, filename, lineno, 'prepend')
 
-    def setVarFlags(self, var, flags):
+    def setVarFlags(self, var, flags, filename = None, lineno = None):
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         if not var in self.dict:
             self._makeShadowCopy(var)
 
         for i in flags:
             if i == "content":
                 continue
+            self.eventLog(var, 'set flag %s' % i, flags[i], filename, lineno)
             self.dict[var][i] = flags[i]
 
     def getVarFlags(self, var):
@@ -380,13 +430,15 @@ class DataSmart(MutableMapping):
         return flags
 
 
-    def delVarFlags(self, var):
+    def delVarFlags(self, var, filename = None, lineno = None):
         if not var in self.dict:
             self._makeShadowCopy(var)
 
         if var in self.dict:
             content = None
 
+            filename, lineno = self.infer_file_and_line(filename, lineno)
+            self.eventLog(var, 'clear all flags', '', filename, lineno)
             # try to save the content
             if "content" in self.dict[var]:
                 content  = self.dict[var]["content"]
@@ -403,10 +455,12 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
+        data.history = self.history.copy()
+        data._tracking_enabled = self._tracking_enabled
 
         return data
 
-    def expandVarref(self, variable, parents=False):
+    def expandVarref(self, variable, parents=False, filename = None, lineno = None):
         """Find all references to variable in the data and expand it
            in place, optionally descending to parent datastores."""
 
@@ -415,12 +469,13 @@ class DataSmart(MutableMapping):
         else:
             keys = self.localkeys()
 
+        filename, lineno = self.infer_file_and_line(filename, lineno)
         ref = '${%s}' % variable
         value = self.getVar(variable, False)
         for key in keys:
             referrervalue = self.getVar(key, False)
             if referrervalue and ref in referrervalue:
-                self.setVar(key, referrervalue.replace(ref, value))
+                self.setVar(key, referrervalue.replace(ref, value), filename, lineno, 'expandVarref')
 
     def localkeys(self):
         for key in self.dict:
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index eae840f..c81f617 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -69,7 +69,7 @@ class ExportNode(AstNode):
         self.var = var
 
     def eval(self, data):
-        data.setVarFlag(self.var, "export", 1)
+        data.setVarFlag(self.var, "export", 1, self.filename, self.lineno)
 
 class DataNode(AstNode):
     """
@@ -91,33 +91,40 @@ class DataNode(AstNode):
     def eval(self, data):
         groupd = self.groupd
         key = groupd["var"]
+        op = 'set'
         if "exp" in groupd and groupd["exp"] != None:
-            data.setVarFlag(key, "export", 1)
+            data.setVarFlag(key, "export", 1, self.filename, self.lineno)
         if "ques" in groupd and groupd["ques"] != None:
             val = self.getFunc(key, data)
             if val == None:
                 val = groupd["value"]
+                op = 'set?'
         elif "colon" in groupd and groupd["colon"] != None:
             e = data.createCopy()
             bb.data.update_data(e)
             val = e.expand(groupd["value"], key + "[:=]")
+            op = 'immediate'
         elif "append" in groupd and groupd["append"] != None:
             val = "%s %s" % ((self.getFunc(key, data) or ""), groupd["value"])
+            op = 'append'
         elif "prepend" in groupd and groupd["prepend"] != None:
             val = "%s %s" % (groupd["value"], (self.getFunc(key, data) or ""))
+            op = 'prepend'
         elif "postdot" in groupd and groupd["postdot"] != None:
             val = "%s%s" % ((self.getFunc(key, data) or ""), groupd["value"])
+            op = 'postdot'
         elif "predot" in groupd and groupd["predot"] != None:
             val = "%s%s" % (groupd["value"], (self.getFunc(key, data) or ""))
+            op = 'predot'
         else:
             val = groupd["value"]
 
         if 'flag' in groupd and groupd['flag'] != None:
-            data.setVarFlag(key, groupd['flag'], val)
+            data.setVarFlag(key, groupd['flag'], val, self.filename, self.lineno, op)
         elif groupd["lazyques"]:
-            data.setVarFlag(key, "defaultval", val)
+            data.setVarFlag(key, "defaultval", val, self.filename, self.lineno, op)
         else:
-            data.setVar(key, val)
+            data.setVar(key, val, self.filename, self.lineno, op)
 
 class MethodNode(AstNode):
     def __init__(self, filename, lineno, func_name, body):
@@ -133,10 +140,10 @@ class MethodNode(AstNode):
                 bb.methodpool.insert_method(funcname, text, self.filename)
             anonfuncs = data.getVar('__BBANONFUNCS') or []
             anonfuncs.append(funcname)
-            data.setVar('__BBANONFUNCS', anonfuncs)
+            data.setVar('__BBANONFUNCS', anonfuncs, self.filename, self.lineno)
         else:
-            data.setVarFlag(self.func_name, "func", 1)
-            data.setVar(self.func_name, '\n'.join(self.body))
+            data.setVarFlag(self.func_name, "func", 1, self.filename, self.lineno)
+            data.setVar(self.func_name, '\n'.join(self.body), self.filename, self.lineno)
 
 class PythonMethodNode(AstNode):
     def __init__(self, filename, lineno, function, define, body):
@@ -152,9 +159,9 @@ class PythonMethodNode(AstNode):
         text = '\n'.join(self.body)
         if not bb.methodpool.parsed_module(self.define):
             bb.methodpool.insert_method(self.define, text, self.filename)
-        data.setVarFlag(self.function, "func", 1)
-        data.setVarFlag(self.function, "python", 1)
-        data.setVar(self.function, text)
+        data.setVarFlag(self.function, "func", 1, self.filename, self.lineno)
+        data.setVarFlag(self.function, "python", 1, self.filename, self.lineno)
+        data.setVar(self.function, text, self.filename, self.lineno)
 
 class MethodFlagsNode(AstNode):
     def __init__(self, filename, lineno, key, m):
@@ -166,16 +173,16 @@ class MethodFlagsNode(AstNode):
         if data.getVar(self.key):
             # clean up old version of this piece of metadata, as its
             # flags could cause problems
-            data.setVarFlag(self.key, 'python', None)
-            data.setVarFlag(self.key, 'fakeroot', None)
+            data.setVarFlag(self.key, 'python', None, self.filename, self.lineno)
+            data.setVarFlag(self.key, 'fakeroot', None, self.filename, self.lineno)
         if self.m.group("py") is not None:
-            data.setVarFlag(self.key, "python", "1")
+            data.setVarFlag(self.key, "python", "1", self.filename, self.lineno)
         else:
-            data.delVarFlag(self.key, "python")
+            data.delVarFlag(self.key, "python", self.filename, self.lineno)
         if self.m.group("fr") is not None:
-            data.setVarFlag(self.key, "fakeroot", "1")
+            data.setVarFlag(self.key, "fakeroot", "1", self.filename, self.lineno)
         else:
-            data.delVarFlag(self.key, "fakeroot")
+            data.delVarFlag(self.key, "fakeroot", self.filename, self.lineno)
 
 class ExportFuncsNode(AstNode):
     def __init__(self, filename, lineno, fns, classes):
@@ -201,21 +208,21 @@ class ExportFuncsNode(AstNode):
                     continue
 
                 if data.getVar(var):
-                    data.setVarFlag(var, 'python', None)
-                    data.setVarFlag(var, 'func', None)
+                    data.setVarFlag(var, 'python', None, self.filename, self.lineno)
+                    data.setVarFlag(var, 'func', None, self.filename, self.lineno)
 
                 for flag in [ "func", "python" ]:
                     if data.getVarFlag(calledvar, flag):
-                        data.setVarFlag(var, flag, data.getVarFlag(calledvar, flag))
+                        data.setVarFlag(var, flag, data.getVarFlag(calledvar, flag), self.filename, self.lineno)
                 for flag in [ "dirs" ]:
                     if data.getVarFlag(var, flag):
-                        data.setVarFlag(calledvar, flag, data.getVarFlag(var, flag))
+                        data.setVarFlag(calledvar, flag, data.getVarFlag(var, flag), self.filename, self.lineno)
 
                 if data.getVarFlag(calledvar, "python"):
-                    data.setVar(var, "\tbb.build.exec_func('" + calledvar + "', d)\n")
+                    data.setVar(var, "\tbb.build.exec_func('" + calledvar + "', d)\n", self.filename, self.lineno)
                 else:
-                    data.setVar(var, "\t" + calledvar + "\n")
-                data.setVarFlag(var, 'export_func', '1')
+                    data.setVar(var, "\t" + calledvar + "\n", self.filename, self.lineno)
+                data.setVarFlag(var, 'export_func', '1', self.filename, self.lineno)
 
 class AddTaskNode(AstNode):
     def __init__(self, filename, lineno, func, before, after):
@@ -229,11 +236,11 @@ class AddTaskNode(AstNode):
         if self.func[:3] != "do_":
             var = "do_" + self.func
 
-        data.setVarFlag(var, "task", 1)
+        data.setVarFlag(var, "task", 1, self.filename, self.lineno)
         bbtasks = data.getVar('__BBTASKS') or []
         if not var in bbtasks:
             bbtasks.append(var)
-        data.setVar('__BBTASKS', bbtasks)
+        data.setVar('__BBTASKS', bbtasks, self.filename, self.lineno)
 
         existing = data.getVarFlag(var, "deps") or []
         if self.after is not None:
@@ -241,13 +248,13 @@ class AddTaskNode(AstNode):
             for entry in self.after.split():
                 if entry not in existing:
                     existing.append(entry)
-        data.setVarFlag(var, "deps", existing)
+        data.setVarFlag(var, "deps", existing, self.filename, self.lineno)
         if self.before is not None:
             # set up things that depend on this func
             for entry in self.before.split():
                 existing = data.getVarFlag(entry, "deps") or []
                 if var not in existing:
-                    data.setVarFlag(entry, "deps", [var] + existing)
+                    data.setVarFlag(entry, "deps", [var] + existing, self.filename, self.lineno)
 
 class BBHandlerNode(AstNode):
     def __init__(self, filename, lineno, fns):
@@ -258,7 +265,7 @@ class BBHandlerNode(AstNode):
         bbhands = data.getVar('__BBHANDLERS') or []
         for h in self.hs:
             bbhands.append(h)
-            data.setVarFlag(h, "handler", 1)
+            data.setVarFlag(h, "handler", 1, self.filename, self.lineno)
         data.setVar('__BBHANDLERS', bbhands)
 
 class InheritNode(AstNode):
-- 
1.7.0.4



