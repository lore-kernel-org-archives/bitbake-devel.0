Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFE0CD4F50
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 18:55:10 +0000 (UTC)
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4656.1779130506698484022
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 11:55:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=bSQJEswo;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=U4lV3EaL;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.152, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B02C77A00A6;
	Mon, 18 May 2026 14:55:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 14:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779130505; x=1779216905; bh=AezZ6M6dae
	JDr40AQre3NgzFr63OBGJEfoTWhr7ndwg=; b=bSQJEswo3KFmrvoQR5+DRrAGJ9
	l83hgn1UQ0AYJSagKhL9cP4KwdzlpSZSlMTlj9tVX+Vz2P9zCQJoCnQnvZ5Ayzgg
	45ooKhUTz/YWFCC5LUfZPEP54EQjon2nXKNSGmHGqACnb3LJrGvMu389mLAR+7L+
	d/H7Q0rzjy3EaQBw+6ja5b+L/onoWThW3ejxam1s2q0k8kYiraNJXssfPePIWLai
	QxXvGe2N6s4DoqmkLiQ+1aUF6UclOJ++GUCfzb9VWEkwlOSNJuu+jZnJ8hYU40Fj
	ployb0oLfQm219IsZ5WvHsTuuhoKFTd1Phh6ECdc47GvzWlNsO2vFmFOJhdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779130505; x=1779216905; bh=AezZ6M6daeJDr40AQre3NgzFr63OBGJEfoT
	Whr7ndwg=; b=U4lV3EaLIUtvY1N9YaigImcjBz+Ax0Uh7eXk24Irc1Yh9DDcm06
	ftfMYnFN/d48qdWNsKgZuSNw5c60lbe32iz9gtV6gFiJocFIOS9GkREj3sSXslsj
	MOnW72fuqXPhXGXWzeFCojRK84T4kboz4cW/KA7jZIpFfN5O0pD56w1SmfGQGTmA
	FTi0s69isHpuYKBknktQDGO3Uz3HIBYaDUqLnjzXQZchRGpyIC1gFbAFnNuDzxhs
	/hA50jrhiLEKTOai2sHBrbhLH28KNc+FE3+c27VTXtZPEOabTCkFN4OYSvAy5tgI
	+LEfocgj2QTG8eZ/0rp8VJuB16Rd9FBkcdg==
X-ME-Sender: <xms:iWALagiUQPbfi8fN6Da6_t9hMEOu3CjGLBDJsvdEwdbjKcynUxJj4g>
    <xme:iWALav4dC2H6u-k7cr5hZBcThgyZXNv9FExWn71f_jwhsWZi9syRPscyYKqKfJQPA
    M6g-hP1nbEI-aZrr7mktuZyocoQ8jIjEI0TGzEjBL_-mbN3X6F2Zh0m>
X-ME-Received: <xmr:iWALagaM6NssdpbvdYGgcZw5yL9gH2VFyd-Lluahj-6sxDuBGqNWuozoMuOvZQ8ROQ_7cP9PrzuqHR1r1mlc89xkNPZtkYsL9GmqM3JfWzv->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epfffhgefhveeguedtgeeuhffguedthfdvffeliedvvdektdevieeiudethfevvdeunecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdphihotghtohhprhhojhgvtghtrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhl
    sehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjhhhonhgrthgrrdhpohhmrgesghhmrghilhdrtghomhdprhgt
    phhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguug
    gvugdrohhrghdprhgtphhtthhopehrihgthhgrrhgurdhpuhhrughivgeslhhinhhugihf
    ohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehnihhqihhnghhlihgrnhhgvddttd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigrdhkrghnrghvihhnsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:iWALas4s-l6ZZJoYxB13L4dEoqCMwNSU363Pdp59ELedryJ5yLv_Eg>
    <xmx:iWALarDkw1vwhUdvtcUKmQeoBbhKdwCUf9HjiwBYR9OzHfVIz83v6w>
    <xmx:iWALaqfYGojToTDQQNbPMpTlPnOSOiH2ekE-Ems_W_LuN33yZt4n8g>
    <xmx:iWALaiKRQfSN6Kvm1bjVtNLxJg7qBW0w4k6TydaQxEHOiV-58zb1FQ>
    <xmx:iWALaheFzdTiT4miSNAZ7TLd2hRBorm8bXVV8VNLimFir4aijpwoNwEA>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 14:55:04 -0400 (EDT)
Message-ID: <dd8c10dda0eec610d1084a92fa383fecee45c67a.camel@pbarker.dev>
Subject: Re: [PATCH] fetch2: honour PATH placeholder on cross-scheme
 PREMIRROR rewrites
From: Paul Barker <paul@pbarker.dev>
To: Jhonata Poma-Hansen <jhonata.poma@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org, niqingliang2003@gmail.com, 
	alex.kanavin@gmail.com
Date: Mon, 18 May 2026 19:55:00 +0100
In-Reply-To: <20260510-b4-yocto-14156-v1-1-b31433816463@gmail.com>
References: <20260510-b4-yocto-14156-v1-1-b31433816463@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-5WVwe+VSqZDNKolBsPhP"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 18:55:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19542


--=-5WVwe+VSqZDNKolBsPhP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-05-10 at 14:00 +0200, Jhonata Poma-Hansen wrote:
> When a PREMIRROR rule rewrites a fetch URL to a different scheme
> (typically gitsm:// -> git:// for an on-disk checkout), uri_replace()
> unconditionally treats the rewrite as a mirrortarball mapping: it
> substitutes the source URL's path basename with the canonical mirror
> tarball name (git2_<host>.<repo>.tar.gz) and drops the source URL
> parameters. That is correct for tarball mirrors but breaks the case
> where the user redirects to a checkout location using HOST/PATH
> placeholders.
>=20
> niqingliang2003 reported this on YOCTO #14156 (2025-07-18) with a
> PREMIRROR of:
>=20
>   gitsm://.*/.*  git:///mnt/datum/repositories/HOST/PATH;protocol=3Dfile
>=20
> For the input:
>=20
>   gitsm://github.com/libjxl/libjxl.git;protocol=3Dhttps;nobranch=3D1
>=20
> the rewrite produces:
>=20
>   git:///mnt/datum/repositories/github.com/libjxl/git2_github.com.libjxl.=
libjxl.git.tar.gz;protocol=3Dfile
>=20
> instead of the user-intended:
>=20
>   git:///mnt/datum/repositories/github.com/libjxl/libjxl.git;protocol=3Df=
ile;nobranch=3D1

Hi Jhonata,

This fixes the use case in the referenced bug, but is this universally
true whenever PATH is used in a PREMIRRORS entry? In the past I have
typically generated mirror tarballs, hosted them on a HTTP service and
put that URL in PREMIRRORS, so in that case I would expect the mirror
tarballs to be downloaded.

What you may actually want to do is handle git:// URLs in the target of
a PREMIRRORS entry, instead of looking for PATH in the URL.

>=20
> The mirror fetch then fails because the resulting URL has no nobranch
> or branch parameter and no actual tarball exists at the path.
>=20
> When the replacement template references the PATH placeholder, the
> user has explicitly asked for the source path to appear in the
> rewritten URL. In that case, skip the mirrortarball-basename override
> and carry the source URL parameters through. Existing PREMIRROR rules
> that do not use PATH (the canonical tarball-mirror layout) continue
> to work unchanged.
>=20
> A new selftest, MirrorUriTest.test_gitsm_premirror_path_placeholder,
> captures the exact niqingliang2003 repro shape so a regression in
> this area becomes a unit-level failure rather than a runtime mirror
> fetch error.
>=20
> The dict-driven test_urireplace and the broader
> GitDownloadDirectoryNamingTest / TarballNamingTest /
> GitShallowTarballNamingTest / CleanTarballTest / FetcherLocalTest /
> FetcherNoNetworkTest suites all stay green with this change (42 of
> 42 relevant fetch tests pass on master + this patch; network-only
> tests not run).
>=20
> Note for reviewers: a wider bitbake-selftest run shows 4 pre-existing
> GitShallowTest errors triggered by local git environment
> (commit.gpgsign + empty editor config); they reproduce on the parent
> commit and are not related to this change.
>=20
> Signed-off-by: Jhonata Poma-Hansen <jhonata.poma@gmail.com>

The commit message and comments here are way too verbose, please tidy
these up to be more readable. Please see the docs [1] on how to
reference Yocto bugs in commit messages and check if the section on AI
generated code applies here [2].

[1]: https://docs.yoctoproject.org/contributor-guide/submit-changes.html#im=
plement-and-commit-changes
[2]: https://docs.yoctoproject.org/contributor-guide/submit-changes.html#ac=
ceptance-of-ai-generated-code

Best regards,

--=20
Paul Barker


--=-5WVwe+VSqZDNKolBsPhP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagtghBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0buAMAP4szMihcdkarZ2Dl5rP26kPDwfPR0Ua3UKz
RsW13LXWpwD+ORrwT4trJbwIQJrmxbD2FLcLQzD9d/dsVXVHjQ1t0Qk=
=RY5d
-----END PGP SIGNATURE-----

--=-5WVwe+VSqZDNKolBsPhP--

