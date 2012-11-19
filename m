Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TaTCG-0004qz-Jc
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Nov 2012 16:23:40 +0100
Received: by mail-ee0-f47.google.com with SMTP id l10so2780089eei.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Nov 2012 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=EtWFloR38QKZf6TYjkg0LoeVMrdrxjL3IMCIGUD7eYo=;
	b=dZwHEFUZeDkLkvY1M4cC4o3y6QZUbpGyR3eqakZ+tXn3ZWZZog33+vxBVjWPBvjdvp
	Evo7TTzIylya0IQzG0Zl+mbGwAJej02FWogEZKyDkF+xzBwNjZ9wtMa9wsGmZOvFzrJA
	Mu//k+A3mYC76fxbTuORpln52K2Ii5vvOE4udzDti7IaHxreEYLrYwqEcJUYK7kUa5aW
	mnSnF6D6/bOqSWvRpwmbnZVg3okBpFG+23WXMUnJtApp0bvuwEE8oGsnYtJC8BDuTwVr
	Qsap3EWXTqk4BWMHLHCMMxeMGyA7a0X/9G28pBay5+h1VtDdSPePuIB6R4TpNEtqS3On
	Dvmw==
Received: by 10.14.221.8 with SMTP id q8mr24828411eep.28.1353337778185;
	Mon, 19 Nov 2012 07:09:38 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id f2sm24636513eep.2.2012.11.19.07.09.36
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 19 Nov 2012 07:09:37 -0800 (PST)
Date: Mon, 19 Nov 2012 16:09:31 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20121119150931.GA3341@jama.jama.net>
References: <1353337280.3709.167.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1353337280.3709.167.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] parse/cache/cooker: Preserve order in the file inclusion list
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
X-List-Received-Date: Mon, 19 Nov 2012 15:23:40 -0000
X-Groupsio-MsgNum: 2942
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 03:01:20PM +0000, Richard Purdie wrote:
> The data returned by get_file_depends() may me used in contexts like
> checksums where order is important. The current usage of sets means
> that some of the checksums can change in circumstances they should not.
>=20
> This patch changes to use lists, thereby removing the problem.

Should this cover also BBINCLUDED variable in parsing cache?

Sometimes I see all recipes reparsed without any reason (no change in
metadata).

Comparing output of bitbake -p (with added patch to dump parse data,
shows order of BBINCLUDED changing.

e.g. from yesterday:
OE om-gta02@shr ~/shr-core $ diff 20121118.BBINCLUDED 20121119.BBINCLUDED
12c12
< /OE/shr-core/openembedded-core/meta/conf/machine/include/tune-arm920t.inc
---
> /OE/shr-core/openembedded-core/meta/classes/mirrors.bbclass
45a46
> /OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
51c52
< /OE/shr-core/openembedded-core/meta/classes/mirrors.bbclass
---
> /OE/shr-core/openembedded-core/meta/conf/machine/include/tune-arm920t.inc
54d54
< /OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
60d59
< /OE/shr-core/openembedded-core/meta/conf/distro/include/tcmode-default.inc
62a62
> /OE/shr-core/openembedded-core/meta/conf/distro/include/tcmode-default.inc

Cheers,

>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
> index 619b9ee..a3c073a 100644
> --- a/bitbake/lib/bb/cache.py
> +++ b/bitbake/lib/bb/cache.py
> @@ -405,12 +405,12 @@ class Cache(object):
>          """Parse the specified filename, returning the recipe informatio=
n"""
>          infos =3D []
>          datastores =3D cls.load_bbfile(filename, appends, configdata)
> -        depends =3D set()
> +        depends =3D []
>          for variant, data in sorted(datastores.iteritems(),
>                                      key=3Dlambda i: i[0],
>                                      reverse=3DTrue):
>              virtualfn =3D cls.realfn2virtual(filename, variant)
> -            depends |=3D (data.getVar("__depends", False) or set())
> +            depends =3D depends + (data.getVar("__depends", False) or [])
>              if depends and not variant:
>                  data.setVar("__depends", depends)
> =20
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index e299059..98d6957 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -692,8 +692,8 @@ class BBCooker:
>          # Generate a list of parsed configuration files by searching the=
 files
>          # listed in the __depends and __base_depends variables with a .c=
onf suffix.
>          conffiles =3D []
> -        dep_files =3D self.configuration.data.getVar('__depends') or set=
()
> -        dep_files.union(self.configuration.data.getVar('__base_depends')=
 or set())
> +        dep_files =3D self.configuration.data.getVar('__base_depends') o=
r []
> +        dep_files =3D dep_files + (self.configuration.data.getVar('__dep=
ends') or [])
> =20
>          for f in dep_files:
>              if f[0].endswith(".conf"):
> diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__in=
it__.py
> index 7b9c47e..4293d09c 100644
> --- a/bitbake/lib/bb/parse/__init__.py
> +++ b/bitbake/lib/bb/parse/__init__.py
> @@ -73,8 +73,7 @@ def update_mtime(f):
>  def mark_dependency(d, f):
>      if f.startswith('./'):
>          f =3D "%s/%s" % (os.getcwd(), f[2:])
> -    deps =3D d.getVar('__depends') or set()
> -    deps.update([(f, cached_mtime(f))])
> +    deps =3D (d.getVar('__depends') or []) + [(f, cached_mtime(f))]
>      d.setVar('__depends', deps)
> =20
>  def supports(fn, data):
> @@ -134,8 +133,8 @@ def vars_from_file(mypkg, d):
>  def get_file_depends(d):
>      '''Return the dependent files'''
>      dep_files =3D []
> -    depends =3D d.getVar('__depends', True) or set()
> -    depends =3D depends.union(d.getVar('__base_depends', True) or set())
> +    depends =3D d.getVar('__base_depends', True) or []
> +    depends =3D depends + (d.getVar('__depends', True) or [])
>      for (fn, _) in depends:
>          dep_files.append(os.path.abspath(fn))
>      return " ".join(dep_files)
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCqS6sACgkQN1Ujt2V2gByyvACfZlfpBlyiDV43MzvafT+VIkYa
Ln4AmwWRoVEV89PDy6EomdAU4eYCNfmm
=d3je
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
