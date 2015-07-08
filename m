Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 22EDA75D7D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExO8M026688; Wed, 8 Jul 2015 15:59:24 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KhffpqY6WplN; Wed,  8 Jul 2015 15:59:24 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMt1026600
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:23 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004SK-96; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:58:57 +0100
Message-Id: <b7555534d8b56be22976142c524bc12ef6304591.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 03/16] data_smart: Improve override handling
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:26 -0000

Rather than the heavy lifting in internal_finalize, move the bulk of
the functionality to getVar and rely on a new internal replaces variable
to keep track of any mappings that are needed. This removes the need
for the COW _special_values cache.

This change in functionality also implies we need to track any changes
not only to OVERRIDES but also any variable which OVERIDES depends upon.
Add code to handle this.

Explicitly list FILE as a value OVERRIDES depends upon since it doesn't
automatically get detected and is of key importance to OVERRIDES,
otherwise PN doesn't update when FILE changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 156 ++++++++++++++++++++-------------------------------
 1 file changed, 60 insertions(+), 96 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 77d0c61..aefc0b9 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -296,12 +296,9 @@ class VariableHistory(object):
                 self.variables[var] = []
 
 class DataSmart(MutableMapping):
-    def __init__(self, special = None, seen = None ):
+    def __init__(self, seen = None):
         self.dict = {}
-        self.overrides = []
 
-        if special is None:
-            special = COWDictBase.copy()
         if seen is None:
             seen = COWDictBase.copy()
 
@@ -310,11 +307,13 @@ class DataSmart(MutableMapping):
         self._tracking = False
 
         # cookie monster tribute
-        self._special_values = special
         self._seen_overrides = seen
 
         self.expand_cache = {}
 
+        self.overridevars = set(["OVERRIDES", "FILE"])
+        self.replaces = {}
+
     def enableTracking(self):
         self._tracking = True
 
@@ -361,11 +360,7 @@ class DataSmart(MutableMapping):
     def internal_finalize(self, parent = False):
         """Performs final steps upon the datastore, including application of overrides"""
 
-        self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
-        finalize_caller = {
-            'op': 'finalize',
-        }
-        infer_caller_details(finalize_caller, parent = parent, varval = False)
+        overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
 
         #
         # Well let us see what breaks here. We used to iterate
@@ -383,10 +378,9 @@ class DataSmart(MutableMapping):
         # information for later.
         #
 
-        # We only want to report finalization once per variable overridden.
-        finalizes_reported = {}
+        self.replaces = {}
 
-        for o in self.overrides:
+        for o in overrides:
             # calculate '_'+override
             l = len(o) + 1
 
@@ -397,61 +391,7 @@ class DataSmart(MutableMapping):
             vars = self._seen_overrides[o].copy()
             for var in vars:
                 name = var[:-l]
-                try:
-                    # Report only once, even if multiple changes.
-                    if name not in finalizes_reported:
-                        finalizes_reported[name] = True
-                        finalize_caller['variable'] = name
-                        finalize_caller['detail'] = 'was: ' + str(self.getVar(name, False))
-                        self.varhistory.record(**finalize_caller)
-                    # Copy history of the override over.
-                    for event in self.varhistory.variable(var):
-                        loginfo = event.copy()
-                        loginfo['variable'] = name
-                        loginfo['op'] = 'override[%s]:%s' % (o, loginfo['op'])
-                        self.varhistory.record(**loginfo)
-                    self.setVar(name, self.getVar(var, False), op = 'finalize', file = 'override[%s]' % o, line = '')
-                    self.delVar(var)
-                except Exception:
-                    logger.info("Untracked delVar")
-
-        # now on to the appends and prepends, and stashing the removes
-        for op in __setvar_keyword__:
-            if op in self._special_values:
-                appends = self._special_values[op] or []
-                for append in appends:
-                    self.handle_special_values(append, op)
-
-    def handle_special_values(self, append, op):
-                    keep = []
-                    for (a, o) in self.getVarFlag(append, op) or []:
-                        match = True
-                        if o:
-                            for o2 in o.split("_"):
-                                if not o2 in self.overrides:
-                                    match = False
-                        if not match:
-                            keep.append((a ,o))
-                            continue
-
-                        if op == "_append":
-                            apps = self.getVarFlag(append, "_appendactive", False) or []
-                            apps.extend([a])
-                            self.setVarFlag(append, "_appendactive", apps, ignore=True)
-                        elif op == "_prepend":
-                            prepends = self.getVarFlag(append, "_prependactive", False) or []
-                            prepends.extend([a])
-                            self.setVarFlag(append, "_prependactive", prepends, ignore=True)
-                        elif op == "_remove":
-                            removes = self.getVarFlag(append, "_removeactive", False) or []
-                            removes.extend(a.split())
-                            self.setVarFlag(append, "_removeactive", removes, ignore=True)
-
-                    # We save overrides that may be applied at some later stage
-                    if keep:
-                        self.setVarFlag(append, op, keep, ignore=True)
-                    else:
-                        self.delVarFlag(append, op, ignore=True)
+                self.replaces[name] = var
 
     def initVar(self, var):
         self.expand_cache = {}
@@ -503,22 +443,19 @@ class DataSmart(MutableMapping):
             self.varhistory.record(**loginfo)
             # todo make sure keyword is not __doc__ or __module__
             # pay the cookie monster
-            try:
-                self._special_values[keyword].add(base)
-            except KeyError:
-                self._special_values[keyword] = set()
-                self._special_values[keyword].add(base)
-            self.handle_special_values(base, keyword)
 
+            if base in self.overridevars:
+                self.overridevars.update(self.expandWithRefs(value, var).references)
+                self.internal_finalize(True)
             return
 
         if not var in self.dict:
             self._makeShadowCopy(var)
 
-        if "_appendactive" in self.dict[var]:
-            del self.dict[var]["_appendactive"]
-        if "_prependactive" in self.dict[var]:
-            del self.dict[var]["_prependactive"]
+        if "_append" in self.dict[var]:
+            del self.dict[var]["_append"]
+        if "_prepend" in self.dict[var]:
+            del self.dict[var]["_prepend"]
 
         # more cookies for the cookie monster
         if '_' in var:
@@ -528,7 +465,8 @@ class DataSmart(MutableMapping):
         self.dict[var]["_content"] = value
         self.varhistory.record(**loginfo)
 
-        if var == "OVERRIDES":
+        if var in self.overridevars:
+            self.overridevars.update(self.expandWithRefs(value, var).references)
             self.internal_finalize(True)
 
     def _setvar_update_overrides(self, var):
@@ -568,10 +506,6 @@ class DataSmart(MutableMapping):
             dest.extend(src)
             self.setVarFlag(newkey, i, dest, ignore=True)
 
-            if i in self._special_values and key in self._special_values[i]:
-                self._special_values[i].remove(key)
-                self._special_values[i].add(newkey)
-
         loginfo['variable'] = key
         loginfo['op'] = 'rename (to)'
         loginfo['detail'] = newkey
@@ -623,22 +557,42 @@ class DataSmart(MutableMapping):
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
         local_var = self._findVar(var)
         value = None
-        if local_var is not None:
+
+        if flag == "_content" and var in self.replaces:
+            value = self.getVar(self.replaces[var])
+
+        if local_var is not None and value is None:
             if flag in local_var:
                 value = copy.copy(local_var[flag])
             elif flag == "_content" and "_defaultval" in local_var and not noweakdefault:
                 value = copy.copy(local_var["_defaultval"])
 
-        if flag == "_content" and local_var is not None and "_appendactive" in local_var:
+        if flag == "_content" and local_var is not None and "_append" in local_var:
             if not value:
                 value = ""
-            for r in local_var["_appendactive"]:
-                value = value + r
-        if flag == "_content" and local_var is not None and "_prependactive" in local_var:
+            for (r, o) in local_var["_append"]:
+                match = True
+                if o:
+                    overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+                    for o2 in o.split("_"):
+                        if not o2 in overrides:
+                            match = False                            
+                if match:
+                    value = value + r
+
+        if flag == "_content" and local_var is not None and "_prepend" in local_var:
             if not value:
                 value = ""
-            for r in local_var["_prependactive"]:
-                value = r + value
+            for (r, o) in local_var["_prepend"]:
+                match = True
+                if o:
+                    overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+                    for o2 in o.split("_"):
+                        if not o2 in overrides:
+                            match = False                            
+                if match:
+                    value = r + value
+
         if expand and value:
             # Only getvar (flag == _content) hits the expand cache
             cachename = None
@@ -647,9 +601,19 @@ class DataSmart(MutableMapping):
             else:
                 cachename = var + "[" + flag + "]"
             value = self.expand(value, cachename)
-        if value and flag == "_content" and local_var is not None and "_removeactive" in local_var:
-            removes = [self.expand(r).split()  for r in local_var["_removeactive"]]
-            removes = reduce(lambda a, b: a+b, removes, [])
+
+        if value and flag == "_content" and local_var is not None and "_remove" in local_var:
+            removes = []
+            for (r, o) in local_var["_remove"]:
+                match = True
+                if o:
+                    overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+                    for o2 in o.split("_"):
+                        if not o2 in overrides:
+                            match = False                            
+                if match:
+                    removes.extend(self.expand(r).split())
+
             filtered = filter(lambda v: v not in removes,
                               value.split())
             value = " ".join(filtered)
@@ -735,21 +699,21 @@ class DataSmart(MutableMapping):
             else:
                 del self.dict[var]
 
-
     def createCopy(self):
         """
         Create a copy of self by setting _data to self
         """
         # we really want this to be a DataSmart...
-        data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
+        data = DataSmart(seen=self._seen_overrides.copy())
         data.dict["_data"] = self.dict
-        data.overrides = copy.copy(self.overrides)
         data.varhistory = self.varhistory.copy()
         data.varhistory.datasmart = data
         data.inchistory = self.inchistory.copy()
 
         data._tracking = self._tracking
 
+        data.overridevars = copy.copy(self.overridevars)
+
         return data
 
     def expandVarref(self, variable, parents=False):
-- 
2.1.0


