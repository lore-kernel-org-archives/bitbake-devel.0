Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D423C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 17:41:30 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web10.419.1646847689448086493
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Mar 2022 09:41:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=YawVg9Ud;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1839E240006;
	Wed,  9 Mar 2022 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646847687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H5nB0S0zl+j6NOmQbo/svPHBr50xj8ZhGc/FEyw7BM=;
	b=YawVg9UdDFw3HNIb+UsP2bMn0Fmr+cntw6PrY0VjjDCX2sQ69TiVPuZUeM9aM0422pqsqh
	oIFfd2A/1UkJxwU8DR7sJVvJjS33WrCbWISbNbSl738RcXI+RvVjQLRNjkf5rc4JL0IXb4
	TFJOPrV+wNsJJ5s34zyG5nUeD+2AC26DdGpukPX1ZhxC5y6kZDSahErMRxwWLZFuKMa40u
	Lva76tmGgYYqG0Jd6Qm/OKqXXQn3oJBjpGDg1mp+nVp/Be2D9EHasAr1pI/hwDyspjHxR9
	bdbyGrXx9CKlcy7TccB7ilSwJFsXE8mGxcWzdLnwDz9O9F+5OIwzitPjPrcXsg==
Message-ID: <0b52ecf5-195a-f938-391e-1f2086296bda@bootlin.com>
Date: Wed, 9 Mar 2022 18:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [docs] Time to make "branch" parameter mandatory in git SRC_URIs?
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <012f6398-a8dd-39fa-bb29-aeff10ab87c9@bootlin.com>
 <08a7766617e5541af2b721a5cbbcb55c7c3a93bd.camel@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: 
 <08a7766617e5541af2b721a5cbbcb55c7c3a93bd.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Mar 2022 17:41:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13454


On 3/9/22 18:33, Richard Purdie wrote:
> On Wed, 2022-03-09 at 18:30 +0100, Michael Opdenacker via lists.yoctoproject.org
> wrote:
>> Hi Richard,
>>
>> In the documentation (migration notes for 3.5), we say that the "branch"
>> parameter is mandatory in git SRC_URIs.
>>
>> However, that's not true yet in the code, which just issues a warning:
>> https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/git.py#n175
>>
>> Given that the warning period was probably long enough, wouldn't it be
>> time to align the code with the documentation ;-) ?
>>
>> At least, this would make it easier for me to update the BitBake manual.
> Lets just assume it mandatory for the docs since otherwise you do see warnings?
>
> Cheers,
>
> Richard

Sounds good to me, thanks!
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


