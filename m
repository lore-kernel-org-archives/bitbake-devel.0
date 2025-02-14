Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DD5C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 16:23:10 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.24965.1739550181591861288
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 08:23:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=b6MV7pp+;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DB724429F;
	Fri, 14 Feb 2025 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739550179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K73HjNBbAfp46E9YZUYAnoG/uGocRKYsXT5OuIHV0G4=;
	b=b6MV7pp+IjQH9I8gg8kmJaGgUlZwDklHxNUD0Iyx7+1sD2YCDeEjUY8SZF1MAzLUnpukJF
	sb44VlVtJPdvwexh4Fg7IAdhR0jicCIU5R2MzpzweZws1KlLWl93cXm62g7StuRqhtvqHO
	WB4h/YX02VsPM3ovXud4vVA6nKsYLv4XLmsiiPs+ZtF/KKymKjIcT5EjsiigJabbMgOlMZ
	W0oAwR19QxKV0y0mRQpiZnGQmpIjoRxebqV00rT5HJH9SVT4jYqBynvVc9cCxCAGv7tmwY
	hRsj0XPtmchUgS6os9OoD2BzGYokl5tyuU8qauDlcPiaqWSvNiOiSAjh6Jm6ig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 17:22:58 +0100
Message-Id: <D7SB2NW65EZO.1DXFZ7T9DLTLL@bootlin.com>
Cc: <simon.sudler@siemens.com>, <jan.kiszka@siemens.com>,
 <alex.kanavin@gmail.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <stefan-koch@siemens.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 2/4] bitbake-user-manual: Add
 documentation for BB_GIT_SHALLOW_FAST
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250214155057.1748020-1-stefan-koch@siemens.com>
 <20250214155057.1748020-2-stefan-koch@siemens.com>
In-Reply-To: <20250214155057.1748020-2-stefan-koch@siemens.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetgeehfeekhffgueffhfekvddvvedtieevffetffetfefgudehjeekheethfefteenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepshhtvghfrghnqdhkohgthhesshhivghmvghnshdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtp
 hhtthhopehsihhmohhnrdhsuhgulhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopegrlhgvgidrkhgrnhgrvhhinhesghhmrghilhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 16:23:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17227

Hi Stefan,

On Fri Feb 14, 2025 at 4:50 PM CET, Stefan via lists.openembedded.org Koch =
wrote:
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../bitbake-user-manual-ref-variables.rst       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index ad219b531..bba6cbcd9 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -347,6 +347,23 @@ overview of their function and contents.
> =20
>        For example usage, see :term:`BB_GIT_SHALLOW`.
> =20
> +   :term:`BB_GIT_SHALLOW_FAST`
> +      Set to "1" for a fast initial shallow fetch.
> +      This setting prefers an initial shallow clone
> +      over an initial full bare clone.
> +      The amount of data transferred during the initial clone will be re=
duced.
> +      `BB_GIT_SHALLOW` does not need to be set additionally,
> +      as `BB_GIT_SHALLOW_FAST` takes precedence over it.

Instead of `BB_GIT_SHALLOW_FAST` you can re-use :term:`BB_GIT_SHALLOW_FAST`
since you created the definition for it. Using single ticks (`...`) will ma=
ke
that appear in italic otherwise.

Same for BB_GIT_SHALLOW, you can use :term:`BB_GIT_SHALLOW`.

> +
> +      However, for updates, the data transfer may be significantly
> +      higher due to fully new shallow clones.
> +      Over time, numerous shallow clones may cumulatively
> +      transfer the same amount of data as the initial full bare clone.
> +      This is especially the case with very large repositories.
> +
> +      Existing initial full bare clones, created without this fast optio=
n,
> +      will always be utilized.

I would rephrase "will always be utilized" to "will always be prioritized o=
ver
the shallow clones". If I understood that correctly?

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

