Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5A22D77115
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 13:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12Ds7gD003597
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 13:54:07 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pv2haEgoy5KK for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 13:54:07 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12Ds1MB003594
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 13:54:02 GMT
Message-ID: <1454421241.27087.61.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Feb 2016 13:54:01 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] codeparser: Improve handling of data.expand() dependencies
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
X-List-Received-Date: Tue, 02 Feb 2016 13:54:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently bitbake doesn't parse into data.expand() expressions,
relying on high level expansion of python code to handle this.

One of the tests does however test this works.

We don't really want to be doing string expansion on python code,
so specifically parse into expand() function calls so that when
the high level behaviour is tweaked, the self tests continue to
pass and that we do continue to handle expand() function calls as
best we can.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 577b427..2094f13 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -221,6 +221,17 @@ class PythonParser():
                     self.references.add(node.args[0].s)
             else:
                 self.warn(node.func, node.args[0])
+        elif name and name.endswith(".expand"):
+            if isinstance(node.args[0], ast.Str):
+                value = node.args[0].s
+                d = bb.data.init()
+                parser = d.expandWithRefs(value, self.name)
+                self.references |= parser.references
+                self.execs |= parser.execs
+                for varname in parser.contains:
+                    if varname not in self.contains:
+                        self.contains[varname] = set()
+                    self.contains[varname] |= parser.contains[varname]
         elif name in self.execfuncs:
             if isinstance(node.args[0], ast.Str):
                 self.var_execs.add(node.args[0].s)
@@ -243,6 +254,7 @@ class PythonParser():
                 break
 
     def __init__(self, name, log):
+        self.name = name
         self.var_execs = set()
         self.contains = {}
         self.execs = set()



