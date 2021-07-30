Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.24117.1627652829314324963
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 06:47:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VxLgvebB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso7778449wms.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jul 2021 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QB8+sd3s9H2Nstr14ze/nWpq3JfZQ9rKVrDHY7QmahM=;
        b=VxLgvebBXQVa5VMiV0vTut2GasC5fZEP2fCM20xhCN+iZue5nmoJGWWdpbabAjr2Jx
         V2ged8M8Qb0yKa9Hw8pkA70ijkqWeUyjdVkdQnFRw7PqSOOdksDODHjS/E02NweNGoKC
         llcu6TT0BIwgCOhnFDc1cJvCHLfkzSSqE1HoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QB8+sd3s9H2Nstr14ze/nWpq3JfZQ9rKVrDHY7QmahM=;
        b=al2UjPho3ySgjyvJWCVWR32+i3kRjgQwV3hav/BIR76MCqDRE1j1/fN/oZYdaULYuP
         2snihB131ODWRWk/cBd+9eo7hJ9vSBxdcaABDgzji0EPgtOCEGUHoHLTUx+fdTvuNe8w
         yrkvxvMS37HN/fl4M2+XduBvYE3GMDzt8NSwq/5v9gnDjmS+K0ex06uXpDAsmceJUjN4
         McB/tLwTAnWsj75HD2HaKpg2feSF0rDrueZ9mNNt+NVmV4yvvkqJQ+cTjD8zQvKYMAsy
         QL4mQMXXWdC9tl79X8COd0DnkCauyshja+Q+SzziEmoiz6vCENxzjgHB2L3OuSZiiVVv
         6jxg==
X-Gm-Message-State: AOAM531h/266DR9a1xfWR4kkU4Q7DOYHq+cOpUUblsB3963k3Wu66oVT
	eiAmE6ULd/ePC3GfouOpPH/tqFQPdI5nEQ==
X-Google-Smtp-Source: ABdhPJyWycSDQSkwu9XBJHdPFyul+QZmYJJayByExbEOE3ijXl1YjGTJ5t7Eu+42K8wLFcl4y0hs7w==
X-Received: by 2002:a05:600c:17d8:: with SMTP id y24mr3145692wmo.91.1627652827514;
        Fri, 30 Jul 2021 06:47:07 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b])
        by smtp.gmail.com with ESMTPSA id p3sm1965969wmp.25.2021.07.30.06.47.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:47:07 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] bitbake: Switch to using new override syntax
Date: Fri, 30 Jul 2021 14:47:03 +0100
Message-Id: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the datastore to use the new override syntax using
colons instead of underscores exclusively. It is expected layers would
have to be converted to work with bitbake after this change.

Supporting mixed syntax isn't possible, it is only feasible to have
one internal representation of overrides.

Whilst we can't warn for every possible override that may be set in the
old format, show errors for _append/_prepend/_remove since those should
never be present.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py      |   4 +-
 lib/bb/data_smart.py | 113 +++++++++++++++++++++----------------------
 lib/bb/parse/ast.py  |   2 -
 lib/bb/siggen.py     |   4 +-
 4 files changed, 59 insertions(+), 64 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 27eb271798..73bc6e9665 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -53,12 +53,12 @@ class RecipeInfoCommon(object):
 
     @classmethod
     def pkgvar(cls, var, packages, metadata):
-        return dict((pkg, cls.depvar("%s_%s" % (var, pkg), metadata))
+        return dict((pkg, cls.depvar("%s:%s" % (var, pkg), metadata))
                     for pkg in packages)
 
     @classmethod
     def taskvar(cls, var, tasks, metadata):
-        return dict((task, cls.getvar("%s_task-%s" % (var, task), metadata))
+        return dict((task, cls.getvar("%s:task-%s" % (var, task), metadata))
                     for task in tasks)
 
     @classmethod
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index b4ed62a4e5..43e9e78555 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -26,8 +26,8 @@ from bb.COW  import COWDictBase
 
 logger = logging.getLogger("BitBake.Data")
 
-__setvar_keyword__ = ["_append", "_prepend", "_remove"]
-__setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>[^A-Z]*))?$')
+__setvar_keyword__ = [":append", ":prepend", ":remove"]
+__setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>:append|:prepend|:remove)(:(?P<add>[^A-Z]*))?$')
 __expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~:]+?}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 __whitespace_split__ = re.compile(r'(\s)')
@@ -277,7 +277,7 @@ class VariableHistory(object):
             for (r, override) in d.overridedata[var]:
                 for event in self.variable(r):
                     loginfo = event.copy()
-                    if 'flag' in loginfo and not loginfo['flag'].startswith("_"):
+                    if 'flag' in loginfo and not loginfo['flag'].startswith(("_", ":")):
                         continue
                     loginfo['variable'] = var
                     loginfo['op'] = 'override[%s]:%s' % (override, loginfo['op'])
@@ -342,7 +342,7 @@ class VariableHistory(object):
         for event in history:
             if 'flag' in event:
                 continue
-            if event['op'] == '_remove':
+            if event['op'] == ':remove':
                 continue
             if isset and event['op'] == 'set?':
                 continue
@@ -481,7 +481,15 @@ class DataSmart(MutableMapping):
 
     def setVar(self, var, value, **loginfo):
         #print("var=" + str(var) + "  val=" + str(value))
-        var = var.replace(":", "_")
+
+        if "_append" in var or "_prepend" in var or "_remove" in var:
+            info = "%s" % var
+            if "filename" in loginfo:
+                info += " file: %s" % loginfo[filename]
+            if "lineno" in loginfo:
+                info += " line: %s" % loginfo[lineno]
+            bb.fatal("Variable %s contains an operation using the old override syntax. Please convert this layer/metadata before attempting to use with a newer bitbake." % info)
+
         self.expand_cache = {}
         parsing=False
         if 'parsing' in loginfo:
@@ -510,7 +518,7 @@ class DataSmart(MutableMapping):
             # pay the cookie monster
 
             # more cookies for the cookie monster
-            if '_' in var:
+            if ':' in var:
                 self._setvar_update_overrides(base, **loginfo)
 
             if base in self.overridevars:
@@ -521,27 +529,27 @@ class DataSmart(MutableMapping):
             self._makeShadowCopy(var)
 
         if not parsing:
-            if "_append" in self.dict[var]:
-                del self.dict[var]["_append"]
-            if "_prepend" in self.dict[var]:
-                del self.dict[var]["_prepend"]
-            if "_remove" in self.dict[var]:
-                del self.dict[var]["_remove"]
+            if ":append" in self.dict[var]:
+                del self.dict[var][":append"]
+            if ":prepend" in self.dict[var]:
+                del self.dict[var][":prepend"]
+            if ":remove" in self.dict[var]:
+                del self.dict[var][":remove"]
             if var in self.overridedata:
                 active = []
                 self.need_overrides()
                 for (r, o) in self.overridedata[var]:
                     if o in self.overridesset:
                         active.append(r)
-                    elif "_" in o:
-                        if set(o.split("_")).issubset(self.overridesset):
+                    elif ":" in o:
+                        if set(o.split(":")).issubset(self.overridesset):
                             active.append(r)
                 for a in active:
                     self.delVar(a)
                 del self.overridedata[var]
 
         # more cookies for the cookie monster
-        if '_' in var:
+        if ':' in var:
             self._setvar_update_overrides(var, **loginfo)
 
         # setting var
@@ -567,8 +575,8 @@ class DataSmart(MutableMapping):
 
     def _setvar_update_overrides(self, var, **loginfo):
         # aka pay the cookie monster
-        override = var[var.rfind('_')+1:]
-        shortvar = var[:var.rfind('_')]
+        override = var[var.rfind(':')+1:]
+        shortvar = var[:var.rfind(':')]
         while override and __override_regexp__.match(override):
             if shortvar not in self.overridedata:
                 self.overridedata[shortvar] = []
@@ -577,9 +585,9 @@ class DataSmart(MutableMapping):
                 self.overridedata[shortvar] = list(self.overridedata[shortvar])
                 self.overridedata[shortvar].append([var, override])
             override = None
-            if "_" in shortvar:
-                override = var[shortvar.rfind('_')+1:]
-                shortvar = var[:shortvar.rfind('_')]
+            if ":" in shortvar:
+                override = var[shortvar.rfind(':')+1:]
+                shortvar = var[:shortvar.rfind(':')]
                 if len(shortvar) == 0:
                     override = None
 
@@ -590,8 +598,6 @@ class DataSmart(MutableMapping):
         """
         Rename the variable key to newkey
         """
-        key = key.replace(":", "_")
-        newkey = newkey.replace(":", "_")
         if key == newkey:
             bb.warn("Calling renameVar with equivalent keys (%s) is invalid" % key)
             return
@@ -620,7 +626,7 @@ class DataSmart(MutableMapping):
                 self.overridedata[newkey].append([v.replace(key, newkey), o])
                 self.renameVar(v, v.replace(key, newkey))
 
-        if '_' in newkey and val is None:
+        if ':' in newkey and val is None:
             self._setvar_update_overrides(newkey, **loginfo)
 
         loginfo['variable'] = key
@@ -632,15 +638,14 @@ class DataSmart(MutableMapping):
     def appendVar(self, var, value, **loginfo):
         loginfo['op'] = 'append'
         self.varhistory.record(**loginfo)
-        self.setVar(var + "_append", value, ignore=True, parsing=True)
+        self.setVar(var + ":append", value, ignore=True, parsing=True)
 
     def prependVar(self, var, value, **loginfo):
         loginfo['op'] = 'prepend'
         self.varhistory.record(**loginfo)
-        self.setVar(var + "_prepend", value, ignore=True, parsing=True)
+        self.setVar(var + ":prepend", value, ignore=True, parsing=True)
 
     def delVar(self, var, **loginfo):
-        var = var.replace(":", "_")
         self.expand_cache = {}
 
         loginfo['detail'] = ""
@@ -649,9 +654,9 @@ class DataSmart(MutableMapping):
         self.dict[var] = {}
         if var in self.overridedata:
             del self.overridedata[var]
-        if '_' in var:
-            override = var[var.rfind('_')+1:]
-            shortvar = var[:var.rfind('_')]
+        if ':' in var:
+            override = var[var.rfind(':')+1:]
+            shortvar = var[:var.rfind(':')]
             while override and override.islower():
                 try:
                     if shortvar in self.overridedata:
@@ -661,14 +666,13 @@ class DataSmart(MutableMapping):
                 except ValueError as e:
                     pass
                 override = None
-                if "_" in shortvar:
-                    override = var[shortvar.rfind('_')+1:]
-                    shortvar = var[:shortvar.rfind('_')]
+                if ":" in shortvar:
+                    override = var[shortvar.rfind(':')+1:]
+                    shortvar = var[:shortvar.rfind(':')]
                     if len(shortvar) == 0:
                          override = None
 
     def setVarFlag(self, var, flag, value, **loginfo):
-        var = var.replace(":", "_")
         self.expand_cache = {}
 
         if 'op' not in loginfo:
@@ -679,7 +683,7 @@ class DataSmart(MutableMapping):
             self._makeShadowCopy(var)
         self.dict[var][flag] = value
 
-        if flag == "_defaultval" and '_' in var:
+        if flag == "_defaultval" and ':' in var:
             self._setvar_update_overrides(var, **loginfo)
         if flag == "_defaultval" and var in self.overridevars:
             self._setvar_update_overridevars(var, value)
@@ -692,7 +696,6 @@ class DataSmart(MutableMapping):
             self.dict["__exportlist"]["_content"].add(var)
 
     def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False, retparser=False):
-        var = var.replace(":", "_")
         if flag == "_content":
             cachename = var
         else:
@@ -712,11 +715,11 @@ class DataSmart(MutableMapping):
             active = {}
             self.need_overrides()
             for (r, o) in overridedata:
-                # What about double overrides both with "_" in the name?
+                # FIXME What about double overrides both with "_" in the name?
                 if o in self.overridesset:
                     active[o] = r
-                elif "_" in o:
-                    if set(o.split("_")).issubset(self.overridesset):
+                elif ":" in o:
+                    if set(o.split(":")).issubset(self.overridesset):
                         active[o] = r
 
             mod = True
@@ -724,10 +727,10 @@ class DataSmart(MutableMapping):
                 mod = False
                 for o in self.overrides:
                     for a in active.copy():
-                        if a.endswith("_" + o):
+                        if a.endswith(":" + o):
                             t = active[a]
                             del active[a]
-                            active[a.replace("_" + o, "")] = t
+                            active[a.replace(":" + o, "")] = t
                             mod = True
                         elif a == o:
                             match = active[a]
@@ -746,28 +749,28 @@ class DataSmart(MutableMapping):
                 value = copy.copy(local_var["_defaultval"])
 
 
-        if flag == "_content" and local_var is not None and "_append" in local_var and not parsing:
+        if flag == "_content" and local_var is not None and ":append" in local_var and not parsing:
             if not value:
                 value = ""
             self.need_overrides()
-            for (r, o) in local_var["_append"]:
+            for (r, o) in local_var[":append"]:
                 match = True
                 if o:
-                    for o2 in o.split("_"):
+                    for o2 in o.split(":"):
                         if not o2 in self.overrides:
                             match = False                            
                 if match:
                     value = value + r
 
-        if flag == "_content" and local_var is not None and "_prepend" in local_var and not parsing:
+        if flag == "_content" and local_var is not None and ":prepend" in local_var and not parsing:
             if not value:
                 value = ""
             self.need_overrides()
-            for (r, o) in local_var["_prepend"]:
+            for (r, o) in local_var[":prepend"]:
 
                 match = True
                 if o:
-                    for o2 in o.split("_"):
+                    for o2 in o.split(":"):
                         if not o2 in self.overrides:
                             match = False                            
                 if match:
@@ -779,12 +782,12 @@ class DataSmart(MutableMapping):
         if expand:
             value = parser.value
 
-        if value and flag == "_content" and local_var is not None and "_remove" in local_var and not parsing:
+        if value and flag == "_content" and local_var is not None and ":remove" in local_var and not parsing:
             self.need_overrides()
-            for (r, o) in local_var["_remove"]:
+            for (r, o) in local_var[":remove"]:
                 match = True
                 if o:
-                    for o2 in o.split("_"):
+                    for o2 in o.split(":"):
                         if not o2 in self.overrides:
                             match = False                            
                 if match:
@@ -820,7 +823,6 @@ class DataSmart(MutableMapping):
         return value
 
     def delVarFlag(self, var, flag, **loginfo):
-        var = var.replace(":", "_")
         self.expand_cache = {}
 
         local_var, _ = self._findVar(var)
@@ -838,7 +840,6 @@ class DataSmart(MutableMapping):
             del self.dict[var][flag]
 
     def appendVarFlag(self, var, flag, value, **loginfo):
-        var = var.replace(":", "_")
         loginfo['op'] = 'append'
         loginfo['flag'] = flag
         self.varhistory.record(**loginfo)
@@ -846,7 +847,6 @@ class DataSmart(MutableMapping):
         self.setVarFlag(var, flag, newvalue, ignore=True)
 
     def prependVarFlag(self, var, flag, value, **loginfo):
-        var = var.replace(":", "_")
         loginfo['op'] = 'prepend'
         loginfo['flag'] = flag
         self.varhistory.record(**loginfo)
@@ -854,7 +854,6 @@ class DataSmart(MutableMapping):
         self.setVarFlag(var, flag, newvalue, ignore=True)
 
     def setVarFlags(self, var, flags, **loginfo):
-        var = var.replace(":", "_")
         self.expand_cache = {}
         infer_caller_details(loginfo)
         if not var in self.dict:
@@ -869,13 +868,12 @@ class DataSmart(MutableMapping):
             self.dict[var][i] = flags[i]
 
     def getVarFlags(self, var, expand = False, internalflags=False):
-        var = var.replace(":", "_")
         local_var, _ = self._findVar(var)
         flags = {}
 
         if local_var:
             for i in local_var:
-                if i.startswith("_") and not internalflags:
+                if i.startswith(("_", ":")) and not internalflags:
                     continue
                 flags[i] = local_var[i]
                 if expand and i in expand:
@@ -886,7 +884,6 @@ class DataSmart(MutableMapping):
 
 
     def delVarFlags(self, var, **loginfo):
-        var = var.replace(":", "_")
         self.expand_cache = {}
         if not var in self.dict:
             self._makeShadowCopy(var)
@@ -974,8 +971,8 @@ class DataSmart(MutableMapping):
             for (r, o) in self.overridedata[var]:
                 if o in self.overridesset:
                     overrides.add(var)
-                elif "_" in o:
-                    if set(o.split("_")).issubset(self.overridesset):
+                elif ":" in o:
+                    if set(o.split(":")).issubset(self.overridesset):
                         overrides.add(var)
 
         for k in keylist(self.dict):
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 977ba375bf..743ea0dfc0 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -97,7 +97,6 @@ class DataNode(AstNode):
     def eval(self, data):
         groupd = self.groupd
         key = groupd["var"]
-        key = key.replace(":", "_")
         loginfo = {
             'variable': key,
             'file': self.filename,
@@ -208,7 +207,6 @@ class ExportFuncsNode(AstNode):
     def eval(self, data):
 
         for func in self.n:
-            func = func.replace(":", "_")
             calledfunc = self.classname + "_" + func
 
             if data.getVar(func, False) and not data.getVarFlag(func, 'export_func', False):
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 07692e673c..3f9fe50642 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -228,7 +228,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #    self.dump_sigtask(fn, task, d.getVar("STAMP"), False)
 
         for task in taskdeps:
-            d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + ":" + task])
+            d.setVar("BB_BASEHASH:task-%s" % task, self.basehash[fn + ":" + task])
 
     def postparsing_clean_cache(self):
         #
@@ -325,7 +325,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         h = hashlib.sha256(data.encode("utf-8")).hexdigest()
         self.taskhash[tid] = h
-        #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
+        #d.setVar("BB_TASKHASH:task-%s" % task, taskhash[task])
         return h
 
     def writeout_file_checksum_cache(self):
-- 
2.30.2

