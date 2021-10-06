Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFA3C433EF
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 14:41:23 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.13048.1633531282625903259
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 07:41:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B38464000B;
	Wed,  6 Oct 2021 14:41:19 +0000 (UTC)
Subject: Re: [docs] [PATCH 1/2] documentation: update sources mirror URL
To: Jon Mason <jdmason@kudzu.us>, docs@lists.yoctoproject.org,
 bitbake-devel@lists.openembedded.org
References: <20211005224513.14134-1-jdmason@kudzu.us>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <35bcdc42-9ed6-5232-c94e-c69f3fd7af94@bootlin.com>
Date: Wed, 6 Oct 2021 16:41:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005224513.14134-1-jdmason@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Oct 2021 14:41:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12732

Hi Jon

Thanks for the proposed update !

On 10/6/21 12:45 AM, Jon Mason wrote:
> The URL for the sources mirror no longer works.  Update to the new
> location.
>
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> ---
>  documentation/ref-manual/faq.rst       | 15 ++++++++-------
>  documentation/ref-manual/variables.rst |  8 ++++----
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
> index d3a603d4a438..f06abc84ee6f 100644
> --- a/documentation/ref-manual/faq.rst
> +++ b/documentation/ref-manual/faq.rst
> @@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
>  ``local.conf`` configuration file::
>  
>     PREMIRRORS:prepend = "\
> -       git://.*/.* http://www.yoctoproject.org/sources/ \n \
> -       ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
> -       http://.*/.* http://www.yoctoproject.org/sources/ \n \
> -       https://.*/.* http://www.yoctoproject.org/sources/ \n"
> +       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> +       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> +       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> +       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"


Hey, doesn't it sound weird to show an example that proposes to use http
when https is usually recommended?
What about proposing https://downloads.yoctoproject.org/mirror/sources/
instead?

Or we don't really care because we use source checksums anyway?

Just my two cents. I don't mind accepting the patch as is.

Thanks again,
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


