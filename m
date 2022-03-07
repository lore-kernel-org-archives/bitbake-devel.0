Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C8C433FE
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 13:18:55 +0000 (UTC)
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net
 [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web10.25997.1646659134225291724
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 05:18:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=m3oTsGnr;
 spf=pass (domain: bootlin.com, ip: 217.70.178.232,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 3202C20000C;
	Mon,  7 Mar 2022 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646659132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOnWerITsOEGGPH3tOOUKnFb8+lxRVcakdnbpwSi/5s=;
	b=m3oTsGnrc5hI/8OT0G001kGTS0t+iTZWCIiMHoSEuttvCaIh/OGL8uRBZT9tjCqo6ctbfM
	+BFuyZhZNw2j6VAK83W1TJKAwoODWVoftlTelx+JKOeDV+9FM84T/eXkofIpqRTsIV31H6
	99bqr+QCcfMNVF9YS4RJDVU3l/1+7OHrYVEMvnMV6ihpIfBDc8w3cTHgdwX/LrQPAymwh4
	wzHTiGsC9BZemLMjUI6RXb9dBZYezIV20t2wgaDQsxWLZBhMsTlZCKkBci0O3vj9Lgv090
	A3PIXyKW/4/Vz841DaMKhrQwIR56XBnN9O6mPOvIxCnUotB4YTjWlp4ElI7Wjw==
Message-ID: <487e734b-9e27-169f-2290-9920023e2ccc@bootlin.com>
Date: Mon, 7 Mar 2022 14:18:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] bitbake-user-manual: add recent release manuals
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <16DA1B8D92F1D6CA.28939@lists.yoctoproject.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <16DA1B8D92F1D6CA.28939@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 13:18:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13425


On 3/7/22 14:15, Michael Opdenacker via lists.yoctoproject.org wrote:
> Add links corresponding to recent releases
> Align the title of sections with yocto-docs' releases.rst
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  doc/releases.rst | 84 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 63 insertions(+), 21 deletions(-)


Oops, wrong version of the patch. Please ignore.
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


