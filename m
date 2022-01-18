Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D39C433EF
	for <webhook@archiver.kernel.org>; Tue, 18 Jan 2022 09:50:47 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web09.10683.1642499446647794849
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Jan 2022 01:50:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B81AC1C0003;
	Tue, 18 Jan 2022 09:50:44 +0000 (UTC)
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual: expand BB_HASHSERVE
 explanations
To: bitbake-devel@lists.openembedded.org
References: <16C6CAAE2E894D4C.29444@lists.yoctoproject.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <5d3d0511-4900-ddf8-7560-b710ffd41ed5@bootlin.com>
Date: Tue, 18 Jan 2022 10:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <16C6CAAE2E894D4C.29444@lists.yoctoproject.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Jan 2022 09:50:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13241


On 1/3/22 3:59 PM, Michael Opdenacker wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  .../bitbake-user-manual-ref-variables.rst                    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 3160a41a..e0f661cd 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -386,7 +386,10 @@ overview of their function and contents.
>  
>        The remote server can be started manually through
>        the ``bin/bitbake-hashserv`` script provided by BitBake,
> -      which supports UNIX domain sockets too.
> +      which supports UNIX domain sockets too. This script also allows
> +      to start the server in read-only mode, to avoid accepting
> +      equivalences that correspond to Share State caches that are
> +      only available on specific clients.
>  
>     :term:`BB_HASHSERVE_UPSTREAM`
>        Specifies an upstream Hash Equivalence server.


Patient ping ;-)
Thanks
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


