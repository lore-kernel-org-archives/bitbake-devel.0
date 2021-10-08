Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5028DC43219
	for <webhook@archiver.kernel.org>; Fri,  8 Oct 2021 12:19:47 +0000 (UTC)
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net
 [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web09.8425.1633695586391438274
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Oct 2021 05:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.178.232, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay12.mail.gandi.net (Postfix) with ESMTPSA id 615E420000A;
	Fri,  8 Oct 2021 12:19:44 +0000 (UTC)
Subject: Re: [docs] [PATCH 8/8] dev-manual: remove errant /
To: Jon Mason <jdmason@kudzu.us>, openembedded-core@lists.openembedded.org,
 docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <20211007150630.22138-1-jdmason@kudzu.us>
 <20211007150630.22138-9-jdmason@kudzu.us>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <098613a4-6d10-6813-00d9-3bb8f6025296@bootlin.com>
Date: Fri, 8 Oct 2021 14:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007150630.22138-9-jdmason@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Oct 2021 12:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12758


On 10/7/21 5:06 PM, Jon Mason wrote:
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> ---
>  documentation/dev-manual/start.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/documentation/dev-manual/start.rst b/documentation/dev-manual/start.rst
> index fc1b7c30752e..1ca25318cd53 100644
> --- a/documentation/dev-manual/start.rst
> +++ b/documentation/dev-manual/start.rst


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Applied to master-next. Many thanks!
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


