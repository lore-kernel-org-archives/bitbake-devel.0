Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A0EB64DB
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 20:16:48 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.268.1687292205686793248
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jun 2023 13:16:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=EmHi0/1v;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1687292203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U671rImQ6pdLpSTxfg2SnBKmm2MpqB7z2CQS6JfFBeQ=;
	b=EmHi0/1vmGIjXDT/uhL2A6X30FfgqiGfjgteao31M9Rgm24ICjTme+B9GVZCw87rCA/BxD
	12Vq6CYaDUtNv9mFDrblbPbRZGm4wuOfI12pgzS9obHNSh+v5Qgq6PEbzoPMk2csX1wLCr
	GD4Sdm52to6XdASkrkeU870kojCg4CeiZGtZ7ZGzvZmLsSEMX+g3OcESIBx7wpC9CVJU1U
	ARX6F6tJEEdm0aGbErEnA1PhiHtGyoa2lGoAjWomzLjgmQ2dn6p+N4AUeGSOe7QTcYVwDa
	tkg0NWKlixPobieishbix4GLbL5NC1ptmx0LrqV0mV827SsPoPtxdH7ULIq4rw==
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53D6E60005;
	Tue, 20 Jun 2023 20:16:43 +0000 (UTC)
Message-ID: <60145e50-fd6a-b28c-51ab-f3cf3540f4a5@bootlin.com>
Date: Tue, 20 Jun 2023 22:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] doc: Document FILE_LAYERNAME
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20230620135822.2802308-1-richard.purdie@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230620135822.2802308-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jun 2023 20:16:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14852

Hi Richard

On 20.06.23 at 15:58, Richard Purdie wrote:
> Document the new variable.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   .../bitbake-user-manual-ref-variables.rst                    | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index ee5d7ba8d4..337cfa3ed5 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1072,6 +1072,11 @@ overview of their function and contents.
>         environment variable. The value is a colon-separated list of
>         directories that are searched left-to-right in order.
>   
> +   :term:`FILE_LAYERNAME`
> +      During parsing and task execution, this is set to the name of the
> +      layer containing the recipe file. Code can use this to identify which
> +      layer a recipe is from.
> +
>      :term:`GITDIR`
>         The directory in which a local copy of a Git repository is stored
>         when it is cloned.


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

If you can merge this commit quickly, I'll be able to include the Yocto 
Manual one you submitted, referring to it.
Thanks!
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


