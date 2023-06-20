Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83682EB64D7
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 17:03:18 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.1438.1687280587759015520
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jun 2023 10:03:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fFJwbt3G;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1687280585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtawV1hFOgc6wK2ssxE4JTo35RtYrlZRK/+OUcYkHDM=;
	b=fFJwbt3GJ3vhHOenbBrbm4QXUsOxcaMuc8xKgIWuoA2+GAdcPlHom6228UKF0MPdaf3jwF
	F6I2Sz6QHoDRzorj6w919ok92WF3UT5j68+7OakEiWDT2CNpT5dhRJs762S+CTLdwvYmqI
	WFzICDNTU0W3B1ZJaCvfi68qbQTf0crfZG9RJjv1XtAAlsQW8UdKdflvRU0QI3xKmiwd6/
	lFHes5mwHip2Nj/QuFKh0C0/SQr9B81Ad+fufpCn6I1WLwQznhQ4tAe8GTGM37JHreYDV4
	BwEk+PZqkcHMjYk3G1MUEWIPJVgAc8SI4dDYJoLLWi7T0BHpm5A+0X+d/ZUwHw==
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D142260008;
	Tue, 20 Jun 2023 17:03:04 +0000 (UTC)
Message-ID: <1dbee557-023e-8b79-84f3-a93ef5a25a78@bootlin.com>
Date: Tue, 20 Jun 2023 19:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: explicit variables
 taking a colon separated list
Content-Language: en-US
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20230619160614.909233-1-michael.opdenacker@bootlin.com>
 <20230620095230.3847067a@booty>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230620095230.3847067a@booty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jun 2023 17:03:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14850

Hi Luca,

Thanks a lot for the review!

On 20.06.23 at 09:52, Luca Ceresoli wrote:
> Hi Mike,
>
> On Mon, 19 Jun 2023 18:06:14 +0200
> "Michael Opdenacker via lists.openembedded.org"
> <michael.opdenacker=bootlin.com@lists.openembedded.org> wrote:
>
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> [YOCTO #15128]
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> ---
>>   .../bitbake-user-manual-ref-variables.rst        | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index 01d4f8d1..ee5d7ba8 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -920,9 +920,9 @@ overview of their function and contents.
>>         section.
>>   
>>      :term:`BBPATH`
>> -      Used by BitBake to locate class (``.bbclass``) and configuration
>> -      (``.conf``) files. This variable is analogous to the ``PATH``
>> -      variable.
>> +      A colon-separated list used by BitBake to locate class (``.bbclass``)
>> +      and configuration (``.conf``) files. This variable is analogous to the
>> +      ``PATH`` variable.
>>   
>>         If you run BitBake from a directory outside of the build directory,
>>         you must be sure to set :term:`BBPATH` to point to the build directory.
>> @@ -1165,8 +1165,8 @@ overview of their function and contents.
>>         order.
>>   
>>      :term:`OVERRIDES`
>> -      BitBake uses :term:`OVERRIDES` to control what variables are overridden
>> -      after BitBake parses recipes and configuration files.
>> +      A colon-separated list that BitBake uses to control what variables are
>> +      overridden after BitBake parses recipes and configuration files.
>>   
>>         Following is a simple example that uses an overrides list based on
>>         machine architectures: OVERRIDES = "arm:x86:mips:powerpc" You can
>> @@ -1225,9 +1225,9 @@ overview of their function and contents.
>>            PREFERRED_PROVIDER_virtual/libgl ?= "mesa"
>>   
>>      :term:`PREFERRED_PROVIDERS`
>> -      Determines which recipe should be given preference for cases where
>> -      multiple recipes provide the same item. Functionally,
>> -      :term:`PREFERRED_PROVIDERS` is identical to
>> +      A colon-separated list to determine which recipe should be given
>> +      preference for cases where multiple recipes provide the same item.
>> +      Functionally, :term:`PREFERRED_PROVIDERS` is identical to
>>         :term:`PREFERRED_PROVIDER`. However, the :term:`PREFERRED_PROVIDERS` variable
>>         lets you define preferences for multiple situations using the following
>>         form::
> If I read the docs correctly, PREFERRED_PROVIDERS is not a
> colon-separated list but rather a space-separated list [of
> colon-separated pairs].


Oops, you're right. bitbake/lib/bb/cooker.py confirms this.
I'm sending an update.
Thanks again
Mike.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


