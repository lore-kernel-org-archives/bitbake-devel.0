Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C67C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 09:06:25 +0000 (UTC)
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88229.1782723979935413123
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 02:06:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=auwINex4;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=EBSJCBHt;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.145, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CD971D0007F;
	Mon, 29 Jun 2026 05:06:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 05:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782723978; x=1782810378; bh=GyoeUOYfji
	cDUdii4lFKb/WmcJybLK5neYrxX9f2jYk=; b=auwINex48gdRx2xuxlnk8CvfqD
	dJa0CdG7UsWFiF8XVifULAO9hT2DNo7aeXX8cHsG+e7brd2RmyOEgX1d7ODFZc2p
	l29JT5CdSbucWbVtaP9AFVeLSUUq3e12FYsnIMRqe4k3hjCTvRhmBLLvyBrN/tIP
	+o5FKSaOxGpTJMRq7tgX+BpuGJU6jU/caLmTC2/VTOQVxIFcsng6SvKJv+7TEDkr
	9wO1KV4hD0WAePyxiLor+s96iMyK2KLnQKXfW1x95LJMMUurSO8T/9NvE5Az5ZNp
	UsLuY8/3UAfgcxcRayM0w71QxMsFlqb4Ez/Zrui+Us+j2u4CFskgUkMU9A/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782723978; x=1782810378; bh=GyoeUOYfjicDUdii4lFKb/WmcJybLK5neYr
	xX9f2jYk=; b=EBSJCBHtwvHm88V31eSGK3WPR8aH7Oichh2TIXSdOgpIU+uvk8x
	6e+grrhDjEXNuRpoUiE8qeqrHUV16mx0N94kMg6X4m3ettv11C/l8sdHN7/Sj7Sn
	GvbODJi5HdT3dXR0c8HnVEl8kpvNfAWk/QmnWVYFBvlsc86NNJTzhbiDmUzNV0H/
	Sv9ASV2Msb8b+GTBJtHTpz/zWBx3K5CxFPtaSy7KDbqp45ImlGDn0nblZsl2T3fD
	F2jO+eNZvhGgLZcBFddDAKuhcCuyFKcO/YhZ8HJz4U5om9fmUMyaf639uTwh5T0x
	DtsPtyUDoB8ypgMDQ/bv1Y7NxZcCq3Srbag==
X-ME-Sender: <xms:ijVCaiiA_s4BIKWVb2Fr6Ccy0TQ5xQD2_8Ws9oZ2ddOYOyelpEmSxA>
    <xme:ijVCaqd4MlDPFSGltimcCwGZ_VERjRPy86XJPj_psUCPgYT8RXgY0byu7xDfcFc8L
    asF8CZrXMSA4Tr38qMOe6cJlQdJ3vZPzuvTLY50qRFjwsPQ4XQ0ZGml>
X-ME-Received: <xmr:ijVCandxVb7vPzpj127fsWjsNsfCgBqZ8qrRkzTxhsOY6xE4OhDIHDmuR1av93cD5mk7bEoA4BpO3z-PRzPZQDT4ujWrNIEL9EWCQ7w>
X-ME-Proxy-Cause: dmFkZTEfo0zfjOIX4ggxsGUjo9sK0a5ldyZe3KfzBOWm1cm0EMrR5oE5V4GATSe484yqbN
    PUvGAbGfi+yj8AWutB21nwmJhcbk0Ts56L7JRnuD0FkCau+2djw03BNqLEddwyrt057vyH
    lbcKYwdCZ9xcJYW7HY0UlxHNXcaryHHXsxeNvFm78bLMM0S67UG49SVaOehQ7vl4xPG3BO
    CHevklFkcwwLCeJm7CxSkaAROKmmhaAz71PLslMSj/KZNPITJnvPDW9L6w72iWLSCxqITz
    Pe5q0vkWrbJhIM7kLzgoZ59IIo/496akRJFMkeRtGDzHcLMWS1vZxYKW2I4X3Lj8MVsufl
    rKd2D83g1Ph+xzMX6B/rWQElCUfyXYFkZr3/zPeA6LuMbc284SEUHw2iJ+tDdqjeS0blwv
    70nbPP0VxNyDwlFHZBncnKkePDh0DItDeUySkLudoLeYkogVCG8ZOTQxJGNGDuvvx464f6
    uOo/BqrzBiwMhT/tXZ6IS5YaZ3y1dfyAhQWAxuzEY5TYhhm25Mzm3tfegWTkjCjcUcc9Od
    SsY5+dh7iFldYzy5PJxn6QzC1Ea0c/hToXEQkhT6OyKrEz8jfxEOGmrjUJLapFedyTlkki
    e7OSKRX3yEj1nb/x44ieoceUngsPk0Wjblqi9yG91HDwix5bbZLEgaNdSjuw
X-ME-Proxy: <xmx:ijVCak-90IJonTmA1uGjym-e3vWtWb5H3TKA24nUNWLwNXqOOKYBEQ>
    <xmx:ijVCajkQK67VrflMf8QBjieCdMUEz9Yx220oh0OXx79S1omZ9oCzMw>
    <xmx:ijVCam-fBkYldr865OtoyPDYfPRkDyHrc_xNG_0D3S6D3exe4stHnQ>
    <xmx:ijVCahmmNm4PWsugAsxjw8w6IQSalX0MG6gaVUUf0POhq8_bYL0QeA>
    <xmx:ijVCaufqJs2JH3LwgK7PY8X680s_9c36kCBt_oNtulLE7mFqQIrUXx9F>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:06:17 -0400 (EDT)
Message-ID: <638e859d9a5d3c4c53b8f471930f11a458c20581.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH v4 00/11] bitbake-setup PyPI Packaging
From: Paul Barker <paul@pbarker.dev>
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 29 Jun 2026 10:06:14 +0100
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-13GVg1Nk9BYYruQ1WNxE"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 09:06:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19804


--=-13GVg1Nk9BYYruQ1WNxE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-06-24 at 10:20 -0700, Rob Woolley via
lists.openembedded.org wrote:
> This is an update to the previous series to rebase on master. It is also
> available at: https://github.com/robwoolley/bitbake/tree/b4/add-pypi-v8
>=20
> This version of the series integrates the vendoring module to update
> beautifulsoup4, ply, progressbar, simplediff, and typing_extensions.
>=20
> I also included Richard's latest commit to add version variables to the
> bitbake scripts and dropped the mechanism that I proposed.

Hi Rob,

Patches 1-5 and 11 look good to me.

For patches 6-10 which improve vendoring of upstream packages, I think
we need to document things clearly. I've also made a couple of review
comments on some of these patches.

Looking at the Python vendoring module [1]:

    Should I use it?

    This tool has no stability promises -- it has only one intended
    user: pip. There may be unannounced changes to this codebase at any
    time, as long as the intended user (i.e. the pip project) is
    prepared for those changes.

    As a general rule of thumb, if the project is going to be a PyPI
    package, it should not use this tool.

    Many downstream redistributors have policies against this kind of
    bundling of dependencies, which means that they'll patch your
    software to debundle it. This can cause various kinds of issues, due
    to violations of assumptions being made about where the dependencies
    are available/which versions are being used. These issues result in
    difficult-to-debug errors, which are fairly difficult to communicate
    with end users.

    pip is a very special case with a thorough rationale [2] for
    vendoring/bundling dependencies with itself.

We need to write down why we're using vendoring despite this warning,
with a rationale (similar to how pip documents this).

We also need to document who's going to run `vendoring sync` and how
often. Do we automate this or rely on running it manually?

[1]: https://pypi.org/project/vendoring/
[2]: https://pip.pypa.io/en/latest/development/vendoring-policy/#rationale

Best regards,

--=20
Paul Barker


--=-13GVg1Nk9BYYruQ1WNxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakI1hhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bmFIAPwPiAjvosK57lpKDLfK4x5odsUsQto1YQrY
4EnYfycyPAD+JU64nNTl+zX+oznNdvhV3ZHTWA9pG6+84rxMoz4I/gc=
=vO5H
-----END PGP SIGNATURE-----

--=-13GVg1Nk9BYYruQ1WNxE--

