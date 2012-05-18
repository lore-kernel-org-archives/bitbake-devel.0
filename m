Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SVR7b-0008UX-OP
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 May 2012 19:37:48 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4IHRg3L025924
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 May 2012 10:27:42 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 18 May 2012 10:27:41 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 May 2012 12:27:39 -0500
Message-ID: <c46dd7e0f30c447a10df5a50c92217150e434996.1337361285.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1337361285.git.peter.seebach@windriver.com>
References: <cover.1337361285.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [RFC PATCH 1/2] data_smart.py: Provide (optional) logging of variable modifications
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
X-List-Received-Date: Fri, 18 May 2012 17:37:48 -0000
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
 lib/bb/cooker.py                   |    4 +-
 lib/bb/data.py                     |   30 +++++++++---
 lib/bb/data_smart.py               |   91 ++++++++++++++++++++++++-----------
 lib/bb/parse/__init__.py           |    2 +-
 lib/bb/parse/ast.py                |   89 +++++++++++++++++++----------------
 lib/bb/parse/parse_py/BBHandler.py |    8 ++--
 lib/bb/siggen.py                   |    2 +-
 7 files changed, 141 insertions(+), 85 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index dea0aad..76104ef 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -825,6 +825,8 @@ class BBCooker:
 
     def parseConfigurationFiles(self, prefiles, postfiles):
         data = self.configuration.data
+        if self.configuration.show_environment:
+            data.enableTracking()
         bb.parse.init_parser(data)
 
         # Parse files for loading *before* bitbake.conf and any includes
@@ -871,7 +873,7 @@ class BBCooker:
         bb.codeparser.parser_cache_init(data)
         bb.event.fire(bb.event.ConfigParsed(), data)
         bb.parse.init_parser(data)
-        data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
+        data.setVar('BBINCLUDED',bb.parse.get_file_depends(data), 'cooker.py', 'N/A')
         self.configuration.data = data
         self.configuration.data_hash = data.get_hash()
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index c0636e1..74efc5d 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -74,14 +74,21 @@ def createCopy(source):
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
+def setVar(var, value, d, filename = 'unknown', lineno = 'N/A'):
     """Set a variable to a given value"""
-    d.setVar(var, value)
+    d.setVar(var, value, filename, lineno)
 
 
 def getVar(var, d, exp = 0):
@@ -89,17 +96,17 @@ def getVar(var, d, exp = 0):
     return d.getVar(var, exp)
 
 
-def renameVar(key, newkey, d):
+def renameVar(key, newkey, d, filename = 'unknown', lineno = 'N/A'):
     """Renames a variable from key to newkey"""
-    d.renameVar(key, newkey)
+    d.renameVar(key, newkey, filename, lineno)
 
-def delVar(var, d):
+def delVar(var, d, filename = 'unknown', lineno = 'N/A'):
     """Removes a variable from the data set"""
-    d.delVar(var)
+    d.delVar(var, filename, lineno)
 
-def setVarFlag(var, flag, flagvalue, d):
+def setVarFlag(var, flag, flagvalue, d, filename = 'unknown', lineno = 'N/A'):
     """Set a flag for a given variable to a given value"""
-    d.setVarFlag(var, flag, flagvalue)
+    d.setVarFlag(var, flag, flagvalue, filename, lineno)
 
 def getVarFlag(var, flag, d):
     """Gets given flag from given var"""
@@ -195,6 +202,13 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
 
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
index 27fb7d9..8c70b3b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -111,13 +111,30 @@ class ExpansionError(Exception):
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
+    def eventLog(self, var, event, value, filename = 'unknown', lineno = '??'):
+        if self._tracking_enabled:
+            if var not in self.history:
+                self.history[var] = []
+            self.history[var].append((event, filename, lineno, value))
+
     def expandWithRefs(self, s, varname):
 
         if not isinstance(s, basestring): # sanity check
@@ -183,15 +200,18 @@ class DataSmart(MutableMapping):
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
             if op in self._special_values:
                 appends = self._special_values[op] or []
+
                 for append in appends:
                     keep = []
                     for (a, o) in self.getVarFlag(append, op) or []:
@@ -202,16 +222,16 @@ class DataSmart(MutableMapping):
                         if op == "_append":
                             sval = self.getVar(append, False) or ""
                             sval += a
-                            self.setVar(append, sval)
+                            self.setVar(append, sval, '[appends]', 'N/A')
                         elif op == "_prepend":
                             sval = a + (self.getVar(append, False) or "")
-                            self.setVar(append, sval)
+                            self.setVar(append, sval, '[prepends]', 'N/A')
 
                     # We save overrides that may be applied at some later stage
                     if keep:
-                        self.setVarFlag(append, op, keep)
+                        self.setVarFlag(append, op, keep, 'unknown', 'N/A', 'keep_overrides')
                     else:
-                        self.delVarFlag(append, op)
+                        self.delVarFlag(append, op, 'unknown', 'N/A')
 
     def initVar(self, var):
         self.expand_cache = {}
@@ -239,7 +259,7 @@ class DataSmart(MutableMapping):
         else:
             self.initVar(var)
 
-    def setVar(self, var, value):
+    def setVar(self, var, value, filename = 'unknown', lineno = '???', op = 'set'):
         self.expand_cache = {}
         match  = __setvar_regexp__.match(var)
         if match and match.group("keyword") in __setvar_keyword__:
@@ -248,7 +268,7 @@ class DataSmart(MutableMapping):
             override = match.group('add')
             l = self.getVarFlag(base, keyword) or []
             l.append([value, override])
-            self.setVarFlag(base, keyword, l)
+            self.setVarFlag(base, keyword, l, filename, lineno)
 
             # todo make sure keyword is not __doc__ or __module__
             # pay the cookie monster
@@ -257,6 +277,7 @@ class DataSmart(MutableMapping):
             except KeyError:
                 self._special_values[keyword] = set()
                 self._special_values[keyword].add( base )
+            self.eventLog(base, keyword, base, filename, lineno)
 
             return
 
@@ -273,6 +294,12 @@ class DataSmart(MutableMapping):
 
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
@@ -282,13 +309,13 @@ class DataSmart(MutableMapping):
             return self.expand(value, var)
         return value
 
-    def renameVar(self, key, newkey):
+    def renameVar(self, key, newkey, filename = 'unknown', lineno = '???'):
         """
         Rename the variable key to newkey
         """
         val = self.getVar(key, 0)
         if val is not None:
-            self.setVar(newkey, val)
+            self.setVar(newkey, val, filename, lineno, 'rename-create')
 
         for i in ('_append', '_prepend'):
             src = self.getVarFlag(key, i)
@@ -297,34 +324,37 @@ class DataSmart(MutableMapping):
 
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
+    def appendVar(self, key, value, filename = 'unknown', lineno = '???'):
         value = (self.getVar(key, False) or "") + value
-        self.setVar(key, value)
+        self.setVar(key, value, filename, lineno, 'append')
 
-    def prependVar(self, key, value):
+    def prependVar(self, key, value, filename = 'unknown', lineno = '???'):
         value = value + (self.getVar(key, False) or "")
-        self.setVar(key, value)
+        self.setVar(key, value, filename, lineno, 'prepend')
 
-    def delVar(self, var):
+    def delVar(self, var, filename = 'unknown', lineno = '???', op = 'del'):
         self.expand_cache = {}
         self.dict[var] = {}
+        self.eventLog(var, op, '', filename, lineno)
         if '_' in var:
             override = var[var.rfind('_')+1:]
             if override and override in self._seen_overrides and var in self._seen_overrides[override]:
                 self._seen_overrides[override].remove(var)
+                self.eventLog(var, 'del', '', filename, lineno)
 
-    def setVarFlag(self, var, flag, flagvalue):
+    def setVarFlag(self, var, flag, flagvalue, filename = 'unknown', lineno = '???', op = 'set'):
         if not var in self.dict:
             self._makeShadowCopy(var)
         self.dict[var][flag] = flagvalue
+        self.eventLog(var, '%s flag %s' % (op, flag), flagvalue, filename, lineno)
 
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
         local_var = self._findVar(var)
@@ -338,25 +368,26 @@ class DataSmart(MutableMapping):
             value = self.expand(value, None)
         return value
 
-    def delVarFlag(self, var, flag):
+    def delVarFlag(self, var, flag, filename = 'unknown', lineno = '???'):
         local_var = self._findVar(var)
         if not local_var:
             return
         if not var in self.dict:
             self._makeShadowCopy(var)
 
+        self.eventLog(var, 'del flag %s' % flag, '', filename, lineno)
         if var in self.dict and flag in self.dict[var]:
             del self.dict[var][flag]
 
-    def appendVarFlag(self, key, flag, value):
+    def appendVarFlag(self, key, flag, value, filename = 'unknown', lineno = '???'):
         value = (self.getVarFlag(key, flag, False) or "") + value
-        self.setVarFlag(key, flag, value)
+        self.setVarFlag(key, flag, value, filename, lineno, 'append')
 
-    def prependVarFlag(self, key, flag, value):
+    def prependVarFlag(self, key, flag, value, filename = 'unknown', lineno = '???'):
         value = value + (self.getVarFlag(key, flag, False) or "")
-        self.setVarFlag(key, flag, value)
+        self.setVarFlag(key, flag, value, filename, lineno, 'prepend')
 
-    def setVarFlags(self, var, flags):
+    def setVarFlags(self, var, flags, filename = 'unknown', lineno = '???'):
         if not var in self.dict:
             self._makeShadowCopy(var)
 
@@ -403,10 +434,12 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
+        data.history = self.history.copy()
+        data._tracking_enabled = self._tracking_enabled
 
         return data
 
-    def expandVarref(self, variable, parents=False):
+    def expandVarref(self, variable, parents=False, filename = 'unknown', lineno = '???'):
         """Find all references to variable in the data and expand it
            in place, optionally descending to parent datastores."""
 
@@ -420,7 +453,7 @@ class DataSmart(MutableMapping):
         for key in keys:
             referrervalue = self.getVar(key, False)
             if referrervalue and ref in referrervalue:
-                self.setVar(key, referrervalue.replace(ref, value))
+                self.setVar(key, referrervalue.replace(ref, value), filename, lineno, 'expandVarref')
 
     def localkeys(self):
         for key in self.dict:
@@ -456,10 +489,10 @@ class DataSmart(MutableMapping):
             return value
 
     def __setitem__(self, var, value):
-        self.setVar(var, value)
+        self.setVar(var, value, '__setitem__', '???')
 
     def __delitem__(self, var):
-        self.delVar(var)
+        self.delVar(var, '__delitem__', '???')
 
     def get_hash(self):
         data = {}
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 7b9c47e..3c3feee 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -75,7 +75,7 @@ def mark_dependency(d, f):
         f = "%s/%s" % (os.getcwd(), f[2:])
     deps = d.getVar('__depends') or set()
     deps.update([(f, cached_mtime(f))])
-    d.setVar('__depends', deps)
+    d.setVar('__depends', deps, f, 'N/A')
 
 def supports(fn, data):
     """Returns true if we have a handler for this file, false otherwise"""
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index eae840f..dc47437 100644
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
@@ -328,7 +335,7 @@ def finalize(fn, d, variant = None):
 
     bb.parse.siggen.finalise(fn, d, variant)
 
-    d.setVar('BBINCLUDED', bb.parse.get_file_depends(d))
+    d.setVar('BBINCLUDED', bb.parse.get_file_depends(d), 'ast.py', 'N/A')
 
     bb.event.fire(bb.event.RecipeParsed(fn), d)
 
@@ -380,7 +387,7 @@ def multi_finalize(fn, d):
     try:
         finalize(fn, d)
     except bb.parse.SkipPackage as e:
-        d.setVar("__SKIPPED", e.args[0])
+        d.setVar("__SKIPPED", e.args[0], 'ast.py', 'N/A')
     datastores = {"": safe_d}
 
     versions = (d.getVar("BBVERSIONS", True) or "").split()
@@ -393,12 +400,12 @@ def multi_finalize(fn, d):
                 pv_d = d
 
             overrides = d.getVar("OVERRIDES", True).split(":")
-            pv_d.setVar("PV", ver)
+            pv_d.setVar("PV", ver, 'ast.py', 'N/A')
             overrides.append(ver)
             bpv = baseversions.get(ver) or orig_pv
-            pv_d.setVar("BPV", bpv)
+            pv_d.setVar("BPV", bpv, 'ast.py', 'N/A')
             overrides.append(bpv)
-            d.setVar("OVERRIDES", ":".join(overrides))
+            d.setVar("OVERRIDES", ":".join(overrides), 'ast.py', 'N/A')
 
         versions = list(_expand_versions(versions))
         for pos, version in enumerate(list(versions)):
@@ -423,7 +430,7 @@ def multi_finalize(fn, d):
             try:
                 finalize(fn, d)
             except bb.parse.SkipPackage as e:
-                d.setVar("__SKIPPED", e.args[0])
+                d.setVar("__SKIPPED", e.args[0], 'ast.py', 'N/A')
 
         _create_variants(datastores, versions, verfunc)
 
@@ -448,13 +455,13 @@ def multi_finalize(fn, d):
         pn = d.getVar("PN", True)
         def extendfunc(name, d):
             if name != extendedmap[name]:
-                d.setVar("BBEXTENDCURR", extendedmap[name])
-                d.setVar("BBEXTENDVARIANT", variantmap[name])
+                d.setVar("BBEXTENDCURR", extendedmap[name], 'ast.py', 'N/A')
+                d.setVar("BBEXTENDVARIANT", variantmap[name], 'ast.py', 'N/A')
             else:
-                d.setVar("PN", "%s-%s" % (pn, name))
+                d.setVar("PN", "%s-%s" % (pn, name), 'ast.py', 'N/A')
             bb.parse.BBHandler.inherit(extendedmap[name], fn, 0, d)
 
-        safe_d.setVar("BBCLASSEXTEND", extended)
+        safe_d.setVar("BBCLASSEXTEND", extended, 'ast.py', 'N/A')
         _create_variants(datastores, extendedmap.keys(), extendfunc)
 
     for variant, variant_d in datastores.iteritems():
@@ -463,11 +470,11 @@ def multi_finalize(fn, d):
                 if not onlyfinalise or variant in onlyfinalise:
                     finalize(fn, variant_d, variant)
             except bb.parse.SkipPackage as e:
-                variant_d.setVar("__SKIPPED", e.args[0])
+                variant_d.setVar("__SKIPPED", e.args[0], 'ast.py', 'N/A')
 
     if len(datastores) > 1:
         variants = filter(None, datastores.iterkeys())
-        safe_d.setVar("__VARIANTS", " ".join(variants))
+        safe_d.setVar("__VARIANTS", " ".join(variants), 'ast.py', 'N/A')
 
     datastores[""] = d
     return datastores
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 815bce1..44d7a82 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -78,7 +78,7 @@ def inherit(files, fn, lineno, d):
         if not file in __inherit_cache:
             logger.log(logging.DEBUG -1, "BB %s:%d: inheriting %s", fn, lineno, file)
             __inherit_cache.append( file )
-            data.setVar('__inherit_cache', __inherit_cache, d)
+            data.setVar('__inherit_cache', __inherit_cache, d, fn, lineno)
             include(fn, file, lineno, d, "inherit")
             __inherit_cache = data.getVar('__inherit_cache', d) or []
 
@@ -129,7 +129,7 @@ def handle(fn, d, include):
         __inherit_cache = data.getVar('__inherit_cache', d) or []
         if not fn in __inherit_cache:
             __inherit_cache.append(fn)
-            data.setVar('__inherit_cache', __inherit_cache, d)
+            data.setVar('__inherit_cache', __inherit_cache, d, fn, 'N/A')
 
     if include != 0:
         oldfile = data.getVar('FILE', d)
@@ -146,7 +146,7 @@ def handle(fn, d, include):
 
     # DONE WITH PARSING... time to evaluate
     if ext != ".bbclass":
-        data.setVar('FILE', abs_fn, d)
+        data.setVar('FILE', abs_fn, d, fn, 'N/A')
 
     statements.eval(d)
 
@@ -157,7 +157,7 @@ def handle(fn, d, include):
             return ast.multi_finalize(fn, d)
 
     if oldfile:
-        d.setVar("FILE", oldfile)
+        d.setVar("FILE", oldfile, fn, 'N/A')
 
     # we have parsed the bb class now
     if ext == ".bbclass" or ext == ".inc":
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 5a0b80e..d1babf1 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -137,7 +137,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #    self.dump_sigtask(fn, task, d.getVar("STAMP", True), False)
 
         for task in taskdeps:
-            d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + "." + task])
+            d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + "." + task], 'siggen.py', 'N/A')
 
     def rundep_check(self, fn, recipename, task, dep, depname, dataCache):
         # Return True if we should keep the dependency, False to drop it
-- 
1.7.0.4



