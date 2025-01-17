Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C0C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 12:08:18 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.9394.1737115693828921296
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 04:08:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jesAADvG;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 226D61C0002;
	Fri, 17 Jan 2025 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737115691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8ed4uQa2ve2B3cRk+TXNF2MjIdeq1OfAR9OpTPMHvo=;
	b=jesAADvGbip994wiT1Rg1cvO2CWiIXPid9qeBWr1Bf9xIoUsAUMr3OJOTBKt83TgZpMlZB
	8J0t0klh/CnlgWWH/qiJq0N5sZ7mtnD4hnTGICbcXtuqFgzbMf37DQQ1hlzeiWrw4Fv33z
	wVTflfKLVfb1yNmwB/0arJSYp8PhY2qAo6G68rU/F3P7gD4sHCbfoNfIO9bVyys0JWD/Na
	SkmK7VF2M3/LeraYZC1r6zL8uDV68A0TWYczOZoyGjvLnegD5gbUBnqPr4Al0Kd1rfSoWE
	03LNRfRKqFive1zul+PIVjP+DxZVVvK6mYbIi+4tViJ/X0HzAZC/Yb2lhsokSg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 13:08:10 +0100
Message-Id: <D74C4BKUYJJM.3ACL3B4JKCQP0@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v2] add basic support for b4
 contribution workflow
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>, "Quentin Schulz"
 <foss@0leil.net>, <bitbake-devel@lists.openembedded.org>,
 <docs@lists.yoctoproject.org>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
 <D74APENZ2FY4.2W3AXB39KKQ1D@bootlin.com>
 <48f94226-eb4b-4d7d-b007-d7b57975a59a@cherry.de>
In-Reply-To: <48f94226-eb4b-4d7d-b007-d7b57975a59a@cherry.de>
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 12:08:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17026

Hi Quentin,

On Fri Jan 17, 2025 at 12:43 PM CET, Quentin Schulz wrote:
[...]
>>> Note that b4 supports patchwork, c.f.
>>> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-=
settings
>>> though I have no clue what it does with it as I am no maintainer, but
>>> maybe something worth having a look at if some maintainer of this repo
>>> wants to use b4 to merge stuff?
>>=20
>> I'll add my configuration here, maybe someone or myself can add some doc=
 for it
>> later, here or elsewhere.
>>=20
>> configuration I use:
>>=20
>> [b4]
>>    pw-url =3D https://patchwork.yoctoproject.org/
>>    pw-key =3D <redacted>
>>    pw-project =3D docs
>>    pw-review-state =3D under-review
>>    pw-accept-state =3D accepted
>>    pw-discard-state =3D rejected
>>=20
>> For `pw-project`, it comes from the project name on patchwork, e.g.:
>>=20
>>    https://patchwork.yoctoproject.org/project/docs/list
>>                                               ^^^^
>>=20
>> The pw-key can be obtained from the user's personal settings.
>>=20
>> Then `b4 {am,shazam}` will automatically set the state to under-review.
>>=20
>> `b4 ty -d` will reject the patch. Sometimes I use `b4 ty --pw-set-state
>> superseded -d ...` when I know another version of the patch/series was s=
ent.
>>=20
>> Finally `b4 ty -a` will also set the accepted state along the generation=
 of
>> thank-you file.
>>=20
>> And overall it's much easier than clicking buttons on patchwork :)
>>=20
>
> Thanks!
>
> How does this work if I don't have pw-key (which will be the case for=20
> most/all contributors)? Does b4 fail or goes on like it would if we had=
=20
> no pw-* settings?

I just checked and if a pw-key is not set, b4 just does nothing related to
patchwork (tested for shazam only).

> Additionally, I'm pretty sure we do not want maintainers to mistakenly=20
> push their pw-key to the mailing list. So I guess this should be stored=
=20
> outside of the git repo and rather in .gitconfig, c.f.=20
> https://b4.docs.kernel.org/en/latest/config.html#configuration-options
> Should we add some documentation on how to do that for maintainers?

True, in fact all of this was configured from .git/config on a per-repo bas=
is.

> Considering I cannot test this right now (i don't have patchwork set up,=
=20
> nor do I know if it makes sense to set it up if I'm not maintainer :) ),=
=20
> I think it'd make more sense to have someone able to test it to send a=20
> patch later to add support for that? What do you think?

I'm not sure where would be a good place for such documentation, as this is
personal tooling and personal taste in the end.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

