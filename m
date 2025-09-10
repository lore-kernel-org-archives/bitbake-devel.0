Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F90FCA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 11:03:41 +0000 (UTC)
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mx.groups.io with SMTP id smtpd.web11.14624.1757502216039340486
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 04:03:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=CDurn373;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=ZmPxDbrX;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.147, mailfrom: paul@pbarker.dev)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D28C91D0026A;
	Wed, 10 Sep 2025 07:03:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 10 Sep 2025 07:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757502214; x=1757588614; bh=SgyvUGyOU9
	1HMQ4SCq7Z58VuWT4D5LkDg3FmnovfCbA=; b=CDurn373/X6qRb5OSbTxpv5O1x
	ueguUxpVDvbWGSe+kpSCjL6oyQh5HkNbBMv6TAl3/QSAsQ9swAdIOBmxfeDqEPyC
	aIUQQZqMR38BInR+keAAPLTMR2Hg7L64lAS4i2fzmJz39J90+tj48Yn9asQdqjeV
	DeKHrRkFR646lauAcxalAOp/TTXOenPK/QSiYKU9GcH4LpgNN4f/Wfx68XhiSXWF
	LXIwlxhz6zPZbRhiFE7rKuxgZPKUoZzKyrbWBZz54OtKKKhhc5GGBNli9sE5NYBv
	LpbzeE7geO1xLWnO3MUe3Ka9t3C7PsCGjFGHQFJ2E21XIlyhY32/QOexCStw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757502214; x=1757588614; bh=SgyvUGyOU91HMQ4SCq7Z58VuWT4D5LkDg3F
	mnovfCbA=; b=ZmPxDbrX4JuV3ISOZ0AqByavfdnioCEjpGs6wTcykA3VazplOD7
	UEMgavrvhHgEOXG4xfgWHXuNfECK4Lhrih09GPXNnuka55ql5E5uhzOAMWYXqDrG
	YUDepY4+AGVYtfFKUmspZPCsuWjRzoPprIuL0RZ2FviHdwjwunjRObzLCASi8EOg
	/iAogr5EaXdicfFmssepdkcr8gc4p5WOr107YAuVUxMGZihjvhybpyxsxh/pReuA
	86qF23Ewrgaa2/eO23XyK8RvxMsSAXNI208PM4stGWdeM8fFVXVceVZWqleLiZ4c
	Vep+CvsjKici6/aevth7bu5IRniwjLajrew==
X-ME-Sender: <xms:BlvBaNAdZOdzzjfPJ0UusW7kQ_KGsrZUx7UThHIdvqfyUGtGAOxylw>
    <xme:BlvBaOyZp4gZUFe0GALS0RVw4fR2hIrlmDt6KCvL1cVX4QCU7Cf--vEC90DlDA0W7
    DheXnYByNg6gfEAzOg>
X-ME-Received: <xmr:BlvBaCAVATpPzblwjGXaKCu3-EzgTj2i4VeQER7612EfCQScy61pw9ekImwv9uBI2J9EQZO15WxWSUsLRHppWTxctEx92g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    efffdvfeegveekudfhteeuhefhieekvdeiueefveeiffeukedtledutdfggeevheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesph
    gsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghlvgigrdhkrghnrghvihhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggu
    rdhorhhgpdhrtghpthhtoheprghlvgigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:BlvBaDY6Uk9AVXf8A3_ptztnGUpCsD0uaAh9e1v34yP79ReqHTFvGw>
    <xmx:BlvBaCjOqC4qHswwiOn5o2wSx9XqvonOhuFcH4QcXjIo0KE5dgi2JA>
    <xmx:BlvBaN7AyrHruzkSgWbMqYkcckcukyt8MaKr2sP_gtB2Z4ILRIn_hw>
    <xmx:BlvBaB5TcpBM4W_7KoDiajDpEmXJtEQcYmHeVVXsX5C7xHblVwS_tw>
    <xmx:BlvBaMu0-kDCK1SZZfX2ll3K1eQ5MxAsoKnykSIJt3y6BtwgfXcIfF99>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 07:03:33 -0400 (EDT)
Message-ID: <8c63326ece999d7ca84f835e4cbd44692ff40baa.camel@pbarker.dev>
Subject: Re: [PATCH 1/3] bitbake-setup: add the initial implementation
From: Paul Barker <paul@pbarker.dev>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Alexander Kanavin
 <alex@linutronix.de>
Date: Wed, 10 Sep 2025 12:03:28 +0100
In-Reply-To: <CANNYZj-OUXMsyiSNxM=dcoLyXsS8ioSuVBkW+amUm=Uc3GeVoA@mail.gmail.com>
References: <20250908123437.1728264-1-alex.kanavin@gmail.com>
	 <dd91f763f6d54bf3fd48215cfad51c2d0b0cfb56.camel@pbarker.dev>
	 <CANNYZj-OUXMsyiSNxM=dcoLyXsS8ioSuVBkW+amUm=Uc3GeVoA@mail.gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7EA/FHDcYZa5o+yz+KOz"
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 11:03:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17995


--=-7EA/FHDcYZa5o+yz+KOz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-09-10 at 12:19 +0200, Alexander Kanavin wrote:
> On Wed, 10 Sept 2025 at 11:35, Paul Barker <paul@pbarker.dev> wrote:
>=20
> > I've added a few thoughts after testing this out.
>=20
> Thanks for the feedback :)
>=20
> > > 3. To check if the build configuration needs to be updated, run:
> > >=20
> > > =3D=3D=3D
> > > $ bin/bitbake-setup status
> > > ...
> > > Configuration in /home/alex/bitbake-builds/poky-alex/ has not changed=
.
> >=20
> > This example doesn't work without a `--build-dir` argument.
>=20
> You have skipped point 2, which explicitly tells that it does work if
> you take the step prescribed :)

Ah, this is my bad then, sorry!

As bitbake-setup is only available on the master-next branch, it's
actually not available after entering the build environment if the
conf.json file asks for the master branch of bitbake. So I tried running
`bitbake-setup status` back in my other shell and it failed.

If I temporarily change the sources.bitbake.git-remote.rev to
master-next in the conf.json file then I can successfully run
`bitbake-setup status` inside my build environment. And this won't be an
issue after bitbake-setup is available on the master branch.

> > We should support entries with 'path' set to an already checked out
> > layer directory and no 'git-remote' key. This would allow people to use
> > bitbake-setup to manage the build directories for layers which they
> > maintain without having to push all changes up to a remote repository i=
n
> > order to test them.
>=20
> I'm not sure I understand the scenario. You can use bitbake-setup to
> clone a layer, and do local work on it, we just need to make sure
> bitbake-setup will not overwrite the changes on 'update'.
>=20
> But if you really really want to refer to an externally managed layer,
> you don't need an entry for it in the sources section at all. Entries
> in 'bb-layers' are relative paths as well, and that can be set to
> anywhere on your local disk. Or the code can be tweaked to recognize
> and support absolute paths.

My preference is to checkout the layers I'm working on first, along with
my own scripts and local configuration. I treat build directories and
the repositories checked out by other tools as ephemeral.

A benefit is the ability to make a change in a layer I'm working on in
one place and then build multiple configurations (perhaps MACHINE/DISTRO
combinations). If each configuration has its own clone of the layer I'm
working on, I need to ensure that my change is copied to them all.

I'd also prefer to specify paths relative to the conf.json file or the
configurations directory so that I don't have to hardcode absolute paths
everywhere.

This is all for future improvement - we can get bitbake-setup merged
first and then iterate on these features.

Thanks,

--=20
Paul Barker

--=-7EA/FHDcYZa5o+yz+KOz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaMFbABEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0btnCAP478++tWHSigVlQjLgr4pPzBiJbUnUE9lZ8
nqX7rxZrYgEAp7gRnAidFDYKQ/A0LXyR9napcD86cEb4pAURqtf3LwU=
=lCTD
-----END PGP SIGNATURE-----

--=-7EA/FHDcYZa5o+yz+KOz--

