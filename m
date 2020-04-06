Received: from Henrys-MBP.localdomain (Henrys-MBP.localdomain [114.34.172.18])
 by mx.groups.io with SMTP id smtpd.web12.6353.1586156673153161753
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2020 00:04:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: henrys-mbp.localdomain, ip: 114.34.172.18, mailfrom: jrhenry@henrys-mbp.localdomain)
Received: by Henrys-MBP.localdomain (Postfix, from userid 501)
	id D6EBD96D8BB; Mon,  6 Apr 2020 15:04:29 +0800 (CST)
From: "Henry Chang" <mr.changyuheng@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Henry Chang <mr.changyuheng@gmail.com>
Subject: [PATCH] lib: Fix not selecting the newest version from the versions that match the wildcard-preferred version
Date: Mon,  6 Apr 2020 15:04:28 +0800
Message-Id: <20200406070428.6918-1-mr.changyuheng@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Same issue can be found here: https://patchwork.openembedded.org/patch/10=
8877/

Quote:
> I have two recipes within a single layer:
>
>   stblinux_3.14-1.7.bb
>   stblinux_3.14-1.8.bb
>
> If PREFERRED_VERSION_stblinux is set to "3.14%", then I would expect
> the version 3.14-1.8 recipe to be selected, however 3.14-1.7 gets
> selected instead.
>
> Reversing the order of files stored in pkg_pn[pn] seems to help. Is it
> a reasonable solution?

Signed-off-by: Henry Chang <mr.changyuheng@gmail.com>
---
 lib/bb/providers.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 81459c36..7ec0e025 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -133,7 +133,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg=
_pn =3D None, item =3D None):
             preferred_r =3D None
=20
         for file_set in pkg_pn:
-            for f in file_set:
+            for f in reversed(file_set):
                 pe, pv, pr =3D dataCache.pkg_pepvpr[f]
                 if preferredVersionMatch(pe, pv, pr, preferred_e, prefer=
red_v, preferred_r):
                     preferred_file =3D f
--=20
2.25.0

