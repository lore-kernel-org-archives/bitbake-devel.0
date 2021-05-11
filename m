Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web08.10423.1620725250415797006
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 May 2021 02:27:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40A251692
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 May 2021 02:27:29 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE71F3F719
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 May 2021 02:27:28 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH][1.48] bitbake: providers: selected version not available should be a warning
Date: Tue, 11 May 2021 10:27:23 +0100
Message-Id: <20210511092723.3916148-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Ross Burton <ross@burtonini.com>

If the selected version if not available, bitbake will happily attempt
to build something else. This should be a loud warning not a small note.

(Bitbake rev: 78cd63285713fde59506eb2e71a7b7ee59a594ff)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/providers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 81459c36d56..3f66a3d99fa 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -151,7 +151,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg=
_pn =3D None, item =3D None):
         if item:
             itemstr =3D " (for item %s)" % item
         if preferred_file is None:
-            logger.info("preferred version %s of %s not available%s", pv=
_str, pn, itemstr)
+            logger.warn("preferred version %s of %s not available%s", pv=
_str, pn, itemstr)
             available_vers =3D []
             for file_set in pkg_pn:
                 for f in file_set:
@@ -163,7 +163,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg=
_pn =3D None, item =3D None):
                         available_vers.append(ver_str)
             if available_vers:
                 available_vers.sort()
-                logger.info("versions of %s available: %s", pn, ' '.join=
(available_vers))
+                logger.warn("versions of %s available: %s", pn, ' '.join=
(available_vers))
         else:
             logger.debug(1, "selecting %s as PREFERRED_VERSION %s of pac=
kage %s%s", preferred_file, pv_str, pn, itemstr)
=20
--=20
2.25.1

