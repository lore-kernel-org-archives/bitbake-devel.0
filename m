Return-Path: <martin.jansa@gmail.com>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
	[209.85.217.169])
	by mail.openembedded.org (Postfix) with ESMTP id C34A265D34
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 11:03:00 +0000 (UTC)
Received: by mail-lb0-f169.google.com with SMTP id n15so47697lbi.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=jgYXb9VlmiLNOXPDTsgyGjdbyhA8aXKdDxkGzWZM/wI=;
	b=T98izMJrSDIzm6OmAIFY3cv3AFS/UPud+L5iUYYeTTAufGekTxevNUP2d+T5WUxIIE
	+Bcw/DsqNEDj6YUCrJWqk6TPN8mLY6Y7M6hQeNuhBE/pneOY6CHSFEgSCg1coh9TaZQl
	2NvZHZI7eqLoUPikdjUPpzJE02/t+4S3RSB4N2df4kBiCgLex7gKq9qartwIg24kKCBc
	96WJ0yYw1rIAvDRny5ILTAyX1UR+4Lj/DM3vtZCnwRa60eX1ML0I1AxR5FstB2ZND5zz
	sPEt+AFfNsxqA9rEAA0OQwROlCvPgXBIB/THzvNuR0SNABBvZVBFNI6bLGAxJqPCVwxP
	it0g==
X-Received: by 10.112.205.200 with SMTP id li8mr31472076lbc.70.1409137380121; 
	Wed, 27 Aug 2014 04:03:00 -0700 (PDT)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id i5sm70634lbd.27.2014.08.27.04.02.58
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 04:02:58 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Wed, 27 Aug 2014 13:03:07 +0200
To: Hongxu Jia <hongxu.jia@windriver.com>
Message-ID: <20140827110307.GC20524@jama>
References: <cover.1409136202.git.hongxu.jia@windriver.com>
MIME-Version: 1.0
In-Reply-To: <cover.1409136202.git.hongxu.jia@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH V2 0/1] bitbake: runqueue: terminate build safely while RunQueueExecuteScenequeue init failed
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
X-List-Received-Date: Wed, 27 Aug 2014 11:03:06 -0000
X-Groupsio-MsgNum: 5000
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hEk4XxIzAisM6naS"
Content-Disposition: inline

--hEk4XxIzAisM6naS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 06:44:40PM +0800, Hongxu Jia wrote:
> Changed in V2:=20
> - Strip the commit message within 80 characters a line
>=20
> //Hongxu
>=20
> The following changes since commit 52b788c6df9201764130ab744bf67b770b24b8=
96:
>=20
>   autogen-native: inherit pkgconfig to fix a build failure (2014-08-25 10=
:26:00 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.pokylinux.org/poky-contrib hongxu/bitbake
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Dhongxu/bitbake

It would be nice to have patches for bitbake repository on bitbake-devel
ML.

> Hongxu Jia (1):
>   bitbake: runqueue: terminate build safely while
>     RunQueueExecuteScenequeue init failed
>=20
>  bitbake/lib/bb/runqueue.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> --=20
> 1.9.1
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--hEk4XxIzAisM6naS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlP9uusACgkQN1Ujt2V2gBxw5gCfag2L+nj8tBCSfhzkmJ9DJFbz
NGUAoIXlFlMFt/jyypYyFz4JTnLC2zlp
=zhYe
-----END PGP SIGNATURE-----

--hEk4XxIzAisM6naS--
