Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SQ1Wz-0000Cl-2f
	for bitbake-devel@lists.openembedded.org;
	Thu, 03 May 2012 21:17:37 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q43ILtbA025821
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 May 2012 11:21:55 -0700 (PDT)
Received: from wrlaptop (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 3 May 2012 11:21:54 -0700
Date: Thu, 3 May 2012 13:21:27 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Message-ID: <20120503132127.1cc1b29a@wrlaptop>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Subject: Bitbake patches: Track include history and variable modification history
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
X-List-Received-Date: Thu, 03 May 2012 19:17:37 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

These are probably not quite ready to be a pull request, but I think
they may be of interest.  I wrote these because I kept wanting this
feature to exist, and spending ages trying to figure out how stuff was
getting set.  Problem solved.  These are both additions to bitbake -e
output.

Sample output looks like this for the include stuff:

# conf/build/x86_64-linux.conf
# conf/target/INVALID-oe-linux.conf
# /home/seebs/poky/meta/conf/machine/qemux86-64.conf includes:
#   /home/seebs/poky/meta/conf/machine/include/tune-x86_64.inc includes:
#     /home/seebs/poky/meta/conf/machine/include/ia32/arch-ia32.inc
#   /home/seebs/poky/meta/conf/machine/include/qemu.inc
# conf/machine-sdk/${SDKMACHINE}.conf

The variable tracking:

# BBFILE_COLLECTIONS [2]
#   append /home/seebs/poky/meta/conf/layer.conf:7:
#     < normal>
#   append /home/seebs/poky/meta-yocto/conf/layer.conf:8:
#     < normal yocto>
#
# BBFILE_COLLECTIONS= normal yocto
BBFILE_COLLECTIONS="normal yocto"

Note that the include tracking is noticably incomplete; most
obviously, in this example, it never finds layer.conf.  Haven't
quite figured out why, still looking at it, but the basic
principle should stay the same.

-s

commit fee6c6ad07d420565b50fed4216f56b916219c2f
Author: Peter Seebach <peter.seebach@windriver.com>
Date:   Tue May 1 19:13:25 2012 -0500

    data_smart.py: Provide (optional) logging of variable modifications
    
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

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index dea0aad..76104ef 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
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
 
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index c0636e1..74efc5d 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
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
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 27fb7d9..5a8917f 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
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
+    def setVar(self, var, value, filename = 'unknown', lineno = 'unknown', op = 'set'):
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
+    def renameVar(self, key, newkey, filename = 'unknown', lineno = 'unknown'):
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
+    def appendVar(self, key, value, filename = 'unknown', lineno = 'unknown'):
         value = (self.getVar(key, False) or "") + value
-        self.setVar(key, value)
+        self.setVar(key, value, filename, lineno, 'append')
 
-    def prependVar(self, key, value):
+    def prependVar(self, key, value, filename = 'unknown', lineno = 'unknown'):
         value = value + (self.getVar(key, False) or "")
-        self.setVar(key, value)
+        self.setVar(key, value, filename, lineno, 'prepend')
 
-    def delVar(self, var):
+    def delVar(self, var, filename = 'unknown', lineno = 'unknown', op = 'del'):
         self.expand_cache = {}
         self.dict[var] = {}
+        self.eventLog(var, op, '', filename, lineno)
         if '_' in var:
             override = var[var.rfind('_')+1:]
             if override and override in self._seen_overrides and var in self._seen_overrides[override]:
                 self._seen_overrides[override].remove(var)
+                self.eventLog(var, 'del', '', filename, lineno)
 
-    def setVarFlag(self, var, flag, flagvalue):
+    def setVarFlag(self, var, flag, flagvalue, filename = 'unknown', lineno = 'unknown', op = 'set'):
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
+    def delVarFlag(self, var, flag, filename = 'unknown', lineno = 'unknown'):
         local_var = self._findVar(var)
         if not local_var:
             return
         if not var in self.dict:
             self._makeShadowCopy(var)
 
+        self.eventLog(var, 'del flag %s' % flag, '', filename, lineno)
         if var in self.dict and flag in self.dict[var]:
             del self.dict[var][flag]
 
-    def appendVarFlag(self, key, flag, value):
+    def appendVarFlag(self, key, flag, value, filename = 'unknown', lineno = 'unknown'):
         value = (self.getVarFlag(key, flag, False) or "") + value
-        self.setVarFlag(key, flag, value)
+        self.setVarFlag(key, flag, value, filename, lineno, 'append')
 
-    def prependVarFlag(self, key, flag, value):
+    def prependVarFlag(self, key, flag, value, filename = 'unknown', lineno = 'unknown'):
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
+    def expandVarref(self, variable, parents=False, filename = 'unknown', lineno = 'unknown'):
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
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 7b9c47e..3c3feee 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -75,7 +75,7 @@ def mark_dependency(d, f):
         f = "%s/%s" % (os.getcwd(), f[2:])
     deps = d.getVar('__depends') or set()
     deps.update([(f, cached_mtime(f))])
-    d.setVar('__depends', deps)
+    d.setVar('__depends', deps, f, 'N/A')
 
 def supports(fn, data):
     """Returns true if we have a handler for this file, false otherwise"""
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index eae840f..dc47437 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
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
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 815bce1..44d7a82 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
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
diff --git a/bitbake/lib/bb/shell.py b/bitbake/lib/bb/shell.py
index 1dd8d54..529692d 100644
--- a/bitbake/lib/bb/shell.py
+++ b/bitbake/lib/bb/shell.py
@@ -493,7 +493,7 @@ SRC_URI = ""
     def setVar( self, params ):
         """Set an outer BitBake environment variable"""
         var, value = params
-        data.setVar( var, value, cooker.configuration.data )
+        data.setVar( var, value, cooker.configuration.data, 'SHELL', '???')
         print("OK")
     setVar.usage = "<variable> <value>"
 
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 8c79b17..4cc69d2 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -137,7 +137,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #    self.dump_sigtask(fn, task, d.getVar("STAMP", True), False)
 
         for task in taskdeps:
-            d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + "." + task])
+            d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + "." + task], 'siggen.py', 'N/A')
 
     def rundep_check(self, fn, recipename, task, dep, depname, dataCache):
         # Return True if we should keep the dependency, False to drop it

commit 1e02fc22a6bc9a0241ebcd492a0c8b0397ec5258
Author: Peter Seebach <peter.seebach@windriver.com>
Date:   Wed May 2 12:11:08 2012 -0500

    data_smart.py: Track configuration file inclusions
    
    This is a preliminary attempt to create a structured representation of
    the processing of include files.  It ignores line numbers because they're
    meaningless.  It could probably be updated to, say, distinguish between
    includes and requires.  Output is added to bitbake -e.
    
    Signed-off-by: Peter Seebach <peter.seebach@windriver.com>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 74efc5d..5ad7862 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -246,10 +246,26 @@ def emit_env(o=sys.__stdout__, d = init(), all=False):
     isfunc = lambda key: bool(d.getVarFlag(key, "func"))
     keys = sorted((key for key in d.keys() if not key.startswith("__")), key=isfunc)
     grouped = groupby(keys, isfunc)
+    # Include history!
+    if d.tracking():
+        o.write('#\n# INCLUDE HISTORY:\n#\n')
+        emit_history(o, d.getIncludeHistory())
+        
     for isfunc, keys in grouped:
         for key in keys:
             emit_var(key, o, d, all and not isfunc) and o.write('\n')
 
+def emit_history(o, h, depth = 0):
+    if not h:
+        return
+    for event in h:
+        o.write("# %*s%s" % (depth * 2, "", event[0]))
+        if event[1]:
+            o.write(" includes:\n")
+            emit_history(o, event[1], depth + 1)
+        else:
+            o.write("\n")
+
 def exported_keys(d):
     return (key for key in d.keys() if not key.startswith('__') and
                                       d.getVarFlag(key, 'export') and
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 5a8917f..e527cee 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -112,6 +112,8 @@ class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
         self.dict = {}
         self.history = {}
+        self.include_history = []
+        self.include_stack = [(-1, self.include_history)]
 
         # cookie monster tribute
         self._special_values = special
@@ -120,6 +122,25 @@ class DataSmart(MutableMapping):
 
         self.expand_cache = {}
 
+    def includeLog(self, filename):
+        """includeLog(included_file) shows that the file was included
+        by the currently-processed file or context."""
+        if self._tracking_enabled:
+            event = (filename, [])
+            position = (len(self.include_stack[-1][1]), event[1])
+            self.include_stack[-1][1].append(event)
+            self.include_stack.append(position)
+
+    def includeLogDone(self, filename):
+        if self._tracking_enabled:
+            if len(self.include_stack) > 1:
+                self.include_stack.pop()
+            else:
+                bb.warn("Uh-oh:  includeLogDone(%s) tried to empty the stack." % filename)
+
+    def getIncludeHistory(self):
+        return self.include_history
+
     def tracking(self):
         return self._tracking_enabled
 
@@ -434,8 +455,19 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
-        data.history = self.history.copy()
-        data._tracking_enabled = self._tracking_enabled
+        if self._tracking_enabled:
+            data._tracking_enabled = self._tracking_enabled
+            data.history = self.history.copy()
+            data.include_history = copy.deepcopy(self.include_history)
+            data.include_stack = []
+            oldref = self.include_history
+            newref = data.include_history
+            # Create corresponding references.
+            for item in self.include_stack:
+                if item[0] >= 0:
+                    newref = newref[item[0]]
+                newevent = (item[0], newref)
+                data.include_stack.append(newevent)
 
         return data
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 6f77bd4..e5def63 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -63,6 +63,7 @@ def include(oldfn, fn, lineno, data, error_out):
         if abs_fn:
             fn = abs_fn
 
+    data.includeLog(fn)
     from bb.parse import handle
     try:
         ret = handle(fn, data, True)
@@ -70,6 +71,8 @@ def include(oldfn, fn, lineno, data, error_out):
         if error_out:
             raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
         logger.debug(2, "CONF file '%s' not found", fn)
+    finally:
+        data.includeLogDone(fn)
 
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.


