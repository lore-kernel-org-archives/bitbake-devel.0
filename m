Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607ACCA462
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:52 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21414.1792156302132554418
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Oct 2026 06:11:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ha1W4vt4;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D38A84E41262
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 13:11:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CF846075D;
	Fri, 16 Oct 2026 13:11:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F69110328544;
	Fri, 16 Oct 2026 15:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792156295; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/QYHuSO5G3v6Bz4s5wR2q83t/d7R50hhJ5OcNgR50bM=;
	b=ha1W4vt4IN8ydJPQPSup4WMpuwmjdNJ1+U8TqlkiyMvrKg1JtR9k8womRWUkXQq83oeqkT
	6dJ2S2v0C9E0bVCkAhN2w/Vk0Bk5fIxHSwgbhpSSNoDQf5sslUE7VcgNRAKAwJLjXEuCZc
	rsQUnqlmtKsjZPg58463XsgmZVjWpuxBW8AD2NHqcey8fKF939V4DG68VDvarnsOrQ4r/+
	GkSXP7gRDVKc7d7F2CHfsS9j7NxaJYkcpAyxE1xzKL076ncNcXtLb7JD1BitwGb2BID+q1
	q4wsRGUwV6n5jfsFa97WK5l+efHt78TAZ2d39MWpf3CxZP2g6Czd6Ra8UfMp6g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 15:11:33 +0200
Message-Id: <DM6ADVADR7L1.F48JUYUSVTMF@bootlin.com>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <michalwsieron@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
 <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
 <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
 <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org>
 <DM5EQUZ5TIGZ.1KG28FB6KB03G@bootlin.com>
 <7dbc1fbb0314b61bbc2913aa004f8ebfd968cc03.camel@linuxfoundation.org>
 <DM5GYBADXEX9.2UOTTZAL4JTT2@bootlin.com>
 <2040945.1792137545176168291@lists.openembedded.org>
In-Reply-To: <2040945.1792137545176168291@lists.openembedded.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 13:11:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20351

Hi,

On Fri Oct 16, 2026 at 9:59 AM CEST, Michal Sieron via lists.openembedded.o=
rg wrote:
> Hi,
>
> two cents from my side. I think that warnings as errors would ideally wor=
k like normal -Werror in compilers.
>
> 1. Regarding name: -W doesn't indicate anything about errors. Only someth=
ing
>    with warnings. I am not sure if having this short option is worth it.

I agree.

> 2. This might be controversial, but ability to do -Wno-error, would be gr=
eat.
>    Problem is we don't have categorized/named warnings/errors. But I thin=
k
>    that it could support a syntax where we use file name (or partial matc=
h on
>    its path) and disable warnings-as-errors for that source file. Or this
>    might be even easier to implement: regex for warning message. It it
>    matches, it won't be treated as an error.

That sounds like an interesting idea - but maybe as a follow-up of this tho=
ugh?

> 3. Exit code only change won't force developers to immediately fix their =
code
>    as it's really easy to ignore in interactive terminals. Sure, later CI
>    would catch it, but I would prefer early fail if possible.

That's true - however, I checked again, and error messages originating from
bb.error (or bberror) do NOT stop the execution of bitbake. This is the rol=
e of
bb.fatal (or bbfatal). bb.error only affects the return code of bitbake, bu=
t
goes as far as possible - for example I was able to build an image recipe e=
ven
though one of its recipes emitted a bb.error.

So if we want warnings to act like errors, I think this is already what thi=
s
series does. If we want warnings/errors to act like bb.fatal, that's anothe=
r
question.

Antonin

