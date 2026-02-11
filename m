Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436BE9E2F0
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 11:56:46 +0000 (UTC)
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17334.1770810999925166472
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 03:56:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=WnrXpu4r;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=AbX7+TC7;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.146, mailfrom: paul@pbarker.dev)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B50D51D00189;
	Wed, 11 Feb 2026 06:56:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 11 Feb 2026 06:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770810998; x=1770897398; bh=J8EQKLvWx7
	vyMN9hehXTQR8ty9ZXuSv8/LKzjJZWFbI=; b=WnrXpu4rGsjaYPzr5zWAHXKu96
	tAqnw7Cc10exWsf5dBm2TQdnnIbSeQ+/yqa6DnZFtexLbENygMWJ9ipkGHN8K+F6
	X6UF5iZ5cQTjIYl1JoGdcwus0pMg3D5EEhnxu2NvQC8snz456WSyQQ2hbsuQaAmU
	9zRaivy1yMVHD2j/vOMdsl/uq/5df9xDgaZgxKymF6Q3EUBK7ZV/ip6QV9ToOSZv
	UnoSS9B4I620Hk3dK78CJB9SNDUNsrFCs6sIH8F1ITmZzJDe4NgAJ8p7PJxkKqA0
	5plIJyX2Avc0B3ZW/EpHSNzv/1HkFOC9g32JHSaGyXu7HVRe59Zozukj5Y2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770810998; x=1770897398; bh=J8EQKLvWx7vyMN9hehXTQR8ty9ZXuSv8/LK
	zjJZWFbI=; b=AbX7+TC7et9kaOJhBs3alRrIq3GAKaFkjT3nVkTkp7wLM+qg4fx
	/FKavKPx9HYhrnrixd+RViHzmolm/tnSaRZ1l0+5dLmrSPjrzAQvrAEhVHP4F8FG
	reOGB5UOxNoSCaNQKCn5vfHOw2ZRyG5vwNgG+cGOLbmsDDR9g4DRkSCCbJN981vY
	gP3ZSeYLqbAEIvAwpexxP/h5ZXq3/AktXJsUmSQXEq3r2IEuTNRX6ivR2lBKLpX5
	6TBrcH7LCFG0a5DzMAKGyEZlnaH54RkfSz54zuremARZ0lWgfnwyXI7HR9o/Ywc8
	U+Ej5yg79JERtWu8j/ONINLE33hR41mrlNQ==
X-ME-Sender: <xms:dm6MaVInS2Sjwik2nq_fzxsoOJdli2VLEm9zyXsVEC76ko1rrsTUOw>
    <xme:dm6MaXIJf20KHGpoQw53rPrKb8e7r25z4mrl-kK3G23ZIF_GFMWUgEyYKiHlWaBaw
    iudVLfpxVW002Nxblhc-dwnjWODI0FTd1rtgDnsNQXFAcIUf-tryLs>
X-ME-Received: <xmr:dm6MabVn9IbXiG9yZ9KxJANr-PiX0WM18LUIz9xvROpjHKctrGTEKA4ZtXSZyZJ6s6MJq4WmAJvELTI4Oas69B3KwAOsA6QE1xZICPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggesghdtreertd
    erjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepfeeileehudffvdeljedvgfetieeugfetteekfe
    dtgeeggfevtddutddvheegfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtth
    hopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehurdhklhgvihhnvgdqkhho
    vghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvg
    hvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:dm6MaRgP88MD1VE4pt6DarZoBlbYW7EZ9qo-Hqvva6ZKaihMBhlwHg>
    <xmx:dm6Mae9683GnjLSQJKJ8YuCQdHK7ZnpSjfTMzd0Ru8t9jNJ3iA7aWQ>
    <xmx:dm6MaTD9CXkvdfwQcyvex88E2T0E5BS25ZiQ4wac-MX6wDFXQvIBaw>
    <xmx:dm6MaTKgjmbRwULUeApX3PNzRQPmFxY5Ic06g4BbCjt_DYwEUC8AUA>
    <xmx:dm6MadiU-nwE8xrkAiKZmAEUSSikI2Z5l6fcpSaA6f6yO0pnKoWeHwjG>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 06:56:37 -0500 (EST)
Message-ID: <5bcaffcd860a42d9b0d28d6eb43b58ba8ca6c4f2.camel@pbarker.dev>
Subject: Re: [PATCH] bitbake/bzr: Drop check for unset .revision after
 .setup_revisions()
From: Paul Barker <paul@pbarker.dev>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 11 Feb 2026 11:56:29 +0000
In-Reply-To: <20251006140246.2459639-2-u.kleine-koenig@baylibre.com>
References: <20251006140246.2459639-2-u.kleine-koenig@baylibre.com>
Autocrypt: addr=paul@paulbarker.me.uk; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gP5HqWp1ORhjcmP90UWA"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 11:56:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19002


--=-gP5HqWp1ORhjcmP90UWA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-06 at 16:02 +0200, Uwe Kleine-K=C3=B6nig wrote:
> FetchMethod.latest_revision() expects three parameters, so the call
> `self.latest_revision(ud, d)` triggers an exception.
>=20
> Drop that error path that obviously isn't used.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> I didn't hit this exception and only noticed that problem during
> research for another problem. I'm unsure if deleting is really the right
> thing to do (i.e. if .setup_revisions() always returns something that
> evaluates to True when interpreted as Bool), but it seems nobody hit
> that error path since commit 7b7a4517c600 ("fetch2: Allow multiple src
> rev to be used in one src_uri").
> (Hmm, maybe the author of commit 7c94ca56b2fd ("fetch2: Correct a few
> calls to latest_revision()") should have noticed ....)
>=20
> There is a similar issue in lib/bb/fetch2/hg.py. I'll postpone sending a
> patch for that until we agreed on what to do here.

Apologies, this patch seems to have dropped through the cracks. Feel
free to send us a ping after a couple of weeks in the future if you've
had no replies.

>=20
> Best regards
> Uwe
>=20
>  lib/bb/fetch2/bzr.py | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
> index fc558f50b047..443195fa00bc 100644
> --- a/lib/bb/fetch2/bzr.py
> +++ b/lib/bb/fetch2/bzr.py
> @@ -35,9 +35,6 @@ class Bzr(FetchMethod):
> =20
>          ud.setup_revisions(d)
> =20
> -        if not ud.revision:
> -            ud.revision =3D self.latest_revision(ud, d)
> -

Looking at the git fetcher, this should probably be fixed to call
self.latest_revision(ud, d, ud.name) instead.

Are you actually using the bzr fetcher? I'd like to propose deprecating
it then removing it after the LTS release.

Best regards,

--=20
Paul Barker


--=-gP5HqWp1ORhjcmP90UWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaYxubREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bqaFAQCVjwSkmpbSzsJDnXKkNcPvAhSUUAlNsXju
amw1mnCnMgD6Ai1p8sHxvUP8F+a00+SuHLZcSN0cXsaLouuYGac/hgc=
=6bpv
-----END PGP SIGNATURE-----

--=-gP5HqWp1ORhjcmP90UWA--

