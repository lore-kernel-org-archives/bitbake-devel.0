Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A1D167F3
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 09:44:46 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6909.1767951881231649830
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 01:44:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=oFrfU6Sb;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B89354E4201C
	for <bitbake-devel@lists.openembedded.org>; Fri,  9 Jan 2026 09:44:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E9B560734;
	Fri,  9 Jan 2026 09:44:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 253FD103C87CC;
	Fri,  9 Jan 2026 10:44:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767951878; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0vzS7XvJPNuvu9FZol2AFvAA7/ZvQIoVRVOCdeSOS7M=;
	b=oFrfU6SbFxjPp3oapyTm/12fPTvX0ZOpQmARRR84ZPfpJ2e2rl8hX+9GCxNTPYSSkdV/Ww
	vFM1+/fHCZIybgdOtAu/VlY4fLTN3ZF0uMmu1se+K5TnU2fEa+yv13GT9i+eI3H/HNE1j/
	QiU6c7se+jztYNahePsV90Gigau+7UUMj7GqjOHcMyH6gPFzAHGd/6Zd9T9aPZlfwTzaKS
	v/S6EAUSuY80YkwGADeoyGZ5Vo4ij/dMiPkv/npT48bxQ1NLTCsfdDnOwaf/a7r5K0dDP7
	uGoViuEqPaJQ+aUExu8r7TJTwqwGHacq4OROtjJMb5AJ0Rcjc5HAduzetcGmIg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Jan 2026 10:44:37 +0100
Message-Id: <DFJYMW8QAZ22.1GOY96LCY19VK@bootlin.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, "BitBake developer list"
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH] doc: bitbake ch 2: use example of nginx to
 explain DEFAULT_PREFERENCE
Cc: "YP docs mailing list" <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <5113f81f-1b33-a4ac-f71d-432caf8e709a@crashcourse.ca>
In-Reply-To: <5113f81f-1b33-a4ac-f71d-432caf8e709a@crashcourse.ca>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 09:44:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18720

Hi,

On Thu Jan 8, 2026 at 11:08 PM CET, Robert P. J. Day wrote:
>
> At the moment, the section on explaining DEFAULT_PREFERENCE uses an
> example of busybox, which does not even use this feature anymore.
> Replace this with an example using "nginx", which does.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/=
doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index d407f59c0..1638a8f5c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -337,21 +337,22 @@ file that BitBake parses, you can change that prefe=
rence::
>
>  .. note::
>
> -   It is common for a recipe to provide two versions -- a stable,
> -   numbered (and preferred) version, and a version that is automatically
> -   checked out from a source code repository that is considered more
> -   "bleeding edge" but can be selected only explicitly.
> -
> -   For example, in the OpenEmbedded codebase, there is a standard,
> -   versioned recipe file for BusyBox, ``busybox_1.22.1.bb``, but there
> -   is also a Git-based version, ``busybox_git.bb``, which explicitly
> -   contains the line ::
> -
> -     DEFAULT_PREFERENCE =3D "-1"
> -
> -   to ensure that the
> -   numbered, stable version is always preferred unless the developer
> -   selects otherwise.
> +   It is not uncommon for a given recipe to provide more than one
> +   version -- a stable (and preferred) version that should be selected
> +   by default, and a newer, development or "bleeding edge" version that
> +   will be selected only explicitly by the developer.
> +
> +   For example, at the moment, in the OpenEmbedded codebase, there are
> +   two versions of the ``nginx`` webserver: a stable "1.28.0" version
> +   that would be selected by default, and a newer "1.29.1" development
> +   version that a developer would need to choose explicitly.
> +
> +   This can be seen based on this snippet from the ``nginx`` 1.29.1
> +   recipe file::
> +
> +      # 1.28.x branch is the current stable branch, the recommended defa=
ult
> +      # 1.29.x is the current mainline branches containing all new featu=
res
> +      DEFAULT_PREFERENCE =3D "-1"

We should consider dropping these kinds of phrasings in favor of generic
examples inspired from real life, e.g. "Consider the following example
recipe...". That way, no maintenance burden like this one.

Anyway, the updated example is fine to me as it is.

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


