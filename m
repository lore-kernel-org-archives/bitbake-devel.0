Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B675475D1E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMv1026633; Wed, 8 Jul 2015 15:59:22 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9tQNCNmMzU2r; Wed,  8 Jul 2015 15:59:22 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExKAV026599
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:21 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqod-0004SE-NH; Wed, 08 Jul 2015 15:59:15 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:58:56 +0100
Message-Id: <0156fb06d6c0e2a1784d768b8295a2914ff6b974.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 02/16] data_smart: Remove need for update_data calls
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:25 -0000

Move the update_data functionality into internal data store operations
so the main finalize (update_data) call is a nop.

To make this work we need to call the internal finalization function
whenever OVERRIDES is changed to ensure values get updated correctly.

This has performance issues but the subsequant patches look into this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index b433489..77d0c61 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -298,6 +298,7 @@ class VariableHistory(object):
 class DataSmart(MutableMapping):
     def __init__(self, special = None, seen = None ):
         self.dict = {}
+        self.overrides = []
 
         if special is None:
             special = COWDictBase.copy()
@@ -354,11 +355,13 @@ class DataSmart(MutableMapping):
     def expand(self, s, varname = None):
         return self.expandWithRefs(s, varname).value
 
-
     def finalize(self, parent = False):
+        return
+
+    def internal_finalize(self, parent = False):
         """Performs final steps upon the datastore, including application of overrides"""
 
-        overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+        self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
         finalize_caller = {
             'op': 'finalize',
         }
@@ -383,7 +386,7 @@ class DataSmart(MutableMapping):
         # We only want to report finalization once per variable overridden.
         finalizes_reported = {}
 
-        for o in overrides:
+        for o in self.overrides:
             # calculate '_'+override
             l = len(o) + 1
 
@@ -417,12 +420,15 @@ class DataSmart(MutableMapping):
             if op in self._special_values:
                 appends = self._special_values[op] or []
                 for append in appends:
+                    self.handle_special_values(append, op)
+
+    def handle_special_values(self, append, op):
                     keep = []
                     for (a, o) in self.getVarFlag(append, op) or []:
                         match = True
                         if o:
                             for o2 in o.split("_"):
-                                if not o2 in overrides:
+                                if not o2 in self.overrides:
                                     match = False
                         if not match:
                             keep.append((a ,o))
@@ -502,6 +508,7 @@ class DataSmart(MutableMapping):
             except KeyError:
                 self._special_values[keyword] = set()
                 self._special_values[keyword].add(base)
+            self.handle_special_values(base, keyword)
 
             return
 
@@ -521,6 +528,9 @@ class DataSmart(MutableMapping):
         self.dict[var]["_content"] = value
         self.varhistory.record(**loginfo)
 
+        if var == "OVERRIDES":
+            self.internal_finalize(True)
+
     def _setvar_update_overrides(self, var):
         # aka pay the cookie monster
         override = var[var.rfind('_')+1:]
@@ -733,6 +743,7 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
+        data.overrides = copy.copy(self.overrides)
         data.varhistory = self.varhistory.copy()
         data.varhistory.datasmart = data
         data.inchistory = self.inchistory.copy()
-- 
2.1.0


