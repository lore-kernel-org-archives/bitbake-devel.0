Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05944CC6B33
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:09 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38343.1792067040992828827
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Oct 2026 05:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=xyFMX7ml;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D80FD1A1238;
	Thu, 15 Oct 2026 12:23:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD6B960360;
	Thu, 15 Oct 2026 12:23:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C08A10328BDA;
	Thu, 15 Oct 2026 14:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792067038; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dwCPx+cdScVwUhazuwaNwTAm/itYlp3yXDp+v2+KJDw=;
	b=xyFMX7mlfJjgf2IbkWvGj6eF6+wysbA0gNHXB4K5hrE+J8TfQuGU6WmyWeI1pDaLMRXZ0z
	BG6dpZv2YWPpvLr1P3PBD1T/SxNSafS/DmWe00MNjdrmwKX6wMHbxCi3F/4RRKcSm8Qq8T
	Aq7Hx8TC/wVr2MyCbHavBJxCt0liOFA/evcTTlwG3xO9nMDBSXrNIsEIljXpdqcxlGICym
	fsOQVuX1JpCjUia00bo0o6a8ZReyq3v3YuA7qmh9cyfjDkf0g7g1qzDxgAYffRNY7gCU+N
	zosSQUOIXNhCm3CfakMY1cNnF7baIxAdACYUP2YiKj2Sw3x0YobnY+j43g/sSA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 14:23:55 +0200
Message-Id: <DM5EQUZ5TIGZ.1KG28FB6KB03G@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>, "Ross Burton" <ross.burton@arm.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
 <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
 <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
 <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org>
In-Reply-To: <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 12:24:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20346

On Thu Oct 15, 2026 at 1:49 PM CEST, Richard Purdie wrote:
> On Thu, 2026-10-15 at 12:25 +0200, Antonin Godard wrote:
>> On Thu Oct 15, 2026 at 10:58 AM CEST, Richard Purdie via lists.yoctoproj=
ect.org wrote:
>> > On Tue, 2026-10-13 at 14:13 +0200, Antonin Godard via lists.openembedd=
ed.org wrote:
>> > > When -W is passed, modify the handlers to show warnings in red and s=
et
>> > > the return value to 1. Add a summary line informing the user that th=
e -W
>> > > option was used as it might not be obvious when looking at the botto=
m
>> > > the end of the console log.
>> >=20
>> > The trouble is this doesn't make warnings behave exactly as errors and
>> > I think that is going to confuse people :/.
>> >=20
>> > Specifically, if an error is encountered in a task, it will error and
>> > fail. The warning will show an error but continue anyway. I also
>> > suspect the warnings will still show as warnings in the log files and
>> > only appear as errors on the console.
>>=20
>> Good point. So there's two directions this could take (if we want that f=
eature):
>>=20
>> - Make this option change the behavior of warnings, and make them _act_ =
(not
>> =C2=A0 just look) like errors, so a given task would stop in case of war=
ning.
>>=20
>> - Rename the option and make it clearer: warnings are still warnings but=
 the
>> =C2=A0 return code will be 1 if there are any.
>>=20
>> =C2=A0 Maybe "-W,--fail-on-warnings: Make bitbake return 1 if any warnin=
g is
>> =C2=A0 emitted"?
>>=20
>> I feel like the second option might be best as the first one is changing=
 the
>> behavior of tasks and I also think this might not be desirable.
>>=20
>> With the second option it allows having a positive exit code on warnings=
 while
>> still being able to have a look at all of them (not only the single one =
that
>> stopped the build as would happen with the first option), just as you wo=
uld with
>> a normal bitbake execution.
>
> I think we need to see if there are others wanting this feature or not.
> I think with new option additions like this, we need to see a clear
> demand from the userbase for it. That feedback may also make it clearer
> which behaviour people would want.

Ross (copied here) was talking about it on IRC[1]. Hard to say which way or=
 the
other was desired from this conversation though. It did give me the idea to
contribute this feature as I also need it sometimes.

I personally have seen multiple projects where builds started in CI environ=
ments
needed to stop when warnings are emitted. I'm happy to keep my scripts as t=
hey
are but I thought this series would make things a bit easier for users.

I cannot say which solution for it the userbase would prefer though!

[1]: https://libera.catirclogs.org/yocto/2026-09-03#1788452760-1788454399;

Antonin

