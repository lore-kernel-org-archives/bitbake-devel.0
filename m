Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F284C731C1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 17:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u04HVNgI011495
	for <bitbake-devel@lists.openembedded.org>; Mon, 4 Jan 2016 17:31:23 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bjX914sCnD0H for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 17:31:23 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u04HVJmL011491
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 4 Jan 2016 17:31:20 GMT
Message-ID: <1451928679.7598.12.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 04 Jan 2016 17:31:19 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] codeparser: Add support for correct linenumbers
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
X-List-Received-Date: Mon, 04 Jan 2016 17:31:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, if there is something like a python indentation error in a
python function, the linenumbers and even file aren't reported correctly.

This allows lineno and filename parameters to be passed in to correct this.

The lack of a lineno parameter to python's compile() function is worked
around by using empty linefeeds. Ugly, but effective and with minimal
performance overhead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 6c9a42d..577b427 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -28,6 +28,10 @@ def check_indent(codestr):
         return codestr
 
     if codestr[i-1] == "\t" or codestr[i-1] == " ":
+        if codestr[0] == "\n":
+            # Since we're adding a line, we need to remove one line of any empty padding
+            # to ensure line numbers are correct
+            codestr = codestr[1:]
         return "if 1:\n" + codestr
 
     return codestr
@@ -248,7 +252,7 @@ class PythonParser():
         self.unhandled_message = "in call of %s, argument '%s' is not a string literal"
         self.unhandled_message = "while parsing %s, %s" % (name, self.unhandled_message)
 
-    def parse_python(self, node):
+    def parse_python(self, node, lineno=0, filename="<string>"):
         if not node or not node.strip():
             return
 
@@ -270,7 +274,9 @@ class PythonParser():
                 self.contains[i] = set(codeparsercache.pythoncacheextras[h].contains[i])
             return
 
-        code = compile(check_indent(str(node)), "<string>", "exec",
+        # We can't add to the linenumbers for compile, we can pad to the correct number of blank lines though
+        node = "\n" * int(lineno) + node
+        code = compile(check_indent(str(node)), filename, "exec",
                        ast.PyCF_ONLY_AST)
 
         for n in ast.walk(code):



