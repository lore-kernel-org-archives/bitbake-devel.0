Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.74.1591387518492077017
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 13:05:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OJMd4oaT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id k26so10243498wmi.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=2zilrISbtISl+CJ1+Zq5ekhfku7uxrGCFqUmtOqut50=;
        b=OJMd4oaTwP2SsNJD+vxlXjrXRHoSScjl2WXc02GRkA2vD1quUvsTpYso+VUxhfYgOl
         FkVXtROEGOAsjTBgp3w5v/Jz1dZtnwswDitIGNVAbLKzTgYj64wm8wB1FyKlTemZZKjY
         8s2kTU9l5ChA+E9IC3cs1gfPHDDtvwPu2S30c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2zilrISbtISl+CJ1+Zq5ekhfku7uxrGCFqUmtOqut50=;
        b=LzkjkeeAGcrlMZYzGYQGQCC1wJtN/R5grLD4a0HNs8DK4m6OcgOabhq8WMbPESREK5
         qNAu1Vb4lFDjvhrGDFCyTHHu/S2Q0FUukmV3knNNWQmZGiLbV9qYD5+qpfkywyXlazcO
         Mi10LzwgVC2D1oowE/lxRS4aWy9sLCsOkbBVIb7N6d8n0n2xi+mNRNK9SKtidpJrvkCW
         CNi2e0WAJrk83w4KCibQNGgr5GVfWkY3unGSPR1zZhllNU7kDhwtyu/9o7ZZEDhUy1A7
         am1B3+KVSTk6SjP8FG0E2D8bL9a6sv1+nQlInIv4w+lZMfShtm8trmk8VZ3+iNKiSf+b
         w+tw==
X-Gm-Message-State: AOAM530eg9kBngkXKi9HZ2zMrU9v1hveQyzoUACdzgvvDXXVsOUM6EIj
	pSVUendNfOs1nS3v+hIt8mkqFw==
X-Google-Smtp-Source: ABdhPJxjM//VnU6Zo+Gjk7yUBAQ3ZvHSQ6LtJ0HvkYElRNLfA1dpfg6aTqHM7dTAv5POogfwU1iGOw==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr4192916wmi.119.1591387516926;
        Fri, 05 Jun 2020 13:05:16 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id l2sm13044987wru.58.2020.06.05.13.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 13:05:16 -0700 (PDT)
Message-ID: <908d8ac324934a1145f03df36775148b94e7ac42.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v4 0/8] Add support for per-multiconfig BBMASK
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Joshua Watt <JPEWhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 05 Jun 2020 21:05:15 +0100
In-Reply-To: <20200605015325.35395-1-JPEWhacker@gmail.com>
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
	 <20200605015325.35395-1-JPEWhacker@gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-06-04 at 20:53 -0500, Joshua Watt wrote:
> Splits apart the bitbake configuration data and caches so that each
> defined multiconfig can specify as separate BBMASK independently of
> the
> other multiconfigs. This can take multiple forms, such as a `BBMASK`
> in
> a multiconfig .conf file, or BBMASK assignment based on an override
> (see
> linked bugzilla for an example).
> 
> The most noticeable change is that bitbake now keeps a parsing cache
> file for each multiconfig instead of a single parsing cache file that
> caches all multiconfigs.
> 
> [YOCTO #13721]
> 
> V2: Fixes some syntax errors in tinfoil
> 
> V3: Optimizes caches so that each one only caches the files for it's
> own
> multiconfig
> 
> V4: Fixes compatability with Python < 3.6
>     Renames split_pn -> split_mc

Its looking better, thanks. There are still the selftest failures:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/1023

Cheers,

Richard

