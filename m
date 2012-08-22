Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4AdS-0008JJ-DJ for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 15:06:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCsAGP003130
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:54:10 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02380-06 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:54:05 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCs0nQ003124
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:54:01 +0100
Message-ID: <1345640041.3907.107.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Aug 2012 13:54:01 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: ast: Rename PythonMethodNode define variable to modulename
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
X-List-Received-Date: Wed, 22 Aug 2012 13:06:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

It was hard for me to understand what the define variable was, modulename
is hopefully a bit better.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 4d3a623..b7eaff1 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -138,10 +138,10 @@ class MethodNode(AstNode):
             data.setVar(self.func_name, '\n'.join(self.body))
 
 class PythonMethodNode(AstNode):
-    def __init__(self, filename, lineno, function, define, body):
+    def __init__(self, filename, lineno, function, modulename, body):
         AstNode.__init__(self, filename, lineno)
         self.function = function
-        self.define = define
+        self.modulename = modulename
         self.body = body
 
     def eval(self, data):
@@ -149,8 +149,8 @@ class PythonMethodNode(AstNode):
         # 'this' file. This means we will not parse methods from
         # bb classes twice
         text = '\n'.join(self.body)
-        if not bb.methodpool.parsed_module(self.define):
-            bb.methodpool.insert_method(self.define, text, self.filename)
+        if not bb.methodpool.parsed_module(self.modulename):
+            bb.methodpool.insert_method(self.modulename, text, self.filename)
         data.setVarFlag(self.function, "func", 1)
         data.setVarFlag(self.function, "python", 1)
         data.setVar(self.function, text)
@@ -280,8 +280,8 @@ def handleData(statements, filename, lineno, groupd):
 def handleMethod(statements, filename, lineno, func_name, body):
     statements.append(MethodNode(filename, lineno, func_name, body))
 
-def handlePythonMethod(statements, filename, lineno, funcname, root, body):
-    statements.append(PythonMethodNode(filename, lineno, funcname, root, body))
+def handlePythonMethod(statements, filename, lineno, funcname, modulename, body):
+    statements.append(PythonMethodNode(filename, lineno, funcname, modulename, body))
 
 def handleMethodFlags(statements, filename, lineno, key, m):
     statements.append(MethodFlagsNode(filename, lineno, key, m))




