Return-Path: <rh@richhaar.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722B2C4167B
	for <webhook@archiver.kernel.org>; Thu, 30 Nov 2023 22:54:52 +0000 (UTC)
Received: from MTA-06-4.privateemail.com (MTA-06-4.privateemail.com [198.54.122.146])
 by mx.groups.io with SMTP id smtpd.web10.9617.1701384883645199709
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Nov 2023 14:54:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: richhaar.com, ip: 198.54.122.146, mailfrom: rh@richhaar.com)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
	by mta-06.privateemail.com (Postfix) with ESMTP id D027C18000AD;
	Thu, 30 Nov 2023 17:54:42 -0500 (EST)
Received: from rich-Lite.. (unknown [31.94.24.246])
	by mta-06.privateemail.com (Postfix) with ESMTPA;
	Thu, 30 Nov 2023 17:54:27 -0500 (EST)
From: Richard Haar <rh@richhaar.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Haar <rh@richhaar.com>
Subject: [PATCH] bitbake: tests: Fix duplicate test_underscore_override test
Date: Thu, 30 Nov 2023 22:51:46 +0000
Message-Id: <20231130225146.27235-1-rh@richhaar.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Nov 2023 22:54:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15593

Found a duplicate test, added  _2 suffix to one, 74 tests now pass up fro=
m 73.

Signed-off-by: Richard Haar <rh@richhaar.com>
---
 lib/bb/tests/data.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 98e430ce..cbc7c1ec 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -395,6 +395,16 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("OVERRIDES", "foo:bar:some_val")
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
=20
+    # Test an override with _<numeric> in it based on a real world OE is=
sue
+    def test_underscore_override_2(self):
+        self.d.setVar("TARGET_ARCH", "x86_64")
+        self.d.setVar("PN", "test-${TARGET_ARCH}")
+        self.d.setVar("VERSION", "1")
+        self.d.setVar("VERSION:pn-test-${TARGET_ARCH}", "2")
+        self.d.setVar("OVERRIDES", "pn-${PN}")
+        bb.data.expandKeys(self.d)
+        self.assertEqual(self.d.getVar("VERSION"), "2")
+
     def test_remove_with_override(self):
         self.d.setVar("TEST:bar", "testvalue2")
         self.d.setVar("TEST:some_val", "testvalue3 testvalue5")
@@ -416,16 +426,6 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TEST:bar:append", "testvalue2")
         self.assertEqual(self.d.getVar("TEST"), "testvalue2")
=20
-    # Test an override with _<numeric> in it based on a real world OE is=
sue
-    def test_underscore_override(self):
-        self.d.setVar("TARGET_ARCH", "x86_64")
-        self.d.setVar("PN", "test-${TARGET_ARCH}")
-        self.d.setVar("VERSION", "1")
-        self.d.setVar("VERSION:pn-test-${TARGET_ARCH}", "2")
-        self.d.setVar("OVERRIDES", "pn-${PN}")
-        bb.data.expandKeys(self.d)
-        self.assertEqual(self.d.getVar("VERSION"), "2")
-
     def test_append_and_unused_override(self):
         # Had a bug where an unused override append could return "" inst=
ead of None
         self.d.setVar("BAR:append:unusedoverride", "testvalue2")
--=20
2.34.1


