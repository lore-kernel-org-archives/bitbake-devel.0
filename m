Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F11AD49201
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 11:31:14 +0000 (UTC)
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10786.1765539072450971942
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 03:31:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=EXT2Ji8y;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=LEjfuwqv;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.154, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C90E140023D;
	Fri, 12 Dec 2025 06:31:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 12 Dec 2025 06:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765539071; x=1765625471; bh=CPv/rnpJVJ
	lpJPTmLPHTuJYSEolJGNpJNXOilNK8wUc=; b=EXT2Ji8ywgpVm0cA9eM8UFY6Qc
	hhjWMPv5SAuiMy2/R7zhEDIs8N5aTxD8pJ/6kmxjO/V2igeUjGJOsIR8Ra+nuRbQ
	DnXQy5MIVgH65mS/4PxWmB4kxrSe+JmXXcoeD3Q6det6OwkqQ8Gww1x5bLI1cWWa
	6vczirS4mafv8NPVxXOm1k9VgZNWbhYkX4tQg99eszkJRINxJzeTcHFctQ1zTxaf
	zA/LkpHvVZgNASr/DUyiN6m5ND9IOt9Rz4ZN8flUQAsCiiMF4Q75XFzgs+l3szYq
	GvfnysOEuHCJWEltjPK9QVZN89Eh9JhN8jy1vddUlHqAMoOfKKY8DNnL6vsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765539071; x=1765625471; bh=CPv/rnpJVJlpJPTmLPHTuJYSEolJGNpJNXO
	ilNK8wUc=; b=LEjfuwqvOxFlx6nOpdO0U7v11jMz8gdAm4HXorsY/SmXLBD1H/P
	tX+77J4pIw15Gnge67DZt1q6zO0LKZ0KrZjjmBlSL7V4/VVLG/YMwn9QW0RktAmU
	4fIR8q/LDKWX/uKR1xafshOlltSzE8XvCzwpyJPa/66z+3dVdsAOarLr73eqGTRH
	H81x8UPpJ++R1taRHU0BwI1kJ607E84so1LmYrqtPZFZBzkSyynZ3w7kjISYHzMd
	kPOZmBZXFaFeaOYe6a59V+Oo5vDGJCF3r2VtZP2qqUTmPdA0Gi/NQdfhfXSfZSj1
	6TNngn8fjUZLozQLeEPHqpF7ufNWnGF3+Mw==
X-ME-Sender: <xms:__w7abWKwCVamoVVxZK1CH8Jg_WU2yT8E5-7GjnD3CixtlNpLPNsdA>
    <xme:__w7abCkR5ZqcRv9uZPSESMmSQHMPqcHp2viw1ChdFR3zirJbQNfOTGdVx71qbZpT
    LWeBfSMvz3HoY_mYaewT170ABBtqHSik36Eao76eJYHihmx1hgcFPo>
X-ME-Received: <xmr:__w7aUxHNQFUapdSfkdJ0yL7jbv9ipq7VcnSzjg9VsnqjkagzxutPC3spX1PhSwVO-4OQqevUHTZk9C9GJC1SHQYlcO-UzilRFkCu9sedU4u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:__w7aQAnmOwj7mqO-YHBixoIVpdblngZtZr58vV3qKwPHVqMhhwR4Q>
    <xmx:__w7aZYWNM5iCTvMo-3A8jfl22mSgLO3ANqP5rFDxHXsLpe4Hj71Gw>
    <xmx:__w7aQjjUYkVsnT8hEx2n98KmphiCPhwKFYa4nI4vhrFuB3pB6Y6Sg>
    <xmx:__w7aT7kCbM87dbzAtW2Cus_DP3llhlMkcL7I9M40MKv4FHkqP_YUQ>
    <xmx:__w7aT23h3asLXESTnNTHTMV143-8TdOxFT2YsxD7ki9t2Gg5y5SrCM->
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 06:31:10 -0500 (EST)
Message-ID: <ef7d55279a74b6c9708fac6d9a770c7699709af6.camel@pbarker.dev>
Subject: Re: [PATCH 2/4] bitbake-setup: override complete source entries,
 not just the git-remote properties
From: Paul Barker <paul@pbarker.dev>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Fri, 12 Dec 2025 11:31:08 +0000
In-Reply-To: <20251211142532.983960-2-alex.kanavin@gmail.com>
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
	 <20251211142532.983960-2-alex.kanavin@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6B20LW2a4vs3Ssofa0uu"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:31:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18575


--=-6B20LW2a4vs3Ssofa0uu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-11 at 15:25 +0100, Alexander Kanavin wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> The code was assuming that a source entry always contains
> a git-remote property, and that is the only property that
> should be replaced.
>=20
> With upcoming introduction of local sources (using 'local' as a
> property as an alternative to the existing 'git-remote'
> property) that is no longer true.
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index b1d751899..8d4e9769a 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -323,7 +323,7 @@ def update_build(config, confdir, setupdir, layerdir,=
 d, update_bb_conf=3D"prompt"
>      layer_overrides =3D config["source-overrides"]["sources"]
>      for k,v in layer_overrides.items():
>          if k in layer_config:
> -            layer_config[k]["git-remote"] =3D v["git-remote"]
> +            layer_config[k] =3D v
>      sources_fixed_revisions =3D checkout_layers(layer_config, layerdir, =
d)
>      bitbake_config =3D config["bitbake-config"]
>      thisdir =3D os.path.dirname(config["path"]) if config["type"] =3D=3D=
 'local' else None

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker


--=-6B20LW2a4vs3Ssofa0uu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTv8/BEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bmUZAQDdYjHPNw7JWVb6Cj6hjk9IxVUqxvvSV6sm
DEnnUOuzCwEArRHJcc5suQoXG8xWpzmubJ24TI4RiRB7Y6DiGhiwQAM=
=+MNY
-----END PGP SIGNATURE-----

--=-6B20LW2a4vs3Ssofa0uu--

