Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43167D3B7E2
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 16:59:33 +0000 (UTC)
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1782.1765213166460952933
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Dec 2025 08:59:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=vqLEdnF6;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=OfeHg+cn;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.145, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C59EA1D00221;
	Mon,  8 Dec 2025 11:59:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 11:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1765213165; x=1765299565; bh=cDlZ9BciJ8
	sETnVEGlt4yOmKvRNNPwAADjSVlIRdv0g=; b=vqLEdnF64KRDrlJUhfNqAGEbdX
	O4f0cNYAP+SEmxlGKm/wfdGpxMYgQkJ1SsF1RAuIn0um8pqKMfCUi1VnGtdNAr4w
	k30i1ve4SFy/XnuWLWn3QyA0J0hjEu1qMkyGLV9A6bUJfyc1Z2A0VlJrPRCfSb4y
	/3HQr6m+ybNojipkPl5V1ojLltO8g2KRSSRpLJpe12jn8pO29P+fYAsGx/2gyXKp
	2fhojv+DlrZZB18FNYSdcBMsCrnyw6ur2rfQV7izj8skbG6tuQY24foFxjm//S/q
	+UfY5TwtKI5hDHLyhihD1z8L7Zjl+p83qXU0PbO/u2cNjgIOOv6ItYvkksKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765213165; x=1765299565; bh=cDlZ9BciJ8sETnVEGlt4yOmKvRNNPwAADjS
	VlIRdv0g=; b=OfeHg+cnxDrFZ3Lq6PzwYc1AQHvxbtD0TZenZhV4fGulNZ0V0mu
	Ij1NC7otpbpfrO3EiF6y5S3VshzK3OLqiiVdI+CirAqBgYu92KSCUmOAmga9Xbkx
	0yrpA3eEJJucMoL5S6Iv/L8XDvvH29+Mjv3vwyCqZcIqkkKLvfz0YhRhUcegQQdA
	l7ksPnA8It2qGXjgsoDx5UmW23JWHs2lKkaTIBMY41et8bmm8gr3Laia35AEMwIe
	iVIk4tq7n4owo9v7Q8pEuQD8hc0Bsd/LsUAteaAJlMdqitICoGy0cVlCcezuZjKA
	/lZ96mj+53srCDbw21SP1TUd5VdNC9jLwJw==
X-ME-Sender: <xms:7QM3aUSkLE_schXAWTm-tXE8MRAs8Gxsm8NHz5ALYkeBSpA_EvfpNw>
    <xme:7QM3aXyo2hAFtQrS6y9TYl3c42YoyT0W_2KX8Jok8tTCCeIhXm0PJbtRXewDHi0Fn
    0hhrC3r2BlFkm0Wc4Y7gLM6TwrC4oSQmoM6kIMuGxuYtTpqVKEO-Q>
X-ME-Received: <xmr:7QM3afcaEq_CF4t_fpjx_O269rUGypauffxvT1Y6gFomIAGU1cCCsYkAMiQEsbNT1E-5ERGSp91o1kVUpwu7pb6eiPqjSuOBOMWd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfgggsehgtderredtre
    ejnecuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghrrdgu
    vghvqeenucggtffrrghtthgvrhhnpeegfefhudethfffveehveekjefhgeffgeeikedtfe
    ektdethfduvdffueeiieetffenucffohhmrghinhepohhpvghnvghmsggvugguvggurdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    gruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegtohhrvghnthhinhdrghhuihhllhgvvhhitgesshhmih
    hlvgdrfhhrpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhp
    vghnvghmsggvugguvggurdhorhhg
X-ME-Proxy: <xmx:7QM3aTKufQTXH40L9Ktn2aWZrnHiomlrGpYP73MyvgLMOfFUW9ktfg>
    <xmx:7QM3aQGV4q85x_AdDYFVjRegQgbAEx4BJUUBHsDCCVj54Q02QHegfw>
    <xmx:7QM3adpC3E1Du3xjIx4wakVZkz-8_mjBIAMrYzOenM8VyCwqBWGVmA>
    <xmx:7QM3aZQFZZMBa6S6prDv6_5OmNycWvIddZYUF9mJVnuUETbPx207Ig>
    <xmx:7QM3aQ3JdwGbbpdDX2cF4TWuq5pJRFxbhtumKmxTeFZq1oytyVVmJYzu>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 11:59:24 -0500 (EST)
Message-ID: <7501fc9f5b22984c6279f56b04f3888b34913d1a.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Skip AUTOREV management if no
 SCM URI
From: Paul Barker <paul@pbarker.dev>
To: corentin.guillevic@smile.fr, bitbake-devel@lists.openembedded.org
Date: Mon, 08 Dec 2025 16:59:21 +0000
In-Reply-To: <20251208161219.41335-1-corentin.guillevic@smile.fr>
References: <20251208161219.41335-1-corentin.guillevic@smile.fr>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7fMgmyGZtKqPqMPB0+C5"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 16:59:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18553


--=-7fMgmyGZtKqPqMPB0+C5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-08 at 17:12 +0100, Corentin Guillevic via
lists.openembedded.org wrote:
> AUTOREV allows to fetch the latest revision. If no SCM URI is used (e.g. =
git://, ...),
> AUTOREV has no effect. However there is one case in which a recipe with A=
UTOREV
> but no SCM URI will lead to a parsing error:
>=20
> ERROR: /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-tools=
/i2c-tools_3.1.2.bb: AUTOREV/SRCPV set too late for the fetcher to work pro=
perly, please set the variables earlier in parsing. Erroring instead of lat=
er obtuse build failures.
>=20
> This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) but is not ac=
ted
> upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI causes the
> srcrev_internal_helper() function to run, and read the value of SRCREV. I=
f
> SRCREV =3D "${AUTOREV}", then AUTOREV will be acted upon.
>=20
> If the recipe does not have an SCM URI, SRCREV is not parsed and AUTOREV =
remains
> unchanged. However, if SRCREV is expanded during the parsing time in Pyth=
on code
> (either pure or evaluated from BitBake code), then AUTOREV will be expand=
ed too
> and resulting in the setting of __BBAUTOREV_SEEN. However, as there is no=
 SCM
> URI, the code flow that would act upon AUTOREV is never run.
>=20
> The fix slightly changes the way AUTOREV is handled: if no SCM URI is pro=
vided,
> AUTOREV will be considered to have never occurred (__BBAUTOREV_SEEN will =
not be
> defined).

It makes more sense to me to throw an error if AUTOREV is seen but no
SCM URI is provided, rather than silently ignoring AUTOREV. Perhaps we
just need to improve the error that is raised.

Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI is
given?

Thanks,

--=20
Paul Barker



--=-7fMgmyGZtKqPqMPB0+C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTcD6REccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bltgAP4/Wgb7897d6OcKjNKn6ZpxatdhhLiCT34T
rnS+3nXcPgEAsZqGcJa3/Hfksgq/r/kFp8C7UkJM3IGRLGoAOqXowQM=
=0jGZ
-----END PGP SIGNATURE-----

--=-7fMgmyGZtKqPqMPB0+C5--

