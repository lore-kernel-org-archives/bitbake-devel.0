Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9DF0775E2D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMv6026633; Wed, 8 Jul 2015 15:59:26 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id P2icZR_ZEApV; Wed,  8 Jul 2015 15:59:26 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMpZ026607
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:23 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004Ss-RY; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:04 +0100
Message-Id: <9a726b283bce21be452c18727968e5e6f2302646.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 10/16] data_smart: Tweak OVERRIDES value cache for performance
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:28 -0000

Updating the value of OVERRIDES whenever it changes turns out to be
extremely expensve/pointless. Instead, clear its value and re-establish
the value when we're going to use it.

This gives significant speed back.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4ccbedb..c800a9a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -311,8 +311,7 @@ class DataSmart(MutableMapping):
 
         # cookie monster tribute
         self.overridedata = {}
-
-        self.overrides = []
+        self.overrides = None
         self.overridevars = set(["OVERRIDES", "FILE"])
 
     def enableTracking(self):
@@ -360,8 +359,13 @@ class DataSmart(MutableMapping):
 
     def internal_finalize(self, parent = False):
         """Performs final steps upon the datastore, including application of overrides"""
+        self.overrides = None
 
-        self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+    def need_overrides(self):
+        if self.overrides is None:
+            self.overrides = []
+            self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+            self.expand_cache = {}
 
     def initVar(self, var):
         self.expand_cache = {}
@@ -587,6 +591,7 @@ class DataSmart(MutableMapping):
         if flag == "_content" and var in self.overridedata and not parsing:
             match = False
             active = {}
+            self.need_overrides()
             for (r, o) in self.overridedata[var]:
                 # What about double overrides both with "_" in the name?
                 if o in self.overrides:
@@ -619,6 +624,7 @@ class DataSmart(MutableMapping):
         if flag == "_content" and local_var is not None and "_append" in local_var and not parsing:
             if not value:
                 value = ""
+            self.need_overrides()
             for (r, o) in local_var["_append"]:
                 match = True
                 if o:
@@ -631,6 +637,7 @@ class DataSmart(MutableMapping):
         if flag == "_content" and local_var is not None and "_prepend" in local_var and not parsing:
             if not value:
                 value = ""
+            self.need_overrides()
             for (r, o) in local_var["_prepend"]:
 
                 match = True
@@ -652,6 +659,7 @@ class DataSmart(MutableMapping):
 
         if value and flag == "_content" and local_var is not None and "_remove" in local_var:
             removes = []
+            self.need_overrides()
             for (r, o) in local_var["_remove"]:
                 match = True
                 if o:
@@ -762,7 +770,7 @@ class DataSmart(MutableMapping):
 
         data._tracking = self._tracking
 
-        data.overrides = copy.copy(self.overrides)
+        data.overrides = None
         data.overridevars = copy.copy(self.overridevars)
         data.overridedata = copy.copy(self.overridedata)
 
-- 
2.1.0


