Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f174.google.com (mail-ea0-f174.google.com
	[209.85.215.174])
	by mail.openembedded.org (Postfix) with ESMTP id 121216B237
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 08:34:33 +0000 (UTC)
Received: by mail-ea0-f174.google.com with SMTP id b10so41355eae.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Jan 2014 00:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=uG1NfMyOpUkG1Ej4+X0B8ysecZXfkRH9zGylx0lNrUA=;
	b=VPch31DQmnkjOoGc9d0T89MCykNZsTWjdFKXvlbzgHNlD07DoMORUEkTHWRvISU8Sf
	yZ/Hf3uC4S1H06vUONfnpJT+anh72WrCK8u7lJXPM33MWjtr1GM206AQItbiQ3trzK4y
	l7EY9gPX4l9+a8KNaMZCTYFpXGmi3P5aEpPoy0ZmTMoOpHNUSSLOLkxGb0koSVYVyGLs
	6vU/alwGy2EWMfJtTvWVDLKwmf9JluHxwyvjWZq/TwahQzpy1KjHUSux5E3GTUmzYICW
	IWgQxwZhK6nTwkBZzO8pTqpk3bymLUj1J421C7K5+LliMkaftfEYZH5YR1CBrWqMC84j
	pw0Q==
X-Received: by 10.14.6.5 with SMTP id 5mr38568081eem.51.1389083674734;
	Tue, 07 Jan 2014 00:34:34 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107]) by mx.google.com with ESMTPSA id
	j46sm177887930eew.18.2014.01.07.00.34.31 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 Jan 2014 00:34:31 -0800 (PST)
Date: Tue, 7 Jan 2014 09:34:40 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Zhenhua Luo <zhenhua.luo@freescale.com>
Message-ID: <20140107083440.GM3709@jama>
References: <1389064866-26141-1-git-send-email-zhenhua.luo@freescale.com>
MIME-Version: 1.0
In-Reply-To: <1389064866-26141-1-git-send-email-zhenhua.luo@freescale.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: b43082@freescale.com, b40290@freescale.com,
	bitbake-devel@lists.openembedded.org, b40527@freescale.com
Subject: Re: [PATCH] bitbake: fetch2/git: add nobranch option for SRC_URI to skip validating SHA
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
X-List-Received-Date: Tue, 07 Jan 2014 08:34:34 -0000
X-Groupsio-MsgNum: 4288
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Content-Disposition: inline

--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 11:21:06AM +0800, Zhenhua Luo wrote:
> For rebased git tree, some commits can be found in tag rather than branch=
, the change
> is useful for such case.
>=20
> Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
> ---
>  lib/bb/fetch2/git.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index b4b9368..6d74dbb 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -101,6 +101,8 @@ class Git(FetchMethod):
> =20
>          ud.rebaseable =3D ud.parm.get("rebaseable","0") =3D=3D "1"
> =20
> +        ud.nobranch =3D ud.parm.get("nobranch","0") =3D=3D "1"
> +
>          # bareclone implies nocheckout
>          ud.bareclone =3D ud.parm.get("bareclone","0") =3D=3D "1"
>          if ud.bareclone:
> @@ -217,7 +219,7 @@ class Git(FetchMethod):
>              ud.repochanged =3D True
>          os.chdir(ud.clonedir)
>          for name in ud.names:
> -            if not self._contains_ref(ud, d, name):
> +            if not ud.nobranch and not self._contains_ref(ud, d, name):

I think that even with nobranch param set you need to check that SHA-1
is included, you just don't care in which branch if it's even included
in any.

Something like
  def _contains_ref(self, tag, branch, d):
was doing before 89abfbc1953e3711d6c90aff793ee622c22609b1, so the
conditional should be in _contains_ref not skipping it completely.

>                  raise bb.fetch2.FetchError("Unable to find revision %s i=
n branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
> =20
>      def build_mirror_data(self, ud, d):
> --=20
> 1.8.4.2
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLLvCAACgkQN1Ujt2V2gBwhrQCfST2QluuMZL6Gd2I6c6t3yCxn
eOsAoIM914WHfbUKbrBM2ZQtwXa+RKpX
=mjPy
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
