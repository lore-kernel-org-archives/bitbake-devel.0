Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web12.13462.1624896302979927079
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Jun 2021 09:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9950C1042
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Jun 2021 09:05:02 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428713F718
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Jun 2021 09:05:02 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/wget: fetch securely by default
Date: Mon, 28 Jun 2021 17:04:58 +0100
Message-Id: <20210628160458.945324-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The days of broken certificates are behind us now, so instead of always
passing --no-check-certificate to wget, don't pass it by default and
instead only pass it if the SRC_URI has insecure=3D1 set.

[ YOCTO #14108 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/wget.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index 784df70c9f6..1088b8e9649 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -82,7 +82,10 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile =3D d.expand(urllib.parse.unquote(ud.host + ud.=
path).replace("/", "."))
=20
-        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t 2 -T 30 --passive-ftp --no-check-certificate"
+        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t 2 -T 30 --passive-ftp"
+
+        if ud.parm.get('insecure', '0') =3D=3D '1':
+            self.basecmd +=3D " --no-check-certificate"
=20
     def _runwget(self, ud, d, command, quiet, workdir=3DNone):
=20
@@ -288,12 +291,14 @@ class Wget(FetchMethod):
         if exported_proxies:
             handlers.append(urllib.request.ProxyHandler())
         handlers.append(CacheHTTPHandler())
+
         # Since Python 2.7.9 ssl cert validation is enabled by default
         # see PEP-0476, this causes verification errors on some https se=
rvers
         # so disable by default.
         import ssl
-        if hasattr(ssl, '_create_unverified_context'):
+        if ud.parm.get('insecure', '0') =3D=3D '1' and hasattr(ssl, '_cr=
eate_unverified_context'):
             handlers.append(urllib.request.HTTPSHandler(context=3Dssl._c=
reate_unverified_context()))
+
         opener =3D urllib.request.build_opener(*handlers)
=20
         try:
--=20
2.25.1

