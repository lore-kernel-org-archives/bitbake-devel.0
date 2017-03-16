Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2E97065CC7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Mar 2017 12:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2GCtOT3003826; Thu, 16 Mar 2017 12:55:24 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SO2TaA13kLC9; Thu, 16 Mar 2017 12:55:24 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2GCtIlS003823
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 Mar 2017 12:55:19 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1coUw2-0007mP-5f; Thu, 16 Mar 2017 12:55:18 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Mar 2017 12:55:15 +0000
Message-Id: <1489668915-29867-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] tests/data: Add inactive remove override test
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
X-List-Received-Date: Thu, 16 Mar 2017 12:55:24 -0000

In 2bc4d35fb32defc59cd6ed1fc87e35924c201a5c we fixed cases where an inactive
remove override was influecing the value of a variable. This adds a test
case for this issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/data.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index be46ffc..895489e 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -283,6 +283,13 @@ class TestConcatOverride(unittest.TestCase):
         self.d.setVar("TEST_remove", "val")
         self.assertEqual(self.d.getVar("TEST"), "bar")
 
+    # Ensure the value is unchanged if we have an inactive remove override
+    # (including that whitespace is preserved)
+    def test_remove_inactive_override(self):
+        self.d.setVar("TEST", "${VAL} ${BAR}    123")
+        self.d.setVar("TEST_remove_inactiveoverride", "val")
+        self.assertEqual(self.d.getVar("TEST"), "val bar    123")
+
     def test_doubleref_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.d.setVar("TEST_remove", "val")
-- 
2.7.4


