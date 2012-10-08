Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TLIcU-0007qY-Na
	for bitbake-devel@lists.openembedded.org;
	Mon, 08 Oct 2012 21:04:03 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q98IotnP013951
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 8 Oct 2012 11:50:55 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 8 Oct 2012 11:50:55 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 8 Oct 2012 13:50:51 -0500
Message-ID: <c9afcc5a75fec47c676a9d853f27274d646a2317.1349721987.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1349721987.git.peter.seebach@windriver.com>
References: <cover.1349721987.git.peter.seebach@windriver.com>
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
X-List-Received-Date: Mon, 08 Oct 2012 19:04:03 -0000
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

The resulting output gives you a pretty good picture of what
values got set, and how they got set.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/cooker.py                   |   10 ++-
 lib/bb/data.py                     |   34 ++++++-
 lib/bb/data.pyc                    |  Bin 0 -> 14383 bytes
 lib/bb/data_smart.py               |  201 +++++++++++++++++++++++++++++++-----
 lib/bb/data_smart.pyc              |  Bin 0 -> 21279 bytes
 lib/bb/parse/ast.py                |   25 ++++-
 lib/bb/parse/parse_py/BBHandler.py |    6 +-
 7 files changed, 235 insertions(+), 41 deletions(-)
 create mode 100644 lib/bb/data.pyc
 create mode 100644 lib/bb/data_smart.pyc

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0c7c4e0..1e959c6 100644
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
@@ -840,6 +846,8 @@ class BBCooker:
 
     def parseConfigurationFiles(self, prefiles, postfiles):
         data = self.configuration.data
+        if self.configuration.show_environment:
+            data.enableTracking()
         bb.parse.init_parser(data)
 
         # Parse files for loading *before* bitbake.conf and any includes
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 9a32353..3c99762 100644
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
 
@@ -194,8 +194,34 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
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
+                    func = ' [%s]' % event['func']
+                else:
+                    func = ''
+                if 'flag' in event:
+                    flag = '[%s] ' % (event['flag'])
+                else:
+                    flag = ''
+                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % (event['op'], event['file'], event['line'], func, flag, re.sub('\n', '\n#     ', value)))
+            if len(history) > 1:
+                o.write("# computed:\n")
+                o.write('#   "%s"\n' % (commentVal))
+        else:
+            o.write("#\n# $%s\n#   [no history recorded]\n#\n" % var)
+            o.write('#   "%s"\n' % (commentVal))
 
     if (var.find("-") != -1 or var.find(".") != -1 or var.find('{') != -1 or var.find('}') != -1 or var.find('+') != -1) and not all:
         return 0
@@ -273,7 +299,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
 
 def update_data(d):
     """Performs final steps upon the datastore, including application of overrides"""
-    d.finalize()
+    d.finalize(parent = True)
 
 def build_dependencies(key, keys, shelldeps, vardepvals, d):
     deps = set()
diff --git a/lib/bb/data.pyc b/lib/bb/data.pyc
new file mode 100644
index 0000000000000000000000000000000000000000..33a7d8393b625849aac1a9db1170bf9a031a27f3
GIT binary patch
literal 14383
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
Cw0*e%

literal 0
HcmV?d00001

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 864f527..03cf4c0 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -28,7 +28,7 @@ BitBake build tools.
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
-import copy, re
+import copy, re, sys, traceback
 from collections import MutableMapping
 import logging
 import hashlib
@@ -43,6 +43,53 @@ __setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend)(_(?P<
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
@@ -115,15 +162,17 @@ class ExpansionError(Exception):
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
@@ -131,6 +180,34 @@ class IncludeHistory(object):
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
 
@@ -148,11 +225,11 @@ class IncludeHistory(object):
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
 
 
@@ -163,10 +240,17 @@ class DataSmart(MutableMapping):
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
@@ -200,10 +284,16 @@ class DataSmart(MutableMapping):
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
@@ -220,6 +310,9 @@ class DataSmart(MutableMapping):
         # Then  we will handle _append and _prepend
         #
 
+        # We only want to report finalization once per variable overridden.
+        finalizes_reported = {}
+
         for o in overrides:
             # calculate '_'+override
             l = len(o) + 1
@@ -232,7 +325,19 @@ class DataSmart(MutableMapping):
             for var in vars:
                 name = var[:-l]
                 try:
-                    self.setVar(name, self.getVar(var, False))
+                    # Report only once, even if 
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
@@ -293,7 +398,9 @@ class DataSmart(MutableMapping):
         else:
             self.initVar(var)
 
-    def setVar(self, var, value):
+
+    def setVar(self, var, value, **loginfo):
+        infer_caller_details(loginfo)
         self.expand_cache = {}
         match  = __setvar_regexp__.match(var)
         if match and match.group("keyword") in __setvar_keyword__:
@@ -303,14 +410,21 @@ class DataSmart(MutableMapping):
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
 
@@ -327,6 +441,7 @@ class DataSmart(MutableMapping):
 
         # setting var
         self.dict[var]["_content"] = value
+        self.history.record(**loginfo)
 
     def getVar(self, var, expand=False, noweakdefault=False):
         value = self.getVarFlag(var, "_content", False, noweakdefault)
@@ -336,13 +451,15 @@ class DataSmart(MutableMapping):
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
+            loginfo['op'] = 'rename'
+            loginfo['details'] = key
+            self.setVar(newkey, val, **loginfo)
 
         for i in ('_append', '_prepend'):
             src = self.getVarFlag(key, i)
@@ -359,15 +476,21 @@ class DataSmart(MutableMapping):
 
         self.delVar(key)
 
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
@@ -375,7 +498,11 @@ class DataSmart(MutableMapping):
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
@@ -392,31 +519,44 @@ class DataSmart(MutableMapping):
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
@@ -434,12 +574,16 @@ class DataSmart(MutableMapping):
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
@@ -449,7 +593,6 @@ class DataSmart(MutableMapping):
             else:
                 del self.dict[var]
 
-
     def createCopy(self):
         """
         Create a copy of self by setting _data to self
@@ -458,6 +601,8 @@ class DataSmart(MutableMapping):
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
         data.history = copy.deepcopy(self.history)
+        data.history.datasmart = data
+        data._tracking = self._tracking
 
         return data
 
diff --git a/lib/bb/data_smart.pyc b/lib/bb/data_smart.pyc
new file mode 100644
index 0000000000000000000000000000000000000000..5477e2e3fc75013f2017aeda921bebaaa0aea693
GIT binary patch
literal 21279
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

literal 0
HcmV?d00001

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 4caa93e..cf37bc7 100644
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
index 2e0647b..7c2d180 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -78,7 +78,7 @@ def inherit(files, fn, lineno, d):
         if not file in __inherit_cache:
             logger.log(logging.DEBUG -1, "BB %s:%d: inheriting %s", fn, lineno, file)
             __inherit_cache.append( file )
-            data.setVar('__inherit_cache', __inherit_cache, d)
+            d.setVar('__inherit_cache', __inherit_cache)
             include(fn, file, lineno, d, "inherit")
             __inherit_cache = d.getVar('__inherit_cache') or []
 
@@ -129,7 +129,7 @@ def handle(fn, d, include):
         __inherit_cache = d.getVar('__inherit_cache') or []
         if not fn in __inherit_cache:
             __inherit_cache.append(fn)
-            data.setVar('__inherit_cache', __inherit_cache, d)
+            d.setVar('__inherit_cache', __inherit_cache)
 
     if include != 0:
         oldfile = d.getVar('FILE')
@@ -146,7 +146,7 @@ def handle(fn, d, include):
 
     # DONE WITH PARSING... time to evaluate
     if ext != ".bbclass":
-        data.setVar('FILE', abs_fn, d)
+        d.setVar('FILE', abs_fn)
 
     statements.eval(d)
 
-- 
1.7.0.4



