Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web09.877.1613681635890443178
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:53:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id 8582C60053;
	Thu, 18 Feb 2021 15:53:55 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id 73D8D60052;
	Thu, 18 Feb 2021 20:53:54 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 3/9] bitbake: providers: remove unneeded logging call
Date: Thu, 18 Feb 2021 20:52:15 +0000
Message-Id: <20210218205221.55005-4-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

The logging line for when no eligible providers are found only adds
unnecessary noise and is not required. As the stack unwinds better
logging occurs which satisfactorily describes the no eligible providers
error condition.

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/providers.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index b5a6cd0090..714f64bfd4 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -249,7 +249,6 @@ def _filterProviders(providers, item, cfgData, dataCa=
che):
         eligible.append(preferred_versions[pn][1])
=20
     if not eligible:
-        logger.error("no eligible providers for %s", item)
         return eligible
=20
     # If pn =3D=3D item, give it a slight default preference
--=20
2.30.0

