Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AABD49207
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 16:04:09 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.44797.1731945844913478518
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Nov 2024 08:04:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=OlkQVZDr;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB57360006;
	Mon, 18 Nov 2024 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731945843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqHH+/5OQ71EMshdL3fvZGk2+gSbAv6AR3wP62IifJ0=;
	b=OlkQVZDrH/oGabEFW62sQ+Hs1c/qoxVz+DA/RcYWB4xwO5vH3aWb3HokGrCmVzBSGa3aGW
	lyM7TeG65zEy0UdIDejCSPIAD8dclujsQCZnntGJ/YZzB/JN2pDVF2yog1lCAR8rmwAfmo
	njOOCQmDwNEuvF9s5V+bH0WRi+dBJ9Dqrb0QvTSB2bOvQipXutfQGkk0+EoE5adomAqqiU
	25rYC8tsskpBP5YWI0Y/OZbUn2ATWrRifY+9BoeaDCRtavY9EUy/7lp3nTjqr37ydKHfnp
	fXrSUS3ht4F6oJHBnSkdkB2JjhhCRHujgkrmI3JdGBAxMYZJOgst/tEZhaTT8Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Nov 2024 17:04:02 +0100
Message-Id: <D5PFK80N8GYJ.1Y0G9NNHOYOGW@bootlin.com>
Subject: Re: [bitbake-devel] [bitbake-devel PATCH] doc: bitbake-user-manual:
 document inherit_defer
Cc: <docs@lists.yoctoproject.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Yoann Congal" <yoann.congal@smile.fr>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.18.2.r87.gd0484b15
References: <20241118-inherit-defer-v1-1-26866a60ab1b@bootlin.com>
 <672b93e1-54d4-4af8-84e3-de0912770b7d@cherry.de>
In-Reply-To: <672b93e1-54d4-4af8-84e3-de0912770b7d@cherry.de>
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 16:04:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16806

Hi Quentin,

On Mon Nov 18, 2024 at 4:44 PM CET, Quentin Schulz wrote:
[...]
>> +``inherit_defer`` Directive
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The ``inherit_defer`` directive works like the ``inherit`` directive, e=
xcept
>
> add a ref here to the inherit directive section?

Yes, thanks.

>> +that it is only evaluated at the end of parsing. Its usage is recommend=
ed when a
>> +conditional expression is used. For example::
>> +
>> +   inherit_defer ${@bb.utils.contains('PACKAGECONFIG', 'python', 'pytho=
n3targetconfig', '', d)}
>> +
>> +This allows conditional expressions to be evaluated "late", meaning cha=
nges
>> +to the variable after the line is parsed will take effect. With the ``i=
nherit``
>> +directive this is not the case.
>> +
>
> OK so I don't know if this wouldn't also typically apply to "inherit=20
> ${VARIABLE}" if VARIABLE is set after the inherit?
>
> Ahah, I believe this is actually specified in the inherit directive secti=
on!
>
> """
> An advantage with the inherit directive as compared to both the include=
=20
> and require directives is that you can inherit class files=20
> conditionally. You can accomplish this by using a variable expression=20
> after the inherit statement. Here is an example:
>
> inherit ${VARNAME}
>
> If VARNAME is going to be set, it needs to be set before the inherit=20
> statement is parsed.
> """
>
> Also, I believe we very likely want to remove the last few paragraphs of=
=20
> the inherit directive section?
>
> i.e. from
> """
> One way to achieve a conditional inherit in this case is to use overrides=
:
> """
> to the end of the section.
>
> I guess we could replace it with "if you want to conditionally inherit,=
=20
> please use :ref:`inherit_defer`".
>
> or something along those lines.
>
> What do you think?

And so the documentation would advise to always use `inherit_defer` for
conditional inherits. As far as I understand the purpose of inherit_defer, =
this
is fine to me (and error-safe), so I agree with you on removing the conditi=
onal
case from the inherit directive section and redirecting towards inherit_def=
er.

This makes me wonder why inherit_defer isn't merged into inherit then (i.e.
inherit would behave like inherit_defer by default). But I guess there are =
other
stakes that go beyond my knowledge on this. :)

Cheers,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

