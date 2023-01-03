Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307FEC53210
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 18:49:38 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.1801.1672771777324606663
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Jan 2023 10:49:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=LJuw9UfO;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 98242E0004;
	Tue,  3 Jan 2023 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1672771775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+31F9+l392wzJ76OkhydQOnRHZNDlatTKs97OAfqm8=;
	b=LJuw9UfOOwYpXOdVALoFD0FyH5iY2I9lA4GKNnIu44KM7O2MwWN86erueEywgDu49eD6Hg
	d0cKd44TTfit5ib2xJQJxxlE/jSZN+K+TmRKgB6hkRZekjgGQa8Xi850Z3SLku0joJ37ut
	FyyT8WJfCcZCDAdSpkf4fEmfYHDXXuPnvwmqBgOfSB5ypMu/7bSFOI0PsBw+mpa5UHNbnb
	c/8FgBuAMa7Tu0wHZDexNd/cWrLHWWP15W8rtnAqqioTVklQzsqUmgfjZ12G2cFWRCnSv0
	SEL0PfE29D1JLWLfWoodCL80GTKMTgtOo20xD6sv89Ai2+Fk6ZQkV3HjWrbstw==
Message-ID: <0d696eac-7344-ddad-504b-08d8205f33c2@bootlin.com>
Date: Tue, 3 Jan 2023 19:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] doc: user-manual: intro: reword a sentence
Content-Language: en-US
To: quentin.schulz@theobroma-systems.com,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 than.matos+bitbake@gmail.com, Quentin Schulz <foss+yocto@0leil.net>
References: <20230103-typo-202301-v1-0-bb5014c684d0@theobroma-systems.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230103-typo-202301-v1-0-bb5014c684d0@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Jan 2023 18:49:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14284


Am 03.01.23 um 18:59 schrieb Quentin Schulz via lists.yoctoproject.org:
> It's been reported this sentence is a bit odd, so let's reword it.
>
> Reported-by: than.matos+bitbake@gmail.com
> Suggested-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> Cc: Quentin Schulz <foss+yocto@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
> reword odd sentence
>
> Cc: docs@lists.yoctoproject.org
> Cc: bitbake-devel@lists.openembedded.org
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> index 35ffb88b0..797feb516 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -275,7 +275,7 @@ simple as ``busybox_%.bbappend`` to be entirely version independent.
>   Obtaining BitBake
>   =================
>   
> -You can obtain BitBake several different ways:
> +There are several different ways that BitBake can be obtained:
>   
>   -  **Cloning BitBake:** Using Git to clone the BitBake source code
>      repository is the recommended method for obtaining BitBake. Cloning
>
> ---
> base-commit: 367a83ed46c7fbcdd06579b6cc3a6e48a89ca7fb
> change-id: 20230103-typo-202301-c5f8f3571209
>
> Best regards,


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Thanks for the patch!
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


