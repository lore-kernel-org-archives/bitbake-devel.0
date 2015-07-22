Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9FC0673D0B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 22:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6MMTqQM013434 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:29:52 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yMI8p-57izfp for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:29:52 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6MMTecC013426
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:29:51 +0100
Message-ID: <1437604180.821.81.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Jul 2015 23:29:40 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] tests/parse: Add BBCLASSEXTEND multiple data store corruption reproducer
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
X-List-Received-Date: Wed, 22 Jul 2015 22:29:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

One data store changing a variable poked through into a different data
store. This test case replicates that issue where the value 'B' would 
become unset/disappear.

We also enhance parsehelper to generate files with an optional suffix
such as bbclass.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index 21fd78a..6beb76a 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -47,9 +47,9 @@ C = "3"
         self.d = bb.data.init()
         bb.parse.siggen = bb.siggen.init(self.d)
 
-    def parsehelper(self, content):
+    def parsehelper(self, content, suffix = ".bb"):
 
-        f = tempfile.NamedTemporaryFile(suffix = ".bb")
+        f = tempfile.NamedTemporaryFile(suffix = suffix)
         f.write(content)
         f.flush()
         os.chdir(os.path.dirname(f.name))
@@ -113,3 +113,35 @@ PN = "bc"
         d.setVar("OVERRIDES", "bc-dev")
         self.assertEqual(d.getVar("DESCRIPTION", True), "C D")
 
+
+    classextend = """
+VAR_var_override1 = "B"
+EXTRA = ":override1"
+OVERRIDES = "nothing${EXTRA}"
+
+BBCLASSEXTEND = "###CLASS###"
+"""
+    classextend_bbclass = """
+EXTRA = ""
+python () {
+    d.renameVar("VAR_var", "VAR_var2")
+}
+"""
+
+    #
+    # Test based upon a real world data corruption issue. One
+    # data store changing a variable poked through into a different data
+    # store. This test case replicates that issue where the value 'B' would 
+    # become unset/disappear.
+    #
+    def test_parse_classextend_contamination(self):
+        cls = self.parsehelper(self.classextend_bbclass, suffix=".bbclass")
+        #clsname = os.path.basename(cls.name).replace(".bbclass", "")
+        self.classextend = self.classextend.replace("###CLASS###", cls.name)
+        f = self.parsehelper(self.classextend)
+        alldata = bb.parse.handle(f.name, self.d)
+        d1 = alldata['']
+        d2 = alldata[cls.name]
+        self.assertEqual(d1.getVar("VAR_var", True), "B")
+        self.assertEqual(d2.getVar("VAR_var", True), None)
+



