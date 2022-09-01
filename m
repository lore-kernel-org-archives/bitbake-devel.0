Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12718ECAAD3
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 11:19:53 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.10806.1662031185946750160
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Sep 2022 04:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aeMveESz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id v16so19167218wrm.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Sep 2022 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=uQnr3osZfKQ9u9nS0gFeMJNsxubfXvfOJF/Wz/+5lLk=;
        b=aeMveESz3wPrJIynZ5Fw9qV2Eh24E40b1BH+T5ooJA6IcZyYvHJyzKvqpzBZsUmEJA
         L6bYdxGom41pncB6RouKZIyjofTiFRcz/G6EP26K0h56TrYB/oG23zQbiMo03fDzdir5
         GxiHGQxeMUiCAmJwNf7z3ZIHWolBrvJeeptcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=uQnr3osZfKQ9u9nS0gFeMJNsxubfXvfOJF/Wz/+5lLk=;
        b=yxj2Z/25hfbg7Zbjz1PK4mrMEsDs+W583zOHj27atGBWr0spDJLlBg+aBmtAtQCdVr
         8AN1oROBdpj0r5DdcGDkHJBtVZgQCXS7H8qreSFnNh3DaPXtoaK4vmo3wCN3k+93qiy+
         natA5cXLpGePZqzOpC1lSUowXviTUoToJ4OVMslewB3P20TWyeDVk8qT+DPSbJuFJrM1
         5N3jxif4InpwFcmfjSwzJJndHVPbVBjtz81e1n6/cuNPI2vOLlfmUGG0PyNRCBEFMNdK
         R6JrQ5NoFlnIPqYlC0bW7sNs+cB9QYQBh2I9piS8uVbi5BANghz93eLoPh9Ot6rPUYdB
         SVeQ==
X-Gm-Message-State: ACgBeo2gMWVjL0JxxivSPFOgHW7IXw+7Kre2xA6QrYQ9zpiXQegdkAaK
	guGUbaNdsVBmbh3T3tT6SdWLvA==
X-Google-Smtp-Source: 
 AA6agR7eJQJ0CqGFhoA7AnfR/ccN0Nqg0hGfz+skJyqlrZ1rUSb8lIzogl8HDWseuXgkRXdc3bbQ5g==
X-Received: by 2002:a5d:6d86:0:b0:226:e362:237d with SMTP id
 l6-20020a5d6d86000000b00226e362237dmr7492131wrs.453.1662031184190;
        Thu, 01 Sep 2022 04:19:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:417:930f:844b:d765?
 ([2001:8b0:aba:5f3c:417:930f:844b:d765])
        by smtp.gmail.com with ESMTPSA id
 b2-20020adff902000000b00226dfac0149sm8353583wrr.114.2022.09.01.04.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 04:19:43 -0700 (PDT)
Message-ID: 
 <7bec4de4e5c8ae8db193bfc6fb3f15e9388c0512.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch: use BPN instead
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>, "Yu, Mingli"
	 <mingli.yu@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 01 Sep 2022 12:19:43 +0100
In-Reply-To: 
 <CABcZAN=rSxhgebWTScxW6tL6+f7k-natKstYWyBVSb11rz1=wA@mail.gmail.com>
References: <170B7854B4242295.1911@lists.openembedded.org>
	 <0abf1f86-d023-a445-0758-436f4767e7ef@windriver.com>
	 <CABcZAN=rSxhgebWTScxW6tL6+f7k-natKstYWyBVSb11rz1=wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Sep 2022 11:19:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13950

On Wed, 2022-08-31 at 13:55 -0700, Christopher Larson wrote:
> BPN is not defined by bitbake, you're hardcoding OE-specifics into
> bitbake with this patch.

This was accidentally applied from the patch queue but I've reverted
it, Chris is correct.

If you still think this isn't right, please show the error you're
seeing with the selftest as we need more information to help further.

Cheers,

Richard

