Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA81C4332F
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 10:03:10 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.24637.1646647389193460288
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 02:03:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=c8mwU4xb;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 60B0E40003;
	Mon,  7 Mar 2022 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646647387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iusnPx2SWLidiox7KDjlel1ui25m6s8dUHxItSCYtE=;
	b=c8mwU4xbhI4XbFZ2ypXtDVrPd7dI3ZoPgtnA+k+UmGQUSXzSLinsMfxkBryMPytgkHk01F
	d2WiNK4rozbz+5z9g2DSEgHAFO16+6vfudjjjJdfOvZdkpY7aTJhtwSYL8Q2OI4+h/xW5E
	oMLelS7yYnpaHaB7iuOcZXuesllGqhvoWzIUbnhaBb4KcQiCL3/mEfwhVRZf7qwX3WuxKg
	q/ZotNbeIifa+hGYUS+9Y/llXIhrLv9WS4rjhd4U72EoqLC8AIHwebLYyHx2jFGQaaM2Ze
	VpPZKfcVKaQCNO4s6kgQjSKiaqXXHTmuT/0iAYRPOetknV/QSRiCi6oJ/FkxMw==
Message-ID: <05d3d27b-395a-6cb4-23f5-cf1a79450d24@bootlin.com>
Date: Mon, 7 Mar 2022 11:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [bitbake-devel] [PATCH] bitbake-user-manual: further
 override syntax updates
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 bitbake-devel@lists.openembedded.org
References: <20220304201150.418001-1-michael.opdenacker@bootlin.com>
 <aece6598-6fef-0d61-abe1-fdc80d01e39e@theobroma-systems.com>
 <b39e90ba68d15f6e13a6ec7ad9557b83f1dca176.camel@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: 
 <b39e90ba68d15f6e13a6ec7ad9557b83f1dca176.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 10:03:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13421

Hi Richard,

On 3/7/22 10:49, Richard Purdie wrote:
> On Mon, 2022-03-07 at 10:37 +0100, Quentin Schulz wrote:
>> Hi Michael,
>>
>> On 3/4/22 21:11, Michael Opdenacker via lists.openembedded.org wrote:
>>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>>
>>> ---
>>> I think I found some missing updates for the overrides syntax,
>>> but I'm not sure, so please review carefully!
>>> ---
>>>   doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>> index 174cac78..b90e5cf0 100644
>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>> @@ -511,7 +511,7 @@ variable.
>>>   .. note::
>>>   
>>>      Overrides can only use lower-case characters. Additionally,
>>> -   underscores are not permitted in override names as they are used to
>>> +   colons are not permitted in override names as they are used to
>>>      separate overrides from each other and from the variable name.
>>>   
>> I think we can now safely say that overrides can have underscores, 
>> dashes and digits in addition to lowercase characters? I don't know if a 
>> variable can start with an underscore, dash or digit but we do have 
>> x86_64 and qemux86-64 which are overrides AFAICT? This should show we 
>> properly support those "special" characters. Probably would be better in 
>> its own commit.
>>
>> Otherwise, for this commit:
>>
>> Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>
> Thanks. It does look correct to me too. We do support digits in overrides and
> dashes. Underscores have a history of being painful and are the reason we have
> TRANSLATED_TARCH_ARCH:
>
> bitbake.conf:OVERRIDES = "${TARGET_OS}:${TRANSLATED_TARGET_ARCH}:pn-${PN}:${MACHINEOVERRIDES}:${DISTROOVERRIDES}:${CLASSOVERRIDE}${LIBCOVERRIDE}:forcevariable"
> bitbake.conf:FILESOVERRIDES = "${TRANSLATED_TARGET_ARCH}:${MACHINEOVERRIDES}:${DISTROOVERRIDES}"
> bitbake.conf:TRANSLATED_TARGET_ARCH ??= "${@d.getVar('TARGET_ARCH').replace("_", "-")}"
>
> although now we use ":" as the override character, we might be able to rethink that.

Thanks for the review!
So, can we say that an override can use lowercase characters and also
digits and dashes (but not as a first character?)?
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


