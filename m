Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f175.google.com (mail-ea0-f175.google.com
	[209.85.215.175])
	by mail.openembedded.org (Postfix) with ESMTP id 5AB1660B60
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 23:27:29 +0000 (UTC)
Received: by mail-ea0-f175.google.com with SMTP id z10so7187729ead.20
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 15:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=fKDaIsjJ8OCN4eIKsOasfEcaDfunwrr8+LImo9/R84k=;
	b=rQ/oxhJmlrbuGz0EWWRJVJCGra6UI3dWfR+ApZcxfCWGpbhJMABYwilRamxMFLucCY
	pFf9iQPgboMZtqoAY5Za861dmm/XfcuGsNOHitjZdAKpCg8XxHqOhYfl6e3ozh6RiDz0
	AzvqgvALWUIdPLxj+gpBivtSphMEnmmz5hu/r4hnc6RwHk+DPMU0mOr+ajD6Gd6n0svP
	RmyMHCY6NPpX0CrQfc0mLedW081CxIfcDpf/ulyT3Ji9JgRm8q354yzMcA7JtcMfZvnX
	i6wk/OYTAuCnXBTvpofzHMeMHmDYMX6DL/N0V0XF+zcJy2gzpYAundgZ1ISGLcY087sw
	Lc+A==
X-Received: by 10.14.87.2 with SMTP id x2mr3785044eee.79.1385767648336;
	Fri, 29 Nov 2013 15:27:28 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id o1sm1882531eea.10.2013.11.29.15.27.27
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 29 Nov 2013 15:27:27 -0800 (PST)
Date: Sat, 30 Nov 2013 00:27:30 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20131129232730.GD2860@jama>
References: <1385766956.11222.80.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1385766956.11222.80.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] parse/ConfHander/BBHandler/utils: Fix cache dependency bugs
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 29 Nov 2013 23:27:29 -0000
X-Groupsio-MsgNum: 4164
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2013 at 11:15:56PM +0000, Richard Purdie wrote:
>=20
> Currently bitbake only adds files to its dependency list if they exist.
> If you add 'include foo.inc' to your recipe and the file doesn't exist,
> then later you add the file, the cache will not be invalidated.
>=20
> This leads to another bug which is that if files don't exist and then
> you add them and they should be found first due to BBPATH, again the
> cache won't invalidate.
>=20
> This patch adds in tracking of files we check for the existence of so
> that if they are added later, the cache correctly invalidates. This
> necessitated a new version of bb.utils.which which returns a list of
> files tested for.
>=20
> The patch also adds in checks for duplicate file includes and for now
> prints a warning about this. That will likely become a fatal error at
> some point since its never usually desired to include a file twice.
>=20
> The same issue is also fixed for class inheritance. Now when a class=20
> is added which would be found in the usual search path, it will cause
> the cache to be invalidated.
>=20
> Unfortunately this is old code in bitbake and the patch isn't the
> neatest since we have to work within that framework.

Does it depend on any other patches? Even after removing extra bitbake/
prefix (I guess the patch is for poky not bitbake repo) it doesn't apply
in current master:

error: patch failed: lib/bb/parse/parse_py/ConfHandler.py:82
error: lib/bb/parse/parse_py/ConfHandler.py: patch does not apply
Patch failed at 0001 parse/ConfHander/BBHandler/utils: Fix cache
dependency bugs
The copy of the patch that failed is found in:
   /OE/bitbake/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.


>=20
> [YOCTO #5611]
> [YOCTO #4425]
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__in=
it__.py
> index c973f6f..97983c9 100644
> --- a/bitbake/lib/bb/parse/__init__.py
> +++ b/bitbake/lib/bb/parse/__init__.py
> @@ -73,9 +73,17 @@ def update_mtime(f):
>  def mark_dependency(d, f):
>      if f.startswith('./'):
>          f =3D "%s/%s" % (os.getcwd(), f[2:])
> -    deps =3D (d.getVar('__depends') or []) + [(f, cached_mtime(f))]
> -    d.setVar('__depends', deps)
> -
> +    deps =3D (d.getVar('__depends') or [])
> +    s =3D (f, cached_mtime_noerror(f))
> +    if s not in deps:
> +        deps.append(s)
> +        d.setVar('__depends', deps)
> +
> +def check_dependency(d, f):
> +    s =3D (f, cached_mtime_noerror(f))
> +    deps =3D (d.getVar('__depends') or [])
> +    return s in deps
> +  =20
>  def supports(fn, data):
>      """Returns true if we have a handler for this file, false otherwise"=
""
>      for h in handlers:
> @@ -102,11 +110,14 @@ def init_parser(d):
>  def resolve_file(fn, d):
>      if not os.path.isabs(fn):
>          bbpath =3D d.getVar("BBPATH", True)
> -        newfn =3D bb.utils.which(bbpath, fn)
> +        newfn, attempts =3D bb.utils.which(bbpath, fn, history=3DTrue)
> +        for af in attempts:
> +            mark_dependency(d, af)
>          if not newfn:
>              raise IOError("file %s not found in %s" % (fn, bbpath))
>          fn =3D newfn
> =20
> +    mark_dependency(d, fn)
>      if not os.path.isfile(fn):
>          raise IOError("file %s not found" % fn)
> =20
> diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/=
parse/parse_py/BBHandler.py
> index 01f22d3..7cba649 100644
> --- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
> +++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
> @@ -77,7 +77,10 @@ def inherit(files, fn, lineno, d):
>          if not os.path.isabs(file):
>              dname =3D os.path.dirname(fn)
>              bbpath =3D "%s:%s" % (dname, d.getVar("BBPATH", True))
> -            abs_fn =3D bb.utils.which(bbpath, file)
> +            abs_fn, attempts =3D bb.utils.which(bbpath, file, history=3D=
True)
> +            for af in attempts:
> +                if af !=3D abs_fn:
> +                    bb.parse.mark_dependency(d, af)
>              if abs_fn:
>                  file =3D abs_fn
> =20
> diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/b=
b/parse/parse_py/ConfHandler.py
> index c28f18b..f4fb2aa 100644
> --- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> @@ -82,12 +82,15 @@ def include(oldfn, fn, lineno, data, error_out):
>      if not os.path.isabs(fn):
>          dname =3D os.path.dirname(oldfn)
>          bbpath =3D "%s:%s" % (dname, data.getVar("BBPATH", True))
> -        abs_fn =3D bb.utils.which(bbpath, fn)
> +        abs_fn, attempts =3D bb.utils.which(bbpath, fn, history=3DTrue)
> +        if abs_fn and bb.parse.check_dependency(data, abs_fn):
> +            bb.warn("Duplicate inclusion for %s in %s" % (abs_fn, data.g=
etVar('FILE', True)))
> +        for af in attempts:
> +            bb.parse.mark_dependency(data, af)
>          if abs_fn:
>              fn =3D abs_fn
> -
> -    if fn in (data.getVar("__depends", False) or ""):
> -        bb.warn("Duplicate inclusion for %s" % fn)
> +    elif bb.parse.check_dependency(data, fn):
> +        bb.warn("Duplicate inclusion for %s in %s" % (fn, data.getVar('F=
ILE', True)))
> =20
>      from bb.parse import handle
>      try:
> @@ -96,6 +99,7 @@ def include(oldfn, fn, lineno, data, error_out):
>          if error_out:
>              raise ParseError("Could not %(error_out)s file %(fn)s" % var=
s(), oldfn, lineno)
>          logger.debug(2, "CONF file '%s' not found", fn)
> +        bb.parse.mark_dependency(data, fn)
> =20
>  # We have an issue where a UI might want to enforce particular settings =
such as
>  # an empty DISTRO variable. If configuration files do something like ass=
igning
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 560f55a..0be45e1 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -796,22 +796,28 @@ def copyfile(src, dest, newmtime =3D None, sstat =
=3D None):
>          newmtime =3D sstat[stat.ST_MTIME]
>      return newmtime
> =20
> -def which(path, item, direction =3D 0):
> +def which(path, item, direction =3D 0, history =3D False):
>      """
>      Locate a file in a PATH
>      """
> =20
> +    hist =3D []
>      paths =3D (path or "").split(':')
>      if direction !=3D 0:
>          paths.reverse()
> =20
>      for p in paths:
>          next =3D os.path.join(p, item)
> +        hist.append(next)
>          if os.path.exists(next):
>              if not os.path.isabs(next):
>                  next =3D os.path.abspath(next)
> +            if history:
> +                return next, hist
>              return next
> =20
> +    if history:
> +        return "", hist
>      return ""
> =20
>  def to_boolean(string, default=3DNone):
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlKZIuIACgkQN1Ujt2V2gBwXdgCgrjU19PibkU6HJtrzoUcyUFe6
ZP8An3BV6c6vvwJSCNnd3kBhcKNz9yG4
=EBZ7
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
