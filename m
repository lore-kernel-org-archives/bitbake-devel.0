Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F27EA3F21
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 08:20:03 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15478.1770711592976183701
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Feb 2026 00:19:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=lXXaofLr;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D83304E40BDF
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 08:19:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC759606BD;
	Tue, 10 Feb 2026 08:19:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 659CA119D0D34;
	Tue, 10 Feb 2026 09:19:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770711590; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oFNpgAQGK58B5qVpGjces356xNxFcycMU9oiIcB5OMQ=;
	b=lXXaofLrcxhN/NoNsWeTbY0R7D7gsdHAFu4CgWzL/Q87nYGDSH6Y2oDUJaoOoD2eAOjSti
	PncEuSc75vZE32NwkyCqZJaOJExg/7T+zj/XssjBuwP85kIzrFUHOP8y/I7gfa4Jj8yrCl
	otzDUo37EJvILmlZYsp3vpG884+qRRm55P+xsZ4te9LPXb4kvtnOzFSpGDTFlb89MAUzEv
	pSVYkMsEoSYo0FC1P8cO5ouibOTB9Kyh2u1I2VtPbYmCV5hsuFNn/89J3r2K4mcZWtR8fR
	c4PVS4BjhW1kM3c2aG/2VnQbuCkCUWiEraO2orlijFj6hEWlMRwm+4dvFmK5Pw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 09:19:48 +0100
Message-Id: <DGB4VE2SE6YL.15KM70MB35WCP@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Rob Woolley" <rob.woolleywr@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pypi
 packaging
Cc: <bitbake-devel@lists.openembedded.org>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
 <20260127160508.3392732-3-rob.woolley@windriver.com>
 <DG0C8LN6ZUK1.3ACK0646PJ6FP@bootlin.com>
 <CAGAhMByPhay1XoWjj3DwSk0gOq7VinrQvprA2=h=uvJcJrE_4w@mail.gmail.com>
In-Reply-To: <CAGAhMByPhay1XoWjj3DwSk0gOq7VinrQvprA2=h=uvJcJrE_4w@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 08:20:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18996

Hi,

On Mon Feb 9, 2026 at 9:19 PM CET, Rob Woolley wrote:
> Hi Antonin,
>
> Thanks for the feedback.  Sorry for the delay.  I am about to push the
> changes Alex asked for so I am revisiing your comments.
>
> On Wed, Jan 28, 2026 at 10:47=E2=80=AFAM Antonin Godard via lists.openemb=
edded.org
> <antonin.godard=3Dbootlin.com@lists.openembedded.org> wrote:
>
>> Hi,
>>
>> On Tue Jan 27, 2026 at 5:04 PM CET, Rob Woolley via lists.openembedded.o=
rg
>> wrote:
>> [...]
>> > diff --git a/contrib/pypi/README.md b/contrib/pypi/README.md
>> > new file mode 100644
>> > index 00000000..a6dd99e0
>> > --- /dev/null
>> > +++ b/contrib/pypi/README.md
>> > @@ -0,0 +1,42 @@
>> > +# bitbake-setup
>> > +
>> > +This package provides the `bitbake-setup` command and the Python modu=
les
>> > +required to support BitBake setup and configuration.
>>
>> s/BitBake setup/`bitbake-setup`/
>>
>
> I don't believe this change is correct as the bitbake-setup module suppor=
ts
> the setup and configuration of BitBake.
>
> Otherwise we are saying that bitbake-setup supports setting up and
> configuring bitbake-setup.

You are right, sorry for the noise

[...]
>> Wondering if it would be possible to include the
>> doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst file h=
ere
>> instead of a custom README?
>>
>> We will likely forget about the above README.md file, and that's one mor=
e
>> file
>> to maintain. If the README needs to be next to the other file, maybe
>> create a
>> symlink to bitbake-user-manual-environment-setup.rst?
>>
>
> That is fine by me.  However, we will need to ensure that the .rst is
> validated and appropriate for PyPI:
> https://packaging.python.org/en/latest/guides/making-a-pypi-friendly-read=
me/
>
>
> When I look at that page now it doesn't seem tailored for PyPI:
> https://github.com/openembedded/bitbake/blob/master/doc/bitbake-user-manu=
al/bitbake-user-manual-environment-setup.rst
>
> It seems to be > 25 pages long which seems too long.  Can we create a
> condensed version with the basics and a link to the formal documentation?

Yes, if the rst document does not conform with pypi, I would be very brief =
and
link to the original documentation. We may do this differently in the futur=
e,
but for now I think this is enough

(perhaps the "quick start" section of bitbake-user-manual-environment-setup=
.rst
could be shared between pypi's docs and the official doc, with some rST inc=
ludes
- but let's postpone for later).

Thanks!
Antonin

