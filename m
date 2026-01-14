Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463CDD37E59
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 15:55:26 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13471.1768406120100247019
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 07:55:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=OMnJzawe;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 203814E420B2;
	Wed, 14 Jan 2026 15:55:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAE366074A;
	Wed, 14 Jan 2026 15:55:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0814910B6826D;
	Wed, 14 Jan 2026 16:55:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768406117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3+HUCu+K3wTSYZSgvM7PxGMFH7fB89pjHq3Z7tgIQHM=;
	b=OMnJzawes77YxzU+pmbqsD7LhfjZC5d/4l0/iTdcd/6B3llVVfJSkgfoDRVLF3ZdeB7mnr
	fG7sUrzz9/g26a1VQosoSnWPb6vlvpGOFcM1anwx0WyS2KRnLLnn6fsY68iF3+kuJ5zORI
	6TpK2HKSI+rSE28rGuofKSFTt9sVhRuNF8MVaETOng/lqxpb0Z22xxzLf9RGcepIVtW7Kv
	d1fTDQX8doseCwGWhWoVzE4KHUw2H96ZAX2dAcCXUwf11WIWJVIqBlvRnblUT7SzZr5I7P
	si3G2zNl6XMUlLdGAJ9IwOWhD9nKWz+xiHGPUfENuHs7aOZvMtNzXWVQNf11Ug==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jan 2026 16:55:15 +0100
Message-Id: <DFOFNE5RSKSK.XVWT4WC911UE@bootlin.com>
To: <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [RFC] bitbake-setup: Documentation terminology
 and tooling suggestions
Cc: <otavio.salvador@ossystems.com.br>,
 <bitbake-devel@lists.openembedded.org>, "Patches and discussions about the
 oe-core layer" <openembedded-core@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com> <DFOEW0JK0R5M.RI0FHSXWERO2@bootlin.com> <CANNYZj-YDD6-K=6W5mvEXRgQwm3XmbqAhhByTzD_givkDjxzmQ@mail.gmail.com>
In-Reply-To: <CANNYZj-YDD6-K=6W5mvEXRgQwm3XmbqAhhByTzD_givkDjxzmQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 15:55:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18758

Hi,

On Wed Jan 14, 2026 at 4:39 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
[...]
>> > 2. Allow Empty Variants in Templates
>> >
>> > Currently, bitbake-setup init requires the user to select a variant wh=
en
>> > one is defined in the template. There is no option to skip this select=
ion.
>>
>> I believe this is already achievable with the --skip-selection option?
>>
>> > Allowing templates without variants (or making variant selection optio=
nal)
>> > would reduce the number of questions during setup, making the process
>> > faster and more approachable for newcomers.
>>
>> Instead of no variants, maybe we just want to instruct the user to run:
>>
>>   bitbake-setup init --non-interactive choice1 choice2 ...
>>
>> Another idea would be to make it possible to define default choices
>> in an existing template? The documentation would then instruct the user =
to
>> simply execute:
>>
>>   bitbake-setup init --non-interactive
>>
>> which, with no choices passed on the command-line, would provide the use=
r with
>> the default variant (the Poky Setup). The default choices would still ha=
ve to be
>> printed on the console to make it clear to the user what was selected.
>
> It would really help to provide an example config template, and use
> that to illustrate usability issues, and proposed improvements. I'm
> afraid I simply am confused by the point 2, and I don't understand the
> issue reported in it, or the suggested solution.
>
> If there are no choices to be made (e.g. only one variant),
> bitbake-setup will pick that without asking. There's also
> --skip-selection option, but it is expressly *not* for newcomers as it
> will result in an incomplete bitbake config. If one wants less
> questions, then they should remove variants from the configuration
> template, otherwise bitbake-setup needs to pick something from several
> choices one way or another.

I think the point here is that newcomers reading the documentation will use=
 the
default registry and not a custom configuration template, and that it would=
 be
more user-friendly to _not_ make the user choose options from the default
registry.

That being said=E2=80=A6 I think it was the intention of the project to giv=
e the user the
option to choose. I don't really have an opinion on whether the user should
choose or not choose at the moment.

On that note, if we go the "user has to choose every option" way, I think i=
t
would be nice to have a description of built-in fragments too.

If you read this as a newcomer:
=20
  Target machines:
  1. machine/qemux86-64
  2. machine/qemuarm64
  3. machine/qemuriscv64
  4. machine/genericarm64
  5. machine/genericx86-64

  Please select one of the above options by its number:

  Distribution configuration variants:
  1. distro/poky
  2. distro/poky-altcfg
  3. distro/poky-tiny

  Please select one of the above options by its number:

I'm not sure a newcomer would know what to choose here. A description would
probably help. It's also a simple addition I guess?

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


