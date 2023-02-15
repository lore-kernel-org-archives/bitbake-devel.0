Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB0C636CC
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 21:36:23 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.5871.1676496974202329535
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 13:36:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BIeaSbta;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso2695157wmp.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 13:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xxtqAnTDFY400oi6MmHvjwHwI2oxz231UCo09D6YCZg=;
        b=BIeaSbta8iiBELw4xxQMj2Fxc54EHAVPpUGA7RoLt1FllOo0iOVRVm97Rs07o11wUf
         B6mYdGy1xC1J7xE2k0WNSE0SVf/vTvZIn2BZlURRccZWIgQsjbxTgtt5UGlW9tcDLcbJ
         8lcrYfvMiDAmPkpXSii1tHGc9I4SK9dD8vx7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxtqAnTDFY400oi6MmHvjwHwI2oxz231UCo09D6YCZg=;
        b=ck/yZPUE4lknDy7LA4/E/Dfm/2TMSssb1IV6sMBbNTnq0KXNRuwAEvSWD5S/mRbD/1
         oNNeY3gbPf2GQS/R55Z29GA+nHdnvMJdA+wUyC626HZaD0NOZuylpA4Un1Qdc5maaR8I
         WZ6GVnwm/BKq8hn+2dYS7Vxn1KeDoDxBTHEDP9IMK77nXZXExG29F0F/1na3/arN4G1Q
         a48gWbeJS9p5HzlwTNHLVcjX7ydyccvTNvYUgnnbTBiG8o89ZWUQw8R8dplUxqFgG4ZI
         EaFYA+L6GSa41fM1XUqwCITjbqiZJ1I/w+09KReZrqsS9x8TTxhCyNbhdXWXLIhss8aG
         0xew==
X-Gm-Message-State: AO0yUKUgfgyVBorkCOIfKkKuC2xfdQt/zaBPmAU0m2MGe48K5JQ66Kda
	yKSPbi34KYcczbLphPRlhrbQbg==
X-Google-Smtp-Source: AK7set9V6fZQzeIzDsQHUOB6PFnweRh/iYyYqCCZvFgLA+1IEZ6wYg55SIexN3qxAhBppSjIIAZDYg==
X-Received: by 2002:a05:600c:4e8a:b0:3dc:4316:52be with SMTP id f10-20020a05600c4e8a00b003dc431652bemr13098wmq.10.1676496972469;
        Wed, 15 Feb 2023 13:36:12 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:d39a:5560:699e:2da6? ([2001:8b0:aba:5f3c:d39a:5560:699e:2da6])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003e00c9888besm3616418wmo.30.2023.02.15.13.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:36:12 -0800 (PST)
Message-ID: <ef357dfbb40e8ddff2685d88b209c2c3cf450b50.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH RFC] data: Evaluate the value of
 export/unexport/network flags
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 15 Feb 2023 21:36:11 +0000
In-Reply-To: <CA+chaQcs0KVqKYA_FJnaTfmFk25F+XrxGRzofCo5eH9L-BGwfA@mail.gmail.com>
References: <20221127214934.541723-1-richard.purdie@linuxfoundation.org>
	 <CA+chaQcs0KVqKYA_FJnaTfmFk25F+XrxGRzofCo5eH9L-BGwfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 21:36:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14438

On Wed, 2023-02-15 at 11:46 +0100, Martin Jansa wrote:
> On Sun, Nov 27, 2022 at 10:49 PM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > Currently the export/unexport/network flags are acted on only by
> > presence
> > or lack of in the data store. This is deliberate due to performance
> > reasons
> > since a given recipe shell task might export ~80-90 variables and
> > this means
> > expanding flags for every one of them.
> >=20
> > This does catch users unaware since values which expand to nothing
> > don't work
> > e.g. ${@""} and setting values to "0" wouldn't work either.
> >=20
> > The downside to this patch is slow down in parsing speed of around
> > 4%.
> >=20
> > The network flag is easier to change and doesn't affect
> > performance, it was
> > made to operate the same as export/unexport for consitency reasons.
>=20
> You already know my opinion, but for others on ML I'm in favor of
> this change.
>=20
> Parsing time is negligible compared to do_compile times in most of my
> builds.

Comparing parsing time to do_compile isn't appropriate, they're very
different things. If doing more interactive development, parsing time
can hurt a lot and is one of the bigger complaints I hear about
bitbake, particualrly with larger numbers of layers.

> Expanding this will allow to resolve e.g. icecc.bbclass to respect
> ICECC_DISABLED before enabling network in all tasks:
> https://lists.openembedded.org/g/openembedded-core/message/167731
> I already have such change for icecc.bbclass and will send it when/if
> this bitbake change is merged.

I personally remain torn.

The TSC discussed it and is overall in favour of it so I'll fix this
patch, test and merge.

I'm running out of ideas to speed bitbake up but I'll probably just
have to stop caring.

Cheers,

Richard



