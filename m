Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D6D20688
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 13:17:06 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43162.1764854221305905841
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 05:17:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=D+DwyVcm;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 65ADDC17862
	for <bitbake-devel@lists.openembedded.org>; Thu,  4 Dec 2025 13:16:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B737D60737;
	Thu,  4 Dec 2025 13:16:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDDA511922578;
	Thu,  4 Dec 2025 14:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764854218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZKzrzxm4t3ALT/N+Bok36gMYv/t8wb2S+jTNF2I7pkY=;
	b=D+DwyVcmk6plYXDqhZ5+LyH4yP55zJGsyEpofoQ5AiaqCVYPbcpJZsE4YcNl3JOxCjwjNE
	o6dXrW/snKQaS+ghowJqaOAkFM7ezOdubvHSCwTgEOAvUFjdiMABMjZIhFU/3pgv4PhtzX
	m+2N6mTXqnZscUz8cfXzkpr4qFxImXSBiiDnFJF0GQ7DzwWfAuK1HBtwtWwMYFO5Fzom8a
	IjcBot1XZ6uUxBte9gtV7wIigzkys9Di5oZop0T3nlIoapKOyGzS+h/vhGQquhPgl3cChV
	Hq64xZhf5BWShBfnUN/HjPz5ZQ90iC4FnwnFN8lRc8hDF7lSfhirwhtRQ7D0hA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 14:16:56 +0100
Message-Id: <DEPGLUAT25P5.1DR1ME2CGN5XQ@bootlin.com>
Subject: Re: [docs] [PATCH 3/3] doc: bitbake-user-manual-metadata: reorder
 introduction on how to locate include files
Cc: <docs@lists.yoctoproject.org>, "Quentin Schulz"
 <quentin.schulz@cherry.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-30-g0177c1d31447
References: <20251203-doc-file-include-require-v1-0-fc708832b475@cherry.de>
 <20251203-doc-file-include-require-v1-3-fc708832b475@cherry.de>
In-Reply-To: <20251203-doc-file-include-require-v1-3-fc708832b475@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 13:17:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18540

On Wed Dec 3, 2025 at 6:06 PM CET, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> BitBake first searches the relative to the local directory before going
> through BBPATH.
>
> Fixes: 7bd36f6c6d33 ("doc: extend classes and include/require documentati=
on")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index ef8ab024d..ef401d4ab 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1054,9 +1054,10 @@ bitbake will treat that as direct value assignment=
 in its configuration::
>  Locating Include Files
>  ----------------------
> =20
> -BitBake uses the :term:`BBPATH` variable to locate needed include files.
> -Additionally, BitBake searches the current directory for :ref:`include
> -<ref-include-directive>` and :ref:`require <require-inclusion>` directiv=
es.
> +BitBake first searches the current directory for needed include files fo=
r
> +:ref:`include <ref-include-directive>` and :ref:`require <require-inclus=
ion>`
> +directives.
> +BitBake also uses the :term:`BBPATH` variable.
> =20
>  .. note::
> =20

Yes, and it's even clearly shown in the example that follows...

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thank you!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


