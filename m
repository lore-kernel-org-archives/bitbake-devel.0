Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E2D3B7EA
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 21:40:18 +0000 (UTC)
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4478.1765230015727101605
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Dec 2025 13:40:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=sHrF1SBE;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=ZdZ83tuV;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DB70DEC06B5;
	Mon,  8 Dec 2025 16:40:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 16:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1765230014; x=1765316414; bh=ip0wvUUxtA
	8dyFoAAADPBuFZRPwyJjC2kSx3G0YuRNk=; b=sHrF1SBEDEAT4p66EVbYNmFH2T
	kHHH9pMrHMb+MsM1H18tUb8BYTigMsGQluFZ4ZVO479+TGlHutWvZaDlQQmNYHiL
	/QRU5BCVlKmpWoYGfv8WUPpIhBFNkMztT0Igfdz33svcJ85ma3fME6f49poDpubk
	1+vb+06JaGJWauZ/fOAOUl/fv8rhP9YlOxs2Zno27pNq5weIv5iLFirgFt7w/f5s
	IqKc4+ncIbf50yql8lxM/tg/snGZcK8ZWx8/NAjNqAfKcua1DUuY5xK2KfhfpPTY
	2weqPzeUZrhC1UNhiw/Lbe3JYcG7yyrya9b686CjVsA7z5ajjGNE6z5p0ftQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765230014; x=1765316414; bh=ip0wvUUxtA8dyFoAAADPBuFZRPwyJjC2kSx
	3G0YuRNk=; b=ZdZ83tuVwwIbYOR7k0o7sIUSj5cOi3SK5U+vw/Am8DUna+2Eujh
	NxdJScjW6dlnowFVTVCzj3ilU4HqsjbIsMknGynRgeZx3ldMUgXOI0eluLbYMV2n
	uU3VNkTMpL5YI5tdWp42rVeBMD3LzAv90vlFSe/bziUp0Xpbv/6G2W6WlM5CBw9H
	Q6AYfO1xUVRgJccU1SbbKpLBy9YkmAwWh0RDbwu2uikEtIj3Tt/27vWgtoH/sQui
	Kln2rTokku5+FdfGjJaGr9mmCr67U2Hwy6WA0XcOgnWD8aRPz6Jeypd57osxa/22
	KY4v8Ve4Uv30NwvnoiiRlIX7hZg9pYpw0rQ==
X-ME-Sender: <xms:vkU3aSfVHgqHK1lqZP91qGGiZbVR6MeKuGaVKJFUW6lJtGYVgDEEfw>
    <xme:vkU3aSNrKS0QjcUyLjy7MEXWzTQ0oHLsB7vTl0SNkf8AKCtWIB9ljbF0eWmQtRBkU
    sEEwX04KxQz4tLx89vnTW0YziwmumhYc1f8YwW4L0wf9bTcokb1yrM>
X-ME-Received: <xmr:vkU3aRIGccMZGkmImwYHVK5mnRb5LSN3zKfMSB3MxACsXBdN0C_LqBWfcKrtXnQYp-9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:vkU3abEKBh_G0gblOPmrLm1bEYqgzlQGQue8LW4czmdPYHTtBj5C_w>
    <xmx:vkU3aRQRIOa3sEcXECtyQxAd1k_x4dcCPQb3fUL0Gq1OUi_JlIGmSg>
    <xmx:vkU3afEoB39SVOHAjImk-ZI72u63hIe23Pgalvlra-jlu1lDlb85LQ>
    <xmx:vkU3aV-nlRxUPhRfBW9rTf4aO4gs_I8Jsbl6dRoJ1sKm7Gh0kK0LGg>
    <xmx:vkU3aXujoE5-1ehwJ-NpD12MiTGmoUfDTZpfyNpR681Db3fYnSNDkbBe>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 16:40:14 -0500 (EST)
Message-ID: <8d1e305bcbc688ca77aa88284bb8be982554971f.camel@pbarker.dev>
Subject: Re: [PATCH] bitbake-layers: layerindex-fetch: respect --branch for
 already-configured layers
From: Paul Barker <paul@pbarker.dev>
To: Osama Abdelkader <osama.abdelkader@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 08 Dec 2025 21:40:05 +0000
In-Reply-To: <20251101135651.26560-1-osama.abdelkader@gmail.com>
References: <20251101135651.26560-1-osama.abdelkader@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-J7u0XDCNhY5V7ykRUoMg"
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 21:40:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18556


--=-J7u0XDCNhY5V7ykRUoMg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2025-11-01 at 15:56 +0200, Osama Abdelkader wrote:
> [YOCTO #7852]
>=20
> The layerindex-fetch command has two issues when --branch is specified:
>=20
> 1. If a layer is already in bblayers.conf, the command exits early with
>    "You already have the requested layer(s)" without checking if the
>    layer is on the requested branch.
>=20
> 2. For layers in bblayers.conf (cooker layers), the branch checking code
>    added in commit 138dd7883ee (2022) never executes because cooker layer=
s
>    are skipped entirely in the fetch loop.
>=20
> This patch fixes both issues by:
>=20
> - Preventing the early exit (fast path) when --branch is specified, forci=
ng
>   branch verification even for already-configured layers.
>=20
> - Adding branch check/switch logic for cooker layers when --branch is
>   specified. The code finds each layer's git repository and calls
>   get_fetch_layer() with the requested branch to perform the validation
>   and checkout if needed.
>=20
> - Fixing the branch detection in get_fetch_layer() to use
>   'git rev-parse --abbrev-ref HEAD' instead of parsing 'git branch' outpu=
t.
>=20
> - Fixing undefined 'stderr' variable (should be 'completed_proc.stderr').
>=20
> This completes the fix started in commit 138dd7883ee, allowing users to
> use --branch to switch already-configured layers to different branches.
>=20
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Hi,

Thanks for the contribution! Apologies for the delay in reviewing it, we've
been focused on finishing the 5.3 release.

This looks like a useful change but it's difficult to review in its current
form. Could you split this into multiple commits? Based on the above detail
there are 4 different logical changes here so we would prefer each of those=
 as
a separate patch.

I'd especially like the completed_proc.stderr fix to be isolated as it
may need to be backported to a stable release. So this fix should come
first in the series - best practice is to put patches that fix bugs
first, then patches that add features.

I think you'll also need to apply these changes to the bitbake
repository rather than the poky repository to remove the unnecessary
'bitbake/' prefix on the file paths.

Best regards,

--=20
Paul Barker

--=-J7u0XDCNhY5V7ykRUoMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTdFtREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bkU5AQDrDLv/ghjXjOokd6AyGM2/0YOtuHSZQFr7
FjrkI7ajPAD/ce7WC8vSkYcvFdDrwsoUbTR04SjGUyjXwO6zsphrYwY=
=+Qbm
-----END PGP SIGNATURE-----

--=-J7u0XDCNhY5V7ykRUoMg--

