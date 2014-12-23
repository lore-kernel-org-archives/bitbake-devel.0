Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A1D17727C4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Dec 2014 12:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sBNCXOvo015864 for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Dec 2014 12:33:24 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nXA2v6W9QFiL for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Dec 2014 12:33:24 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sBNCXBD1015851
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Dec 2014 12:33:22 GMT
Message-ID: <1419338028.6428.4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 23 Dec 2014 12:33:48 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] tests/data: Add a key deletion test
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
X-List-Received-Date: Tue, 23 Dec 2014 12:34:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you copy the datastore, then delete a key, it should not exist in
d.keys(). This adds a test to cover the recently found data store bug.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 9b09ff4..81e4091 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -121,6 +121,12 @@ class DataExpansions(unittest.TestCase):
         keys = self.d.keys()
         self.assertEqual(keys, ['value_of_foo', 'foo', 'bar'])
 
+    def test_keys_deletion(self):
+        newd = bb.data.createCopy(self.d)
+        newd.delVar("bar")
+        keys = newd.keys()
+        self.assertEqual(keys, ['value_of_foo', 'foo'])
+
 class TestNestedExpansions(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()



