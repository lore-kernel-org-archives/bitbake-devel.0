Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SQ5HA-00070R-3B
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 01:17:32 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q43KTSRk017897
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 May 2012 13:29:28 -0700 (PDT)
Received: from wrlaptop (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 3 May 2012 13:29:28 -0700
Date: Thu, 3 May 2012 15:29:00 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Peter Seebach <peter.seebach@windriver.com>
Message-ID: <20120503152900.36c330cc@wrlaptop>
In-Reply-To: <20120503141535.4aae4df9@wrlaptop>
References: <20120503132127.1cc1b29a@wrlaptop>
	<20120503141535.4aae4df9@wrlaptop>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake patches: Track include history and variable modification history
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
X-List-Received-Date: Thu, 03 May 2012 23:17:32 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Thu, 3 May 2012 14:15:35 -0500
Peter Seebach <peter.seebach@windriver.com> wrote:

> On Thu, 3 May 2012 13:21:27 -0500
> Peter Seebach <peter.seebach@windriver.com> wrote:
> 
> > Note that the include tracking is noticably incomplete; most
> > obviously, in this example, it never finds layer.conf.  Haven't
> > quite figured out why, still looking at it, but the basic
> > principle should stay the same.
> 
> Mystery solved, for reference:  The tracking needs to happen
> in bb.parse.handle, and that turns out to require making the
> createCopy in the := assignment case suppress the history copy,
> or maybe just making the history copy bug-tolerant.

Here's the second part fixed up.  Handling is moved to
bb.parse.handle, so it catches a lot more files, and createCopy
now fails silently if it can't copy history.  Produces much more
comprehensive output.

commit d945f8c854c0b9eaff6d9c93b1c00c663b2858cf
Author: Peter Seebach <peter.seebach@windriver.com>
Date:   Wed May 2 12:11:08 2012 -0500

    data_smart.py: Track configuration file inclusions
    
    This is a preliminary attempt to create a structured representation of
    the processing of include files.  It ignores line numbers because they're
    meaningless.  It could probably be updated to, say, distinguish between
    includes and requires.  Output is added to bitbake -e.
    
    Signed-off-by: Peter Seebach <peter.seebach@windriver.com>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 74efc5d..5ad7862 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -246,10 +246,26 @@ def emit_env(o=sys.__stdout__, d = init(), all=False):
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
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 5a8917f..b68de05 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -29,6 +29,7 @@ BitBake build tools.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import copy, re
+import sys
 from collections import MutableMapping
 import logging
 import hashlib
@@ -112,6 +113,8 @@ class DataSmart(MutableMapping):
     def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
         self.dict = {}
         self.history = {}
+        self.include_history = []
+        self.include_stack = [(-1, self.include_history)]
 
         # cookie monster tribute
         self._special_values = special
@@ -120,6 +123,25 @@ class DataSmart(MutableMapping):
 
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
 
@@ -434,9 +456,22 @@ class DataSmart(MutableMapping):
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
+                        newref = newref[item[0]]
+                    newevent = (item[0], newref)
+                    data.include_stack.append(newevent)
+            except Exception:
+                sys.exc_clear()
         return data
 
     def expandVarref(self, variable, parents=False, filename = 'unknown', lineno = 'unknown'):
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 3c3feee..26b501b 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
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
Listen, get this.  Nobody with a good compiler needs to be justified.


