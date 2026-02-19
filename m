Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE1FE9A03B
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 10:19:04 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10738.1771496337523386018
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Feb 2026 02:18:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2AfAr/O8;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 64FE01A06A3;
	Thu, 19 Feb 2026 10:18:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3A4225FB45;
	Thu, 19 Feb 2026 10:18:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B112D10368C89;
	Thu, 19 Feb 2026 11:18:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771496334; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dNWqG2H9VvnN/dtLUlJSZ5uJHV2yWTq3+xgkPVG9nvU=;
	b=2AfAr/O8V5LNeBNGl9Sv/tGOO14K+IKczpOKviNTjHl6k0nx0hhMLSiwOBjiS9dHPOGkYC
	IUd6jmCa6180UVf5pEhgsswIHtZ+ySs5hQM4th0+rQtZKBJe+yQk9fakYjeCzAdc0MEKVp
	fQaJFCz6wWJIJMM6XxnDGImT559Jpy9f4DHLQLJ9wOb3zT1RZW2yEtG7P8+l6S2Wf3KYGy
	kWqcrJ8VlMUoqoBLXb7cQVItdoj1pSm+bB7jMXG7ds+/wwuIhA4iuqScrFlclTpx5bZHC9
	+6tOaQ6iFYTzlBG1C/Tzx9mDJ8+MAqwZEckDeTPSaSwBObQtW3rerJwXtltuvQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Feb 2026 11:18:53 +0100
Message-Id: <DGIV1GKTYP9C.1OMEZARTNTX1U@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 3/4] bitbake-setup: print colored
 diffs
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com> <20260218-improve-bbsetup-readability-v2-3-351584e5df9c@bootlin.com> <DGI6Z0US5NPC.6Y8DAVVEYWRG@bootlin.com> <CANNYZj9grDk3dYjGARxhyca6a++GtHYaSKB0ouxpaoX03NWt+Q@mail.gmail.com>
In-Reply-To: <CANNYZj9grDk3dYjGARxhyca6a++GtHYaSKB0ouxpaoX03NWt+Q@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 10:19:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19065

Hi,

On Thu Feb 19, 2026 at 10:36 AM CET, Alexander Kanavin wrote:
> On Wed, 18 Feb 2026 at 16:27, Antonin Godard via
> lists.openembedded.org
> <antonin.godard=3Dbootlin.com@lists.openembedded.org> wrote:
>
>> Oops, this slipped through, but shouldn't be changed at all since it is =
removed
>> in the next commit. I will resend the series.
>
> Also the function is *way* over-engineered. I only wanted to avoid
> repeating the color logic, so perhaps just this bit could be
> abstracted and used in all three locations?
>
> def get_color_param():
>     return "always" if BBSETUP_COLOR else "never"

Not sure I follow.

def color_enabled() -> bool:
    return logger.handlers[0].formatter.color_enabled

IMO this is better than the previous version which did:

global BBSETUP_COLOR
if args.color =3D=3D 'always' or (args.color =3D=3D 'auto' and sys.stdout.i=
satty() and os.environ.get('NO_COLOR', '') =3D=3D ''):
    BBSETUP_COLOR =3D True

That logic is already present in the logger object, in msg.py, when creatin=
g the
logger:

if color =3D=3D 'always' or (color =3D=3D 'auto' and output.isatty() and os=
.environ.get('NO_COLOR', '') =3D=3D ''):
    format.enable_color()

The proposal here was to get rid of BBSETUP_COLOR entirely and avoid
duplication. Not sure how this is *way* over-engineered, I'd rather see it =
as a
simplification

Antonin

