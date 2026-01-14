Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89F9D37E41
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 15:19:35 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12651.1768403974063731700
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 07:19:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=PUHYoKwk;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 16E524E420D7;
	Wed, 14 Jan 2026 15:19:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E14056074A;
	Wed, 14 Jan 2026 15:19:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A009610B68265;
	Wed, 14 Jan 2026 16:19:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768403971; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0zSRvIFKsGt8FjBzOVTm6OpBXmaI/vVK/rUEyDbHXuE=;
	b=PUHYoKwkC+ZYHMZK31MmHRB73K3gzrPEDR/pubWWJx/d0UQHEW4+i4QvgmPXj1iTMd/s8r
	YVQD7gyemcJmfT95MMsCJIVMXh/3OXdJMgqtkmp5Y8Hw5wyt0s8MY2mAY56Bqt+4iPyA1I
	jev01ihhMkIbcPefnQfxEnozTh8MKilH5C55uV6mc99holf0YzthiVJBAwfcnZJtAtFkcF
	wel79Tr1Ir+W6ilTeCfX5U/bFqbmYhjYWCszsPJfUCW0amBH1WONgHxSYvybR25805aKTD
	AsT3YCFhC7/uu4jUgZBHXxb6oZCsoFHRmECSL10Ndoa1ux9u2TvukHOQpo2AfA==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jan 2026 16:19:29 +0100
Message-Id: <DFOEW0JK0R5M.RI0FHSXWERO2@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <otavio.salvador@ossystems.com.br>,
 <bitbake-devel@lists.openembedded.org>, "Patches and discussions about the
 oe-core layer" <openembedded-core@lists.openembedded.org>
Subject: Re: [bitbake-devel] [RFC] bitbake-setup: Documentation terminology
 and tooling suggestions
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
In-Reply-To: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 15:19:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18755

Hi,

On Wed Jan 14, 2026 at 1:02 AM CET, Otavio Salvador via lists.openembedded.=
org wrote:
[...]
> 1. Generic Configuration =E2=86=92 BitBake Setup Template
>
> The term "Generic Configuration" does not immediately convey that this is=
 a
> reusable template file used as input to create a build environment. The
> word "generic" can be interpreted as "basic" or "non-specialized" rather
> than "reusable template."
>
> We suggest *BitBake Setup Template* as an alternative. This clearly
> communicates that the .conf.json file serves as a template for creating
> setups.
> 2. Specific Configuration =E2=86=92 BitBake Setup Instance
>
> Similarly, "Specific Configuration" does not clearly indicate that this i=
s
> the *result* of applying a template with user choices. The relationship
> between "Generic" and "Specific" is not immediately obvious.
>
> We suggest *BitBake Setup Instance* as an alternative. The "Template =E2=
=86=92
> Instance" pattern is widely understood by developers and immediately
> conveys the relationship: a template is used to create an instance.

I like the Template/Instance suggestion, but I'm not sure about removing th=
e
word "configuration" out of these terms. We are speaking about the
_configuration_ of a Setup after all, and "BitBake Setup Instance" could be
misinterpreted as a running bitbake-setup execution.

So maybe:

  Bitbake Setup Configuration Template
  Bitbake Setup Configuration Instance

or simply:

  Configuration Template
  Configuration Instance

Would be enough. Having "BitBake Setup" prefixing every occurrence of this =
term
is going to be too much otherwise?

What do you think?

> 3. Nested "configurations" =E2=86=92 Variant
>
> Within a BitBake Setup Template, there are nested "configurations" (e.g.,
> poky, poky-with-sstate) that represent predefined bundles of fragments an=
d
> settings. Using "configuration" here creates confusion since the term is
> already heavily overloaded in the Yocto ecosystem.
>
> We suggest *Variant* as an alternative. This conveys that these are
> different flavors or variations of the same base template, similar to how
> distributions have variants or flavors.

That sounds good to me, but would you also define a Variant as its own term=
 (in
the glossary)?

[...]
> 2. Allow Empty Variants in Templates
>
> Currently, bitbake-setup init requires the user to select a variant when
> one is defined in the template. There is no option to skip this selection=
.

I believe this is already achievable with the --skip-selection option?

> Allowing templates without variants (or making variant selection optional=
)
> would reduce the number of questions during setup, making the process
> faster and more approachable for newcomers.

Instead of no variants, maybe we just want to instruct the user to run:

  bitbake-setup init --non-interactive choice1 choice2 ...

Another idea would be to make it possible to define default choices
in an existing template? The documentation would then instruct the user to
simply execute:

  bitbake-setup init --non-interactive

which, with no choices passed on the command-line, would provide the user w=
ith
the default variant (the Poky Setup). The default choices would still have =
to be
printed on the console to make it clear to the user what was selected.

[...]
> 5. Fragment Discovery on OpenEmbedded Layer Index
>
> The OpenEmbedded Layer Index (https://layers.openembedded.org) is an
> excellent resource for discovering layers. However, there is no equivalen=
t
> discovery mechanism for configuration fragments.
>
> Adding a tab or section for fragments would help users discover available
> fragments and understand what problems they solve.

Good idea IMO, as we already have machines and distros there, fragments wou=
ld be
a nice addition.

Thanks for looking into this!

Regards,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


