Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
	by mail.openembedded.org (Postfix) with ESMTP id 54FE26E927
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 16 Feb 2014 22:41:44 +0000 (UTC)
Received: by mail-ee0-f45.google.com with SMTP id b15so6618633eek.18
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 16 Feb 2014 14:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=+OtlptgbIuiiPF+yN32X/g4azfRmfQY8a86BTQBth1g=;
	b=p/WRm2zs2z26mvjeKt+QT+OkKtwC/bRxxcyBYSbnja6+U9Yz4kp8NTS3hBGUvoe8Xh
	B6tA02C7t+jK+hzvmLEYgdYWflFfSQ6TR8zvpUInBbD2wIpmL0gehxB3MWNsU5rc8p1T
	ZQX0LlksKau2pFfXKQarMxs+KwwHW4pXOoLivRYI/fxetByTM4VQFnSYeU8NytaGiwhN
	Swjz9NOgY14b3Tsrr3YjctihATfP983WRFtRwDcWX0LU4CGUPGkPVsBRhvM/MfmL5C5m
	nYl3IlEfitknFRi/0Iem9FhQcxjk0+Y6GZTEc3w3CIcDrbKiY7T5E5/dMmitIu1I2aou
	7YXA==
X-Received: by 10.15.51.196 with SMTP id n44mr23742779eew.27.1392590504962;
	Sun, 16 Feb 2014 14:41:44 -0800 (PST)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	d9sm49818695eei.9.2014.02.16.14.41.43 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 16 Feb 2014 14:41:44 -0800 (PST)
Date: Sun, 16 Feb 2014 23:42:13 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20140216224213.GB4067@jama>
References: <1390319188-21978-1-git-send-email-Martin.Jansa@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1390319188-21978-1-git-send-email-Martin.Jansa@gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Subject: Re: [PATCH][1.20] fetch2: Don't allow '/' in user:pass, fix branch containing '@'
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
X-List-Received-Date: Sun, 16 Feb 2014 22:41:44 -0000
X-Groupsio-MsgNum: 4391
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline

--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2014 at 04:46:28PM +0100, Martin Jansa wrote:
> From: Martin Jansa <martin.jansa@gmail.com>

Ping

>=20
> * currently decode_url regexp parses branch=3D@foo as username so it ends=
 like this:
>   - ('git', '', 'foo', 'git.openembedded.org/bitbake;branch=3D', '', {})
>   + ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'=
})
> * http://hg.python.org/cpython/file/2.7/Lib/urlparse.py also assumes
>   that there is at least one '/' as separator between netloc and path,
>   params, so it looks reasonable to prevent including '/' in username
>=20
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/__init__.py | 2 +-
>  lib/bb/tests/fetch.py     | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 9499a91..8f195f2 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -329,7 +329,7 @@ def decodeurl(url):
>      user, password, parameters).
>      """
> =20
> -    m =3D re.compile('(?P<type>[^:]*)://((?P<user>.+)@)?(?P<location>[^;=
]+)(;(?P<parm>.*))?').match(url)
> +    m =3D re.compile('(?P<type>[^:]*)://((?P<user>[^/]+)@)?(?P<location>=
[^;]+)(;(?P<parm>.*))?').match(url)
>      if not m:
>          raise MalformedUrl(url)
> =20
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 4bcff54..e134a31 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -407,7 +407,8 @@ class URLHandle(unittest.TestCase):
>      datatable =3D {
>         "http://www.google.com/index.html" : ('http', 'www.google.com', '=
/index.html', '', '', {}),
>         "cvs://anoncvs@cvs.handhelds.org/cvs;module=3Dfamiliar/dist/ipkg"=
 : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '', {'module': 'familiar=
/dist/ipkg'}),
> -       "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=3DV0-99-81;mod=
ule=3Dfamiliar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs',=
 'anonymous', {'tag': 'V0-99-81', 'module': 'familiar/dist/ipkg'})
> +       "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=3DV0-99-81;mod=
ule=3Dfamiliar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs',=
 'anonymous', {'tag': 'V0-99-81', 'module': 'familiar/dist/ipkg'}),
> +       "git://git.openembedded.org/bitbake;branch=3D@foo" : ('git', 'git=
=2Eopenembedded.org', '/bitbake', '', '', {'branch': '@foo'})
>      }
> =20
>      def test_decodeurl(self):
> --=20
> 1.8.5.3
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlMBPsUACgkQN1Ujt2V2gBwseQCfbYprOaacf4ac4DFqjhZd3hFR
XQ8An2zGLsoRmcbdEdYEn2qsxRF/qr3J
=/FB1
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
