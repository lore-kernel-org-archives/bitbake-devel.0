Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5846C678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 16:45:40 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.21309.1677775532565799693
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Mar 2023 08:45:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=SOr6GOOu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 0BCC624000C;
	Thu,  2 Mar 2023 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677775530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOfbC/DSv6aFaygmTX2YqWTQIKG5Ax+KOEQt27tcaa0=;
	b=SOr6GOOuRn1bZ9GIfB58nQ3BWSGcon3gFQgWF7DL/yne5rDJk85MS4fSFtcdOzXDDhX0oF
	GeXC2wHD6T6X76a5evco2DCE1AaFvS6ecMmTc1sSTf46rTFSlVSawU5j86PPhjsJF1xlLG
	rmVEcblMWFCn0lAqCDDZcCvEOTCwYWcoUoruO+ANR8ewdoTQUARs2exGelPkIUBLwZvlGB
	pXwfH27T7Q63f6SufKIM1KRnpJ0n9/MWYnzAUlhv9CipUVV9kLUpCOWRVNhTWu/q90GtnQ
	fpXBt45KKtzM0R6I49LOJLviUPAl4JCacgH5wNxxbo4GtgLYELr2HP6RS94Clg==
Message-ID: <ba3c18a6-09df-c695-080a-b33e1555cc3d@bootlin.com>
Date: Thu, 2 Mar 2023 17:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: docs@lists.yoctoproject.org, Ever ATILANO <ever.atilano@smile.fr>,
 Yoann CONGAL <yoann.congal@smile.fr>, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v4 1/2] doc: ref-variables: add
 LAYERSERIES_COMPAT to term glossary
Content-Language: en-US
To: Fawzi KHABER <fawzi.khaber@smile.fr>
References: <20230302161431.8594-1-fawzi.khaber@smile.fr>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230302161431.8594-1-fawzi.khaber@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Mar 2023 16:45:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14518

Hi Fawzi

On 02.03.23 at 17:14, Fawzi KHABER wrote:
> Bitbake throws a warning if the layer compatibility is not defined since
> cca81e33b58c390dcf5cc3a31555a43b79177166. The description of this variable
> comes from the Yocto Project manual.
>
> Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
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


Looks good to me, thanks!
Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


