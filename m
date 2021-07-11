Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.5314.1625996884131310234
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Jul 2021 02:48:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fFmLTDk8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id i94so19928936wri.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Jul 2021 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=I6LY7CJeTeba7+rDkJxp2pZi5VyYZ7Itr1Z6J5ophN0=;
        b=fFmLTDk8dUF0Cx8IQq2pStb2dmRJ5rS649r08dr7YPrg447OHYDmj1bD5+8TRVTEgt
         zZkBT/LQPGGBRTdul3L1SIjuBB88cxcpzAKRBO9wT2IH7+SHSRK0Lq33lELyvK5e8gwg
         bKkWcVzqUAeASWJ1SMwvEnmlTnMgLGQi/yJG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=I6LY7CJeTeba7+rDkJxp2pZi5VyYZ7Itr1Z6J5ophN0=;
        b=ZmMxa7jaa/xvXd5JDdIN9WJCU27lQsOQkbE8XRY5rzv2i3d2Vf9tQkKSELKyqfGyzF
         yVBd6vo8Mylm+KVf+IRtrll9PATjU4+ee4Die3Az4o84tyB7yfdidLImmp9P8xx0Tzht
         u7DhezU8kI+IXQHUXVIVUdhkAQVdFwOnm7USvtcFN2V1yChGhd/+t+jJf262DgFa9a9q
         0/aNP8culZsNmOn20jRrwm13KfswdQOF5V1i8/tB0Xo+tcOdjO1Uzgp22Q9sorWnDh3Q
         NmtVZ0c9bxiCcdLYoGeQ60931qRKZYFYnqJHwkbBBufeAGICArJVQSqK53oxxBmBYBXa
         bqUg==
X-Gm-Message-State: AOAM5323qwOJCJDw75HHE17BQsoaYcTUyyxBSYUjcu0bs5eZZnCDX5JH
	WuGxOyKngIvToVxkvdrYHAylvw==
X-Google-Smtp-Source: ABdhPJy0cbzxEmoq6AD2+qVviRSywGXpGwQmCaxCU3vRIC4o0Jk7rUVb80grXeighitk/mr+zw7+zw==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr7246843wrx.181.1625996882469;
        Sun, 11 Jul 2021 02:48:02 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5e67:1ea9:260d:3e7f? ([2001:8b0:aba:5f3c:5e67:1ea9:260d:3e7f])
        by smtp.gmail.com with ESMTPSA id h10sm11827065wmb.46.2021.07.11.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 02:48:02 -0700 (PDT)
Message-ID: <3cb191b83c3a9223ad76dff397d6d3c0dd8b755a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/s3: improve checking if object exists in s3 by using botocore
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>, 
	bitbake-devel@lists.openembedded.org
Cc: Adam Romanek <romanek.adam@gmail.com>
Date: Sun, 11 Jul 2021 10:47:58 +0100
In-Reply-To: <20210708123021.568443-1-dwrobel@ertelnet.rybnik.pl>
References: <20210708123021.568443-1-dwrobel@ertelnet.rybnik.pl>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2021-07-08 at 14:30 +0200, Damian Wrobel wrote:
> From: Adam Romanek <romanek.adam@gmail.com>
> 
> Botocore uses urllib3 which in turn uses a connection pool to issue HTTP
> requests. Keeping the S3 client obtained from botocore library allows
> one to reuse that connection pool.
> 
> The S3 client obtained from botocore is now kept in a connection
> cache, which in case of sstate-cache checks is set up in
> openembedded-core/classes/sstate.bbclass.
> 
> On Python 3.5+ a ResourceWarning on unclosed SSL socket is issued when
> dropping the reference to botocore S3 client, which is a known issue but
> apparently a false positive: https://github.com/boto/boto3/issues/454
> 
> Initial results show the time to check ~2700 objects is cut by 85%
> (4 mins -> 35 secs).
> 
> With this change setting SSTATE_MIRRORS directly to S3 could now be the
> preferred method for using sstate-cache from S3 (no need to sync
> sstate-cache from S3 prior running the build), especially when the cache
> grows significantly over time (e.g. from 4GB to 30GB during the day).
> 
> Signed-off-by: Adam Romanek <romanek.adam@gmail.com>
> Signed-off-by: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>

With this change all the builds on the autobuilder and my local builds 
start showing:

WARNING: S3 FetchMethod: consider installing botocore to speed up S3 access

which isn't really appropriate for users not using S3.

I'm also a little worried that the changes in this patch appear to effectively
totally change the fetcher type to effectively different code, I'm torn on that
and whether it is nearly a different fetcher type.

Cheers,

Richard

