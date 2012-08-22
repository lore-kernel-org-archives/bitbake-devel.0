Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4Acd-0008Hx-Gi for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 15:05:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCrJNZ003121
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:53:19 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02180-07 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:53:12 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCrAMe003115
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:53:11 +0100
Message-ID: <1345639991.3907.106.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Aug 2012 13:53:11 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: methodpool: Clean up the parsed module list handling to be slightly less insane
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
X-List-Received-Date: Wed, 22 Aug 2012 13:05:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This removes some dubious functions and replaces them with a simpler, cleaner
API which better describes what the code is doing. Unused code/variables are
removed and comments tweaked.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/methodpool.py b/bitbake/lib/bb/methodpool.py
index 3b8e5c1..2fb5d96 100644
--- a/bitbake/lib/bb/methodpool.py
+++ b/bitbake/lib/bb/methodpool.py
@@ -33,9 +33,7 @@
 from bb.utils import better_compile, better_exec
 from bb       import error
 
-# A dict of modules we have handled
-# it is the number of .bbclasses + x in size
-_parsed_methods = { }
+# A dict of function names we have seen
 _parsed_fns     = { }
 
 def insert_method(modulename, code, fn):
@@ -56,15 +54,18 @@ def insert_method(modulename, code, fn):
         else:
             _parsed_fns[name] = modulename
 
+# A dict of modules the parser has finished with
+_parsed_methods = {}
+
 def parsed_module(modulename):
     """
-    Inform me file xyz was parsed
+    Has module been parsed?
     """
     return modulename in _parsed_methods
 
-
-def get_parsed_dict():
+def set_parsed_module(modulename):
     """
-    shortcut
+    Set module as parsed
     """
-    return _parsed_methods
+    _parsed_methods[modulename] = True
+
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index b88d5f5..4d3a623 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -31,7 +31,6 @@ import itertools
 from bb import methodpool
 from bb.parse import logger
 
-__parsed_methods__ = bb.methodpool.get_parsed_dict()
 _bbversions_re = re.compile(r"\[(?P<from>[0-9]+)-(?P<to>[0-9]+)\]")
 
 class StatementGroup(list):
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 625a2a2..2e0647b 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -161,7 +161,7 @@ def handle(fn, d, include):
 
     # we have parsed the bb class now
     if ext == ".bbclass" or ext == ".inc":
-        bb.methodpool.get_parsed_dict()[base_name] = 1
+        bb.methodpool.set_parsed_module(base_name)
 
     return d
 




