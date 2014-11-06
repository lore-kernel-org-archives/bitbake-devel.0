Return-Path: <martin.jansa@gmail.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 4307971FDB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Nov 2014 13:58:07 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id bs8so1560470wib.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Nov 2014 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=JEmzO/Lrq4gPr3dhzdyWZkXnX4OIfRTZpYzVlC8RLDI=;
	b=wdlBAcNsYjGfuTUL/Pdz7xYX2PgLWa0HbotF+ZFVov/YskiCR0qSVyBYKsL8OeKVsr
	nQby+4mrPc8XnN6r7/xs/9h5GCeahgBXOxcLmHM8MZffCaqkeRJwnOaRnIdtHGx2tiDe
	4BLglEjCXpIzkUBn1rOSMiTc2q1PNJw5CX7JyjgtKKCeFB3Khg8k90Grddq9YUd3/4c/
	6zAgxGKqfBaO8r10rBZGNfQRR2H60CpowxJtQmRTmJwcO8hBcZ70BQ2w1aoDauw44VMU
	9+SRVJds85CCjOdVlaYN1juEAfrTy7IStJ4oaWK0COZGMHCfMDtpX+hD8MNUkjFIJsf+
	BuGw==
X-Received: by 10.180.85.6 with SMTP id d6mr41724083wiz.82.1415282287774;
	Thu, 06 Nov 2014 05:58:07 -0800 (PST)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	cx9sm7921116wjc.25.2014.11.06.05.58.06 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Nov 2014 05:58:06 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Thu, 6 Nov 2014 14:58:11 +0100
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20141106135811.GA2455@jama>
References: <1415206693.23396.56.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1415206693.23396.56.camel@ted>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] prserv: Use WAL mode
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
X-List-Received-Date: Thu, 06 Nov 2014 13:58:08 -0000
X-Groupsio-MsgNum: 5120
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2014 at 04:58:13PM +0000, Richard Purdie wrote:
> Ideally, we want the PR service to have minimal influence from=20
> queued disk IO. sqlite tends to be paranoid about data loss and=20
> locks/fsync calls. There is a "WAL mode" which changes the journalling
> mechanism and would appear much better suited to our use case.
>=20
> This patch therefore switches the database to what WAL mode. With this

                                                ^ what =3D that?

> change, write overhead appears significantly reduced.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
> index 3bdc046..9d6d115 100644
> --- a/bitbake/lib/prserv/db.py
> +++ b/bitbake/lib/prserv/db.py
> @@ -235,6 +235,7 @@ class PRData(object):
>          self.connection=3Dsqlite3.connect(self.filename, isolation_level=
=3D"EXCLUSIVE", check_same_thread =3D False)
>          self.connection.row_factory=3Dsqlite3.Row
>          self.connection.execute("pragma synchronous =3D off;")
> +        self.connection.execute("PRAGMA journal_mode =3D WAL;")
>          self._tables=3D{}
> =20
>      def __del__(self):
>=20
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlRbfnMACgkQN1Ujt2V2gBy01gCeJJXCf6bhN/aUTRhjPrGOEuAT
gzkAn2nwzpqplw5QFLnlbJuzk2hxbquv
=VPnm
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
