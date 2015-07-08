Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6F4E475E05
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMv3026633; Wed, 8 Jul 2015 15:59:24 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2NSa6Ln4C1KQ; Wed,  8 Jul 2015 15:59:24 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExM9Y026602
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:23 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004SS-Ev; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:58:59 +0100
Message-Id: <0311c28b17c6337d7d2bb5f9d2056992cedd4691.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 05/16] data_smart: Cache overrides and fix data store
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

Rather than repeatedly expanding the value of OVERRIDES, cache
the value and update it when things change.

There were also some bugs introduced in the replaces functionality
which this approach fixes by ensuring the replaces data is updated
at the correct points.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index eee5827..884ca19 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -311,6 +311,7 @@ class DataSmart(MutableMapping):
 
         self.expand_cache = {}
 
+        self.overrides = []
         self.overridevars = set(["OVERRIDES", "FILE"])
         self.replaces = {}
 
@@ -360,7 +361,7 @@ class DataSmart(MutableMapping):
     def internal_finalize(self, parent = False):
         """Performs final steps upon the datastore, including application of overrides"""
 
-        overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+        self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
 
         #
         # Well let us see what breaks here. We used to iterate
@@ -380,7 +381,7 @@ class DataSmart(MutableMapping):
 
         self.replaces = {}
 
-        for o in overrides:
+        for o in self.overrides:
             # calculate '_'+override
             l = len(o) + 1
 
@@ -393,6 +394,18 @@ class DataSmart(MutableMapping):
                 name = var[:-l]
                 self.replaces[name] = var
 
+    def internal_finalize2(self, var, o):
+        """Performs final steps upon the datastore, including application of overrides"""
+
+        l = len(o) + 1
+        name = var[:-l]
+
+        if name in self.replaces:
+            del self.replaces[name]
+        for o in self.overrides:
+            if o in self._seen_overrides and name + "_" + o in self._seen_overrides[o]:
+                self.replaces[name] = name + "_" + o
+
     def initVar(self, var):
         self.expand_cache = {}
         if not var in self.dict:
@@ -457,6 +470,12 @@ class DataSmart(MutableMapping):
         if "_prepend" in self.dict[var]:
             del self.dict[var]["_prepend"]
 
+        if var in self.replaces:
+            del self.replaces[var]
+        for o in self.overrides:
+            if o in self._seen_overrides and var + "_" + o in self._seen_overrides[o]:
+                self.delVar(var + "_" + o)
+
         # more cookies for the cookie monster
         if '_' in var:
             self._setvar_update_overrides(var)
@@ -477,6 +496,7 @@ class DataSmart(MutableMapping):
             if override not in self._seen_overrides:
                 self._seen_overrides[override] = set()
             self._seen_overrides[override].add( var )
+            self.internal_finalize2(var, override)
             override = None
             if "_" in shortvar:
                 override = var[shortvar.rfind('_')+1:]
@@ -534,6 +554,7 @@ class DataSmart(MutableMapping):
             override = var[var.rfind('_')+1:]
             if override and override in self._seen_overrides and var in self._seen_overrides[override]:
                 self._seen_overrides[override].remove(var)
+                self.internal_finalize2(var, override)
 
     def setVarFlag(self, var, flag, value, **loginfo):
         self.expand_cache = {}
@@ -574,9 +595,8 @@ class DataSmart(MutableMapping):
             for (r, o) in local_var["_append"]:
                 match = True
                 if o:
-                    overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
                     for o2 in o.split("_"):
-                        if not o2 in overrides:
+                        if not o2 in self.overrides:
                             match = False                            
                 if match:
                     value = value + r
@@ -587,9 +607,8 @@ class DataSmart(MutableMapping):
             for (r, o) in local_var["_prepend"]:
                 match = True
                 if o:
-                    overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
                     for o2 in o.split("_"):
-                        if not o2 in overrides:
+                        if not o2 in self.overrides:
                             match = False                            
                 if match:
                     value = r + value
@@ -608,9 +627,8 @@ class DataSmart(MutableMapping):
             for (r, o) in local_var["_remove"]:
                 match = True
                 if o:
-                    overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
                     for o2 in o.split("_"):
-                        if not o2 in overrides:
+                        if not o2 in self.overrides:
                             match = False                            
                 if match:
                     removes.extend(self.expand(r).split())
@@ -716,6 +734,7 @@ class DataSmart(MutableMapping):
 
         data._tracking = self._tracking
 
+        data.overrides = copy.copy(self.overrides)
         data.overridevars = copy.copy(self.overridevars)
 
         return data
-- 
2.1.0


