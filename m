Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A03CCF9FE
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 15:00:22 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23079.1762182019118897886
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 07:00:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=OhzIZ2tX;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EA7901A1848;
	Mon,  3 Nov 2025 15:00:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B541460628;
	Mon,  3 Nov 2025 15:00:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1787F10B50130;
	Mon,  3 Nov 2025 16:00:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762182016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cnA9ixgsXiI0a9ZxBsILKCCbFKTlsqAmEDuMSGIO4X8=;
	b=OhzIZ2tXELFfUoVolz3kYvfXdh0GvAVOeM8liIwo9OfQpXfTX23wK1t3iuHyDnGbAXfLpv
	frcjjCWB1jfxp/J2RZgwDqAskvKkNJNSAKgQYPYGCVFdN3nhmiaOKB1mR9dWbZKqiybcCz
	rn2UE0a311vm9e7m8WLpswtqnbDnd1qlZUcfL/me6l8cvIUoKch6WSnefAiPhwplqJnBP9
	eCOhZM0IYe4UbMRSrMD7kWm9o2mhWn+oVMOwl6gSTSmCC/9mbqc6R8O+kBlBhIREdSVeMw
	7PmuYdj20NZTwK6ZdOB/LkiT5RH4dJUNUK7I8vUj7nD0W62Tv8Xtk2YMmC+0bw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 16:00:14 +0100
Message-Id: <DDZ5E1Q83MQ8.XEVR52YBZS0T@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: rename 'build' ->
 'setup'
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <20251103135759.1129769-1-alex.kanavin@gmail.com>
In-Reply-To: <20251103135759.1129769-1-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 15:00:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18239

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

While writing the documentation for bitbake-setup I was confused myself abo=
ut
this, which lead to renaming it "setup". Hopefully the documentation patch =
I
will send (soon-ish) will clear things out further.

Acked-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


