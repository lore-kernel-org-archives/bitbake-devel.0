Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65424C3DA78
	for <webhook@archiver.kernel.org>; Tue, 17 Jan 2023 15:37:05 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web11.199754.1673969824656473711
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Jan 2023 07:37:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm3 header.b=rlkOgD36;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.29, mailfrom: pavel@zhukoff.net)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 027F25C0111;
	Tue, 17 Jan 2023 10:37:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 17 Jan 2023 10:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1673969823; x=1674056223; bh=dG
	EikX6zmYU0CmysaEjjrWQJCcnN1DMaFRrCtrfDw1s=; b=rlkOgD36wlvTpjo0zf
	tWLAODffASgVY/6cJpNE+EvQ1IvKvCNwVON9Z18M6x7QfpKKdgKkqeF9QoQ9EHhW
	t5Uk1bbbOKGRRFl2gRwsBA03NhIgBYowtkG5RzMMF91NnPwCfaBoYHEDPndbbXE3
	V8izlXWKZMQlVgeIXMk2UpMjeLuCnaRXO+1XxCEKQLujzntQgXpG84sf7VxvIqQy
	tKKktuNm310ud4v2UxXXTUEI/f72PiRy86+QJZEgdmpY36Ee8DohWBK5fN5rOMjn
	jgoDWGSXqt83tAZkuWOhifnsALAbkPxjpbbkAfY0/SRDmgKlIPG9ou9/ojLVLU2U
	ZAhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1673969823; x=1674056223; bh=dGEikX6zmYU0C
	mysaEjjrWQJCcnN1DMaFRrCtrfDw1s=; b=b0MnjvgxzetgDt2NgkbgyeJ114AgD
	jE/9avWP38lIDKLm0t/acwFBDIbju3DU4oWiBxBXfMYfiCy6836ELUP/AmHN8mbr
	Xa0+4UirVmvpAg5nskkXK2f7LTQOydGzclnyGsUV9LWI1LFLp7OjxDRe7PYoEo+B
	z98JRWAywQFKYKfXu/iXgyfWrzAHTBDTNsxc4mymPPeVbORGKyAYFuUDRFz8nB/d
	HraFXp82c5RQH0WFkdzEWc+9bFCSHjDCOuoqJ0iJJPqWmLJ99i8XOGOffqoUcvwE
	knj6qWEphFY4kGeQh+qWmsr8KOT1/P6OdlKWvshrVtMBEpe9eiL8A+JAw==
X-ME-Sender: <xms:n8DGY_j3DMhtj5-WFPpEUwO_ooxFn3qR0ntHv2GmEl5B-hTCMPN2xg>
    <xme:n8DGY8CA5MQsfJzHqCsCDeYwYIQjOq3qZ5sXod_WNAIHUGatdexTo8dgHNJXYW0fS
    FdBIUeXA6IHkld4c38>
X-ME-Received: <xmr:n8DGY_GpV0ljLGMh98ORKpHXb1-nMOdghJFfMoW1I8wKfwt80Z_wKpLHDe9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtiedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhu
    khhofhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeeukeeuueegudfhheetgeekudekje
    efkeeugefhledtueelgeeijeetffejvefhfeenucffohhmrghinhepihhmfhhrvggvugho
    mhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:n8DGY8RNEep4g5KJFGXepXcOUNH1GIHI_4Ancaf6ssog--RKI3OVzw>
    <xmx:n8DGY8z4LxoghuSNQ3IPigQkC791dK9ohCSmybLl4VmWxxnxzbapuw>
    <xmx:n8DGYy7T6gS1Lc_9ffouXH81sQ_4tJOV2pdGVdlvg1riDcvy0XYd_g>
    <xmx:n8DGYya0-03RMEOi58WtLJHKa1WSB6Cn5d_ME8RdZ6JtIhIUE-5cJQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 10:37:03 -0500 (EST)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH 2/2] fetch2/tests: Add test for Mercurial
Date: Tue, 17 Jan 2023 16:36:43 +0100
Message-Id: <20230117153643.21716-2-pavel@zhukoff.net>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117153643.21716-1-pavel@zhukoff.net>
References: <20230117153643.21716-1-pavel@zhukoff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Jan 2023 15:37:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14319

Basic test for mercurial functionality including PREMIRRORONLY with
disabled network

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 bitbake/lib/bb/tests/fetch.py | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index ad3d4dea7d..2e5cd14205 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2936,6 +2936,50 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
 
+class FetchPremirroronlyMercurialTest(FetcherTest):
+    """ Test for premirrors with mercurial repos
+        the test covers also basic hg:// clone (see fetch_and_create_tarball
+    """
+    def skipIfNoHg():
+        import shutil
+        if not shutil.which('hg'):
+            return unittest.skip('Mercurial not installed')
+        return lambda f: f
+
+    def setUp(self):
+        super(FetchPremirroronlyMercurialTest, self).setUp()
+        self.mirrordir = os.path.join(self.tempdir, "mirrors")
+        os.mkdir(self.mirrordir)
+        self.reponame = "libgnt"
+        self.clonedir = os.path.join(self.tempdir, "hg")
+        self.recipe_url = "hg://keep.imfreedom.org/libgnt;module=libgnt"
+        self.d.setVar("SRCREV", "53e8b422faaf")
+        self.mirrorname = "hg_libgnt_keep.imfreedom.org_.libgnt.tar.gz"
+
+    def fetch_and_create_tarball(self):
+        """
+        Ask bitbake to download repo and prepare mirror tarball for us
+        """
+        self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher.download()
+        mirrorfile = os.path.join(self.d.getVar("DL_DIR"), self.mirrorname)
+        self.assertTrue(os.path.exists(mirrorfile), "Mirror tarball {} has not been created".format(mirrorfile))
+        ## moving tarball to mirror directory
+        os.rename(mirrorfile, os.path.join(self.mirrordir, self.mirrorname))
+        self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "0")
+
+
+    @skipIfNoNetwork()
+    @skipIfNoHg()
+    def test_premirror_mercurial(self):
+        self.fetch_and_create_tarball()
+        self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
+        self.d.setVar("BB_NO_NETWORK", "1")
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher.download()
+
 class FetchPremirroronlyBrokenTarball(FetcherTest):
 
     def setUp(self):
-- 
2.39.0


