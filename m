Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1S1lkC-0003TF-Ee; Sun, 26 Feb 2012 22:35:00 +0100
Received: by eaae1 with SMTP id e1so326804eaa.6
	for <multiple recipients>; Sun, 26 Feb 2012 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=UUmoAJRnJ7NRywQe9oSeKgjEnbIbUdn2waV685eCLKA=;
	b=VgX1n6NNBtSKP08VZkWBUrOxKd5n/ggRLS9AoRX3O9l2LOcGwyHkBWNjsntXYUWqGk
	pB0nPeAp/nr6/G9SJAYHS8g9Vpx0gdw898+mLDF0CUakNZjgdVVgF4hpN+KjxpQBkojW
	mck6R08Gv4UPQA+TR+Nx20gdwmLtH9bzW8kAY=
Received: by 10.14.202.130 with SMTP id d2mr4761819eeo.83.1330291594860;
	Sun, 26 Feb 2012 13:26:34 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id r5sm37350162eef.6.2012.02.26.13.26.33
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 26 Feb 2012 13:26:33 -0800 (PST)
Date: Sun, 26 Feb 2012 22:26:31 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120226212631.GA3859@jama.jama.net>
References: <1330261465.31855.4.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1330261465.31855.4.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [PATCH] bitbake/ConfHandler: Be more strict about variable quoting
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 26 Feb 2012 21:35:00 -0000
X-Groupsio-MsgNum: 1059
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2012 at 01:04:25PM +0000, Richard Purdie wrote:
> [cross posted to OE-Core since this is a major change in behaviour but
> in my opinion, probably a good one]

Agreed, missing quotes are hard to notice and easy to fix in existing
recipes with resonable error message provided by this.
=20
> Currently, bitbake will accept variables in the forms:
>=20
> X =3D 1
> X =3D '1 \
>=20
> X =3D "1"
> X =3D '1'
>=20
> which will all set X=3D1. This patch removes the first two possibilities
> and makes quoting mandatory. There is little metadata out there which
> doesn't quote properly and bitbake will exit with an error about the
> exact line number and file with any problem so users can easily identify
> and fix issues. OE-Core has already been checked/fixed.

Not completly true about OE-Core, but I'll send another patch fixing the
rest and also meta-oe and meta-smartphone layers..

Cheers,

> The motivation for this is being able to give sane errors if a user
> does something like:
>=20
> IMAGE_INSTALL +=3D # tslib mtd-utils"
>=20
> which currently gives a really nasty failure.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/b=
b/parse/parse_py/ConfHandler.py
> index 9242632..64b8208 100644
> --- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> @@ -29,8 +29,7 @@ import logging
>  import bb.utils
>  from bb.parse import ParseError, resolve_file, ast, logger
> =20
> -#__config_regexp__  =3D re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z=
0-9\-_+.${}]+)\s*(?P<colon>:)?(?P<ques>\?)?=3D\s*(?P<apo>['\"]?)(?P<value>.=
*)(?P=3Dapo)$")
> -__config_regexp__  =3D re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0=
-9\-_+.${}/]+)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=3D)|(?P<laz=
yques>\?\?=3D)|(?P<ques>\?=3D)|(?P<append>\+=3D)|(?P<prepend>=3D\+)|(?P<pre=
dot>=3D\.)|(?P<postdot>\.=3D)|=3D)\s*(?P<apo>['\"]?)(?P<value>.*)(?P=3Dapo)=
$")
> +__config_regexp__  =3D re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0=
-9\-_+.${}/]+)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=3D)|(?P<laz=
yques>\?\?=3D)|(?P<ques>\?=3D)|(?P<append>\+=3D)|(?P<prepend>=3D\+)|(?P<pre=
dot>=3D\.)|(?P<postdot>\.=3D)|=3D)\s*(?P<apo>['\"])(?P<value>.*)(?P=3Dapo)$=
")
>  __include_regexp__ =3D re.compile( r"include\s+(.+)" )
>  __require_regexp__ =3D re.compile( r"require\s+(.+)" )
>  __export_regexp__ =3D re.compile( r"export\s+(.+)" )
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9Ko4cACgkQN1Ujt2V2gBw+FQCfbgq24l1UFt6iLcKGndeTftK+
n6IAoJj89s4pCYbJjl5E4oA+B7KbIGcY
=e+AI
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
