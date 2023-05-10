Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B8C77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 13:24:59 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.16625.1683725098150803622
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 May 2023 06:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=c+CIpLgZ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 01DCC6000E;
	Wed, 10 May 2023 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1683725095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGn0Iovgx+mMbYs4d28Gmt+qDS0J1RytDYMJNSwt5/g=;
	b=c+CIpLgZmZBh5dlE1LNxc3X0K7FsXCjDrggi5vyJqHdf0xtD2IcwYNOTs4SHaki4fjhXQq
	1rJp0SO9i3+DEWS0MXPIM+trYr/5i9aoe0GKMAuUzyzzStpcISvkrx/IsSG8gVGzlpcKhX
	XCXPA+ZNsm+MN5fcTCQFbBgSjbmeNGYWsSmkQVC7eUHyqE3yTrnMh4mZkCmUixz62xkTCc
	ipSHWY4TWiLiByT22aQPTVyWuztbdPeTABQsCLNIZwFA6P5PzQJF4WdUzkkdvLNyUFWbZo
	T21UXuQnM4x+cdRCXATSTCFVttNS4HxUw4OU+QLLbLVZCc45rHY/J6UCKb572Q==
Message-ID: <e49c8cc5-b3ca-505e-9054-ab3152bab712@bootlin.com>
Date: Wed, 10 May 2023 15:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] bitbake: git fetcher: use urllib quote
 ...
Content-Language: en-US
To: thilo.cestonaro@thalesgroup.com
References: <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
 <b4f209d135c1dcf47253ba561ccbde128b0123e9.camel@linuxfoundation.org>
 <PR0P264MB1882562678B304BEBDDFC68AE9779@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <PR0P264MB1882562678B304BEBDDFC68AE9779@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 13:24:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14778

Hi Thilo,

On 10.05.23 at 15:10, Thilo C. via lists.openembedded.org wrote:
> Hi Richard!
>
>> I'd like to ensure that we add test coverage to "bitbake-selftest" to
>> cover this situation (see lib/bb/tests/fetch.py).
>>
>> We tend not to accept fixes like this unless we have test coverage to
>> prevent future regressions.
> Next version of my patch. I tried to have a as simple as possible test which exactly does show what goes wrong without my patch.


Thank you very much for the patch, but please don't send it as an 
attachment. Otherwise, people cannot comment or ask questions about 
specific lines.

You should basically send your patches through "git send-email". See 
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded

Thanks in advance :)
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


