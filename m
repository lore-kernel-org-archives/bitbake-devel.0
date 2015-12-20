Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D09277316F
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Dec 2015 13:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBKDMc1R025244 for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Dec 2015 13:22:38 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qi-pEW5njwNL for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Dec 2015 13:22:38 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBKDMJlu025241
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Dec 2015 13:22:36 GMT
Message-ID: <1450617739.8461.93.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 Dec 2015 13:22:19 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] event/utils/methodpool: Add a cache of compiled code objects
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
X-List-Received-Date: Sun, 20 Dec 2015 13:22:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

With the addition of function line number handling, the overhead of
the compile functions is no longer negligible. We tend to compile
the same pieces of code over and over again so wrapping a cache around
this is beneficial and removes the overhead of line numbered functions.

Life cycle of a cache using a global like this is in theory problematic
although in reality unlikely to be an issue. It can be dealt with
if/as/when we deal with the other global caches.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index bd2b0a4..5ffe89e 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -31,6 +31,7 @@ except ImportError:
 import logging
 import atexit
 import traceback
+import ast
 import bb.utils
 import bb.compat
 import bb.exceptions
@@ -189,13 +190,15 @@ def register(name, handler, mask=None, filename=None, lineno=None):
         if isinstance(handler, basestring):
             tmp = "def %s(e):\n%s" % (name, handler)
             try:
-                import ast
-                if filename is None:
-                    filename = "%s(e)" % name
-                code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
-                if lineno is not None:
-                    ast.increment_lineno(code, lineno-1)
-                code = compile(code, filename, "exec")
+                code = bb.methodpool.compile_cache(tmp)
+                if not code:
+                    if filename is None:
+                        filename = "%s(e)" % name
+                    code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
+                    if lineno is not None:
+                        ast.increment_lineno(code, lineno-1)
+                    code = compile(code, filename, "exec")
+                    bb.methodpool.compile_cache_add(tmp, code)
             except SyntaxError:
                 logger.error("Unable to register event handler '%s':\n%s", name,
                              ''.join(traceback.format_exc(limit=0)))
diff --git a/bitbake/lib/bb/methodpool.py b/bitbake/lib/bb/methodpool.py
index b2ea1a1..492c3a5 100644
--- a/bitbake/lib/bb/methodpool.py
+++ b/bitbake/lib/bb/methodpool.py
@@ -27,3 +27,14 @@ def insert_method(modulename, code, fn, lineno):
     comp = better_compile(code, modulename, fn, lineno=lineno)
     better_exec(comp, None, code, fn)
 
+compilecache = {}
+
+def compile_cache(code):
+    h = hash(code)
+    if h in compilecache:
+        return compilecache[h]
+    return None
+
+def compile_cache_add(code, compileobj):
+    h = hash(code)
+    compilecache[h] = compileobj
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index e564bb6..fa2853e 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -298,10 +298,15 @@ def better_compile(text, file, realfile, mode = "exec", lineno = None):
     will print the offending lines.
     """
     try:
+        cache = bb.methodpool.compile_cache(text)
+        if cache:
+            return cache
         code = compile(text, realfile, mode, ast.PyCF_ONLY_AST)
         if lineno is not None:
             ast.increment_lineno(code, lineno)
-        return compile(code, realfile, mode)
+        code = compile(code, realfile, mode)
+        bb.methodpool.compile_cache_add(text, code)
+        return code
     except Exception as e:
         error = []
         # split the text into lines again



