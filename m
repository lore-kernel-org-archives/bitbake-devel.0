Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C1ECAAD2
	for <webhook@archiver.kernel.org>; Fri, 26 Aug 2022 08:41:14 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by mx.groups.io with SMTP id smtpd.web09.34865.1661503268174007091
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Aug 2022 01:41:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=QLnW6IYz;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.25, mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 80E1B5C002F;
	Fri, 26 Aug 2022 04:41:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Aug 2022 04:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1661503267; x=1661589667; bh=+g
	eNOVo9YzUMavYaVzHhCZJ7kHdHCdJ6+aPCGr5mexg=; b=QLnW6IYzvtzYdYF9ib
	+KVrlycEcrg2+rwFtZ8DcQq3oufpoUq2TNSThZeTwc6kOXAnDcD/WxRpkL5equbM
	Ad9GA1mYtG96ElfPeQcznZXxzUvzNko8anWy0BCvF3Y2NWzNMX2tgXDUhtZUv7dF
	whe5iBSJCHtK9zA/kGQpgEIOtyAhma3I+Q4Oh4YtD3ESsO405HSoSZppFQDSezMe
	ytO8/fWTG2i9nCtaegkZqmIOHaQZvCXwjoaQkzKBPRFgxTTb19cJlRSaiZ05fdLX
	YdpdrLiPvP84xvPaoxT4Bg59ugdQzcb328K+QGWNWm+HdWGnkIOQeF1wBj5tfpI5
	CajQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1661503267; x=1661589667; bh=+geNOVo9YzUMa
	vYaVzHhCZJ7kHdHCdJ6+aPCGr5mexg=; b=jvCrIEyYh6bdVjgobExlXkYwNF9U/
	wZGa+q3ypIdQYHoPLXHONENLJgkiNmd193rQWnoU1zN5d4BocXvKm8xzEXxacgU9
	Xdt/8DWVUjrynMZKvDlMiJn+VueRBuhUYBNUTEANyLA2hVbZ3PKcNaTKm7s0tBuW
	92AmhYQm5KXELJczCUUtsLoX4Gs6jgwEMJ1um+v+79TCQ11s3UTASSjrSu7O2IZd
	HMesN4IkbFCjctuOuR5M/jym4aaWM4tacMd6FxV+vJ9yC9ALNzLPS8zJ8eW5Kjl5
	t/vi1kjT3wdqT3g8XVUaDq/ha1ckhg3txdJVsMulYv1d7ojcn+WyhvVoQ==
X-ME-Sender: <xms:I4cIY69tg-Y_OEzH43OYWc5NSdOeWJWhBXr09lahANglejvlkt3bzA>
    <xme:I4cIY6sJy2HNcl4_NF-_UoWBXQosd7oWUHNz9x50dXkeycjea5nanz3svyOlJ66Ms
    gTSwnc-NDfEfdD12to>
X-ME-Received: 
 <xmr:I4cIYwAYJzmDO5s7G-DEeA4LNJnuzbgrLTguklB3rIUtyVhDbPxGv19txnjH0QADAIVw4zrxoUDjiuWclxIO6CA>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhu
    khhofhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeegkeelueeggfekiefgtdfgledvvd
    ettdffffeuheetgeevjeeutedvtddtkeekjeenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    grvhgvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:I4cIYyekGNpttlumcmDrbMLkFAgzwA6CI4CGHHePtEvOxfr91sAgJw>
    <xmx:I4cIY_OyMGKx9cHJfcJYaz8CSdk0XYXjCa-4ajI2Iv59dliQEj88Ag>
    <xmx:I4cIY8kfbcITcNlkHgzghOrXvjB-VA8cX0qf12Q-_FmkiGem_TJC5w>
    <xmx:I4cIYxU1P0YiaJGeoCiVN-PYcnz_S3blxe-C_ZWp0V83H-G-lAAeNQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 04:41:06 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH 3/3] tests: Add test for possible gitsm deadlock
Date: Fri, 26 Aug 2022 10:40:31 +0200
Message-Id: <20220826084031.11919-3-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826084031.11919-1-pavel@zhukoff.net>
References: <20220826084031.11919-1-pavel@zhukoff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 08:41:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13936

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 lib/bb/tests/fetch.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e69b4b05..b4ed691f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1191,6 +1191,15 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/ctest/README.md')), msg='Missing submodule checkout')
         self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/testrunner/readme.md')), msg='Missing submodule checkout')
 
+    @skipIfNoNetwork()
+    def test_git_submodule_reference_to_parent(self):
+        self.recipe_url = "gitsm://github.com/gflags/gflags.git;protocol=https;branch=master"
+        self.d.setVar("SRCREV", "14e1138441bbbb584160cb1c0a0426ec1bac35f1")
+        with Timeout(60):
+            fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+            with self.assertRaises(bb.fetch2.FetchError):
+                fetcher.download()
+
 class SVNTest(FetcherTest):
     def skipIfNoSvn():
         import shutil
-- 
2.35.1


