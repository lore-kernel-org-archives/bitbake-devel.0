Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web12.20296.1628762794611097678
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Aug 2021 03:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3B7E8E000A;
	Thu, 12 Aug 2021 10:06:31 +0000 (UTC)
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual-execution: remove mention to long-gone BBHASHDEPS variable
To: Quentin Schulz <foss@0leil.net>, bitbake-devel@lists.openembedded.org
References: <20210811201912.13648-1-foss@0leil.net>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <c685ac8f-1e87-6756-2109-9a2d0ac3e292@bootlin.com>
Date: Thu, 12 Aug 2021 12:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811201912.13648-1-foss@0leil.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 8/11/21 10:19 PM, Quentin Schulz wrote:
> BBHASHDEPS was removed from bitbake in April 2014, with the following
> commit:
> 92526eadd09d "bitbake-worker: Drop BBHASH variables"
>
> so let's remove mentions from the docs.
>
> Signed-off-by: Quentin Schulz <foss@0leil.net>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-execution.rst | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index a6ef90db12..6153f36a0f 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -578,9 +578,6 @@ the build. This information includes:
>  -  ``BB_BASEHASH_``\ *filename:taskname*: The base hashes for each
>     dependent task.
>  
> --  ``BBHASHDEPS_``\ *filename:taskname*: The task dependencies for
> -   each task.
> -
>  -  :term:`BB_TASKHASH`: The hash of the currently running task.
>  
>  It is worth noting that BitBake's "-S" option lets you debug BitBake's


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Thanks!
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

