Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A681EC433FE
	for <webhook@archiver.kernel.org>; Fri,  8 Oct 2021 08:57:08 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web09.6700.1633683427492853160
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Oct 2021 01:57:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 55C181C0003;
	Fri,  8 Oct 2021 08:57:05 +0000 (UTC)
Subject: Re: [docs] [PATCH 5/8] bitbake: replace http with https for URLs
To: Jon Mason <jdmason@kudzu.us>, openembedded-core@lists.openembedded.org,
 docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <20211007150630.22138-1-jdmason@kudzu.us>
 <20211007150630.22138-6-jdmason@kudzu.us>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <3377b038-93b4-0df5-7f51-e9d9c0f3cf62@bootlin.com>
Date: Fri, 8 Oct 2021 10:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007150630.22138-6-jdmason@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Oct 2021 08:57:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12754

Hi Jon,

Many thanks for the patches!

On 10/7/21 5:06 PM, Jon Mason wrote:
> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -60,11 +60,11 @@ member Chris Larson split the project into two distinct pieces:
>  -  OpenEmbedded, a metadata set utilized by BitBake
>  
>  Today, BitBake is the primary basis of the
> -`OpenEmbedded <http://www.openembedded.org/>`__ project, which is being
> +`OpenEmbedded <https://www.openembedded.org/>`__ project, which is being
>  used to build and maintain Linux distributions such as the `Angstrom
>  Distribution <http://www.angstrom-distribution.org/>`__, and which is
>  also being used as the build tool for Linux projects such as the `Yocto
> -Project <http://www.yoctoproject.org>`__.
> +Project <https://www.yoctoproject.org>`__.


Unrelated here, but Angstrom is defunct now and
http://www.angstrom-distribution.org down. I'll address this through a
different patch, though.

Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>*
*Thanks again!
Michael
**

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


