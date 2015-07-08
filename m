Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D679475DE6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMv4026633; Wed, 8 Jul 2015 15:59:25 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id o9U4ZenfxE3q; Wed,  8 Jul 2015 15:59:25 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMXu026606
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:23 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004Sn-P4; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:03 +0100
Message-Id: <821c819294d0ef9bb27e84453c16ba3979287a57.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 09/16] data_smart: Seperate out the override cache
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

Using an internal flag for override mapping turns out to be slower
than is optimal, not least as we don't want the keys list to list
variables that have no value other than a potential override expansion.

Maintinaing a seperate cache is therefore more optimal from a speed
perspective.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 55 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index d414bf4..4ccbedb 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -310,6 +310,8 @@ class DataSmart(MutableMapping):
         self.expand_cache = {}
 
         # cookie monster tribute
+        self.overridedata = {}
+
         self.overrides = []
         self.overridevars = set(["OVERRIDES", "FILE"])
 
@@ -434,8 +436,18 @@ class DataSmart(MutableMapping):
                 del self.dict[var]["_append"]
             if "_prepend" in self.dict[var]:
                 del self.dict[var]["_prepend"]
-            if "_overrides" in self.dict[var]:
-                del self.dict[var]["_overrides"]
+            if var in self.overridedata:
+                active = []
+                self.need_overrides()
+                for (r, o) in self.overridedata[var]:
+                    if o in self.overrides:
+                        active.append(r)
+                    elif "_" in o:
+                        if set(o.split("_")).issubset(set(self.overrides)):
+                            active.append(r)
+                for a in active:
+                    self.delVar(a)
+                del self.overridedata[var]
 
         # more cookies for the cookie monster
         if '_' in var:
@@ -454,10 +466,10 @@ class DataSmart(MutableMapping):
         override = var[var.rfind('_')+1:]
         shortvar = var[:var.rfind('_')]
         while override:
-            l = self.getVarFlag(shortvar, "_overrides") or []
-            if [var, override] not in l:
-                l.append([var, override])
-                self.setVarFlag(shortvar, "_overrides", l, ignore=True)
+            if shortvar not in self.overridedata:
+                self.overridedata[shortvar] = []
+            if [var, override] not in self.overridedata[shortvar]:
+                self.overridedata[shortvar].append([var, override])
             for event in self.varhistory.variable(var):
                 if 'flag' in loginfo and not loginfo['flag'].startswith("_"):
                     continue
@@ -498,6 +510,12 @@ class DataSmart(MutableMapping):
             dest.extend(src)
             self.setVarFlag(newkey, i, dest, ignore=True)
 
+        if key in self.overridedata:
+            self.overridedata[newkey] = []
+            for (v, o) in self.overridedata[key]:
+                self.overridedata[newkey].append([v.replace(key, newkey), o])
+                self.renameVar(v, v.replace(key, newkey))
+
         if '_' in newkey and val is None:
             self._setvar_update_overrides(newkey, **loginfo)
 
@@ -525,15 +543,23 @@ class DataSmart(MutableMapping):
         self.varhistory.record(**loginfo)
         self.expand_cache = {}
         self.dict[var] = {}
+        if var in self.overridedata:
+            del self.overridedata[var]
         if '_' in var:
             override = var[var.rfind('_')+1:]
             shortvar = var[:var.rfind('_')]
-            l = self.getVarFlag(shortvar, "_overrides") or []
-            try:
-                l.remove([var, override])
-            except ValueError as e:
-                pass
-            self.setVarFlag(shortvar, "_overrides", l, ignore=True)
+            while override:
+                try:
+                    if shortvar in self.overridedata:
+                        self.overridedata[shortvar].remove([var, override])
+                except ValueError as e:
+                    pass
+                override = None
+                if "_" in shortvar:
+                    override = var[shortvar.rfind('_')+1:]
+                    shortvar = var[:shortvar.rfind('_')]
+                    if len(shortvar) == 0:
+                         override = None
 
     def setVarFlag(self, var, flag, value, **loginfo):
         self.expand_cache = {}
@@ -558,10 +584,10 @@ class DataSmart(MutableMapping):
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False, parsing=False):
         local_var = self._findVar(var)
         value = None
-        if flag == "_content" and local_var is not None and "_overrides" in local_var and not parsing:
+        if flag == "_content" and var in self.overridedata and not parsing:
             match = False
             active = {}
-            for (r, o) in local_var["_overrides"]:
+            for (r, o) in self.overridedata[var]:
                 # What about double overrides both with "_" in the name?
                 if o in self.overrides:
                     active[o] = r
@@ -738,6 +764,7 @@ class DataSmart(MutableMapping):
 
         data.overrides = copy.copy(self.overrides)
         data.overridevars = copy.copy(self.overridevars)
+        data.overridedata = copy.copy(self.overridedata)
 
         return data
 
-- 
2.1.0


