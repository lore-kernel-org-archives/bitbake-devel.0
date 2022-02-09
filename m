Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F2DC433F5
	for <webhook@archiver.kernel.org>; Wed,  9 Feb 2022 21:47:22 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web12.1766.1644443241369279579
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Feb 2022 13:47:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Bk/2qkN2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id o24so3617888wro.3
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Feb 2022 13:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qjYm1JwMKFkrYVeHhGtiU73A9xBftKfUfe7bQL+UmJQ=;
        b=Bk/2qkN2HnR7rSZgFJk44L92xr+CRRQ0KETPRxa0b3JVRG4nGGbay5JxCtT8KzFFN5
         WTHgGKEbmx7zWT9+1frr2yScDS/LBPJBuD0tW2SLfv72vr3YrQtcP3N0OPaf6am5Psev
         OdUv1iHm06oDgF90467aaXin5QRtfT2voW3mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qjYm1JwMKFkrYVeHhGtiU73A9xBftKfUfe7bQL+UmJQ=;
        b=hHY+HgGqVp5m1aTVDooGvPXVWaC+ppXqrAFoNHlIe5+kpAiQuRhcUMmJd11xxpELlO
         gbbbv4VsoKWczM6J9jqTv0a1QfW2uEE3vQ56556y/pEwCEg0MNP6NBKNBBcS5feqvEj2
         Ff9ZT7bdsZz7zs3Ckko0UwdfSHHswpKf0E7qPaHSVYvqj7NYp7gyVTF+AfyThDjSu1z/
         j+iS1JLhdxAHZEJPdJkU32s0R7T2GejJl5haBTcRblcnbtTc0Hcv4KRjDXCNsGtrshSD
         kvAVE5aF1bpiXchjJ9muRhs1G3qOiMld92ewuU9WZXG7nM5kF1BQoK3wIWDwiffoNxsq
         hz/Q==
X-Gm-Message-State: AOAM5301mi6koMjQT60IIf4pCP2966B0mSxXCVAQAvdxb7joCuCSIaHg
	JNHGzTWKPvx8QioFkK/5wbg9hQ==
X-Google-Smtp-Source: 
 ABdhPJzFNz0z/EY0ZOCLdcf0Xfeg0dB+IV9zeXzLNPsOzOLXJnAOJp5Y98/Sv1bqbIiQS1qdxyhJnA==
X-Received: by 2002:adf:aa84:: with SMTP id h4mr2030017wrc.122.1644443239625;
        Wed, 09 Feb 2022 13:47:19 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:2250:1cae:83bc:d91f?
 ([2001:8b0:aba:5f3c:2250:1cae:83bc:d91f])
        by smtp.gmail.com with ESMTPSA id
 ay3sm5869363wmb.44.2022.02.09.13.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:47:19 -0800 (PST)
Message-ID: 
 <0f1f2eace443402fca3790908033286be4a9b0e0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] wget.py: use a longer timeout in
 checkstatus()
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Wed, 09 Feb 2022 21:47:17 +0000
In-Reply-To: <20220209214018.363691-1-alex@linutronix.de>
References: <20220209214018.363691-1-alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Feb 2022 21:47:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13324

On Wed, 2022-02-09 at 22:40 +0100, Alexander Kanavin wrote:
> The addition of 30 second timeout is recent [1], and has
> proved not long enough with the AB server when mass-checking
> for sstate item availability, resulting in timeout errors with
> extensible SDKs[2].
> 
> [1]
> https://git.yoctoproject.org/poky/commit/?id=2c46245f449d2716566ef668da0bf48f2109643a
> [2]
> https://autobuilder.yoctoproject.org/typhoon/#/builders/53/builds/4710/steps/16/logs/stdio
> 
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bitbake/lib/bb/fetch2/wget.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
> index 253cabce75..2a7592ae5f 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -366,7 +366,7 @@ class Wget(FetchMethod):
>                  except (TypeError, ImportError, IOError, netrc.NetrcParseError):
>                      pass
>  
> -                with opener.open(r, timeout=30) as response:
> +                with opener.open(r, timeout=300) as response:
>                      pass
>              except urllib.error.URLError as e:
>                  if try_again:


We need to fix the servers. I doubt that at 300s it would work much better but
the user experience would be horrible with builds hanging at startup for 5
minutes.

Cheers,

Richard


