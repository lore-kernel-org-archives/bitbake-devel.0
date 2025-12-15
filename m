Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9C6D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 11:54:24 +0000 (UTC)
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46875.1765799664424042143
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 03:54:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=O4AxDdCd;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=s5vqQLNO;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C7AF61D0006B;
	Mon, 15 Dec 2025 06:54:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 15 Dec 2025 06:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765799663; x=1765886063; bh=IaKfFJxMOa
	4LiW37aPhT8VM3Y8nq777CetXtx7vS69A=; b=O4AxDdCd6nJzaNI97Qwkb9Snft
	Hn1YAgK9jFrJbwNlSj4vqFOef1Mk61TW4GSnFnnWZWgHCat7wmugK1+QFkNiQyEV
	g/Iez4A7ej25PCnrdHdYlIb28Zk1EWqFhyO5AHMW0vvF/Lk4TKu6ALe7pgnV8Vdw
	NYvMqAWbNWX0NFgZSHi7LnV+FquMAEjMicWH2xSYsFkLqai9pQ+OaCcdO64VX50N
	QBZv+72XLVfgVfiGktPu6xQi7PyGJfl5xLw/mKfhOLAhZWEJgcdDneFutU59qMeB
	5LaFLXy/4scmeyzjVNXn+hzOIiiAzNoKpqb5lyVV5Ut51K15AaagZcuIdk3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765799663; x=1765886063; bh=IaKfFJxMOa4LiW37aPhT8VM3Y8nq777CetX
	tx7vS69A=; b=s5vqQLNOVF2CaoUQDzpAlJSPkJQLnoi9BzQLfh7CIZhFHsyKCqz
	zqFt76gMQdkIixPnr8730fPm/DmtcS1OZ5+FrNgxfYP96Uh+S10y9A9H4clSgK6D
	ndgcC//8o7ZETKbqR+OB8IpZup4r8GmnxbnE5dOhgtsLR8Wod7h91pkyjVdMQTne
	aom4+iDWEh0zxVpqnBAONJ54ZTYVRkUCJE/aXviywDYR8WNSK7VDtzfzumhkpgSu
	GChpK+PcUm+Wx3yLuwnLk1VjOfh0upvKiD06kicHrDEvec5Y8fBVJE802M8/BLrf
	vcmFUimCB0JhxHgQP8avYLPWnj8j35jC/wQ==
X-ME-Sender: <xms:7_Y_aUsl0XXaDgeP5jJTalJikjSeZwb-6l_YrHScYBtjTuVNZyZflQ>
    <xme:7_Y_aXfiRVU6-nlYZv9ymOh2CzREWTg3RnqQJbp7vwO4slYzrKH4Entj3G1iiapx7
    wOLUaCxidGC5_cCi3TmqzC66wWaO5e3szXYoAxKAbTCFKuqWrLYwv8m>
X-ME-Received: <xmr:7_Y_adZMNUQAZxcezw8FpzrkiS6THcpT5j2UZA6JRRvENEtYE4L2oY8B4tYvDJyAQkh8WBcBkpOVmkgY222GMVHeG2ZoLgaTC4fShIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefieejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceurghr
    khgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnhepfe
    eileehudffvdeljedvgfetieeugfetteekfedtgeeggfevtddutddvheegfeeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsg
    grrhhkvghrrdguvghvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehoshgrmhgrrdgrsgguvghlkhgruggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvggu
    uggvugdrohhrgh
X-ME-Proxy: <xmx:7_Y_aSVE3H5i6zbscNQ_nmyPyKBWiMUw95D3NCyzPKHfUrWxSTs1Gg>
    <xmx:7_Y_aXi_5LpReveHtuaW-jUUG0Vq_tRd6_gKSM9c9a9gPqIJxENIxQ>
    <xmx:7_Y_aYVBo0epUaI1B1W44PEbIOMS83td3_VxkpP4b-J9qj6qQKTL0g>
    <xmx:7_Y_aWMWkcUkJRD2aUnX8QmpF-4e4EkuhTFhyeByX7utk3s03mmpQw>
    <xmx:7_Y_aR-YwrB5HkDTb1EDk4kLSOtIWK9k7wTz-YFi8MAsolFfEG5dereN>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 06:54:22 -0500 (EST)
Message-ID: <016117db60e8c28186fd3ac5d078f9a0de727682.camel@pbarker.dev>
Subject: Re: [PATCH 2/4] bitbake-layers: layerindex-fetch: Fix branch
 detection method
From: Paul Barker <paul@pbarker.dev>
To: Osama Abdelkader <osama.abdelkader@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 15 Dec 2025 11:54:20 +0000
In-Reply-To: <20251212190806.32476-3-osama.abdelkader@gmail.com>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
	 <20251212190806.32476-3-osama.abdelkader@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-HA5rI8TNrWDRbvMFY+Gw"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 11:54:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18590


--=-HA5rI8TNrWDRbvMFY+Gw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-12-12 at 20:08 +0100, Osama Abdelkader wrote:
> Replace fragile parsing of 'git branch' output with the more reliable
> 'git rev-parse --abbrev-ref HEAD' command to get the current branch name.
> This avoids parsing issues and is the recommended way to get the current =
branch name.

Do you have a source for this recommendation? I thought the preferred
command was `git branch --show-current` as that just prints the branch
name with no extra formatting.

Best regards,

--=20
Paul Barker


--=-HA5rI8TNrWDRbvMFY+Gw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaT/27BEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bhGqAP9WzeM7Zr12FCMLUysN0QTqkzCU8Wv7DJuF
ipLqGiwmswEAvqZf6O43URzsgtG2ru9Aek4kn00aDyz2w1NuVf3W3go=
=Ptnx
-----END PGP SIGNATURE-----

--=-HA5rI8TNrWDRbvMFY+Gw--

