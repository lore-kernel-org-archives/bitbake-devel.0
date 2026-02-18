Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B0E9A047
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 15:27:22 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14407.1771428439092348419
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Feb 2026 07:27:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=MUtIDsJ2;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B4F65C6345B
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 15:27:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC5C55FA23
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 15:27:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D19710368BB1;
	Wed, 18 Feb 2026 16:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771428436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BBq4Jjp1pZ1RW1+jFj5RGV9/vVMDHPsrDc4eSZrEWoI=;
	b=MUtIDsJ2Zkap4+mhEww+62wbUVW5/espzkkT0q0Mog9kEQYXyzzdh+4eEL6D7jFnqkabuo
	P/vVgqDQWdxAG0ZUDqy5onX3WCY1YbozxK1fXkOTnv3GY/baIUkp+bZcBw5tV1kO8I88lx
	F6qwMxGMU4TAAorhDb0XA2cFKBVY/JO8ijjWSpxz7wxTuHYUlINuFlNi/EZ3XLUOu1bBsL
	PDW1JTUWnvDteUlI9b7WUbqFtpIj/l1/c+o4wpfj4r/iGunrACjK3rVWDTlgdW7xa0Lj9P
	onPss+Vq31E72NqokvkgqPjNoU6fwH4w2YpWgdnJatN+ePm8+qkBfDrEAtJu8Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 16:27:15 +0100
Message-Id: <DGI6Z0US5NPC.6Y8DAVVEYWRG@bootlin.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2 3/4] bitbake-setup: print colored diffs
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Antonin Godard"
 <antonin.godard@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com> <20260218-improve-bbsetup-readability-v2-3-351584e5df9c@bootlin.com>
In-Reply-To: <20260218-improve-bbsetup-readability-v2-3-351584e5df9c@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 15:27:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19063

Hi,

On Wed Feb 18, 2026 at 2:15 PM CET, Antonin Godard wrote:
[...]
> @@ -728,7 +761,9 @@ def init_config(top_dir, settings, args):
> =20
>  def get_diff(file1, file2):
>      try:
> -        bb.process.run('diff -uNr {} {}'.format(file1, file2))
> +        bb.process.run('diff --color=3D{} -uNr {} {}'.format("always" if=
 BBSETUP_COLOR else "never",
> +                                                           file1,
> +                                                           file2))

Oops, this slipped through, but shouldn't be changed at all since it is rem=
oved
in the next commit. I will resend the series.

Antonin

