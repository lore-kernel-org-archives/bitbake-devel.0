Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39796C433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 18:12:36 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web12.318.1639678354702785527
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 10:12:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BE87420005;
	Thu, 16 Dec 2021 18:12:32 +0000 (UTC)
Subject: Re: [docs] [PATCH v2] doc: bitbake-user-manual: expand BB_HASHSERVE
 and document BB_HASHSERVE_UPSTREAM
To: Quentin Schulz <foss@0leil.net>, docs@lists.yoctoproject.org,
 bitbake-devel@lists.openembedded.org
References: <16C0F955FEA53DE5.26558@lists.yoctoproject.org>
 <20211216095204.2016867-1-michael.opdenacker@bootlin.com>
 <4F7DB4A6-D4E6-4849-9DB9-6B24C21E1459@0leil.net>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <112ec250-6968-7549-be23-3d0c0a7132b3@bootlin.com>
Date: Thu, 16 Dec 2021 19:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4F7DB4A6-D4E6-4849-9DB9-6B24C21E1459@0leil.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 18:12:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13188

Hi Quentin,

Many thanks for the review!

On 12/16/21 6:32 PM, Quentin Schulz wrote:
>
>>
>> -      If set to ``host:port``, BitBake will use a remote server on the
>> +      If set to ``unix://path``, BitBake will connect to an existing a
> s/a//

Fixed.
>
>
>
> +      This last kind of server can be started manually through
> s/This last kind of server/The remote server/


Much better, adopted!

>
>
> +
> +      Example usage::
> Do we not need a newline after the ::?


Oops yes, otherwise the rendering is different.

>
>> +         BB_HASHSERVE_UPSTREAM = "typhoon.yocto.io:8687"
>> +
> Is this the address of an actual hashserver? Is this supposed to be used? Is it able to handle many requests? Basically asking if we should have a real hashserver here?


Yes, that's the server proposed in Poky's
meta-poky/conf/local.conf.sample file, though it is commented out by
default.
We talked about that in a meeting, and if I recall correctly, we agreed
to document its usage, but not turn it on by default. Effectively, if
everyone starts using it at the same time, runs could become slower than
if the corresponding artifacts were built locally.

There's a proper warning in my patch, anyway.

Don't hesitate to disagree, that's not too late!

Thanks again
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


