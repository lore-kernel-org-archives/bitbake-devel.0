Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FCBD70DF2
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 19:39:43 +0000 (UTC)
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.849.1766086773057575794
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Dec 2025 11:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=rkvWfTh7;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=ld/0EeRf;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32F0B14001D5;
	Thu, 18 Dec 2025 14:39:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 14:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766086772; x=1766173172; bh=44hLIHlMdD
	vZPgRjX6P3ZRCLYRc7Gg/5eqDAWfy2EDI=; b=rkvWfTh7NIFlvYhQ4VAYCxXvO2
	bZNOHzU9uLZ5HQu8s1+kQ2BQX+rQtmdSdARU2Kg8vdgyXFipWzRxJoW7wKeD9CbB
	dNEDA+htU+/+rYX7qq2lRe54lHexKugY/+/8zD29mKHsYeYA/W95gBs9Sy833iBB
	XclixtV3swUCgJ8Lh3VlybEk6toxNBIyL6I+mxLlbSXaqsmcNRLCAe/lEXAkAbhv
	w2ZvxaJL/Qo71hrUxlxE3fY1LFFwJGP6LhKkS9ktos0s5eEnXP5mQPiAvqzvQWv8
	fzJxCq11AO0bkvNfs5kRTf3Ph2BdXs1FKzrBywev/XqSNeJjvvgxLeNeqWiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766086772; x=1766173172; bh=44hLIHlMdDvZPgRjX6P3ZRCLYRc7Gg/5eqD
	AWfy2EDI=; b=ld/0EeRf/LXv0zhF3ySpXlQQrkTIhDr911CvQ4LYJOtDg7EMx6E
	X8QneL5O8ruMukybnlLUGnc9Hib0StqpGrXCvBDfIOMm00WNd8tvYeaYXdtM9p2S
	pAotAx50g1FI5JfU3tWNQmZrpYXV/Ia2yUlCDAq5IIA7QcU5GG0d/9f4Jg7ms0+6
	XfhEUCFCjemYADiUpuBWmwjh8kTOtow2Ti9OWT6r19J2E7JzxQkoEFMraFdeaffe
	n9vPqpEfshld1ZFIbZ7/hSscr+z8QtO6CO3IflvXqyWJPqv9f6oNE8SgaLtN0+53
	cNU9hMEigB5TIX7qeGz5ex74PDFHnap0kWA==
X-ME-Sender: <xms:c1hEaV_RIO9e2GaQ7-EqQ1HJSTuPP0lxTzuxtdb7rEXfUQLHAdEjJQ>
    <xme:c1hEafsePIvms29WdP_1HQF1yzxcsxD3of6Ae51DRlECcCalJ_BY_zbNgdad-u1q9
    FIAyHMLt00exAUYT8ZJPbQDeEQFDg_GQitJComg_7V0awSSYNf_Rw>
X-ME-Received: <xmr:c1hEaQqpG7oLT4jxK5j-iiBJkg_r9T-jzd0IdGDrbxWj7wehR3y92g1QlqVqR34hzs4gqGepecs1e0lpFTFJ8rlimP2qGKA3xWxlBYkBLJMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegiedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    etieejkeehleejgeeigfdtteelgffglefgjedtjefhffeijefgveduudefffeiueenucff
    ohhmrghinhepghhithdqshgtmhdrtghomhdphihotghtohhprhhojhgvtghtrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhl
    sehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehoshgrmhgrrdgrsgguvghlkhgruggvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmh
    gsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:c1hEaUk-uMCeil6TWE1rhBYbEMpVX_b6bxM4dI-buqmfu3Trrs5EAw>
    <xmx:c1hEacyYejkngecDV3TmkVHN7jTq0BXamG1hETWXRK3qIEQZP2m-Og>
    <xmx:c1hEaUlCIgCq45B_CIbeY5t4RQF07Yxr9BXYWmilDMMV8fs8XySwMw>
    <xmx:c1hEadeBBBtaCZ2FPQhs4J9nQfiMoU4xPbB8vWi_wTQE8cxTfCw6QA>
    <xmx:dFhEabPmChCbnZL7MShmAgVMVRjYlKDQdurfEaOyQxEy2ea-zZEOMQdL>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 14:39:31 -0500 (EST)
Message-ID: <c84892212ed26bf08b1e7447391188ea5793a8a3.camel@pbarker.dev>
Subject: Re: [PATCH 2/4] bitbake-layers: layerindex-fetch: Fix branch
 detection method
From: Paul Barker <paul@pbarker.dev>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Dec 2025 19:39:28 +0000
In-Reply-To: <aUCM_Y388wesrBe-@osama>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
	 <20251212190806.32476-3-osama.abdelkader@gmail.com>
	 <016117db60e8c28186fd3ac5d078f9a0de727682.camel@pbarker.dev>
	 <aUCM_Y388wesrBe-@osama>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-yWs0Y9qDcsokr5xkfUHQ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Dec 2025 19:39:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18609


--=-yWs0Y9qDcsokr5xkfUHQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-15 at 23:34 +0100, Osama Abdelkader wrote:
> On Mon, Dec 15, 2025 at 11:54:20AM +0000, Paul Barker wrote:
> > On Fri, 2025-12-12 at 20:08 +0100, Osama Abdelkader wrote:
> > > Replace fragile parsing of 'git branch' output with the more reliable
> > > 'git rev-parse --abbrev-ref HEAD' command to get the current branch n=
ame.
> > > This avoids parsing issues and is the recommended way to get the curr=
ent branch name.
> >=20
> > Do you have a source for this recommendation? I thought the preferred
> > command was `git branch --show-current` as that just prints the branch
> > name with no extra formatting.
>=20
> Git commands are divided into two groups:
>=20
> Porcelain - High level commands intended to be used at the command line
> Plumbing - Low level commands intended for use in scripts
>=20
> git rev-parse is a "plumbing" command, meaning its output format is guara=
nteed to be stable across different versions of Git.
> It reliably outputs only the raw branch name to standard output.
>=20
> git branch is a "porcelain" command, intended for human users. While git =
branch --show-current currently behaves helpfully,
> the formatting of porcelain commands is theoretically subject to change i=
n future Git releases, which could break your build
> scripts unexpectedly.
>=20
> https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
> https://git-scm.com/docs/git-rev-parse

Hi Osama,

Thanks for the additional context! We discussed this on the patch review
call today.

`git rev-parse --abbrev-ref` is definitely an improvement over calling
`git branch`, but we have still seen some issues with this command in
other contexts on the autobuilder. The best command to use seems to be
`git name-rev --name-only` [1].

[1]: https://git.yoctoproject.org/yocto-autobuilder-helper/commit/?id=3D1e8=
0c19f62169c536e44f99fdcdf9f1e84c65d99

Best regards,

--=20
Paul Barker


--=-yWs0Y9qDcsokr5xkfUHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaURYcBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bvUHAQDHuLOitGD96osb1gm8CGZ3I4lMgzEAHWDT
F0VDQQNVqAEA5VXKDl4pRutc6+9sxoktD+DvDoCU7osz2L6JBrBQRgs=
=E8B0
-----END PGP SIGNATURE-----

--=-yWs0Y9qDcsokr5xkfUHQ--

