Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEABFC36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 12:25:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.21067.1742991929773483399
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Mar 2025 05:25:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 157661596
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 05:25:35 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21DD43F63F
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 05:25:29 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 6/7] tests/fetch: support setting PV in the wget fetcher
Date: Wed, 26 Mar 2025 12:25:22 +0000
Message-ID: <20250326122523.293551-6-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326122523.293551-1-ross.burton@arm.com>
References: <20250326122523.293551-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 12:25:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17500

Some code paths in latest_versionstring() need PV to be set correctly.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tests/fetch.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 7a53631f3b1..7f4951fa83b 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1472,7 +1472,7 @@ class FetchLatestVersionTest(FetcherTest):
             : "0.28.0",
     }
=20
-    WgetTestData =3D collections.namedtuple("WgetTestData", ["pn", "path=
", "check_uri", "check_regex"], defaults=3D[None, None])
+    WgetTestData =3D collections.namedtuple("WgetTestData", ["pn", "path=
", "pv", "check_uri", "check_regex"], defaults=3D[None, None, None])
     test_wget_uris =3D {
         #
         # packages with versions inside directory name
@@ -1558,6 +1558,7 @@ class FetchLatestVersionTest(FetcherTest):
             for data, v in self.test_wget_uris.items():
                 with self.subTest(pn=3Ddata.pn):
                     self.d.setVar("PN", data.pn)
+                    self.d.setVar("PV", data.pv)
                     if data.check_uri:
                         checkuri =3D "http://127.0.0.1:%s/%s" % (port, d=
ata.check_uri)
                         self.d.setVar("UPSTREAM_CHECK_URI", checkuri)
--=20
2.43.0


