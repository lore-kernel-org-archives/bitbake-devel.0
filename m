Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA02C433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 16:05:48 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web09.14098.1642694746564393803
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 08:05:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 89A484000C;
	Thu, 20 Jan 2022 16:05:44 +0000 (UTC)
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [bitbake-devel] [PATCH] bitbake-user-manual: add "crate"
 fetcher
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 bitbake-devel@lists.openembedded.org
References: <20220120105438.1212027-1-michael.opdenacker@bootlin.com>
 <24786647-3cd2-d084-cc59-62ffa6cb241e@theobroma-systems.com>
 <d986349f-951e-1530-5514-f89101cb91b4@bootlin.com>
 <6d0658a8-e7fc-b645-787e-a1d411e8042b@theobroma-systems.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <18284cec-1192-735d-c8e7-32a257252a74@bootlin.com>
Date: Thu, 20 Jan 2022 17:05:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6d0658a8-e7fc-b645-787e-a1d411e8042b@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 16:05:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13260

Hi Quentin,

On 1/20/22 4:47 PM, Quentin Schulz wrote:
> Seems like they call it "registry", c.f.
> https://doc.rust-lang.org/cargo/reference/registries.html#registries
>
> I can suggest "other crate registries" and "crate://REGISTRY/NAME/..." ?


This definitely makes sense. Thank you with your much appreciated help!
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


