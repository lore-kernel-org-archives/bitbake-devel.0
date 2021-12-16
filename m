Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F62C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 09:54:56 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web09.8772.1639648495738261951
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 01:54:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A12C11BF203;
	Thu, 16 Dec 2021 09:54:52 +0000 (UTC)
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH v2] doc: bitbake-user-manual: expand BB_HASHSERVE
 and document BB_HASHSERVE_UPSTREAM
To: bitbake-devel@lists.openembedded.org
References: <16C0F955FEA53DE5.26558@lists.yoctoproject.org>
 <16C133788573DBFD.8581@lists.yoctoproject.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <3ed47ca8-b684-57fd-67bb-87cbfb8a88ca@bootlin.com>
Date: Thu, 16 Dec 2021 10:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <16C133788573DBFD.8581@lists.yoctoproject.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 09:54:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13178


On 12/16/21 10:52 AM, Michael Opdenacker wrote:
>  
>        If set to ``auto``, BitBake automatically starts its own server
> -      over a UNIX domain socket.
> +      over a UNIX domain socket. An option is to connect this server
> +      to an upstream one, by setting :term:`BB_HASHSERVE_UPSTREAM`.

This new iteration just adds a reference to BB_HASHSERVE_UPSTREAM when
BB_HASHSERVE = "auto"

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


