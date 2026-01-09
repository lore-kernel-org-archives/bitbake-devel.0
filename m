Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E437FD167F1
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 09:40:46 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6811.1767951636139230949
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 01:40:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=YxgF/gwA;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 26FDA4E4201C;
	Fri,  9 Jan 2026 09:40:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F23D460734;
	Fri,  9 Jan 2026 09:40:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C7C3103C87CC;
	Fri,  9 Jan 2026 10:40:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767951633; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NndjMPydbeBKZh0922Nha0YeSIkTb9s7y9yDSTDp4Cw=;
	b=YxgF/gwAJnfM5MNU3qIVMCqJFdpsz/kBc93UQ8w1Y90LfGC6sonLywzBs+QpzgXR2o9QzH
	j4OnOSKmR6553cirAITKIJEQRlo1GPinQxmk9ug3We5f3EpykijSEG+a0GBaJ5n/uM1t6P
	iUIGn8QTll3xHaKE0eOoRD9UD/lOi3GdpOTGri4oEffkJUWfmtUgqfrED1pjUd/e6b+aUv
	jFGkWxhvR7NQBSKdGV+olHIIZ7R4a7Sem5zuo0beDf91nT+BS1R/9Af1oyMvEIO2IV3uEv
	wt74kVs3CTYs+yxRUZ7MiQr3FDr/E+rpiVvhL+xQDacZLMjYOgc+ZF2wh+IIkg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Jan 2026 10:40:32 +0100
Message-Id: <DFJYJRINA08I.9HHIYNCUZJSL@bootlin.com>
Cc: "BitBake developer list" <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, "YP docs mailing list"
 <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH] doc: use monospaced font for visual
 clarity of options
X-Mailer: aerc 0.21.0-45-g839807923d24
References: <569a2da6-6603-5c64-bf27-da55484a7966@crashcourse.ca>
In-Reply-To: <569a2da6-6603-5c64-bf27-da55484a7966@crashcourse.ca>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 09:40:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18719

On Thu Jan 8, 2026 at 5:25 PM CET, Robert P. J. Day wrote:
>
> Use monospaced font for command options, to make it clear when double
> dashes are being used.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   since i saw an example of this being done in the same chapter
> of the bitbake manual without quotes, i chose to do it that way.
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/=
bitbake-user-manual/bitbake-user-manual-intro.rst
> index 329b02829..4e70eaf9d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -538,7 +538,7 @@ The following command runs the clean task on the ``fo=
o.bb`` recipe file::
>
>  .. note::
>
> -   The "-b" option explicitly does not handle recipe dependencies. Other
> +   The ``-b`` option explicitly does not handle recipe dependencies. Oth=
er
>     than for debugging purposes, it is instead recommended that you use
>     the syntax presented in the next section.
>
> @@ -553,7 +553,7 @@ dependencies, both for build-time and runtime. There =
must be a way for
>  you to express recipe preferences when multiple recipes provide the same
>  functionality, or when there are multiple versions of a recipe.
>
> -The ``bitbake`` command, when not using "--buildfile" or "-b" only
> +The ``bitbake`` command, when not using ``--buildfile`` or ``-b`` only
>  accepts a "PROVIDES". You cannot provide anything else. By default, a
>  recipe file generally "PROVIDES" its "packagename" as shown in the
>  following example::
> @@ -561,7 +561,7 @@ following example::
>    $ bitbake foo
>
>  This next example "PROVIDES" the
> -package name and also uses the "-c" option to tell BitBake to just
> +package name and also uses the ``-c`` option to tell BitBake to just
>  execute the ``do_clean`` task::
>
>    $ bitbake -c clean foo

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


