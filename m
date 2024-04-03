Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BACD128A
	for <webhook@archiver.kernel.org>; Wed,  3 Apr 2024 15:34:08 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.14365.1712158440730303107
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Apr 2024 08:34:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ks2SB727;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A92671C000D;
	Wed,  3 Apr 2024 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712158439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJIXh1FdZ+XAQA/ALuGqh7yDP7gO3Ve93oW/8u6qclU=;
	b=ks2SB727b3Yvl9+MjG2wZ2PLE7wkB6jxo8bt7E1C9kdXFpX6NI+5P6KXtcT7Yb19MaZY3k
	Carpo4h8J2IrSZuRcHctglEXBKUC2H3/Ms+HQJI3HnR7PavHs5uM6LuQJFQ06CWtXpJjbg
	UOKHcVjoxPmONhyPPgz42k5lwiF3k5eCoBgQKevro0CJdF/sLKMj2cJIB2tHqIQzzrOHU2
	5NSU5DJ0q46gMzfmfjOX7XvrUMaOCjKZUj+IebJEp7JlLeA73EJSwElHg/Ruri/y05ECzp
	cs1fThLcC5wFFoQJLj/JTrj0lFw2VOCSyrgECmGD7qoaU+jBD1OQaXxi59CWyg==
Message-ID: <80bcd78e-7c42-4b10-b1b2-f04955059c2e@bootlin.com>
Date: Wed, 3 Apr 2024 17:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 00/12] prserv: add support for an
 "upstream" server
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
 <c04991f85ccf2d28ef0e04ffbc18e5faf93f1e63.camel@linuxfoundation.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <c04991f85ccf2d28ef0e04ffbc18e5faf93f1e63.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Apr 2024 15:34:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16043

Hi Richard,

Many thanks for the first review!

On 4/3/24 at 17:09, Richard Purdie wrote:
> On Fri, 2024-03-29 at 15:39 +0100, Michael Opdenacker via
> lists.openembedded.org wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> This makes it possible to customize an "upstream" distribution
>> by modifying local packages. If the "upstream" package bears
>> revision "x", the local one will have revision "x.y", this
>> having priority over the upstream one.
>>
>> Take advantage of this work to clean-up and update the prserv code
>> too.
>>
>> Michael Opdenacker (12):
>>    prserv: simplify the PRServerClient() interface
>>    prserv: use double quotes by default
>>    bitbake-prserv: replace deprecated optparse by argparse
>>    prserv: use self.logger instead of logger directly
>>    asyncrpc: include parse_address from hashserv
>>    prserv: capitalization and spacing improvements
>>    prserv: fix read_only test
>>    prserv: add extra requests
>>    prserv: remove redundant exception handler
>>    prserv: correct error message
>>    prserv: remove unnecessary code
>>    prserv: add "upstream" server support
> Most of these series looks like cleanups to make prserv look more like
> hashserv, which is fine.
>
> The piece I'm struggling to understand is what happens if we have three
> prservs where A has B an upstream and B has C as an upstream. Does the
> system cope with multiple levels of increment, x.y.z and so on?


I haven't tested that yet, but wasn't sure we wanted to support such as 
multi-level scenario. If you confirm that's within the scope, I can try 
to make this work!

>
> I'm a bit worried we're seeing floats in the results, which suggests
> that generic x.y.z wouldn't work?


I first tried to explicitly convert all the responses from the PR server 
to strings, but that didn't help. Could it be that a return value like 
'0.1' could be automatically interpreted as a float if it can be 
converted to one? There is no explicit conversion to float in the PR 
server code, so it seemed to me that the conversion was done automatically.

>
> Also, where do we stand on automated tests for this code?


Not done yet. I was waiting for the reviews on the first series, but I 
understand that tests will be necessary :)
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


