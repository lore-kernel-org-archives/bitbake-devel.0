Return-Path: <patrick@stwcx.xyz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AECCC00140
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:58:04 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web08.8621.1658851079174732172
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Jul 2022 08:58:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stwcx.xyz header.s=fm1 header.b=FgY0kUuy;
 spf=pass (domain: stwcx.xyz, ip: 66.111.4.27, mailfrom: patrick@stwcx.xyz)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7575F5C0127;
	Tue, 26 Jul 2022 11:57:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 26 Jul 2022 11:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1658851078; x=1658937478; bh=agdNoobRDz
	XDchd1W+NwFhJHluMkbvaqT7uTC2fpm8Y=; b=FgY0kUuypvE1F4EZlBX4vr+zCF
	IXptHwtwAKvxLb8DAhnKZubiBjiRx0ckd+L1W083V90LO4ub/GVIuXnWTzLonvu2
	naD2rxe4g1nUGokhmhZ/jORi3vb2TNw25EuWOprxFTybWqA+r6TbOquwdA4y1QKj
	UQkQPQzlQb4vib1wWMKKGRmIfjIITMhwQpB4sOSl7iLaoc6yiQPP70MWE1YuI04M
	v/uj3Sm4dy1eguWeJSez3/1p7SuZxB3kACdG62OCE1OFSSUp0EDxWmNSay6m8bVP
	MaQ73NGYBKJ93ehSqaw58n+bygbls6XFwkJ/svFW2JCkqRibE11Ach/ewT0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1658851078; x=1658937478; bh=agdNoobRDzXDchd1W+NwFhJHluMk
	bvaqT7uTC2fpm8Y=; b=qzs6SAY9RUYW8CYCPrwsVNpiy+1U3ehhuWiztU9BHJCM
	fhGwTJSZ3ILSXst155cyM+dA+5Waes2xpCkpTqwjrwABvAh/UOWXpUagyMS0MS/k
	tmYfmY8mLCkhMYJQ608Ira3IBTrtBlu+Xstqu5bx5SHGLtj6IbPOd2fIQbdiqygZ
	vH6MKorof8eTf/NZp6gVQtVsRfA1zv5uD7osB+th4G6pQg3Rhp2Bldb8fxh0o3Od
	tZUsBMhLOQ1HoXOtaos0M+OnKndsKslzw0Z/f2XLlr/aiQMpLv3vbH/G0s5L1Zg6
	xJfeu7AHgDuA3qCAM5o3M8bOTmDSXxlqSMychFy6rg==
X-ME-Sender: <xms:Bg_gYgAQDs76U4N0ch-cEgjB2k11kL--7G3VFlp8OOilydwmNPxcQA>
    <xme:Bg_gYijsUmZiQ-QD_fxEiJoTm91DHSjCmAQdAJzPfQrwYbAKOdJvwhqpmrRi7MCSY
    6zHJ3k7A7hphK1ofqM>
X-ME-Received: 
 <xmr:Bg_gYjnVum3vBwfei0rV6n9SJ6Z_uc7xmFS8DEsunoyhMhWI4S5OBXDme_ZmE5St5daVLY-E45V7obg6qNp1QnXRjbvnuSlv>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludejmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpefggeeiieevgeffheffledtkeei
    gfehleevgefhueduffffhedttdegtdettedvieenucffohhmrghinhephihotghtohhprh
    hojhgvtghtrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:Bg_gYmxrjddTwvOtQEPKcgvJ7kfr60WFu7SrNa1CiqbT5gn2IlvKKA>
    <xmx:Bg_gYlSJjcE3WFUuAtPKNe1UinMzyz7ZWvz6OBy7z2TtcHVEEzfyZA>
    <xmx:Bg_gYhaN-4Q1UxqWu9VWCprG9g1gVAzUhLuqZuHnYaia98KVDyLD_A>
    <xmx:Bg_gYgfteJ3nHKttFTaa44BbkxFZ73DwoQB9Mj-P6rR1XM4ipdYjiA>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 11:57:57 -0400 (EDT)
Date: Tue, 26 Jul 2022 10:57:56 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Paulo Neves <ptsneves@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch: bb.fatal when trying to
 checksum non-existing files.
Message-ID: <YuAPBJrwSDriYmTZ@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
 <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
 <CANNYZj99t0x08TYJ6JmZC9uT7VderpqjPCdKRp-QNzJAS2s6Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LP+MJyEgP/5/lJRM"
Content-Disposition: inline
In-Reply-To: 
 <CANNYZj99t0x08TYJ6JmZC9uT7VderpqjPCdKRp-QNzJAS2s6Qw@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Jul 2022 15:58:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13853


--LP+MJyEgP/5/lJRM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 07:35:21AM +0200, Alexander Kanavin wrote:
> On Tue, 26 Jul 2022 at 06:09, Patrick Williams <patrick@stwcx.xyz> wrote:
> > There are some more complex examples, but one easy example is a recipe
> > which had `file://${MACHINE}/eeprom.h` in its SRC_URI[1].  Any machine
> > which didn't provide this file, even if it never intended to use the
> > recipe, now fails when we picked up this change.
>=20
> This is not how machine-specific versions of the same file are
> supposed to be listed. Just use `file://eeprom.h`, and bitbake will
> look for it in subdirectories that include $MACHINE, and if not found
> there, a default version will be picked (which you can make bogus, so
> builds will fail at recipe build stage instead of parsing stage).
>=20
> Example:
> https://git.yoctoproject.org/poky/tree/meta/recipes-graphics/xorg-xserver=
/xserver-xf86-config?h=3Dmaster-next

I agree.  The person who originally wrote the recipe didn't know about
the automatic addition of overrides with the FILESEXTRAPATHS.  As I
wrote this was just one easy example.  I fixed this one to both use the
override implicitly (as you also suggested) and put a default 'eeprom.h'
with a `#error`[1].

A seriously more complex example we have is that we have our own u-boot
recipes and used the same `u-boot-foo.inc` file names as are present in
`meta/`.  It happens that the recipes in `meta/recipes-bsp/u-boot` end
up, even though we'd never use them, using our `u-boot-foo.inc` files
and ending up with totally bogus SRC_URIs in the parsing phase (and
thus failing).  Essentially, whenever there is a new version of u-boot
in `meta` we're going to end up having to make some bogus empty
files[2].

>=20
> > I know we've been ignoring the warning(s) for a while on these kinds of
> > failures, so it is our own fault, but it is kind of annoying the new
> > behavior.  We now have to make sure every recipe not only parses validly
> > on all machine configs but it also has to have fully populated SRC_URIs
> > even when the recipe is never used on that machine config.
> >
> > 1. https://github.com/facebook/openbmc/blob/f0d9511ad2fbd563a6b793093cd=
ac557c5ef2a89/meta-facebook/recipes-utils/mac-util/mac-util_0.1.bb#L12
>=20
> Look, this is bleeding edge. And bleeding edge sometimes bleeds and
> breaks your builds. You signed up for it; if you don't like it there,
> use stable branches, or use controlled transitions to milestone tags.

I agree we signed up for the bleeding edge, partially to be more aware
of changes like this.  Hopefully this wasn't worded too poorly, but I am
not complaining that "things are currently broken for me".  I was trying
to raise awareness that this change isn't as pleasant to downstream layer
maintainers as it might seem on the surface.  If there is an improvement
or revert, great; if there isn't, we'll deal with it.

1. https://github.com/facebook/openbmc/commit/c4e6ffacb73a567c83458f6a1b7e5=
bb0a032b770
2. https://github.com/facebook/openbmc/tree/c4e6ffacb73a567c83458f6a1b7e5bb=
0a032b770/meta-aspeed/recipes-bsp/u-boot/files/openbmc-fb
--=20
Patrick Williams

--LP+MJyEgP/5/lJRM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmLgDwMACgkQqwNHzC0A
wRnjuRAAhYuNRWlyZJwtCNkWj+72d7DmshhBw+7oQmBbsh8rutj/LTIq5qgOQ6cu
EgYhPk0yEMkibqFjde3P4oegQwtyF6dfNIVqV0n25YVzdihOQ2e7TvIFoqo4TuI4
DagADpzBqlzHsM+hrFKmzZjnF+ziTo42Fwwot+O4CHqgYJ0QtdspOFCTqnFgB2oK
I1u0FPnLPK5az/qFnXpaiSohcupKsI2GRH7assBpJbtNd1Cv18ny1TKlX9r0wnpT
lPYmKIk9zs7F6NRpZhwBhyBVAvFnt6E1A4TY1gYxNQEOrS33/qzseDpYxoGHsj6w
hFv1kvf1KxSSnyRrMIQmj0ffGLFCS1YqvsVYdc8bomONxWS0H5Ddg+jCvv2oh9XR
+dDSjjPe0B6Hoe3p3WZA196D1IF+THgfEYHChoO6tjYcqzbhQPDJO6RAjrhNXnZ6
QcXzXEydtYFA/tdl70DvjfmZTgJMB+iwF4MNl9umF5+TvaTt+jT384VBqk8PaSs7
b6hj+Z9LwzcaThm+RurgTuhvNgCbHCyYnugS2m7rLMrFOBUhdNC7iyznufgRE2UC
8UklmW5gtOhh/5HW9U50VamhoCCuwRP57evoYzJhXlty67NluLUHvUz6+6rV02Ox
D//hwgGspKPLV0NJd5XZBVWGo62iBzzRZx5l/UqBx/mWY0V6330=
=UrHF
-----END PGP SIGNATURE-----

--LP+MJyEgP/5/lJRM--

