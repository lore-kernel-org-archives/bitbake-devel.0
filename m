Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3D7CCD182
	for <webhook@archiver.kernel.org>; Fri,  3 Oct 2025 11:55:20 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.5552.1759492515351132128
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Oct 2025 04:55:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=TP4bbcgn;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 31BCEC00D99;
	Fri,  3 Oct 2025 11:54:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1ED9760683;
	Fri,  3 Oct 2025 11:55:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A57CB102F1C3B;
	Fri,  3 Oct 2025 13:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759492512; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iWP6fdggruC9Q8wjaU4INIRsNXA+NahKxIzYeRZQh+c=;
	b=TP4bbcgntufpaTsXiquLyup9QwZcl5XK+ua4JM7T7rvjHvXSCk5WbZMZF/VPOqyC6eCWlw
	4tiNs7N9MUMpgiO2djCDLrR99ryRuhzOB+B2DWjAIdNqyKM6/qPHBJX93FmhLVAhGru7Pz
	+Az1pv99TfksYE18s/xR2vZ7zlQXZ1OBxkOUwQrlVrLy8+6h3QFkq4cfFYRZajSGlJw969
	COQGpmLMAx/Ycbao9XeOji5+NddMBxOs9kNSsMhQybU2LjIS5tGA4tV23tXlO3jnie3Mle
	zVzvB+G5ENMENsq3AaubEzd2n4pIw5I7aWHTaEL0I5Wcl8YOpFJFoFeZuomAmQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Oct 2025 13:55:09 +0200
Message-Id: <DD8O1G6S52MQ.2RRPD9QVIHT6O@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <adam.blank.g@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-user-manual-ref-variables:
 improve INHERIT
References: <20251001093743.26710-1-adam.blank.g@gmail.com>
In-Reply-To: <20251001093743.26710-1-adam.blank.g@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 11:55:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18130

On Wed Oct 1, 2025 at 11:37 AM CEST, Adam Blank via lists.openembedded.org =
wrote:
> Current wording makes it difficult to understand what
> exactly is done with INHERIT-ed anonymous functions and
> when.
>
> Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 810f88689..9d0cbd71d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1200,8 +1200,8 @@ overview of their function and contents.
> =20
>     :term:`INHERIT`
>        Causes the named class or classes to be inherited globally. Anonym=
ous
> -      functions in the class or classes are not executed for the base
> -      configuration and in each individual recipe. The OpenEmbedded buil=
d
> +      functions in the class or classes are executed either for the base
> +      configuration, or in each individual parsed recipe. The OpenEmbedd=
ed build

I ran a quick test, and I do see the anonymous function called for individu=
al
recipes, but I have trouble understanding what the "base configuration" is.=
 Does
this mean the anonymous function is also called in the top-level context /
top-level configuration, with no recipes associated to it?

The original sentence could be interpreted differently IMO, and I would hav=
e
phrased it this way:

"""
Anonymous functions in the class or classes are not executed for the base
configuration but are executed in each individual recipe.
"""

Which is what I observe when testing=E2=80=A6 I don't see any call to it wi=
thout an
associated recipe.

What do you think?

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


