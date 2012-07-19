Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1SrnXe-0000fQ-3X; Thu, 19 Jul 2012 12:01:06 +0200
Received: by bkcik5 with SMTP id ik5so1827054bkc.6
	for <multiple recipients>; Thu, 19 Jul 2012 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=92goRJEzrnk7fj3Dgx3oxl4jGs585zd5tVQqqlsNrjQ=;
	b=tS8hqcESyiR403mOBnn7ncvn4sX1yKnCmOnmaSOvnwq396jLE0HNdJWjUCtGEF7J2x
	Fi2Mf5Qf0Q1yPt7fyhkYkTF9zWabZP8ptSL2kB2fTo4twVbCgkJLrctvZtIXfICCOCkg
	i9IdBYL52cStM4Pr2DaJtgIRuiHzMRSieZVJd1hBR2K5N4s74soE7THp9WYiQemoNIGW
	49P3/4O7MF5L1cB3Azh4KB+bzHQWOgS3SnSrTk5rtYjHk7v238QomGgDuJECFulEToX3
	shzE33Pl4065fz+sYLKIflDyhcR+kpIxpd6iLxp9FoKwBd8QPB2N4S3vq+pZT80IlwFP
	jPqQ==
Received: by 10.205.128.141 with SMTP id he13mr509967bkc.112.1342691384329;
	Thu, 19 Jul 2012 02:49:44 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id u8sm713174bks.0.2012.07.19.02.49.42
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 19 Jul 2012 02:49:43 -0700 (PDT)
Date: Thu, 19 Jul 2012 11:49:54 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120719094954.GF3331@jama.jama.net>
References: <1342606005.30680.17.camel@ted>
	<CAJTo0LbkkXkJH-mbxwqKK7KM1PWDdF4mD+K8omTF4SQ9_WDogQ@mail.gmail.com>
	<1342611618.30680.24.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1342611618.30680.24.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] PLEASE READ: Major change landing shortly (python whitespace)
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
X-List-Received-Date: Thu, 19 Jul 2012 10:01:06 -0000
X-Groupsio-MsgNum: 2457
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline

--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2012 at 12:40:18PM +0100, Richard Purdie wrote:
> On Wed, 2012-07-18 at 11:17 +0100, Burton, Ross wrote:
> > On 18 July 2012 11:06, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > I put a proposal to the TSC, that we have bitbake warn/error whenever=
 it
> > > finds tab characters in any python function. The advantage of this is
> > > that we give the user a clear definitive error. The downside is that
> > > we'll have to go through all the metadata and scrub it for the proble=
m.
> >=20
> > Have you ran that warning over oe-core to check that there are not any
> > legitimate uses of \t, not for indentation but inside strings?  I
> > can't think of any realistic use but you never know (construct a
> > Makefile in a python function?).
>=20
> The check is for actual tab characters, not "\t". There are some
> legitimate users of tab characters which I've replaced with \t in
> strings.
>=20
> My current patch work in progress for the conversion is:
>=20
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=3Drpurdie/t14=
&id=3D49d3d01f3d61a0eb19b6852229fa8fc26712f653

=66rom those 2 patches which were just merged I see that you're converting
strictly python functions, can we extend this tabs->spaces rule also to
bash tasks like do_install etc?

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAH2EIACgkQN1Ujt2V2gByO2gCfdcLEtyJutZa52wNTgSesEpX7
/ZMAoJSPtQX8ruz69KwHS37QxBW4kWOO
=sd/p
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
