Received: from mail-wg0-f41.google.com ([74.125.82.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1Srp3k-0002fP-Ki; Thu, 19 Jul 2012 13:38:20 +0200
Received: by wgbds1 with SMTP id ds1so4674815wgb.0
	for <multiple recipients>; Thu, 19 Jul 2012 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=YOZT99fU+eqgaWAnn+QLReoWFrT01bLoyzpdwdyyDbU=;
	b=KEpiYBVtlR2ce3SW2dd/y6EjiafIXYzPo0W2HjmGJQtZgG0HKl50/UBwzFlRUhvwF9
	68sFcZOSBwzaqWpbyLmS/M/3TjsQKa5IfXdcITcxPqA8Hy9gKQFc7ELF/o0X5BOsYBBw
	5NPl9EkYLDJ3o1Rc5sT2QefEbVrVUmN/eCnQOcIlRACYDw3seZaG3XLGhK0b+FNtPjnG
	IxW0Ab3JBf3SkCzvdUGbfosYmCUDFo/AXt+TMfc07i6wWeGOw2oKljocssH4oK+RNz9y
	vA5iToAcuiSKKG+3DNg6o1M/B6kqFWuAbIVHj2NJjjE6lhb6rugxNCFIrmHie3XSYbcO
	sR1Q==
Received: by 10.180.103.136 with SMTP id fw8mr3808530wib.20.1342697218936;
	Thu, 19 Jul 2012 04:26:58 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id eu4sm37989411wib.2.2012.07.19.04.26.57
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 19 Jul 2012 04:26:58 -0700 (PDT)
Date: Thu, 19 Jul 2012 13:27:09 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120719112709.GI3331@jama.jama.net>
References: <1342606005.30680.17.camel@ted>
	<CAJTo0LbkkXkJH-mbxwqKK7KM1PWDdF4mD+K8omTF4SQ9_WDogQ@mail.gmail.com>
	<1342611618.30680.24.camel@ted>
	<20120719094954.GF3331@jama.jama.net> <1342692948.7940.4.camel@ted>
	<20120719111812.GH3331@jama.jama.net>
MIME-Version: 1.0
In-Reply-To: <20120719111812.GH3331@jama.jama.net>
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
X-List-Received-Date: Thu, 19 Jul 2012 11:38:20 -0000
X-Groupsio-MsgNum: 2460
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Content-Disposition: inline

--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2012 at 01:18:12PM +0200, Martin Jansa wrote:
> On Thu, Jul 19, 2012 at 11:15:48AM +0100, Richard Purdie wrote:
> > On Thu, 2012-07-19 at 11:49 +0200, Martin Jansa wrote:
> > > On Wed, Jul 18, 2012 at 12:40:18PM +0100, Richard Purdie wrote:
> > > > On Wed, 2012-07-18 at 11:17 +0100, Burton, Ross wrote:
> > > > > On 18 July 2012 11:06, Richard Purdie
> > > > > <richard.purdie@linuxfoundation.org> wrote:
> > > > > > I put a proposal to the TSC, that we have bitbake warn/error wh=
enever it
> > > > > > finds tab characters in any python function. The advantage of t=
his is
> > > > > > that we give the user a clear definitive error. The downside is=
 that
> > > > > > we'll have to go through all the metadata and scrub it for the =
problem.
> > > > >=20
> > > > > Have you ran that warning over oe-core to check that there are no=
t any
> > > > > legitimate uses of \t, not for indentation but inside strings?  I
> > > > > can't think of any realistic use but you never know (construct a
> > > > > Makefile in a python function?).
> > > >=20
> > > > The check is for actual tab characters, not "\t". There are some
> > > > legitimate users of tab characters which I've replaced with \t in
> > > > strings.
> > > >=20
> > > > My current patch work in progress for the conversion is:
> > > >=20
> > > > http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=3Drpurd=
ie/t14&id=3D49d3d01f3d61a0eb19b6852229fa8fc26712f653
> > >=20
> > > from those 2 patches which were just merged I see that you're convert=
ing
> > > strictly python functions, can we extend this tabs->spaces rule also =
to
> > > bash tasks like do_install etc?
> >=20
> > Shell tasks should be tabs according to the style guide. Its harder to
> > check the indentation in those and if the indentation is wrong, it
> > doesn't matter since they're not whitespace sensitive.
> >=20
> > So whilst I'd welcome fixing them up, I don't think they need bitbake
> > enforcing policy in the same way as python functions.
>=20
> Agreed about not forcing the check or updating all .bb/.inc files with
> this now, but maybe style guide should be updated now?
>=20
> I really don't like files with mixed indentation (even when it doesn't
> hurt) especially with a lot of files not conforming to style guide now,
> using even mix of tabs/spaces on the same line..
>=20
> FWIW: I've prepared patch for whole meta-smartphone to unify that and
> I've sent RFC for few bbclasses in meta-oe too.

I know you've sent me link do different style guide last time I've
asked, but first google hit (for openembedded style guide):
http://www.openembedded.org/wiki/Styleguide

says about tabs only this:
- Use spaces for indentation as developers tends to use different amount
  of spaces per one tab.

So only in yocto wiki there are 2 more bullets after that
https://wiki.yoctoproject.org/wiki/Recipe_%26_Patch_Style_Guide
- Use spaces for indentation as developers tends to use different amount
  of spaces per one tab.
- Shell functions should use tabs
- Python functions should use spaces (4 spaces per indent).

And yocto style guide is not in first 5 pages of result when searching
for "openembedded style guide".

Cheers,
--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAH7w0ACgkQN1Ujt2V2gBxqWgCfQhQpOVEgUDEKNtuqEXgfEqb6
2q4AoLcR+nwnhMkb6a0qOgky03JagLWJ
=SY1i
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--
