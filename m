Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 65FF677BE8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Apr 2017 14:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v3BEHHYa022038; 
	Tue, 11 Apr 2017 15:17:18 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id s8dahBagw54v; Tue, 11 Apr 2017 15:17:18 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v3BE9tiv021100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 11 Apr 2017 15:09:56 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cxwUV-0007qx-MW; Tue, 11 Apr 2017 15:09:55 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Apr 2017 15:09:49 +0100
Message-Id: <1491919789-30149-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] data_smart: Ensure _remove operations on newly set variables are cleared
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
X-List-Received-Date: Tue, 11 Apr 2017 14:17:19 -0000

We clear append/prepend on newly set variables, we should also clear
remove operations. If we don't do this, there is no way we can actually
delete a remove operation. Bitbake internally uses parsing=True to avoid
these side effects when making its own internal calls.

Also add a testcase to bitbake-selftest to ensure we remain consistent going
forward from here.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 2 ++
 lib/bb/tests/data.py | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index d6dd698..7dc1c68 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -546,6 +546,8 @@ class DataSmart(MutableMapping):
                 del self.dict[var]["_append"]
             if "_prepend" in self.dict[var]:
                 del self.dict[var]["_prepend"]
+            if "_remove" in self.dict[var]:
+                del self.dict[var]["_remove"]
             if var in self.overridedata:
                 active = []
                 self.need_overrides()
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index fe947f5..a4a9dd3 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -283,6 +283,12 @@ class TestConcatOverride(unittest.TestCase):
         self.d.setVar("TEST_remove", "val")
         self.assertEqual(self.d.getVar("TEST"), "bar")
 
+    def test_remove_cleared(self):
+        self.d.setVar("TEST", "${VAL} ${BAR}")
+        self.d.setVar("TEST_remove", "val")
+        self.d.setVar("TEST", "${VAL} ${BAR}")
+        self.assertEqual(self.d.getVar("TEST"), "val bar")
+
     # Ensure the value is unchanged if we have an inactive remove override
     # (including that whitespace is preserved)
     def test_remove_inactive_override(self):
-- 
2.7.4


