Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ED46C605B2
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 May 2014 10:26:23 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s43AFlv7006146 for <bitbake-devel@lists.openembedded.org>;
	Sat, 3 May 2014 11:15:47 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 889-5tjtA-eu for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 May 2014 11:15:47 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s43AFg5F006141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 3 May 2014 11:15:44 +0100
Message-ID: <1399112137.12731.96.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 03 May 2014 11:15:37 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] codeparser: Fix to better catch all getVar references
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
X-List-Received-Date: Sat, 03 May 2014 10:26:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if you do localdata.getVar, the code parser simply ignores
the references. Change the code to use endswith() to catch more of the
references. These names are probably unique enough to get away with this.

Bump the cache version to ensure things get updated.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 8439efb..2e8de12 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -35,7 +35,7 @@ def check_indent(codestr):
 
 class CodeParserCache(MultiProcessCache):
     cache_file_name = "bb_codeparser.dat"
-    CACHE_VERSION = 5
+    CACHE_VERSION = 6
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -102,7 +102,7 @@ class BufferedLogger(Logger):
         self.buffer = []
 
 class PythonParser():
-    getvars = ("d.getVar", "bb.data.getVar", "data.getVar", "d.appendVar", "d.prependVar")
+    getvars = (".getVar", ".appendVar", ".prependVar")
     containsfuncs = ("bb.utils.contains", "base_contains", "oe.utils.contains", "bb.utils.contains_any")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
@@ -122,7 +122,7 @@ class PythonParser():
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
-        if name in self.getvars or name in self.containsfuncs:
+        if name and name.endswith(self.getvars) or name in self.containsfuncs:
             if isinstance(node.args[0], ast.Str):
                 varname = node.args[0].s
                 if name in self.containsfuncs and isinstance(node.args[1], ast.Str):



