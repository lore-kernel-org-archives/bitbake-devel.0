Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web11.709.1619190895761189981
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 08:14:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.232, mailfrom: michael.opdenacker@bootlin.com)
Received: from [10.0.0.12] (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay12.mail.gandi.net (Postfix) with ESMTPSA id 480D0200008;
	Fri, 23 Apr 2021 15:14:53 +0000 (UTC)
Cc: Michal Piechowski <m.z.piechowski@gmail.com>
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual: fix typo left over from Sphinx migration
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <20210422075454.258616-1-nicolas.dechesne@linaro.org>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <61a2bdf4-67cb-b14b-722d-c067415fdad7@bootlin.com>
Date: Fri, 23 Apr 2021 17:14:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422075454.258616-1-nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Nicolas,

On 4/22/21 9:54 AM, Nicolas Dechesne wrote:
> Fixes d99760cc687c (sphinx: last manual round of fixes/improvements)
>
> Reported-by: Michal Piechowski <m.z.piechowski@gmail.com>
> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-hello.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> index e3fd3215..fab1e8a6 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> @@ -325,9 +325,9 @@ Following is the complete "Hello World" example.
>      following: ::
>  
>        BBPATH .= ":${LAYERDIR}"
> -      BBFILES += "${LAYERDIR}/\*.bb"
> +      BBFILES += "${LAYERDIR}/*.bb"
>        BBFILE_COLLECTIONS += "mylayer"
> -     `BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
> +      BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
>  
>      For information on these variables, click on :term:`BBFILES`,
>      :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS` or :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`


Thanks for this fix. I checked that the HTML output looks good.

Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Cheers,

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

