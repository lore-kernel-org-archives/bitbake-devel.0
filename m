Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A51C433FE
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 12:58:49 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.19801.1665579519874318508
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Oct 2022 05:58:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jdXpMmD1;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 8580AC0009;
	Wed, 12 Oct 2022 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1665579518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zElXlPNmrJKdXBBX8gtWHnLr4oFmrcPDJM3JdqXigV0=;
	b=jdXpMmD1vh3EHDGy7qpJRPJns7xdlv1udiieJcQVwTQkljzCcRpz93MlvOJ6+Gv6elb8uN
	4VkksJQ4RLVkQAfMhqc6Ds/AxTWgo1mwCt5KABI0+e9rvoLk2NiZxKRNWBckxaYxMmfiro
	PpWWkiUhwWOhfFdFah/TG97aCJ8c88DvI0qSmoFQ8bc6eVSs07IVX45+Mqc05w8iw8SjXd
	HSk4XJC/Xabbd0lJQ7qZ9wC5nYKUi3XSxQsDDGOCOkzCxaoUq2pIkP4sKpJMMZDKckUE3J
	PfXsftKZ2o8/QgwQa4HW3ZISB6ToZp4mczr/ZBsPs09Eye1915VgUFh296WMww==
Message-ID: <8f2ef282-75d0-18b7-52ad-bc7f2e25552b@bootlin.com>
Date: Wed, 12 Oct 2022 14:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual: expand description of
 BB_PRESSURE_MAX variables
Content-Language: en-US
To: quentin.schulz@theobroma-systems.com,
 Paul Eggleton <paul.eggleton@microsoft.com>
References: <20221012124304.2926858-1-michael.opdenacker@bootlin.com>
 <91b7e8e3-a6b9-d426-527a-368e5676d4ea@theobroma-systems.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <91b7e8e3-a6b9-d426-527a-368e5676d4ea@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Oct 2022 12:58:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14035

Hi Quentin,

On 10/12/22 14:52, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Michael, Paul,
>
> On 10/12/22 14:43, Michael Opdenacker via lists.yoctoproject.org wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> Signed-off-by: Paul Eggleton <paul.eggleton@microsoft.com>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> ---
>>   .../bitbake-user-manual-ref-variables.rst     | 60 +++++++++++++------
>>   1 file changed, 43 insertions(+), 17 deletions(-)
>>
>> diff --git 
>> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst 
>> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index 725e6c2c..b9c1b75d 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -484,29 +484,55 @@ overview of their function and contents.
>>            for it to work.
>>        :term:`BB_PRESSURE_MAX_CPU`
>> -      The threshold for maximum CPU pressure before BitBake prevents 
>> the
>> -      scheduling of new tasks. Once the :term:`BB_PRESSURE_MAX_CPU` 
>> threshold
>> -      is exceeded, new tasks are not started until the pressure 
>> subsides to
>> -      below the threshold. If :term:`BB_PRESSURE_MAX_CPU` is not 
>> set, CPU
>> -      pressure is not monitored. A threshold can be set in 
>> ``conf/local.conf``
>> -      as::
>> +      Specifies a maximum CPU pressure threshold, above which BitBake's
>> +      scheduler will not start new tasks (providing there is at least
>> +      one active task). If no value is set, CPU pressure is not
>> +      monitored when starting tasks.
>> +
>> +      The pressure data is calculated based upon what (recent) Linux
>
> "recent" does not mean much. Can we remove this or get a minimal 
> version number?

Very good point!
/proc/pressure was introduced in Linux 4.20 
(https://kernelnewbies.org/Linux_4.20#Pressure_stall_information_for_better_overview_of_system_load)

I'm sending an update soon.
Thanks again

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


