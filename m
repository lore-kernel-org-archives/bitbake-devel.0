Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B3AC77B75
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:16:10 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.6178.1682061360208593649
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 00:16:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=NftKHm8i;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id CCD2420008;
	Fri, 21 Apr 2023 07:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1682061357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDly0ClDw9K9BcUnxGT6w/SyjTbFodzgrxM+hAi3N7Y=;
	b=NftKHm8iPhxeXca3pX3TNYHmKYPnGDEwHwpfDm1ZwjEaq3wwJ7W6SxcRP6FlZnjveKgQzx
	S3X+96wsFisPdln5IhH7TZsfzw2NllrXmb7ljbrpzuU7YiLWSrJbAjBt1YiDkabuw/OWNi
	GnYHz9m/3EYic2FPx+TkzKTNgaZeiBA/j17rh7Y7Apb9Zzasid51Y+Al/y+o1xSW0Pjw25
	VuRfatItQ4hSYN5dx3GbwRQbVBKXDs6dYGCrwDzm3zqIXtcDmlK9saxPU/tqwz6ciNlwxb
	NTSIShY/Jjh96NL/GD/vOx67RVdWCkRFz0xXyiBxAzHAv+8LdDgAGjp06dvMfg==
Date: Fri, 21 Apr 2023 09:15:55 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Alberto Pianon" <alberto@pianon.eu>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: base process
 (patch 1/3)
Message-ID: <20230421091555.6599abc9@booty>
In-Reply-To: <20230420062024.134035-1-alberto@pianon.eu>
References: <20230420062024.134035-1-alberto@pianon.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Apr 2023 07:16:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14730

Ciao Alberto,

On Thu, 20 Apr 2023 08:20:24 +0200
"Alberto Pianon" <alberto@pianon.eu> wrote:

> From: Alberto Pianon <alberto@pianon.eu>
> 
> License compliance, SBoM generation and CVE checking require to be able
> to trace each source file back to its corresponding upstream source. The
> current implementation of bb.fetch2 makes it difficult, especially when
> multiple sources are combined together.
> 
> This series of patches provides a solution to the issue by implementing
> a process that unpacks each SRC_URI element into a temporary directory,
> collects relevant provenance metadata on each source file, moves
> everything to the recipe rootdir, and saves metadata in a JSON file.
> 
> The proposed solution is split into a series of patches, with the first
> patch containing required modifications to fetchers' code and a
> TraceUnpackBase class that implements the process, and the second patch
> implementing the data collecting logic in a separate TraceUnpack
> subclass. The final patch includes test data and test cases to
> demonstrate the solution's efficacy.
> 
> Signed-off-by: Alberto Pianon <alberto@pianon.eu>

Testing this patchset on the autobuilders triggered failures on the
oe-selftest builds. Here are the logs:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5085/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5034/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/5076/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5114/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1296/steps/15/logs/stdio

May you have a look at that?

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

