Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8980C4708E
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 09:09:30 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.7872.1672823364288818319
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jan 2023 01:09:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=pZ4fvUxT;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 9E10F40017;
	Wed,  4 Jan 2023 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1672823362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ks6uqONUO7lfIPsEawsYtUztv9n7nb8swGhFkFcITbs=;
	b=pZ4fvUxTWodKAd4LUxA6KtvvbqOP+fRnZ2Wirg/ZiaTnvCTrpSFSx3nr34/JTtXQ63viz5
	Uo0OEskgwwk08p1TNMmqL44aadouz87i11vpisyoUQbcxg72k48eDhng1IIMkN+Vdz91jP
	GWqsiszrNqMccV4Xske3LtxXHvU2eN7sFh8WTXpnHeWiDw/gkpSdTzY1BdoCTYDPa3WOwQ
	PefTHTmZsi+tBJGlEdwHtoKfyXujvCwnTGiDtOva7gV0dnvgcxOBJCtgylWsDsBuLsOPpS
	fpOchmj+uiI1N09OGRY6RAT974RhBCRG2lRmBFH1SsH3tOvygJrQuEU2PpcHLQ==
Message-ID: <06079ed7-7f81-c869-e141-b62d29497585@bootlin.com>
Date: Wed, 4 Jan 2023 10:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] Typo on the BitBake Documentation
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 than.matos+bitbake@gmail.com, bitbake-devel@lists.openembedded.org
References: <bWm9.1672174859052782246.2l5k@lists.openembedded.org>
 <dee6ed9a3beabd5cd18042c61b0dfd31c2c4ff8e.camel@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <dee6ed9a3beabd5cd18042c61b0dfd31c2c4ff8e.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jan 2023 09:09:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14286

Hi Richard,

Am 03.01.23 um 23:24 schrieb Richard Purdie:
> On Tue, 2022-12-27 at 13:00 -0800, than.matos+bitbake@gmail.com wrote:
>> I'm not sure if this is the right place to report and if I'm writing
>> in the wrong place, please feel free to remove this post.
>>   
>> I'm also not a native of English, but I think there is a typo on the
>> BitBake documentation page.
>>   
>>> You can obtain BitBake several different ways:
>> I feel like there is a missing `in` before the word `several`.
>>   
>> Sorry to bother you!
> Thanks for reporting it.
>
> I'm a little torn on this. I am a native speaker and I'd have said it
> was probably sounds better as it is now. Adding "in" could likely be
> argued to me more grammatically correct and more formal for a written
> document but it doesn't feel quite right to me. I suspect it is one of
> those cases where there isn't a 100% correct answer.


Thanks for the native advice!

What about "There are several ways to obtain BitBake"?

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


