Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7258C36010
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 13:44:09 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.50129.1743083046837420218
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Mar 2025 06:44:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=OKkeidml;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9CFB43195;
	Thu, 27 Mar 2025 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743083045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXFaDQC1tZR1bA58feO3IKI8zsaTk4akZ2rB5bHWphU=;
	b=OKkeidmlNGVRNUW98SdB6iZJtcos0A7a5pY8ouCdeoWb81ckXNxtzEM9B+05BO2iDnYvFZ
	U3wc46un6Fq0H6N9hp++ECFDg7Rtl1R+k2Qm4oyxVT6H+FJscoIQmvo5tJCOfoT+tZHrZn
	nfIbju3I3t3haw7XXun8VsRJZCrmYDk56iGKI/RVqTpGtZ8W5JGzhk3TBov/V3jUrVwxqH
	QZArtPsk9xU9O0vqOqJ/blwZWyJYuz8bmy/NRI1Dfji0Edk8VjgeuHVLEzPeXuE6d8JFB3
	hfGKyghyWsfmBP1yCRiIKrkdC+7rc8EXkno6xxqi3PqX00F9jkFJA/tmQNJ4qg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Mar 2025 14:44:03 +0100
Message-Id: <D8R3DBLE3C5T.12J03WL0YNGID@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Javier Tia" <javier.tia@linaro.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] doc: Mention `if [[ somecondition ]]` is not supported
Cc: <docs@lists.yoctoproject.org>, "Mikko Rapeli" <mikko.rapeli@linaro.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.1-42-g7f7db0373f6c
References: <20250320003358.977774-1-javier.tia@linaro.org>
In-Reply-To: <20250320003358.977774-1-javier.tia@linaro.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkhffvufevofhfjgesthhqredtredtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekueekgeeggeeltedvjeduuedvveffvddtteeuteekudfhgeelteevledthfdvteenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehjrghvihgvrhdrthhirgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnv
 ghmsggvugguvggurdhorhhgpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehmihhkkhhordhrrghpvghliheslhhinhgrrhhordhorhhgpdhrtghpthhtohepihhlihgrshdrrghprghlohguihhmrghssehlihhnrghrohdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Mar 2025 13:44:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17503

Hi Javier,

On Thu Mar 20, 2025 at 1:33 AM CET, Javier Tia wrote:
> I keep forgetting using `if [[ somecondition ]]` is not supported.
>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 415fbf6d6..5474e154f 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1381,6 +1381,10 @@ To make use of this technique, you need the follow=
ing things in place:
>     To call your modified version of the function as defined in your reci=
pe,
>     call it as ``do_foo``.
> =20
> +   .. note::
> +
> +      Conditional expression using ``[[ somecondition ]]`` is not suppor=
ted.
> +
>  With these conditions met, your single recipe can freely choose between
>  the original function as defined in the class file and the modified
>  function in your recipe. If you do not set up these conditions, you are

The documentation already says the following:

  The scripts are executed by ``/bin/sh``, which may not be a bash
  shell but might be something such as ``dash``. You should not use
  Bash-specific script (bashisms).

I think [[ ]] is a bashism, or at least the POSIX shell spec clearly state =
to
not use it[1]. I'm not sure the BitBake documentation should list all the s=
hell
syntax it does not support, as I expect there are quite a few.

The codeparser, however, could be modified to try and detect the usage of [=
[ ]]
and give a warning on such occurrences?

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_04

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

