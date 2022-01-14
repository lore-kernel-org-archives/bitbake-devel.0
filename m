Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B1C433F5
	for <webhook@archiver.kernel.org>; Fri, 14 Jan 2022 16:00:19 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.8952.1642176019149123032
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Jan 2022 08:00:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id F414AFF80E;
	Fri, 14 Jan 2022 16:00:13 +0000 (UTC)
Cc: bitbake-devel@lists.openembedded.org, ashishm@mvista.com
Subject: Re: [bitbake-devel] [1.46][PATCH] hashserv: specify loop for asyncio
 in python < 3.7
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: Jate Sujjavanich <jatedev@gmail.com>
References: <20220113010527.181-1-jatedev@gmail.com>
 <78ac1aea-db40-2a99-1668-dc3bfcb3a074@bootlin.com>
 <CAPphmgaM5ABM=omAhgizE+ay+S65hELq_rgQio9ed4aVdSTRNQ@mail.gmail.com>
 <16CA2D972C0D44B2.13159@lists.openembedded.org>
Organization: Bootlin
Message-ID: <54534c9f-7cb4-1b01-1fa1-009b23ea847d@bootlin.com>
Date: Fri, 14 Jan 2022 17:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <16CA2D972C0D44B2.13159@lists.openembedded.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Jan 2022 16:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13236


On 1/14/22 4:45 PM, Michael Opdenacker wrote:
>
> Actually, I don't have the issue on BitBake 1.46 (testing on Dunfell).
> Just tested.
>
> I have it with the version in master Poky, and your patch doesn't apply.


I filed a new bug about this:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=14689
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


