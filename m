Return-Path: <jacob.kroon@gmail.com>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by mail.openembedded.org (Postfix) with ESMTP id 586D27FA7F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Sep 2019 09:11:07 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id j19so4868557lja.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Sep 2019 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=OdbaT5AxJLBgmXudDDEV9spQ+5Fh3sTJEQhSCQBCt3M=;
	b=gk8GjHDYeSPsk0d6XDRmGQVF5ySNDyXGTwE5QExZ3qaVqAenbn9YPxSWGgZMRnNGsK
	2B+HTHIBSZk2xwrQ9kfEq0s4u6ct5/CehkQTUNv6aEUb9FT0ZWdQX3x7imgn51I8b0Ou
	EB3+uVdWDaQPsJG1PJvQ3oVd2HvZAbbK6n8zxHHhXnlJR8kIi8p9nB43UPLjO5lbfGJq
	q6Id0PfFjemsUFAie0x3/fpycd0dTDkCr8W4YVVi0OOMusvfINGs/xoCbkHRmxnA1tdK
	m+sWJkkQRD+OOKQ0fS9rgBbYpmGmV8SuXRzZhmUkJgxGAfGvS2/NyagtYHRw1D7xr6WY
	6DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=OdbaT5AxJLBgmXudDDEV9spQ+5Fh3sTJEQhSCQBCt3M=;
	b=BU4G5QB5Zm8i1X4Owq7vjC28QEjLLPvcpfD5P7rsh1+lvuIYVSM2S/GDeDwdQWP6is
	xEalyb7fl07vQkfLKdHwg28E6ZM2Uwwr+iUzuQbdEa4mJz2AOwxitPC4jIN83B7xheWL
	2k7WcUH9er3A/uvyRTKu2ySIw56uOUz0jyl80u9zCKee2hcYikmd0YxzeDY20CM+u4fL
	ERVUdmpSJbCY5l8J1N2cmmDHdIZBdhPM+jTojtOl/HXrxtPrMvoTq9VFnOJyiWOz66Zn
	cpjtu+JCjwehiMdykjMuUri1N8zb+c7j9Oh6ip0u09vN9uktp1dzmYrLz8gnKB4Xju34
	pBsg==
X-Gm-Message-State: APjAAAUheKx4xkH7LNb7zr51NZYH8m+ZouuAb58CP4zdWZCnE6yO+BqC
	jY0BXRF1d/NRPXTYpB/fIPrGeQRa02Q=
X-Google-Smtp-Source: APXvYqwp5b5rvcaeH2ZQLHjaL0jtwPs7Kx05TUTgNaE86ccZO0ta5JLG7cYkXhxYd3ifZCNrp5VwPg==
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr4508688lji.204.1568970667150; 
	Fri, 20 Sep 2019 02:11:07 -0700 (PDT)
Received: from manatarms-greyskull.lan.mikrodidakt.se ([213.185.29.22])
	by smtp.gmail.com with ESMTPSA id r22sm299794ljr.43.2019.09.20.02.11.02
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 20 Sep 2019 02:11:03 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Sep 2019 11:10:51 +0200
Message-Id: <20190920091051.29088-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] tests/data: Test combinations of _append together with override
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
X-List-Received-Date: Fri, 20 Sep 2019 09:11:07 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 lib/bb/tests/data.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index a9b0bdb0..3e49984c 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -381,6 +381,19 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("OVERRIDES", "foo:bar:some_val")
         self.assertEqual(self.d.getVar("TEST"), " testvalue5")
 
+    def test_append_and_override_1(self):
+        self.d.setVar("TEST_append", "testvalue2")
+        self.d.setVar("TEST_bar", "testvalue3")
+        self.assertEqual(self.d.getVar("TEST"), "testvalue3testvalue2")
+
+    def test_append_and_override_2(self):
+        self.d.setVar("TEST_append_bar", "testvalue2")
+        self.assertEqual(self.d.getVar("TEST"), "testvaluetestvalue2")
+
+    def test_append_and_override_3(self):
+        self.d.setVar("TEST_bar_append", "testvalue2")
+        self.assertEqual(self.d.getVar("TEST"), "testvalue2")
+
     # Test an override with _<numeric> in it based on a real world OE issue
     def test_underscore_override(self):
         self.d.setVar("TARGET_ARCH", "x86_64")
-- 
2.21.0


