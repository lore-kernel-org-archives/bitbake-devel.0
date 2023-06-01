Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE40C77B7A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 10:22:29 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.27553.1685614945552460268
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Jun 2023 03:22:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Zi7e1g8z;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: alexandre.belloni@bootlin.com)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1685614943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgZtdnAdUAZon0q0vCDNPQI7XDQ6+8goEpAJN+QUo1w=;
	b=Zi7e1g8znGSZaStFYG8mb3EW5ijRKFx8uTPprE/98m1KMw1yEsqSsXakiTg9+493h6rVoU
	T5UsKb60BMKbH31yFq0qqnM2w4biPE6eEGj7YvjOC3Ohxo2MpoaHv2HzZB032Cw2QjtqZq
	Xwx4BDAV2pM1mc5I9/j//f8mbfGPjM47+770uhxmOdnt/lwxgbC5SnRvoI1P81/WVtcgPJ
	rqeYVYKBV2xqNtxcmAjt2PisEb3YXOTi6s+vhvKKP+R7hmb2OPaE2WF3cxV2HKYuiSK4qZ
	oQBGdZfBmVWj8NVan7LSFeYvrQo9TDx9hpi8Y4xE657yXdm2wigy3WWltOSOiQ==
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDB154000D;
	Thu,  1 Jun 2023 10:22:22 +0000 (UTC)
Date: Thu, 1 Jun 2023 12:22:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: belouargamohamed@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [master][PATCH] fetch2: npmsw: Don't fetch dev
 dependencies when they are not demanded
Message-ID: <2023060110222211f35f6b@mail.local>
References: <202305311847057862e591@mail.local>
 <18872.1685559575756686252@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18872.1685559575756686252@lists.openembedded.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Jun 2023 10:22:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14824

On 31/05/2023 11:59:35-0700, belouargamohamed@gmail.com wrote:
> Hey,
> 
> Before applying this patch, on other patch should be accepted first:
> https://lists.openembedded.org/g/bitbake-devel/message/14815?p=%2C%2C%2C20%2C0%2C0%2C0%3A%3Arecentpostdate%2Fsticky%2C%2Cbelouarga%2C20%2C2%2C0%2C99163598
> 

This patch is marked for kirkstone so it has been ignored. Can you send
a series that can be applied on master?

> Thanks

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14822): https://lists.openembedded.org/g/bitbake-devel/message/14822
> Mute This Topic: https://lists.openembedded.org/mt/99230772/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

