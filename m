Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3570C77B61
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 16:15:32 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.17100.1682093722959670101
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 09:15:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=C3n2QGbC;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 8DE6E240007;
	Fri, 21 Apr 2023 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1682093721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErQL9Z7eEDoGVkKIDPj5R8s/72T0q857v740/1PhEKY=;
	b=C3n2QGbCPsLMX4rm+Iz9drlevMbnezW72MtI7MqXrJp1/9H+OBhALTwgERm9M0KZE57uxG
	Eov2KLre+qViZ4ihtx70aFF8Y7Lpet22X83ZTy/ztC2sni7YAlmi6Yn27BTcxn8yZ4AyRH
	tGIDje+j21uMPaEG/VvAylvvKn33UqwH6S/B1c5gmI6eEPi16Rv6CjXe/YMIdNmM0oajjJ
	T/9sFUba43w0Z11ZmHRC6Ih0cV7kZYI9fHTkTZ4EfFylfPy1+rqWnxLR5Y1h/OZwdR8LA/
	PHlZBipcQcNMb7TCFDmoyuV5qvD44lnerXDCo92QKHQP7JR+Pji1aKe1z6o43Q==
Date: Fri, 21 Apr 2023 18:15:18 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
Cc: Alberto Pianon <alberto@pianon.eu>,
 "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/3] upstream source tracing: base
 process
Message-ID: <20230421181518.23d8a279@booty>
In-Reply-To: <DB5PR02MB102133408DCA18D8EB0999BEBEF609@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230421070525.333494-1-alberto@pianon.eu>
	<20230421092803.081e3cd6@booty>
	<3afd4fe2d1581be5720508538c0c2287@pianon.eu>
	<DB5PR02MB102133408DCA18D8EB0999BEBEF609@DB5PR02MB10213.eurprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Apr 2023 16:15:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14734

Hello Peter, Alberto,

On Fri, 21 Apr 2023 13:50:25 +0000
"Peter Kjellerstedt" <peter.kjellerstedt@axis.com> wrote:

> > >
> > > Also, I see this patch set is not bisectable as well as v1: you define
> > > class TraceUnpack in patch 2 and use it in patch 1.
> > >  
> > 
> > do you mean that:
> > 
> > import TraceUnpackBase as TraceUnpack
> > 
> > in patch 1 is not good, and that I should use just TraceUnpackBase
> > as a class name/alias in patch 1?  
> 
> My guess is that Luca missed the `import ... as` line. I believe you 
> should be fine as you are.

You're right Peter, my review was too quick. Indeed Alberto's patches
are OK in that respect. Sorry for the noise.



-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

