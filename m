Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.34219.1629999919462143783
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Aug 2021 10:45:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=Qi/nxOgD;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629999919;
  x=1661535919;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=qUcWCA2Ez/NplagFZJuaTIKF5b7lQ/lLDENNSUtugvw=;
  b=Qi/nxOgDIZvrhka2aB9G3OI5KXuzSUQvJbdFp/IYT2uakzCr4XD6xaWc
   eBaEKWfEVCeUGCKUzxS2NKL4M3ev07nyRlx3hFciVbDaikXTzid+MtW0J
   Ew0ufRgqenVd/7EVM2YYss/W3kKv0/QfFib4z0JoiEV+Wf87I0aVEElpa
   KZwkxT5ztQfjltlJdbz7wDhT325iTsvWeHnkwxIdKWIjlhkHhDbBrVdwG
   LXBVqC/jXmsBF/rByjfsO81q42wsgaoNsKpm75xOeyrF0gsq8U2qFAtRO
   Xw/7HIzcsTLESIBcvJQ1W0Q87S3xEMp6H2dSuGNwZQvFCC8t3Nce+JJ0d
   g==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] providers: Use new override syntax when handling pn- "override"
Thread-Topic: [bitbake-devel] [PATCH] providers: Use new override syntax when
 handling pn- "override"
Thread-Index: AQHXmqD/q5eykmH/3UOK1jdGBn+MvKuGDSog
Date: Thu, 26 Aug 2021 17:45:17 +0000
Message-ID: <2f401da4d3e646e7b2aaecd9ac871acb@axis.com>
References: <169EEBD79694E731.9667@lists.openembedded.org>
In-Reply-To: <169EEBD79694E731.9667@lists.openembedded.org>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Return-Path: peter.kjellerstedt@axis.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 26 augusti 2021 19:37
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] providers: Use new override syntax when
> handling pn- "override"
>=20
> Make versionVariableMatch() support pn-foo overrides using the new
> override syntax.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/providers.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
> index 516d45e4aa..8c1c31a5c5 100644
> --- a/bitbake/lib/bb/providers.py
> +++ b/bitbake/lib/bb/providers.py
> @@ -94,7 +94,7 @@ def versionVariableMatch(cfgData, keyword, pn):
>=20
>      # pn can contain '_', e.g. gcc-cross-x86_64 and an override cannot
>      # hence we do this manually rather than use OVERRIDES
> -    ver =3D cfgData.getVar("%s_VERSION_pn-%s" % (keyword, pn))
> +    ver =3D cfgData.getVar("%s_VERSION:pn-%s" % (keyword, pn))
>      if not ver:
>          ver =3D cfgData.getVar("%s_VERSION_%s" % (keyword, pn))
>      if not ver:

I do not know why PREFERRED_VERSION_<foo> & co have not been changed to=20
the new syntax, but I will argue that at least PREFERRED_VERSION_pn-<foo>=20
should be changed to PREFERRED_VERSION:pn-<foo> as per above to not cause=20
confusion. Though I am unsure if anyone actually uses that format, at=20
least I didn't know it was even supported until I found the above code.

//Peter

