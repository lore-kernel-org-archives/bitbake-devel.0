Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E02BC7113B
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 07:58:14 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.6000.1692863890991160364
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 00:58:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=cwqqZqz0;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: luca.ceresoli@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1B23FF80C;
	Thu, 24 Aug 2023 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1692863888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu0Rsi2sRZ+AYxa4YCmf+1P3ydREz3ITs8wMHOmExKw=;
	b=cwqqZqz0WRjSeAxNAQ/SCIvukud3kipKtUn8gNYZ6b0F6PDjwzgtTXoeyDKR3bEUyySn9R
	Z7fYKbgmz+RcRDfe5Pde5hZwP/8tfxsWHac0wzyWLsR465AvUU7ymXE/Ca3ikKqx/MdiOf
	eagKyf/J+/KJP4TP4qTCX+1YAjVSHO492TD1T7Oj8YxBlEmm0/+umi5xOYEG2nayMG6wfZ
	7aJM1Iw2lGVYWNev2AXbhO46Qmjsh8CM0nZQg0vvF2lN5yDbsPlrLomtJLqWKTa6kC9QR8
	24o/6Fl+QetMvmaK7myJ/d0oxiVvyPJil3CyYzHORjxps34EzmgvuN45mHm4gQ==
Date: Thu, 24 Aug 2023 09:58:06 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Paulo Neves" <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/1] siggen.py: Improve taskhash
 reproducibility
Message-ID: <20230824095806.356563f2@booty>
In-Reply-To: <20230822203350.264625-1-paulo@myneves.com>
References: <20230822203350.264625-1-paulo@myneves.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 07:58:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14969

Hello Paulo,

On Tue, 22 Aug 2023 20:33:58 +0000
"Paulo Neves" <paulo@myneves.com> wrote:

> file checksums are part of the data checksummed
> to generate the task hash. The list of file checksums
> was not ordered.
> 
> In this commit we make sure the task hash checksum takes
> a list of checksum data that is ordered by unique file name
> thus guaranteeing reproducibility.
> 
> Signed-off-by: Paulo Neves <paulo@myneves.com>

Lots of errors like the following on the autobuilders are possibly
caused by this patch:

Hash for task dependency pseudo-native:do_populate_sysroot changed from f4435f759ac00c51c07eaa840d9d61249f38f82d39a8dbffa4e8f599d874a3c6 to 07a200198639768d86d5c2c654fcbd0d4ea23d333e735848ac22c12474db1c2d
(and a lot more errors)

Logs:

https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5592/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5646/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1954/steps/15/logs/stdio

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

