Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TIqF5-0001mg-01 for bitbake-devel@lists.openembedded.org;
	Tue, 02 Oct 2012 02:21:43 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9208jIU009673
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Oct 2012 01:08:45 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 07592-09 for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Oct 2012 01:08:37 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9208TSC009643
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Oct 2012 01:08:30 +0100
Message-ID: <1349136509.15753.123.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Oct 2012 01:08:29 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] tests/utils: Add test for explode_dep_versions2
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
X-List-Received-Date: Tue, 02 Oct 2012 00:21:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/tests/utils.py b/bitbake/lib/bb/tests/utils.py
index 04e8d5d..9f60491 100644
--- a/bitbake/lib/bb/tests/utils.py
+++ b/bitbake/lib/bb/tests/utils.py
@@ -34,3 +34,18 @@ class VerCmpString(unittest.TestCase):
         result = bb.utils.vercmp_string('1.1', '1_p2')
         self.assertTrue(result < 0)
 
+    def test_explode_dep_versions(self):
+        correctresult = {"foo" : ["= 1.10"]}
+        result = bb.utils.explode_dep_versions2("foo (= 1.10)")
+        self.assertEqual(result, correctresult)
+        result = bb.utils.explode_dep_versions2("foo (=1.10)")
+        self.assertEqual(result, correctresult)
+        result = bb.utils.explode_dep_versions2("foo ( = 1.10)")
+        self.assertEqual(result, correctresult)
+        result = bb.utils.explode_dep_versions2("foo ( =1.10)")
+        self.assertEqual(result, correctresult)
+        result = bb.utils.explode_dep_versions2("foo ( = 1.10 )")
+        self.assertEqual(result, correctresult)
+        result = bb.utils.explode_dep_versions2("foo ( =1.10 )")
+        self.assertEqual(result, correctresult)
+




