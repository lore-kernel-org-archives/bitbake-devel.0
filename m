Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDEACCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 16:03:33 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.888.1762185810132228706
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 08:03:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=vgL/mgh1;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E91B4E414B7;
	Mon,  3 Nov 2025 16:03:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8D9A60628;
	Mon,  3 Nov 2025 16:03:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C9CC10B50169;
	Mon,  3 Nov 2025 17:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762185807; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C0NmxDhxAYwOa8kEldovb8ndwUNBmOmJMnGeCZu9yNU=;
	b=vgL/mgh172du2YCbP4qyFyW/X5ey9MUGajBQOlAF+qC8WDlUyAAaiD+D0d5E3cly6UTzO7
	oDIR/TMEcX00+GgEwUqj+KRUmRKQHtHUNffO/J+bOTwbveoGdO30aHmP/Fqc29iSPrfSrT
	HOXpoFW52IzKL6EioOBgIm6M8dsXhhrt6/WGWSp9Q8j8HN+rO5Qophg2wV1om1l33lIm7T
	cArUEVwB/L7PU/45CKs80bYQvN7oC33HzR/Hj5Ba2s9gdrczvgfUDyzdovmgY2tUjz49GH
	rTB6eVvAoZd2hqwyQc2ez1BXLqK55wZsejuwd8Um4jJnIBGAYnYkJXObxe0eEg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 17:03:25 +0100
Message-Id: <DDZ6QFANRFEB.4MFIOJHGMQ42@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: rename 'build' ->
 'setup'
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251103135759.1129769-1-alex.kanavin@gmail.com>
In-Reply-To: <20251103135759.1129769-1-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 16:03:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18240

On Mon Nov 3, 2025 at 2:57 PM CET, Alexander Kanavin via lists.openembedded=
.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> After a terminology review by Antonin we brainstormed
> something less confusing than 'build' and 'build directory'
> for the place where bitbake-setup clones layers and
> creates a *bitbake* build directory in. People are bound
> to get these two confused and mix them up, and 'setup' is
> much more distinct and aligns nicely with 'bitbake-setup'.
> It's also not claimed by anything else in OE/Yocto.
>
> So before:
>
> top-dir -> build-dir (can be several) -> bitbake build dir, layer dir, co=
nfig dir
>
> Now:
>
> top-dir -> setup-dir (can be several) -> bitbake build dir, layer dir, co=
nfig dir
>
> This also updates the respective command line options, I understand it's
> a breaking change, but as before the tweaks are simple and we need to get=
 the
> terminology right for the users, and now is the time to do it.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---

Note, this will break with current configuration on the autobuilder, we
will have to modify the parameters we pass to bitbake-setup.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


