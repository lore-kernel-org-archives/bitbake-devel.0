Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18C6C04FF6
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 13:34:26 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.17976.1712842459030137264
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Apr 2024 06:34:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=RMd/MYMX;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72DF21BF212;
	Thu, 11 Apr 2024 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712842457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEDNY2C5wAa7w6waTOuc7nkgnBO9STKF2iiK74btArI=;
	b=RMd/MYMX7Y+3+HgXblkjOUEVAiYm7e0YhkIGN0wJ5CciiOW7fFuw76P4kp+XjLFAyFzGOP
	Zb9rQK1aXfJWZYroMs873X0LvY752LQhsSGTkEQMIMwTd4giXEmmNHSZFD22xKTay+b03s
	vy5I5uL2FaINodsD3yiCbB+dkzkdHDLY/vxHFkdIKHjSYAqMOvyQs8NlTLopmYQO9taBKD
	iinek0Hzi2Z2QzKxSnDTLxvOWgVGqCZ/gKToPiuJJnPktpzB5EGUNdZ99HKB7ymlfoHLJ8
	ZrQG4Jva4nq98Pc2HsgkJrw7U5Vi1w4T93CixYRwFUTnhVPhc5LI7JVERe3UjA==
Message-ID: <7ebe5ceb-e3c1-4c66-b080-cbfd3b2cfe80@bootlin.com>
Date: Thu, 11 Apr 2024 15:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org,
 quentin.schulz@theobroma-systems.com, =?UTF-8?Q?Simone_Wei=C3=9F?=
 <simone.p.weiss@posteo.com>
Subject: Re: [docs] [bitbake-devel] [PATCH v3] bitbake: doc: Add section for
 variable context
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20240223192047.7431-1-simone.p.weiss@posteo.com>
 <0a3f67b7-06ea-4dc0-bdf6-506098cf46b2@bootlin.com>
 <ce7e0116-69e9-4103-874b-c1f16d0a64e6@theobroma-systems.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <ce7e0116-69e9-4103-874b-c1f16d0a64e6@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Apr 2024 13:34:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16071

Hi Richard

On 2/27/24 at 17:38, Quentin Schulz via lists.openembedded.org wrote:
> Hi all,
>
> On 2/26/24 15:16, Michael Opdenacker via lists.yoctoproject.org wrote:
>> Hi Simone,
>>
>> On 2/23/24 at 20:20, Simone Weiß wrote:
>>> From: Simone Weiß <simone.p.weiss@posteo.com>
>>>
>>> This is inspired by the same section in the yocto-docs. It aims to 
>>> provide
>>> information in what contexts(recipes, .conf, bbclass,...) a variable 
>>> is usually
>>> used. For that I tried to group similar variables, so that a short 
>>> overview is
>>> given. This was inspired by [YOCTO #14072], but of course does not 
>>> implement a
>>> warning if a variable is used in an unintended context.
>>>
>>> Signed-off-by: Simone Weiß <simone.p.weiss@posteo.com>
>>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>> ---
>>>
>>> Notes to v3:
>>> - Applied the fixes suggested in review (thanks for the patch! I 
>>> hope adding the
>>>    Signed-off like this during squashing is fine)
>>> - For the ref label, I plan to come up with an svg that illustrates 
>>> tasks,
>>>    recipes, classes, conf (thanks Quentin for the suggestion), but 
>>> in a generic
>>>    way and add it to the Concepts section, I want to add a ref from 
>>> there.
>>>   ...bake-user-manual-ref-variables-context.rst | 91 
>>> +++++++++++++++++++
>>>   doc/index.rst                                 |  1 +
>>>   2 files changed, 92 insertions(+)
>>>   create mode 100644 
>>> doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst
>>
>>
>> Thanks for this new update of this worthy addition to the BitBake 
>> documentation! Everything looks good now.
>> Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> A section on task context would be nice but it can come up in a later 
> patch I guess.
>
> Thanks!
>
> By the way, I had an old doc build lying around and just git pull my 
> local branch + applying this patch and somehow the navbar was not 
> updated to contain this new section, I had to remove the build dir and 
> compile it from scratch. I'm wondering if we aren't missing something 
> somewhere so that this navbar is updated whenever it needs to?
>
> Cheers,
> Quentin


Ping for this nice patch from Simone.
Both of us have given it our "Reviewed-by".

Thanks in advance
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


