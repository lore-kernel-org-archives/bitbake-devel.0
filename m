Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D66D275DB2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExO8O026688; Wed, 8 Jul 2015 15:59:25 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dHRpNYVJXHjH; Wed,  8 Jul 2015 15:59:25 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMbK026603
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:23 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004SY-HS; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:00 +0100
Message-Id: <5936c2611f26bd7e548152e41ea74b3a720e75d5.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 06/16] data_smart: Move override handling to getVar
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:27 -0000

Compeltely remove the replaces functionality and move all overrides
handling to getVar time. We can move the cookie cache into a hidden
flag within the variables themselves.

This removes the need for any of the internal_finalize steps.

This obsolete the need for the _seen_overrides COW cache.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 131 ++++++++++++++++++++++++---------------------------
 1 file changed, 61 insertions(+), 70 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 884ca19..28ea2ae 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -296,24 +296,18 @@ class VariableHistory(object):
                 self.variables[var] = []
 
 class DataSmart(MutableMapping):
-    def __init__(self, seen = None):
+    def __init__(self):
         self.dict = {}
 
-        if seen is None:
-            seen = COWDictBase.copy()
-
         self.inchistory = IncludeHistory()
         self.varhistory = VariableHistory(self)
         self._tracking = False
 
-        # cookie monster tribute
-        self._seen_overrides = seen
-
         self.expand_cache = {}
 
+        # cookie monster tribute
         self.overrides = []
         self.overridevars = set(["OVERRIDES", "FILE"])
-        self.replaces = {}
 
     def enableTracking(self):
         self._tracking = True
@@ -363,49 +357,6 @@ class DataSmart(MutableMapping):
 
         self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
 
-        #
-        # Well let us see what breaks here. We used to iterate
-        # over each variable and apply the override and then
-        # do the line expanding.
-        # If we have bad luck - which we will have - the keys
-        # where in some order that is so important for this
-        # method which we don't have anymore.
-        # Anyway we will fix that and write test cases this
-        # time.
-
-        #
-        # First we apply all overrides
-        # Then we will handle _append and _prepend and store the _remove
-        # information for later.
-        #
-
-        self.replaces = {}
-
-        for o in self.overrides:
-            # calculate '_'+override
-            l = len(o) + 1
-
-            # see if one should even try
-            if o not in self._seen_overrides:
-                continue
-
-            vars = self._seen_overrides[o].copy()
-            for var in vars:
-                name = var[:-l]
-                self.replaces[name] = var
-
-    def internal_finalize2(self, var, o):
-        """Performs final steps upon the datastore, including application of overrides"""
-
-        l = len(o) + 1
-        name = var[:-l]
-
-        if name in self.replaces:
-            del self.replaces[name]
-        for o in self.overrides:
-            if o in self._seen_overrides and name + "_" + o in self._seen_overrides[o]:
-                self.replaces[name] = name + "_" + o
-
     def initVar(self, var):
         self.expand_cache = {}
         if not var in self.dict:
@@ -457,6 +408,11 @@ class DataSmart(MutableMapping):
             # todo make sure keyword is not __doc__ or __module__
             # pay the cookie monster
 
+            # more cookies for the cookie monster
+            if '_' in var:
+                self._setvar_update_overrides(base, **loginfo)
+
+
             if base in self.overridevars:
                 self.overridevars.update(self.expandWithRefs(value, var).references)
                 self.internal_finalize(True)
@@ -469,16 +425,12 @@ class DataSmart(MutableMapping):
             del self.dict[var]["_append"]
         if "_prepend" in self.dict[var]:
             del self.dict[var]["_prepend"]
-
-        if var in self.replaces:
-            del self.replaces[var]
-        for o in self.overrides:
-            if o in self._seen_overrides and var + "_" + o in self._seen_overrides[o]:
-                self.delVar(var + "_" + o)
+        if "_overrides" in self.dict[var]:
+            del self.dict[var]["_overrides"]
 
         # more cookies for the cookie monster
         if '_' in var:
-            self._setvar_update_overrides(var)
+            self._setvar_update_overrides(var, **loginfo)
 
         # setting var
         self.dict[var]["_content"] = value
@@ -488,19 +440,29 @@ class DataSmart(MutableMapping):
             self.overridevars.update(self.expandWithRefs(value, var).references)
             self.internal_finalize(True)
 
-    def _setvar_update_overrides(self, var):
+    def _setvar_update_overrides(self, var, **loginfo):
         # aka pay the cookie monster
         override = var[var.rfind('_')+1:]
         shortvar = var[:var.rfind('_')]
         while override:
-            if override not in self._seen_overrides:
-                self._seen_overrides[override] = set()
-            self._seen_overrides[override].add( var )
-            self.internal_finalize2(var, override)
+            l = self.getVarFlag(shortvar, "_overrides") or []
+            if [var, override] not in l:
+                l.append([var, override])
+                self.setVarFlag(shortvar, "_overrides", l, ignore=True)
+            for event in self.varhistory.variable(var):
+                if 'flag' in loginfo and not loginfo['flag'].startswith("_"):
+                    continue
+                loginfo = event.copy()
+                loginfo['variable'] = shortvar
+                loginfo['op'] = 'override[%s]:%s' % (override, loginfo['op'])
+                self.varhistory.record(**loginfo)
+
             override = None
             if "_" in shortvar:
                 override = var[shortvar.rfind('_')+1:]
                 shortvar = var[:shortvar.rfind('_')]
+                if len(shortvar) == 0:
+                    override = None
 
     def getVar(self, var, expand=False, noweakdefault=False):
         return self.getVarFlag(var, "_content", expand, noweakdefault)
@@ -526,6 +488,9 @@ class DataSmart(MutableMapping):
             dest.extend(src)
             self.setVarFlag(newkey, i, dest, ignore=True)
 
+        if '_' in newkey and val is None:
+            self._setvar_update_overrides(newkey, **loginfo)
+
         loginfo['variable'] = key
         loginfo['op'] = 'rename (to)'
         loginfo['detail'] = newkey
@@ -552,9 +517,13 @@ class DataSmart(MutableMapping):
         self.dict[var] = {}
         if '_' in var:
             override = var[var.rfind('_')+1:]
-            if override and override in self._seen_overrides and var in self._seen_overrides[override]:
-                self._seen_overrides[override].remove(var)
-                self.internal_finalize2(var, override)
+            shortvar = var[:var.rfind('_')]
+            l = self.getVarFlag(shortvar, "_overrides") or []
+            try:
+                l.remove([var, override])
+            except ValueError as e:
+                pass
+            self.setVarFlag(shortvar, "_overrides", l, ignore=True)
 
     def setVarFlag(self, var, flag, value, **loginfo):
         self.expand_cache = {}
@@ -567,7 +536,7 @@ class DataSmart(MutableMapping):
         self.dict[var][flag] = value
 
         if flag == "_defaultval" and '_' in var:
-            self._setvar_update_overrides(var)
+            self._setvar_update_overrides(var, **loginfo)
 
         if flag == "unexport" or flag == "export":
             if not "__exportlist" in self.dict:
@@ -580,8 +549,30 @@ class DataSmart(MutableMapping):
         local_var = self._findVar(var)
         value = None
 
-        if flag == "_content" and var in self.replaces:
-            value = self.getVar(self.replaces[var])
+        if flag == "_content" and local_var is not None and "_overrides" in local_var:
+            match = False
+            active = {}
+            for (r, o) in local_var["_overrides"]:
+                # What about double overrides both with "_" in the name?
+                if o in self.overrides:
+                    active[o] = r
+                elif set(o.split("_")).issubset(set(self.overrides)):
+                    active[o] = r
+            mod = True
+            while mod:
+                mod = False
+                for o in self.overrides:
+                    for a in active.copy():
+                        if a.endswith("_" + o):
+                            t = active[a]
+                            del active[a]
+                            active[a.replace("_" + o, "")] = t
+                            mod = True
+                        elif a == o:
+                            match = active[a]
+                            del active[a]
+            if match:
+                value = self.getVar(match)
 
         if local_var is not None and value is None:
             if flag in local_var:
@@ -726,7 +717,7 @@ class DataSmart(MutableMapping):
         Create a copy of self by setting _data to self
         """
         # we really want this to be a DataSmart...
-        data = DataSmart(seen=self._seen_overrides.copy())
+        data = DataSmart()
         data.dict["_data"] = self.dict
         data.varhistory = self.varhistory.copy()
         data.varhistory.datasmart = data
-- 
2.1.0


