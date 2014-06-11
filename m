Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 395CB60E68
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Jun 2014 10:07:24 +0000 (UTC)
Received: by mail-wg0-f49.google.com with SMTP id y10so2830686wgg.20
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Jun 2014 03:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=8oT4LErmWeCQPs2MAo+82CIaxzuK72n9oEJEDjSZsTM=;
	b=IRogfJCypK4z8a24lcmC0ijYdxhbohfNpbdz5HNEGFppvqSuCt97qWbFgxnzrOFv0a
	DS2iuuohFZW7vySWbR9ahgFyI2sSTNpMv/ha5r8PLC+5/DcjF/cD6WO95rCDbuNQqGUl
	aXfUuhx8EYbwYeCEQlsxugl/3ykGGqHMhVKNXrCw1+h0by1uL6AYIthh52BK+JwcW71Y
	5R5/uLIP8Wt8oTozT5MOo3A5Y+0/puDoqfjK06HDQI/mfkkRAcJduG7NpGR5ZSy/E3Tj
	S7obtT2HTi9KohLKlNajUdSOUHw/qnifHw+ashTTqkkm542niqvyrBuKsrlGs8IS/ifF
	gUTg==
X-Gm-Message-State: ALoCoQm6zcgcPdR2cvJG3hwnuth0mO7wYtzQ5m/v0Mn4hSRg9ASHWsO121lj10jV1t400LMwTmrr
X-Received: by 10.194.120.68 with SMTP id la4mr49761424wjb.40.1402481245044;
	Wed, 11 Jun 2014 03:07:25 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id vc2sm33522760wjc.2.2014.06.11.03.07.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jun 2014 03:07:24 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jun 2014 11:04:43 +0100
Message-Id: <1402481084-13848-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH 1/2] bb/tests/data.py: add tests for contains() and contains_any()
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
X-List-Received-Date: Wed, 11 Jun 2014 10:07:33 -0000

contains_any is buggy so write a test case to demonstrate this.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/data.py |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 228f72c..944a906 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -299,3 +299,39 @@ class TestFlags(unittest.TestCase):
         self.assertEqual(self.d.getVarFlag("foo", "flag2"), None)
 
 
+class Contains(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.d.setVar("SOMEFLAG", "a b c")
+
+    def test_contains(self):
+        self.assertTrue(bb.utils.contains("SOMEFLAG", "a", True, False, self.d))
+        self.assertTrue(bb.utils.contains("SOMEFLAG", "b", True, False, self.d))
+        self.assertTrue(bb.utils.contains("SOMEFLAG", "c", True, False, self.d))
+
+        self.assertTrue(bb.utils.contains("SOMEFLAG", "a b", True, False, self.d))
+        self.assertTrue(bb.utils.contains("SOMEFLAG", "b c", True, False, self.d))
+        self.assertTrue(bb.utils.contains("SOMEFLAG", "c a", True, False, self.d))
+
+        self.assertTrue(bb.utils.contains("SOMEFLAG", "a b c", True, False, self.d))
+        self.assertTrue(bb.utils.contains("SOMEFLAG", "c b a", True, False, self.d))
+
+        self.assertFalse(bb.utils.contains("SOMEFLAG", "x", True, False, self.d))
+        self.assertFalse(bb.utils.contains("SOMEFLAG", "a x", True, False, self.d))
+        self.assertFalse(bb.utils.contains("SOMEFLAG", "x c b", True, False, self.d))
+        self.assertFalse(bb.utils.contains("SOMEFLAG", "x c b a", True, False, self.d))
+
+    def test_contains_any(self):
+        self.assertTrue(bb.utils.contains_any("SOMEFLAG", "a", True, False, self.d))
+        self.assertTrue(bb.utils.contains_any("SOMEFLAG", "b", True, False, self.d))
+        self.assertTrue(bb.utils.contains_any("SOMEFLAG", "c", True, False, self.d))
+
+        self.assertTrue(bb.utils.contains_any("SOMEFLAG", "a b", True, False, self.d))
+        self.assertTrue(bb.utils.contains_any("SOMEFLAG", "b c", True, False, self.d))
+        self.assertTrue(bb.utils.contains_any("SOMEFLAG", "c a", True, False, self.d))
+
+        self.assertTrue(bb.utils.contains_any("SOMEFLAG", "a x", True, False, self.d))
+        self.assertTrue(bb.utils.contains_any("SOMEFLAG", "x c", True, False, self.d))
+
+        self.assertFalse(bb.utils.contains_any("SOMEFLAG", "x", True, False, self.d))
+        self.assertFalse(bb.utils.contains_any("SOMEFLAG", "x y z", True, False, self.d))
-- 
1.7.10.4


