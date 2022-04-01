Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C921C4167D
	for <webhook@archiver.kernel.org>; Fri,  1 Apr 2022 14:52:21 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web12.11670.1648824739076917390
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Apr 2022 07:52:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Vpral7mt;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 7AB92E0004;
	Fri,  1 Apr 2022 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648824737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b0DvqqMRaaD+6bVEABmwrD5DpETPPF5c6Dd/4A1Xew=;
	b=Vpral7mtZH9DdedvYlxEC5+7bZJanIrO+8dOcy2VDQttB3Fx32wL4C3sCZy+f1At33Sas3
	oS0z65bI4jAX9NgNeNROAm0iZmZWoKvCcd7mWSYPuaUnnzAv8jCiFx+DE6ZaaifrUmnlC9
	ev9B+8z1IL1JaG7iV2xmh7MDS9gXdyIs8D7lDYbJQMof4RZVfBhD/mfODjw4rGJe1bmBwg
	aragm6Fx0w3g24B/vhF52mIoJ0zv/WGsnHAoyXRX6T+uA9FvmKfR/3pcHSJeLC0EvpzaoO
	+iaqREfBq46Dfn/qQ1ESD978Evjkm0PG6QcVe+rAQ8qFlkwXSLMpLlzajj0o/Q==
Message-ID: <f209acbf-3df1-f646-14e6-2d483c81e8a3@bootlin.com>
Date: Fri, 1 Apr 2022 16:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc: docs@lists.yoctoproject.org, "Robert P. J. Day" <rpjday@crashcourse.ca>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [docs] [PATCH] bitbake-user-manual: punctuation fixes
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 bitbake-devel@lists.openembedded.org
References: <20220329130747.364485-1-michael.opdenacker@bootlin.com>
 <5205d592-db48-f554-5c64-221dbcb7b774@theobroma-systems.com>
 <119c048f-010d-f9d2-2e74-da470b1d043d@bootlin.com>
 <6a58f3eb-7140-b6aa-6b9f-a0372b7311fa@theobroma-systems.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <6a58f3eb-7140-b6aa-6b9f-a0372b7311fa@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Apr 2022 14:52:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13566

Hi Quentin,

On 3/31/22 10:24, Quentin Schulz wrote:
> Hi Michael,
>
> On 3/29/22 18:33, Michael Opdenacker wrote:
>> Hi Quentin,
>>
>> Thanks for the review!
>>
>> On 3/29/22 15:13, Quentin Schulz wrote:
>>> Hi Michael,
>>>
>>> On 3/29/22 14:07, Michael Opdenacker via lists.yoctoproject.org wrote:
>>>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>>>
>>>> - Replace hyphens by em dashes when necessary
>>>
>>> I seem to recall we ultimately decided to not go for em dashes because
>>> it wouldn't be matched by a search in the browser or in the sources?
>>
>
> c.f. https://lists.yoctoproject.org/g/docs/topic/85211078#1731
>
> for the original discussion around em dashes. Didn't decide anything
> at that time though but you have all the arguments there.
>
>>
>> Ouch, this is frustrating. I'd rather not deviate from English writing
>> rules, so that we don't have to keep a list of exceptions to them, or
>> worse keep them in the back of our heads.
>>
>> And why would one need to look for an em dash in the browser or in the
>> sources? As a reader, I'd avoid special characters in my searches, and
>> as a developer, I would do the same, but if I really want to look for a
>> specific em dash, I'll quickly find what the corresponding characters
>> are in the sources, thanks to the surrounding context.
>>
>
> You just gave the example as to why I think we shouldn't use em
> dashes: to "avoid special characters in my searches".
>
> No more arguments since the discussion Robert started last August,
> so... up to you.


Thanks for the reminder about the original discussion. You have a better
memory than I do ;-)

Could others (at least Richard, Nico ?) share their opinion here?
Otherwise it's hard to find a majority opinion...

The question is whether we should use em dashes
(https://www.thepunctuationguide.com/em-dash.html), described as "---"
in Restructed Text. This respects the English punctuation rules, but is
harder to grep in the sources.

If we prefer to use hyphens instead of em dashes in the documentation,
we will have to document the exception, but the risk remains to get
questions from time to time.

My vote goes to using em dashes, and I submitted patches for the YP and
Bitbake docs, but of course, I can accept the opposite choice if there's
a majority for it.

Thanks in advance
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


