Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B75EEB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 09:12:14 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.38081.1687511531912250377
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jun 2023 02:12:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=iZ3s5jmT;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: luca.ceresoli@bootlin.com)
X-GND-Sasl: luca.ceresoli@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1687511529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZbUmeDobyrsG/yIjq9sEq2rxHKYy2NIcBbykgWdeXw=;
	b=iZ3s5jmTY6U127S9claCe+LLHbsGsbANNoeMJ/4nkTJIAhG03eEpHXVrrlfKZHNNY5LYZR
	0YCKm/6B4uE3UbxhbTgjHZ+TDyJhEUY2Y3fGuHOn4hOlvRKgOa+OgELIcoYTBCR7Dn9p01
	VqRo+7nw22Y6qmqhAdun+I7RPmzpAs3DAIa02uh/ZvZRtgn7uxN/M7UOBL/vq4mITV4tHX
	USvLh9i8bwAFdEUDHi5RYfqHRUmnfg2bhi6NzK7B7khXsjOOduFl/AWs2fabAkrNKKFKI6
	WtC4rWs0QXlzZgr6zKjVkVgWDxDbg9u1OcfeoHg6Gh5vmZZ5zk1WSRHm0c9fFQ==
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 215D6C000F;
	Fri, 23 Jun 2023 09:12:08 +0000 (UTC)
Date: Fri, 23 Jun 2023 11:12:07 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Quentin Schulz via lists.openembedded.org"
 <quentin.schulz=theobroma-systems.com@lists.openembedded.org>
Cc: quentin.schulz@theobroma-systems.com,
 bitbake-devel@lists.openembedded.org, Quentin Schulz <foss+yocto@0leil.net>
Subject: Re: [bitbake-devel] [PATCH] docs: bitbake-user-manual:
 bitbake-user-manual-hello: add links and highlights for variables
Message-ID: <20230623111207.19aa7ea5@booty>
In-Reply-To: <20230622-typos-202306-v1-1-dce56bcb2f37@theobroma-systems.com>
References: <20230622-typos-202306-v1-1-dce56bcb2f37@theobroma-systems.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jun 2023 09:12:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14855

Hi Quentin,

On Thu, 22 Jun 2023 18:48:45 +0200
"Quentin Schulz via lists.openembedded.org"
<quentin.schulz=theobroma-systems.com@lists.openembedded.org> wrote:
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I think you forgot your sendemail.from here, which you apparently have
configured correctly for oe-core. Can you check your setup for the
bitbake repository as well please?

No need to resend, I fixed locally shile applying to my testing branch.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

