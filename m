Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web08.31965.1627315356548387517
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 09:02:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 59A7DFF808;
	Mon, 26 Jul 2021 16:02:33 +0000 (UTC)
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss@0leil.net>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH 1/2] doc: bitbake-user-manual: ref-variables: order alphabetically the glossary sources
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20210726153523.2503355-1-quentin.schulz@theobroma-systems.com>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <b3975308-cf7b-b7da-184a-a8b37af6f006@bootlin.com>
Date: Mon, 26 Jul 2021 18:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726153523.2503355-1-quentin.schulz@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Quentin,

Thanks for the patch. Oops, you forgot to CC the "bitbake-devel" mailing
list (done now). That's where Richard is supposed to take the BitBake
documentation patches from.

On 7/26/21 5:35 PM, Quentin Schulz wrote:
> This reorders a few entry so that they are alphabetically sorted.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Signed-off-by: Quentin Schulz <foss@0leil.net>
> ---
>  .../bitbake-user-manual-ref-variables.rst     | 54 +++++++++----------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 57a759f1..7b5bbc28 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -231,23 +231,23 @@ overview of their function and contents.
>        based on the interval occur each time a respective interval is
>        reached beyond the initial warning (i.e. 1 Gbytes and 100 Kbytes).
>  
> -   :term:`BB_ENV_WHITELIST`
> -      Specifies the internal whitelist of variables to allow through from
> -      the external environment into BitBake's datastore. If the value of
> -      this variable is not specified (which is the default), the following
> -      list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`,
> -      :term:`BB_ENV_WHITELIST`, and :term:`BB_ENV_EXTRAWHITE`.
> +   :term:`BB_ENV_EXTRAWHITE`
> +      Specifies an additional set of variables to allow through (whitelist)
> +      from the external environment into BitBake's datastore. This list of
> +      variables are on top of the internal list set in
> +      :term:`BB_ENV_WHITELIST`.
>  
>        .. note::
>  
>           You must set this variable in the external environment in order
>           for it to work.
>  
> -   :term:`BB_ENV_EXTRAWHITE`
> -      Specifies an additional set of variables to allow through (whitelist)
> -      from the external environment into BitBake's datastore. This list of
> -      variables are on top of the internal list set in
> -      :term:`BB_ENV_WHITELIST`.
> +   :term:`BB_ENV_WHITELIST`
> +      Specifies the internal whitelist of variables to allow through from
> +      the external environment into BitBake's datastore. If the value of
> +      this variable is not specified (which is the default), the following
> +      list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`,
> +      :term:`BB_ENV_WHITELIST`, and :term:`BB_ENV_EXTRAWHITE`.
>  
>        .. note::
>  
> @@ -276,18 +276,6 @@ overview of their function and contents.
>  
>           BB_GENERATE_MIRROR_TARBALLS = "1"
>  
> -   :term:`BB_HASHCONFIG_WHITELIST`
> -      Lists variables that are excluded from base configuration checksum,
> -      which is used to determine if the cache can be reused.
> -
> -      One of the ways BitBake determines whether to re-parse the main
> -      metadata is through checksums of the variables in the datastore of
> -      the base configuration data. There are variables that you typically
> -      want to exclude when checking whether or not to re-parse and thus
> -      rebuild the cache. As an example, you would usually exclude ``TIME``
> -      and ``DATE`` because these variables are always changing. If you did
> -      not exclude them, BitBake would never reuse the cache.
> -
>     :term:`BB_HASHBASE_WHITELIST`
>        Lists variables that are excluded from checksum and dependency data.
>        Variables that are excluded can therefore change without affecting
> @@ -309,6 +297,18 @@ overview of their function and contents.
>        However, the more accurate the data returned, the more efficient the
>        build will be.
>  
> +   :term:`BB_HASHCONFIG_WHITELIST`
> +      Lists variables that are excluded from base configuration checksum,
> +      which is used to determine if the cache can be reused.
> +
> +      One of the ways BitBake determines whether to re-parse the main
> +      metadata is through checksums of the variables in the datastore of
> +      the base configuration data. There are variables that you typically
> +      want to exclude when checking whether or not to re-parse and thus
> +      rebuild the cache. As an example, you would usually exclude ``TIME``
> +      and ``DATE`` because these variables are always changing. If you did
> +      not exclude them, BitBake would never reuse the cache.
> +
>     :term:`BB_HASHSERVE`
>        Specifies the Hash Equivalence server to use.
>  
> @@ -357,15 +357,15 @@ overview of their function and contents.
>        running builds when not connected to the Internet, and when operating
>        in certain kinds of firewall environments.
>  
> +   :term:`BB_NUMBER_PARSE_THREADS`
> +      Sets the number of threads BitBake uses when parsing. By default, the
> +      number of threads is equal to the number of cores on the system.
> +
>     :term:`BB_NUMBER_THREADS`
>        The maximum number of tasks BitBake should run in parallel at any one
>        time. If your host development system supports multiple cores, a good
>        rule of thumb is to set this variable to twice the number of cores.
>  
> -   :term:`BB_NUMBER_PARSE_THREADS`
> -      Sets the number of threads BitBake uses when parsing. By default, the
> -      number of threads is equal to the number of cores on the system.
> -
>     :term:`BB_ORIGENV`
>        Contains a copy of the original external environment in which BitBake
>        was run. The copy is taken before any whitelisted variable values are


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Richard, can you merge this patch as it was sent to the [docs] mailing list?

Thanks in advance
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

