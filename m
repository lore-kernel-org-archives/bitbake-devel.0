Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8571AD31767
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 16:40:43 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.24671.1730824841581502510
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 08:40:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=O9t3pXtK;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA40F40002;
	Tue,  5 Nov 2024 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730824839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DBKYBklfOq+OGI5oz8qyNXhMAD7w3Eo3Wa/g2xUsSI=;
	b=O9t3pXtKcplDhjuQGccuzBhJWFguA6mY0KowPCehZ7CSd0DXirJgyN7ELqpf3OOvwDx1oH
	Y/x2ilpcfCnFal/HCJ3BQn8k8VaTNfcLnFb1WxBjf1AMUr7E1YUbrEkEjWtUmqxfg4ntgR
	J+2EZgNDcFwwrCAUVgXU25UH45Y9d6kUxLT8eNYEebBo1NQbMFy+1LvkJOcqAcQuUQ/EzP
	3LBnS8ipZXZx3T/o4WMfD7BxcUkyDevQtswnawTZC3bXjbxU1WyZ8hADRSp9aGNL8g1dUg
	KUFnUlVByZYNQfUbDFZN3wyMazk/Y5ca48KzzYdE7JLfSC5VMBDQKhqvlO2eAA==
Date: Tue, 5 Nov 2024 17:40:37 +0100
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/2] server/process: Decrease idle/main
 loop frequency
Message-ID: <ZypKhYgAkvrse6bx@bootlin-mathieu>
Mail-Followup-To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20241105150628.2827698-1-richard.purdie@linuxfoundation.org>
 <20241105150628.2827698-2-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105150628.2827698-2-richard.purdie@linuxfoundation.org>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 16:40:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16779

On Tue, Nov 05, 2024 at 03:06:28PM +0000, Richard Purdie wrote:
> The idle and main loops have socket select calls to know when to execute.
> This means we can increase the normal timeout frequency since this is
> just a fall back and have some small efficiency gains.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Hi Richard,

This patch set does not apply cleanly on master nor on my master-next. I
believe it misses the "Merge a function to simplfy code" from your
master-next branch.

-- 
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

