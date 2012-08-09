Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SzZRl-0005jC-Sh
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 22:35:10 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q79KNLGX018821
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2012 13:23:21 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Thu, 9 Aug 2012 13:23:20 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 9 Aug 2012 15:23:17 -0500
Message-ID: <5b4d2f759a2c3b1968b3d2cb6ee304c781e200bb.1344543257.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1344543257.git.peter.seebach@windriver.com>
References: <cover.1344543257.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/3] data_smart.py: Track configuration file inclusions
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
X-List-Received-Date: Thu, 09 Aug 2012 20:35:10 -0000
Content-Type: text/plain

This is a preliminary attempt to create a structured representation of
the processing of include files.  It ignores line numbers because they're
meaningless.  It could probably be updated to, say, distinguish between
includes and requires.  Output is added to bitbake -e.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/data.py           |   16 ++++++++++++++++
 lib/bb/data_smart.py     |   41 ++++++++++++++++++++++++++++++++++++++---
 lib/bb/parse/__init__.py |    6 +++++-
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 64bf9a9..a762a40 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -253,10 +253,26 @@ def emit_env(o=sys.__stdout__, d = init(), all=False):
     isfunc = lambda key: bool(d.getVarFlag(key, "func"))
     keys = sorted((key for key in d.keys() if not key.startswith("__")), key=isfunc)
     grouped = groupby(keys, isfunc)
+    # Include history!
+    if d.tracking():
+        o.write('#\n# INCLUDE HISTORY:\n#\n')
+        emit_history(o, d.getIncludeHistory())
+        
     for isfunc, keys in grouped:
         for key in keys:
             emit_var(key, o, d, all and not isfunc) and o.write('\n')
 
+def emit_history(o, h, depth = 0):
+    if not h:
+        return
+    for event in h:
+        o.write("# %*s%s" % (depth * 2, "", event[0]))
+        if event[1]:
+            o.write(" includes:\n")
+            emit_history(o, event[1], depth + 1)
+        else:
+            o.write("\n")
+
 def exported_keys(d):
     return (key for key in d.keys() if not key.startswith('__') and
                                       d.getVarFlag(key, 'export') and
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 49e40ad..feab6c8 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -30,6 +30,7 @@ BitBake build tools.
 
 import traceback
 import copy, re
+import sys
 from collections import MutableMapping
 import logging
 import hashlib
@@ -116,6 +117,8 @@ class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
         self.dict = {}
         self.history = {}
+        self.include_history = []
+        self.include_stack = [(-1, self.include_history)]
 
         # cookie monster tribute
         self._special_values = special
@@ -124,6 +127,25 @@ class DataSmart(MutableMapping):
 
         self.expand_cache = {}
 
+    def includeLog(self, filename):
+        """includeLog(included_file) shows that the file was included
+        by the currently-processed file or context."""
+        if self._tracking_enabled:
+            event = (filename, [])
+            position = (len(self.include_stack[-1][1]), event[1])
+            self.include_stack[-1][1].append(event)
+            self.include_stack.append(position)
+
+    def includeLogDone(self, filename):
+        if self._tracking_enabled:
+            if len(self.include_stack) > 1:
+                self.include_stack.pop()
+            else:
+                bb.warn("Uh-oh:  includeLogDone(%s) tried to empty the stack." % filename)
+
+    def getIncludeHistory(self):
+        return self.include_history
+
     def tracking(self):
         return self._tracking_enabled
 
@@ -463,9 +485,22 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
-        data.history = self.history.copy()
-        data._tracking_enabled = self._tracking_enabled
-
+        if self._tracking_enabled:
+            data._tracking_enabled = self._tracking_enabled
+            data.history = self.history.copy()
+            data.include_history = copy.deepcopy(self.include_history)
+            data.include_stack = []
+            oldref = self.include_history
+            newref = data.include_history
+            # Create corresponding references, if we can
+            try:
+                for item in self.include_stack:
+                    if item[0] >= 0:
+                        newref = newref[item[0]][1]
+                    newevent = (item[0], newref)
+                    data.include_stack.append(newevent)
+            except Exception:
+                sys.exc_clear()
         return data
 
     def expandVarref(self, variable, parents=False, filename = None, lineno = None):
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 7b9c47e..0ea6a55 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -88,7 +88,11 @@ def handle(fn, data, include = 0):
     """Call the handler that is appropriate for this file"""
     for h in handlers:
         if h['supports'](fn, data):
-            return h['handle'](fn, data, include)
+            data.includeLog(fn)
+            try:
+                return h['handle'](fn, data, include)
+            finally:
+                data.includeLogDone(fn)
     raise ParseError("not a BitBake file", fn)
 
 def init(fn, data):
-- 
1.7.0.4



