Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web08.871.1613681637402566691
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:53:57 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id 1080960056;
	Thu, 18 Feb 2021 15:53:57 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id 1BE1E60052;
	Thu, 18 Feb 2021 20:53:55 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 4/9] bitbake: providers: consistent single line formatting between functions
Date: Thu, 18 Feb 2021 20:52:16 +0000
Message-Id: <20210218205221.55005-5-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/providers.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 714f64bfd4..e8241d90c0 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -48,7 +48,6 @@ def findProviders(cfgData, dataCache, pkg_pn =3D None):
=20
     return (latest_versions, preferred_versions)
=20
-
 def allProviders(dataCache):
     """
     Find all providers for each pn
@@ -59,7 +58,6 @@ def allProviders(dataCache):
         all_providers[pn].append((ver, fn))
     return all_providers
=20
-
 def sortPriorities(pn, dataCache, pkg_pn =3D None):
     """
     Reorder pkg_pn by file priority and default preference
@@ -189,7 +187,6 @@ def findLatestProvider(pn, cfgData, dataCache, file_s=
et):
=20
     return (latest, latest_f)
=20
-
 def findBestProvider(pn, cfgData, dataCache, pkg_pn =3D None, item =3D N=
one):
     """
     If there is a PREFERRED_VERSION, find the highest-priority bbfile
@@ -209,7 +206,6 @@ def findBestProvider(pn, cfgData, dataCache, pkg_pn =3D=
 None, item =3D None):
=20
     return (latest, latest_f, preferred_ver, preferred_file)
=20
-
 def _filterProviders(providers, item, cfgData, dataCache):
     """
     Take a list of providers and filter/reorder according to the
@@ -265,7 +261,6 @@ def _filterProviders(providers, item, cfgData, dataCa=
che):
=20
     return eligible
=20
-
 def filterProviders(providers, item, cfgData, dataCache):
     """
     Take a list of providers and filter/reorder according to the
@@ -387,7 +382,6 @@ def getRuntimeProviders(dataCache, rdepend):
=20
     return rproviders
=20
-
 def buildWorldTargetList(dataCache, task=3DNone):
     """
     Build package list for "bitbake world"
--=20
2.30.0

