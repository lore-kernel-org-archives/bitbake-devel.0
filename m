Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7AC4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 08:05:07 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.7551.1714723501181022979
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 May 2024 01:05:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fI8RBx3X;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9F9E1C000A;
	Fri,  3 May 2024 08:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714723499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuDukr+LnnUT6AGazRjyZuSiOV49rZFOqfPpti6fSeY=;
	b=fI8RBx3XWwnjQa0r6bi1p4YT8XTIKwzTc9S4h6mxfSIyUkLMw+P34RQKwS3UzC0n367vbI
	+3oypFocx+cXwTPGXCx8pmr6L9C4Z9qQ/udd0+StBn1g/M/esXAdy8a7t3dUzyMj9cWQI+
	2qN5K/VThUM5ySZImIDqxIQ6GUe8ch2toSN+a2ANAbqj0EMhMpjaM7ZmYtZfTwRSwarJNg
	WhhBTIAl5o8E1LfoBVdJsR9QBp/VJj1qkVcsDUo5GurGxLKITbJwperTNfjS0VX/BEC8Yl
	sxDsoJt9N0p6My5fmtQ4wZfVoWCcTffyw1TrFRP0uUblrpWzp2TtTdJoVPot5Q==
Message-ID: <2a2f731e-7ca0-4442-a0e2-5e2b3bfde80c@bootlin.com>
Date: Fri, 3 May 2024 10:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org,
 Joshua Watt <JPEWhacker@gmail.com>, Tim Orling <ticotimo@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v5 2/5] prserv: move code from __init__ to
 bitbake-prserv
To: Khem Raj <raj.khem@gmail.com>
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-3-michael.opdenacker@bootlin.com>
 <CAMKF1soyTt3He84XOgAv01ZdwGPZ2gxVwZaRxsL2Dufj3W_=rg@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAMKF1soyTt3He84XOgAv01ZdwGPZ2gxVwZaRxsL2Dufj3W_=rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 May 2024 08:05:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16185

Hi Khem

On 5/2/24 at 18:57, Khem Raj wrote:
> Hi Michael
>
> I am seeing a problem with this series, specifically following
> patchset is causing a regression
>
> * ea1d7b8a36e bitbake: prserv: add bitbake selftests
> * 5c66d345300 bitbake: prserv: import simplification
> * c23f2c1680f bitbake: prserv: store_value() improvements
> * 395b321af29 bitbake: prserv: avoid possible race condition in database code
> * 8022dc1029d bitbake: prserv: enable database sharing
> * b81bfdfbed8 bitbake: prserv: add "upstream" server support
> * 9539ce3b14a bitbake: prserv: move code from __init__ to bitbake-prserv
> * 4ec1553710b bitbake: prserv: declare "max_package_pr" client hook
>
>
> error seen during packagedata task of base-files
>
> WARNING: base-files-3.0.14-r0 do_packagedata: Error talking to server:
> Connection closed
> ERROR: Error from client ('127.0.0.1', 59846): 'PRTable' object has no
> attribute 'sync'
> Traceback (most recent call last):


Thanks for the review. Actually, did you test with the V6 update I sent?
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


