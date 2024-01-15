Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF30C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 11:57:35 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by mx.groups.io with SMTP id smtpd.web10.77723.1705319854409035310
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jan 2024 03:57:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@myneves.com header.s=protonmail3 header.b=VN1s1kKi;
 spf=pass (domain: myneves.com, ip: 185.70.40.22, mailfrom: paulo@myneves.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail3; t=1705319852; x=1705579052;
	bh=3qTGb+hxirY0J3NpRE1fT+Hhv3wfSD0ciqp7hBdFX34=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VN1s1kKiFJg+CDVlxd5E22P3wdFAUMtTRQPz3wgp9WTCmNqSH1hoAc9Wb8oxrpLl1
	 ye201POn9xqiaq03FHII6fJVCny0vT90UdTfCfL2n2OO0kl0/sA/EvAEWq/fAz4usc
	 wVKPQ/GoRwjXsfnM8mpKT4f5V3rWBtSmSdW4znrOGmTc3YlFlgMeMb7Xkg7uAzB6o0
	 CooEJMjZdSg/wH7ssZlpa1asStzIxFrt3LUR4WOmoTrNY1f76iGiSVan8eMet52zXK
	 +UazKl6qj5kU7i1hgO8ctSfuKWAJMZYcb62HwdwDtQ3i1DN8fgzwNNE8sVOe0VwP2I
	 2LU0lqvFx0rXA==
Date: Mon, 15 Jan 2024 11:57:22 +0000
To: Vasyl Vavrychuk <vvavrychuk@gmail.com>, bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Subject: Re: [bitbake-devel] how to appendVar via Tinfoil API
Message-ID: <18a82940-55ce-48d0-841b-754b736839b3@myneves.com>
In-Reply-To: <rjF5.1704750728530444364.AHOb@lists.openembedded.org>
References: <rjF5.1704750728530444364.AHOb@lists.openembedded.org>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jan 2024 11:57:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15795

Hello Vasyl,

The way I did in the past is to create a conf file that is injected to=20
bitbake by making the script set os.environ["BBPOSTCONF"] =3D "<my special=
=20
conf>"

This will then be picked up by=20
https://github.com/openembedded/bitbake/blob/966f25dfc23a6d17b2b6d3e0100e9a=
e264f99025/lib/bb/main.py#L328

Another way, I haven't tested is that your default configuration=20
includes a variable that is normally unset and then in tinfoil.prepare=20
you pass config_params argument as in=20
https://github.com/openembedded/bitbake/blob/966f25dfc23a6d17b2b6d3e0100e9a=
e264f99025/lib/bb/tinfoil.py#L364

For example

BB_MULTI_PROVIDER_ALLOWED +=3D "A B ${EXTRA_MULTIPROVIDER_ALLOWED}"

and then tinfoil.prepare(self, config_only=3DFalse,=20
config_params=3D{EXTRA_MULTIPROVIDER_ALLOWED: "C"}, quiet=3D0,=20
extra_features=3DNone):

Cheers

Paulo Neves

On 08/01/2024 22:52, Vasyl Vavrychuk wrote:
> I would like temporary appendVar before parsing recipes via Tinfoil=20
> API. Specifically, I want to do using Tinfoil API:
>
> BB_MULTI_PROVIDER_ALLOWED +=3D "..."
>
> and then call Tinfoil API to get all providers including skipped one.
>
> Can I do appendVar using Tinfoil?=20


