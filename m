Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3AC4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 14:38:50 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.17336.1714487921989363086
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 07:38:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=UNA1h3gT;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0D7440010;
	Tue, 30 Apr 2024 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714487920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U62XLXSvhBy8tPWOV85sVnlANuJFBYeEZQTAtD8E5CU=;
	b=UNA1h3gT1cK4jJxxIfrkwnIe5RwUhJixuUSAoMxK5CKsMa1QVNSmvxX3fBmZbnGFGNqHLp
	CjYTSKbflJ51n5aJ7+nwladXD8KtMWS4TFHCqcfpQru7NyiOf7hxJnhF3TTyaHP1lDANkz
	maDVJ+J+ePSIdINO32V/oUlX/zkD03hOgP68ymAdzX6c74BgVSDB3OGN97cpu4fQ01uX1f
	gzFwDizJSTOw8Lo4n0C/ed4I3lvyONDu+isAhxQchZaEEwR8XyQjA9hevLcmkZFkQ1XmSz
	MUZEQ7xn3NknnuAhSHY5gQVlI/Sb4qXXTuoMhiD2EGenx/ExfPyMvP4ayvyUWA==
Message-ID: <1302be92-cbe9-4790-882f-861a9b1c8c2b@bootlin.com>
Date: Tue, 30 Apr 2024 16:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <ticotimo@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 4/5] prserv: enable database sharing
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-5-michael.opdenacker@bootlin.com>
 <CAJdd5GbeJL=Z4-YHYm8eab0x3JD3yynoBE+S0LsuP_E3cCYQPA@mail.gmail.com>
 <56222882-76c9-44ab-9a20-237a1293489b@bootlin.com>
 <CAJdd5GbR_LDbCX8aBzFkjrTj0GU55zJYWnQ07dJ1cC2wObz5BA@mail.gmail.com>
 <CAJdd5GZewzCZJFbVeASOMqQRKJRG51RcnBn1+A41_3pwn8_FtA@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GZewzCZJFbVeASOMqQRKJRG51RcnBn1+A41_3pwn8_FtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 14:38:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16164

Hi Joshua,

On 4/30/24 at 15:55, Joshua Watt wrote:
>
> Sorry, also forgot to mention: if your use case is _just_ a read-write
> server and a read-only server, then you are correct, you do not need
> to worry about retries. I think that's your only use case for this
> work, so the above statements are just for posterity, as I suspect we
> will be doing more work on the PR server after you finish the current
> work :)


Great, good to know thanks!
This will make things simpler indeed.
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


