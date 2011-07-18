Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1Qioqn-00030H-8o
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Jul 2011 16:31:13 +0200
Received: by ewy5 with SMTP id 5so1536131ewy.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2011 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=tWEK9rfhDC4jIW7MggaYSyOy1KF5QaTB+IUIOageH1A=;
	b=uYT+cbCFZ1OIKmGzg5KJKMtarTKSb4SAM+XtnBOrLTPzkYSZ3WaS44ZacalF6BH6iM
	QT58vZQiwDGXlb7tHpPDiCij86h/hHPZoY7b+3ytqSy/sANAH0JHjFL6+A3Y2Kiqrw2a
	ceHsnmBR77Kf0Jb+JFTxihbKhMR7rxOjtpoPw=
Received: by 10.213.20.200 with SMTP id g8mr2229592ebb.140.1310999229145;
	Mon, 18 Jul 2011 07:27:09 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id x41sm2182546eeb.35.2011.07.18.07.27.06
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 18 Jul 2011 07:27:07 -0700 (PDT)
Date: Mon, 18 Jul 2011 16:27:00 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Denys Dmytriyenko <denis@denix.org>
Message-ID: <20110718142700.GD3412@jama.jama.net>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<201106271406.45596.paul.eggleton@linux.intel.com>
	<1309264777.20015.280.camel@rex>
	<1865303E0DED764181A9D882DEF65FB6A167F0C723@shsmsx502.ccr.corp.intel.com>
	<1309364097.20015.414.camel@rex> <20110629165139.GA8160@denix.org>
MIME-Version: 1.0
In-Reply-To: <20110629165139.GA8160@denix.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Mon, 18 Jul 2011 14:31:13 -0000
X-Groupsio-MsgNum: 173
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline

--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2011 at 12:51:39PM -0400, Denys Dmytriyenko wrote:
> On Wed, Jun 29, 2011 at 05:14:57PM +0100, Richard Purdie wrote:
> > On Thu, 2011-06-30 at 00:03 +0800, Cui, Dexuan wrote:
> > > Sorry -- what's the conclusion?
> > > Keeping the v2 patch
> > > (http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Ddcui=
/bb-v2&id=3D2a520959f71ec2cd80ed2088bfcf082631161a1a)
> > > , or changing bb.error() to bb.warn()?
> >=20
> > Where you have:
> >=20
> >   bb.error('No recipes available for:\n%s' % '\n'.join(appendlines))
> >=20
> > this would become something like:
> >=20
> >   msg =3D 'No recipes available for:\n%s' % '\n'.join(appendlines)
> >   if d.getVar("BB_DANGLINGAPPENDS_WARNONLY", False):
> >      bb.warn(msg)
> >   else:
> >      bb.fatal(msg)
> >=20
> > which means we can have a strong default but advanced
> > users/distros/whoever can avoid this.
>=20
> Thanks! That's a nice compromise.

Agreed, looks good to me.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk4kQrQACgkQN1Ujt2V2gBwcyQCbBSLzbh3NrTAerWv6M0kkfgxI
WeYAni/XEwGmHmi80M8jzRWuxjJG1OGz
=OVwi
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
