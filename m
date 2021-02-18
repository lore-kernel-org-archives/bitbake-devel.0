Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web09.879.1613681640886192649
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:54:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id 85BA260056;
	Thu, 18 Feb 2021 15:54:00 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id 5F85060052;
	Thu, 18 Feb 2021 20:53:59 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 6/9] bitbake: providers: check for REQUIRED_VERSION in _filterProviders
Date: Thu, 18 Feb 2021 20:52:18 +0000
Message-Id: <20210218205221.55005-7-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

Before the REQUIRED_VERSION variable was introduced the
PREFERRED_VERSION variable allowed for a fallback to the next most
suitable version.

Since REQUIRED_VERSION does not allow a fallback to a different version
implement a check in the _filterProviders function to make sure that
if a requested REQUIRED_VERSION is not found then the function returns
no eligible providers have been found.

Fixes [YOCTO #10096]

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/providers.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 09e5701f2e..95152323ef 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -256,10 +256,13 @@ def _filterProviders(providers, item, cfgData, data=
Cache):
=20
     logger.debug("providers for %s are: %s", item, list(sorted(pkg_pn.ke=
ys())))
=20
-    # First add PREFERRED_VERSIONS
+    # First add REQUIRED_VERSIONS or PREFERRED_VERSIONS
     for pn in sorted(pkg_pn):
         sortpkg_pn[pn] =3D sortPriorities(pn, dataCache, pkg_pn)
-        preferred_versions[pn] =3D findPreferredProvider(pn, cfgData, da=
taCache, sortpkg_pn[pn], item)
+        preferred_ver, preferred_file, required =3D findPreferredProvide=
r(pn, cfgData, dataCache, sortpkg_pn[pn], item)
+        if required and preferred_file is None:
+            return eligible
+        preferred_versions[pn] =3D (preferred_ver, preferred_file)
         if preferred_versions[pn][1]:
             eligible.append(preferred_versions[pn][1])
=20
--=20
2.30.0

