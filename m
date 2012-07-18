Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1SrcD7-0002Cl-8K; Wed, 18 Jul 2012 23:55:09 +0200
Received: by wibhq4 with SMTP id hq4so4587715wib.6
	for <multiple recipients>; Wed, 18 Jul 2012 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=uiLBapECz82tXb7HTrC1V6Tkev6XxdnnE8WqCpwUjPI=;
	b=oaR7HGTKe7PReFKh1iPQBqlRpyn0NsXmhADYo2XnudusH45PBaajZd3MDZMxB++Yus
	aVmMbJc2dsZTq4V+9CifYvYyEIUhzMkShmS1cU6/nnnpbMdVeckyR5cmpMG0Q08ZbAAW
	1JeWRp+SwHsaxvGuNKYs4y2tbogO9TVd+k+i0iJjPMlS4mAf5zKk4ISlLRx51dQeQMr7
	whNrUCMrdvihe0Ey4zdc8qCx+Z2Kl2X+KjSWx0ROS+sYsinKodCDlTYqfH+8fJuayA6r
	OToCoGY/izSvimvpx7CHjYd138b6o5kdR/pb+K1mgTslvl7IxrDgwWytiIyLof+XhWdq
	iWWg==
Received: by 10.180.78.35 with SMTP id y3mr9838738wiw.16.1342647828329;
	Wed, 18 Jul 2012 14:43:48 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id cu1sm34757903wib.6.2012.07.18.14.43.46
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 18 Jul 2012 14:43:47 -0700 (PDT)
Date: Wed, 18 Jul 2012 23:43:58 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120718214358.GT22569@jama.jama.net>
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
X-List-Received-Date: Wed, 18 Jul 2012 21:55:09 -0000
X-Groupsio-MsgNum: 2455
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mIJwGTFTwAlEXlA"
Content-Disposition: inline

--7mIJwGTFTwAlEXlA
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

Would be great if someone updates

bitbake/contrib/vim to highlight tabs, so that every tab would be easily
spotted in recipe/bbclass.

And maybe also meta-openembedded/contrib/oe-stylize.py, but that seems
to expand tabs to spaces already.

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--7mIJwGTFTwAlEXlA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAHLh4ACgkQN1Ujt2V2gBxPxwCeM5VAAoC8EVqEr4BFj2ia7CHo
KPUAoKFgPY+MjKoO2pzTsV7KgzYBwCxl
=SEzB
-----END PGP SIGNATURE-----

--7mIJwGTFTwAlEXlA--
