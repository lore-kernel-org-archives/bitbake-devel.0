Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD3CC433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 15:14:51 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.10573.1646925290362300098
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 07:14:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ilR7uLYB;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id D6C16E0011;
	Thu, 10 Mar 2022 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646925288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVqQRndPHrfYwbHeST/qstwHwrLFHj7/hyyB5zcfhMo=;
	b=ilR7uLYBzD9KZh/LV4xWNLJMGaEcFMKVf4rWSpl+iVC85SXNHq9a7UMhS/JEIN3sSLmSVo
	hMoIOVvf47rFLW3NcickqYCYd9bOxjIYY1kGOXSYvpP8mZwhqeoJllRzR6jSxHFGh6fzCX
	v5XOr8a3yhqZMoypmL13C7qsEcN3OQyLy3vss8RQ3Px3bcGpbuowba0HKM96QJBEDDZF3s
	36aG3OyJuuUptLqVv24Okz++MG5LoBadOPmEWRZCAmClEKiW2Je1mCj3M555vWUg8TIgxi
	No/eB0CRc9RsqCPBJ5w1BYalfQoz0/a/l+nEQ50y99t/mgb47KktLioSiwnU+g==
Message-ID: <61005249-7b87-7e47-da58-b0a32ffa9bce@bootlin.com>
Date: Thu, 10 Mar 2022 16:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc: docs@lists.yoctoproject.org,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [docs] [PATCH] bitbake-user-manual: add note about the old syntax
 for OVERRIDES
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 bitbake-devel@lists.openembedded.org
References: 
 <6035008ce96fb9055547cf0cc2ffa51d2262c9ea.camel@linuxfoundation.org>
 <20220307183803.534661-1-michael.opdenacker@bootlin.com>
 <b1392865-9754-dd70-8278-42a067277380@theobroma-systems.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <b1392865-9754-dd70-8278-42a067277380@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 15:14:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13466

Hi Quentin

Thanks for the review.

On 3/10/22 11:54, Quentin Schulz wrote:
> We should mention that we're talking about external/third party
> documentation/tutorials and not ours :)


Oops, Richard already merged the change. Is it really worth it to make
another commit for such an update?
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


