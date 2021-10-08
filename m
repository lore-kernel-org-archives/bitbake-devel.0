Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920EEC433EF
	for <webhook@archiver.kernel.org>; Fri,  8 Oct 2021 12:48:54 +0000 (UTC)
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net
 [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web09.8772.1633697333338400427
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Oct 2021 05:48:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.178.232, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8F52A20000D;
	Fri,  8 Oct 2021 12:48:51 +0000 (UTC)
Subject: Re: [bitbake-devel] [PATCH 1/2] knotty/uihelper: Show setscene task
 progress in summary output
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20211007125530.2414480-1-richard.purdie@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <ccd7f47b-ec5b-8bea-05de-ea61f5bf4d19@bootlin.com>
Date: Fri, 8 Oct 2021 14:48:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007125530.2414480-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Oct 2021 12:48:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12759

Hi Richard,

On 10/7/21 2:55 PM, Richard Purdie wrote:
> With the changes to task accounting, bitbake doesn't show progress
> when executing setscene tasks on the summary console output.
>
> Change to show a progress within the setscene tasks and a progress
> within the main tasks. I can't see any way to display this more easily
> without confusing users.
>
> [YOCTO #14586]


Tested-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
This looks like a good solution. We clearly see what's going on.
Thanks!
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


