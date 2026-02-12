Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37409EB48E6
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:49:53 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41348.1770886190482364500
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Feb 2026 00:49:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=0Vq1wZcU;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4C91B1A0E26;
	Thu, 12 Feb 2026 08:49:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BBB7606CA;
	Thu, 12 Feb 2026 08:49:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 116BB119714E9;
	Thu, 12 Feb 2026 09:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770886187; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BUua2cunn4P7bxLxTnUli0TClKXDNmt3virjB94rN1s=;
	b=0Vq1wZcUzUCkkGCcHrFHXtHUfmf1dUPh7uOr5ZP4x5/BSluv8hhkmoIUpFdTxdJPXi0tz4
	/hAJzg/bneOVyGWXqq4G4fh/4W2zNlH5+n9nZI8d+MeTMeis3l9QZVhFJoZkUhTWcUooV2
	cdi6uvZfWZrQH6s9BMIUeTzh9myxb2wdERbPcqfLOKYf3cteMceAmpcdP2PdMzFCEuOd+B
	UJDHGH88lx5lbTDFKbwANNx74ed+8zg0FJuAV+5dcZzeuGtdJffCl+nboIDfcnYwDset7n
	kwePvEgXp67dyg2OxRx5hVjvjTMCs/yPHnDImrtrOuXHke6BawSTmVNWb+RW3w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 09:49:45 +0100
Message-Id: <DGCUREOACEVG.3QW902HRYGH28@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <foss@0leil.net>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH 1/4] doc: bitbake-user-manual-ref-variables:
 clarify BBMASK directory matching
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 <docs@lists.yoctoproject.org>, "Quentin Schulz" <quentin.schulz@cherry.de>
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
 <20260211-bbmask-slashes-v1-1-b72161c647ef@cherry.de>
In-Reply-To: <20260211-bbmask-slashes-v1-1-b72161c647ef@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 08:49:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19014

Hi,

On Wed Feb 11, 2026 at 7:06 PM CET, Quentin Schulz via lists.yoctoproject.o=
rg wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> BBMASK matches files in the directories matching the regex, and also in
> their respective subdirectories, so make that clear in the wording
> leading to the example.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 4b3b10d46..18bbd638d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1051,8 +1051,8 @@ overview of their function and contents.
>        documentation at http://docs.python.org/3/library/re.html.
> =20
>        The following example uses a complete regular expression to tell
> -      BitBake to ignore all recipe and recipe append files in the
> -      ``meta-ti/recipes-misc/`` directory::
> +      BitBake to ignore all recipe and recipe append files in
> +      ``meta-ti/recipes-misc/`` directories (and their subdirectories)::

If I follow: this will mask multiple occurrences "meta-ti/recipes-misc/". H=
ow
could there be more than one in practice? How could this ever happen?

Wouldn't:

"""
The following example uses a complete regular expression to tell
BitBake to ignore all recipe and recipe append files in the
``meta-ti/recipes-misc/`` directory and its subdirectories::
"""

be less confusing?

Antonin

