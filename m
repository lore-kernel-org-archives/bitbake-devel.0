Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB8CC433F5
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 23:07:58 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.247.1635894477509011860
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 16:07:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AIvydGoj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id o14so764063wra.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=wizCR1pgTpbXMFGJE3DJeA8lxmSNQsShgZHSm+unEfw=;
        b=AIvydGoj1TCQTp74vs8qoJ5D9UUi0wQCtxrwpsLZkJhwlte4JCLOVWg6/llSxBVWcQ
         g9c6MMXsKzBiKv+IUZEAVBFAW0eSOOkGOF+9e4YTQexLiBvbuBuRi1wmHOojCGWyf9jn
         s2We0D9qnXc+kO+iGJnxLS2l0xy2WrJGwfFEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wizCR1pgTpbXMFGJE3DJeA8lxmSNQsShgZHSm+unEfw=;
        b=Z4AQGiZGtpm2qpTN7t//pko5RluwYoM7JaZsmqY77sX0PIVHr6h2O4QsbWeukujKho
         uU/EcrDcFUa5c7Tt9oPzpjDmLe4a/vAA8yy86sfdl9R5Ndio6wrliyO/oSeZwrfli3Xc
         /MnnEbfyKqqflVdT7FT6UsmPEkRPkoV8bZKfMxP36osdebnF4SL1XJ6oApWJcLHGiIEw
         JsZ7xDhSaBk+kcXhK2E3VDV304FHzm4ApQfS/muW83UC2982F0AybcUFUcoD5gytvdKL
         lfDScxmeEoHwvmygF0BoSHYfFJTPaDtDE+itWDRN5xeEf7S76dyFhAYW8qRXweAhU7jV
         ET8g==
X-Gm-Message-State: AOAM532/r/k/sZyFbfQymI/mFJ1/MIzBooAPaYttRXaNEYUFQRnloQEo
	RnhPzMBFt+IwgHPB/IPrlS57PqVm3pIDgg==
X-Google-Smtp-Source: 
 ABdhPJyDdIQQhDzeeNmrwE3PsNBFlrwTQiRHAuIz/CPrXfBsQJ/MboItRt1JELbGTvUbkpPbaob2tQ==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr17835533wrm.83.1635894476129;
        Tue, 02 Nov 2021 16:07:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:52dc:b819:4029:149f?
 ([2001:8b0:aba:5f3c:52dc:b819:4029:149f])
        by smtp.gmail.com with ESMTPSA id
 l11sm322989wrp.61.2021.11.02.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:07:55 -0700 (PDT)
Message-ID: 
 <a581707862c86bf7d3035a10e5a69b04f3f06033.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] fetch/git: Show warning for invalid
 github urls
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: akuster808 <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 02 Nov 2021 23:07:54 +0000
In-Reply-To: <b43ae3ea-2d22-b53a-efcf-fa83f7e6e9be@gmail.com>
References: <20211102170559.3553007-1-richard.purdie@linuxfoundation.org>
	 <b43ae3ea-2d22-b53a-efcf-fa83f7e6e9be@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 23:07:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12871

On Tue, 2021-11-02 at 16:07 -0700, akuster808 wrote:
> I feel like this may need to become an FAQ as it will affect older
> releases no longer supported.
> 
> did I just volunteer?

Yes, thanks! :)

Cheers,

Richard


