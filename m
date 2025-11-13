Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480B0CD6E5D
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 13:19:09 +0000 (UTC)
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23597.1763039939522111064
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 05:18:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=vzQj2HDk;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=BIqUriFv;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E038EC01BD;
	Thu, 13 Nov 2025 08:18:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 13 Nov 2025 08:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763039938; x=1763126338; bh=xw2OkqjvaK
	CR8t5WAFtdo3VTclUKPlvipWF7/D7ct3I=; b=vzQj2HDkHyRFrFCeXorD0YYiSp
	fR1ombyrO3qPqg/dBY73kLsQ/F2Ot8sZz+sDdO3MG9ErWjeVaaEtrjVWs1/vuN4r
	8Vkn/b90XeGHiWjXjVn4ZZauQbUrJpbc5Rxq24HtUjMrAnS3Bv3MJ0GrlQf6ngu3
	KKvdErK4szI3oAYzqkXkV78aoBmaBZizkLzfY7gzv4UUgVRT8vt4U5YRWmPmUI2P
	FGg69icvTs0ukKtxAoANObr2FeiAnJGHu+rWgujQV8vk3KXVdz31PhqQbqjGMQP8
	lxAU9GT1Q9bMDgnb3SsfBvH/se2lA6SZeLsG6Rg8m/dpLWEdxuUdkcgImXJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763039938; x=1763126338; bh=xw2OkqjvaKCR8t5WAFtdo3VTclUKPlvipWF
	7/D7ct3I=; b=BIqUriFv2Be2LmfAqwrLPOOd6Zk2ldgYm/rowZvknT08BuKFjU5
	zoxgzNHRH3MJUczUs6D+GoENmFkgt7Kt22b3Cjr89ZSQMmRjJiv8gIQf3nphlWmt
	ymb22DtxxKkL8hTkKMT7H3KaitLahV1nMkGmjqUUFLPBP2t54KzCChjxf82/S/mJ
	9j43AhyMbiYXvVTr3VrqKslfi8Bz6WVSOPnU8cDCV0szK3A3feXDRxrETu/w0hDK
	+LvTeLkjFVE6KMI+hrXeqqIYEI/oUkL2YOHiilGm5dLnthkBukK6WaoafA+8RYtE
	/iU+8YFITfvpFHxt+z/RCVvqrs1ZRU86qQQ==
X-ME-Sender: <xms:wdoVabjAqdHT5b8V2fkHgdbTvrok3LGtb5_GfySWa4Qg5xnJx2IuZg>
    <xme:wdoVaUlF2HkbVAd0fdxoQPrRI3tw2zSANM-pE96-2zpUq7c3SjKTbl-HMUlHJS7SV
    Ho4Ym8N-fPyGUdgzrZ9a__9SeMUmiOVK3LkYjngEeaUUpKG739erd8>
X-ME-Received: <xmr:wdoVafhOR9Bl08P0khZBHn6dPGHI05nAzhd4qgUqbvLJuwZXE2hfZTNZUwVjJYId7Zu-OllLy5bD4KgqfMi8GqmHwi90yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epfeffvdefgeevkeduhfetueehhfeikedvieeufeevieffueektdeluddtgfegveehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlse
    hpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishht
    shdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtoheprghlvgigrdhkrghnrg
    hvihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhsrdgsuhhrthhonhesrghr
    mhdrtghomhdprhgtphhtthhopehrvggrthhmohhnsehtihdrtghomhdprhgtphhtthhope
    hlihgviihhihdrhigrnhhgseifihhnughrihhvvghrrdgtohhmpdhrtghpthhtoheprghn
    thhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrth
    hhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphht
    thhopehjphgvfihhrggtkhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wdoVafFwZMwvGYGCX0mUIno0EdkBImz2q9LyaTf6vd0vgHfE2Nomzg>
    <xmx:wdoVaZt0hrzdlm3Sh1SejijqGgs5SkDLEXKZnQ0WEuHT75NMKo2g4Q>
    <xmx:wdoVaYdf6dM-peOEEqctdDiVNo4tYpq_uFPWgHKZPIeKzGueX4mxKA>
    <xmx:wdoVaXlfZZykOnzIyLfhx8wQGn-4fUatIDRwUf9z2zhiG7t0se8zjg>
    <xmx:wtoVaWP9zwaxuvjwcHWGANuhAh0sdg4sNz2hGbxHnQVPn1YEPoPEA0SW>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 08:18:56 -0500 (EST)
Message-ID: <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev>
Subject: Re: bitbake-setup steps for release
From: Paul Barker <paul@pbarker.dev>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, Ross Burton	
 <ross.burton@arm.com>, reatmon <reatmon@ti.com>, Robert Yang	
 <liezhi.yang@windriver.com>, "antonin.godard" <antonin.godard@bootlin.com>,
  Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt
 <JPEWhacker@gmail.com>, Adrian Freihofer	 <adrian.freihofer@siemens.com>
Date: Thu, 13 Nov 2025 13:18:51 +0000
In-Reply-To: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
References: 
	<2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0MyeMDBduOG3fOzwEzcu"
User-Agent: Evolution 3.56.1-1+deb13u1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 13:19:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18373


--=-0MyeMDBduOG3fOzwEzcu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-11-13 at 11:16 +0000, Richard Purdie wrote:
> Hi All,
>=20
> Huge thanks to everyone who has sent patches. Having multiple people
> looking at this and sending them has allowed "parallel processing" that
> is really moving us closer to release.
>=20
> The review call agreed with the patches on master-next and that those
> should merge. Not all are perfect and there will be some further tweaks
> needed but they do move things closer to where we need to be.

I think we're making good progress so thanks to everyone who has helped!
More testing and feedback at this stage would still be really
appreciated to make sure that bitbake-setup meets the needs of different
users & developers.

> There are some things we all thought still needed fixing before
> release:
>=20
> a) The update command needs to prompt y/n on overwriting bblayers.conf
> or local.conf and give the users a choice. We need a way for users to
> update the repos with one command, we can improve the conf file
> upgrading later.
>=20
> b) There should be a --no-conf-updates (better naming?) to the update
> command

I suggest --conf-updates=3D[yes,no,prompt] with 'prompt' being the
default. 'yes' means update without asking, 'no' means don't touch the
config files, 'prompt' means ask separately for each of bblayers.conf
and local.conf.

> c) The default build path should not include the machine name. Ryan
> mentioned his previous patches which have the concept of a format
> string, or we have a include y/n piece in the json config. Otherwise
> you can end up with multiple elements like poky_poky.
>=20
> d) We need to tell the user how to change the machine/distro layer as
> nobody knows about the bitbake-config-build command. Mention "bitbake-
> config-build enable-fragment machine/XXX" in output when running the
> tool.
>=20
> e) Add a comment into toolcfg.conf to point at the command to change
>=20
> f) Catch conf file configuration of MACHINE/DISTRO conflicting with a
> fragment?
>=20
> I'll let anyone add anything I've missed.

I'm still struggling to use bitbake-setup while hacking on bitbake &
openembedded-core themselves. I've always had permanent working
repositories in my home directory and more ephemeral build directories
under a path like /mnt/build which may be thrown away when no longer
needed. My home directory gets backed up but my build directories don't,
so I don't want to do my work inside the layers directory created by
bitbake-setup.

I'd like to be able to override the sources specified in a bitbake-setup
conf.json file without having to create and manage a new conf.json file
myself. I'm imagining a command line argument that I can pass to
bitbake-setup, perhaps --local-override/-L, to drop the "git-remote"
settings for a given source and set a local path:

    bitbake-setup init -L bitbake=3D~/src/bitbake \
        -L openembedded-core=3D~/src/openembedded-core

I don't think this would be difficult to support and I think it'd be a
usability win for developers. I'd like to get this in before the release
if we can, otherwise I'm going to be hand editing bblayers.conf and
fighting against the tools until we have something in place.

We will need bitbake-setup to remember that sources have been overridden
so that running `bitbake-setup update` does the right thing.

Thanks,

--=20
Paul Barker

--=-0MyeMDBduOG3fOzwEzcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaRXauxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bnEHAP9VEjWVZb6SAEG8GLtGqymAjQdKiDaI/8ru
zMnxsgdXaAD8C3ju/ydg8qmkL/ieNeFcQ0h6Y/VWchc9A9veo2OEsAw=
=PomI
-----END PGP SIGNATURE-----

--=-0MyeMDBduOG3fOzwEzcu--

