Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2652A60017
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jan 2016 14:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0LE5l7w021606; Thu, 21 Jan 2016 14:05:47 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nSnrLb5QEnWU; Thu, 21 Jan 2016 14:05:46 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0LE5hIu021603
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Jan 2016 14:05:45 GMT
Message-ID: <1453385143.27999.166.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Jan 2016 14:05:43 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: Patrick Ohly <patrick.ohly@intel.com>
Subject: [PATCH] data_smart: Don't show exceptions for EOL literals
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
X-List-Received-Date: Thu, 21 Jan 2016 14:05:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If variables are unset, the code simply doesn't expand them, there
aren't errors. If the code is a python expression, this can get a bit
messy, see the attached test case. The python expansion code sees the }
of the unexpanded value rather than the close of the python expression
and then raises a SyntaxError exception.

Ideally, we'd update the code to match pairs of brackets. I don't know
how to do that with the current regex and this is unfortunately a
performance sensitive piece of code. We also run the risk of breaking
existing code in OE-Core where there are "{" characters but not "}"
to close them (PKGE and PE).

Rather than raising the exception, matching the existing "just return
the expression" behaviour seems more consistent with the standard 
variable behaviour.

This addresses an issue found in the recent image.bbclass code where
there are some variables we choose not to expand (TMPDIR/DATETIME).

This patch also adds a test case for this behaviour. It wouldn't preclude
improved bracket matching code in the future either.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 7e931c9..2797c78 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -384,7 +384,12 @@ class DataSmart(MutableMapping):
             olds = s
             try:
                 s = __expand_var_regexp__.sub(varparse.var_sub, s)
-                s = __expand_python_regexp__.sub(varparse.python_sub, s)
+                try:
+                    s = __expand_python_regexp__.sub(varparse.python_sub, s)
+                except SyntaxError as e:
+                    # Likely unmatched brackets, just don't expand the expression
+                    if e.msg != "EOL while scanning string literal":
+                        raise
                 if s == olds:
                     break
             except ExpansionError:
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index e9aab57..a96078f 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -80,6 +80,11 @@ class DataExpansions(unittest.TestCase):
         val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
         self.assertEqual(str(val), "value_of_foo value_of_bar")
 
+    def test_python_unexpanded(self):
+        self.d.setVar("bar", "${unsetvar}")
+        val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
+        self.assertEqual(str(val), "${@d.getVar('foo', True) + ' ${unsetvar}'}")
+
     def test_python_snippet_syntax_error(self):
         self.d.setVar("FOO", "${@foo = 5}")
         self.assertRaises(bb.data_smart.ExpansionError, self.d.getVar, "FOO", True)



