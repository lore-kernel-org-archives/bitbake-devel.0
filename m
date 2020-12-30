Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
 by mx.groups.io with SMTP id smtpd.web11.13485.1609365990752149929
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Dec 2020 14:06:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stwcx.xyz header.s=fm3 header.b=fj6Am3L3;
 spf=pass (domain: stwcx.xyz, ip: 64.147.123.25, mailfrom: patrick@stwcx.xyz)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 1580C9E6
	for <bitbake-devel@lists.openembedded.org>; Wed, 30 Dec 2020 17:06:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 30 Dec 2020 17:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
	date:from:to:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=fm3; bh=b+NsEtzK0aUpgiiDQUX9n2nwWG+
	jcawpnD4uOkjQmtU=; b=fj6Am3L3AkJuOXH3LG1FHgEIMy2KFnl573X6yTgqnvW
	Lh1n+47TX4LBQEG8IQONShDb66yop/ChcQPvSrUTBSU7T+Pqyl6QsTrH1PQRgdlX
	avIDM5P15h+uL1BN3EMJ4YJxUUFq87gtHRHsq2gSeKI2XNVlpfYSLZDrzCWMet0U
	Gp0xI+RmrZJdg/ebs5gPTH4XePFaHBGTQh+8Gvblj+gkmtcFpk3kycWQvZh/rRAH
	RCiT340GLVcHFNqou3nCuUMv9GHNzZp6t+UOLzbfRTUw6QGOrj0JfrXabrDYoac9
	+OtYikU9fEjIHt7qb+H2LIgH8NXcZZ2nq6I8aCyTHwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=b+NsEt
	zK0aUpgiiDQUX9n2nwWG+jcawpnD4uOkjQmtU=; b=hIqQ8V+9q/8JYmXQ3Y5l7E
	uncx2epuleVhcuxjNawCm772xfV9oIdA70lFq1VzDm28ZK1YXinxnXFEune5VD4p
	QjAIRcUSvFIxJpYatB/KI2pDdBGerYh3SFDx1NbvQs/D7mhSosEe9oEaqSjR360N
	eifOGkSJBUBpwlp0m0ZRN33V606piiUR6lSt+F1+Qd7VuAYYDs6bkkI5ys3hlKuW
	OyZGSaMbwXTrwEiV0kTvLJ6xOril9NmRoVQdZ2RSoCLDEe45hH5QgjKat6YJk+6h
	o112jq8WHLIhlgQBco71GSV5gfJI9vydMmbRlsW42oRNHdnVsX6IRK+XHx4yeUSQ
	==
X-ME-Sender: <xms:5fnsXx8sBOJvYaa704Cu6gLBlZHqCqbFX0oXetC7IC3NbJlIcTLNdg>
    <xme:5fnsX1u_9NHFYKDs3DluNhNNwK-Drmdd51UAiHdPI7mSUCdZzdTlr-YFOnmv7qoaK
    HYmS_fBqvI0Jhcv8Os>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvfedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepff
    fhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucghihhl
    lhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrh
    hnpeegheehfeffgeekveehtdfhgfduhfegfefgtdehhfektdelffevkefgueffhedtieen
    ucfkphepudeiiedrudejiedruddvfedrudejkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:5fnsX_CTZZIMlG4zPkuMGhuNIbkScMtdkpda3WPfIw0rp6H1JOYFRw>
    <xmx:5fnsX1cJTV6AK7-mrDHks-GIEta4ZMW6F5BfJuENpNEqNy1O2A-Okw>
    <xmx:5fnsX2PoqKdhXvXtw_VntDNHhLFZiTTe4xjK3FQh3obbFI9BnVxcPw>
    <xmx:5fnsX8ZbvOd9ewnD13BT_pEDr3WmtM_QbHm1uIfxqBvN0LKQIlGRPg>
Received: from localhost (mobile-166-176-123-178.mycingular.net [166.176.123.178])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6B7E9108005B
	for <bitbake-devel@lists.openembedded.org>; Wed, 30 Dec 2020 17:06:29 -0500 (EST)
Date: Wed, 30 Dec 2020 16:06:28 -0600
From: "Patrick Williams" <patrick@stwcx.xyz>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v4] fetch2/wget: include parameters in URL
Message-ID: <X+z55CKAFrEE0Hdr@heinlein>
References: <20201229151316.165171-1-patrick@stwcx.xyz>
 <20201230220323.727622-1-patrick@stwcx.xyz>
MIME-Version: 1.0
In-Reply-To: <20201230220323.727622-1-patrick@stwcx.xyz>
X-Groupsio-MsgNum: 11893
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sYvdwtYu4LSClMCo"
Content-Disposition: inline

--sYvdwtYu4LSClMCo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 04:03:23PM -0600, Patrick Williams wrote:
> The wget fetcher currently silently drops all parameters and has
> been that way since it was originally introduced in fetch via 080eb8764.
> This prevents use in SOURCE_MIRROR_URL and SRC_URI which require
> additional parameters.
>=20
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> ---
>  lib/bb/fetch2/wget.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index e6d9f528..0019f10c 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -91,7 +91,14 @@ class Wget(FetchMethod):
> =20
>          fetchcmd =3D self.basecmd
> =20
> -        if 'downloadfilename' in ud.parm:
> +        # Join the URL components together.
> +        url_parts =3D ud.url.split(";")
> +        if len(url_parts) =3D=3D 1:
> +            uri =3D url_parts[0]
> +        else:
> +            uri =3D url_parts[0] + "?" + "&".join(url_parts[1:])
> +
> +        if 'downloadfilename' in ud.parm or len(url_parts) !=3D 1:
>              localpath =3D os.path.join(d.getVar("DL_DIR"), ud.localfile)
>              bb.utils.mkdirhier(os.path.dirname(localpath))
>              fetchcmd +=3D " -O %s" % shlex.quote(localpath)
> @@ -99,7 +106,6 @@ class Wget(FetchMethod):
>          if ud.user and ud.pswd:
>              fetchcmd +=3D " --user=3D%s --password=3D%s --auth-no-challe=
nge" % (ud.user, ud.pswd)
> =20
> -        uri =3D ud.url.split(";")[0]

I ran into one more edge case trying to re-download a file from my
internal mirror service: netbase_6.1~bpo10+1.tar.xz .  The URL
contains a URL-quoted version of the filename.  Switched the code
to reuse the 'downloadfilename' logic earlier in the function, which
is safer anyhow because it uses shlex, etc.

>          if os.path.exists(ud.localpath):
>              # file exists, but we didnt complete it.. trying again..
>              fetchcmd +=3D d.expand(" -c -P ${DL_DIR} '%s'" % uri)
> @@ -441,7 +447,7 @@ class Wget(FetchMethod):
>                      valid =3D 1
>                  elif self._vercmp(version, newver) < 0:
>                      version =3D newver
> -               =20
> +
>          pupver =3D re.sub('_', '.', version[1])
> =20
>          bb.debug(3, "*** %s -> UpstreamVersion =3D %s (CurrentVersion =
=3D %s)" %
> --=20
> 2.26.2
>=20

--=20
Patrick Williams

--sYvdwtYu4LSClMCo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAl/s+eIACgkQqwNHzC0A
wRk0tg//UV+pIQV+Xn0eZkL2OXHm19VcEezK+IYXBL2C55g1CvI+vMyTEvYIy0+k
Asi1kOJN8RIe6yCDVvssFS0e7DwrPGfG69ueM1FqJ3O1l1lLXTy1Dl9IEAnuADf1
551k99YXOFz1ZiO+u/Ljqsnn7gb1hae7tFEGuvw1TRHK91FdmpXF2tmzTajoA34R
q8bOM18pr09XQvLbo0jNceqhqessHT9269/iMpHo7oqpZqFV0O5pmXrZtuLU7N4u
pnyPZ5HIz9bUzY9VciOPG/tvt6qxgLlNvP+fmAMBFzG4WqQOnKYclUs/rPGdm9xm
6kRJccuOiQBFHrSQXYNYYCsp5IuPT7ctlMfPxEzbCeQjRHn9ArIPOcqU/XqULKZD
Hw3kILFLGoQ942FEuqg8evgCONtrfog5sEcB1vC0bsFfiwUSKNk7NZENC+TDASi1
2AT4lKM8mYtMozamAtbpTDoDfnEYNtx4XOPUD9zGzU0GTuUQJ/qtiQYUKErOo895
hZbQcUN4ucjFfOekgVum+WfSb9ttbZzeIVybcJ/8sebOHqbIq52BmpDkGHlz23Jl
IFrtXD0pxMpUyjsVHT4fuMdrYSU2lzqf6S0m1Sv+Y8/4lNeoJ1WpjhbyMc5FYgQ+
3r6JXjru0agP2tlGb1rB9ymxhVIm0u/69ivyrgIj9b88d6pQQqI=
=PR1v
-----END PGP SIGNATURE-----

--sYvdwtYu4LSClMCo--
