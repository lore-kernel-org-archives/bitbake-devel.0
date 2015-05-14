Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 853AF72207
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 16:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4EGv4gN015805 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 17:57:04 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eFwZ57Ermymq for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 17:57:04 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4EGupen015783
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 17:57:03 +0100
Message-ID: <1431622611.18723.2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 May 2015 17:56:51 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] BBHandler: Error for incomplete function definitions
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
X-List-Received-Date: Thu, 14 May 2015 16:57:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add some sanity checks on the parsing state engine when returning data
so that incomplete functions raise parse errors.

This means a recipe doing:

do_somefunction {
     echo 1

VAR = "1"

will now raise a ParseError. To get the right file/line information,
__infunc__ was changed to a list.

[YOCTO #7633]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 9633340..56d4672 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -32,7 +32,7 @@ import bb.build, bb.utils
 from bb import data
 
 from . import ConfHandler
-from .. import resolve_file, ast, logger
+from .. import resolve_file, ast, logger, ParseError
 from .ConfHandler import include, init
 
 # For compatibility
@@ -48,7 +48,7 @@ __def_regexp__           = re.compile( r"def\s+(\w+).*:" )
 __python_func_regexp__   = re.compile( r"(\s+.*)|(^$)" )
 
 
-__infunc__ = ""
+__infunc__ = []
 __inpython__ = False
 __body__   = []
 __classname__ = ""
@@ -120,7 +120,7 @@ def get_statements(filename, absolute_filename, base_name):
 def handle(fn, d, include):
     global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __infunc__, __body__, __residue__, __classname__
     __body__ = []
-    __infunc__ = ""
+    __infunc__ = []
     __classname__ = ""
     __residue__ = []
 
@@ -159,6 +159,11 @@ def handle(fn, d, include):
         if include == 0:
             return { "" : d }
 
+    if __infunc__:
+        raise ParseError("Shell function %s is never closed" % __infunc__[0], __infunc__[1], __infunc__[2])
+    if __residue__:
+        raise ParseError("Leftover unparsed (incomplete?) data %s from %s" % __residue__, fn)
+
     if ext != ".bbclass" and include == 0:
         return ast.multi_finalize(fn, d)
 
@@ -172,8 +177,8 @@ def feeder(lineno, s, fn, root, statements):
     if __infunc__:
         if s == '}':
             __body__.append('')
-            ast.handleMethod(statements, fn, lineno, __infunc__, __body__)
-            __infunc__ = ""
+            ast.handleMethod(statements, fn, lineno, __infunc__[0], __body__)
+            __infunc__ = []
             __body__ = []
         else:
             __body__.append(s)
@@ -217,8 +222,8 @@ def feeder(lineno, s, fn, root, statements):
 
     m = __func_start_regexp__.match(s)
     if m:
-        __infunc__ = m.group("func") or "__anonymous"
-        ast.handleMethodFlags(statements, fn, lineno, __infunc__, m)
+        __infunc__ = [m.group("func") or "__anonymous", fn, lineno]
+        ast.handleMethodFlags(statements, fn, lineno, __infunc__[0], m)
         return
 
     m = __def_regexp__.match(s)



