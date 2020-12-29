Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web09.18670.1609279338384533824
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Dec 2020 14:02:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stwcx.xyz header.s=fm3 header.b=B9rqweCN;
 spf=pass (domain: stwcx.xyz, ip: 66.111.4.27, mailfrom: patrick@stwcx.xyz)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id AEA545C0062
	for <bitbake-devel@lists.openembedded.org>; Tue, 29 Dec 2020 17:02:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 29 Dec 2020 17:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
	date:from:to:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=fm3; bh=vDkvi32Vq47UQUNzKEme0F81YhV
	ZgVf85CXdhRSKeOs=; b=B9rqweCNreTzPwrsx+oue95GKGjFwidH+Kn91E4ppMv
	Ix5EtWAddK16+Oqst5sKXedNsc+2yX9nAM/7Bex/UlyBzVSEMjDspushxVN9/K4N
	DWHdDxxxtHGL/i9RXS06Jul9TyV6cPUl30FG23QtAz2wjBAiK92HviqFE1AR/QwU
	3ZJ/Fn2jqjeXxLUO4jng9ddp3XhIEwY3M2sQOXqfx1liPj74EgerbvhUcbpjN6B3
	TolED8DvaBLWlMSb8hVjYZjotR2gJs3kKYhrtLpYJlFM8ZGZT6CCPBxV5+Bmy+rz
	1fRWZkR8cKUTd7QUwN6gPWhFbX2Qqb+sgDdJPy12fxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vDkvi3
	2Vq47UQUNzKEme0F81YhVZgVf85CXdhRSKeOs=; b=jpah77+F5paq19pljHRL6A
	5QSZC6uXs/iMNXedlmG0CYsW3rRLfLdjvbvi59BcT8jVqpG7W+Vs57slW6mdwG6g
	PwFxCFoZHoGPfjh+wukhLzu7mZNwSPDwznc4euJ3bIAXWwB7UiMRlHO9w9ycnncv
	FjIhlTLwQNDBbUV4t5SVL3sBSOujfDPA6pcaaZwmba9TxHhTeYbJjPqNlYkDKxIJ
	wwzr/Srvahzu592i6Tp4nzC3xM+74HdYt3caUujPAqotKSFj//U19YMIQYBd/Ntz
	RBNoRaa/YdaRdmex0HIIQHTFtQwujU+XWUsotb//9QxKRT99J0WSuf626/ft5zhw
	==
X-ME-Sender: <xms:aafrX61nww_Aqq065ChMovGuDP5wEcxVEz6aXHQnLQSkO0dHDQX69w>
    <xme:aafrX9Guyia2lfXwj4Ag_n8B4RoU5b0RMFHlFRbpY-xwgk90lavvk5rldrEiwxMlQ
    Ty0whUuIz9FDPqStBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvuddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepff
    fhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucghihhl
    lhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrh
    hnpeegheehfeffgeekveehtdfhgfduhfegfefgtdehhfektdelffevkefgueffhedtieen
    ucfkphepudeiiedrudejiedruddvuddrudefleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:aafrXy6NaPtQfFXPEkRXzPw0PAdTUfe_Uz7FVT81tdB8Lp6pk6AptQ>
    <xmx:aafrX73cpknh7r1y2Cqz_yJ3t6g6h1BdKBn3AW8qxZhImKF_ABcRZA>
    <xmx:aafrX9GO3eZMoKSGe6Zb2bWG9JZPDkAAMjhuT9RsGJu5JhEPi2NPNg>
    <xmx:aafrXxQ75mAQ63dwA5SkMM0yKPV1hp8-PWY_lf6MbMJ8DOnWSj10NA>
Received: from localhost (mobile-166-176-121-139.mycingular.net [166.176.121.139])
	by mail.messagingengine.com (Postfix) with ESMTPA id 07542240057
	for <bitbake-devel@lists.openembedded.org>; Tue, 29 Dec 2020 17:02:16 -0500 (EST)
Date: Tue, 29 Dec 2020 16:02:16 -0600
From: "Patrick Williams" <patrick@stwcx.xyz>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v3] fetch2/wget: include parameters in URL
Message-ID: <X+unaFkdA9kAEFza@heinlein>
References: <20201229151316.165171-1-patrick@stwcx.xyz>
 <20201229215746.69819-1-patrick@stwcx.xyz>
MIME-Version: 1.0
In-Reply-To: <20201229215746.69819-1-patrick@stwcx.xyz>
X-Groupsio-MsgNum: 11891
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RhvCx8hr7YYLJQ0X"
Content-Disposition: inline

--RhvCx8hr7YYLJQ0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2020 at 03:57:46PM -0600, Patrick Williams wrote:
> The wget fetcher currently silently drops all parameters and has
> been that way since it was originally introduced in fetch via 080eb8764.
> This prevents use in SOURCE_MIRROR_URL and SRC_URI which require
> additional parameters.
>=20
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> ---
>  lib/bb/fetch2/wget.py | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index e6d9f528..80baf04a 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -99,7 +99,14 @@ class Wget(FetchMethod):
>          if ud.user and ud.pswd:
>              fetchcmd +=3D " --user=3D%s --password=3D%s --auth-no-challe=
nge" % (ud.user, ud.pswd)
> =20
> -        uri =3D ud.url.split(";")[0]
> +        # Join the URL components together.
> +        urls =3D ud.url.split(";")
> +        if len(urls) =3D=3D 1:
> +            uri =3D urls[0]
> +        else:
> +            uri =3D urls[0] + "?" + "&".join(urls[1:])
> +            fetchcmd +=3D " -O '%s/%s'" % (d.getVar("DL_DIR"), urls[0].s=
plit("/")[-1])
> +

I've now tested this with a `bitbake <image> --runall=3Dfetch` for one of
my machine images and was successful.  The `-O` above feels a little
fragile but it is required for the uninative blob because that ends up
in a `uninative/<checksum>` subdirectory.

In uninative.bbclass there is:
            localdata.setVar('DL_DIR', tarballdir)

The `-P ${DL_DIR}` below seems to not take effect if `-O` is given.

>          if os.path.exists(ud.localpath):
>              # file exists, but we didnt complete it.. trying again..
>              fetchcmd +=3D d.expand(" -c -P ${DL_DIR} '%s'" % uri)
> --=20
> 2.26.2
>=20

--=20
Patrick Williams

--RhvCx8hr7YYLJQ0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAl/rp2YACgkQqwNHzC0A
wRkxLBAAhayjOg0VH5Hqi/hKnGLKkT/AQrPRamlURfnjA1/3nd+JES62eITmg67t
tekQTOM0pg8qxvjMy/xa4yNFqMguLO0U0tnjMyj8uGdt4udrRD/Zqml32q9hlJVA
GXoHaz4jp5PhfBnEE7pGmH/HlcNX8tjxh4m4/8q3idq/UBs0k7JueucRGo92YkfB
StyyHRvONqrnFTDHpe98hQw+PfP2D+nb0NVw7G5H3QZWK/cJJXZbIo7AL6AutMse
pP3FuV+tDJsfXn5/nSvbyaWUBTKKFSkQbQDIJZqlxZQVZHuhfZaYjg5EqNFJ8lQM
ibeWeVv1pAHKX1vhBizIIEhAzjff7yunRzfgQmjOkmePAXdtgcFVsKcvChWge8c0
qKAatKFQxjNtIK/2maiEHv92yzRPWU1oSz2jr//nNKrPLX3737lQfO0FuZJUL1JI
qWk9lwCEHIbmKwv/6Qqeuvd+sMX/Qg7xDKL5quxCVBQG0eO1cA6cLtyrs1CZ845e
dQuWbcdBXIXL6YmkmeY+G+7Vn+K9T2uIzNPYHWbojdI5IrLvwHWe7E7cwC5v3yaf
5o2RMSXGu3/9VyJwBXtd8u2BdMln+jKZ1ensUwowVfW14QmR2mRSlFa4CjYBy/zV
bL2/Nz39HY6QseOEINxXHm2VHYsf2iI6qfp8EzJOriOOsWDzqUc=
=0zNt
-----END PGP SIGNATURE-----

--RhvCx8hr7YYLJQ0X--
