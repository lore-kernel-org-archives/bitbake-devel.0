Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C16C3600B
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 12:25:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.21035.1742991929431849402
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Mar 2025 05:25:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E63812FC
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 05:25:34 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AC2F3F63F
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 05:25:28 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 5/7] tests/fetch: use a namedtuple for the wget test data
Date: Wed, 26 Mar 2025 12:25:21 +0000
Message-ID: <20250326122523.293551-5-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326122523.293551-1-ross.burton@arm.com>
References: <20250326122523.293551-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 12:25:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17499

Use a named tuple so the test can access named members instead of just
accessing the data via index, which is harder to understand.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tests/fetch.py | 46 ++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 6b1d9645911..7a53631f3b1 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1472,56 +1472,57 @@ class FetchLatestVersionTest(FetcherTest):
             : "0.28.0",
     }
=20
+    WgetTestData =3D collections.namedtuple("WgetTestData", ["pn", "path=
", "check_uri", "check_regex"], defaults=3D[None, None])
     test_wget_uris =3D {
         #
         # packages with versions inside directory name
         #
         # http://kernel.org/pub/linux/utils/util-linux/v2.23/util-linux-=
2.24.2.tar.bz2
-        ("util-linux", "/pub/linux/utils/util-linux/v2.23/util-linux-2.2=
4.2.tar.bz2", "", "")
+        WgetTestData("util-linux", "/pub/linux/utils/util-linux/v2.23/ut=
il-linux-2.24.2.tar.bz2")
             : "2.24.2",
         # http://www.abisource.com/downloads/enchant/1.6.0/enchant-1.6.0=
.tar.gz
-        ("enchant", "/downloads/enchant/1.6.0/enchant-1.6.0.tar.gz", "",=
 "")
+        WgetTestData("enchant", "/downloads/enchant/1.6.0/enchant-1.6.0.=
tar.gz")
             : "1.6.0",
         # http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
-        ("cmake", "/files/v2.8/cmake-2.8.12.1.tar.gz", "", "")
+        WgetTestData("cmake", "/files/v2.8/cmake-2.8.12.1.tar.gz")
             : "2.8.12.1",
         # https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.14.=
tar.xz
-        ("libxml2", "/software/libxml2/2.9/libxml2-2.9.14.tar.xz", "", "=
")
+        WgetTestData("libxml2", "/software/libxml2/2.9/libxml2-2.9.14.ta=
r.xz")
             : "2.10.3",
         #
         # packages with versions only in current directory
         #
         # https://downloads.yoctoproject.org/releases/eglibc/eglibc-2.18=
-svnr23787.tar.bz2
-        ("eglic", "/releases/eglibc/eglibc-2.18-svnr23787.tar.bz2", "", =
"")
+        WgetTestData("eglic", "/releases/eglibc/eglibc-2.18-svnr23787.ta=
r.bz2")
             : "2.19",
         # https://downloads.yoctoproject.org/releases/gnu-config/gnu-con=
fig-20120814.tar.bz2
-        ("gnu-config", "/releases/gnu-config/gnu-config-20120814.tar.bz2=
", "", "")
+        WgetTestData("gnu-config", "/releases/gnu-config/gnu-config-2012=
0814.tar.bz2")
             : "20120814",
         #
         # packages with "99" in the name of possible version
         #
         # http://freedesktop.org/software/pulseaudio/releases/pulseaudio=
-4.0.tar.xz
-        ("pulseaudio", "/software/pulseaudio/releases/pulseaudio-4.0.tar=
.xz", "", "")
+        WgetTestData("pulseaudio", "/software/pulseaudio/releases/pulsea=
udio-4.0.tar.xz")
             : "5.0",
         # http://xorg.freedesktop.org/releases/individual/xserver/xorg-s=
erver-1.15.1.tar.bz2
-        ("xserver-xorg", "/releases/individual/xserver/xorg-server-1.15.=
1.tar.bz2", "", "")
+        WgetTestData("xserver-xorg", "/releases/individual/xserver/xorg-=
server-1.15.1.tar.bz2")
             : "1.15.1",
         #
         # packages with valid UPSTREAM_CHECK_URI and UPSTREAM_CHECK_REGE=
X
         #
         # http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2
         # https://github.com/apple/cups/releases
-        ("cups", "/software/1.7.2/cups-1.7.2-source.tar.bz2", "/apple/cu=
ps/releases", r"(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.=
gz")
+        WgetTestData("cups", "/software/1.7.2/cups-1.7.2-source.tar.bz2"=
, check_uri=3D"/apple/cups/releases", check_regex=3Dr"(?P<name>cups\-)(?P=
<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
             : "2.0.0",
         # http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz
         # http://ftp.debian.org/debian/pool/main/d/db5.3/
-        ("db", "/berkeley-db/db-5.3.21.tar.gz", "/debian/pool/main/d/db5=
.3/", r"(?P<name>db5\.3_)(?P<pver>\d+(\.\d+)+).+\.orig\.tar\.xz")
+        WgetTestData("db", "/berkeley-db/db-5.3.21.tar.gz", check_uri=3D=
"/debian/pool/main/d/db5.3/", check_regex=3Dr"(?P<name>db5\.3_)(?P<pver>\=
d+(\.\d+)+).+\.orig\.tar\.xz")
             : "5.3.10",
         #
         # packages where the tarball compression changed in the new vers=
ion
         #
         # http://ftp.debian.org/debian/pool/main/m/minicom/minicom_2.7.1=
.orig.tar.gz
-        ("minicom", "/debian/pool/main/m/minicom/minicom_2.7.1.orig.tar.=
gz", "", "")
+        WgetTestData("minicom", "/debian/pool/main/m/minicom/minicom_2.7=
.1.orig.tar.gz")
             : "2.8",
     }
=20
@@ -1554,21 +1555,22 @@ class FetchLatestVersionTest(FetcherTest):
         server.start()
         port =3D server.port
         try:
-            for k, v in self.test_wget_uris.items():
-                with self.subTest(pn=3Dk[0]):
-                    self.d.setVar("PN", k[0])
-                    checkuri =3D ""
-                    if k[2]:
-                        checkuri =3D "http://127.0.0.1:%s/" % port + k[2=
]
-                    self.d.setVar("UPSTREAM_CHECK_URI", checkuri)
-                    self.d.setVar("UPSTREAM_CHECK_REGEX", k[3])
-                    url =3D "http://127.0.0.1:%s/" % port + k[1]
+            for data, v in self.test_wget_uris.items():
+                with self.subTest(pn=3Ddata.pn):
+                    self.d.setVar("PN", data.pn)
+                    if data.check_uri:
+                        checkuri =3D "http://127.0.0.1:%s/%s" % (port, d=
ata.check_uri)
+                        self.d.setVar("UPSTREAM_CHECK_URI", checkuri)
+                    if data.check_regex:
+                        self.d.setVar("UPSTREAM_CHECK_REGEX", data.check=
_regex)
+
+                    url =3D "http://127.0.0.1:%s/%s" % (port, data.path)
                     ud =3D bb.fetch2.FetchData(url, self.d)
                     pupver =3D ud.method.latest_versionstring(ud, self.d=
)
                     verstring =3D pupver[0]
-                    self.assertTrue(verstring, msg=3D"Could not find ups=
tream version for %s" % k[0])
+                    self.assertTrue(verstring, msg=3D"Could not find ups=
tream version for %s" % data.pn)
                     r =3D bb.utils.vercmp_string(v, verstring)
-                    self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Pa=
ckage %s, version: %s <=3D %s" % (k[0], v, verstring))
+                    self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Pa=
ckage %s, version: %s <=3D %s" % (data.pn, v, verstring))
         finally:
             server.stop()
=20
--=20
2.43.0


