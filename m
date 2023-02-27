Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A650DC7EE23
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 15:50:23 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.93631.1677513021876335450
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 07:50:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=IqXCj1VS;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 2E624FF80C;
	Mon, 27 Feb 2023 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677513019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAAPOXFZicCwgHPtS4SJruqberQ1trcSuYglNkjM8s=;
	b=IqXCj1VSpCPiCv7NqPx+UOeJMcZGe6JHNosibEnRD4U653vUdY3ekFoX+apuMD0iFzQwJs
	QEdYXymfnjViChPF5oo3xsF4tzBJ86tPhQ99PwE9coX3Nm+mITyTNGfDyUiFpUq7RKVMtt
	LDW9DZQqSZr5fhUBcET5+Vn3W5Qbg3nWtdylNX5ovCr4ND1JdPkDPUquXDFiA/mGh566r4
	E9JJMv/zb23l69U0vbu7Yqei4i4qFc2RC/ap061Kr3yvN6DOzDA+1NBrzZ40QxNjuygHCp
	3gEm9gVe6h3pl0US7xwwoeWSsq4LMMsXfLwfMN+MIOjezAVFkSgfy7gSTq9Pig==
Message-ID: <7a7f4e78-c17d-edb9-0551-e826b612575d@bootlin.com>
Date: Mon, 27 Feb 2023 16:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: Ever ATILANO <ever.atilano@smile.fr>, Yoann CONGAL
 <yoann.congal@smile.fr>, YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] doc: ref-variables: add
 LAYERSERIES_COMPAT to term glossary
Content-Language: en-US
To: Fawzi KHABER <fawzi.khaber@smile.fr>, bitbake-devel@lists.openembedded.org
References: <20230227135115.29202-1-fawzi.khaber@smile.fr>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230227135115.29202-1-fawzi.khaber@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 15:50:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14501

Hi Fawzi

Thanks for the patch!

Not a big deal, but next time you send patches for the BitBake manual, 
don't forget to copy the docs@lists.yoctoproject.org mailing list too. 
This will help getting reviews.

See my comments below...

On 27.02.23 at 14:51, Fawzi KHABER wrote:
> Bitbake throws a warning if the layer compatibility is not defined since
> cca81e33b58c390dcf5cc3a31555a43b79177166. This variable did not figure in
> the documentation.
>
> Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
> Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
> Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
> ---
>   .../bitbake-user-manual-ref-variables.rst     | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 09d09a8d..a48e7000 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1096,6 +1096,29 @@ overview of their function and contents.
>         variable is not available outside of ``layer.conf`` and references
>         are expanded immediately when parsing of the file completes.
>   
> +   :term:`LAYERSERIES_COMPAT`
> +      Lists the versions of the OpenEmbedded-Core (OE-Core) for which
> +      a layer is compatible. Using the :term:`LAYERSERIES_COMPAT` variable
> +      allows the layer maintainer to indicate which combinations of the
> +      layer and OE-Core can be expected to work. The variable gives the
> +      system a way to detect when a layer has not been tested with new
> +      releases of OE-Core (e.g. the layer is not maintained).
> +
> +      To specify the OE-Core versions for which a layer is compatible, use
> +      this variable in your layer's ``conf/layer.conf`` configuration file.
> +      For the list, use the Yocto Project release name (e.g. "kirkstone",
> +      "mickledore"). To specify multiple OE-Core versions for the layer, use
> +      a space-separated list::
> +
> +         LAYERSERIES_COMPAT_layer_root_name = "kirkstone mickledore"
> +
> +      .. note::
> +
> +         Setting :term:`LAYERSERIES_COMPAT` is required by the Yocto Project
> +         Compatible version 2 standard.
> +         The OpenEmbedded build system produces a warning if the variable
> +         is not set for any given layer.
> +
>      :term:`LAYERVERSION`
>         Optionally specifies the version of a layer as a single number. You
>         can use this variable within


This corresponds to one of BitBake variables which were documented in 
the Yocto Project manual, but not in the BitBake manual.

This is a good idea to migrate their description to the BitBake manual, 
and once the change is accepted, I'll be happy to update the entry in 
the YP manual to be just a reference to the variable entry in the 
BitBake manual.

However, I'd suggest to modify the commit description, to provide an 
accurate description of where the text comes from:

"Bitbake throws a warning if the layer compatibility is not defined since
cca81e33b58c390dcf5cc3a31555a43b79177166. However, this variable was not
described in the BitBake manual. Taking the description of this variable
in the Yocto Project manual."

Thanks again
Cheers
Michael

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


