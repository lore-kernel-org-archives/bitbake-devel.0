Return-Path: <patrick@stwcx.xyz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5BFC19F21
	for <webhook@archiver.kernel.org>; Wed, 27 Jul 2022 19:16:12 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 by mx.groups.io with SMTP id smtpd.web10.24053.1658949366179407057
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Jul 2022 12:16:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@stwcx.xyz header.s=fm1
 header.b=tVws74qb;
 spf=pass (domain: stwcx.xyz, ip: 64.147.123.21, mailfrom: patrick@stwcx.xyz)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id B50803200915;
	Wed, 27 Jul 2022 15:16:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Jul 2022 15:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1658949364; x=1659035764; bh=r4qGK98sg4
	2Vk4nGLDU9Rohvg1uYf2TuYvcv51y5nOY=; b=tVws74qbPOlthf49R6AX7EX5N1
	4KYxdj3C7lsdvQeRy3EDgJtyVtYBdXI9eDTPGV8FeR+HRFlBoYJJMmvUovorzhBB
	V6MmeFnDqiridIbnASdRP0KKCYKuSACDWwwSOOjR8I2NPtfvul5tSn7x3lZuS3eE
	Z/jHmObf338OF/z3l8022idmvyrFYdhIERTxKy5+99VtMdOMBb4y2Kb7ee7aHZYG
	3eY5lhZHes04OwX0NdYy1x6l3rNRIA5b84dcnggsPDm91B1YnpHveZrZ2BAPn8gU
	yw21+FxO3wATZutvgoFf7L8VJjy0rNrPK+fC+WXMN0thXwhhocGgDFqr5ikw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1658949364; x=1659035764; bh=r4qGK98sg42Vk4nGLDU9Rohvg1uY
	f2TuYvcv51y5nOY=; b=2sim3mX/FU/T91R/3HELJ/7/A9kHDhvcFafEloXbqahb
	3/c8Oz05G1QOkvnYm94ihHhKU8EorD+GeJx1e+rYO7zcXOl2QshZZxAidTpgNRuk
	ih3z6oOHRd4089F6/895n1rCxFG4RNhMw7w4dOtoB+jGkyLwqCRvIESOcprp9J8w
	SdeXEGDrBCjxPU2Zb2d7UhpW5FIftzrI6z837pxJ4zFw+moyL7j95rfDDKvJh1Yh
	sS05zC2vraaDoqyQHLqdG9Ilk29oMsebMmw34/51/4L/q4hmeqBHi8SWtcVvOgJa
	Zevh4T2Zvb9XyLYqzJZ7TOjkvVj2uR0T7M1iKt/fTw==
X-ME-Sender: <xms:847hYtYeQ5aJ_lrTn05vRmQ6UBnXzqX1kLT-oVyJjTbaZYOkvSo0aw>
    <xme:847hYkaBhpH0FPOPhAZvqDruAPXmBHK1xd-d2KFM50-9LIkaLW_cRDHsX6VcajwWa
    wh-aeZjIGeCfvTcOc0>
X-ME-Received: 
 <xmr:847hYv9GUqaLUf7JbRdfZbPOa6sItAWnXvajPhrjJS3fcbXTrpCSdZzSwzur2R7-HYo7h7d1eRQbXpt35iJl3__lU3o-OIX->
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreer
    tddtvdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkh
    esshhtfigtgidrgiihiieqnecuggftrfgrthhtvghrnhephefgiefglefgfeefudfhffdu
    fefhhedvjeefueeguddttdeileekgeeuieejuedvnecuffhomhgrihhnpehophgvnhgvmh
    gsvgguuggvugdrohhrghdphihotghtohhprhhojhgvtghtrdhorhhgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfi
    gtgidrgiihii
X-ME-Proxy: <xmx:847hYrrAyJYpWBMgKvTuHmmZMetEFR1AefCpu1KGJd_vDyqUO8Oqeg>
    <xmx:847hYorvXMShf5nwi-ULVHlOs0--zynFG7UjzImkGH5EgudiT0RIDQ>
    <xmx:847hYhSW5hpYinBcEK534OjnsMfhd5Rni0xeFTMaXYpLeVoZgQzRKA>
    <xmx:9I7hYjUqfLHCokZhfBISLDD3UaAKEfAZ4vnGSvpcgqcTZJlFneUMbg>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Jul 2022 15:16:03 -0400 (EDT)
Date: Wed, 27 Jul 2022 14:16:02 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Paulo Neves <ptsneves@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch: bb.fatal when trying to
 checksum non-existing files.
Message-ID: <YuGO8jIZ/SE215Nh@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
 <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
 <CANNYZj99t0x08TYJ6JmZC9uT7VderpqjPCdKRp-QNzJAS2s6Qw@mail.gmail.com>
 <YuAPBJrwSDriYmTZ@heinlein.stwcx.org.github.beta.tailscale.net>
 <f3f31635-e216-d11a-d30d-dbedb6ed3335@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="McHT4cjUskvDRz8E"
Content-Disposition: inline
In-Reply-To: <f3f31635-e216-d11a-d30d-dbedb6ed3335@theobroma-systems.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Jul 2022 19:16:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13860


--McHT4cjUskvDRz8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 27, 2022 at 04:50:37PM +0200, Quentin Schulz wrote:
> On 7/26/22 17:57, Patrick Williams wrote:
> > On Tue, Jul 26, 2022 at 07:35:21AM +0200, Alexander Kanavin wrote:
> >> On Tue, 26 Jul 2022 at 06:09, Patrick Williams <patrick@stwcx.xyz> wro=
te:

> The original u-boot recipe uses "require" with just the filename, c.f.=20
> https://cgit.openembedded.org/openembedded-core/tree/meta/recipes-bsp/u-b=
oot/u-boot_2022.07.bb?h=3Dmaster,=20
> etc... there's not a single recipes-bsp/u-boot returned by git grep in=20
> openembedded-core... My understanding of the require mechanism so far is=
=20
> that if you pass it a filename, it'll only look into the current=20
> directory (where the recipe is located) and if it has a path, it'll look=
=20
> for that path in all layers (well, BBPATH, which in the majority of=20
> cases should be LAYERDIR, the root of the layer). Since there is no path=
=20
> in require for the u-boot recipes in openmebedded-core, I don't=20
> understand what you're saying happens happens. c.f.=20
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-ma=
nual-metadata.html#require-directive=20
> for the doc on require directive.
>=20
> This highlights one of the following:
>   - a rogue bbappend or some weird configuration in one the layers in use,

I dug into it a little more.  It is a rogue bbappend in the u-boot case
and not an issue with the require.

We have an internal tree that contains all the u-boot code along side
the recipes, along with a u-boot%.bbappend to replace the external
SRC_URI with an internal ("file://"-based) one.  This gets applied to
the `meta/recipes-bsp` versions even though we don't have copies of
their code.

--=20
Patrick Williams

--McHT4cjUskvDRz8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmLhjvAACgkQqwNHzC0A
wRngYQ//ZAi7220p77qJ0IHuHNunXDbAxAKWzNkkWZF5kwhV+5rgJlpfUi1F6N5y
tOn0yvfBcmPvyjhUAsrNMkIzSkfjCGc1IzeYWTC2uCDfbgt9cH9uyPpImYjoGVUO
lEuyYVEZX+l+a95ZHzsSyWPoanEHTySrGoL6SW1QQfR64FvacqPbwS2DR/TJh0G0
OiNPQdnp1zcM/NL/xWnPOFqlQ90iumkm+BdZj7riW1CIuTJDWTDKqXXmuLrITDVA
x/pMCGhQToDKADFVEHszPmFINdzFM5RD6cTSmtsQT3n+VgAO2L4vtXVt2XqunokQ
2qqtrsLzE/2g3OYsIiZo36lLbgZO7OvgKADz+nFKFNAeDrPugWTMt73aLZeuNp9n
3ErnI67Nu42EoGSQq2CEeR2htD1Eys9jmSrpg5/RB8NBmiGgZfd55l3IM/EJ1YsE
eIGwNB54S4d39QseQefM8VkGp+2uybs/R10oOBODGTYiMbMxhrV5ZPRUHEtQDcYe
0mSzq/QJWKPlr5yeKdvYGd4Gu1aOtFmqv6gyM1EH2C6RWE06Ivae6T5BKWf5iJA5
eqyRCM0BrrDTIpg5IpOFCEV/NPsFaYSqdgXI1uR7uPcUvK7EKwcorW8diCGLnrOP
w+Nu5pUT7XqcB/bsk8J7U1K17yw50NsyLr00i52tjpB5HTmcQNY=
=GjPT
-----END PGP SIGNATURE-----

--McHT4cjUskvDRz8E--

