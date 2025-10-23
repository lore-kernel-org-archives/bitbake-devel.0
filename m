Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3947CCD193
	for <webhook@archiver.kernel.org>; Thu, 23 Oct 2025 08:09:30 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.15219.1761206960376066531
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Oct 2025 01:09:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=le42f4vR;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 847291A1616
	for <bitbake-devel@lists.openembedded.org>; Thu, 23 Oct 2025 08:09:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B8376062C;
	Thu, 23 Oct 2025 08:09:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60FEE102F245E;
	Thu, 23 Oct 2025 10:09:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761206958; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LE4fOkYhRj0rjR7ycc+/nIEd1GiAMRTlVLdzBfpTNwc=;
	b=le42f4vR65cGn8BRruHqXi8R1VBkB8e5Fh9P/dqiijG5Xm+78RyRDEhX4h8wQ0o3Qceepg
	uJPGixDf+QCMTTtasZYV7COZntfC9i+FIUwCij26BY94T3/O0Pb73UTDjeqozS/e3eOwgz
	OeBk+9IVcE+zuXQ3QowdyoHrkP24EHlKAih+e7hHUF2tRkHPJ2M+Tpfl09GhfuIUG5DLEf
	0ZTBE2pzDSa8IfB1vMmd6FEO7y+fo1/McUroqXUQ6cRisT4lmT0lPAa8cA77QpEJuBypxB
	gR94c6UYJLzCTj5wOP2nbDWMeH+5jakL4pZhFnq2RUYUTPfOileTwvYQFZgR6g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 10:09:15 +0200
Message-Id: <DDPJRDKF6JZ5.W7ZQ9040RD0P@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <adam.blank.g@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/2] Describe AUTOREV and
 SRCREV_FORMAT roles in fetching
References: <20251022175913.13007-1-adam.blank.g@gmail.com>
In-Reply-To: <20251022175913.13007-1-adam.blank.g@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Oct 2025 08:09:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18213

Hi,

On Wed Oct 22, 2025 at 7:59 PM CEST, Adam Blank via lists.openembedded.org =
wrote:
> Fix encountered style issues, add missing variable
> descriptions and references.
> ---
> Changes in v2:
> - abandoned the commit for the UNPACKDIR
> - reworded and fixed typos
>
> ---
> Adam Blank (2):
>   doc: bitbake-user-manual: AUTOREV and SRCREV_FORMAT roles in fetching
>   doc: bitbake-user-manual: style and completeness corrections
>
>  .../bitbake-user-manual-fetching.rst          | 112 ++++++++++++------
>  .../bitbake-user-manual-ref-variables.rst     |  18 ++-
>  2 files changed, 91 insertions(+), 39 deletions(-)

Please, put other people's Reviewed-by in your patch body _after_ said peop=
le
have sent these kind of trailers themselves.

Some details:
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-t=
ested-by-reviewed-by-suggested-by-and-fixes

I would also suggest using b4 which has the `b4 trailers -u` command to
automatically add these to your patches:
https://b4.docs.kernel.org/en/latest/

With that said, for the two patches:

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


