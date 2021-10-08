Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB91C433EF
	for <webhook@archiver.kernel.org>; Fri,  8 Oct 2021 09:08:37 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web08.6622.1633684115708807069
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Oct 2021 02:08:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 991C21C000C;
	Fri,  8 Oct 2021 09:08:33 +0000 (UTC)
Subject: Re: [docs] [PATCH 6/8] documentation: replace http with https for
 URLs
To: Jon Mason <jdmason@kudzu.us>, openembedded-core@lists.openembedded.org,
 docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <20211007150630.22138-1-jdmason@kudzu.us>
 <20211007150630.22138-7-jdmason@kudzu.us>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <3eb56880-8ecb-db1b-1a6b-fbc69074cf7f@bootlin.com>
Date: Fri, 8 Oct 2021 11:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007150630.22138-7-jdmason@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Oct 2021 09:08:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12755

Hi Jon,

Thanks for the patch!

On 10/7/21 5:06 PM, Jon Mason wrote:
> https has been the preferred way to access websites for many years now.
> Change all of the URLs with a _working_ https server/certificate to use
> that URL.
>
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> ---
>  documentation/profile-manual/usage.rst     | 28 +++++++++++-----------
>  documentation/ref-manual/faq.rst           | 16 ++++++-------
>  documentation/ref-manual/variables.rst     |  8 +++----
>  documentation/toaster-manual/reference.rst |  8 +++----
>  4 files changed, 30 insertions(+), 30 deletions(-)


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
and merged into master-next (I want this to be part of the pull request
I'm sending today).

Thanks again,

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


