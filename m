Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.29340.1590731176860030714
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 22:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LIVia1GG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id l11so2052170wru.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 22:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=3yreKB6sPyY1suNYfJNcykBE6IjcZbM+CesDK5bWAeQ=;
        b=LIVia1GGoKLMxIzmiwjrXce8xBVZgRRkPioLvGhjoU5cb+APzPOi5D8iR2fwhnjfRH
         aN6iEp+VICJUulI1eUSv2xE5JA1kcNtHqSAPbOtjRHvPIZ424dp+FhgBAJ1JW3YRvMy5
         ezaHGH3jSj56+mG8qw6YWNDKmtdeFbiVZLpO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3yreKB6sPyY1suNYfJNcykBE6IjcZbM+CesDK5bWAeQ=;
        b=mX73EwgahQlV7sAx29lPOakueRlHY2wCCynRzJGyRpymcf6b0YD2h8jPuetaR0fdqO
         hX1ArcxzViP56y616vBOIa9wCXlUP/YZOdsalL1ZZ5NSMpBDmMTpkdpvVsLrgANaD1VX
         zNRfDFTH4YHmweY54JUhEfq0kwE7BdQeCfggIb7a/NnI8pznPKohmtpmfS4hG7IybTWp
         dJ5wSiEiKyxq1W6SIzGiJfWwWPzP+wNbRnvgC/tFAebIafFWCo+ieUA1sjM/Zoc3YAMO
         vgn5effcvvY+LeqtLMXmdJkqmMqpm2qM+W0JSMqKVI+dzdxC2Ml+yQ6RGxu4JgHy3Y9L
         uaOA==
X-Gm-Message-State: AOAM53371DlgTZNRN3hdOsI1JTnB5gwU6q4kn5kowxE9v4xRa7ZhWsT9
	9jSnGLhXbohSDqsqIsvUrFRGYg==
X-Google-Smtp-Source: ABdhPJx3r+wbh7K1dSFUE2yGDNrEibCGw7/D7KUARFiXExhBB53Pifmgin2NLCt2/Od3zsLPZgF5OA==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr3134598wrn.16.1590731175421;
        Thu, 28 May 2020 22:46:15 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id g1sm8689120wrb.46.2020.05.28.22.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:46:14 -0700 (PDT)
Message-ID: <d373c7f3e2c72c995dbe4af7589f76f3dee9535d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] git.py: skip smudging if lfs=0 is set
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Mauro =?ISO-8859-1?Q?Queir=F3s?= <maurofrqueiros@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 29 May 2020 06:46:13 +0100
In-Reply-To: <20200528141853.213890-1-maurofrqueiros@gmail.com>
References: <20200528141853.213890-1-maurofrqueiros@gmail.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2020-05-28 at 15:18 +0100, Mauro Queirós wrote:
> Git-LFS objects were being fetched even when lfs=0 was not set.
> This patch disables LFS smudging when lfs=0. That way, only the LFS
> pointers
> are downloaded during checkout.
> 
> Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 5b3793a7..4c7d388e 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -475,6 +475,9 @@ class Git(FetchMethod):
>  
>          need_lfs = ud.parm.get("lfs", "1") == "1"
>  
> +        if not need_lfs:
> +            ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
> +
>          source_found = False
>          source_error = []

Thanks for the patches, the sound good. Unfortunately they cause
bitbake-selftest to fail:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/991/steps/8/logs/step1d

Cheers,

Richard

