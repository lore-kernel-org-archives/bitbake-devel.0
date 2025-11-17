Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E4BCE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 15:37:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12422.1763393818568308265
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 07:37:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=temperror, err=temporary DNS error (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 481F0FEC
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 07:36:50 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7EB3D3F66E
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 07:36:57 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bb/utils: add layer_path() function
Date: Mon, 17 Nov 2025 15:36:49 +0000
Message-ID: <20251117153649.3611181-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 15:37:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18431

Add layer_path() which will return the path to a layer. Useful to
programatically find other layers at build time, or from tinfoil.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 lib/bb/tests/utils.py | 30 ++++++++++++++++++++++++++++++
 lib/bb/utils.py       | 16 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 52b7bf85bf..13c3c16a75 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -703,3 +703,33 @@ class FilemodeTests(unittest.TestCase):
         with self.assertRaises(ValueError):
             bb.utils.to_filemode("999")
=20
+class LayerPathTests(unittest.TestCase):
+    def parsehelper(self, content, suffix=3D".bb"):
+        f =3D tempfile.NamedTemporaryFile(mode=3D"wt", suffix=3Dsuffix)
+        f.write(content)
+        f.flush()
+        return f
+
+    def test_layer_path(self):
+        config =3D """
+BBPATH =3D "/layer/core:/layer/bsptwo:/layer/bsp:/layer/malformed"
+BBFILE_PATTERN_core =3D "^/layer/core/"
+BBFILE_PATTERN_bsp =3D "^/layer/bsp/"
+BBFILE_PATTERN_bsptwo =3D "^/layer/bsptwo/"
+BBFILE_PATTERN_malformed =3D "^/layer/mal-formed/"
+        """
+        d =3D bb.data.init()
+        bb.parse.siggen =3D bb.siggen.init(d)
+        with self.parsehelper(config) as f:
+            d =3D bb.parse.handle(f.name, d)['']
+
+        self.assertEqual(bb.utils.layer_path("core", d), "/layer/core")
+        self.assertEqual(bb.utils.layer_path("bsp", d), "/layer/bsp")
+        self.assertEqual(bb.utils.layer_path("bsptwo", d), "/layer/bsptw=
o")
+
+        with self.assertRaises(KeyError):
+            bb.utils.layer_path("no-such-layer", d)
+
+        with self.assertRaises(KeyError):
+            bb.utils.layer_path("malformed", d)
+
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 366836bfc9..8106ada29c 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1902,6 +1902,22 @@ def get_file_layer(filename, d, collection_res=3D{=
}):
=20
     return result
=20
+def layer_path(layername, d):
+    """
+    Return the path to the specified layer, or raises KeyError if the la=
yer
+    cannot be found.
+    """
+    bbpath =3D d.getVar("BBPATH").split(":")
+    pattern =3D d.getVar('BBFILE_PATTERN_' + layername)
+    if not pattern:
+        raise KeyError(f"Cannot find BBFILE_PATTERN for {layername}")
+
+    # Sort and reverse to protect against BBFILE_PATTERNs that don't hav=
e
+    # trailing slashes
+    for path in reversed(sorted(bbpath)):
+        if re.match(pattern, path + "/"):
+            return path
+    raise KeyError(f"Could not match BBFILE_PATTERN for {layername}")
=20
 # Constant taken from http://linux.die.net/include/linux/prctl.h
 PR_SET_PDEATHSIG =3D 1
--=20
2.43.0


