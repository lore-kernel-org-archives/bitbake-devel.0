Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1TCm1I-0000ZD-Np; Sat, 15 Sep 2012 08:38:24 +0200
Received: by weyr6 with SMTP id r6so2834539wey.6
	for <multiple recipients>; Fri, 14 Sep 2012 23:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=F9COBA5G/Q+NatzqDj4DbaUjyxhozyNGIaVvEjHOUVg=;
	b=bHNrK4ZsaKfTNUOKWaQxSVOV12b1BOa0Qpn379eYCRhKBsACJhxV124pwlJjonpdRE
	X2TK5LTBOMxcWmU3/1F7fscm88TVXeI+3/5w7gv/blFnGyVz+yBpwcaJDXx0gU47KScn
	yfL8AZL3phU8rhJisyOMFxMjAtZCQGIBtnBDwolJ/ckUrAeDc2Qe+zIkoQ30MwUxTgIo
	ClsVLnVY+nsf7qPGwDeS1FhHkq66Rn8WI2IDSFkwkhD/Uk1S2u0oeRWkYf09Kyck+15D
	nGPPFZnjiEyZV4jbKve0cBj0xOC33jVzlUIl++Q/uxRS7rJLPgIYa7RYmeX/pJJH1wCY
	dz0A==
Received: by 10.217.3.71 with SMTP id q49mr2849354wes.33.1347690348926;
	Fri, 14 Sep 2012 23:25:48 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id fr4sm4469926wib.8.2012.09.14.23.25.46
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 14 Sep 2012 23:25:47 -0700 (PDT)
Date: Sat, 15 Sep 2012 08:25:52 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120915062552.GC11252@jama.jama.net>
References: <cover.1346905978.git.raj.khem@gmail.com>
	<5c54fcdb91d19909f8658b6a6e8d6e6cac934cf2.1346905978.git.raj.khem@gmail.com>
	<504FF70B.7060701@mlbassoc.com> <1347458928.11710.21.camel@ted>
	<CAMKF1so6qUDFMw_aOZTdC4W_Dh=rDiiC1O7pvjaUQS2xkG8xWg@mail.gmail.com>
	<20120913121935.GC18675@giant>
	<CAP9ODKp8sKpVMi9MwdFxwZTq2-VMiRGzDzD=bBrFu8r4hZ0xMA@mail.gmail.com>
	<CABcZANkbpR66G2-4WnBjdcjUGd4Khbje-kvpd2geUaVMMxE=4A@mail.gmail.com>
	<1347623908.13596.2.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1347623908.13596.2.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Otavio Salvador <otavio@ossystems.com.br>,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 1/4] gcc: Switch SRC_URI to use svn
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
X-List-Received-Date: Sat, 15 Sep 2012 06:38:24 -0000
X-Groupsio-MsgNum: 2718
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline

--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 12:58:28PM +0100, Richard Purdie wrote:
> On Thu, 2012-09-13 at 07:22 -0700, Chris Larson wrote:
> > On Thu, Sep 13, 2012 at 6:06 AM, Otavio Salvador
> > <otavio@ossystems.com.br> wrote:
> > > On Thu, Sep 13, 2012 at 9:19 AM, Bj=F6rn Stenberg <bjst@enea.com> wro=
te:
> > >> Khem Raj wrote:
> > >>> I agree but then 1.7 GB is noticeably huge too and it will only bec=
ome
> > >>> larger in future so I don't think fetching from git will be a good =
solution
> > >>> for gcc ever.
> > >>
> > >> Can we use shallow clones? A quick test of gcc-4.7 gave me a 308 MB =
tar.gz when cloned with --depth 1.
> > >
> > > I did not check if the fetcher has this support  but it would be a
> > > nice solution.
> >=20
> > Shallow clones won't be able to support SRCREV properly, as you can
> > only clone shallowly from HEAD, not from an arbitrary point in
> > history, AFAIK.
>=20
> Right, shallow clones are a can of worms from a variety of angles.
>=20
> My current thinking is a ;allowsinglerev=3D1 parameter to the git fetcher
> which:
>=20
> a) Generates tarballs of single git revisions if tarball generation is
> turned on
> b) Searches for single revision tarballs before trying the main checkout
> approach.
>=20
> This would mean that WORKDIR may or may not have a .git directory for
> any SRC_URI marked with this. I think we should all be able to live with
> that and it shouldn't break too much?

Ah so finally fetch2 will have same functionality like fetch11 had?

IIRC there is old buq report about this.

>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBUH3AACgkQN1Ujt2V2gBweZQCeIhzj0rB7vKFb81ODFIObcLbe
f+sAoJT794QdJpg0DjMt3C6i1C3oZex/
=b+dm
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
