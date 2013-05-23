Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 3DD7F6086B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 09:50:10 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9rpDL017515 for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:53:51 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id c2oykl2WwSBQ for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:53:51 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9rmdo017510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:53:50 +0100
Message-ID: <1369302597.14887.29.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 23 May 2013 10:49:57 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker/cookerdata/utils: Improve context management
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 23 May 2013 09:50:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The current execution context management for bitbake is ugly and the
use of a global variable is nasty. Fixing that is hard, however we
can improve things to start to establish an API for accessing
and changing that context.

This patch also adds in an explicit reset of the context when we reparse
the configuration data which starts to improve the lifecycle of the data
in setups like hob.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 41f70ab..e868647 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1454,7 +1454,7 @@ class Parser(multiprocessing.Process):
         self.quit = quit
         self.init = init
         multiprocessing.Process.__init__(self)
-        self.context = bb.utils._context.copy()
+        self.context = bb.utils.get_context().copy()
         self.handlers = bb.event._handlers.copy()
 
     def run(self):
@@ -1490,7 +1490,8 @@ class Parser(multiprocessing.Process):
 
     def parse(self, filename, appends, caches_array):
         try:
-            bb.utils._context = self.context.copy()
+            # Reset our environment and handlers to the original settings
+            bb.utils.set_context(self.context.copy())
             bb.event._handlers = self.handlers.copy()
             return True, bb.cache.Cache.parse(filename, appends, self.cfg, caches_array)
         except Exception as exc:
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 70e22b4..efcc765 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -173,6 +173,7 @@ class CookerDataBuilder(object):
         self.postfiles = params.postfile
         self.tracking = params.tracking
 
+        bb.utils.set_context(bb.utils.clean_context())
         self.data = bb.data.init()
         if self.tracking:
             self.data.enableTracking()
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 1ecc44a..7db6e38 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -36,12 +36,22 @@ from contextlib import contextmanager
 
 logger = logging.getLogger("BitBake.Util")
 
+def clean_context():
+    return {
+        "os": os,
+        "bb": bb,
+        "time": time,
+    }
+
+def get_context():
+    return _context
+    
+
+def set_context(ctx):
+    _context = ctx
+
 # Context used in better_exec, eval
-_context = {
-    "os": os,
-    "bb": bb,
-    "time": time,
-}
+_context = clean_context()
 
 def explode_version(s):
     r = []
@@ -343,7 +353,7 @@ def better_exec(code, context, text = None, realfile = "<code>"):
     if not hasattr(code, "co_filename"):
         code = better_compile(code, realfile, realfile)
     try:
-        exec(code, _context, context)
+        exec(code, get_context(), context)
     except Exception as e:
         (t, value, tb) = sys.exc_info()
 
@@ -358,10 +368,10 @@ def better_exec(code, context, text = None, realfile = "<code>"):
         raise e
 
 def simple_exec(code, context):
-    exec(code, _context, context)
+    exec(code, get_context(), context)
 
 def better_eval(source, locals):
-    return eval(source, _context, locals)
+    return eval(source, get_context(), locals)
 
 @contextmanager
 def fileslocked(files):



