Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web08.20189.1625660435860794099
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Jul 2021 05:20:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 666296D
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Jul 2021 05:20:25 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 087E23F73B
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Jul 2021 05:20:24 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bb/utils: add layer_path() function
Date: Wed,  7 Jul 2021 13:20:21 +0100
Message-Id: <20210707122021.2924476-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add layer_path() which will return the path to a layer. Useful to
programatically find other layers at build time, or from tinfoil.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/utils.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 6ba1d2a3766..951fa3cb0e4 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1537,6 +1537,16 @@ def get_file_layer(filename, d, collection_res=3D{=
}):
=20
     return result
=20
+def layer_path(layername, d):
+    """
+    Return the path to the specified layer, or None if the layer isn't p=
resent.
+    """
+    bbpath =3D d.getVar("BBPATH").split(":")
+    pattern =3D d.getVar('BBFILE_PATTERN_' + layername)
+    for path in reversed(sorted(bbpath)):
+        if re.match(pattern, path + "/"):
+            return path
+    return None
=20
 # Constant taken from http://linux.die.net/include/linux/prctl.h
 PR_SET_PDEATHSIG =3D 1
--=20
2.25.1

