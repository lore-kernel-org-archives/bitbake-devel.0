Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE785C433EF
	for <webhook@archiver.kernel.org>; Fri, 18 Feb 2022 10:59:24 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web09.9502.1645181962599802073
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Feb 2022 02:59:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RcH2WTf8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id
 d14-20020a05600c34ce00b0037bf4d14dc7so6087203wmq.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Feb 2022 02:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ls0i7K0Rbk2Dbge6TODSkjVhGtHOHbYTQ062NwD3ziI=;
        b=RcH2WTf8G1ENOi2rOx/GM3nJbC6UliiljwmnuhlSbnwI9ide4RTuNS9x9Kf0UOiOPd
         7s2IAQZ4k13ie9fuOF58jf4lMN1Bkw1MVSNBukwsuUJAn2kZG0Om+fpmfmvY97C6A0Tv
         dMjTSJewBa6EvcTqnnh3cZdtcZcYLg124y1FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ls0i7K0Rbk2Dbge6TODSkjVhGtHOHbYTQ062NwD3ziI=;
        b=DvAgDLvi6TyblKaeHZDpun2AzchRaaPdsMgTUZ21ueTrQ9rUw9xPaeLbuh3nrBHZV4
         1qrXRU8UOwh15HV1NxwEXn6tWMVhIw9Nl5fdEFDjlwKIcmENsI1cabjfZrFn8HJqhOgX
         6uqlnB14TrMQcMa9UrxJfomRMn+/R+YkSTy7x5/Pr/DDwVDpDlVQ1P+s1wvvuoGK3+T1
         UnEPre0Fud8AiwDcncDf1/W1QTsV+UvCkmuK+Y4HU7HxX+QzvN8S0udIuBf4/HkDP1oy
         l7gwBakIvEPeAwA8SUZf9G0v4SRikNy/uI4e/rhj5cPI9JIP1zcgNCTbv1yL4Bt4PfqQ
         7B+w==
X-Gm-Message-State: AOAM532RRl8ePXKjUUDaG8vm1qB/sbhmFavDdz4Ot+3DSZM1XDMmkIc+
	RgdMMEFcJQElxo6l7zGf7TY7Gg==
X-Google-Smtp-Source: 
 ABdhPJxbf/BhWNNVAep8Mn4XlfhkKnYVlaPs+XlQt6jLoxL6I+yNSMOnG18ADqUy/+5ltoMsMWRrcw==
X-Received: by 2002:a05:600c:4b87:b0:37b:f6ac:cf11 with SMTP id
 e7-20020a05600c4b8700b0037bf6accf11mr6587478wmp.183.1645181960922;
        Fri, 18 Feb 2022 02:59:20 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7bc9:59b:7021:269f?
 ([2001:8b0:aba:5f3c:7bc9:59b:7021:269f])
        by smtp.gmail.com with ESMTPSA id
 b2sm19624307wri.35.2022.02.18.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:59:20 -0800 (PST)
Message-ID: 
 <e067eac4230def7edd9541d847461a9d84746dd0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/cooker: Fix source revision
 handling with floating upstreams
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 Feb 2022 10:59:19 +0000
In-Reply-To: 
 <CANNYZj8mR7Ov9w+=b3mv1QVLc_0G9Nusj1D3ZmzYq3yn3pA5MA@mail.gmail.com>
References: <20220210175426.2695614-1-richard.purdie@linuxfoundation.org>
	 <bbab3b39fefc448199235b2c458ba378@axis.com>
	 <8229aa5ea01b346aa9c2519c7c46883e4c06b48b.camel@linuxfoundation.org>
	 <CANNYZj8mR7Ov9w+=b3mv1QVLc_0G9Nusj1D3ZmzYq3yn3pA5MA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Feb 2022 10:59:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13366

On Fri, 2022-02-18 at 08:44 +0100, Alexander Kanavin wrote:
> This change broke upstream version checks. Also, 'KeyError:
> 'git:git.yoctoproject.org.dbus-waitmaster' looks odd - where's the
> separator?

The separator is a ".", it is only the key name that is useful here, it doesn't
need to be re-split.

The fix seems to be:

https://git.yoctoproject.org/poky-contrib/commit/?h=rpurdie/t222&id=90750e3dfe137370651bca14d9927a9c74e492b4

Can you let me know if that resolves things? It did in my quick local test.

Cheers,

Richard




