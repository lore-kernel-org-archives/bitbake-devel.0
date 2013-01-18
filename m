Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwAf3-0002KK-5C for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 13:03:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IBlfYY008541;
	Fri, 18 Jan 2013 11:47:41 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05490-02; Fri, 18 Jan 2013 11:47:37 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IBlYrf008535
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2013 11:47:35 GMT
Message-ID: <1358509654.27799.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 Jan 2013 11:47:34 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake: data_smart.py and friends: Track variable history
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
X-List-Received-Date: Fri, 18 Jan 2013 12:03:35 -0000
X-List-Received-Date: Fri, 18 Jan 2013 12:03:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From: Peter Seebach <peter.seebach@windriver.com>

This patch adds tracking of the history of variable assignments.
The changes are predominantly localized to data_smart.py and
parse/ast.py. cooker.py and data.py are altered to display the
recorded data, and turn tracking on for the bitbake -e case.
The data.py update_data() function warns DataSmart.finalize()
to report the caller one further back up the tree.

In general, d.setVar() does what it used to do. Optionally,
arguments describing an operation may be appended; if none
are present, the operation is implicitly ignored. If it's
not ignored, it will attempt to infer missing information
(name of variable, value assigned, file and line) by examining
the traceback. This slightly elaborate process eliminates a
category of problems in which the 'var' member of the keyword
arguments dict is set, and a positional argument corresponding
to 'var' is also set. It also makes calling much simpler for
the common cases.

The resulting output gives you a pretty good picture of what
values got set, and how they got set.

RP Modifications:

a) Split from IncludeHistory to separate VariableHistory
b) Add dedicated copy function instead of deepcopy
c) Use COW for variables dict
d) Remove 'value' loginfo value and just use 'details'
e) Desensitise code for calling order (set 'op' before/after
   infer_caller_details was error prone)
f) Fix bug where ?= "" wasn't shown correctly
g) Log more set operations as some variables mysteriously acquired
   values previously
h) Standardise infer_caller_details to be triggered from .record()
   where at all possible to reduce overhead in non-enabled cases
i) Rename variable parameter names to match inference code
j) Add VariableHistory emit() function to match IncludeHistory
k) Fix handling of appendVar, prependVar and matching flag ops
l) Use ignored=True to stop logging further events where appropriate

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f06b71c..caf1123 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -177,6 +177,8 @@ class BBCooker:
 
     def initConfigurationData(self):
         self.configuration.data = bb.data.init()
+        if self.configuration.show_environment:
+            self.configuration.data.enableTracking()
 
         if not self.server_registration_cb:
             self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
@@ -185,13 +187,7 @@ class BBCooker:
         bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
 
     def loadConfigurationData(self):
-        self.configuration.data = bb.data.init()
-
-        if not self.server_registration_cb:
-            self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
-
-        filtered_keys = bb.utils.approved_variables()
-        bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
+        self.initConfigurationData()
 
         try:
             self.parseConfigurationFiles(self.configuration.prefile,
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 2c3e905..7047f48 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -166,9 +166,9 @@ def inheritFromOS(d, savedenv, permitted):
     for s in savedenv.keys():
         if s in permitted:
             try:
-                d.setVar(s, getVar(s, savedenv, True))
+                d.setVar(s, getVar(s, savedenv, True), op = 'from env')
                 if s in exportlist:
-                    d.setVarFlag(s, "export", True)
+                    d.setVarFlag(s, "export", True, op = 'auto env export')
             except TypeError:
                 pass
 
@@ -194,8 +194,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         return 0
 
     if all:
-        commentVal = re.sub('\n', '\n#', str(oval))
-        o.write('# %s=%s\n' % (var, commentVal))
+        d.varhistory.emit(var, oval, val, o)
 
     if (var.find("-") != -1 or var.find(".") != -1 or var.find('{') != -1 or var.find('}') != -1 or var.find('+') != -1) and not all:
         return 0
@@ -274,7 +273,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
 
 def update_data(d):
     """Performs final steps upon the datastore, including application of overrides"""
-    d.finalize()
+    d.finalize(parent = True)
 
 def build_dependencies(key, keys, shelldeps, vardepvals, d):
     deps = set()
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 5fdfeee..ddf98e6 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -28,7 +28,7 @@ BitBake build tools.
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
-import copy, re
+import copy, re, sys, traceback
 from collections import MutableMapping
 import logging
 import hashlib
@@ -43,6 +43,42 @@ __setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend)(_(?P<
 __expand_var_regexp__ = re.compile(r"\${[^{}]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 
+def infer_caller_details(loginfo, parent = False, varval = True):
+    """Save the caller the trouble of specifying everything."""
+    # Save effort.
+    if 'ignore' in loginfo and loginfo['ignore']:
+        return
+    # If nothing was provided, mark this as possibly unneeded.
+    if not loginfo:
+        loginfo['ignore'] = True
+        return
+    # Infer caller's likely values for variable (var) and value (value), 
+    # to reduce clutter in the rest of the code.
+    if varval and ('variable' not in loginfo or 'detail' not in loginfo):
+        try:
+            raise Exception
+        except Exception:
+            tb = sys.exc_info()[2]
+            if parent:
+                above = tb.tb_frame.f_back.f_back
+            else:
+                above = tb.tb_frame.f_back
+            lcls = above.f_locals.items()
+        for k, v in lcls:
+            if k == 'value' and 'detail' not in loginfo:
+                loginfo['detail'] = v
+            if k == 'var' and 'variable' not in loginfo:
+                loginfo['variable'] = v
+    # Infer file/line/function from traceback
+    if 'file' not in loginfo:
+        depth = 3    
+        if parent:
+            depth = 4
+        file, line, func, text = traceback.extract_stack(limit = depth)[0]
+        loginfo['file'] = file
+        loginfo['line'] = line
+        if func not in loginfo:
+            loginfo['func'] = func
 
 class VariableParse:
     def __init__(self, varname, d, val = None):
@@ -157,11 +193,80 @@ class IncludeHistory(object):
             o.write("\n")
             child.emit(o, level)
 
+class VariableHistory(object):
+    def __init__(self, dataroot):
+        self.dataroot = dataroot
+        self.variables = COWDictBase.copy()
+
+    def copy(self):
+        new = VariableHistory(self.dataroot)
+        new.variables = self.variables.copy()
+        return new
+
+    def record(self, *kwonly, **loginfo):
+        if not self.dataroot._tracking:
+            return
+        if len(kwonly) > 0:
+            raise TypeError
+        infer_caller_details(loginfo, parent = True)
+        if 'ignore' in loginfo and loginfo['ignore']:
+            return
+        if 'op' not in loginfo or not loginfo['op']:
+            loginfo['op'] = 'set'
+        if 'detail' in loginfo:
+            loginfo['detail'] = str(loginfo['detail'])
+        if 'variable' not in loginfo or 'file' not in loginfo:
+            raise ValueError("record() missing variable or file.")
+        var = loginfo['variable']
+
+        if var not in self.variables:
+            self.variables[var] = []
+        self.variables[var].append(loginfo.copy())
+
+    def variable(self, var):
+        if var in self.variables:
+            return self.variables[var]
+        else:
+            return []
+
+    def emit(self, var, oval, val, o):
+        history = self.variable(var)
+        commentVal = re.sub('\n', '\n#', str(oval))
+        if history:
+            if len(history) == 1:
+                o.write("#\n# $%s\n" % var)
+            else:
+                o.write("#\n# $%s [%d operations]\n" % (var, len(history)))
+            for event in history:
+                # o.write("# %s\n" % str(event))
+                if 'func' in event:
+                    # If we have a function listed, this is internal
+                    # code, not an operation in a config file, and the
+                    # full path is distracting.
+                    event['file'] = re.sub('.*/', '', event['file'])
+                    display_func = ' [%s]' % event['func']
+                else:
+                    display_func = ''
+                if 'flag' in event:
+                    flag = '[%s] ' % (event['flag'])
+                else:
+                    flag = ''
+                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % (event['op'], event['file'], event['line'], display_func, flag, re.sub('\n', '\n#     ', event['detail'])))
+            if len(history) > 1:
+                o.write("# computed:\n")
+                o.write('#   "%s"\n' % (commentVal))
+        else:
+            o.write("#\n# $%s\n#   [no history recorded]\n#\n" % var)
+            o.write('#   "%s"\n' % (commentVal))
+
+
 class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
         self.dict = {}
 
         self.inchistory = IncludeHistory()
+        self.varhistory = VariableHistory(self)
+        self._tracking = False
 
         # cookie monster tribute
         self._special_values = special
@@ -169,6 +274,12 @@ class DataSmart(MutableMapping):
 
         self.expand_cache = {}
 
+    def enableTracking(self):
+        self._tracking = True
+
+    def disableTracking(self):
+        self._tracking = False
+
     def expandWithRefs(self, s, varname):
 
         if not isinstance(s, basestring): # sanity check
@@ -204,10 +315,14 @@ class DataSmart(MutableMapping):
         return self.expandWithRefs(s, varname).value
 
 
-    def finalize(self):
+    def finalize(self, parent = False):
         """Performs final steps upon the datastore, including application of overrides"""
 
         overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+        finalize_caller = {
+            'op': 'finalize',
+        }
+        infer_caller_details(finalize_caller, parent = parent, varval = False)
 
         #
         # Well let us see what breaks here. We used to iterate
@@ -224,6 +339,9 @@ class DataSmart(MutableMapping):
         # Then  we will handle _append and _prepend
         #
 
+        # We only want to report finalization once per variable overridden.
+        finalizes_reported = {}
+
         for o in overrides:
             # calculate '_'+override
             l = len(o) + 1
@@ -236,7 +354,19 @@ class DataSmart(MutableMapping):
             for var in vars:
                 name = var[:-l]
                 try:
-                    self.setVar(name, self.getVar(var, False))
+                    # Report only once, even if multiple changes.
+                    if name not in finalizes_reported:
+                        finalizes_reported[name] = True
+                        finalize_caller['variable'] = name
+                        finalize_caller['detail'] = 'was: ' + str(self.getVar(name, False))
+                        self.varhistory.record(**finalize_caller)
+                    # Copy history of the override over.
+                    for event in self.varhistory.variable(var):
+                        loginfo = event.copy()
+                        loginfo['variable'] = name
+                        loginfo['op'] = 'override[%s]:%s' % (o, loginfo['op'])
+                        self.varhistory.record(**loginfo)
+                    self.setVar(name, self.getVar(var, False), op = 'finalize', file = 'override[%s]' % o, line = '')
                     self.delVar(var)
                 except Exception:
                     logger.info("Untracked delVar")
@@ -267,9 +397,9 @@ class DataSmart(MutableMapping):
 
                     # We save overrides that may be applied at some later stage
                     if keep:
-                        self.setVarFlag(append, op, keep)
+                        self.setVarFlag(append, op, keep, ignore=True)
                     else:
-                        self.delVarFlag(append, op)
+                        self.delVarFlag(append, op, ignore=True)
 
     def initVar(self, var):
         self.expand_cache = {}
@@ -297,7 +427,10 @@ class DataSmart(MutableMapping):
         else:
             self.initVar(var)
 
-    def setVar(self, var, value):
+
+    def setVar(self, var, value, **loginfo):
+        if 'op' not in loginfo:
+            loginfo['op'] = "set"
         self.expand_cache = {}
         match  = __setvar_regexp__.match(var)
         if match and match.group("keyword") in __setvar_keyword__:
@@ -306,15 +439,22 @@ class DataSmart(MutableMapping):
             override = match.group('add')
             l = self.getVarFlag(base, keyword) or []
             l.append([value, override])
-            self.setVarFlag(base, keyword, l)
-
+            self.setVarFlag(base, keyword, l, ignore=True)
+            # And cause that to be recorded:
+            loginfo['detail'] = value
+            loginfo['variable'] = base
+            if override:
+                loginfo['op'] = '%s[%s]' % (keyword, override)
+            else:
+                loginfo['op'] = keyword
+            self.varhistory.record(**loginfo)
             # todo make sure keyword is not __doc__ or __module__
             # pay the cookie monster
             try:
-                self._special_values[keyword].add( base )
+                self._special_values[keyword].add(base)
             except KeyError:
                 self._special_values[keyword] = set()
-                self._special_values[keyword].add( base )
+                self._special_values[keyword].add(base)
 
             return
 
@@ -331,6 +471,7 @@ class DataSmart(MutableMapping):
 
         # setting var
         self.dict[var]["_content"] = value
+        self.varhistory.record(**loginfo)
 
     def getVar(self, var, expand=False, noweakdefault=False):
         value = self.getVarFlag(var, "_content", False, noweakdefault)
@@ -340,13 +481,17 @@ class DataSmart(MutableMapping):
             return self.expand(value, var)
         return value
 
-    def renameVar(self, key, newkey):
+    def renameVar(self, key, newkey, **loginfo):
         """
         Rename the variable key to newkey
         """
         val = self.getVar(key, 0)
         if val is not None:
-            self.setVar(newkey, val)
+            loginfo['variable'] = newkey
+            loginfo['op'] = 'rename from %s' % key
+            loginfo['detail'] = val
+            self.varhistory.record(**loginfo)
+            self.setVar(newkey, val, ignore=True)
 
         for i in ('_append', '_prepend'):
             src = self.getVarFlag(key, i)
@@ -355,23 +500,34 @@ class DataSmart(MutableMapping):
 
             dest = self.getVarFlag(newkey, i) or []
             dest.extend(src)
-            self.setVarFlag(newkey, i, dest)
+            self.setVarFlag(newkey, i, dest, ignore=True)
 
             if i in self._special_values and key in self._special_values[i]:
                 self._special_values[i].remove(key)
                 self._special_values[i].add(newkey)
 
-        self.delVar(key)
-
-    def appendVar(self, key, value):
-        value = (self.getVar(key, False) or "") + value
-        self.setVar(key, value)
-
-    def prependVar(self, key, value):
-        value = value + (self.getVar(key, False) or "")
-        self.setVar(key, value)
-
-    def delVar(self, var):
+        loginfo['variable'] = key
+        loginfo['op'] = 'rename (to)'
+        loginfo['detail'] = newkey
+        self.varhistory.record(**loginfo)
+        self.delVar(key, ignore=True)
+
+    def appendVar(self, var, value, **loginfo):
+        loginfo['op'] = 'append'
+        self.varhistory.record(**loginfo)
+        newvalue = (self.getVar(var, False) or "") + value
+        self.setVar(var, newvalue, ignore=True)
+
+    def prependVar(self, var, value, **loginfo):
+        loginfo['op'] = 'prepend'
+        self.varhistory.record(**loginfo)
+        newvalue = value + (self.getVar(var, False) or "")
+        self.setVar(var, newvalue, ignore=True)
+
+    def delVar(self, var, **loginfo):
+        loginfo['detail'] = ""
+        loginfo['op'] = 'del'
+        self.varhistory.record(**loginfo)
         self.expand_cache = {}
         self.dict[var] = {}
         if '_' in var:
@@ -379,10 +535,14 @@ class DataSmart(MutableMapping):
             if override and override in self._seen_overrides and var in self._seen_overrides[override]:
                 self._seen_overrides[override].remove(var)
 
-    def setVarFlag(self, var, flag, flagvalue):
+    def setVarFlag(self, var, flag, value, **loginfo):
+        if 'op' not in loginfo:
+            loginfo['op'] = "set"
+        loginfo['flag'] = flag
+        self.varhistory.record(**loginfo)
         if not var in self.dict:
             self._makeShadowCopy(var)
-        self.dict[var][flag] = flagvalue
+        self.dict[var][flag] = value
 
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
         local_var = self._findVar(var)
@@ -396,7 +556,7 @@ class DataSmart(MutableMapping):
             value = self.expand(value, None)
         return value
 
-    def delVarFlag(self, var, flag):
+    def delVarFlag(self, var, flag, **loginfo):
         local_var = self._findVar(var)
         if not local_var:
             return
@@ -404,23 +564,38 @@ class DataSmart(MutableMapping):
             self._makeShadowCopy(var)
 
         if var in self.dict and flag in self.dict[var]:
-            del self.dict[var][flag]
-
-    def appendVarFlag(self, key, flag, value):
-        value = (self.getVarFlag(key, flag, False) or "") + value
-        self.setVarFlag(key, flag, value)
+            loginfo['detail'] = ""
+            loginfo['op'] = 'delFlag'
+            loginfo['flag'] = flag
+            self.varhistory.record(**loginfo)
 
-    def prependVarFlag(self, key, flag, value):
-        value = value + (self.getVarFlag(key, flag, False) or "")
-        self.setVarFlag(key, flag, value)
+            del self.dict[var][flag]
 
-    def setVarFlags(self, var, flags):
+    def appendVarFlag(self, var, flag, value, **loginfo):
+        loginfo['op'] = 'append'
+        loginfo['flag'] = flag
+        self.varhistory.record(**loginfo)
+        newvalue = (self.getVarFlag(var, flag, False) or "") + value
+        self.setVarFlag(var, flag, newvalue, ignore=True)
+
+    def prependVarFlag(self, var, flag, value, **loginfo):
+        loginfo['op'] = 'prepend'
+        loginfo['flag'] = flag
+        self.varhistory.record(**loginfo)
+        newvalue = value + (self.getVarFlag(var, flag, False) or "")
+        self.setVarFlag(var, flag, newvalue, ignore=True)
+
+    def setVarFlags(self, var, flags, **loginfo):
+        infer_caller_details(loginfo)
         if not var in self.dict:
             self._makeShadowCopy(var)
 
         for i in flags:
             if i == "_content":
                 continue
+            loginfo['flag'] = i
+            loginfo['detail'] = flags[i]
+            self.varhistory.record(**loginfo)
             self.dict[var][i] = flags[i]
 
     def getVarFlags(self, var):
@@ -438,13 +613,16 @@ class DataSmart(MutableMapping):
         return flags
 
 
-    def delVarFlags(self, var):
+    def delVarFlags(self, var, **loginfo):
         if not var in self.dict:
             self._makeShadowCopy(var)
 
         if var in self.dict:
             content = None
 
+            loginfo['op'] = 'delete flags'
+            self.varhistory.record(**loginfo)
+
             # try to save the content
             if "_content" in self.dict[var]:
                 content  = self.dict[var]["_content"]
@@ -461,8 +639,12 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
+        data.varhistory = self.varhistory.copy()
+        data.varhistory.datasmart = data
         data.inchistory = self.inchistory.copy()
 
+        data._tracking = self._tracking
+
         return data
 
     def expandVarref(self, variable, parents=False):
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 79e9f7e..b2657f8 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -68,7 +68,7 @@ class ExportNode(AstNode):
         self.var = var
 
     def eval(self, data):
-        data.setVarFlag(self.var, "export", 1)
+        data.setVarFlag(self.var, "export", 1, op = 'exported')
 
 class DataNode(AstNode):
     """
@@ -90,33 +90,53 @@ class DataNode(AstNode):
     def eval(self, data):
         groupd = self.groupd
         key = groupd["var"]
+        loginfo = {
+            'variable': key,
+            'file': self.filename,
+            'line': self.lineno,
+        }
         if "exp" in groupd and groupd["exp"] != None:
-            data.setVarFlag(key, "export", 1)
+            data.setVarFlag(key, "export", 1, op = 'exported', **loginfo)
+
+        op = "set"
         if "ques" in groupd and groupd["ques"] != None:
             val = self.getFunc(key, data)
+            op = "set?"
             if val == None:
                 val = groupd["value"]
         elif "colon" in groupd and groupd["colon"] != None:
             e = data.createCopy()
             bb.data.update_data(e)
+            op = "immediate"
             val = e.expand(groupd["value"], key + "[:=]")
         elif "append" in groupd and groupd["append"] != None:
+            op = "append"
             val = "%s %s" % ((self.getFunc(key, data) or ""), groupd["value"])
         elif "prepend" in groupd and groupd["prepend"] != None:
+            op = "prepend"
             val = "%s %s" % (groupd["value"], (self.getFunc(key, data) or ""))
         elif "postdot" in groupd and groupd["postdot"] != None:
+            op = "postdot"
             val = "%s%s" % ((self.getFunc(key, data) or ""), groupd["value"])
         elif "predot" in groupd and groupd["predot"] != None:
+            op = "predot"
             val = "%s%s" % (groupd["value"], (self.getFunc(key, data) or ""))
         else:
             val = groupd["value"]
 
+        flag = None
         if 'flag' in groupd and groupd['flag'] != None:
-            data.setVarFlag(key, groupd['flag'], val)
+            flag = groupd['flag']
         elif groupd["lazyques"]:
-            data.setVarFlag(key, "defaultval", val)
+            flag = "defaultval"
+
+        loginfo['op'] = op
+        loginfo['detail'] = groupd["value"]
+
+        if flag:
+            data.setVarFlag(key, flag, val, **loginfo)
         else:
-            data.setVar(key, val)
+            data.setVar(key, val, **loginfo)
 
 class MethodNode(AstNode):
     def __init__(self, filename, lineno, func_name, body):




