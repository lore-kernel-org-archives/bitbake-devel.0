Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3587DCCA470
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 09:15:24 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.11534.1759914922315167369
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Oct 2025 02:15:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1TGLeoAy;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 834244E40F88;
	Wed,  8 Oct 2025 09:15:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50C76606E5;
	Wed,  8 Oct 2025 09:15:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D798D102F2193;
	Wed,  8 Oct 2025 11:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759914919; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MrUZP6rvoU4p+x2BMvBOtGsX+henMnw+xg9QBR+0TDg=;
	b=1TGLeoAy8a2rKh2tkgIgIQMVXUiHPIw5MFpHDFv19u1Oa6Bilkxs3bp0RLA7gJWT7Og8Hb
	JDOsxmadK+un/te2XVKtTYvQ2O2mbkUun7t56aMBEL80YbsVSg3+3eiDkpumQWbsgtX+GJ
	k57WMzw/v6Iwr+kcjLBeSysAiV9uQajlvU6ejofqXniKA659axDE00BDHFk9wWcPrm8P2z
	hNkLBAVqtza+YftskhA/dmwTkY3pFrnwmd/ZXNGxYhRjVeygT0QbrQBoUsVtphWXej9uTS
	eh3se5hnVxHY8sSZZnIPpquiOWwIWR+zb6GOWH13+DMFz6bErD/zzIfrL/hASg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 11:15:18 +0200
Message-Id: <DDCTRS0A6C72.13SF4HEOH56TD@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Adam Blank" <adam.blank.g@gmail.com>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v3] doc/bitbake-user-manual-ref-variables: improve
 INHERIT
References: <20251006181951.39364-1-adam.blank.g@gmail.com>
In-Reply-To: <20251006181951.39364-1-adam.blank.g@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 09:15:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18142

On Mon Oct 6, 2025 at 8:19 PM CEST, Adam Blank wrote:
> Current wording makes it difficult to understand what
> exactly is done with INHERIT-ed anonymous functions and
> when.
>
> Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
> Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Changes in v2:
> - Added reference to Parsing The Base Configuration Metadata
> - Emphasised how disjoint the cases are
> Changes in v3:
> - Regenerate the patch previously corrupted by Emacs
>
> ---
>  .../bitbake-user-manual-ref-variables.rst         | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 810f88689..06d48dd47 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1200,9 +1200,18 @@ overview of their function and contents.
>
>     :term:`INHERIT`
>        Causes the named class or classes to be inherited globally. Anonym=
ous
> -      functions in the class or classes are not executed for the base
> -      configuration and in each individual recipe. The OpenEmbedded buil=
d
> -      system ignores changes to :term:`INHERIT` in individual recipes.
> +      functions in the class or classes are executed in two disjoint sit=
uations:
> +
> +      - When only the
> +	:ref:`base configuration <bitbake-user-manual/bitbake-user-manual-execu=
tion:parsing the base configuration metadata>`
> +	is parsed as a result of the following BitBake invocation::
> +
> +	  $ bitbake -e

I guess this is _one_ of the situations where this can happen. Maybe, rephr=
ase
to:

"""
... is parsed. For example, as a result of the following BitBake invocation=
::
"""

> +
> +      - When recipes are parsed - then for each parsed recipe.
> +
> +      The OpenEmbedded build system ignores changes to :term:`INHERIT`
> +      in individual recipes.

This is the Bitbake documentation and Bitbake is not only used by the
OpenEmbedded build system, so we can't have OpenEmbedded references here. S=
o you
could rephrase to:

"""
BitBake ignores changes to ...
"""

Otherwise some documentation syntax nitpicks, not important but for next ti=
me
you will know :) :

* We put two spaces after the "-", like so:

  """
  -  one
  -  two
  """

* We indent code blocks with three spaces usually, like so:

  """
  Here is a code block::

     code
  """

See https://git.yoctoproject.org/yocto-docs/tree/documentation/standards.md=
. We
try to follow those.

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


