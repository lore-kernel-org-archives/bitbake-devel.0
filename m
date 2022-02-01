Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7D0C433EF
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 14:17:06 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web12.48616.1643725024266990098
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Feb 2022 06:17:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=k0RMvpdT;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B5D2A1BF20B;
	Tue,  1 Feb 2022 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1643725022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFqqe/J5MkPBRL3dXCuZ9hvVXAyN1meJ5UBRL7t1y6c=;
	b=k0RMvpdTrZA+r7yk4Omf/RSYNLZ8Eo1FjmZ0lwKgJeZFENMOyFvpXi1qPfiRpsxJoUSlQW
	kmFb8YuPvdi6TCcV6lopgY0ASf63tTqYD+dk6v8muduarq1rGQoDoD4eQifvcFGZZO8Apw
	T6BQ1KebEvazcaoJcfJqUAs6ic2Qrm106BN+UzKL0+dnYqmeQNO+s5wTQ+miqcyLk+Yuor
	KZNQHC2zK58/lV6KbW4v9mFJAk94jQBbApluCctVJfv1S2MWRKlP10bzzS2pGYB6rkTKkN
	68I1JYLzA+GpK0JhXdyyKXzLHOLAvwH3BcjSLFIBkPR9WTVzKgaywPkXCqOQ2g==
Message-ID: <19b4a25b-42d6-ed7c-1c48-b9cccdd5eb0b@bootlin.com>
Date: Tue, 1 Feb 2022 15:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH v3] knotty: improve the UI information
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Trevor Woerner <twoerner@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20220127205138.29159-1-twoerner@gmail.com>
 <6dd771e81db2c09c606c298b452850c16818be5c.camel@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: 
 <6dd771e81db2c09c606c298b452850c16818be5c.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Feb 2022 14:17:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13304

Hi Richard,

On 2/1/22 09:00, Richard Purdie wrote:
> On Thu, 2022-01-27 at 15:51 -0500, Trevor Woerner wrote:
>> During a build you might end up with bitbake telling you:
>>
>> 	Currently 30 running tasks (2757 of 2757/3476 of 6390)
>>
>> Which, to me, is really confusing. The forward slash separator and the two
>> numbers immediately on each side of which are likely to be interpreted as
>> being one unit (i.e. 2757/3476) but they're not. Also nothing is labeled,
>> leaving the user to wonder what these numbers are.
>>
>> Add labels, spaces, etc. to help clarify the information bitbake is trying to
>> convey. The resulting line would appear as:
>>
>> 	30 running tasks (setscene:2757/2757 tasks:3476/6390)
> I agree we shouldn't have used / as a separator, my fault on that.
>
> If we're going to change this again we need to get it right and I feel we're not
> quite there yet. I was wondering about:
>
>   30 running tasks (3476 of 6390), (Setscene: 2757 of 2757)


I agree that this would be an improvement.

>
> which moves the "tasks" closer together however my other worry is that people
> don't know what setscene tasks are and that the setscene piece is then not
> ordered before tasks. 


Yes, this could be confusing for people who don't know what setscene
tasks are.

> The "of" keyword does clearly indicate something to some
> subgroup of users, I think I was once advised about that.
>
> We could consider:
>
>   Setscene tasks: 2757 of 2757
>   30 running tasks: 3476 of 6390 
>
> which would break the code assumptions about a single line but we can likely fix
> that...


This would be much clearer indeed. I vote for this solution.
Just my 2 cents.
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


