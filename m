Return-Path: <martin.jansa@gmail.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 171F465DEB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Aug 2014 10:15:19 +0000 (UTC)
Received: by mail-wg0-f48.google.com with SMTP id x13so6138350wgg.19
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Aug 2014 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=efsgPn/qUxBCbwupxMNh4Ww+09Fnyrnrls6IsPu9sfM=;
	b=jE6jvmbgrRIcxjK/iMeKutJGJDoGZKNePZF5MMhE7dhbGoiSF4/GjvZoJxa4HgXGpP
	RlRqw1b3myruDBqJvRaYnRm5kJqslX4c0/xyraEwWR85C/x6eOvhKg4yMnyAR/gzRLp+
	Brkm2p69yyDGzk45m+y0ZzpJ8Lofz+S/A2V9EwIUGMGKjyLFQ8xJUirObCT70PmUtCKs
	KwzDAAkOdkRerVvEVKWFePLpisSiuG+WJR6nak5zT6RScO3Xt4ytrybOfGrT3voJTmZ6
	6uc06ZPPAa5IpmMk4i/sbQVCHHurU7v4acQX18QC+LIP5NexjYBnoW/cgA1wvI5oLid7
	U7kQ==
X-Received: by 10.195.12.103 with SMTP id ep7mr9907006wjd.121.1408443320904;
	Tue, 19 Aug 2014 03:15:20 -0700 (PDT)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	gi5sm49268156wjd.33.2014.08.19.03.15.19 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Aug 2014 03:15:19 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 19 Aug 2014 12:15:21 +0200
To: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <20140819101521.GP3660@jama>
References: <cover.1408439224.git.liezhi.yang@windriver.com>
	<d2f547297c3e0004e4fc64457cd36f7899db60d5.1408439224.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
In-Reply-To: <d2f547297c3e0004e4fc64457cd36f7899db60d5.1408439224.git.liezhi.yang@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] fetch2/__init__.py: remove broken sysmlink
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
X-List-Received-Date: Tue, 19 Aug 2014 10:15:26 -0000
X-Groupsio-MsgNum: 4976
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4dIe/AmYstFUGHTF"
Content-Disposition: inline

--4dIe/AmYstFUGHTF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 02:07:41AM -0700, Robert Yang wrote:
> Fixed:
> (Simulate mirror the tarball from PREMIRRORS)
> $ ln -sf /path/to/local/PREMIRROR/bzip2 bzip2-1.0.6.tar.gz
> (Simulate the PREMIRRORS are gone)
> $ rm -f /path/to/local/PREMIRROR/bzip2-1.0.6.tar.gz
> $ bitbake bzip2 -ccleansstate && bitbake bzip2 -cfetch

Why does it need to re-fetch it when you haven't don't cleanall?

If it has different checksums, then fetcher should rename it, before
re-downloading it.

Shouldn't fetcher just use bzip2-1.0.6.tar.gz if there is
bzip2-1.0.6.tar.gz.done?

I'm not saying that your change isn't correct, but maybe it uncovers
worse issue with fetcher redownloading unnecessary.

> Then the newly get bzip2-1.0.6.tar.gz will be saved to
> /path/to/local/PREMIRROR/bzip2-1.0.6.tar.gz rather than then the DL_DIR,
> or get error if we don't have the write permission on to the mirror.
> This is because wget uses "lstat()" to follow the symlink for FTP (but
> fstat() for HTTP, so http doesn't have this issue), and we can't fix
> wget (this might be intended by wget) since it is one of
> SANITY_REQUIRED_UTILITIES.
>=20
> Remove the broken sysmlink in DL_DIR will fix the problem.

type symlink

>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
> index df2f2b0..c95f177 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1081,6 +1081,11 @@ class FetchData(object):
>          self.donestamp =3D basepath + '.done'
>          self.lockfile =3D basepath + '.lock'
> =20
> +        # Remove the broken sysmlink

typo "symlink"

> +        if self.localpath and not os.path.exists(self.localpath) and \
> +                os.path.islink(self.localpath):
> +            os.unlink(self.localpath)
> +
>      def setup_revisons(self, d):
>          self.revisions =3D {}
>          for name in self.names:
> --=20
> 1.7.9.5
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--4dIe/AmYstFUGHTF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlPzI7kACgkQN1Ujt2V2gByCgACgubg41+kdS81p61DH9UlPqVDv
LK4AoIUjmL1CsnBHm62GMh6CoHKnizE8
=kPaZ
-----END PGP SIGNATURE-----

--4dIe/AmYstFUGHTF--
