Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.2490.1627979985890008976
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Aug 2021 01:39:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=LCVStmY8;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1627979986;
  x=1659515986;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=GEhGLqkAg23/bI2NngSvkzbeBmfzikpA20ac5RdfVL0=;
  b=LCVStmY81fMuQHnhIDRriRgKqjxyiAVnQl6ggkS3d5Tz1mmk0PZGEgKU
   Fb/6orCViABuV1m9ZXTlzwVasdke11txjecxI0lwchP8ZmSBaFfSvHzQl
   hkjw+PSPzs/m21StWZ/MhDaBSrVo0FEF7k7bkabQ36m2gffudx/LM6KZR
   RAmso2EnC1t3wYp3GctJuqQ5VaLAaPb6LxA1b7PCydeLEpaCu/a1oU4sz
   nTahY2KL7wJe3m5q3diXHbILAr7AVN9ht5KZczfIaJakcEtogvOijsbeM
   vL29Vfo12pzAPRAsnxcbqL0n1YupaRGbLrNAifttGv+fETjioIiIYHkgt
   Q==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Fix inactive overide accidental variable value corruption
Thread-Topic: [bitbake-devel] [PATCH] data_smart: Fix inactive overide
 accidental variable value corruption
Thread-Index: AQHXh7T8NU+jS8JzFEu0qoxkOW/tfathdjYg
Date: Tue, 3 Aug 2021 08:39:42 +0000
Message-ID: <4331c60640d446eaba8788dd4fcf3009@axis.com>
References: <20210802154212.3453639-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210802154212.3453639-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.13.13]
MIME-Version: 1.0
Return-Path: peter.kjellerstedt@axis.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 2 augusti 2021 17:42
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] data_smart: Fix inactive overide
> accidental variable value corruption
>=20
> Setting something like:
>=20
>   BAR:append:unusedoverride
>=20
> should cause BAR to be None, not "" which was what the datastore was
> returning. This caused problems when mixing variables like:
>=20
>   RDEPENDS:${PN}:inactiveoverride
>   RDEPENDS:${BPN}
>=20
> since key expansion would report key overlap when there was none. This
> is a bug in the datastore. Fix it and add a test too.
>=20
> [YOCTO #14088]
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/data_smart.py | 8 ++++----
>  lib/bb/tests/data.py | 5 +++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 43e9e78555..65528c6ae6 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -750,8 +750,6 @@ class DataSmart(MutableMapping):
>=20
>=20
>          if flag =3D=3D "_content" and local_var is not None and ":append=
" in local_var and not parsing:
> -            if not value:
> -                value =3D ""
>              self.need_overrides()
>              for (r, o) in local_var[":append"]:
>                  match =3D True
> @@ -760,11 +758,11 @@ class DataSmart(MutableMapping):
>                          if not o2 in self.overrides:
>                              match =3D False
>                  if match:
> +                    if value is None:
> +                        value =3D ""
>                      value =3D value + r

Minor detail, but at least I find this more readable:

                     value =3D (value or "") + r

>=20
>          if flag =3D=3D "_content" and local_var is not None and ":prepen=
d" in local_var and not parsing:
> -            if not value:
> -                value =3D ""
>              self.need_overrides()
>              for (r, o) in local_var[":prepend"]:
>=20
> @@ -774,6 +772,8 @@ class DataSmart(MutableMapping):
>                          if not o2 in self.overrides:
>                              match =3D False
>                  if match:
> +                    if value is None:
> +                        value =3D ""
>                      value =3D r + value
>=20
>          parser =3D None
> diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
> index 7f1d3ffbbc..e667c7c7d3 100644
> --- a/lib/bb/tests/data.py
> +++ b/lib/bb/tests/data.py
> @@ -405,6 +405,11 @@ class TestOverrides(unittest.TestCase):
>          bb.data.expandKeys(self.d)
>          self.assertEqual(self.d.getVar("VERSION"), "2")
>=20
> +    def test_append_and_unused_override(self):
> +        # Had a bug where an unused override append could return "" inst=
ead of None
> +        self.d.setVar("BAR:append:unusedoverride", "testvalue2")
> +        self.assertEqual(self.d.getVar("BAR"), None)
> +
>  class TestKeyExpansion(unittest.TestCase):
>      def setUp(self):
>          self.d =3D bb.data.init()
> --
> 2.30.2

//Peter

