Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06AEC4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 15:37:23 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.16892.1713368239125064708
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Apr 2024 08:37:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=EYJYAhfV;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECFAFC0007;
	Wed, 17 Apr 2024 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713368237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMHrHIWk9rVrhP0AqfyGnzmH1SDVLQ1u7BvvECzDysM=;
	b=EYJYAhfVn+O2jv+v+0HTwINIPgufZFhCSsoqUljdCuInfcWm+X1/siS2BBT+vkzsScpjv9
	sMDG11oeaj700ZPvcXq+tUmAiYjN8Nm3REr6vhZoAYBGezVOwW8adgdAAKAgS751946SB1
	DJM/9E4V214s7faPxV6MOsnbq7ZWeuyXdjXH3w6ie6lF4rVLttyEgKF09AjB5RDU9CYLbV
	PRRC288He9yJkpC+9ZwBNEM0WYIDGTUU/0BQ1lt7teGC3xJ33aDok8I4Okdq22ZIBc8Th0
	MtGqJbgGQoKdXLJzE9ZncyYnPcYPpQyFomMQbCVw7j6GCTaM58sinR3SYnuBvg==
Message-ID: <2f51024b-dee0-4014-a8e5-cd207f8e6596@bootlin.com>
Date: Wed, 17 Apr 2024 17:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Joshua Watt <JPEWhacker@gmail.com>, Tim Orling <ticotimo@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 12/12] prserv: add "history" argument to
 "get-pr" request
To: Bruce Ashfield <bruce.ashfield@gmail.com>
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
 <20240412090234.4110915-13-michael.opdenacker@bootlin.com>
 <CADkTA4N9ZKKo1s7+THXd8AvO1CEvxYskNLGP5ji_Ly-2aP6wYw@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CADkTA4N9ZKKo1s7+THXd8AvO1CEvxYskNLGP5ji_Ly-2aP6wYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 15:37:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16109

Hi Bruce,

Many thanks for your review, much appreciated!

On 4/17/24 at 17:21, Bruce Ashfield wrote:
> I can't say that I understand the difference between history and 
> no-history from
> just reading this series .. but I realize it isn't something being 
> added as part of
> this feature addition.
>
> I just wanted to comment that from the name "history" alone, I can't 
> figure
> out what it is doing and how it impacts PR values.

You'll find details in the code:
https://git.openembedded.org/bitbake/tree/lib/prserv/db.py#n25

Indeed, these modes should be documented. For the moment, only the "No 
history" mode was used, that's why no document exists yet.
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


