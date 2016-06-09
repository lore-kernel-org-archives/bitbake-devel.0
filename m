Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8D05C60767
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jun 2016 22:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u59Mc4ou017804 for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Jun 2016 23:38:04 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ce2IB60JviGM for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jun 2016 23:38:04 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u59Mc1t8017801
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Jun 2016 23:38:02 +0100
Message-ID: <1465511881.13979.156.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 09 Jun 2016 23:38:01 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] data_smart/utils: Add 'd' to the context used for better_eval in python expansion
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
X-List-Received-Date: Thu, 09 Jun 2016 22:38:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If a line like:

foo=${@' '.join([d.getVar('D', True) + x for x in (' '.join([d.getVar('FILES_bash-' + p, True) or '' for p in ['lib', 'dev', 'staticdev', 'doc', 'locale', 'ptest']])).split()])}

is added to a function like do_install, it fails with Exception name 'd'
is not defined. This is due to a change of behaviour in python 3 compared
to python 2. Generator expressions, dict comprehensions  and set comprehensions
are executed in a new scope but list comprehensions in python 2.x are not. In
python 3 they all use a new scope.

To allow these kinds of expressions to work, the easiest approach is
to add 'd' to the global context. To do this, an extra optional parameter
is added to better_eval and we use that to add 'd'.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 25c412c..f100446 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -135,7 +135,7 @@ class VariableParse:
                     self.contains[k] = parser.contains[k].copy()
                 else:
                     self.contains[k].update(parser.contains[k])
-            value = utils.better_eval(codeobj, DataContext(self.d))
+            value = utils.better_eval(codeobj, DataContext(self.d), {'d' : self.d})
             return str(value)
 
 
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 8f75871..0a1bf68 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -37,6 +37,7 @@ import errno
 import signal
 import ast
 import collections
+import copy
 from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
@@ -407,8 +408,13 @@ def better_exec(code, context, text = None, realfile = "<code>", pythonexception
 def simple_exec(code, context):
     exec(code, get_context(), context)
 
-def better_eval(source, locals):
-    return eval(source, get_context(), locals)
+def better_eval(source, locals, extraglobals = None):
+    ctx = get_context()
+    if extraglobals:
+        ctx = copy.copy(ctx)
+        for g in extraglobals:
+            ctx[g] = extraglobals[g]
+    return eval(source, ctx, locals)
 
 @contextmanager
 def fileslocked(files):



