Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web08.14618.1625002054162376779
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jun 2021 14:27:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Dpn4lwM4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso3447897wmj.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Jun 2021 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=65W1iEfCsQffxnYoDfQQIqx4dQ8P841SHIMRDJo5nms=;
        b=Dpn4lwM4tleoZE80lyVrBYoo2WZ3Tv5N0G9C5CQ/gP+hPzPYW0QsQF57sknY7g7S1U
         x3EgAzOxWh+LrubscYR41GV7x9D+JDXOI5QFAX+fajvam8QCtqyvw9Xmjxxhk+iFEL1o
         MxvRFbe0QaxdE4ZcEHohfbQZfeGQdRwyabaV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=65W1iEfCsQffxnYoDfQQIqx4dQ8P841SHIMRDJo5nms=;
        b=TN4iEhXfWVf4PDJzBrkxv60qX8ED9tIqw7HW8jl26ZpIvSoAJS8GlC50uDOnpUrieS
         tiK0tXJyFd5gnFNBuPqVK4Q9vy5GvP7oOUNl8hLxaDJvmZ/G9Srm1uiYtZrh8H3o2lBx
         rCEbKrEeCygKDrdPnVtT89EMtpaxfYXOYSlt82Rvs+D0na71teexXQCcVDiTHcgfnuUj
         ciD9ncUt7dG09SijfegqV4PwbUUAH/VaDc3vIEDu0oM/V86Jcfr71VA3Pcp/9wY1FgPp
         jYsOxCAjQY9EUNq7d85Krea+rUDeJ7hAC437QtNjIe1JCXR9r8qy0DBWOrZGoTy3T4sp
         5eiw==
X-Gm-Message-State: AOAM533Q7wiqx2MEVEx7V85r5qXAWtq/+iTDIM4MMcsmbdvy1sy87EWK
	AfZo9whJhj+XgPupsvUki4U8fw==
X-Google-Smtp-Source: ABdhPJzClevvfwmnG65jWwBHPXrlRE2u5C47Rg7MwG/KBt157eNae1CuQHbLvCmuB0/biDJJ0n+u6A==
X-Received: by 2002:a7b:c3ca:: with SMTP id t10mr866637wmj.74.1625002052430;
        Tue, 29 Jun 2021 14:27:32 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:fa9c:ff43:b5c6:d04f? ([2001:8b0:aba:5f3c:fa9c:ff43:b5c6:d04f])
        by smtp.gmail.com with ESMTPSA id f9sm6339677wrm.48.2021.06.29.14.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 14:27:32 -0700 (PDT)
Message-ID: <ccc5b774fa3ff509fdd51036b9cc0fa2a855a992.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/wget: fetch securely by default
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Ross Burton <ross@burtonini.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 29 Jun 2021 22:27:29 +0100
In-Reply-To: <20210628171240.950640-1-ross.burton@arm.com>
References: <20210628171240.950640-1-ross.burton@arm.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-06-28 at 18:12 +0100, Ross Burton wrote:
> The days of broken certificates are behind us now, so instead of always
> passing --no-check-certificate to wget, don't pass it by default and
> instead only pass it BB_CHECK_SSL_CERTS = "0".
> 
> [ YOCTO #14108 ]
> 
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  .../bitbake-user-manual-fetching.rst            |  4 ++++
>  .../bitbake-user-manual-ref-variables.rst       |  4 ++++
>  bitbake/lib/bb/fetch2/wget.py                   | 17 ++++++++++++++---
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
[...]
> @@ -288,12 +297,14 @@ class Wget(FetchMethod):
>          if exported_proxies:
>              handlers.append(urllib.request.ProxyHandler())
>          handlers.append(CacheHTTPHandler())
> +
>          # Since Python 2.7.9 ssl cert validation is enabled by default
>          # see PEP-0476, this causes verification errors on some https servers
>          # so disable by default.
>          import ssl
> -        if hasattr(ssl, '_create_unverified_context'):
> +        if not self.check_certs(d) and hasattr(ssl, '_create_unverified_context'):
>              handlers.append(urllib.request.HTTPSHandler(context=ssl._create_unverified_context()))
> +
>          opener = urllib.request.build_opener(*handlers)

The comment here is now incorrect. I tweaked it in the version I queued in -next.

Cheers,

Richard

