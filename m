Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SzZRm-0005jE-JV
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 22:35:11 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q79KNLkh025567
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2012 13:23:21 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Thu, 9 Aug 2012 13:23:21 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 9 Aug 2012 15:23:18 -0500
Message-ID: <64c64f3b5ef519490877f1399b0dc697fa6ada14.1344543257.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1344543257.git.peter.seebach@windriver.com>
References: <cover.1344543257.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] data_smart.py: Fix variable tracking
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
X-List-Received-Date: Thu, 09 Aug 2012 20:35:11 -0000
Content-Type: text/plain

There were a number of flaws in the variable tracking, some
more bug-like, some more poor design choices.

1. Appends were displaying the entire new state of the thing
appended. For BBCLASSEXTEND, this could result in ten megabytes
of diagnostic output for a single 27K or so variable. Solution:
Add a new "details" option which is displayed instead of the
value if provided, and modify appends/prepends to display only
the change.

2. Some internal bookkeeping was generating log events that were
uninformative to the user. As a new idiom, the file name 'Ignore'
causes the logger to ignore operations on that file. Several
operations, especially in finalize(), are changed to respect this.

3. The display of overrides was confusing at best. Too many
things were logged, resulting in a number of log events showing
empty overrides (because the deletion of the override as its
value gets stored in the thing overridden was tracked).

4. Because the copy of the history was not a deep copy, a
database which was repeatedly copied-and-finalized ended up with
multiple records of finalization events.

5. In general, finalization was being overreported, because
really we don't care that much; we already *saw* that these
appends, etcetera, existed.
---
 lib/bb/data_smart.py                 |   81 ++++++++++++++++++++-------------
 lib/bb/parse/ast.py                  |    7 +++-
 lib/bb/parse/parse_py/ConfHandler.py |    4 +-
 3 files changed, 57 insertions(+), 35 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index feab6c8..a889441 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -156,7 +156,7 @@ class DataSmart(MutableMapping):
         self._tracking_enabled = False
 
     def eventLog(self, var, event, value, filename = None, lineno = None):
-        if self._tracking_enabled:
+        if self._tracking_enabled and filename != 'Ignore':
             if var not in self.history:
                 self.history[var] = []
             self.history[var].append((event, filename, lineno, value))
@@ -197,7 +197,7 @@ class DataSmart(MutableMapping):
     # specified.
     def infer_file_and_line(self, filename, lineno):
         details = lineno
-        if self._tracking_enabled and not filename:
+        if self._tracking_enabled and not filename and filename != 'Ignore':
             filename, lineno, func, line = traceback.extract_stack(limit=3)[0]
             details = "%d [%s]" % (lineno, func)
         return filename, details
@@ -222,6 +222,9 @@ class DataSmart(MutableMapping):
         # Then  we will handle _append and _prepend
         #
 
+        # Note that the tracking is going to report some things here
+        # which duplicate previous effects; we show it anyway because
+        # people may not be sure which overrides are being applied.
         for o in overrides:
             # calculate '_'+override
             l = len(o) + 1
@@ -234,14 +237,19 @@ class DataSmart(MutableMapping):
             for var in vars:
                 name = var[:-l]
                 try:
+                    # Move the history of the override into the history of
+                    # the overridden:
                     for event in self.getHistory(var):
-                        self.eventLog(name, 'override:%s' % var, event[3], event[1], event[2])
-                    self.setVar(name, self.getVar(var, False), '${%s}' % var, 'N/A', 'override')
-                    self.delVar(var)
+                        self.eventLog(name, 'override:%s' % o, event[3], event[1], event[2])
+                    self.setVar(name, self.getVar(var, False), 'Ignore')
+                    self.delVar(var, 'Ignore')
                 except Exception, e:
                     logger.info("Untracked delVar %s: %s" % (var, e))
 
         # now on to the appends and prepends
+        # We are going to shut off tracking briefly. Any _append we see
+        # here was already reported as a flag set previously, so we
+        # don't need to repeat it.
         for op in __setvar_keyword__:
             if op in self._special_values:
                 appends = self._special_values[op] or []
@@ -260,16 +268,17 @@ class DataSmart(MutableMapping):
                         if op == "_append":
                             sval = self.getVar(append, False) or ""
                             sval += a
-                            self.setVar(append, sval)
+                            self.setVar(append, sval, 'Ignore')
                         elif op == "_prepend":
                             sval = a + (self.getVar(append, False) or "")
-                            self.setVar(append, sval)
+                            self.setVar(append, sval, 'Ignore')
 
                     # We save overrides that may be applied at some later stage
+                    # ... but we don't need to report on this.
                     if keep:
-                        self.setVarFlag(append, op, keep)
+                        self.setVarFlag(append, op, keep, 'Ignore')
                     else:
-                        self.delVarFlag(append, op)
+                        self.delVarFlag(append, op, 'Ignore')
 
     def initVar(self, var):
         self.expand_cache = {}
@@ -297,7 +306,13 @@ class DataSmart(MutableMapping):
         else:
             self.initVar(var)
 
-    def setVar(self, var, value, filename = None, lineno = None, op = 'set'):
+    # In some cases, we want to set a value, but only record part of it;
+    # for instance, when appending something, we want to record what we
+    # appended, not what the complete value of the now-appended value.
+    # This becomes especially obvious when looking at the output for
+    # BBCLASSEXTEND.
+
+    def setVar(self, var, value, filename = None, lineno = None, op = 'set', details = None):
         filename, lineno = self.infer_file_and_line(filename, lineno)
         self.expand_cache = {}
         match  = __setvar_regexp__.match(var)
@@ -306,8 +321,12 @@ class DataSmart(MutableMapping):
             keyword = match.group("keyword")
             override = match.group('add')
             l = self.getVarFlag(base, keyword) or []
-            l.append([value, override])
-            self.setVarFlag(base, keyword, l, filename, lineno)
+            # Compute new details: This is what we're actually appending.
+            details = [value, override]
+            l.append(details)
+            # Log these with the keyword as the op, not as flag ops
+            self.setVarFlag(base, keyword, l, 'Ignore')
+            self.eventLog(base, keyword, details or value, filename, lineno)
 
             # todo make sure keyword is not __doc__ or __module__
             # pay the cookie monster
@@ -316,7 +335,6 @@ class DataSmart(MutableMapping):
             except KeyError:
                 self._special_values[keyword] = set()
                 self._special_values[keyword].add( base )
-            self.eventLog(base, keyword, base, filename, lineno)
 
             return
 
@@ -333,7 +351,7 @@ class DataSmart(MutableMapping):
 
         # setting var
         self.dict[var]["content"] = value
-        self.eventLog(var, op, value, filename, lineno)
+        self.eventLog(var, op, details or value, filename, lineno)
 
     def getHistory(self, var):
         if var in self.history:
@@ -372,15 +390,15 @@ class DataSmart(MutableMapping):
 
         self.delVar(key, filename, lineno, 'rename-delete')
 
-    def appendVar(self, key, value, filename = None, lineno = None):
+    def appendVar(self, key, newValue, filename = None, lineno = None):
         filename, lineno = self.infer_file_and_line(filename, lineno)
-        value = (self.getVar(key, False) or "") + value
-        self.setVar(key, value, filename, lineno, 'append')
+        value = (self.getVar(key, False) or "") + newValue
+        self.setVar(key, value, filename, lineno, 'append', newValue)
 
-    def prependVar(self, key, value, filename = None, lineno = None):
+    def prependVar(self, key, newValue, filename = None, lineno = None):
         filename, lineno = self.infer_file_and_line(filename, lineno)
-        value = value + (self.getVar(key, False) or "")
-        self.setVar(key, value, filename, lineno, 'prepend')
+        value = newValue + (self.getVar(key, False) or "")
+        self.setVar(key, value, filename, lineno, 'prepend', newValue)
 
     def delVar(self, var, filename = None, lineno = None, op = 'del'):
         filename, lineno = self.infer_file_and_line(filename, lineno)
@@ -391,14 +409,13 @@ class DataSmart(MutableMapping):
             override = var[var.rfind('_')+1:]
             if override and override in self._seen_overrides and var in self._seen_overrides[override]:
                 self._seen_overrides[override].remove(var)
-                self.eventLog(var, 'del', '', filename, lineno)
 
-    def setVarFlag(self, var, flag, flagvalue, filename = None, lineno = None, op = 'set'):
+    def setVarFlag(self, var, flag, flagvalue, filename = None, lineno = None, op = 'set', details = None):
         filename, lineno = self.infer_file_and_line(filename, lineno)
         if not var in self.dict:
             self._makeShadowCopy(var)
         self.dict[var][flag] = flagvalue
-        self.eventLog(var, '%s flag %s' % (op, flag), flagvalue, filename, lineno)
+        self.eventLog(var, '[flag %s] %s' % (flag, op), details or flagvalue, filename, lineno)
 
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
         local_var = self._findVar(var)
@@ -424,17 +441,17 @@ class DataSmart(MutableMapping):
         if var in self.dict and flag in self.dict[var]:
             del self.dict[var][flag]
 
-    def appendVarFlag(self, key, flag, value, filename = None, lineno = None):
+    def appendVarFlag(self, key, flag, newValue, filename = None, lineno = None):
         filename, lineno = self.infer_file_and_line(filename, lineno)
-        value = (self.getVarFlag(key, flag, False) or "") + value
-        self.setVarFlag(key, flag, value, filename, lineno, 'append')
+        value = (self.getVarFlag(key, flag, False) or "") + newValue
+        self.setVarFlag(key, flag, value, filename, lineno, 'appendVar', newValue)
 
-    def prependVarFlag(self, key, flag, value, filename = None, lineno = None):
+    def prependVarFlag(self, key, flag, newValue, filename = None, lineno = None):
         filename, lineno = self.infer_file_and_line(filename, lineno)
-        value = value + (self.getVarFlag(key, flag, False) or "")
-        self.setVarFlag(key, flag, value, filename, lineno, 'prepend')
+        value = newValue + (self.getVarFlag(key, flag, False) or "")
+        self.setVarFlag(key, flag, value, filename, lineno, 'prependVar', newValue)
 
-    def setVarFlags(self, var, flags, filename = None, lineno = None):
+    def setVarFlags(self, var, flags, filename = None, lineno = None, details = None):
         filename, lineno = self.infer_file_and_line(filename, lineno)
         if not var in self.dict:
             self._makeShadowCopy(var)
@@ -442,7 +459,7 @@ class DataSmart(MutableMapping):
         for i in flags:
             if i == "content":
                 continue
-            self.eventLog(var, 'set flag %s' % i, flags[i], filename, lineno)
+            self.eventLog(var, 'set flag %s' % i, details or flags[i], filename, lineno)
             self.dict[var][i] = flags[i]
 
     def getVarFlags(self, var):
@@ -487,7 +504,7 @@ class DataSmart(MutableMapping):
         data.dict["_data"] = self.dict
         if self._tracking_enabled:
             data._tracking_enabled = self._tracking_enabled
-            data.history = self.history.copy()
+            data.history = copy.deepcopy(self.history)
             data.include_history = copy.deepcopy(self.include_history)
             data.include_stack = []
             oldref = self.include_history
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index c5b4121..dbc2237 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -92,6 +92,7 @@ class DataNode(AstNode):
         groupd = self.groupd
         key = groupd["var"]
         op = 'set'
+        details = None
         if "exp" in groupd and groupd["exp"] != None:
             data.setVarFlag(key, "export", 1, self.filename, self.lineno)
         if "ques" in groupd and groupd["ques"] != None:
@@ -107,15 +108,19 @@ class DataNode(AstNode):
         elif "append" in groupd and groupd["append"] != None:
             val = "%s %s" % ((self.getFunc(key, data) or ""), groupd["value"])
             op = 'append'
+            details = groupd["value"]
         elif "prepend" in groupd and groupd["prepend"] != None:
             val = "%s %s" % (groupd["value"], (self.getFunc(key, data) or ""))
             op = 'prepend'
+            details = groupd["value"]
         elif "postdot" in groupd and groupd["postdot"] != None:
             val = "%s%s" % ((self.getFunc(key, data) or ""), groupd["value"])
             op = 'postdot'
+            details = groupd["value"]
         elif "predot" in groupd and groupd["predot"] != None:
             val = "%s%s" % (groupd["value"], (self.getFunc(key, data) or ""))
             op = 'predot'
+            details = groupd["value"]
         else:
             val = groupd["value"]
 
@@ -124,7 +129,7 @@ class DataNode(AstNode):
         elif groupd["lazyques"]:
             data.setVarFlag(key, "defaultval", val, self.filename, self.lineno, op)
         else:
-            data.setVar(key, val, self.filename, self.lineno, op)
+            data.setVar(key, val, self.filename, self.lineno, op, details)
 
 class MethodNode(AstNode):
     def __init__(self, filename, lineno, func_name, body):
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 6f77bd4..4a1012e 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -110,10 +110,10 @@ def handle(fn, data, include):
         feeder(lineno, s, fn, statements)
 
     # DONE WITH PARSING... time to evaluate
-    data.setVar('FILE', abs_fn)
+    data.setVar('FILE', abs_fn, 'Ignore')
     statements.eval(data)
     if oldfile:
-        data.setVar('FILE', oldfile)
+        data.setVar('FILE', oldfile, 'Ignore')
 
     for f in confFilters:
         f(fn, data)
-- 
1.7.0.4



