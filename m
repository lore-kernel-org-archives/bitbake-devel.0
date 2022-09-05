Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BBEECAAD5
	for <webhook@archiver.kernel.org>; Mon,  5 Sep 2022 14:21:33 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web09.25119.1662387688074281103
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Sep 2022 07:21:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=T207zLqA;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6332DE0009;
	Mon,  5 Sep 2022 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1662387686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8C4TIDUeexMhK9KWD0GTcmeaG8m/XJA1COreU8wj5o=;
	b=T207zLqAaRb/ZoOKEZdK9kmVRaQIsbHdMt22J1/EHh00g5VTfkpWNNyQxhuZ/1m4sXOvNl
	odcyRvOB8QB9pn9WA8M661J8sss0ThBxLPOmUxfT1CpdMXU/InYmKS1c/QYBzCKkgBDv04
	QA+D2RssJY6uJLXGze5TPi3lwtXbH4u30/7Ns0bZ0ZOQaiWTY6kuYmHQyq2d+GVvVaQTA/
	DVSgW3tbRGdqGXty2/UjdtpMadBpZpmcLYRI+46mwXG2Ufkq3DlOuUsD24hjst95RJx2b2
	iBcxP6LZ2yl4Q+vLl/pXu5U76BqIMsCp5oF8mt5jk7W++nSUTWw5xXAPCxNFtA==
Message-ID: <fd4adc11-ec14-ac22-31d4-12ff883a65e5@bootlin.com>
Date: Mon, 5 Sep 2022 16:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: docs@lists.yoctoproject.org, Aryaman Gupta <aryaman.gupta@windriver.com>,
 Randy Macleod <Randy.Macleod@windriver.com>
Subject: Re: [bitbake-devel] [PATCH v3] doc: bitbake-user-manual: Add
 definition for BB_PRESSURE_MAX variables
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 bitbake-devel@lists.openembedded.org
References: 
 <832988652fd0646394de3145564a068ba6c59b51.camel@linuxfoundation.org>
 <20220902173550.89987-1-michael.opdenacker@bootlin.com>
 <676e32d5-7341-a389-206f-ac515ab37c50@theobroma-systems.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <676e32d5-7341-a389-206f-ac515ab37c50@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Sep 2022 14:21:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13959

Hi Quentin

On 9/5/22 15:54, Quentin Schulz wrote:
> Hi Michael,
>
> On 9/2/22 19:35, Michael Opdenacker via lists.openembedded.org wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> From: Aryaman Gupta <aryaman.gupta@windriver.com>
>>
>> Add the definitions for the BB_PRESSURE_MAX{CPU|IO|MEMORY} variables 
>> in the
>> bitbake varibales glossary. Further information on how to determine a 
>> good
>> threshold will be added to the Yocto reference manual in a later commit.
>>
>> Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
>> Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
>
> IIRC you're supposed to add your SoB when you're sending a patch even 
> if it comes from someone else.
>
> Otherwwise, looks good.
>
> Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>


Thanks for the clarification. Indeed, according to 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=further+sobs#sign-your-work-the-developer-s-certificate-of-origin, 
anyone participating to the distribution of the patch should add his/her 
SoB too.

I'll keep this in mind next time. I hope Richard can add those when merging.

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


