Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF1C83F0A
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 11:38:03 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.16295.1751974673034123675
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 04:37:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=BNztXV0q;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9FA243145;
	Tue,  8 Jul 2025 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751974670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEl2gJZrzpuYF4URlTQ287VGMn2+NMAioQlgh0BpI0U=;
	b=BNztXV0qSqz3QXdziFQ5IOervup8k6Sz0g4v5411yPpSsw2YX2MKbTWHzDmG6NbOnbbZ40
	e3AYojiuS54+Zans1IKRbwRh0C/fdX1KNvZWBmcve8i4B4kJ1gEdgP8Gkry1W+EncWcZuE
	ty2jOnx0jEPf3CGaYRiAyomQKpi37Th7XlIhQNbX2VX1UZA7zHUbcbfQsP+mQJVzzs7PJ+
	OEImjpIm1uxdWrDrQRtN8+g9FVrYZ3hRqDu/ywNteYP8Ku7c+6PRhPomRGt49m/r2f4y38
	3dbz1v7U79l9ieAKUnSqJPn/XCNnAWKfzQF0TT0xkxP+YRUNJDf/v7jBPLm20g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 13:37:49 +0200
Message-Id: <DB6N6S3RH1TM.1HFNXT9E75TR8@bootlin.com>
Subject: Re: [docs] [PATCH] Mention existence of three supported "classes"
 directories
Cc: "BitBake developer list" <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, "YP docs mailing list"
 <docs@lists.yoctoproject.org>
References: <7f7b0bf4-2fdf-d216-6488-7576a79b19ed@crashcourse.ca>
In-Reply-To: <7f7b0bf4-2fdf-d216-6488-7576a79b19ed@crashcourse.ca>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvfhfjgesthhqredttddtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffheekueetteekueefjeejveevuddutdfgueetieevkeejgeejgeetueevkeefudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehrphhjuggrhiestghrrghshhgtohhurhhsvgdrtggrpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopegsihhtsggrk
 hgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 11:38:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17756

On Tue Jul 8, 2025 at 1:29 PM CEST, Robert P. J. Day wrote:
>
> Early in Section 1, mention that BitBake supports three related
> classes directories.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   I'm not thrilled with this explanation in terms of where it is, but
> it's better than not explaining this at all.
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/=
bitbake-user-manual/bitbake-user-manual-intro.rst
> index 539bb62d8..feab1df9d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -206,6 +206,18 @@ installing (empty by default) and packaging (empty b=
y default). These
>  tasks are often overridden or extended by other classes added during the
>  project development process.
>
> +.. note::
> +
> +   While BitBake comes with just the one ``base.bbclass`` file in the
> +   ``classes`` directory, it supports class files also being installed
> +   in related directories ``classes-global`` and ``classes-recipe`` and
> +   will automatically search all three directories for a selectd class

s/selectd/selected/

> +   file.
> +
> +   This means that, in this documentation, when you see a reference to
> +   class files being in the ``classes`` directory, you can interpret tha=
t
> +   as meaning in any one of the above three directories.

I don't think this is enough explanation on these directories, and as-is it
would create confusion I think.

There are some details about these directories here:
https://bootlin.com/doc/training/yocto/yocto-slides.pdf#19

Maybe that can help you add the explanation?

I would also explain the difference between these directories (classes,
classes-recipe and classes-global) in a paragraph of its own, not in a note=
.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


