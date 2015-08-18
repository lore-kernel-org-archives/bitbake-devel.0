Return-Path: <martin.jansa@gmail.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id E18A460043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 18:51:21 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so108175417wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=hZNh97ooRPJKfaL2kKW3ddG8MXFvzGctl8c8wMMZByI=;
	b=1BJ15+2PaUkOfPAbxYm0XIohnkUBTmvZ3TAmk2GLmrR0mu5Q2NR/pTVAG7CLt5E/zx
	dxDF/iHb2l9cVPt8XZtYbn6BnN4R0EoytEKIQ+5/TKFhx3akR2hIDZ91oRs0ei4/I0Br
	E/GKdSZitXj2TYnAXpLbLmrG9mWHBXX5YilbZxpYobs9ySOsZjUC64EKeHuY9AEVvu/C
	/xqJVUXSFdjRXJocT1+yMxDNqtir+k7NrRYc6Ko32DDaDuzphQJQ4mkJFuMgL0VEeWjb
	HK+NFY4vVpCT4efZ5uauZoep45NXvD38lJ4aus//FR1F+Avp6h2CV0CdjA6+e4QNht+x
	sENg==
X-Received: by 10.180.99.39 with SMTP id en7mr44707753wib.49.1439923881397;
	Tue, 18 Aug 2015 11:51:21 -0700 (PDT)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	fn8sm22543915wib.2.2015.08.18.11.51.20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 18 Aug 2015 11:51:20 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 18 Aug 2015 20:51:24 +0200
To: Christopher Larson <kergoth@gmail.com>
Message-ID: <20150818185124.GA10246@jama>
References: <cover.1439509247.git.chris_larson@mentor.com>
	<CABcZAN=qS5Hc2KMr2bazenmfoPDdU2fL_3TqAYedGWr=jnH17A@mail.gmail.com>
	<20150818084520.GF2458@jama>
	<CABcZANmP1md-Rn1pA_cAWdO4sKANROPgz8fapb04UL4cfc-U5g@mail.gmail.com>
	<CABcZANmRM78-5NFg+deE90nAbp4ByjW8Kz40YVhr91ihfaO-uQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABcZANmRM78-5NFg+deE90nAbp4ByjW8Kz40YVhr91ihfaO-uQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC PATCH 0/5] Implement git shallow mirror tarball support
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
X-List-Received-Date: Tue, 18 Aug 2015 18:51:23 -0000
X-Groupsio-MsgNum: 6220
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 11:35:03AM -0700, Christopher Larson wrote:
> On Tue, Aug 18, 2015 at 7:28 AM, Christopher Larson <kergoth@gmail.com>
> wrote:
>=20
> >
> > On Tue, Aug 18, 2015 at 1:45 AM, Martin Jansa <martin.jansa@gmail.com>
> > wrote:
> >
> >> On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christopher Larson wrote:
> >> > On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <kergoth@gmail.c=
om>
> >> > wrote:
> >> >
> >> > > From: Christopher Larson <chris_larson@mentor.com>
> >> > >
> >> > > Please review the following changes for suitability for inclusion.=
 If
> >> you
> >> > > have
> >> > > any objections or suggestions for improvement, please respond to t=
he
> >> > > patches. If
> >> > > you agree with the changes, please provide your Acked-by.
> >> > >
> >> > > This only implements support for shallow mirror tarballs, not shal=
low
> >> > > clones.
> >> > >
> >> > > The mirror tarball filename includes branch, revision, and depth. =
To
> >> > > enable,
> >> > > use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for
> >> specific
> >> > > URLs. This variable can hold either a clone depth (e.g. `1` to just
> >> get
> >> > > SRCREV), or a ref or commit, in which case we keep history up to t=
hat
> >> > > commit.
> >> > >
> >> > > The shallow support will not, at this time, function correctly for
> >> > > linux-yocto, due to its branching scheme & validation.
> >> > >
> >> > > Example:
> >> > >
> >> > >     BB_GIT_SHALLOW ?=3D "1"
> >> > >     BB_GIT_SHALLOW_pn-linux-yocto =3D ""
> >> > >     BB_GIT_SHALLOW_pn-linux-mel_mx6 =3D "v3.14"
> >> > >     BB_GIT_SHALLOW_pn-testrepo =3D "testbranch"
> >> > >
> >> > > This implementation will attempt to fetch a full mirror tarball if=
 it
> >> was
> >> > > unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
> >> > > `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a
> >> shallow
> >> > > tarball will be emitted.
> >>
> >> It would be nice to describe what this implementation does when there =
is
> >> some local git clone already (will it first try to update it with "git
> >> fetch"
> >> or download shallow tarball?)
> >
> >
> > In that case, I believe it will update the clone and use that, unless we
> > have a current tarball already downloaded, but I'll double check the lo=
gic
> > and get back to you.
>=20
>=20
> I was correct about the behavioral inconsistency of the current
> implementation -- if both existed, localpath was returning the mirror
> tarball, needs_update was returning false regardless of the state of the
> clone, and then unpack would unpack the out of date clone instead of the
> tarball :) Not ideal, obviously -- either we prefer a shallow tarball to a
> clone or vice versa, not somewhere in-between. I'm fixing that now.
>=20
> I think that since the clone is essentially a superset (or should be) of
> the clone tarball, it should probably be preferred when both are around,
> but I'm open to opinions on that.

I agree that existing clone should be preferred over shallow tarball
(doing incremental update should be faster in most repositories and
updating local clone will be useful next time SRCREV is upgraded again).

When fetching from premirror shallow tarball should be preferred over
full clone (maybe make it configureable for cases where shallow clone is
still big compared with full clone and when developer expects many
SRCREV bumps - e.g. for AUTOREV - better to fetch full 10GB clone once
per builder machine and do git fetch every 2 days, than downloading 1GB
shallow clone tarball every 2 days - we have this case with huge
*webkit* or chromium repos already).

I think this is matching with Koen's suggestion in:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D1511

Thanks for working on this.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlXTfqsACgkQN1Ujt2V2gBzJIwCfewHb3DWp5yD5EIeoUZN76yTu
KrQAnAoq0P3iVosl8y7s8gkNIbNlXs3S
=+Q9F
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
