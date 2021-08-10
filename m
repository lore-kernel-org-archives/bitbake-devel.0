Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.266.1628614513550032125
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Aug 2021 09:55:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 192BE6D
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Aug 2021 09:55:12 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7DDA3F718
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Aug 2021 09:55:11 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 1/4] utils: add environment updating context manager
Date: Tue, 10 Aug 2021 17:55:06 +0100
Message-Id: <20210810165509.19121-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bb.utils.environment() is a context manager to alter os.environ inside
a specific block, restoring it after the block is closed.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tests/utils.py | 18 ++++++++++++++++++
 bitbake/lib/bb/utils.py       | 16 ++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/bitbake/lib/bb/tests/utils.py b/bitbake/lib/bb/tests/utils.p=
y
index a7ff33db527..4d5e21b99e1 100644
--- a/bitbake/lib/bb/tests/utils.py
+++ b/bitbake/lib/bb/tests/utils.py
@@ -666,3 +666,21 @@ class GetReferencedVars(unittest.TestCase):
=20
         layers =3D [{"SRC_URI"}, {"QT_GIT", "QT_MODULE", "QT_MODULE_BRAN=
CH_PARAM", "QT_GIT_PROTOCOL"}, {"QT_GIT_PROJECT", "QT_MODULE_BRANCH", "BP=
N"}, {"PN", "SPECIAL_PKGSUFFIX"}]
         self.check_referenced("${SRC_URI}", layers)
+
+
+class EnvironmentTests(unittest.TestCase):
+    def test_environment(self):
+        os.environ["A"] =3D "this is A"
+        self.assertIn("A", os.environ)
+        self.assertEqual(os.environ["A"], "this is A")
+        self.assertNotIn("B", os.environ)
+
+        with bb.utils.environment(B=3D"this is B"):
+            self.assertIn("A", os.environ)
+            self.assertEqual(os.environ["A"], "this is A")
+            self.assertIn("B", os.environ)
+            self.assertEqual(os.environ["B"], "this is B")
+
+        self.assertIn("A", os.environ)
+        self.assertEqual(os.environ["A"], "this is A")
+        self.assertNotIn("B", os.environ)
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index e6e82d11182..70634910f7b 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1681,3 +1681,19 @@ def rename(src, dst):
             shutil.move(src, dst)
         else:
             raise err
+
+@contextmanager
+def environment(**envvars):
+    """
+    Context manager to selectively update the environment with the speci=
fied mapping.
+    """
+    backup =3D dict(os.environ)
+    try:
+        os.environ.update(envvars)
+        yield
+    finally:
+        for var in envvars:
+            if var in backup:
+                os.environ[var] =3D backup[var]
+            else:
+                del os.environ[var]
--=20
2.25.1

