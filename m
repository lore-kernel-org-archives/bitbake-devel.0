Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
 by mx.groups.io with SMTP id smtpd.web09.883.1623433588623680862
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Jun 2021 10:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: streamunlimited.com, ip: 213.33.87.17, mailfrom: quentin.schulz@streamunlimited.com)
Received: from qschulz (vpn.streamunlimited.com [91.114.0.140])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4G1pDd091Pz5tl9;
	Fri, 11 Jun 2021 19:46:24 +0200 (CEST)
Date: Fri, 11 Jun 2021 19:46:23 +0200
From: "Quentin Schulz" <quentin.schulz@streamunlimited.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] docs: Add BB_HASHSERVE definition to glossary
Message-ID: <20210611174623.mieo5f3zln7xk4jb@qschulz>
References: <20210604162647.661888-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20210604162647.661888-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

On Fri, Jun 04, 2021 at 06:26:47PM +0200, Michael Opdenacker wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  .../bitbake-user-manual-ref-variables.rst              | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index e1b640e2..bfb74c11 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -313,6 +313,16 @@ overview of their function and contents.
>        However, the more accurate the data returned, the more efficient the
>        build will be.
>  
> +   :term:`BB_HASHSERVE`
> +      Specifies the Hash Equivalence server to use.
> +

I've never used the Hash Equivalence server before (we're using a release
that does not support it) so I might have missed the documentation for
it... but.. is there actual documentation of what the hash equivalence
server is and what is used for?

I could see a reference to such an explicit definition in some other
page, e.g. https://docs.yoctoproject.org/overview-manual/concepts.html.
(don;t know where it would make sense in bitbake docs since sstate-cache
isn't even explained there yet?).

Also, we'll need to extend
https://docs.yoctoproject.org/overview-manual/yp-intro.html?highlight=sstate#features
"Supports partial builds" with reference to hashserv too.
Probably some other places where sstate-cache is mentioned.

I've nothing to say on the patch itself though :)

Cheers,
Quentin
