Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2934D41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 11:52:34 +0000 (UTC)
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46842.1765799553089018227
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 03:52:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=t7sdMqOI;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=Wv/gjqKJ;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.157, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 560DD7A0057;
	Mon, 15 Dec 2025 06:52:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Dec 2025 06:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765799552; x=1765885952; bh=LWt9q0wWAh
	PxczDa8sbopHFqAuM7DiVGaQu6owIFbSY=; b=t7sdMqOIFpsm6WQSfAElS8rxI3
	rIJaOj32AT4BjkZAw5kSDXU+31AOaLoobnf/+6xSPajY9WPXzjND4aRKbT6yWyX2
	MGMEACQ56oJ1ED/liornptnBraKBCqQZ/BVtlCmDMzAKQABBA6PB6lVYDS9qO4x6
	gZ1C4U62n96PMBYvXdnwGVofy+cZX8tSamSV8bD1Kv6XX6Az5mwViWES2ITK4V76
	Zxj2fDjEfsCPALSW3GhibaCZ6OlAEPrlp4uNLCX9X4HxtJXnAElJjsm+3JZkzZJg
	N9N1WWGX2HBWkur+ih0bJP/CeqwetxNRoE54wvyZMNq1p3PuKENcAmMUXMWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765799552; x=1765885952; bh=LWt9q0wWAhPxczDa8sbopHFqAuM7DiVGaQu
	6owIFbSY=; b=Wv/gjqKJlNy+6HbGb7/W6zic3VuCXPQngNt7MyL5N+WDWn1xl8+
	F4jXwof54YAUWrzhC0HgarayQzo40PzUww8lO+NcW6k+h8O0NwhI2qzDHiBMYRaM
	O+1FmLTn+1iuMQihXWHBfL3wA7hRIsX/W+COaLmJ/cnhYdz/DWcnxwKI28XPpFqU
	90KZaqJCJP76p3lM1NC85MrcRRbKUxhQVsNw9kOBujdabiGtM9JoxU+xotsO00oJ
	hj/9rmjlLnjhyG+ZREV2Tr7YESdGStRxS1GEZTJUy6nV34LUD0mOFIcMGw0nnFlS
	BIgcd8WIxYEejP3CWAFvYXZUDpLdN0jR9bg==
X-ME-Sender: <xms:gPY_aUNHAtT4zMAbl9Bq8H-lfWGY0VpvLyOVZMCZGw4xHydmHYt-9A>
    <xme:gPY_aQ8pVvXo4U3zl0PP9F1RkwLaqDP8ddbedOwbA8JQJPXx6351hA3gXJwVS6SG8
    G1DRh8n33q3gjdnxZGCVXQ-4Exo8Vfas4vbealElclaOQaxdV4zAds>
X-ME-Received: <xmr:gPY_aY7rr-4paNF7_6zK-qhDm1DcXGjIweoG06O71V1AqseJsZgX-4TVmKL0NYIRRmRNbmx3vAgxS59rupI4wsHumlNrY6tUkXb7Ssw>
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
X-ME-Proxy: <xmx:gPY_aX0oSyH5jPAsn0Duisp3arUPAU6YLvdq0hj_WGYiltJErD3Pjg>
    <xmx:gPY_afAIY1YnZpORfg3yG9mS_981cyPxGZ9r_mqAPS1t0en8WyJv8w>
    <xmx:gPY_aZ1ZCr1Tqx06Byp5AYXZ9n2uqkTxq4UHx6szaFkexg2Ckwzqkw>
    <xmx:gPY_aZvoO2hRN7NjawDuexQjTCPpe3oAKYc1qd7teLuqBbM1AySRIQ>
    <xmx:gPY_aRe5JnXt3FS2lPCyWWqNvfcRLu1JU6wMX88QT-zj3uKtx7QkVOlp>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 06:52:31 -0500 (EST)
Message-ID: <a858e4bba5ee45eee8708288698f520566cd08a4.camel@pbarker.dev>
Subject: Re: [PATCH 1/4] bitbake-layers: layerindex-fetch: Fix undefined
 stderr variable
From: Paul Barker <paul@pbarker.dev>
To: Osama Abdelkader <osama.abdelkader@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 15 Dec 2025 11:52:28 +0000
In-Reply-To: <20251212190806.32476-2-osama.abdelkader@gmail.com>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
	 <20251212190806.32476-2-osama.abdelkader@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-z/ZEIZDWk0AZNnPjPGL6"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 11:52:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18589


--=-z/ZEIZDWk0AZNnPjPGL6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-12-12 at 20:08 +0100, Osama Abdelkader wrote:
> Fix undefined 'stderr' variable in error handling. The variable should
> be 'completed_proc.stderr' to properly display the error message from the=
 git command.
>=20
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  lib/bblayers/layerindex.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
> index ba91fac669..0ffc95822b 100644
> --- a/lib/bblayers/layerindex.py
> +++ b/lib/bblayers/layerindex.py
> @@ -58,7 +58,7 @@ class LayerIndexPlugin(ActionPlugin):
>              cmd =3D base_cmd + ['branch']
>              completed_proc =3D subprocess.run(cmd, text=3DTrue, capture_=
output=3DTrue)
>              if completed_proc.returncode:
> -                logger.error("Unable to validate repo %s (%s)" % (repodi=
r, stderr))
> +                logger.error("Unable to validate repo %s (%s)" % (repodi=
r, completed_proc.stderr))
>                  return None, None, None
>              else:
>                  if branch !=3D completed_proc.stdout[2:-1]:

Reviewed-by: Paul Barker <paul@pbarker.dev>

This should be applied for the bitbake stable branches as well as
master.

Best regards,

--=20
Paul Barker



--=-z/ZEIZDWk0AZNnPjPGL6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaT/2fBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0brD7AQCWVt7VyBwIJHmaarQfg5f5aDbKKMFeX2dZ
tG/gnvbcyAD+Ms9bW/51u543W0gi1ai+3GZAPJatv/svUpZ8/PmdHQY=
=RO0N
-----END PGP SIGNATURE-----

--=-z/ZEIZDWk0AZNnPjPGL6--

