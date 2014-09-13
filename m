Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7C50965E38
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 13 Sep 2014 07:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8D7oVNS015841 for <bitbake-devel@lists.openembedded.org>;
	Sat, 13 Sep 2014 08:50:31 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 62Efd4iBKpKi for <bitbake-devel@lists.openembedded.org>;
	Sat, 13 Sep 2014 08:50:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8D7oPSx015838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 13 Sep 2014 08:50:26 +0100
Message-ID: <1410594626.14624.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 13 Sep 2014 08:50:26 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Fix remove operator and its interaction with data expansion
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
X-List-Received-Date: Sat, 13 Sep 2014 07:50:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you have:

FOO = "${bindir}/X Y"
FOO_remove = "${bindir}/X"

the expected result is "Y". Currently this doesn't work since the removed
expressions are not expanded first. This patch adjusts things so the
expressions are expanded before being processed for removal.

Also add a test to ensure this case continues to work.

[YOCTO #6624]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 7b2032a..16a85bc 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -642,7 +642,8 @@ class DataSmart(MutableMapping):
                 cachename = var + "[" + flag + "]"
             value = self.expand(value, cachename)
         if value and flag == "_content" and local_var is not None and "_removeactive" in local_var:
-            filtered = filter(lambda v: v not in local_var["_removeactive"],
+            removes = [self.expand(r) for r in local_var["_removeactive"]]
+            filtered = filter(lambda v: v not in removes,
                               value.split(" "))
             value = " ".join(filtered)
             if expand:
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 944a906..9b09ff4 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -259,6 +259,13 @@ class TestConcatOverride(unittest.TestCase):
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST", True), "")
 
+    def test_remove_expansion(self):
+        self.d.setVar("BAR", "Z")
+        self.d.setVar("TEST", "${BAR}/X Y")
+        self.d.setVar("TEST_remove", "${BAR}/X")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "Y")
+
 class TestOverrides(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()



