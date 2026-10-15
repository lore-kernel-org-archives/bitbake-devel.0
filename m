Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB404CC6B3D
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 14:07:59 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41069.1792073270782340312
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Oct 2026 07:07:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mmW66Oz+;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AB706C62203
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 14:08:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44BD260360;
	Thu, 15 Oct 2026 14:07:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9481810328189;
	Thu, 15 Oct 2026 16:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792073263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mk4lvqb1yAgsQTIpro4zgThpjieS4PFE55ITqK1dylY=;
	b=mmW66Oz+k/Jvms8qDLaaeCNoAzW3R17Flh9w6F9/96tX4Q+Ibh1yu3v8KK7tQ3nFBJPm5u
	vN5TM+SzypJL7s/7lJJ/K7JJTzYEwUcstlzW0UkiW5x1V606bn5FwMjxYKD2GRLtuHHVyQ
	M9+m41u7VOkDUJXo8cns1jBes9VGqqzYw8UuSjnURlobNdIrt3oWnQIunkPrD5phgwlvt2
	+kt0BDqniie9Jna9asG8lhRbB+WMdxrj9IIqw8NKrDUG3Pan8jm6MUJPgSC+fJwPXgJEL9
	JrX1bfMkG+s7a8mvLNtQwT8lcV0pddUhDsJw7vlBQj4pFBYO5g4QIk8+lvZbJA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 16:07:42 +0200
Message-Id: <DM5GYBADXEX9.2UOTTZAL4JTT2@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>, "Ross Burton" <ross.burton@arm.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
 <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
 <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
 <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org>
 <DM5EQUZ5TIGZ.1KG28FB6KB03G@bootlin.com>
 <7dbc1fbb0314b61bbc2913aa004f8ebfd968cc03.camel@linuxfoundation.org>
In-Reply-To: <7dbc1fbb0314b61bbc2913aa004f8ebfd968cc03.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 14:07:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20348

On Thu Oct 15, 2026 at 3:04 PM CEST, Richard Purdie wrote:
> On Thu, 2026-10-15 at 14:23 +0200, Antonin Godard wrote:
>> On Thu Oct 15, 2026 at 1:49 PM CEST, Richard Purdie wrote:
>> > On Thu, 2026-10-15 at 12:25 +0200, Antonin Godard wrote:
>> > > On Thu Oct 15, 2026 at 10:58 AM CEST, Richard Purdie via lists.yocto=
project.org wrote:
>> > > > On Tue, 2026-10-13 at 14:13 +0200, Antonin Godard via lists.openem=
bedded.org wrote:
>> > > > > When -W is passed, modify the handlers to show warnings in red a=
nd set
>> > > > > the return value to 1. Add a summary line informing the user tha=
t the -W
>> > > > > option was used as it might not be obvious when looking at the b=
ottom
>> > > > > the end of the console log.
>> > > >=20
>> > > > The trouble is this doesn't make warnings behave exactly as errors=
 and
>> > > > I think that is going to confuse people :/.
>> > > >=20
>> > > > Specifically, if an error is encountered in a task, it will error =
and
>> > > > fail. The warning will show an error but continue anyway. I also
>> > > > suspect the warnings will still show as warnings in the log files =
and
>> > > > only appear as errors on the console.
>> > >=20
>> > > Good point. So there's two directions this could take (if we want th=
at feature):
>> > >=20
>> > > - Make this option change the behavior of warnings, and make them _a=
ct_ (not
>> > > =C2=A0 just look) like errors, so a given task would stop in case of=
 warning.
>> > >=20
>> > > - Rename the option and make it clearer: warnings are still warnings=
 but the
>> > > =C2=A0 return code will be 1 if there are any.
>> > >=20
>> > > =C2=A0 Maybe "-W,--fail-on-warnings: Make bitbake return 1 if any wa=
rning is
>> > > =C2=A0 emitted"?
>> > >=20
>> > > I feel like the second option might be best as the first one is chan=
ging the
>> > > behavior of tasks and I also think this might not be desirable.
>> > >=20
>> > > With the second option it allows having a positive exit code on warn=
ings while
>> > > still being able to have a look at all of them (not only the single =
one that
>> > > stopped the build as would happen with the first option), just as yo=
u would with
>> > > a normal bitbake execution.
>> >=20
>> > I think we need to see if there are others wanting this feature or not=
.
>> > I think with new option additions like this, we need to see a clear
>> > demand from the userbase for it. That feedback may also make it cleare=
r
>> > which behaviour people would want.
>>=20
>> Ross (copied here) was talking about it on IRC[1]. Hard to say which way=
 or the
>> other was desired from this conversation though. It did give me the idea=
 to
>> contribute this feature as I also need it sometimes.
>>=20
>> I personally have seen multiple projects where builds started in CI envi=
ronments
>> needed to stop when warnings are emitted. I'm happy to keep my scripts a=
s they
>> are but I thought this series would make things a bit easier for users.
>
> Do you really want to "stop" on warnings though? Usually you want a
> list of *all* the warnings, not just the first one. You probably do
> want to continue through all the rest of the tasks too.

No, I don't want to stop on the first warning. I wasn't clear, sorry.

> That makes it sound like you want to just change the exit code, which
> is a bit of a different discussion...

Yes, exactly, the goal would be to return 1 if at least 1 warning is emitte=
d,
which I think is a common use-case.

Antonin

