Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.3182.1627335335570448106
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 14:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OeZgSLU+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id p5so7605492wro.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=H56rpvEfMRsMLwI705/jfua6dmTlL1QoIVle+jvH6QY=;
        b=OeZgSLU+J8RNeq2zY6UoMDvgYzMK+yC8ERrxouIiRLwtd0vp6NdYvDUMRp1/4BAmm/
         A757lhIBTbobHCHfXLY9U2uHqrbrvHrDkx6mYN6o/wpv1QDoTRZQ3Mscm6nV58f7eXdq
         m6a3w0ck9W6Yj+NEwJnB7hlvuEKqXUehurNhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=H56rpvEfMRsMLwI705/jfua6dmTlL1QoIVle+jvH6QY=;
        b=URgdoorrjYiIlo7n10GXmvqdSlMDFYcF12fgZRJcbnaVQ4H394M9b9RlUCpbIvvJHh
         l8fDUqz0WkYaXx8PuF5/YsO0z68Wc6vJW+UCrFbK4L35/j5Laaw6wMqGQsPAXTV5gUCM
         uoFcaeyH4IrKzdqLESAsPnafcOtnLkOd+B5MIK8owbmt4HALWIryPojBmoGfm/xz9711
         8I4HqSwyh6Zw39Ud4RkMAg/jv7MCi0xABZ9xFQziHje4bX3+7rTkB+847NCLf/D2lfio
         E645PyNMdOQoQbeeqBGD8qyP4HhThAi9ZyWc1nFroIF/mLvqYKFO+l1tzsUjIqMNYK4m
         Fljw==
X-Gm-Message-State: AOAM532viRGJ0G40DLnStbXeMik4PB82xpnsL6aphajM9N28VKOEKC1W
	3C05v6IVeIzJT1j2+FX7S8XocQ==
X-Google-Smtp-Source: ABdhPJxX9QFSfcam31dJcx0xYtXXIZaeJnUjz9t0080tt0SB2wCnfPnmUnXs63G3/KQDUUhXCEaRbQ==
X-Received: by 2002:a05:6000:1248:: with SMTP id j8mr21143524wrx.391.1627335334156;
        Mon, 26 Jul 2021 14:35:34 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4? ([2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4])
        by smtp.gmail.com with ESMTPSA id y3sm948648wrh.16.2021.07.26.14.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 14:35:33 -0700 (PDT)
Message-ID: <25b786aeddbabd5bbe979d1559d30ba4ec8b5d05.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH] doc: Makefile: turn warnings into errors by default
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, Quentin Schulz
	 <quentin.schulz@theobroma-systems.com>
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss@0leil.net>, BitBake
	developer list <bitbake-devel@lists.openembedded.org>
Date: Mon, 26 Jul 2021 22:35:32 +0100
In-Reply-To: <a0ddc662-dddc-dba4-d4e0-bbf94d8c9f9f@bootlin.com>
References: <20210726153446.2503018-1-quentin.schulz@theobroma-systems.com>
	 <a0ddc662-dddc-dba4-d4e0-bbf94d8c9f9f@bootlin.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-07-26 at 18:55 +0200, Michael Opdenacker wrote:
> Hello Quentin,
> 
> Thank you for the new *BitBake* documentation patch. I CC the
> bitbake-devel mailing list.
> 
> On 7/26/21 5:34 PM, Quentin Schulz wrote:
> > -W is for turning warnings into errors, --keep-going to make sure the
> > whole documentation is built and all warnings will be printed before
> > failing.
> > 
> > Since there's currently no warning, it's time to introduce it!
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > Signed-off-by: Quentin Schulz <foss@0leil.net>
> > 
> >  BUILDDIR      = _build
[...]

> 
> Tested-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Richard, can you merge this patch as it was sent to the [docs] mailing list?
> Thanks in advance,

Merged, thanks.

Richard

