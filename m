Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C015D462BD
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 14:50:12 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.13525.1731509409174143377
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Nov 2024 06:50:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Kc1EPe6r;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D79220005;
	Wed, 13 Nov 2024 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731509407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFar8lTxtsrmdbxFDB4koVPOYcGj8XHRJKhcjDykRD0=;
	b=Kc1EPe6repZrC1PrJL0lPzJt2+RIMB46h1xC/xv3EEROLIZCCA0lmP2GkYdj43VnMedZba
	IOv963ZEI7SS33mC4iq91AerBpiFFmj5e4CnSaaBEwHqg6UmXwum+56+/co5Q1mR2DAtYr
	HtodXkoRTV65q94QZ0IFFMfNPKP7dhIoHOx783Oq++5aiB4el3hXyFs9UPfkSwLIIO1YhD
	8UFIVTJFSZvtjFXlzdZT/9iASNwR3wSoY0HzP/AZ4nrditHfSSExiGi5aU/0Ogq1J7n+JY
	KYHrcaeEdELfYW0TJpSknu0aXu4VE34Ip+S31i1o5MnkZfZlPsXDgeaCKNSRHg==
Date: Wed, 13 Nov 2024 15:50:05 +0100
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: yoann.congal@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-getvar: use finalizeData
 tinfoil API to get identical result to "bitbake -e"
Message-ID: <ZzS8nf1QeJ1oU7Ob@bootlin-mathieu>
Mail-Followup-To: yoann.congal@smile.fr,
	bitbake-devel@lists.openembedded.org
References: <20241112230559.2035910-1-yoann.congal@smile.fr>
 <20241112230559.2035910-2-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112230559.2035910-2-yoann.congal@smile.fr>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Nov 2024 14:50:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16796

On Wed, Nov 13, 2024 at 12:05:59AM +0100, Yoann Congal via lists.openembedded.org wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
> 
> Fixes [YOCTO #15638]
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

Hi Yoann,

I believe this commit is responsible of build failures on the
autobuilder, on oe-selftest* and *-tc builders:

RuntimeError: core-image-minimal - FAILED to start qemu - check the task
log and the boot log

https://valkyrie.yoctoproject.org/#/builders/28/builds/402/steps/12/logs/stdio
https://valkyrie.yoctoproject.org/#/builders/28/builds/402/steps/12/logs/stdio

Can you have a look at this issue please ?

-- 
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

