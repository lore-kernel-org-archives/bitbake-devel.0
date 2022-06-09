Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D8AC433EF
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 06:58:01 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web12.7440.1654757879022481710
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 23:57:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lD6RYEe3;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231,
 mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BC85910000E;
	Thu,  9 Jun 2022 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1654757877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BiVUt7SwjND4FqvrAhK9zP9dW67JiY1mk++LjpDG7JQ=;
	b=lD6RYEe3EiCacNZdQ9la7qrRke9X0xpStrMxhp22jsKIWzwcOHLPJ9GVfPI3KV5POXc366
	qgJQ2kMphlgDXl1A9llwaKAYYOolH3LSLqsR54kj72wLWK9iwHi8/L1G4G8jy9yPgwr8QV
	jbiYDcTHcN8r55XM77Qih5mgsAYmHgFV1M1JCcOSfAok5Eunhs6XDoY2AYNVqpjIMmYNaJ
	RW/ng6iDYM0nZnN2bsF8DBmmgVzggeJhi3p5GbdwTauVijYeNP/Cymx4ml/V6WHF+31d8P
	HboVU7Ql7+quZQgddMiqVBqxsbmozy6Imz7jUMjF6djRXmCMyXjmdREJ/0J4WQ==
Date: Thu, 9 Jun 2022 08:57:54 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Mikko Rapeli" <mikko.rapeli@bmw.de>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] event.py: ignore exceptions from stdout
 and sterr operations in atexit
Message-ID: <20220609085754.22144287@booty>
In-Reply-To: <20220609055610.29857-1-mikko.rapeli@bmw.de>
References: <20220609055610.29857-1-mikko.rapeli@bmw.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jun 2022 06:58:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13744

Hi Mikko,

On Thu,  9 Jun 2022 08:56:10 +0300
"Mikko Rapeli" <mikko.rapeli@bmw.de> wrote:

> From: Mikko Rapeli <mikko.rapeli@bmw.de>
> 
> When atexit functions run, stdout and stderr operations may fail, e.g.
> when output is piped to less but has been exited by the user.
> This removes error print from output of "bitbake -e sqlite3 | less"
> if user presses "q" before bitbake has finished processing:
> 
> [Errno 32] Broken pipeError in atexit._run_exitfuncs:
> Traceback (most recent call last):
>   File "/home/builder/src/poky/bitbake/lib/bb/event.py", line 135, in print_ui_queue
>     sys.stdout.flush()
> 
> Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
> ---
>  bitbake/lib/bb/event.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index df020551e3..97668601a1 100644
> --- a/bitbake/lib/bb/event.py

        ^^^^^^^^

This patch does not apply on the bitbake tree due to the extra
'bitbake/' directory component. Perhaps you generated it from a poky
tree instead?

I removed the extra component and applied it however, thus no need to
resend, and also:

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

