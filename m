Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web12.7717.1628689576072760508
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Aug 2021 06:46:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3F7DB1C0005;
	Wed, 11 Aug 2021 13:46:13 +0000 (UTC)
Subject: Re: [bitbake-devel] [PATCH v3 4/4] fetch2/wget: fetch securely by default
To: Ross Burton <ross@burtonini.com>, bitbake-devel@lists.openembedded.org
References: <20210810165509.19121-1-ross.burton@arm.com>
 <20210810165509.19121-4-ross.burton@arm.com>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <86a39b80-209b-8fc5-7239-ef6cf3541f55@bootlin.com>
Date: Wed, 11 Aug 2021 15:46:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810165509.19121-4-ross.burton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Ross,

Thanks for the patches!

On 8/10/21 6:55 PM, Ross Burton wrote:
> From: Ross Burton <ross@burtonini.com>
>
> The days of broken certificates are behind us now, so instead of always
> passing --no-check-certificate to wget, don't pass it by default and
> instead only pass it BB_CHECK_SSL_CERTS = "0".
>
> [ YOCTO #14108 ]
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  .../bitbake-user-manual-fetching.rst          |  4 ++++
>  .../bitbake-user-manual-ref-variables.rst     |  4 ++++
>  bitbake/lib/bb/fetch2/wget.py                 | 19 ++++++++++++++++---
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst

This patch looks good, but your patches seem to apply to the Poky repo,
not BitBake. Wouldn't be easier for Richard if you submitted patches for
the BitBake repo instead? That's where the patches need to go, if I
understood correctly. Unless there's a workflow I'm not familiar with...

Cheers,
Michael.
-- 

Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

