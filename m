Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD28C77B61
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 16:16:03 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web10.25352.1682612160865312802
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Apr 2023 09:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=KQKH2moj;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 758F6100006;
	Thu, 27 Apr 2023 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1682612159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m2Q2YbQKL2Tp+EKdrQb0qI3TcGb+exaBYvExBu1Nf8=;
	b=KQKH2moj5zULgYWOSaJwU0OvHWnwx6GW/8H4IQ43mxPq9WYAeqmoVt44NvBY73Fs7MN7xK
	206DwgSy1ijmJNT+fFQUNke7/xBIgJObi5WvY0MrqYQCGF6KDzVriXH14GF7UuyjnaFdtQ
	fYHwoQOUBpC81UZEcAiwK6qqa3d8hKvShDXrz3zTKMu95Bcqw/v4NWC2f1LymMmwjLF1Nh
	DN/rRdFkVPO+pcn6FoyUq5xqOwyC/05OpLBP+SVgXTDYFmt+JYzGYRIc4bKPddyGgxCE4A
	TAPMAV2Cx4ba3DzmSthLhZTEwEnrbxUJ5LL9sBk7nZfnJjV8MlNKkEl1rkW5hg==
Message-ID: <fdc1a244-7a52-f5d9-b5b4-607536ecae6a@bootlin.com>
Date: Thu, 27 Apr 2023 18:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: docs@lists.yoctoproject.org, yocto@pengutronix.de
Subject: Re: [docs] [PATCH] bitbake-user-manual: fix BB_RUNFMT's default value
Content-Language: en-US
To: =?UTF-8?Q?Ulrich_=c3=96lmann?= <u.oelmann@pengutronix.de>,
 bitbake-devel@lists.openembedded.org
References: <20230427130636.4028096-1-u.oelmann@pengutronix.de>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230427130636.4028096-1-u.oelmann@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 16:16:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14754

Hi Ulrich,

Thanks for the patch!

On 27.04.23 at 15:06, Ulrich Ölmann wrote:
> According to the code the default value is slightly different (see [1] which
> reflects the current tip commit at the time of writing).
>
> [1] https://git.openembedded.org/bitbake/tree/lib/bb/build.py?id=d97d62e2cbe4bae17f0886f3b4759e8f9ba6d38c#n237
>
> Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 6ccf58b21234..01d4f8d14a35 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -563,7 +563,7 @@ overview of their function and contents.
>         :term:`BB_RUNFMT` variable is undefined and the run filenames get
>         created using the following form::
>   
> -         run.{task}.{pid}
> +         run.{func}.{pid}
>   
>         If you want to force run files to take a specific name, you can set this
>         variable in a configuration file.


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


