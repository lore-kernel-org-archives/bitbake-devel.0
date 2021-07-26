Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.32777.1627318552694516729
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 09:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 94123240002;
	Mon, 26 Jul 2021 16:55:50 +0000 (UTC)
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss@0leil.net>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH] doc: Makefile: turn warnings into errors by default
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20210726153446.2503018-1-quentin.schulz@theobroma-systems.com>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <a0ddc662-dddc-dba4-d4e0-bbf94d8c9f9f@bootlin.com>
Date: Mon, 26 Jul 2021 18:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726153446.2503018-1-quentin.schulz@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hello Quentin,

Thank you for the new *BitBake* documentation patch. I CC the
bitbake-devel mailing list.

On 7/26/21 5:34 PM, Quentin Schulz wrote:
> -W is for turning warnings into errors, --keep-going to make sure the
> whole documentation is built and all warnings will be printed before
> failing.
>
> Since there's currently no warning, it's time to introduce it!
>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Signed-off-by: Quentin Schulz <foss@0leil.net>
> ---
>  doc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/Makefile b/doc/Makefile
> index d40f390e..996f01b7 100644
> --- a/doc/Makefile
> +++ b/doc/Makefile
> @@ -3,7 +3,7 @@
>  
>  # You can set these variables from the command line, and also
>  # from the environment for the first two.
> -SPHINXOPTS    ?= -j auto
> +SPHINXOPTS    ?= -W --keep-going -j auto
>  SPHINXBUILD   ?= sphinx-build
>  SOURCEDIR     = .
>  BUILDDIR      = _build

Tested-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Richard, can you merge this patch as it was sent to the [docs] mailing list?
Thanks in advance,
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

