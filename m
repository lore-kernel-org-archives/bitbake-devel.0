Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E633C433F5
	for <webhook@archiver.kernel.org>; Fri, 14 Jan 2022 15:45:42 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web08.8946.1642175140522697958
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Jan 2022 07:45:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B9CCBC0008;
	Fri, 14 Jan 2022 15:45:37 +0000 (UTC)
Cc: bitbake-devel@lists.openembedded.org, ashishm@mvista.com
Subject: Re: [bitbake-devel] [1.46][PATCH] hashserv: specify loop for asyncio
 in python < 3.7
To: Jate Sujjavanich <jatedev@gmail.com>
References: <20220113010527.181-1-jatedev@gmail.com>
 <78ac1aea-db40-2a99-1668-dc3bfcb3a074@bootlin.com>
 <CAPphmgaM5ABM=omAhgizE+ay+S65hELq_rgQio9ed4aVdSTRNQ@mail.gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <142b4c2a-d019-7f48-26e3-d64bbcc7ea13@bootlin.com>
Date: Fri, 14 Jan 2022 16:45:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: 
 <CAPphmgaM5ABM=omAhgizE+ay+S65hELq_rgQio9ed4aVdSTRNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Jan 2022 15:45:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13235

Hi Jate

Thanks for your advice!

On 1/13/22 7:04 PM, Jate Sujjavanich wrote:
> Hello Michael,
>
> I tested on an Ubuntu 20.04 docker container, and the code worked in
> that environment. It has kernel 5.10.25-linuxkit which is different
> from the default kernel in Ubuntu 20.04 which is 5.4.
>
> I chose to keep the loop argument for versions 3.6 and below because
> python first deprecated the loop argument in 3.7. Perhaps it's safer
> to keep specifying loop for 3.9 and below. There is one other report
> of the bug but it seems to be the result of the fix for 3.10 in
> October. So it was probably working for python 3.9 and below.
>
> Could you try the fix with the minor number changed to 10?
>
> if sys.version_info[0] == 3 and sys.version_info[1] < 10:
>
> If that works, I will update the patch. I am not familiar with the
> asyncio library and its system calls, so I'm hoping this works.

Actually, I don't have the issue on BitBake 1.46 (testing on Dunfell).
Just tested.

I have it with the version in master Poky, and your patch doesn't apply.

Cheers,
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


