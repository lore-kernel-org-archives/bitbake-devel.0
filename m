Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.26932.1598556341048570475
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2020 12:25:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: sandra.tobajas@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2F9BC9C06A2
	for <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2020 15:25:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DlWck4xD61VM; Thu, 27 Aug 2020 15:25:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A7AF89C06A0;
	Thu, 27 Aug 2020 15:25:39 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1QGZg4fn39LQ; Thu, 27 Aug 2020 15:25:39 -0400 (EDT)
Received: from localhost.localdomain (modemcable244.108-163-184.mc.videotron.ca [184.163.108.244])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 806B09C0545;
	Thu, 27 Aug 2020 15:25:39 -0400 (EDT)
From: "Sandra Tobajas" <sandra.tobajas@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Sandra Tobajas <sandra.tobajas@savoirfairelinux.com>
Subject: [bitbake-devel][PATCH] bitbake: fetch2/npm: allow to build npm package with no dependency
Date: Thu, 27 Aug 2020 15:25:37 -0400
Message-Id: <20200827192537.3091416-1-sandra.tobajas@savoirfairelinux.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the case of an empty npm-shrinkwrap.json file (with no dependency),
the npmsw fetcher was causing a RecursionError reported in [1].

It also happened if the package has only "dev" dependencies and was built
without --npm-dev option.

Add sanity checks to ensure that the dependency list is not empty and set
the urldata proxy attribute to None if no dependency is found.

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13901.

Signed-off-by: Sandra Tobajas <sandra.tobajas@savoirfairelinux.com>
---
 bitbake/lib/bb/fetch2/npmsw.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw=
.py
index 0c3511d8ab..e06719f45b 100644
--- a/bitbake/lib/bb/fetch2/npmsw.py
+++ b/bitbake/lib/bb/fetch2/npmsw.py
@@ -177,17 +177,21 @@ class NpmShrinkWrap(FetchMethod):
         # This fetcher resolves multiple URIs from a shrinkwrap file and=
 then
         # forwards it to a proxy fetcher. The management of the donestam=
p file,
         # the lockfile and the checksums are forwarded to the proxy fetc=
her.
-        ud.proxy =3D Fetch([dep["url"] for dep in ud.deps], data)
+        if ud.deps:
+            ud.proxy =3D Fetch([dep["url"] for dep in ud.deps], data)
+        else:
+            ud.proxy =3D None
         ud.needdonestamp =3D False
=20
     @staticmethod
     def _foreach_proxy_method(ud, handle):
         returns =3D []
-        for proxy_url in ud.proxy.urls:
-            proxy_ud =3D ud.proxy.ud[proxy_url]
-            proxy_d =3D ud.proxy.d
-            proxy_ud.setup_localpath(proxy_d)
-            returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
+        if ud and ud.proxy:
+            for proxy_url in ud.proxy.urls:
+                proxy_ud =3D ud.proxy.ud[proxy_url]
+                proxy_d =3D ud.proxy.d
+                proxy_ud.setup_localpath(proxy_d)
+                returns.append(handle(proxy_ud.method, proxy_ud, proxy_d=
))
         return returns
=20
     def verify_donestamp(self, ud, d):
--=20
2.25.1

