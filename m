Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314DAC433EF
	for <webhook@archiver.kernel.org>; Fri,  8 Oct 2021 12:16:01 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web10.8207.1633695359993136232
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Oct 2021 05:16:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay10.mail.gandi.net (Postfix) with ESMTPSA id DFFE5240011;
	Fri,  8 Oct 2021 12:15:57 +0000 (UTC)
Subject: Re: [docs] [PATCH 7/8] documentation: use YOCTO_DL_URL
To: Jon Mason <jdmason@kudzu.us>, openembedded-core@lists.openembedded.org,
 docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <20211007150630.22138-1-jdmason@kudzu.us>
 <20211007150630.22138-8-jdmason@kudzu.us>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <368abe36-f66d-3b6f-7bfe-5698fc754016@bootlin.com>
Date: Fri, 8 Oct 2021 14:15:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007150630.22138-8-jdmason@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Oct 2021 12:16:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12757

Hi Jon

On 10/7/21 5:06 PM, Jon Mason wrote:
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> ---
>  documentation/profile-manual/usage.rst | 28 +++++++++++++-------------
>  documentation/ref-manual/faq.rst       | 16 +++++++--------
>  documentation/ref-manual/variables.rst |  8 ++++----
>  3 files changed, 26 insertions(+), 26 deletions(-)


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Merged in "master-next".
Many thanks!
Michael.
-- 

Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


