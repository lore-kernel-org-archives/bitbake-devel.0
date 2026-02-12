Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B7EEB48EA
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:58:53 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41429.1770886722666564244
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Feb 2026 00:58:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=oGgAQJmz;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3146C1A0E3C;
	Thu, 12 Feb 2026 08:58:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0673A606CA;
	Thu, 12 Feb 2026 08:58:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A492C1197006A;
	Thu, 12 Feb 2026 09:58:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770886720; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B2xmERMrVkyJupYiJ7jTFsTzQBaWZzieHMmiEmRl8cw=;
	b=oGgAQJmzqdPhilbXOzYVNW1XnY8x46LNMLZbxiEryGA6sCUDUJ90/P7PdICENsIPVHX/ZC
	Y6CjMySp1Pavqvoox0c5b0jNb+a23qeyMNFr6Vz3HqLyHgDOaU5VsKrNNtpp4fYNLqvNQm
	2bCH1GTBhFmglbf4q2mJnOfiiKRHVV0k6sAn45UD+2FyS9ma8RFfRo7mc2PhUEbqszfIhI
	YSEAFKkuwlTcZZ9BG5dEIU3Hn+DHyVj0eX/aAWm5t9GmlsmJTUFSmYA3HjJ9roXwJX1KAc
	vXzjsZj1vM1SRCU0UE3shAHXIp7E9mBU/QEOxtNlnG6LXCijq5k9k/razgj1DA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 09:58:39 +0100
Message-Id: <DGCUY7U4ZJZE.1Y4VMQEELJUO@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <foss@0leil.net>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH 3/4] doc: bitbake-user-manual-ref-variables:
 clarify BBMASK matching patterns
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 <docs@lists.yoctoproject.org>, "Quentin Schulz" <quentin.schulz@cherry.de>
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
 <20260211-bbmask-slashes-v1-3-b72161c647ef@cherry.de>
In-Reply-To: <20260211-bbmask-slashes-v1-3-b72161c647ef@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 08:58:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19015

Hi,

On Wed Feb 11, 2026 at 7:06 PM CET, Quentin Schulz via lists.yoctoproject.o=
rg wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The documentation doesn't explain the side-effect of putting a leading
> slash, only the trailing slash.
>
> The leading slash is not for making the regular expression match an
> absolute path, but to force the match on the directory or file that
> exactly starts (and ends if there is a trailing slash) with the
> specified string.
>
> Finally, this also explains that this still doesn't prevent more than
> the intended path to be caught up, specifically because it is NOT a
> regular expression matching an absolute path. For that though, the user
> can use BBFILE_PATTERN set for the layer they want to mask the recipe or
> append files to BitBake. This is typically a regex starting with
> ^${LAYERDIR}, making it an absolute path matching.
>
> Let's document those limitations.
>
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  .../bitbake-user-manual-ref-variables.rst          | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index f20a9012c..6612dcc03 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1071,6 +1071,28 @@ overview of their function and contents.
>           When specifying a directory name, use the trailing slash charac=
ter
>           to ensure you match just that directory name.
> =20
> +      .. note::
> +
> +         The leading slash in a regular expression in :term:`BBMASK` doe=
s not
> +         mean the path is absolute. It simply forces the directory to be=
 named
> +         exactly that. Take::
> +
> +            BBMASK =3D "meta-ti/recipes-bsp/"
> +
> +        If you happen to have a directory ``my-meta-ti/recipes-bsp``, it=
 will
> +        be matched.
> +
> +        Leading with a slash::
> +
> +           BBMASK =3D "/meta-ti/recipes-bsp/"
> +
> +        makes sure that doesn't happen. However, this doesn't prevent ma=
tching a
> +        directory ``meta-foo/meta-ti/recipes-bsp``. For that, use the
> +        appropriate :term:`BBFILE_PATTERN` to only match a directory fro=
m one
> +        specific layer::
> +
> +           BBMASK =3D "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"

So this looks this is actually what most users want to do, right? Wouldn't =
it be
better to put this forward instead of in a note, say, at the beginning of t=
he
definition?

For example, replacing the first example in the variable's definition by:

-The following example uses a complete regular expression to tell
-BitBake to ignore all recipe and recipe append files in the
-``meta-ti/recipes-misc/`` directory::
-
-   BBMASK =3D "meta-ti/recipes-misc/"
+The following example uses a complete regular expression to tell BitBake t=
o
+ignore all recipe and recipe append files in the ``recipes-misc/`` directo=
ry
+and subdirectories of the ``meta-ti`` layer::
+
+   BBMASK =3D "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"

What do you think?

Antonin

