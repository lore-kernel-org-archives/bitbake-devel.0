Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E150E63F35
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 08:03:10 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15226.1771228983678887277
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 00:03:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=h/NBZHhh;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2F1051A0F9F;
	Mon, 16 Feb 2026 08:03:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 02AB3606CF;
	Mon, 16 Feb 2026 08:03:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23FFF10369080;
	Mon, 16 Feb 2026 09:02:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771228981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Df1VL9wxB84Xrn+YADaHFT+XXgIehVaPGVR5fPrYd34=;
	b=h/NBZHhh6c+TyDPcjsQVotvROw20/RSk2LCpxxVSdaxTDfPEiqRD8m/n6Xbaj72zTMJglk
	OqE0QBXkHloLkC2wMSuM8IEKTLdXq6f3suBqR7IMLSv1Xs4+l5E4GYsnx8n0R2E/MmMhsu
	4lTBY8uHAV2R+lBmkztYCvHYS63dBgPYCPYnqVtM6z3aECVC/NHdEV69L0/xsdcuxteRyY
	rpz+i/6Rs2MXdwT7k/9Gqsk2RLvo17Va4tffEdNUsoC2d+oRVjBAB5MGIiguei01J6v5dq
	BBU6NKRbbvKdQHTbG0Rgy5Bd6N1ReXNs9oXGHZ0GPk0BsOd2QAhYatMu6g0MKw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 09:02:59 +0100
Message-Id: <DGG89S39J5AT.3JD08TH092QC3@bootlin.com>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <quentin.schulz@cherry.de>, <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH 3/4] doc: bitbake-user-manual-ref-variables:
 clarify BBMASK matching patterns
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
 <20260211-bbmask-slashes-v1-3-b72161c647ef@cherry.de>
 <DGCUY7U4ZJZE.1Y4VMQEELJUO@bootlin.com>
 <f97528ec-917d-44d8-be42-ab0c48a1b2cc@cherry.de>
In-Reply-To: <f97528ec-917d-44d8-be42-ab0c48a1b2cc@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 08:03:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19032

Hi,

On Thu Feb 12, 2026 at 12:38 PM CET, Quentin Schulz via lists.yoctoproject.=
org wrote:
[...]
>> So this looks this is actually what most users want to do, right? Wouldn=
't it be
>> better to put this forward instead of in a note, say, at the beginning o=
f the
>> definition?
>>=20
>> For example, replacing the first example in the variable's definition by=
:
>>=20
>> -The following example uses a complete regular expression to tell
>> -BitBake to ignore all recipe and recipe append files in the
>> -``meta-ti/recipes-misc/`` directory::
>> -
>> -   BBMASK =3D "meta-ti/recipes-misc/"
>> +The following example uses a complete regular expression to tell BitBak=
e to
>> +ignore all recipe and recipe append files in the ``recipes-misc/`` dire=
ctory
>> +and subdirectories of the ``meta-ti`` layer::
>> +
>> +   BBMASK =3D "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
>>=20
>
> Yeah I was conflicted... not sure what's best. This does also rely on=20
> BBFILE_PATTERN_meta-ti starting with ^ otherwise we have another=20
> potential name clash and we don't actually mention that in the=20
> documentation of BBFILE_PATTERN (though it is set like that when=20
> creating a layer with bitbake-layers create-layer).
>
> If for some reason you have:
>
> /layers/meta-ti/recipes-bsp
> /downstream/my-layer/appends/layers/meta-ti/recipes-bsp
>
> then both would be matched (I assume, I haven't checked). That is very=20
> much a corner case.
>
> I'm also pretty sure nobody actually does that. The only layer I have in=
=20
> my pool of cloned layers which uses BBMASK is meta-lts-mixins and then=20
> doesn't even have the layer name in the paths so /me shrugs.
>
>> What do you think?
>>=20
>
> We could start with the BBFILE_PATTERN thingy, then explain there are=20
> other less restrictive ways to match multiple recipes or directories=20
> from different locations later on.

Yes, I think we should do that

Antonin

