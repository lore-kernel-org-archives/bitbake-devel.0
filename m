Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A34C4345F
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 13:50:16 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.18339.1712843406618771465
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Apr 2024 06:50:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=iQPAvMEg;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C29A2000D;
	Thu, 11 Apr 2024 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712843404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jljlmTaFc7rB4eSgJRrQg8BSZ/77cGONMLFXCmeW40U=;
	b=iQPAvMEgyhgAEZcIGlEbRYNbUS3yODNemacVSAaEuIOyJK/Q4XcyidLFc/udYlfxAsUSlz
	2BWimKoYHzTxFj4BnyQJhWXq59R3PnIk8vapb8SDKHa4k2cimXAHYQeRkgDV2o2YOG+Psq
	OV5c22qe2xzItdcJw3SI5Whyf2JTmuh9Wl0bdRSt0XYfQ62xwelFZX0H21WVNGZ8IQ9u6U
	cmqtoJxWkwvCE4sG20KB6OBmzqQ+loBIuen2FgMpwVJH1IAE0vIhJldlUevxKVFiw503C7
	c4dGwEDYTkMFwfJOrD2SzPxQiH2v15lkkx4skI6/Ud+x1K/e2v5IWNuE9/uetw==
Message-ID: <15a8400a-37b6-4216-96a2-1ba5d48654d6@bootlin.com>
Date: Thu, 11 Apr 2024 15:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org,
 YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH] doc/user-manual: Add BB_LOADFACTOR_MAX
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20240411122508.2149106-1-richard.purdie@linuxfoundation.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240411122508.2149106-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Apr 2024 13:50:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16072

Hi Richard,

On 4/11/24 at 14:25, Richard Purdie wrote:
> Document BB_LOADFACTOR_MAX which was recently added.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   .../bitbake-user-manual-ref-variables.rst                | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index d3936935cd..00faeea686 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -432,6 +432,15 @@ overview of their function and contents.
>         ``ConfigParsed`` event can set the variable to trigger the re-parse.
>         You must be careful to avoid recursive loops with this functionality.
>   
> +   :term:`BB_LOADFACTOR_MAX`
> +      Setting this to a value will cause bitbake to check the system load
s/bitbake/BitBake/

That's the convention we follow everywhere, when talking about the 
total, not the command to type of course.
> +      average before executing new tasks. If the load average is above the
> +      the number of CPUs multipled by this factor, no new task will be started
> +      unless there is no task executing. A value of "1.5" has been found to
> +      work reasonably. This is helpful for systems which don't have pressure
> +      regulation enabled, which is more granular. Pressure values take
> +      precedence over loadfactor.
> +

Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Once this is merged, I'll make the YP docs directly point to this in the 
BitBake manual. At the moment, we have a shorter description.
Thanks!
Michael

-- 

Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


