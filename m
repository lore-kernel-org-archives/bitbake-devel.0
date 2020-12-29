Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web08.17968.1609275928268544215
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Dec 2020 13:05:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stwcx.xyz header.s=fm3 header.b=OyUCjgAw;
 spf=pass (domain: stwcx.xyz, ip: 66.111.4.27, mailfrom: patrick@stwcx.xyz)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8D6155C0154
	for <bitbake-devel@lists.openembedded.org>; Tue, 29 Dec 2020 16:05:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 29 Dec 2020 16:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
	date:from:to:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=fm3; bh=QgDX5NMiWq4XGRRQaAdm4XW7n3X
	Wq2V/6Dk1HY/2sQs=; b=OyUCjgAwbkP3XPTBvliC1ph5aBnGb1fEktHDIROdErw
	fkG0Za4Nq/1jOvpIg9yrZ4YUIxJZwPX4j6xbpqyJ9NYl9necMNYwRNh/y2ApT8tY
	LNI8nJ2B6oST7HxnGTLapwplSjUf1f573DsbxqGROTeFeScSuWI9FkP3KhkAMWMV
	bQBS+dXPOKkkUfA7Ig1iBw/070DfK5/fGkcZMR1LIlzFM0U8DF40u3Hfn2HwHL3A
	knRDuO1ixPP9FtoolDpekZYUURAZc4Ov+Zm08PX94H1NltWVY+dR5+Nb2780Dv/p
	10cAFsRc4TmYiN/fijlmRn9F/W9+IY+RIqY/nRokcVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QgDX5N
	MiWq4XGRRQaAdm4XW7n3XWq2V/6Dk1HY/2sQs=; b=EMP7Ci6uyQKh5pZNZrdJJo
	uUc1TY5CBf3GUPSPsTPg5cN70oHO8uMwsnedgGEtK88FxyKRAlbV6dGDgrkfpwGR
	p/JO2Ib9AckUDIRvl9PTDdc7mWW9hQf1P++SlMElLAN17aPCjgTj5Rzi7dbLcHca
	8spd27Qgiq9DdSt+q8NCreSqQINX3GyuimVdtnqigRg5e+q3NnlimK3XBN2LL2uZ
	KpH+HuvfUAXYi5rOtfBJxKPKH3X+OjvHZq2gXiPpYszzZu8UMSkNzGYbuUYdc9wx
	q7KfnO5urI/t7k8wpcAkV3lNPMVaeASB+SAtPVbDhR+GXBg9HBf9wWpfmISB+JFA
	==
X-ME-Sender: <xms:F5rrX9qDxTl2BDdg-3KRalrufBdTDiO6BfvqlFWl8TLR2ftBdkY05Q>
    <xme:F5rrX_obfe6Qtq3NmJnh6n33d6u1DtT4pJNtH4XLAIe1xA8VjN75uX93K4QfxXY89
    qwaPOk3L6fyGYco-Qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvuddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepff
    fhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucghihhl
    lhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrh
    hnpeegheehfeffgeekveehtdfhgfduhfegfefgtdehhfektdelffevkefgueffhedtieen
    ucfkphepudeiiedrudejiedruddvuddrudefleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:F5rrX6PdP4D8eSU_zse_hqNwEs8y6dhW2MPUukWa0rTFzN8tIPCBtg>
    <xmx:F5rrX448ee02HMI6j8rEHn4ghEp8WoVO6VT1pf-AmcED599Zs4bfjg>
    <xmx:F5rrX84gMjxkCD1SljsEBalah7sL-SVN0coJ9ybPvF6PTSu3s11_7A>
    <xmx:F5rrX-HPLCCTM9mAhiRVwV5eReFb38BwScU6PmKTEhsPRcH14pqCLA>
Received: from localhost (mobile-166-176-121-139.mycingular.net [166.176.121.139])
	by mail.messagingengine.com (Postfix) with ESMTPA id E75E824005B
	for <bitbake-devel@lists.openembedded.org>; Tue, 29 Dec 2020 16:05:26 -0500 (EST)
Date: Tue, 29 Dec 2020 15:05:25 -0600
From: "Patrick Williams" <patrick@stwcx.xyz>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/wget: include paramters in URL
Message-ID: <X+uaFU9gEOZPW6xD@heinlein>
References: <20201229151316.165171-1-patrick@stwcx.xyz>
MIME-Version: 1.0
In-Reply-To: <20201229151316.165171-1-patrick@stwcx.xyz>
X-Groupsio-MsgNum: 11888
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SJzH+skW8RB5/Pdc"
Content-Disposition: inline

--SJzH+skW8RB5/Pdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2020 at 09:13:16AM -0600, Patrick Williams wrote:
> The wget fetcher currently silently drops all parameters and has
> been that way since it was originally introduced in fetch via 080eb8764.
> This prevents use in SOURCE_MIRROR_URL and SRC_URI which require
> additional parameters.
>=20
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> ---
>  lib/bb/fetch2/wget.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index e6d9f528..d41d7408 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -99,7 +99,13 @@ class Wget(FetchMethod):
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
> +
>          if os.path.exists(ud.localpath):
>              # file exists, but we didnt complete it.. trying again..
>              fetchcmd +=3D d.expand(" -c -P ${DL_DIR} '%s'" % uri)
> --=20
> 2.26.2
>=20

This causes some problems that I need to work out more.  In my downloads
directory I ended up with files like:

    'libxml2-2.9.10.tar.gz?name=3Dlibtar'
    'libxml2-2.9.10.tar.gz?name=3Dlibtar.1'

--=20
Patrick Williams

--SJzH+skW8RB5/Pdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAl/rmhMACgkQqwNHzC0A
wRk0aQ/+OpZgocF5jL5G2D6vUrp4+2vXT4z4m4iHnvVH3RM3XlNna5bY3mWRfawz
jC46ExtzDtruGHRv1kiDbSxeBhXgmgyPMm+/C1vkF68YVXqpdwqt9+M7o93Gl6s6
0jF4JxMdDBmWrdFvpV50ufse7H4WP/m9ZIwQnOII2sXxFczTMaru2xUjNo4DmEfZ
eOvvZc/ZdEZ5Q+Lp/RKVBE6DHfv9ltN08XbxzN4qPjYRFCCu9AFtS2u33+oFVyta
q8gFDshfM+4cUTWYl+e+0r1CUViZryi70FzvaGrEVyWDO9cNQ4dxC3JYMjPM84H3
EGnU8wc04CjLp0CaCbXZ0NK+CaozUoDOGVGyJz6boB6V/abzcD36+MVE68d3DCqu
CDk/8Q3IK3ub2zWXffGwmXVanY1IbLRnykOsegkikzghzlQaOG8EWjh42zHDmM0i
l43fZcN/FE5nXCOhyUeTvlWVPFsbeaq9MDa8KYdl0BYWo5MzHAGcTjqT5tWDRIOX
+rA0cWVv1QgWz4jgbD5AXSSiJ1Ad7hL0pK070NZkWHgIiCpAuFPCMhNnZmbcGCuR
K0NP/7DF1+qrhfthnjPXdpO82/Im8YJWPl+gknKBDnuD1VSS2AhtwkvP6KS7AGQv
PipOgQ+6eFMIIPuukGNQAoqI0ZFZkFhg9bgKFubduxmAx/K6EAE=
=nxSx
-----END PGP SIGNATURE-----

--SJzH+skW8RB5/Pdc--
