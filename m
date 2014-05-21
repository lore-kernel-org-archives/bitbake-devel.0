Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (unknown [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 88CA165D1A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 14:29:58 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4LETsfN022317 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 15:29:54 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2p0aiPCy0CP0 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 15:29:54 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4LETlqF022305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 15:29:49 +0100
Message-ID: <1400682580.17834.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 May 2014 15:29:40 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Fix an unusual variable reference bug
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
X-List-Received-Date: Wed, 21 May 2014 14:30:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you try:

Y = ""
Y_remove = "X"

in OE-Core, bitbake will crash with a KeyError during expansion. The reason
is that no expansion of the empty value is attempted but removal from is it
and hence no varparse data is present for it in the expand_cache.

If the value is empty, there is nothing to remove so the best fix is simply
not to check for None but check it has any value.

Also add a test for this error so it doesn't get reintroduced.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 27806f9..db0f8e6 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -641,7 +641,7 @@ class DataSmart(MutableMapping):
             else:
                 cachename = var + "[" + flag + "]"
             value = self.expand(value, cachename)
-        if value is not None and flag == "_content" and local_var is not None and "_removeactive" in local_var:
+        if value and flag == "_content" and local_var is not None and "_removeactive" in local_var:
             filtered = filter(lambda v: v not in local_var["_removeactive"],
                               value.split(" "))
             value = " ".join(filtered)
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index ee66b22..228f72c 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -253,6 +253,11 @@ class TestConcatOverride(unittest.TestCase):
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST_TEST", True), "bar bar")
 
+    def test_empty_remove(self):
+        self.d.setVar("TEST", "")
+        self.d.setVar("TEST_remove", "val")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "")
 
 class TestOverrides(unittest.TestCase):
     def setUp(self):



