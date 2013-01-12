Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TtsV8-0005xb-6r
	for bitbake-devel@lists.openembedded.org;
	Sat, 12 Jan 2013 05:15:24 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r0C1f5x9004840
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Jan 2013 17:41:05 -0800 (PST)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 11 Jan 2013 17:41:05 -0800
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Jan 2013 19:40:59 -0600
Message-ID: <f8b831dc3a8ac4bf67a52936b93c6043cdc4e30e.1357954043.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1357954043.git.peter.seebach@windriver.com>
References: <cover.1357954043.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] data_smart.py and friends: Track variable history
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
X-List-Received-Date: Sat, 12 Jan 2013 04:15:25 -0000
Content-Type: text/plain

This patch adds tracking of the history of variable assignments.
The changes are predominantly localized to data_smart.py and
parse/ast.py. BBHandler.py is changed to use d.setVar(...)
instead of data.setVar(..., d), and cooker.py and data.py are
altered to display the recorded data, and turn tracking on for
the bitbake -e case. The data.py update_data() function warns
DataSmart.finalize() to report the caller one further back up
the tree.

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

If you make manual calls to some of these functions, you can
get surprises; for instance, infer_caller_details will set the
'value' member of the loginfo object to None if it can't find
a value; if you then pass that loginfo object to setVar, after
a value, the loginfo array clashes with the positional
parameter named value.

The resulting output gives you a pretty good picture of what
values got set, and how they got set.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/cooker.py                   |   10 ++-
 lib/bb/data.py                     |   38 ++++++-
 lib/bb/data_smart.py               |  216 +++++++++++++++++++++++++++++++-----
 lib/bb/parse/ast.py                |   25 ++++-
 lib/bb/parse/parse_py/BBHandler.py |    6 +-
 5 files changed, 253 insertions(+), 42 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 86e3ed6..35e79a7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -101,8 +101,10 @@ class BBCooker:
         # to use environment variables which have been cleaned from the
         # BitBake processes env
         self.savedenv = bb.data.init()
+        if self.configuration.show_environment:
+            self.savedenv.enableTracking()
         for k in savedenv:
-            self.savedenv.setVar(k, savedenv[k])
+            self.savedenv.setVar(k, savedenv[k], op = 'inherit', file = '[saved environment]')
 
         self.caches_array = []
         # Currently, only Image Creator hob ui needs extra cache.
@@ -177,6 +179,8 @@ class BBCooker:
 
     def initConfigurationData(self):
         self.configuration.data = bb.data.init()
+        if self.configuration.show_environment:
+            self.configuration.data.enableTracking()
 
         if not self.server_registration_cb:
             self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
@@ -186,6 +190,8 @@ class BBCooker:
 
     def loadConfigurationData(self):
         self.configuration.data = bb.data.init()
+        if self.configuration.show_environment:
+            self.configuration.data.enableTracking()
 
         if not self.server_registration_cb:
             self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
@@ -846,6 +852,8 @@ class BBCooker:
 
     def parseConfigurationFiles(self, prefiles, postfiles):
         data = self.configuration.data
+        if self.configuration.show_environment:
+            data.enableTracking()
         bb.parse.init_parser(data)
 
         # Parse files for loading *before* bitbake.conf and any includes
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 478a482..ec0db9e 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -166,9 +166,9 @@ def inheritFromOS(d, savedenv, permitted):
     for s in savedenv.keys():
         if s in permitted:
             try:
-                setVar(s, getVar(s, savedenv, True), d)
+                d.setVar(s, getVar(s, savedenv, True), op = 'inherit')
                 if s in exportlist:
-                    setVarFlag(s, "export", True, d)
+                    d.setVarFlag(s, "export", True, op = 'automatic')
             except TypeError:
                 pass
 
@@ -194,8 +194,38 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         return 0
 
     if all:
+        history = d.history.variable(var)
         commentVal = re.sub('\n', '\n#', str(oval))
-        o.write('# %s=%s\n' % (var, commentVal))
+        if history:
+            if len(history) == 1:
+                o.write("#\n# $%s\n" % var)
+            else:
+                o.write("#\n# $%s [%d operations]\n" % (var, len(history)))
+            for event in history:
+                # o.write("# %s\n" % str(event))
+                if 'details' in event and event['details']:
+                    value = event['details']
+                else:
+                    value = event['value']
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
+                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % (event['op'], event['file'], event['line'], display_func, flag, re.sub('\n', '\n#     ', value)))
+            if len(history) > 1:
+                o.write("# computed:\n")
+                o.write('#   "%s"\n' % (commentVal))
+        else:
+            o.write("#\n# $%s\n#   [no history recorded]\n#\n" % var)
+            o.write('#   "%s"\n' % (commentVal))
 
     if (var.find("-") != -1 or var.find(".") != -1 or var.find('{') != -1 or var.find('}') != -1 or var.find('+') != -1) and not all:
         return 0
@@ -274,7 +304,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
 
 def update_data(d):
     """Performs final steps upon the datastore, including application of overrides"""
-    d.finalize()
+    d.finalize(parent = True)
 
 def build_dependencies(key, keys, shelldeps, vardepvals, d):
     deps = set()
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8adda30..a2c6e41 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -8,6 +8,8 @@ BitBake build tools.
 
 """
 
+import pprint
+
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2004, 2005  Seb Frankengul
 # Copyright (C) 2005, 2006  Holger Hans Peter Freyther
@@ -28,7 +30,7 @@ BitBake build tools.
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
-import copy, re
+import copy, re, sys, traceback
 from collections import MutableMapping
 import logging
 import hashlib
@@ -43,6 +45,53 @@ __setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend)(_(?P<
 __expand_var_regexp__ = re.compile(r"\${[^{}]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 
+def infer_caller_details(loginfo, parent = False):
+    """Save the caller the trouble of specifying everything."""
+    locals = None
+    # Save effort.
+    if 'ignore' in loginfo and loginfo['ignore']:
+        return
+    # If nothing was provided, mark this as possibly unneeded.
+    if not loginfo:
+        loginfo['ignore'] = True
+        return
+    if parent:
+        depth = 4
+    else:
+        depth = 3
+    # Infer caller's likely values for variable (var), loginfo (loginfo),
+    # and value (value), to reduce clutter in the rest of the code.
+    if 'variable' not in loginfo or 'value' not in loginfo:
+        try:
+            raise Exception
+        except Exception:
+            tb = sys.exc_info()[2]
+            if parent:
+                above = tb.tb_frame.f_back.f_back
+            else:
+                above = tb.tb_frame.f_back
+            locals = above.f_locals.items()
+            tb = None
+            above = None
+        value = None
+        variable = None
+        for k, v in locals:
+            if k == 'value':
+                value = v
+            if k == 'var':
+                variable = v
+        if 'value' not in loginfo:
+            loginfo['value'] = value
+        if 'variable' not in loginfo:
+            loginfo['variable'] = variable
+        locals = None
+    # Infer file/line/function from traceback
+    if 'file' not in loginfo:
+        file, line, func, text = traceback.extract_stack(limit = depth)[0]
+        loginfo['file'] = file
+        loginfo['line'] = line
+        if func not in loginfo:
+            loginfo['func'] = func
 
 class VariableParse:
     def __init__(self, varname, d, val = None):
@@ -115,15 +164,17 @@ class ExpansionError(Exception):
         return self.msg
 
 class IncludeHistory(object):
-    def __init__(self, parent = None, filename = None):
+    def __init__(self, parent = None, filename = None, datasmart = None):
         self.parent = parent
-        if parent:
+        if parent is not None:
             self.top = parent.top
         else:
             self.top = self
+        self.datasmart = datasmart
         self.filename = filename or '[TOP LEVEL]'
         self.children = []
         self.current = self
+        self.variables = {}
 
     def include(self, filename):
         newfile = IncludeHistory(self.current, filename)
@@ -131,6 +182,34 @@ class IncludeHistory(object):
         self.current = newfile
         return self
 
+    def record(self, *kwonly, **loginfo):
+        if len(kwonly) > 0:
+            raise TypeError
+        if not self.top.datasmart._tracking:
+            return
+        infer_caller_details(loginfo, parent = True)
+        if 'ignore' in loginfo and loginfo['ignore']:
+            return
+        if 'op' not in loginfo or not loginfo['op']:
+            loginfo['op'] = 'set'
+        if 'details' in loginfo and loginfo['details']:
+            loginfo['details'] = str(loginfo['details'])
+        if 'value' in loginfo and loginfo['value']:
+            loginfo['value'] = str(loginfo['value'])
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
     def __enter__(self):
         pass
 
@@ -148,11 +227,11 @@ class IncludeHistory(object):
             o.write("# %s%s" % (spaces, self.filename))
             if len(self.children) > 0:
                 o.write(" includes:")
-            o.write("\n")
             level = level + 1
         else:
-            o.write("#\n# INCLUDE HISTORY:\n#\n")
+            o.write("#\n# INCLUDE HISTORY:\n#")
         for child in self.children:
+            o.write("\n")
             child.emit(o, level)
 
 
@@ -163,10 +242,17 @@ class DataSmart(MutableMapping):
         # cookie monster tribute
         self._special_values = special
         self._seen_overrides = seen
-        self.history = IncludeHistory()
+        self.history = IncludeHistory(datasmart = self)
+        self._tracking = False
 
         self.expand_cache = {}
 
+    def enableTracking(self):
+        self._tracking = True
+
+    def disableTracking(self):
+        self._tracking = False
+
     def expandWithRefs(self, s, varname):
 
         if not isinstance(s, basestring): # sanity check
@@ -202,10 +288,16 @@ class DataSmart(MutableMapping):
         return self.expandWithRefs(s, varname).value
 
 
-    def finalize(self):
+    def finalize(self, parent = False):
         """Performs final steps upon the datastore, including application of overrides"""
 
         overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+        finalize_caller = {
+            'variable': 'ignored',
+            'value': 'ignored',
+            'op': 'finalize',
+        }
+        infer_caller_details(finalize_caller, parent = parent)
 
         #
         # Well let us see what breaks here. We used to iterate
@@ -222,6 +314,9 @@ class DataSmart(MutableMapping):
         # Then  we will handle _append and _prepend
         #
 
+        # We only want to report finalization once per variable overridden.
+        finalizes_reported = {}
+
         for o in overrides:
             # calculate '_'+override
             l = len(o) + 1
@@ -234,7 +329,19 @@ class DataSmart(MutableMapping):
             for var in vars:
                 name = var[:-l]
                 try:
-                    self.setVar(name, self.getVar(var, False))
+                    # Report only once, even if multiple changes.
+                    if name not in finalizes_reported:
+                        finalizes_reported[name] = True
+                        finalize_caller['variable'] = name
+                        finalize_caller['value'] = 'was: ' + str(self.getVar(name, False))
+                        self.history.record(**finalize_caller)
+                    # Copy history of the override over.
+                    for event in self.history.variable(var):
+                        loginfo = event.copy()
+                        loginfo['variable'] = name
+                        loginfo['op'] = 'override[%s]:%s' % (o, loginfo['op'])
+                        self.history.record(**loginfo)
+                    self.setVar(name, self.getVar(var, False), op = 'finalize', file = 'override[%s]' % o, line = '')
                     self.delVar(var)
                 except Exception:
                     logger.info("Untracked delVar")
@@ -295,7 +402,9 @@ class DataSmart(MutableMapping):
         else:
             self.initVar(var)
 
-    def setVar(self, var, value):
+
+    def setVar(self, var, value, **loginfo):
+        infer_caller_details(loginfo)
         self.expand_cache = {}
         match  = __setvar_regexp__.match(var)
         if match and match.group("keyword") in __setvar_keyword__:
@@ -305,14 +414,21 @@ class DataSmart(MutableMapping):
             l = self.getVarFlag(base, keyword) or []
             l.append([value, override])
             self.setVarFlag(base, keyword, l)
-
+            # And cause that to be recorded:
+            loginfo['details'] = value
+            loginfo['variable'] = base
+            if override:
+                loginfo['op'] = '%s[%s]' % (keyword, override)
+            else:
+                loginfo['op'] = keyword
+            self.history.record(**loginfo)
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
 
@@ -329,6 +445,7 @@ class DataSmart(MutableMapping):
 
         # setting var
         self.dict[var]["_content"] = value
+        self.history.record(**loginfo)
 
     def getVar(self, var, expand=False, noweakdefault=False):
         value = self.getVarFlag(var, "_content", False, noweakdefault)
@@ -338,13 +455,23 @@ class DataSmart(MutableMapping):
             return self.expand(value, var)
         return value
 
-    def renameVar(self, key, newkey):
+    def renameVar(self, key, newkey, **loginfo):
         """
         Rename the variable key to newkey
         """
+        # Figure out who called us so the line information is meaningful.
+        if 'op' not in loginfo:
+            loginfo['op'] = 'rename'
+        infer_caller_details(loginfo, True)
         val = self.getVar(key, 0)
         if val is not None:
-            self.setVar(newkey, val)
+            loginfo['variable'] = newkey
+            loginfo['op'] = 'rename from %s' % key
+            loginfo['details'] = val
+            # the parameter before kwargs is named 'value', this would clash:
+            del loginfo['value']
+            # bb.note("creating log entry: %s" % pprint.pformat(loginfo))
+            self.setVar(newkey, val, **loginfo)
 
         for i in ('_append', '_prepend'):
             src = self.getVarFlag(key, i)
@@ -359,17 +486,26 @@ class DataSmart(MutableMapping):
                 self._special_values[i].remove(key)
                 self._special_values[i].add(newkey)
 
-        self.delVar(key)
+        loginfo['variable'] = key
+        loginfo['op'] = 'rename (to)'
+        loginfo['details'] = newkey
+        self.delVar(key, **loginfo)
 
-    def appendVar(self, key, value):
+    def appendVar(self, key, value, **loginfo):
+        loginfo['details'] = value
         value = (self.getVar(key, False) or "") + value
-        self.setVar(key, value)
+        self.setVar(key, value, **loginfo)
 
-    def prependVar(self, key, value):
+    def prependVar(self, key, value, **loginfo):
+        loginfo['details'] = value
         value = value + (self.getVar(key, False) or "")
-        self.setVar(key, value)
+        self.setVar(key, value, **loginfo)
 
-    def delVar(self, var):
+    def delVar(self, var, **loginfo):
+        loginfo['value'] = ""
+        if not 'op' in loginfo:
+            loginfo['op'] = 'del'
+        self.history.record(**loginfo)
         self.expand_cache = {}
         self.dict[var] = {}
         if '_' in var:
@@ -377,7 +513,11 @@ class DataSmart(MutableMapping):
             if override and override in self._seen_overrides and var in self._seen_overrides[override]:
                 self._seen_overrides[override].remove(var)
 
-    def setVarFlag(self, var, flag, flagvalue):
+    def setVarFlag(self, var, flag, flagvalue, **loginfo):
+        infer_caller_details(loginfo)
+        loginfo['value'] = flagvalue
+        loginfo['flag'] = flag
+        self.history.record(**loginfo)
         if not var in self.dict:
             self._makeShadowCopy(var)
         self.dict[var][flag] = flagvalue
@@ -394,31 +534,44 @@ class DataSmart(MutableMapping):
             value = self.expand(value, None)
         return value
 
-    def delVarFlag(self, var, flag):
+    def delVarFlag(self, var, flag, **loginfo):
+        infer_caller_details(loginfo)
+        loginfo['value'] = ""
         local_var = self._findVar(var)
+        if 'op' not in loginfo:
+            loginfo['op'] = 'delFlag'
+        loginfo['flag'] = flag
         if not local_var:
             return
         if not var in self.dict:
             self._makeShadowCopy(var)
 
         if var in self.dict and flag in self.dict[var]:
+            self.history.record(**loginfo)
             del self.dict[var][flag]
 
-    def appendVarFlag(self, key, flag, value):
+    def appendVarFlag(self, key, flag, value, **loginfo):
+        infer_caller_details(loginfo)
+        loginfo['details'] = value
         value = (self.getVarFlag(key, flag, False) or "") + value
-        self.setVarFlag(key, flag, value)
+        self.setVarFlag(key, flag, value, **loginfo)
 
-    def prependVarFlag(self, key, flag, value):
+    def prependVarFlag(self, key, flag, value, **loginfo):
+        infer_caller_details(loginfo)
+        loginfo['details'] = value
         value = value + (self.getVarFlag(key, flag, False) or "")
-        self.setVarFlag(key, flag, value)
+        self.setVarFlag(key, flag, value, **loginfo)
 
-    def setVarFlags(self, var, flags):
+    def setVarFlags(self, var, flags, **loginfo):
+        infer_caller_details(loginfo)
         if not var in self.dict:
             self._makeShadowCopy(var)
 
         for i in flags:
             if i == "_content":
                 continue
+            loginfo['flag'] = i
+            self.history.record(**loginfo)
             self.dict[var][i] = flags[i]
 
     def getVarFlags(self, var):
@@ -436,12 +589,16 @@ class DataSmart(MutableMapping):
         return flags
 
 
-    def delVarFlags(self, var):
+    def delVarFlags(self, var, **loginfo):
+        infer_caller_details(loginfo)
+        if 'op' not in loginfo:
+            loginfo['op'] = 'delete flags'
         if not var in self.dict:
             self._makeShadowCopy(var)
 
         if var in self.dict:
             content = None
+            self.history.record(**loginfo)
 
             # try to save the content
             if "_content" in self.dict[var]:
@@ -451,7 +608,6 @@ class DataSmart(MutableMapping):
             else:
                 del self.dict[var]
 
-
     def createCopy(self):
         """
         Create a copy of self by setting _data to self
@@ -460,6 +616,8 @@ class DataSmart(MutableMapping):
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
         data.history = copy.deepcopy(self.history)
+        data.history.datasmart = data
+        data._tracking = self._tracking
 
         return data
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 79e9f7e..ba672b1 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -68,7 +68,7 @@ class ExportNode(AstNode):
         self.var = var
 
     def eval(self, data):
-        data.setVarFlag(self.var, "export", 1)
+        data.setVarFlag(self.var, "export", 1, op = 'exported')
 
 class DataNode(AstNode):
     """
@@ -90,33 +90,48 @@ class DataNode(AstNode):
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
+        # The others all want this by default:
+        loginfo['details'] = groupd["value"]
+        op = None
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
 
+        loginfo['op'] = op
         if 'flag' in groupd and groupd['flag'] != None:
-            data.setVarFlag(key, groupd['flag'], val)
+            data.setVarFlag(key, groupd['flag'], val, **loginfo)
         elif groupd["lazyques"]:
-            data.setVarFlag(key, "defaultval", val)
+            data.setVarFlag(key, "defaultval", val, **loginfo)
         else:
-            data.setVar(key, val)
+            data.setVar(key, val, **loginfo)
 
 class MethodNode(AstNode):
     def __init__(self, filename, lineno, func_name, body):
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 2ee8ebd..c585b60 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -84,7 +84,7 @@ def inherit(files, fn, lineno, d):
         if not file in __inherit_cache:
             logger.log(logging.DEBUG -1, "BB %s:%d: inheriting %s", fn, lineno, file)
             __inherit_cache.append( file )
-            data.setVar('__inherit_cache', __inherit_cache, d)
+            d.setVar('__inherit_cache', __inherit_cache)
             include(fn, file, lineno, d, "inherit")
             __inherit_cache = d.getVar('__inherit_cache') or []
 
@@ -134,7 +134,7 @@ def handle(fn, d, include):
         __inherit_cache = d.getVar('__inherit_cache') or []
         if not fn in __inherit_cache:
             __inherit_cache.append(fn)
-            data.setVar('__inherit_cache', __inherit_cache, d)
+            d.setVar('__inherit_cache', __inherit_cache)
 
     if include != 0:
         oldfile = d.getVar('FILE')
@@ -151,7 +151,7 @@ def handle(fn, d, include):
 
     # DONE WITH PARSING... time to evaluate
     if ext != ".bbclass":
-        data.setVar('FILE', abs_fn, d)
+        d.setVar('FILE', abs_fn)
 
     try:
         statements.eval(d)
-- 
1.7.0.4



