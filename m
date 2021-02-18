Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web08.867.1613681634329117911
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:53:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id F16A660053;
	Thu, 18 Feb 2021 15:53:53 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id CBDF760052;
	Thu, 18 Feb 2021 20:53:52 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 2/9] bitbake: providers: use pythonic empty list check
Date: Thu, 18 Feb 2021 20:52:14 +0000
Message-Id: <20210218205221.55005-3-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/providers.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 32b2261eb0..b5a6cd0090 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -248,7 +248,7 @@ def _filterProviders(providers, item, cfgData, dataCa=
che):
         preferred_versions[pn] =3D findLatestProvider(pn, cfgData, dataC=
ache, sortpkg_pn[pn][0])
         eligible.append(preferred_versions[pn][1])
=20
-    if len(eligible) =3D=3D 0:
+    if not eligible:
         logger.error("no eligible providers for %s", item)
         return eligible
=20
--=20
2.30.0

