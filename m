Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF4C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Apr 2022 21:51:28 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.964.1651009886940493872
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Apr 2022 14:51:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Q/QT+Eue;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id e24so7394542wrc.9
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Apr 2022 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lsdeRGSUh9ewmrQ53qskG7x4Vo40iEp1ztNiaioOlY4=;
        b=Q/QT+EuetldajILRD7r19svvAD7GUq2Wt0zUk+g2kd4exgVqpp2UZI6qEDN5YHAFh3
         4FjDgNcxnQjyVFWfUdB6FZnRcjw2zHISKRAQIap8HyH0BbG7WVdO79QqpMQFlPc8hubM
         OFROnzRgrAV/PDMRuWgwpt8xTaUkaXb0LPdIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lsdeRGSUh9ewmrQ53qskG7x4Vo40iEp1ztNiaioOlY4=;
        b=e2ca5UHAuM0xMtDRle9d26Q5IPloO/AdomaNxpJNuNkQwo6NhmLrf0Pf+h/iACH9EV
         wmXef6GktEq4yHeVvAKu3k1qVkXNICjjjiGGMFpcZLRSzEwQumxyyI32j6uEaBG0ruym
         fLIvm7sdBIbDBf+uyYutrktfJmdUs3YISY+O66PfxCL1WQshF4EQtuPKdrpo7Uot1hjJ
         YMwslbFQeUVlsTRW2Ybbp3hPuUhCLBHbipgePmIlYr9SCpE21XuUd146z/RGgFPLcxVB
         WxTPndjLkm+sGSd3cyH57RNgIzEp7+o8kbEneHYCVLX4IyjEvcHGxGpByBuBSRLif7Lm
         gK3A==
X-Gm-Message-State: AOAM531ZjUW3bW2f4JY0oHcz4yuGak1rG4L0qHcvgeuga1tOK5GRPDAR
	/dEEfYwnzY1LR7r7dyMf4kLabg==
X-Google-Smtp-Source: 
 ABdhPJx1Ns4Umd6U79bv4oabpAFHKUit4RhTxXLoL7W+fSzTPb7dAMf4XMaDjMPSkrWo2QmFBceFeQ==
X-Received: by 2002:adf:e110:0:b0:205:b611:7a6b with SMTP id
 t16-20020adfe110000000b00205b6117a6bmr19675858wrz.20.1651009885336;
        Tue, 26 Apr 2022 14:51:25 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:aee4:ace8:5bdc:9ee3?
 ([2001:8b0:aba:5f3c:aee4:ace8:5bdc:9ee3])
        by smtp.gmail.com with ESMTPSA id
 c9-20020adfa309000000b0020ad4eae9b6sm9143681wrb.100.2022.04.26.14.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:51:24 -0700 (PDT)
Message-ID: 
 <99a5bd79f212a830d28427c72dcf83f924c13cb9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: document
 TEMPLATECONF environment variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Tue, 26 Apr 2022 22:51:23 +0100
In-Reply-To: <20220426214901.201802-1-michael.opdenacker@bootlin.com>
References: <20220426214901.201802-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Apr 2022 21:51:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13659

On Tue, 2022-04-26 at 23:49 +0200, Michael Opdenacker via lists.openembedded.org
wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  .../bitbake-user-manual-ref-variables.rst        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index af4ff980..80005580 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1483,6 +1483,22 @@ overview of their function and contents.
>        consist mostly of task logs and scripts, when building a particular
>        recipe.
>  
> +   :term:`TEMPLATECONF`
> +      Specifies the directory used by the build system to find templates
> +      from which to build the ``bblayers.conf`` and ``local.conf`` files.
> +      Use this variable if you wish to customize such files, and the default
> +      BitBake targets shown when sourcing the ``oe-init-build-env`` script.
> +
> +      For details, see the
> +      :yocto_docs:`Creating a Custom Template Configuration Directory
> +      </dev-manual/common-tasks.html#creating-a-custom-template-configuration-directory>`
> +      section in the Yocto Project Development Tasks manual.
> +
> +      .. note::
> +
> +         You must set this variable in the external environment in order
> +         for it to work.
> +

I don't think this is a bitbake variable, it is an OE one?

Cheers,

Richard


