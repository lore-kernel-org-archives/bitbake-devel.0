Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B700FC46CD2
	for <webhook@archiver.kernel.org>; Sat, 30 Dec 2023 23:50:18 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.195785.1703980212099342825
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Dec 2023 15:50:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gX8udgUY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5aef534eso38658035e9.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 30 Dec 2023 15:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703980210; x=1704585010; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mV5kt/K36oyWxU7d64msVpEo86TSN6Co+UYVUwOE+c=;
        b=gX8udgUYnfj6WSXOkic+SREEv4XKC3sdMmoPyqFeYy5v+JrwDbap3VV2KyWuRkBar3
         RUfB+zr3TegCniNgOruUTWXaG8FTCRb/sqN4p2ap16k0kFB1Y3MjwW6eyxXy2dtdj9Zu
         jXMOYpbLfX5j0BiYRpWhF9g7yQ2TkM5x7GHrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703980210; x=1704585010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5mV5kt/K36oyWxU7d64msVpEo86TSN6Co+UYVUwOE+c=;
        b=mw9gVy0JVnbJlRmZezFJwfhgV2MPxBtB+blXsevuoutHNjMNVeA/kQ58Zsrztp4Pek
         RxoIjuzQpmJ2WzeZwR2l7NBksljpNETWqwIJXTE+92hVFL+71n7C+7TzFZ/C1w/QPPTh
         8SOpCwXBIE5GPZBC7ICB0umwwTKUSK7CiZcKJXknHLrswEStr3mk0qU+vfntRMxJVOD3
         zMJwkQZ4nvO04nNZNt+KDd6ruy8HKkjd1kErb1CsXBy+7Ky/R4XKLaxOvYhqYk2JdhGt
         pUmgKhgGywA1ewooyHZoqn7AEiLs9EgY++eFDWdEivXdSIOqypZDDJcglcy1SHta9Dcs
         55vw==
X-Gm-Message-State: AOJu0Yw5lWR64UiFAHLDb/RgwOgNt9Msvg0B4sx7r1N75Tszo6LRWkAf
	hlpq8390kKcPnmvkJPhHpLJLEDfx1j/nOagjPpzeKXR2YHQ=
X-Google-Smtp-Source: AGHT+IGptx10jwgToKnl4r2rrJ/bRBQ0H+cBzZMy4CoeFpMYzuLZ0enHQGpObum877YWBEwDkS6i4Q==
X-Received: by 2002:a7b:ca56:0:b0:40d:5c8e:345a with SMTP id m22-20020a7bca56000000b0040d5c8e345amr3545804wml.108.1703980210630;
        Sat, 30 Dec 2023 15:50:10 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:cec3:25e9:1e4c:7e1c? ([2001:8b0:aba:5f3c:cec3:25e9:1e4c:7e1c])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b004030e8ff964sm43851460wmr.34.2023.12.30.15.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 15:50:10 -0800 (PST)
Message-ID: <74ea71abd4a3fa563dad559af79bccb360706d96.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] fetch2/crate: Unpack into
 CARGO_VENDORING_DIRECTORY
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex Kiernan <alex.kiernan@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 30 Dec 2023 23:50:09 +0000
In-Reply-To: <20231230154843.8086-1-alex.kiernan@gmail.com>
References: <20231230154843.8086-1-alex.kiernan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Dec 2023 23:50:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15730

On Sat, 2023-12-30 at 15:48 +0000, Alex Kiernan wrote:
> The vendor directory is set in cargo_common, to work with rust 1.75.0 we
> need to change the location, so use CARGO_VENDORING_DIRECTORY here.
> Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
> ---
> Is this change allowed, or am I coupling repos in a bad way and should
> hardcode `registry/src` (which is what I need it to be) here instead?

We really need to find a better way. Bitbake isn't supposed to have
"knowledge" of OE-Core outside the key variables it expects from
bitbake.conf. CARGO* from class files aren't included in that.

What we probably should do is set this in bitbake in the fetcher and
then read the value in OE-Core.

Cheers,

Richard

