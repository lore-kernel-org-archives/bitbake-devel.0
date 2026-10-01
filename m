Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1018ACA5FA5
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 08:32:44 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6460.1790843555000980642
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Oct 2026 01:32:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=Troks/J3;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=x5jMPrkQ;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.145, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 06381EC0112;
	Thu,  1 Oct 2026 04:32:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 04:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790843554;
	 x=1790929954; bh=UgXdstgYBZ2wklYg7gJ0hRc57yrebfV7KZ9mQMew/Yw=; b=
	Troks/J3hLjojXuY9xXbdeMbMhHeMPgqPTmlwZCnQTQWlQoH1fPMplbjQnryPamh
	hDvr8FI7zjA7+DNsl/uIVkoB4rUu898U4JqyU0RwGYYA/aHUj5/Hssvz6Jm9Fwd9
	lyrHkfAG/mWm/cY7mNptAu9aVVJbkv9Ny4Csm2PRQAwam0e1yrUjdeii7WS//KGO
	gbsQQa8Jcp5AL5TfiHxfRz69fEW3sHJ+NSuseHvX55PFs0QaTA7RZI5AiI5HLDcI
	D3+3LEXpS2MqDL2irvZnOFeAyJYBG+fjBP24ieyYTUllue26dAM9/BmsInGXnuAK
	wy4As1u7vYRUie8uieYZUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790843554; x=
	1790929954; bh=UgXdstgYBZ2wklYg7gJ0hRc57yrebfV7KZ9mQMew/Yw=; b=x
	5jMPrkQ03VQVqz1F4aqMXXJXNwQEh+ivE0oJKfDGUgKS1b58FFdX0sfOmDUBbh09
	y5sAHw5VBF/fTVTLtJKfSdWuo5el8Tz+daKzT1zN7GZVpMUcdD5VhDoE5tFlTemb
	mH0xruBI22q4uNkKHNS5RizDxOeJaFv6e+v+asFV+Uu0n0x0dtdxX0YqYPUf1tF9
	E76W+KoGYrOBcB2qDK3DPoaH6+wT+eYUZR0IrdNGTbei0ct+ang/cqYJz7eiLOVt
	l72r6W1NV3XB7TCrXZhmLwG+MSmwhSyLeMlmyRvOb7CTyyddeGMMfF3cogVVZWOJ
	Mgsfed8+6xMb7PP7xHtxA==
X-ME-Sender: <xms:oRq-ak6OEZXZcid8pGLNGebeshW5Nf9G7mpNSiFrm9emRK3r5DpOzw>
    <xme:oRq-atWiDcS5STxIR-500OTvhK-crgKEczGEdPEjheNeyfMIUXZyG2mYsZqqIhgq6
    mPpDvJtNxgmWqn_0kitqPVgeZlLGLa4Jkn2poZ3QmnHouVd48O8CydE>
X-ME-Received: <xmr:oRq-ag2788BRJxyrX0-uf-NdKaRr3gVcWDKRmsbh5zkkuTfq-sVJYeGMFeqvEzBkzXaFgjqP-Yw_HJ5ye1-DoWGbOU_dECTWL4MxjRenjUrq>
X-ME-Proxy-Cause: dmFkZTGvltMEvBuZ0PIYmDyT5n8bdWdQeF2GBuZDxi4fA/jvyfWykqaIQhLx3dwj1hvwuk
    yX5/NwyzQdvR8zUzbpAevm6M0n5+Ey30qxJNz0XohzqUzzkM+wtCXNdSz6FfoLLQENm3ZV
    peBmMqI3Hx6fHWtWcsH+G+GvPPZf3JxFYBs/SZ5uH8Lo6J7GlUmZY34wmx4pLBunW5aZc6
    mhJtD+qKdhbKd1UC2dXXG+/TDXJoswzq+AWANU/dmP6uIDiQTPRyNBgEtLDAurSOFUNa5X
    1eM8XGpg+7XsFLNYc1Q+8C9mgSPxtiR7dQzYoUpcsIKpqvMiQUH+IVCDomWFSjuW/e1cQW
    H4Qwh4eceVN3ueKAc45eCNgFbV8sDF8F9vumH9NicOAKmLA1X8IxGnKKGdGaD/stY6t/Kp
    qAxqQeCMH1ZLm7msJyJtwoQK5YlD4LQ8B6+dDJj+Q+5YG9tun2NCSOEKm3+8lEPJCJF2bW
    Iu7A/EsuzZ/zVarQNXlqoie0CrYdT2XKHKfl94ye16kTmVanG6qkQY8z2rKk8KyeE9Qf+h
    0ptYZOw0qlLF5VMZHPJXuaa2jpE8eG43CPzdcwN8iAvuW6txOGJaTGn41JkLGAvg75nWrO
    i5HRnqv8N3TMtgHg33qB1qHEI8lbe672Ps+Fs7B1jXg4zRneombsN+WNmdmA
X-ME-Proxy: <xmx:oRq-ai3WmsCG961bV4FxqP4T89ERdF-vFBtS8XctHRfS-3U5pe0xMA>
    <xmx:oRq-ar8aNwCpvOViZ-8nDSxLnRSFyt9X0gHuJQa2QKZuPa59ethsgQ>
    <xmx:oRq-an1-I-5VOGjRTgSy4STqig0vsT4aqChNe6gtFD-MF4afb_SvUQ>
    <xmx:oRq-ag8z0LcDgAKU7Emwb6_I9akusOo-hMmsIy8Ba8EjUQAQJbb7dQ>
    <xmx:ohq-ahBq_qDl3ZcMbKoS8lGsAMnSQ6dBtukQELzYF9VHv2zTIQxZ18QQ>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 04:32:33 -0400 (EDT)
Message-ID: <abf12d51916cac8780914605168243c54494ca32.camel@pbarker.dev>
Subject: Re: [PATCH v6] fetch/local: verify checksums for file:// urls
From: Paul Barker <paul@pbarker.dev>
To: Savvas Etairidis <setairidis@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Jhonata Poma-Hansen <jhonata@example.com>
Date: Thu, 01 Oct 2026 09:32:31 +0100
In-Reply-To: <20260930212125.118877-1-setairidis@gmail.com>
References: <0aca7b91f894803dcb2e436d98ecb2c404c610d3.camel@pbarker.dev>
	 <20260930212125.118877-1-setairidis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Oct 2026 08:32:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20287

On Wed, 2026-09-30 at 23:21 +0200, Savvas Etairidis wrote:
> [YOCTO #9993]
>=20
> A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
> UNINATIVE_URL points at a local file://) was never verified, because
> Local disables the donestamp and so verify_checksum() was never called.
> Override verify_donestamp() in Local to check the file against those
> checksums on every fetch, via a new
> FetchData.verify_checksum_if_expected() helper. A mismatch raises
> ChecksumError before the rename/mirror handling, so the user's file is
> never renamed.
>=20
> Hashing directly rather than enabling the donestamp avoids trusting a
> cached checksum for a file edited with an old mtime, and avoids stamp
> and lock paths in DL_DIR derived from the url path colliding with other
> recipes or real downloads.
> The file is re-hashed on every fetch; this is a known cost, but only
> for file:// urls that carry a checksum, which are typically small.

We shouldn't assume that anything coming from a file:// URL is
"typically small", or that it is on fast local storage (it could be on a
HDD array accessed over NFS).

>=20
> Based on a patch by Jhonata Poma-Hansen.
>=20
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
>=20
> ---
> changes in v6:
> - Rebased on top of master

You don't need to mention this if it didn't result in actual change.

> - Fixed issues reported by reviewer

Such as? This is a completely different approach so it's useful to know
which bits of feedback were actually relevant and which were made
obsolete by the change in approach.

> - Check the file directly in Local.verify_donestamp(), via a new
>   FetchData.verify_checksum_if_expected() helper, instead of enabling
>   the donestamp. Fixes stale checksums for files edited with an old
>   mtime and DL_DIR stamp/lock path collisions

What does "edited with an old mtime" mean?

> - Drop the rename_bad_checksum() refactor, no longer needed
> - Document the cost of re-hashing on every fetch
> - Tests: use a correct md5sum and a wrong sha256sum in the mismatch
>   test, add a test for a file edited with an old mtime, and check that
>   nothing is written to DL_DIR

Why complicate this by using different hash algorithms for the different
tests?

> - Tested with BB_SKIP_NETTESTS=3Dyes bin/bitbake-selftest bb.tests.fetch
>=20
> changes in v5:
> - Rebased on top of master, added changelog entry
>=20
> changes in v4:
> - Rebased on top of master
>=20
> changes in v3:
> - Cherry-picked the patch from Jhonata Poma-Hansen

Best regards,

--=20
Paul Barker


