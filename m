Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 1240C6D959
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:00:29 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAPN0OeL025924 for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:00:24 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ITADwAmtP5HA for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:00:23 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAPN0KPE025921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:00:21 GMT
Message-ID: <1385420417.24083.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 23:00:17 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] codeparser: Drop unneeded variable separation
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
X-List-Received-Date: Mon, 25 Nov 2013 23:00:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There is no good reason to separately track var_references and
references so merge them and remove the unneeded variable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index e44e791..1164815 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -122,7 +122,7 @@ class PythonParser():
         name = self.called_node_name(node.func)
         if name in self.getvars or name in self.containsfuncs:
             if isinstance(node.args[0], ast.Str):
-                self.var_references.add(node.args[0].s)
+                self.references.add(node.args[0].s)
             else:
                 self.warn(node.func, node.args[0])
         elif name in self.execfuncs:
@@ -147,7 +147,6 @@ class PythonParser():
                 break
 
     def __init__(self, name, log):
-        self.var_references = set()
         self.var_execs = set()
         self.execs = set()
         self.references = set()
@@ -177,7 +176,6 @@ class PythonParser():
             if n.__class__.__name__ == "Call":
                 self.visit_Call(n)
 
-        self.references.update(self.var_references)
         self.references.update(self.var_execs)
 
         codeparsercache.pythoncacheextras[h] = {}



