Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web08.32464.1627317233694700768
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 09:33:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.232, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8DCAB200004;
	Mon, 26 Jul 2021 16:33:51 +0000 (UTC)
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss@0leil.net>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH 2/2] documentation: ref-manual: force glossary output to be alphabetically sorted
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20210726152947.2501390-1-quentin.schulz@theobroma-systems.com>
 <20210726152947.2501390-2-quentin.schulz@theobroma-systems.com>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <3b3332e9-5043-5132-336b-6928ca0b9528@bootlin.com>
Date: Mon, 26 Jul 2021 18:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726152947.2501390-2-quentin.schulz@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Quentin,

Thanks for this other patch. CCing the bitbake-devel list here too.

On 7/26/21 5:29 PM, Quentin Schulz wrote:
> Even though, care should be taken to have the terms in the glossary
> sources alphabetically ordered, it is possible some terms might be in
> the wrong place.
>
> This makes sure that whatever the order of terms in the glossary
> sources, the generated medium is correctly sorted.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Signed-off-by: Quentin Schulz <foss@0leil.net>
> ---
>  documentation/ref-manual/terms.rst     | 1 +
>  documentation/ref-manual/variables.rst | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/documentation/ref-manual/terms.rst b/documentation/ref-manual/terms.rst
> index 545100efa..4d960393c 100644
> --- a/documentation/ref-manual/terms.rst
> +++ b/documentation/ref-manual/terms.rst
> @@ -9,6 +9,7 @@ development environment might find helpful. While some of these terms are
>  universal, the list includes them just in case:
>  
>  .. glossary::
> +   :sorted:
>  
>     :term:`Append Files`
>        Files that append build information to a recipe file.  Append files are
> diff --git a/documentation/ref-manual/variables.rst b/documentation/ref-manual/variables.rst
> index e5525e922..220e88db1 100644
> --- a/documentation/ref-manual/variables.rst
> +++ b/documentation/ref-manual/variables.rst
> @@ -17,6 +17,7 @@ system and gives an overview of their function and contents.
>  :term:`W <WARN_QA>` :term:`X <XSERVER>`
>  
>  .. glossary::
> +   :sorted:
>  
>     :term:`ABIEXTENSION`
>        Extension to the Application Binary Interface (ABI) field of the GNU

Tested-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Richard, can you merge this patch as it was sent to the [docs] mailing list?

Thanks in advance
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

