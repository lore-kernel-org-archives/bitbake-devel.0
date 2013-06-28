Return-Path: <Joe.MacDonald@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 97A326A4E3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2013 19:19:12 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r5SJJDKh005917
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Jun 2013 12:19:13 -0700 (PDT)
Received: from yow-jmacdona-d1.ottawa.wrs.com (128.224.146.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Fri, 28 Jun 2013 12:19:11 -0700
Received: from yow-jmacdona-l1 (yow-jmacdona-d2.wrs.com [128.224.146.166])	by
	yow-jmacdona-d1.ottawa.wrs.com (Postfix) with ESMTP id 99A0B52D0B;
	Fri, 28 Jun 2013 15:19:04 -0400 (EDT)
Received: by yow-jmacdona-l1 (Postfix, from userid 1000)	id F3EE2410DF; Fri,
	28 Jun 2013 15:19:09 -0400 (EDT)
Date: Fri, 28 Jun 2013 15:19:09 -0400
From: Joe MacDonald <Joe.MacDonald@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20130628191909.GC10011@windriver.com>
References: <1372431907-10142-1-git-send-email-joe.macdonald@windriver.com>
	<1372431907-10142-2-git-send-email-joe.macdonald@windriver.com>
	<1372438595.9930.274.camel@ted> <51CDC119.1080306@windriver.com>
	<1372439079.9930.276.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1372439079.9930.276.camel@ted>
X-URL: http://github.com/joeythesaint/joe-s-common-environment/tree/master
X-Configuration: git://github.com/joeythesaint/joe-s-common-environment.git
X-Editor: Vim-703 http://www.vim.org
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake][oe-core][RFC PATCH 1/2] fetch2: Add an extra check for sstate_mirrors
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 28 Jun 2013 19:19:12 -0000
X-Groupsio-MsgNum: 3613
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline

--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Re: [bitbake-devel] [bitbake][oe-core][RFC PATCH 1/2] fetch2: Add an extra=
 check for sstate_mirrors] On 13.06.28 (Fri 18:04) Richard Purdie wrote:

> On Fri, 2013-06-28 at 12:00 -0500, Mark Hatle wrote:
> > On 6/28/13 11:56 AM, Richard Purdie wrote:
> > > On Fri, 2013-06-28 at 11:05 -0400, Joe MacDonald wrote:
> > >> BB_NO_NETWORK disables any fetching, however if we're using an exter=
nal
> > >> sstate cache, we may want to be able to fetch those objects even if =
we are
> > >> not fetching the upstream sources.
> > >>
> > >> Signed-off-by: Joe MacDonald <joe.macdonald@windriver.com>
> > >> ---
> > >>   bitbake/lib/bb/fetch2/__init__.py |   18 +++++++++++++-----
> > >>   1 file changed, 13 insertions(+), 5 deletions(-)
> > >
> > >
> > > Bitbake's fetch module knows nothing about sstate right now and I don=
't
> > > see any reason to teach it about it. Why can't you just change
> > > BB_NO_NETWORK in sstate.bbclass before we call into the fetcher?
> >=20
> > We considered that, but won't that then change the value potentially fo=
r other=20
> > things that could be running in parallel?  Or is the namespace protecti=
on good=20
> > enough for that?
> >=20
> > I.e. in sstate.bbclass do a d.setVar ... call the fetch .. d.setVar (re=
store)?
>=20
> If you look carefully you'll see sstate.bbclass does a
> bb.data.createCopy() of the datastore and only changes that before
> calling into the fetcher module. The change is only local to that copy
> and the copy only lives as long as its referenced so it should all be
> fine.

Okay, thanks for the feedback, guys.  I've re-worked this into a purely
sstate.bbclass change and verified it is still behaving nicely, I'll
mail that out to openembedded-core@lists.openembedded.org now.

-J.

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
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
-Joe MacDonald.
:wq

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEUEARECAAYFAlHN4a0ACgkQPN8S4W6ZZnc9BACeNNtnyYyBmKFFyQwrvzVDK4p0
hnwAmOq4eTILOiZkMh+tmZnNbetb5fM=
=t8ge
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
