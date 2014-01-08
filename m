Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f171.google.com (mail-ea0-f171.google.com
	[209.85.215.171])
	by mail.openembedded.org (Postfix) with ESMTP id 32AE76D0A0
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2014 11:32:03 +0000 (UTC)
Received: by mail-ea0-f171.google.com with SMTP id h10so750322eak.16
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Jan 2014 03:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=UgWDk8NsUMPUvs6cBHPEy4vEORwNFqUiY6kwgcb/tmY=;
	b=kk9zTe2as6hCmlaybY89qFGlEp5xJd7HaNNBD8nyN2C8NC2RE1E+g1QM+AphpdJ43Q
	jZRYMM4/EoSwJNWiEF/iFBaCPglw8KgyuJB35AwbT7C4sL9lJ125dtDOcWrEgQrK7nD1
	aFZTqD2v2vNxcXle+JfaTZ0Y2YTSNn8yMs26tzx3XI3e6Hrhe7Uq7qhiywLsy5jJISaU
	7u7QZN/NG5ofoOGwWyfjiWE9SqHK2jQH5kl4ojrozQYJnLcYGMz6GGRgPAxVkwhZWNNT
	FFiLKW3y2tJwVCR3nl8eyImC0tYFSHNEIOBLbE+0ynn/DF32fyB+TFZVx8Ma63pTDSlV
	qCNQ==
X-Received: by 10.14.179.130 with SMTP id h2mr45916463eem.34.1389180723814;
	Wed, 08 Jan 2014 03:32:03 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107]) by mx.google.com with ESMTPSA id
	h48sm188458303eev.3.2014.01.08.03.32.02 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 Jan 2014 03:32:02 -0800 (PST)
Date: Wed, 8 Jan 2014 12:32:13 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: "zhenhua.luo@freescale.com" <zhenhua.luo@freescale.com>
Message-ID: <20140108113213.GV3709@jama>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
	<1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
	<20140103134343.GF3707@jama>
	<566cdb63dddc4dc28aa269289bf94ea8@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140106091245.GE3709@jama>
	<c4d074a69c9d4c29b77cdf0bd01f7f20@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140107144659.GR3709@jama>
	<10ed04d1db504750b8a54f0786735f50@DM2PR03MB399.namprd03.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <10ed04d1db504750b8a54f0786735f50@DM2PR03MB399.namprd03.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: "Zongchun.Yu@freescale.com" <Zongchun.Yu@freescale.com>,
	"B40290@freescale.com" <B40290@freescale.com>,
	"ting.liu@freescale.com" <ting.liu@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Richard Schmitt <richard.schmitt@freescale.com>
Subject: Re: [PATCH 1/2] bitbake: fetch2/git: Add sanity check for SHA validity of tag
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
X-List-Received-Date: Wed, 08 Jan 2014 11:32:04 -0000
X-Groupsio-MsgNum: 4303
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hEi834+foqWOL7fK"
Content-Disposition: inline

--hEi834+foqWOL7fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 10:21:53AM +0000, zhenhua.luo@freescale.com wrote:
> > -----Original Message-----
> > From: Martin Jansa [mailto:martin.jansa@gmail.com]
> > Sent: Tuesday, January 07, 2014 10:47 PM
> >=20
> > On Tue, Jan 07, 2014 at 03:29:22AM +0000, zhenhua.luo@freescale.com wro=
te:
> > > It is a simple way to add "nobranch" option to skip the SHA validity
> > check. I have posted a patch, please review.
> > >
> > > http://patches.openembedded.org/patch/64197/
> >=20
> > The v2 looks good and it's already merged :).
> >=20
> > > > > 	When tag is defined in SRC_URI, there are three SHA
> > definition
> > > > scenarios:
> > > > > 	* SRCREV is set to SHA corresponding to the tag, commit
> > > > corresponding
> > > > > to the tag will be used
> > > >
> > > > This is OK, but you cannot check that it really corresponds and show
> > > > warning if not, because it could be now allowed variant with older
> > > > SHA as bellow.
> >=20
> > Be aware that for this to work correctly you need to run "git fetch --
> > tags" or equivalent, because with lightweight tags you can have repo li=
ke
> > this:
> >=20
> > SHA-1
> > A123  <- tag-1.0
> > B123
> > C123  <- master HEAD
> >=20
> > You're building C123 or tag-1.0 when C123 revision already exists, so
> > fetcher creates clone including all 3 SHA-1s, it creates tarball with
> > checkout and puts it on PREMIRROR.
> >=20
> > Someone in upstream adds tag-1.1 pointing to B123
> >=20
> > SHA-1
> > A123  <- tag-1.0
> > B123  <- tag-1.1
> > C123  <- master HEAD
> >=20
> > Someone changes recipe to use:
> > SRCREV =3D "B123"
> > SRC_URI =3D "git://foo;tag=3Dtag-1.1"
> >=20
> > Current fetcher starts by checking if "B123" SHA-1 exists in checkout in
> > downloads directory (or even downloaded from PREMIRROR) and it returns
> > yes, so it doesn't try to update it, but then if you try to check that
> > B123 corresponds with "tag-1.1" it fails, because tag-1.1 doesn't exist
> > yet in current checkout/premirror.
> >=20
> > With annotated tags it's not problem because every new tag has new SHA-=
1,
> > so fetcher always updates the checkout first when checking for new tag.
> [Luo Zhenhua-B19537] Thanks for the explanation.=20
>=20
> > > > > 	* SRCREV is set to an older SHA in the tag, the older commit
> > in
> > > > > the tag will be used
> > > >
> > > > This one is IMHO a bit confusing, because people can notice
> > > > SRC_URI=3D.*;tag=3Dfoo
> > > >
> > > > and then they don't notice SRCREV in the recipe (or don't expect it
> > > > to be older commit in foo tag) and they just assume that tag=3Dfoo
> > > > means the tip of the tag will be used in build.
> > > >
> > > > In most cases such commit is also included in some branch and using
> > > > just SRC_URI=3D.*;branch=3Dfoo + SRCREV would be less confusing.
> > > >
> > > > So I would show warning in this case.
> > > >
> > > > In very few exceptions (if any) where you really want SRCREV not
> > > > included in any branch and included in some tag, but not
> > > > corresponding to that tag you would use SRC_URI=3D.*;nobranch + SRC=
REV
> >=20
> > I think that with nobranch patch now merged we should show warning when
> > this case happens, people shouldn't use tag parameter when they don't
> > want exactly that tag.
> [Luo Zhenhua-B19537] You point is to show warning when SRCREV and tag are=
 set, meanwhile SRCREV is not corresponding to the tag, right?

Yes

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--hEi834+foqWOL7fK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLNNz0ACgkQN1Ujt2V2gBwakgCeMLAoUBSuBCg4i9kf0FvyzNa7
ev4An28ZddHB2X25rDocC+wU0bVPVCYV
=cASX
-----END PGP SIGNATURE-----

--hEi834+foqWOL7fK--
