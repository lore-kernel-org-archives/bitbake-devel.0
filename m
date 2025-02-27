Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E7BC021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:09:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web11.6974.1740647343978457937
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 01:09:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: lgo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt8-0002IO-28; Thu, 27 Feb 2025 10:09:02 +0100
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt7-0036DG-1f;
	Thu, 27 Feb 2025 10:09:01 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt7-006qeh-1S;
	Thu, 27 Feb 2025 10:09:01 +0100
From: =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	yocto@pengutronix.de,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH v2 3/5] tests: fetch: add download test for the GitHub release artifact fetcher
Date: Thu, 27 Feb 2025 10:08:51 +0100
Message-Id: <20250227090853.1632280-4-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 09:09:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17341

The fetcher is mostly intended to work with release artifacts for
_private_ GitHub repositories, which require authentication in the form
of a token.

Release artifacts for public repositories can simply be downloaded using
the normal wget fetcher using a public and stable URL.

The tests use a public repository anyways because it would otherwise have
to contain a GitHub token that is supposed to be kept secret.

The `tslib` release referenced in the test is used because it is already
used by another test.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 lib/bb/tests/fetch.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 48b9e4af1..6b23bae5b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1276,6 +1276,18 @@ class FetcherNetworkTest(FetcherTest):
             with self.assertRaises(bb.fetch2.FetchError):
                 fetcher.download()
 
+    @skipIfNoNetwork()
+    def test_github_release_artifact(self):
+        fetcher = bb.fetch.Fetch(["ghra://github.com/kergoth/tslib/1.1/tslib-1.1.tar.xz;sha256sum=fe35e5f710ea933b118f710e2ce4403ac076fe69926b570333867d4de082a51c"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/tslib-1.1.tar.xz"), 238184)
+        self.d.setVar("BB_NO_NETWORK", "1")
+        fetcher = bb.fetch.Fetch(["ghra://github.com/kergoth/tslib/1.1/tslib-1.1.tar.xz;sha256sum=fe35e5f710ea933b118f710e2ce4403ac076fe69926b570333867d4de082a51c"], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        self.assertEqual(len(os.listdir(self.unpackdir + "/tslib-1.1/")), 29)
+
+
 class SVNTest(FetcherTest):
     def skipIfNoSvn():
         import shutil
-- 
2.39.5


