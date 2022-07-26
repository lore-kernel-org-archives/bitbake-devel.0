Return-Path: <patrick@stwcx.xyz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60530C00140
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 16:01:54 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web12.8598.1658851312032899881
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Jul 2022 09:01:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@stwcx.xyz header.s=fm1
 header.b=GtfW99P9;
 spf=pass (domain: stwcx.xyz, ip: 66.111.4.27, mailfrom: patrick@stwcx.xyz)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 54A615C0112;
	Tue, 26 Jul 2022 12:01:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 26 Jul 2022 12:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1658851311; x=1658937711; bh=GDUbBpww5S
	CaOhQYhaVS7UwKfEKHy7zNGthAwh0iOVA=; b=GtfW99P9R6fCd/YJ6q3Ch4rrHa
	YTquVy1VujojKvL4gNSAoQ0vsQQ/t26tfG67+KfiM+hSnyUJ7ts8r+EkDzOlylLD
	Nso0GWok4zfYvyVKHbEAlwFoWlG2UMhNRTZsSZQnFW9t9ZdgWATygEyifsftUfDb
	FZtXX9TWEfd9NLQw4NAnXyr2U8oojbPFyku9XkBq71cC6MwrRxXsajoPKYgzr7uK
	r9a6rgmicO4EYwyyL6PWVQyBJNh0sdUvOQgjv+LGKmu8jr8inHLBb3ikzBVL+u+Z
	4fbIHlEAyMA3lxjpHCSITdPwQc6kSftJtzfuD4XCDByOi9O6onSPMgg9wZ5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1658851311; x=1658937711; bh=GDUbBpww5SCaOhQYhaVS7UwKfEKH
	y7zNGthAwh0iOVA=; b=A+u5Dg+aNyigYVrxB3ONlWAhTigI1JzMUhm27yJTurrg
	oqb9M2svQzS30i+h4bDmmkCtBdDG/gDu2ut3IUFSBVjbra12V4iAVFpmhZ+SUgbD
	U9pbk5D9/P8oplyHUbPjiqUOOYz2ThS23XgzX7tHQ/iC8t/U6x07psMKdLyUANBf
	4f4NcT8nGlvWst89aLjArb2lf2hswwq0oEQI3zCeAjZoD6lEIQ8ZkcAQl1oeBrNW
	HANjIgFH0lSwki3lsPsfXumGOjLxr17+ZuJxWdBnY8rtDS2FHGWfjA+aTohiecwC
	hmYmb5pE+piU9MJMdyHS1Q+LvCtZv9og3AU/gJAxkw==
X-ME-Sender: <xms:7g_gYudP2-XsRgiLPLN61lAyh9l8PdqfutQT9UZiMVLXg-c21ExWcg>
    <xme:7g_gYoOrFCv77XH7RpWiVpaLSZLDDIEsuvdoHqbyJbzAA3OOzFhcP_sc7m7_snE7K
    6U2eyG4sYGDl60tY4A>
X-ME-Received: 
 <xmr:7g_gYvgQCZi5gSFN6MTaW_ibhPdzTHOEd9bvgSItiBQBdVNRkY-qpewmAdDw0pQLSdo52SCvKbOFNDbwziih1I4HVyQ1nFlp>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:7g_gYr91ntryQ9jqiDBHGzUvHSfsDcCDz7ctE_fG_Kvrwg189aGulA>
    <xmx:7g_gYquAmd2qcj0IbHseTS8WQDL5z6ofwSOEIa4-pGEufTovbJybiA>
    <xmx:7g_gYiEHgKwV7NXS_8A35W87Lt7Evqvw_tLPvXFTy_fv_suqNHHHqQ>
    <xmx:7w_gYvXZgFrojsZevM49EiDDd7YZMMEEao3F9d0xOQ1SrWPOKDYh3g>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 12:01:50 -0400 (EDT)
Date: Tue, 26 Jul 2022 11:01:49 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Paulo Neves <ptsneves@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] fetch: bb.fatal when trying to checksum non-existing
 files.
Message-ID: <YuAP7QK8YYLjp9Sh@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
 <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
 <8cbc762227c6c5223004d7e457dff8f3da683a2d.camel@linuxfoundation.org>
 <CAJO0J4g25ypP_RW=pN76suM1z15VEh9cdOsxqfNj9-C_xW5PcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fnLqhLDhXE120UeV"
Content-Disposition: inline
In-Reply-To: 
 <CAJO0J4g25ypP_RW=pN76suM1z15VEh9cdOsxqfNj9-C_xW5PcQ@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Jul 2022 16:01:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13854


--fnLqhLDhXE120UeV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 09:01:31AM +0200, Paulo Neves wrote:

> > I'm just going from memory but it might help to set COMPATIBLE_MACHINE
> > in the recipe so that it isn't fully parsed for the machines it isn't
> > intended for.
> That is what I do. If the recipe is machine specific it should be marked =
as
> such.
>=20

Thanks for the info.  At first blush it doesn't sound pleasant to
maintain a list like this for each recipe (since we have over 30
different machines), but we might be able to take a tactical approach on
specific problematic recipes and/or leverage some overrides to better
classify the machine feature that causes the recipe to be necessary.

--=20
Patrick Williams

--fnLqhLDhXE120UeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmLgD+0ACgkQqwNHzC0A
wRkcSg//VLWQqURnNTVAn0O4TI2usE937Vqdjy6+V4qT5SjqA3vVgQPah2MVlFgd
IutbFc0oVG6mtLGleJMENUhxGnrXELIrB948Xkh0mckYYjvZS5IRj0D7wd6cTIyU
EyMn+l0dfNcFoHCpQECDsScakBfuZvxAykCipHF4uTEG5mBUfdmnx75tB1xdnvdd
31RyrvuXs+kns1BOSyjjc4Lw6NDG9CA08RTRse6LDV615z4zeloPkazsPE5F7838
JT0H/KoIGa72ifPcHed8uQbCCFDgLyqGaUi7cfnrI3J4d6h2yPBOMDdLbmtEFBcI
MjwaL7obHF/5uYUYO9XMkL00nbj+8JchCRt1hOGJmvJCVjCyzXpxzE7udQqaMa3n
i2nnbPN/jPov7LUG5vuBiT6z4cIvK9DNjPSiJER247V0+XFEYlgs/ol7GTyXAZzo
V+3E+sq2WVhY3z5JeC6eE3kLD77yl5VdLovp5OCHNix9a4X4TC59moW3qrBTaaJL
5cR126dlDybfruDdja6C0O6xL5Jhk7IZH8wVgsj4GbDbkapYanvkPu/zDKbpXXsy
xh72Ptyx59CU/G2PcRjWq54fLpnxXWYH+FVAS/vDOMSZbavBUgF7g6DaY+y3Qhoa
X//KCXA8LB1qmAiNhXtq69x4lMGG4AhYQ4FTYm/lPPqWpyJLgPk=
=+7lE
-----END PGP SIGNATURE-----

--fnLqhLDhXE120UeV--

