Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C86D20687
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 13:17:06 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43164.1764854222004365144
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 05:17:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=yNi8UMgN;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DBACE1A1F49;
	Thu,  4 Dec 2025 13:16:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB02860731;
	Thu,  4 Dec 2025 13:16:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 354101192257B;
	Thu,  4 Dec 2025 14:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764854218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aiXr+ZslzDLiabryIa040gNW/9IdfMsJ8079MP63BnQ=;
	b=yNi8UMgNPAlt8PoKXQry+SMtuz2ACq4PUAaIXxR4peSe8SDQPGSAHlxCUMrhi3+BKkin3l
	/xu8c81lz/WxDIx4QCNBcYLD8zff2n8xvMCKYfSDZoSSdJzII/7jwjj/iyHE9Df350IdgN
	7+1kJN8ijKT4/fYJIc6QhWe3/NJJCBTYa4kzonViGivZ5vBMKI8R8FxNMXQtgtsO6E3RaT
	piSxb7Ti1c40beDVLSLPmhbE6wjDVq1uyIzGCTRl7Phzk3R8LP4gi0cD0eKCSTNb++lXu2
	5VvEFpTxYsTvxNMV3SN5hK7jXuykkoQNFyUpsPyuHR8D58Cy4h7VsdqyvpZ2rw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 14:16:56 +0100
Message-Id: <DEPGLUEBY8HP.2A72US2T78IKO@bootlin.com>
Cc: <docs@lists.yoctoproject.org>, "Quentin Schulz"
 <quentin.schulz@cherry.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH 2/3] doc: bitbake-user-manual-intro: specify
 inherit_defer directive for recipe classes
X-Mailer: aerc 0.21.0-30-g0177c1d31447
References: <20251203-doc-file-include-require-v1-0-fc708832b475@cherry.de>
 <20251203-doc-file-include-require-v1-2-fc708832b475@cherry.de>
In-Reply-To: <20251203-doc-file-include-require-v1-2-fc708832b475@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 13:17:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18543

On Wed Dec 3, 2025 at 6:06 PM CET, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> We specify the recipe classes must be used with inherit but they can
> actually also be used with inherit_defer directive so let's make that
> clear.
>
> Fixes: 7bd36f6c6d33 ("doc: extend classes and include/require documentati=
on")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/=
bitbake-user-manual/bitbake-user-manual-intro.rst
> index 2875e18f3..329b02829 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -220,9 +220,10 @@ BitBake supports class files installed in three diff=
erent directories:
>        INHERIT +=3D "myclass"
> =20
>  -  ``classes-recipe/``: these classes must be inherited from a recipe us=
ing the
> -   :ref:`inherit <ref-bitbake-user-manual-metadata-inherit>` directive. =
They do
> -   not support being inherited globally. For example, you would use the =
recipe
> -   class named ``myclass`` like so::
> +   :ref:`inherit <ref-bitbake-user-manual-metadata-inherit>` or
> +   :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
> +   directive. They do not support being inherited globally. For example,=
 you
> +   would use the recipe class named ``myclass`` like so::
> =20
>        inherit myclass
> =20

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thank you!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


