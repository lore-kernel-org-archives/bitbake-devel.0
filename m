Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B05CCF9FE
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 14:45:42 +0000 (UTC)
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22455.1762181132704534678
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 06:45:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=Br3FbQBj;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=UV/dW/Ek;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.152, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A603714001FD;
	Mon,  3 Nov 2025 09:45:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 03 Nov 2025 09:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1762181131; x=1762267531; bh=wq1f+xSNku
	I5Cca/6BblPz6NaSpOG88E1woQgdCyOZ0=; b=Br3FbQBjwf4xF076GTe05nnJ45
	fEGK85gxBtoK7eC6U7uVEOm8yUf3AEFbNOWCuqMw+IRkQYcATJn5FFAeTfU/GSGW
	KSSiKAd+Q7zn7hHmy0/EvQod9zxS1SomJyNATn5LYEfpjXUQiUnApKk5zztzUmtL
	W3RhsLNsVYbi+JAnT5BWJPCE4MHc3HfxLph/L6ZhjS/1jDhM9qp7AwbwjRiBcK8E
	rsZn8U12GrYbSZywlAWwsMG/3SaQyw8/ckNenx4B1tstbZPPZZKeSaRA42rl1bNv
	lCmT7rvVJB8ZI25S17p8la1ze2ZuYhMb8DhiwlA5/tseTk0mOMq6VcOG9cEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762181131; x=1762267531; bh=wq1f+xSNkuI5Cca/6BblPz6NaSpOG88E1wo
	QgdCyOZ0=; b=UV/dW/Ekem5mxBtPqG8z5rg85fT33XUbZJU7d1PTy6eq5ji2ZaF
	GVP64dXxs6P+c0QnV3Lw7NQwhkEE5LHI4PhyvtIG6oo4HhsXZcMSi5RaaeHQhItu
	b8OnUpdWyBlcVaZTwrycWjuMf0LTZo7rnfUNvO/MIslofs6LqlspycLN7Mzwwd5q
	vjQCmx5YpX5hoGUAxTeR+nHzhEYrapr1n3sKzCjGMFmyaLLvxgsPJPGHOwOBrKqH
	IJ40UexNmpAsui62tQ3YuwJRWuQr6U+qnANLgqGlLdclBymIK9S3xTMGxQLdvUwJ
	9G14teOc1yfKGNbvs4thi1wS2irZN+mhXXw==
X-ME-Sender: <xms:C8AIafJFmCHeCyEa6dg9RwYITJbQsSo1dCh4xUUTKttusdg6OtSKXg>
    <xme:C8AIaakrlyWduAUcqhQ4I1HaR-mZ8IkGr4AcV2Hbp9Rx15QsV9QrbL822bqCBfLVa
    9gGWofLqS4H47Yv2A9DA9UaJRB3sqdx7a8UsaxuvAJqolOW6SDNb3Q>
X-ME-Received: <xmr:C8AIaVF14dSrO6ZnVrY-Uv0bVqWBoXI8IACXyAuX_voqbOlorwDA-sR-pTqASPU_tbvBBp0k9p3hOg0WsX4anSsIFsvVTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epfeffvdefgeevkeduhfetueehhfeikedvieeufeevieffueektdeluddtgfegveehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlse
    hpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrlhgvgidrkhgrnhgrvhhinhesghhmrghilhdrtghomhdprhgtph
    htthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggv
    ugdrohhrghdprhgtphhtthhopegrlhgvgieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:C8AIaSE93ID2sP8FqpI0kcM8AVcz0s074Cc4UsjOvY95TXU4YBgxKA>
    <xmx:C8AIaaMofx_Pu_qTqoU_oXaqGuNHVBue1TaeZQHYo_8uDrUoUWZNSA>
    <xmx:C8AIaZFAfIJFOcMXHwHPVd7KzBZBea0wAeKomBuwa4Q4r5w2hKUmiQ>
    <xmx:C8AIaZPNaOJmMdL8M2HioVAC9DkGhkKJN9RJougPjmqM2QXpJppWmQ>
    <xmx:C8AIaY78rcwOynM7jAJ0Y5lPViJ9FqCcc-CThL9b8DTYvNGbTDpy1H9B>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 09:45:30 -0500 (EST)
Message-ID: <2ffeb4b46910a5727c3642e7a900c4eecc3a5017.camel@pbarker.dev>
Subject: Re: [PATCH] bitbake-setup: rename 'build' -> 'setup'
From: Paul Barker <paul@pbarker.dev>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Mon, 03 Nov 2025 14:45:25 +0000
In-Reply-To: <20251103135759.1129769-1-alex.kanavin@gmail.com>
References: <20251103135759.1129769-1-alex.kanavin@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ax5WC4/xEQZqTDqQWbTu"
User-Agent: Evolution 3.56.1-1+deb13u1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 14:45:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18238


--=-ax5WC4/xEQZqTDqQWbTu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-11-03 at 14:57 +0100, Alexander Kanavin wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> After a terminology review by Antonin we brainstormed
> something less confusing than 'build' and 'build directory'
> for the place where bitbake-setup clones layers and
> creates a *bitbake* build directory in. People are bound
> to get these two confused and mix them up, and 'setup' is
> much more distinct and aligns nicely with 'bitbake-setup'.
> It's also not claimed by anything else in OE/Yocto.
>=20
> So before:
>=20
> top-dir -> build-dir (can be several) -> bitbake build dir, layer dir, co=
nfig dir
>=20
> Now:
>=20
> top-dir -> setup-dir (can be several) -> bitbake build dir, layer dir, co=
nfig dir
>=20
> This also updates the respective command line options, I understand it's
> a breaking change, but as before the tweaks are simple and we need to get=
 the
> terminology right for the users, and now is the time to do it.

Terminology is hard, especially when we already have concepts of "build
directory", "work directory", etc. I think "setup directory" is a good
choice to avoid confusion.

There's just one place where it reads a bit weird to me:
=20
> -    print("Initializing a build in\n    {}".format(builddir))
> +    print("Initializing a setup in\n    {}".format(setupdir))

Perhaps "Initializing setup directory" or "Intializing bitbake-setup in"
would be better.

Thanks,

--=20
Paul Barker

--=-ax5WC4/xEQZqTDqQWbTu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaQjABREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bsveAQCP5AIvuiphPDkJ8pQfiqzY70IlxPNkLJLk
/+PLNGf1LAEAtTdW3FiGCNpfi4HNdVF1KdCR2DHT8gEY4FmtK83wiwQ=
=VAKT
-----END PGP SIGNATURE-----

--=-ax5WC4/xEQZqTDqQWbTu--

