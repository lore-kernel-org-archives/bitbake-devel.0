Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA78C3600E
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 12:25:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.64115.1742905494464587723
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Mar 2025 05:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 199AB1756
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 05:25:00 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC87D3F58B
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 05:24:53 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 3/6] bb/tests: use subtests when looping in a test case
Date: Tue, 25 Mar 2025 12:24:37 +0000
Message-ID: <20250325122441.2521891-3-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325122441.2521891-1-ross.burton@arm.com>
References: <20250325122441.2521891-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 12:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17488

Marking the test iterations as subtests means that when one fails, it
can identify clearly which iteration has failed.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tests/fetch.py | 67 ++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 486c10cd084..6b1d9645911 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1534,18 +1534,19 @@ class FetchLatestVersionTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_latest_versionstring(self):
         for k, v in self.test_git_uris.items():
-            self.d.setVar("PN", k[0])
-            self.d.setVar("SRCREV", k[2])
-            self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
-            ud =3D bb.fetch2.FetchData(k[1], self.d)
-            pupver=3D ud.method.latest_versionstring(ud, self.d)
-            verstring =3D pupver[0]
-            self.assertTrue(verstring, msg=3D"Could not find upstream ve=
rsion for %s" % k[0])
-            r =3D bb.utils.vercmp_string(v, verstring)
-            self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package %s=
, version: %s <=3D %s" % (k[0], v, verstring))
-            if k[4]:
-                r =3D bb.utils.vercmp_string(verstring, k[4])
-                self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Packag=
e %s, version: %s <=3D %s" % (k[0], verstring, k[4]))
+            with self.subTest(pn=3Dk[0]):
+                self.d.setVar("PN", k[0])
+                self.d.setVar("SRCREV", k[2])
+                self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
+                ud =3D bb.fetch2.FetchData(k[1], self.d)
+                pupver=3D ud.method.latest_versionstring(ud, self.d)
+                verstring =3D pupver[0]
+                self.assertTrue(verstring, msg=3D"Could not find upstrea=
m version for %s" % k[0])
+                r =3D bb.utils.vercmp_string(v, verstring)
+                self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Packag=
e %s, version: %s <=3D %s" % (k[0], v, verstring))
+                if k[4]:
+                    r =3D bb.utils.vercmp_string(verstring, k[4])
+                    self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Pa=
ckage %s, version: %s <=3D %s" % (k[0], verstring, k[4]))
=20
     def test_wget_latest_versionstring(self):
         testdata =3D os.path.dirname(os.path.abspath(__file__)) + "/fetc=
h-testdata"
@@ -1554,32 +1555,34 @@ class FetchLatestVersionTest(FetcherTest):
         port =3D server.port
         try:
             for k, v in self.test_wget_uris.items():
-                self.d.setVar("PN", k[0])
-                checkuri =3D ""
-                if k[2]:
-                    checkuri =3D "http://127.0.0.1:%s/" % port + k[2]
-                self.d.setVar("UPSTREAM_CHECK_URI", checkuri)
-                self.d.setVar("UPSTREAM_CHECK_REGEX", k[3])
-                url =3D "http://127.0.0.1:%s/" % port + k[1]
-                ud =3D bb.fetch2.FetchData(url, self.d)
-                pupver =3D ud.method.latest_versionstring(ud, self.d)
-                verstring =3D pupver[0]
-                self.assertTrue(verstring, msg=3D"Could not find upstrea=
m version for %s" % k[0])
-                r =3D bb.utils.vercmp_string(v, verstring)
-                self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Packag=
e %s, version: %s <=3D %s" % (k[0], v, verstring))
+                with self.subTest(pn=3Dk[0]):
+                    self.d.setVar("PN", k[0])
+                    checkuri =3D ""
+                    if k[2]:
+                        checkuri =3D "http://127.0.0.1:%s/" % port + k[2=
]
+                    self.d.setVar("UPSTREAM_CHECK_URI", checkuri)
+                    self.d.setVar("UPSTREAM_CHECK_REGEX", k[3])
+                    url =3D "http://127.0.0.1:%s/" % port + k[1]
+                    ud =3D bb.fetch2.FetchData(url, self.d)
+                    pupver =3D ud.method.latest_versionstring(ud, self.d=
)
+                    verstring =3D pupver[0]
+                    self.assertTrue(verstring, msg=3D"Could not find ups=
tream version for %s" % k[0])
+                    r =3D bb.utils.vercmp_string(v, verstring)
+                    self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Pa=
ckage %s, version: %s <=3D %s" % (k[0], v, verstring))
         finally:
             server.stop()
=20
     @skipIfNoNetwork()
     def test_crate_latest_versionstring(self):
         for k, v in self.test_crate_uris.items():
-            self.d.setVar("PN", k[0])
-            ud =3D bb.fetch2.FetchData(k[1], self.d)
-            pupver =3D ud.method.latest_versionstring(ud, self.d)
-            verstring =3D pupver[0]
-            self.assertTrue(verstring, msg=3D"Could not find upstream ve=
rsion for %s" % k[0])
-            r =3D bb.utils.vercmp_string(v, verstring)
-            self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package %s=
, version: %s <=3D %s" % (k[0], v, verstring))
+            with self.subTest(pn=3Dk[0]):
+                self.d.setVar("PN", k[0])
+                ud =3D bb.fetch2.FetchData(k[1], self.d)
+                pupver =3D ud.method.latest_versionstring(ud, self.d)
+                verstring =3D pupver[0]
+                self.assertTrue(verstring, msg=3D"Could not find upstrea=
m version for %s" % k[0])
+                r =3D bb.utils.vercmp_string(v, verstring)
+                self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Packag=
e %s, version: %s <=3D %s" % (k[0], v, verstring))
=20
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris =3D ["https://downloads.yoctoproject.org/releases/sat=
o/sato-engine-0.1.tar.gz",
--=20
2.43.0


