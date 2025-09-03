Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E61CA1009
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 09:03:09 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.8046.1756890185782843080
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Sep 2025 02:03:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=P3RDk56w;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E1CEBC6B39D;
	Wed,  3 Sep 2025 09:02:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDAF4606C3;
	Wed,  3 Sep 2025 09:03:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB9121C22D0C9;
	Wed,  3 Sep 2025 11:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756890183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ch+zPSro2YxBEhX4GVmCd0cJfHsFQUj4gmgymxh1NwA=;
	b=P3RDk56whUH3VxejF2XCRysSEqazZZdDCucEurwRRi+V4OXvBgroEg4y0gqDNfCAlWbTyk
	1MtRhq0T8jwp52XvevdQusAvCrc1SRuWCDApBhAqqejrAG0VHHuY7atjS/ev93U8c//pNM
	iNImO39HGQSLjREOHkQRZT+zV21qiRjZQeoHUyY+9vvLbZcEpwla4zhEvEFAwtvtJ51Tr9
	EMCfn2j/IsmemIV/tAVzBFX1tjAEJ/XliS04i1LPbnO1Ldx0QdtiPNL796sVGVvi3HflBs
	eInDUKPO1bUPILH0RKmq6qh5kOzL7T0t//10MUSMw+B1Z3YMzn+isAei0zaq8Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 11:03:01 +0200
Message-Id: <DCJ1LB07T040.172FGJP1QUJ1E@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/6] bitbake-setup: add the initial
 implementation
Cc: <bitbake-devel@lists.openembedded.org>, "Alexander Kanavin"
 <alex@linutronix.de>
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <DCIDMIQZKLXV.2ZM8YXZTV1MM8@bootlin.com>
 <CANNYZj982UwaX97yiyN-9gXkRJb1qmQCnrGKri9mMkK1CL8LDg@mail.gmail.com>
In-Reply-To: <CANNYZj982UwaX97yiyN-9gXkRJb1qmQCnrGKri9mMkK1CL8LDg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 09:03:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17947

On Tue Sep 2, 2025 at 9:41 PM CEST, Alexander Kanavin wrote:
>> Could we add the shorter form `-b`? I feel like this is going to get typ=
ed a
>> lot. Same for --top-dir/-t, although the BITBAKE_SETUP_TOP_DIR variable =
makes it
>> less necessary.
>
> You only need to add --build-dir if you have not sourced the bitbake
> environment, but if you did, then bitbake-setup will deduce the
> build-dir from that by default.

> As for --top-dir, the awkwardness of setting it to something else than
> $HOME has been bothering me too, I've given it a bit of thought, and I
> think it needs to be split into two parts:
>
> - top-dir-prefix, which defaults to $HOME but can be set to cwd
> (someone requested that) or some custom local directory intended
> specifically for yocto builds (this is also common).
> - top-dir-name which is appended to that when a build is initialized,
> and defaults to 'bitbake-builds'.
>
> Defaults for both items are taken from ~/.config/bitbake-setup, but
> can be overriden with command line options. Then the environment
> variable is not needed. What you think?

I like the idea of a config file in ~/.config (~/.config/bitbake-setup/conf=
ig?)
rather than an env variable, if I had to choose.

Personally I would prefer having both, with this order of precedence:

1. --top-dir-prefix
2. BITBAKE_SETUP_TOP_DIR_PREFIX env variable
3. top-dir-prefix =3D ... in ~/.config/bitbake-setup/config

I think this would cover all use-cases and satisfy everyone? :)

The fact that bitbake-setup prints "Bitbake-setup is using <...> as top
directory" when it starts is great and should be kept IMO, this makes it ea=
sy to
verify what the current top-dir is.

>> Do we really need --build-dir for the status command?
>>
>> "bitbake-setup status" alone returns:
>>
>>   usage: bitbake-setup status [-h] --build-dir BUILD_DIR
>>   bitbake-setup status: error: the following arguments are required: --b=
uild-dir
>>
>> Maybe BUILD_DIR should be the only positional argument instead of an opt=
ional
>> one:
>>
>>   bitbake-setup status <build_dir>
>
> See above: source the bitbake environment, and 'bitbake-setup status'
> without arguments will work. I'm not fond of positional arguments,
> because they make the command line less readable, especially if there
> are several unrelated ones one after another.

Indeed I did not know that, I agree it makes more sense to run after sourci=
ng
the environment file.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


