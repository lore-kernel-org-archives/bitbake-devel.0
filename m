Return-Path: <martin.jansa@gmail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 01E0960043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 08:45:16 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so88737512wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 01:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=zDBi70WkRTWpeBNj/WVYGlOSAxNwqWQpzq8mCtz/Puw=;
	b=F55yOXmUsYX6j8z+BE8hIDmc9iVzJapRkqEfcQn48PrmZgVtJPM885D6ZJzwTXuSUr
	3RJz25Yn/DKzBPdJ+UYp4G3lyi1d2xIjd55X5jfjTtB5w1YzOCQqxw4GLgM9Mjm3pyl3
	NXy1eM95z0GqK4OiRKi7vnHww3FAuAaMZP7zZq+CQYoBUQqpTe1nTjeo+frcieF120Ds
	ROS0bAdKVPaWAvlwih5CFZ98MrZJS/5JBpoucNNKotrMXy3MAc2eN8FWHQE3fgw/ZSzx
	wEWHtzE609wgDlb146x00pnAbaYhevVBy6FsI+SJsGk7wvYG0hfCfgZSI9vK/osUFHWs
	Mk6g==
X-Received: by 10.180.75.40 with SMTP id z8mr42677084wiv.84.1439887516781;
	Tue, 18 Aug 2015 01:45:16 -0700 (PDT)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	cd16sm20337941wib.19.2015.08.18.01.45.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 18 Aug 2015 01:45:15 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 18 Aug 2015 10:45:20 +0200
To: Christopher Larson <kergoth@gmail.com>
Message-ID: <20150818084520.GF2458@jama>
References: <cover.1439509247.git.chris_larson@mentor.com>
	<CABcZAN=qS5Hc2KMr2bazenmfoPDdU2fL_3TqAYedGWr=jnH17A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABcZAN=qS5Hc2KMr2bazenmfoPDdU2fL_3TqAYedGWr=jnH17A@mail.gmail.com>
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
X-List-Received-Date: Tue, 18 Aug 2015 08:45:21 -0000
X-Groupsio-MsgNum: 6200
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline

--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christopher Larson wrote:
> On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <kergoth@gmail.com>
> wrote:
>=20
> > From: Christopher Larson <chris_larson@mentor.com>
> >
> > Please review the following changes for suitability for inclusion. If y=
ou
> > have
> > any objections or suggestions for improvement, please respond to the
> > patches. If
> > you agree with the changes, please provide your Acked-by.
> >
> > This only implements support for shallow mirror tarballs, not shallow
> > clones.
> >
> > The mirror tarball filename includes branch, revision, and depth. To
> > enable,
> > use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for speci=
fic
> > URLs. This variable can hold either a clone depth (e.g. `1` to just get
> > SRCREV), or a ref or commit, in which case we keep history up to that
> > commit.
> >
> > The shallow support will not, at this time, function correctly for
> > linux-yocto, due to its branching scheme & validation.
> >
> > Example:
> >
> >     BB_GIT_SHALLOW ?=3D "1"
> >     BB_GIT_SHALLOW_pn-linux-yocto =3D ""
> >     BB_GIT_SHALLOW_pn-linux-mel_mx6 =3D "v3.14"
> >     BB_GIT_SHALLOW_pn-testrepo =3D "testbranch"
> >
> > This implementation will attempt to fetch a full mirror tarball if it w=
as
> > unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
> > `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a shallow
> > tarball will be emitted.

It would be nice to describe what this implementation does when there is
some local git clone already (will it first try to update it with "git fetc=
h"
or download shallow tarball?)

> >
>=20
> I forgot to mention, this implements [YOCTO #7958](
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D7958).

it also looks like more proper fix for [YOCTO #1511](
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D1511).

> --=20
> Christopher Larson
> kergoth at gmail dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics

> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlXS8J8ACgkQN1Ujt2V2gBwv8gCfTnSECBbBL0jMVTJL7Lr80Pgf
8XAAn1U4h3kRJLd2I8BnXoYjp19+y64b
=Fu6k
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
