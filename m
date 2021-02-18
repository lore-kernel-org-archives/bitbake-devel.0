Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web08.874.1613681643853394037
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:54:03 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id 7E38360052;
	Thu, 18 Feb 2021 15:54:03 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id 6EF1260053;
	Thu, 18 Feb 2021 20:54:02 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 8/9] bitbake: cooker: Add REQUIRED_VERSION checks
Date: Thu, 18 Feb 2021 20:52:20 +0000
Message-Id: <20210218205221.55005-9-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

Add logic to check that if REQUIRED_VERSION has been set that the cooker
class method findBestProviders properly handles the case where the
REQUIRED_VERSION has not been found.

Fixes [YOCTO #10096]

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/cooker.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 03e311ee83..36e63450ec 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1071,10 +1071,16 @@ class BBCooker:
         if pn in self.recipecaches[mc].providers:
             filenames =3D self.recipecaches[mc].providers[pn]
             eligible, foundUnique =3D bb.providers.filterProviders(filen=
ames, pn, self.databuilder.mcdata[mc], self.recipecaches[mc])
-            filename =3D eligible[0]
+            if eligible is not None:
+                filename =3D eligible[0]
+            else:
+                filename =3D None
             return None, None, None, filename
         elif pn in self.recipecaches[mc].pkg_pn:
-            return bb.providers.findBestProvider(pn, self.databuilder.mc=
data[mc], self.recipecaches[mc], self.recipecaches[mc].pkg_pn)
+            (latest, latest_f, preferred_ver, preferred_file, required) =
=3D bb.providers.findBestProvider(pn, self.databuilder.mcdata[mc], self.r=
ecipecaches[mc], self.recipecaches[mc].pkg_pn)
+            if required and preferred_file is None:
+                return None, None, None, None
+            return (latest, latest_f, preferred_ver, preferred_file)
         else:
             return None, None, None, None
=20
--=20
2.30.0

