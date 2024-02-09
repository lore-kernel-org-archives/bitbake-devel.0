Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A953C4828F
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 16:04:37 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.15501.1707494671154468959
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 08:04:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PSGKozqk;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: thomas.perrot@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD1426000E;
	Fri,  9 Feb 2024 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707494669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yd8N16xaUYwWL1aa4nkZtiCDLSt3i+UjrC1UKflDahA=;
	b=PSGKozqkAm0z6xFwflbxFdg71TwElWIlkXeyXpYhUeYgDcHy2RWO5rXvYBu4iephsrq9RS
	uFasR0oe/ypiZz66anx0AXPudY6S7tGitcDi0gYDd+3uH8zMh1S5bjNz2xJlXIA54v7unc
	fEaxZoaAygXlxxmGmYfYcVFhh2FQFHs4u4FjsO8eIbeUsQJr9FLZm9zqUBqoU5ESdscV9x
	jgv78oSUfMaEc9Jm0XGRKKtt1Iz9CujSocsIRo3/IkxNcHqPcB6ozhaVTRvzuwpJUoK4pH
	7KAh86L9HM/HRbv6dl9LD4HFQ4YKkZ9mOcqG7u/xC6psFlF1e5A2hL4rJbrEGw==
Message-ID: <3554214325be6023bc07eae6127f2cc445873f7b.camel@bootlin.com>
Subject: Re: [bitbake-devel][PATCH] wget.py: always use the custom user agent
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 09 Feb 2024 17:04:28 +0100
In-Reply-To: <CANPvuR=3rtSZfRaZbFUS4J+03o89fiURPzZc+abPSv52aFM-MA@mail.gmail.com>
References: <20240209152547.2741703-1-thomas.perrot@bootlin.com>
	 <CANPvuR=3rtSZfRaZbFUS4J+03o89fiURPzZc+abPSv52aFM-MA@mail.gmail.com>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-2JbQQTRV8D2EInFMg6HW"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-GND-Sasl: thomas.perrot@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 16:04:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15855


--=-2JbQQTRV8D2EInFMg6HW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jose,

On Fri, 2024-02-09 at 15:52 +0000, Jose Quaresma wrote:
>=20
>=20
> Thomas Perrot via lists.openembedded.org
> <thomas.perrot=3Dbootlin.com@lists.openembedded.org> escreveu (sexta,
> 9/02/2024 =C3=A0(s) 15:25):
> > From: Thomas Perrot <thomas.perrot@bootlin.com>
> >=20
> > Add the "--user-agent" paramater in the wget base command to
> > perform all wget commands with this parameter, because a few
> > HTTP servers block requests with the default wget user agent.
> >=20
> > For example, "hg.openjdk.org" never send a response to requests
> > have been sent with wget:
> > wget https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
> > https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
> > Resolving hg.openjdk.org (hg.openjdk.org)... 23.54.129.73
> > Connecting to hg.openjdk.org (hg.openjdk.org)|23.54.129.73|:443...
> > connected.
> > HTTP request sent, awaiting response...
> >=20
> > Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> > ---
> > =C2=A0lib/bb/fetch2/wget.py | 7 ++++---
> > =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> > index dc025800e659..e7c4cdd396b3 100644
> > --- a/lib/bb/fetch2/wget.py
> > +++ b/lib/bb/fetch2/wget.py
> > @@ -87,7 +87,8 @@ class Wget(FetchMethod):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not ud.localfile:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.localfile =3D d.expa=
nd(urllib.parse.unquote(ud.host +
> > ud.path).replace("/", "."))
> >=20
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.basecmd =3D d.getVar("FETCHCMD_wget")=
 or "/usr/bin/env
> > wget -t 2 -T 30 --passive-ftp"
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.basecmd =3D d.getVar("FETCHCMD_wget")=
 \
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or "/usr/bin/env wget -t 2 -=
T 30 --passive-ftp --user-
> > agent=3D'%s'" % (self.user_agent)
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.check_certs(d):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.basecmd +=3D " --n=
o-check-certificate"
> > @@ -454,7 +455,7 @@ class Wget(FetchMethod):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f =3D tempfile.NamedTemporaryFile()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with tempfile.TemporaryDirectory(pref=
ix=3D"wget-index-") as
> > workdir, tempfile.NamedTemporaryFile(dir=3Dworkdir, prefix=3D"wget-
> > listing-") as f:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetchcmd =3D self.basec=
md
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchcmd +=3D " -O " + f.nam=
e + " --user-agent=3D'" +
> > self.user_agent + "' '" + uri + "'"
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchcmd +=3D " -O '" + uri =
+ "'"
> >=20
>=20
>=20
> Looks like the file name was removed unintentional.

Really sorry for this error, I'm sending a v2.

Kind regards,
Thomas Perrot
>=20
> Jose
> =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._run=
wget(ud, d, fetchcmd, True,
> > workdir=3Dworkdir)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetchresu=
lt =3D f.read()
> > @@ -492,7 +493,7 @@ class Wget(FetchMethod):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0valid =3D 1
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif self=
._vercmp(version, newver) < 0:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0version =3D newver
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pupver =3D re.sub('_', '.', version[1=
])
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.debug(3, "*** %s -> UpstreamVersio=
n =3D %s
> > (CurrentVersion =3D %s)" %
> >=20
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#15853):
> > https://lists.openembedded.org/g/bitbake-devel/message/15853
> > Mute This Topic:
> > https://lists.openembedded.org/mt/104260370/5443093
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe:
> > https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[thomas.perro=
t@bootlin.com
> > ]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >=20

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


--=-2JbQQTRV8D2EInFMg6HW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmXGTQwACgkQn8ALBXH+
Cu3WDAv/VcFNJFyLgXSAhefN4KTwuqsfLEKqXtBrY3D7eCNubSoP4QcAwrgndTk8
+MYoMjc62zVnCiR1RIr2NyTicpHDhMMfoQGAmvbeF+vZ2Q4IXf9mfCl9V4353Fqr
pk6SQ+a44cF0IuxvMLJ7GuUNQnPclB+HPPCq2zj/7Cn/DNShghpQVmT2wEqulIfF
xB3zejycTwsISYDWFbYSYSZc/ovixgs3siO6qBqz3EZo/XQBaFcZAZpTY2u7NC+U
+rnlN+TDX2KUYLUCkcG+ZBX8dhDEgpd+CvsCsClGbgFT+tcs8FKwNQsZXkD39gvt
qNvha8O7d471o+VV6+R7NL7LG6kvdoWaQS3WXZlodQgB8T5B2VkyJxivKac3GX2z
v3AoxSVuJ6aaxautfE9w2/XLIV/aCbHtc/geo6YGA7Nb4efAdpjG5sdaImdUQ+ss
qL4ohiXHU96DZVNV5h32RA3A1tGdXUYinKGRfTTCUNfb/ThIgdMcKxflQ93fjGPR
NYoKNbrv
=yi/a
-----END PGP SIGNATURE-----

--=-2JbQQTRV8D2EInFMg6HW--

