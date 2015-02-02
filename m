Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 35B34606BF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Feb 2015 15:11:26 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id x12so39287712wgg.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 Feb 2015 07:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=wq2P61NVa6tEbFlFzrboRtEu0qw885yPvC3uarPpZdw=;
	b=hfpA0pt+dG9FcSmC9EOz9m5N/wkjMwaiuBoDrnVoCFVw2YbErIyjH2EUeQaNuO299Z
	RFZESp/mIGjAmEpOm0huHtsFdnNtZjt2UEZXc1LvSH93M6BTw2+55VkRkq1qL+qeQj2v
	IQ9ugIkd+7yB1VnR9HasPEQIugPM2u+5JMco6E6Pwbdv8zbZgQYJ9ZTXvRlG6BNdRMip
	dR0nbdr3iZ7AvgzrkQDdFTuxXu4ctsX2qeMOo8S+RZMa3irS0Cnlv8+kybmLiNIoibHq
	QGhpspkHFTS+jk6KY4W5wB9tevnHUS6PfpACf1b3w45ElfBaNRtlcLcgO09oxbtJHxss
	uqFw==
X-Gm-Message-State: ALoCoQlP5MIZcBUjIesRmdkyakGooqB+09cqso0XBaBX5N62B7gypbQFxnEPUfrkoA29przR11IP
X-Received: by 10.180.7.199 with SMTP id l7mr25516145wia.66.1422889878067;
	Mon, 02 Feb 2015 07:11:18 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by mx.google.com with ESMTPSA id 18sm28294829wjr.46.2015.02.02.07.11.16
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Feb 2015 07:11:16 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Feb 2015 15:09:24 +0000
Message-Id: <1422889765-1308-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH 1/2] tests/data: add test for incorrect remove behaviour
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
X-List-Received-Date: Mon, 02 Feb 2015 15:11:28 -0000

The _remove operator isn't working correctly when used with a variable that
expands to several items, so add a test case to exercise this path.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/data.py |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 81e4091..7994a88 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -272,6 +272,13 @@ class TestConcatOverride(unittest.TestCase):
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST", True), "Y")
 
+    def test_remove_expansion_items(self):
+        self.d.setVar("TEST", "A B C D")
+        self.d.setVar("BAR", "B D")
+        self.d.setVar("TEST_remove", "${BAR}")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "A C")
+
 class TestOverrides(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()
-- 
1.7.10.4


