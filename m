Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C7C54EAA
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 17:12:21 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.107808.1674839532593342773
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jan 2023 09:12:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PQZjqXfA;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C8C281BF203;
	Fri, 27 Jan 2023 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1674839530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIHBNK+xE0vrP9WzY6MDnRl8kGMeFHCQlAskSkXjBcY=;
	b=PQZjqXfAAG4v2s0qz4eJcNskSNZBzl0uykMnGQhTOAZVQYrZzH+beaibNpwnwjglqOGemu
	veJXDQPwWsMBm2vRqSZvjzBMTwkFQF29cCxvLLJEyO+Rx6JAT1ChLya3dqRadeJeKL0h0N
	rXHWcQF4H9JXDTLYz5IR2f9xAoTGrCiIJsOt9MfaHQGz1nDjUoTzx0HH4vCXy7Yo0OjBXG
	mF5HmCPEPcIebZj34rFEQxLieJKx4BBqMNn3I9sgDzRL5gfMGhZnJEGaKg2N0b20YeEjqk
	yvntPbOpnfQoY2WLLtupoeFy3rNoOmL5SWenlmGznXLnXkbSi8Oz77cfcCrQ8w==
Message-ID: <9a0d0e43-2620-9a2f-36e6-008094e9dcb4@bootlin.com>
Date: Fri, 27 Jan 2023 18:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [docs] [bitbake-devel] Saving off warnings to a separate file
 with Python structured logging
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 quentin.schulz@theobroma-systems.com, Joshua Watt <JPEWhacker@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <3c606d49-77d9-d89f-4d8d-96cb0a36f620@gmail.com>
 <d2858712-723b-bb6a-d1a7-6e2a134ced97@theobroma-systems.com>
 <5d50798e294101e1135f980e7576fa77a72ba844.camel@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <5d50798e294101e1135f980e7576fa77a72ba844.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 17:12:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14360


On 27.01.23 at 14:26, Richard Purdie wrote:
> On Fri, 2023-01-27 at 14:24 +0100, Quentin Schulz via
> lists.yoctoproject.org wrote:
>> Hi Joshua,
>>
>> This seems to be too valuable information to be lost in the mailing list
>> archives. Any chance of having this somewhere in the bitbake/yocto docs?
>>
>> Cc'ing Michael and the docs mailing list on this.
> The context was that we discussed this in triage yesterday and said
> making this public was the first step but then we'd document it in the
> manuals. Michael was on that call so knows about it! :)

Actually, there is already documentation about BB_LOGCONFIG in 
https://docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/bitbake-user-manual-execution.html#logging. 
I'll propose an update taking Joshua's guidelines into account. Let me 
know if you had something else in mind, and if you see obsolete details 
on this page.

The provided JSON file still seems to work, but it serves a different 
purpose.

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


