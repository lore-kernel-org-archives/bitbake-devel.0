Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12773CD5BB3
	for <webhook@archiver.kernel.org>; Fri, 22 May 2026 15:39:42 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19471.1779464380002435814
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 May 2026 08:39:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=sqFTAjiq;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 187AC1A3670
	for <bitbake-devel@lists.openembedded.org>; Fri, 22 May 2026 15:39:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA26D6003C;
	Fri, 22 May 2026 15:39:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8956C1081051D;
	Fri, 22 May 2026 17:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779464377; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NFOUnfa4PtwWlquEqby0TQXH+vDxitNQUBgee5/6j1U=;
	b=sqFTAjiqY3zuwoLQuBVbFAOTerpqH45pJQDqKWmmhqNb5n/IybKmwuNrLWd/DbTcMekq5G
	d940aNvyc1ZniSF2SC52DK9uKQaokJjkwo9tFd5V1GyKot1TLUUEBFgt1ZWftlB05iYtWf
	OomOoc4G2jyrJRti+7m8Brm4NkMnmpBDVy7ZGOUygg3tgzWjom1omfDIYLok47C+25tp10
	BYxE9B6qE2EZzM4twUZAvGPWXjgT0xEsHP89VgTiru95B8RFzS7LP7pJ4E6pdt18ClDjQ/
	6rsvORzIK2UNBwH3TyAg74AAbpyl7xyN+kwcsRYRa+iBe7wB0qJQqUmqgMb5ag==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 17:39:34 +0200
Message-Id: <DIPBH4ELBFTQ.224CE5TZWAOUH@bootlin.com>
To: <bijak.dawid@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH v4] doc: bitbake-user-manual-metadata: document
 inherit_defer limitations
Cc: <docs@lists.yoctoproject.org>, <quentin.schulz@cherry.de>,
 <richard.purdie@linuxfoundation.org>, <mathieu.dubois-briand@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-124-gaeabb20698f9
References: <20260516191137.11033-1-bijak.dawid@gmail.com>
In-Reply-To: <20260516191137.11033-1-bijak.dawid@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 May 2026 15:39:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19550

On Sat May 16, 2026 at 9:11 PM CEST, Dawid Bijak via lists.yoctoproject.org=
 wrote:
> Add a warning explaining that anonymous Python functions cannot be
> used to influence inherit_defer, since they run after the directive has
> already been resolved.
>
> Also rename VARNAME to VARIABLE for consistency throughout the
> documentation.
>
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
> ---
>  .../bitbake-user-manual-metadata.rst           | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 0c7c3ff99..134cf8ff1 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -827,17 +827,17 @@ the variable after the line is parsed will take eff=
ect. With the :ref:`inherit
> =20
>  Here is an example::
> =20
> -   inherit_defer ${VARNAME}
> +   inherit_defer ${VARIABLE}
> =20
>  One way to achieve a conditional inherit in this case is to use
>  overrides::
> =20
> -   VARNAME =3D ""
> -   VARNAME:someoverride =3D "myclass"
> +   VARIABLE =3D ""
> +   VARIABLE:someoverride =3D "myclass"
> =20
>  :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
> -defers the evaluation of ``${VARNAME}`` until the end of
> -parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARNAME}=
``
> +defers the evaluation of ``${VARIABLE}`` until the end of
> +parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARIABLE=
}``
>  expands to ``myclass``, which is then inherited.
> =20
>  Alternatively, you could use an inline Python expression in the
> @@ -853,6 +853,14 @@ In all cases, if the expression evaluates to an
>  empty string, the statement does not trigger a syntax error because it
>  becomes a no-op.
> =20
> +.. warning::
> +
> +    Setting or modifying variables within an :ref:`anonymous Python func=
tion
> +    <bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python F=
unctions>`
> +    will have no impact on the value of that variable in an
> +    :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>=
` directive
> +    as the function runs after the directive has been resolved.
> +
>  See also :term:`BB_DEFER_BBCLASSES` for automatically promoting classes
>  ``inherit`` calls to ``inherit_defer``.
> =20

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

