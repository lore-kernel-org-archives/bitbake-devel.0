Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web12.912.1613681633070217500
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:53:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id 5710F60053;
	Thu, 18 Feb 2021 15:53:52 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id 2EBD460052;
	Thu, 18 Feb 2021 20:53:50 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 1/9] bitbake: providers: fix incorrect return type bug
Date: Thu, 18 Feb 2021 20:52:13 +0000
Message-Id: <20210218205221.55005-2-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

If no eligible providers are found then an integer zero is returned.
This causes the following error, in two possible places in taskdata.py,
when the return value is used in a list comprehension:

[snip]
    eligible =3D [p for p in eligible if not p in self.failed_fns]
TypeError: 'int' object is not iterable
[\snip]

Fix by returning the variable eligible itself, of type list.

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/providers.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 0c87dfd4bc..32b2261eb0 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -250,7 +250,7 @@ def _filterProviders(providers, item, cfgData, dataCa=
che):
=20
     if len(eligible) =3D=3D 0:
         logger.error("no eligible providers for %s", item)
-        return 0
+        return eligible
=20
     # If pn =3D=3D item, give it a slight default preference
     # This means PREFERRED_PROVIDER_foobar defaults to foobar if availab=
le
--=20
2.30.0

