Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C5C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 16:15:54 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by mx.groups.io with SMTP id smtpd.web08.19726.1655396148877925366
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 09:15:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail, err=mail: unclosed angle-addr;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.24,
 mailfrom: pavel@zhukoff.net)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id BD2513200928;
	Thu, 16 Jun 2022 12:15:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 16 Jun 2022 12:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1655396147; x=1655482547; bh=bUjJZ5zYOeWg/DBVF9wlMOLYQ
	8jzhUomQujrVZd1MpA=; b=quIlAbVRrrGTo+iHWJLHT/JUpIse2HxY2jBLwdwId
	9G+8Nh9aApYElWoAd7OA8pUziPLXZKWSFiBZZd3C4EUkI9gkNuVGPr8ZHFON96S2
	j92szUgQJaQchPQZ9aMzRG4NgPUZXYWrMz9jLS9v0Vhr+84Vp/DqAcX+U/qClAqJ
	znq0tmAqbuM2qQHzlkHKr1SMQeVKXESn8rQxvJy75wNheCq34AmI23jLQh0MJ9/t
	OsMw7Lo+JnQ1C2Ni8PtAVNiBLUMlYVtsfZ7m1hGz+YgiCqNSxRoNTdeKfJ3Z8JGb
	IRsgYP3QK5dQJAdkUsJICFCNYxzQhYcQmB7u4GTWMvI8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1655396147; x=1655482547; bh=bUjJZ5zYOeWg/DBVF9wlMOLYQ8jzhUomQuj
	rVZd1MpA=; b=QDi0khIJci1OJW6K7h1V0gFqo2Y48lwUS3I4x0J6BBX/juXQi6j
	u3/nCf7B/AE+ZEPmmAveARHjlxQkWa8IhzBeILuCTA8eFAncDVo8pygj9NL+AmrQ
	uMoASq1KhODPubnHd8huDD7cBBLbXP0y/kvrcqdYimRgFyCT7NIrk12rKN/5rj2M
	5B30QvEfRIXiBDahpJmaYVcmsIWmcrQY5Z7YKCclIRfwKAYk9Si+rDLQAZXt6CON
	e+pEgyzT4eP1EdIIOw9alrQDkhWmQlroq3NuGpTB38n+RnnHKh6rwH1Y8NqhtIxB
	gf/hqqohwddfRq4QJRdGWJFBMs1fPZ7hFvg==
X-ME-Sender: <xms:MlerYk33Tsh47jqg9ItAZKjPl18qAIYqWocOHF0dC83ywSjZ0tyrIw>
    <xme:MlerYvGVwERBSni8PGnyJwfrMC_2xVqmiTUb4jLQFUBSyZm1pKQkZJ-x7OIRvxULZ
    AQl6SIAlen3SDQnVZY>
X-ME-Received: 
 <xmr:MlerYs61Qnxg2AXt1AfoHdTl3QMtx4fymHJlWQTwK9Vq007yutQ9keIM3xjF6gcOKtChO9ZvNY2WCUyzvWb7jik>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedruddvfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gouegrugdqhfhrohhmucdlkedtmdenucfjughrpefhvfevufffkffoggfgsedtkeertder
    tddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhukhhofh
    hfrdhnvghtnecuggftrfgrthhtvghrnhepieelheejveegteejueeigeehvdejtdetveet
    heeivdeifeetheffgffgtdetfffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphgrvhgvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:MlerYt3oiVo8m8-7iBR8wuDIRN__258P1oOTSXL14lYyJFnckDYWiQ>
    <xmx:MlerYnF47gExiriLZqP4TfqLsydqyRQoBYfPw6UA6nBLVosTSUhYNg>
    <xmx:MlerYm9q0ZkwgtjvKFsBTLejrVLVXcDPs6RZ9nz5PbRFqKevoIvtMA>
    <xmx:M1erYtNSsFm87gbvZ-37f9YuNblmR76WP71nqCK-zEv45b4vsA8pdQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 12:15:46 -0400 (EDT)
From: Pavel@codeaurora.org, "Zhukov <pavel"@zhukoff.net
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH] tests/fetch: Add test for broken mirror tarball
Date: Thu, 16 Jun 2022 18:15:22 +0200
Message-Id: <20220616161521.20906-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jun 2022 16:15:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13772

With PREMIRROR set and BB_NETWORK = "1" bitbake should not try to
fetch into non-initialized git directory if tarball is broken (or not in
gzip format)

[Yocto 14822]

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/tests/fetch.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 622c46a0..ee41bff4 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2895,3 +2895,28 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
+
+class FetchPremirroronlyBrokenTarball(FetcherTest):
+
+    def setUp(self):
+        super(FetchPremirroronlyBrokenTarball, self).setUp()
+        self.mirrordir = os.path.join(self.tempdir, "mirrors")
+        os.mkdir(self.mirrordir)
+        self.reponame = "bitbake"
+        self.gitdir = os.path.join(self.tempdir, "git", self.reponame)
+        self.recipe_url = "git://git.fake.repo/bitbake"
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
+        self.d.setVar("BB_NO_NETWORK", "1")
+        self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
+        self.mirrorname = "git2_git.fake.repo.bitbake.tar.gz"
+        with open(os.path.join(self.mirrordir, self.mirrorname), 'w') as targz:
+            targz.write("This is not tar.gz file!")
+
+    def test_mirror_broken_download(self):
+        import sys
+        self.d.setVar("SRCREV", "0"*40)
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+        stdout = sys.stdout.getvalue()
+        self.assertFalse(" not a git repository (or any parent up to mount point /)" in stdout)
-- 
2.35.1


