Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1Srov6-0002OI-4M; Thu, 19 Jul 2012 13:29:24 +0200
Received: by wgbdr1 with SMTP id dr1so2173077wgb.24
	for <multiple recipients>; Thu, 19 Jul 2012 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=Vx3XW8DH3RKkv0aVlfp8iLS0+v2kl5CNhPCVTHiIfQQ=;
	b=GLIbcILwsXoF9hkPt/mcYEL26nU90Awv9FUS3JHmsgUgGQUQxBZzF2sR8f0chWIRJJ
	0rZEwaVbazURqzy2QENsIgxVhuuOqIQL/O4Enffc3RHv/rK2QR48wS7EEc0J+h1DOzEp
	aI7o2q7JdvzgyL4j8xH327xxdfa68vMtI2CbFzajGvAdyDxjI+s12bFEroMBjt7FpS0x
	B7qFHUN5gmJjbIIpibmd+ZJSBjdSvtIXdHSopwN47Mwr1SN8w+O8/joaPUpaImet9vys
	dll+PTeEt+3kGGa8I96Cb37KtQ6s60l84E43+GsTfHuYCiq2oKn8yRs/rTW2hj7tRMIf
	2+lA==
Received: by 10.216.85.149 with SMTP id u21mr908242wee.147.1342696682444;
	Thu, 19 Jul 2012 04:18:02 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id ex20sm5343519wid.7.2012.07.19.04.18.00
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 19 Jul 2012 04:18:01 -0700 (PDT)
Date: Thu, 19 Jul 2012 13:18:12 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120719111812.GH3331@jama.jama.net>
References: <1342606005.30680.17.camel@ted>
	<CAJTo0LbkkXkJH-mbxwqKK7KM1PWDdF4mD+K8omTF4SQ9_WDogQ@mail.gmail.com>
	<1342611618.30680.24.camel@ted>
	<20120719094954.GF3331@jama.jama.net> <1342692948.7940.4.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1342692948.7940.4.camel@ted>
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
X-List-Received-Date: Thu, 19 Jul 2012 11:29:24 -0000
X-Groupsio-MsgNum: 2459
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline

--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2012 at 11:15:48AM +0100, Richard Purdie wrote:
> On Thu, 2012-07-19 at 11:49 +0200, Martin Jansa wrote:
> > On Wed, Jul 18, 2012 at 12:40:18PM +0100, Richard Purdie wrote:
> > > On Wed, 2012-07-18 at 11:17 +0100, Burton, Ross wrote:
> > > > On 18 July 2012 11:06, Richard Purdie
> > > > <richard.purdie@linuxfoundation.org> wrote:
> > > > > I put a proposal to the TSC, that we have bitbake warn/error when=
ever it
> > > > > finds tab characters in any python function. The advantage of thi=
s is
> > > > > that we give the user a clear definitive error. The downside is t=
hat
> > > > > we'll have to go through all the metadata and scrub it for the pr=
oblem.
> > > >=20
> > > > Have you ran that warning over oe-core to check that there are not =
any
> > > > legitimate uses of \t, not for indentation but inside strings?  I
> > > > can't think of any realistic use but you never know (construct a
> > > > Makefile in a python function?).
> > >=20
> > > The check is for actual tab characters, not "\t". There are some
> > > legitimate users of tab characters which I've replaced with \t in
> > > strings.
> > >=20
> > > My current patch work in progress for the conversion is:
> > >=20
> > > http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=3Drpurdie=
/t14&id=3D49d3d01f3d61a0eb19b6852229fa8fc26712f653
> >=20
> > from those 2 patches which were just merged I see that you're converting
> > strictly python functions, can we extend this tabs->spaces rule also to
> > bash tasks like do_install etc?
>=20
> Shell tasks should be tabs according to the style guide. Its harder to
> check the indentation in those and if the indentation is wrong, it
> doesn't matter since they're not whitespace sensitive.
>=20
> So whilst I'd welcome fixing them up, I don't think they need bitbake
> enforcing policy in the same way as python functions.

Agreed about not forcing the check or updating all .bb/.inc files with
this now, but maybe style guide should be updated now?

I really don't like files with mixed indentation (even when it doesn't
hurt) especially with a lot of files not conforming to style guide now,
using even mix of tabs/spaces on the same line..

FWIW: I've prepared patch for whole meta-smartphone to unify that and
I've sent RFC for few bbclasses in meta-oe too.

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAH7PQACgkQN1Ujt2V2gBxBDgCfeHW5sK7w37TulaVqxLfIayD+
fVsAoIoxAWfYnkgwAoCtRROUnozcR7ew
=JYWM
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
