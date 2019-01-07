Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 620FD6C466
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 15:55:38 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id d15so1348975wmb.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=uTWs8lN6osqkHsEH7ZdFtXtmcYVmwiA/jXnzG5vgTHs=;
	b=D1JKAfOAcVQX5SujjV4GvZKSWd7r8cEHnRHCD2mOeOE+BBQcPMrLqPrxc5MxHf3HkX
	Adf1LdGux2N/blkq2SkGZX+rKO1wveCSyvbxKi1iWMbCnl6353n9Ay+szu2McpXWXCOr
	Mi0ywpjAD30zOu63goznEXQp2UqJeA495BpbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=uTWs8lN6osqkHsEH7ZdFtXtmcYVmwiA/jXnzG5vgTHs=;
	b=TnplS2S7qIq2Cta+JFxlE/slVySq3Kj1trb8qaEIGrAiEbhZ0lG1oUub7TNVDTSGq3
	v89DY6bXAceTRMglQ6wkee5EvJW+rvCp6HWTYyNhkPVbkDh4clE5IS1bP2paT6V/aT7Y
	pVZPgngFXpp9GFpe9AxTzZJgTtciz32VZHRty5AYj+ogP+F8yfQWiPedPfX2qcnpQY7Z
	wnobz75LZGDPPCC8KApSHVhazznHAIypmrOKkbEjdHuK+kDIqR1JbW5FRdZHB8UffIe/
	MAgCYzt+iPsNCNsr/POle++H2Yei/KdY7fTozKMpIOtqBp6Vd7bC5NuDdkDYcx6P1JUi
	I8Vw==
X-Gm-Message-State: AJcUukdbRmZjwzD7KhViW7jcsywqgnMCY8b2E267cXsqIJTWbIbDP/sJ
	vx5lsydkOAN0C0yqof6tSbBSKweSrDW62w==
X-Google-Smtp-Source: ALg8bN7mMMxD2P/VTi2FHygWJig5wzTSDSuTVR1riw14hRFewbQeXUW1quVpXwWr4oKYz8KwS5n7Hw==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr6736765wme.101.1546876538319; 
	Mon, 07 Jan 2019 07:55:38 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o9sm6400347wmh.3.2019.01.07.07.55.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 07 Jan 2019 07:55:37 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Jan 2019 15:55:33 +0000
Message-Id: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH 1/4] tests.data: Add underscore+numeric in overrides datastore test
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
X-List-Received-Date: Mon, 07 Jan 2019 15:55:38 -0000
Content-Transfer-Encoding: 8bit

Add a test for x86_64 in overrides where is was being incorrectly handled.
There was a previous fix (3a3be518536acc868c7eeb3c1111ad1b321480b7) but
this ensures we don't regress.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/data.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index db3e2010a9..3c511f214b 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -394,6 +394,15 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("OVERRIDES", "foo:bar:some_val")
         self.assertEqual(self.d.getVar("TEST"), " testvalue5")
 
+    # Test an override with _<numeric> in it based on a real world OE issue
+    def test_underscore_override(self):
+        self.d.setVar("TARGET_ARCH", "x86_64")
+        self.d.setVar("PN", "test-${TARGET_ARCH}")
+        self.d.setVar("VERSION", "1")
+        self.d.setVar("VERSION_pn-test-${TARGET_ARCH}", "2")
+        self.d.setVar("OVERRIDES", "pn-${PN}")
+        bb.data.expandKeys(self.d)
+        self.assertEqual(self.d.getVar("VERSION"), "2")
 
 class TestKeyExpansion(unittest.TestCase):
     def setUp(self):
-- 
2.19.1


