Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4AeC-0008KT-DQ for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 15:07:00 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCsteG003139
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:54:56 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02180-08 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:54:51 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCsk4V003133
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:54:47 +0100
Message-ID: <1345640087.3907.109.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Aug 2012 13:54:47 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] ast: Extract text variable in PythonMethodNode
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
X-List-Received-Date: Wed, 22 Aug 2012 13:07:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index b7eaff1..dfc0b02 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -125,17 +125,18 @@ class MethodNode(AstNode):
         self.body = body
 
     def eval(self, data):
+        text = '\n'.join(self.body)
         if self.func_name == "__anonymous":
             funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(string.maketrans('/.+-', '____'))))
             if not funcname in bb.methodpool._parsed_fns:
-                text = "def %s(d):\n" % (funcname) + '\n'.join(self.body)
+                text = "def %s(d):\n" % (funcname) + text
                 bb.methodpool.insert_method(funcname, text, self.filename)
             anonfuncs = data.getVar('__BBANONFUNCS') or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
         else:
             data.setVarFlag(self.func_name, "func", 1)
-            data.setVar(self.func_name, '\n'.join(self.body))
+            data.setVar(self.func_name, text)
 
 class PythonMethodNode(AstNode):
     def __init__(self, filename, lineno, function, modulename, body):




