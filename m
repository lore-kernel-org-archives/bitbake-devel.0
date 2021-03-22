Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web08.398.1616425890036064603
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Mar 2021 08:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: from [10.0.0.8] (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay10.mail.gandi.net (Postfix) with ESMTPSA id EAC11240005;
	Mon, 22 Mar 2021 15:11:27 +0000 (UTC)
Subject: Re: [bitbake-devel] [PATCH] doc: fix glossary link for BB_INVALIDCONF variable
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <e4fff4fe-acf7-a9ab-8189-b191458797de@crashcourse.ca>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <91da75d2-2568-297d-d9c3-a00a3079a1b9@bootlin.com>
Date: Mon, 22 Mar 2021 16:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e4fff4fe-acf7-a9ab-8189-b191458797de@crashcourse.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 3/22/21 11:52 AM, Robert P. J. Day wrote:
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 7ea68ade..c87a9d9d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1569,7 +1569,7 @@ might have an interest in viewing:
>     events when each of the workers parse the base configuration or if
>     the server changes configuration and reparses. Any given datastore
>     only has one such event executed against it, however. If
> -   ```BB_INVALIDCONF`` <#>`__ is set in the datastore by the event
> +   :term:`BB_INVALIDCONF` is set in the datastore by the event
>     handler, the configuration is reparsed and a new event triggered,
>     allowing the metadata to update configuration.


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Thanks!

Michael

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

