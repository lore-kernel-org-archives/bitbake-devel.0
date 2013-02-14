Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U675b-0005Oi-RF for bitbake-devel@lists.openembedded.org;
	Thu, 14 Feb 2013 23:15:43 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1EM5c38015491 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 22:05:38 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WjKXSDDyxfvM for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 22:05:38 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1EM5Wja015466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 22:05:35 GMT
Message-ID: <1360879161.11225.128.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Feb 2013 21:59:21 +0000
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Subject: [PATCH] codeparser: Track bb.utils.contains usage
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
X-List-Received-Date: Thu, 14 Feb 2013 22:15:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The bb.utils.contains function usage is getting increasingly used in the metadata
but isn't handled automatically by the python dependency tracking code. This patch
changes that and also adds the "OE" names for the functions.

Whilst there are reasons this is a bad idea, its likely outweighed by the
shear number of these references and the current holes in dependency information
which we're now relying heavily upon.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 979e6bd..78f82e1 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -101,6 +101,7 @@ class BufferedLogger(Logger):
 
 class PythonParser():
     getvars = ("d.getVar", "bb.data.getVar", "data.getVar", "d.appendVar", "d.prependVar")
+    containsfuncs = ("bb.utils.contains", "base_contains", "oe.utils.contains")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
     def warn(self, func, arg):
@@ -119,7 +120,7 @@ class PythonParser():
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
-        if name in self.getvars:
+        if name in self.getvars or name in self.containsfuncs:
             if isinstance(node.args[0], ast.Str):
                 self.var_references.add(node.args[0].s)
             else:




