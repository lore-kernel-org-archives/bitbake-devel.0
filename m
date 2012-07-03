Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1Sm7cR-0003X0-37
	for bitbake-devel@lists.openembedded.org;
	Tue, 03 Jul 2012 20:14:35 +0200
Received: by weyr6 with SMTP id r6so1135410wey.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jul 2012 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=zpOI3QrWYeXCmcibBVaScW5Y1TRaJTkCSo6Eq9BDehM=;
	b=bDlj7524I4ZAbZehlI8QeZr4y7BK1BRlWs0FvXEj3q1+uml+yPP64SKSaF95z1roJO
	qD0SciX1v//LYjfplRt/JkbSgnipm6JTEyColXEAx1bWFMjRomq+u7bXUu+SaLkbOjYu
	/fdgnYrfzf+fW64lDazKAkynFA34yyJ2PPNzog2ZT1/NVQEG+jIOxzDEwU5kbfy0AMVh
	3iaj4p123CRsj0HCXPIBeuR3O+UvjXqEJgJmzMPVNtD4R1MFZel/1xeHNCzVmrEkPlbK
	BUBIvnwU5y5nKcLJ0USOPTQykXMB1uDQYdYxsUyB8XC4D5xlBj8999jgS8+rQUr4wjnZ
	XrzQ==
Received: by 10.181.13.142 with SMTP id ey14mr27056259wid.19.1341338613120;
	Tue, 03 Jul 2012 11:03:33 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id fo7sm32061225wib.9.2012.07.03.11.03.31
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 03 Jul 2012 11:03:32 -0700 (PDT)
Date: Tue, 3 Jul 2012 20:03:32 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120703180332.GG3771@jama.jama.net>
References: <1341260584.23146.265.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1341260584.23146.265.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/svn: Enhance to cope with subversion 1.7 upgrade
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
X-List-Received-Date: Tue, 03 Jul 2012 18:14:35 -0000
X-Groupsio-MsgNum: 2405
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline

--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2012 at 09:23:04PM +0100, Richard Purdie wrote:
> svn changed working checkout formats between 1.6 and 1.7. Its convoluted =
to
> detect what format a given working copy is in so the simplest solution is=
 simply
> to run "svn upgrade" within the working copy.
>=20
> The base svn command variable is relocated slightly to enable this new co=
de to
> work effectively.
>=20

Tested-by: Martin Jansa <Martin.Jansa@gmail.com>

but as described in [YOCTO #2409] I was using 1.7 on premirror as well
as builder so all my checkouts/tarballs were already in 1.7 format.

Cheers,

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
> index 59d7ccb..bc5b96b 100644
> --- a/bitbake/lib/bb/fetch2/svn.py
> +++ b/bitbake/lib/bb/fetch2/svn.py
> @@ -49,6 +49,8 @@ class Svn(FetchMethod):
>          if not "module" in ud.parm:
>              raise MissingParameterError('module', ud.url)
> =20
> +        ud.basecmd =3D d.getVar('FETCHCMD_svn', True)
> +
>          ud.module =3D ud.parm["module"]
> =20
>          # Create paths to svn checkouts
> @@ -69,8 +71,6 @@ class Svn(FetchMethod):
>          command is "fetch", "update", "info"
>          """
> =20
> -        basecmd =3D data.expand('${FETCHCMD_svn}', d)
> -
>          proto =3D ud.parm.get('proto', 'svn')
> =20
>          svn_rsh =3D None
> @@ -88,7 +88,7 @@ class Svn(FetchMethod):
>              options.append("--password %s" % ud.pswd)
> =20
>          if command =3D=3D "info":
> -            svncmd =3D "%s info %s %s://%s/%s/" % (basecmd, " ".join(opt=
ions), proto, svnroot, ud.module)
> +            svncmd =3D "%s info %s %s://%s/%s/" % (ud.basecmd, " ".join(=
options), proto, svnroot, ud.module)
>          else:
>              suffix =3D ""
>              if ud.revision:
> @@ -96,9 +96,9 @@ class Svn(FetchMethod):
>                  suffix =3D "@%s" % (ud.revision)
> =20
>              if command =3D=3D "fetch":
> -                svncmd =3D "%s co %s %s://%s/%s%s %s" % (basecmd, " ".jo=
in(options), proto, svnroot, ud.module, suffix, ud.module)
> +                svncmd =3D "%s co %s %s://%s/%s%s %s" % (ud.basecmd, " "=
=2Ejoin(options), proto, svnroot, ud.module, suffix, ud.module)
>              elif command =3D=3D "update":
> -                svncmd =3D "%s update %s" % (basecmd, " ".join(options))
> +                svncmd =3D "%s update %s" % (ud.basecmd, " ".join(option=
s))
>              else:
>                  raise FetchError("Invalid svn command %s" % command, ud.=
url)
> =20
> @@ -117,6 +117,11 @@ class Svn(FetchMethod):
>              logger.info("Update " + loc)
>              # update sources there
>              os.chdir(ud.moddir)
> +            # We need to attempt to run svn upgrade first in case its an=
 older working format
> +            try:
> +                runfetchcmd(ud.basecmd + " upgrade", d)
> +            except FetchError:
> +                pass
>              logger.debug(1, "Running %s", svnupdatecmd)
>              bb.fetch2.check_network_access(d, svnupdatecmd, ud.url)
>              runfetchcmd(svnupdatecmd, d)
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/zM/QACgkQN1Ujt2V2gBxybwCfcuouVeQtgZFR7btew6TCzQE/
gfEAoLTapsk6jvXrJiSeJs/CtkESbzpD
=vECb
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
