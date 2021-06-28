Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web10.14136.1624899109609305581
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Jun 2021 09:51:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.178.231, mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay11.mail.gandi.net (Postfix) with ESMTPSA id 92D45100005;
	Mon, 28 Jun 2021 16:51:47 +0000 (UTC)
Date: Mon, 28 Jun 2021 16:51:41 +0000
From: "Quentin Schulz" <foss@0leil.net>
To: bitbake-devel@lists.openembedded.org, Ross Burton <ross@burtonini.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: fetch securely by default
In-Reply-To: <20210628160458.945324-1-ross.burton@arm.com>
References: <20210628160458.945324-1-ross.burton@arm.com>
Message-ID: <957C68A6-EAD9-4A26-A42D-0F4F868276BE@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ross,

On June 28, 2021 4:04:58 PM UTC, Ross Burton <ross@burtonini=2Ecom> wrote:
>The days of broken certificates are behind us now, so instead of always
>passing --no-check-certificate to wget, don't pass it by default and
>instead only pass it if the SRC_URI has insecure=3D1 set=2E
>

Please also send a patch to the documentation of the wget fetcher=2E

Cheers,
Quentin

>[ YOCTO #14108 ]
>
>Signed-off-by: Ross Burton <ross=2Eburton@arm=2Ecom>
>---
> bitbake/lib/bb/fetch2/wget=2Epy | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/bitbake/lib/bb/fetch2/wget=2Epy b/bitbake/lib/bb/fetch2/wget=
=2Epy
>index 784df70c9f6=2E=2E1088b8e9649 100644
>--- a/bitbake/lib/bb/fetch2/wget=2Epy
>+++ b/bitbake/lib/bb/fetch2/wget=2Epy
>@@ -82,7 +82,10 @@ class Wget(FetchMethod):
>         if not ud=2Elocalfile:
>             ud=2Elocalfile =3D d=2Eexpand(urllib=2Eparse=2Eunquote(ud=2E=
host + ud=2Epath)=2Ereplace("/", "=2E"))
>=20
>-        self=2Ebasecmd =3D d=2EgetVar("FETCHCMD_wget") or "/usr/bin/env =
wget -t 2 -T 30 --passive-ftp --no-check-certificate"
>+        self=2Ebasecmd =3D d=2EgetVar("FETCHCMD_wget") or "/usr/bin/env =
wget -t 2 -T 30 --passive-ftp"
>+
>+        if ud=2Eparm=2Eget('insecure', '0') =3D=3D '1':
>+            self=2Ebasecmd +=3D " --no-check-certificate"
>=20
>     def _runwget(self, ud, d, command, quiet, workdir=3DNone):
>=20
>@@ -288,12 +291,14 @@ class Wget(FetchMethod):
>         if exported_proxies:
>             handlers=2Eappend(urllib=2Erequest=2EProxyHandler())
>         handlers=2Eappend(CacheHTTPHandler())
>+
>         # Since Python 2=2E7=2E9 ssl cert validation is enabled by defau=
lt
>         # see PEP-0476, this causes verification errors on some https se=
rvers
>         # so disable by default=2E
>         import ssl
>-        if hasattr(ssl, '_create_unverified_context'):
>+        if ud=2Eparm=2Eget('insecure', '0') =3D=3D '1' and hasattr(ssl, =
'_create_unverified_context'):
>             handlers=2Eappend(urllib=2Erequest=2EHTTPSHandler(context=3D=
ssl=2E_create_unverified_context()))
>+
>         opener =3D urllib=2Erequest=2Ebuild_opener(*handlers)
>=20
>         try:
>--=20
>2=2E25=2E1
>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
