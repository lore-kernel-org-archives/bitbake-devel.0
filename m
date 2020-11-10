Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web09.34751.1605044009953845864
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 13:33:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iELuaT0F;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id o15so6477828wru.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2020 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=7v+V6GLmEsSK6jy98Ihi0cYys/gawgJZ5DIxggxZ/CE=;
        b=iELuaT0FEqu6xZ5Aee1mgzvhjITNm0L8uM/S49XZI+DgZuwYg8+ZXunTu+jqDciVFW
         MK0z2GTnRytdd8Vca1x3X9FU2Eqcar//gET8/03LQELr2/U4ptfbHE2yfjW+VyEB9Ehj
         c6AfJgY8KgRblz9CeTTBCqCsm4irhCf1z6C44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7v+V6GLmEsSK6jy98Ihi0cYys/gawgJZ5DIxggxZ/CE=;
        b=Xy0ca0gzFgh0ev0whUWPFs/naxMV2UDKhhp/pt8anIWHQEEAWO1J9YnRS6gYEKmS8s
         QyJsT5iOduPG15bOeiO/6VWf3fZxB4/RBmEFyBuu65pv6ZSpaHFca5roJP6tLhMfP80H
         G9fCawAiXmGY/9I+HlfS2TQRNw5iVIVb0nVwo1IbJRTTMrs3/ZuG3mFOwv5BPtD9erol
         dRV+rIrb5LNvHuXsWofUAPLX/RkKa111ttAb359sO2l66SVIiSE/KJlzy454L4FSj6zb
         Tagh1O3ZsQ2nn32dZc6yfH131xhDJDscRwONRPBKUNRrc02RwvZDyGVN1Vg2BxUE5FZY
         S11Q==
X-Gm-Message-State: AOAM532Z2eL4yQpnzQfNdac0ywhVF+C45rqzj4OOB+blzpN/4+z0Qf97
	t2RaueYLKzWY9oBlZ/MwGyccZA==
X-Google-Smtp-Source: ABdhPJxuC/ZmXoWPEM4HzP4cr7s57bvFeo8Dyum/NCUiLiEBzg6V5SxuV+8UX7EoysO1C9hORrXL+Q==
X-Received: by 2002:a5d:51c5:: with SMTP id n5mr5014734wrv.83.1605044008365;
        Tue, 10 Nov 2020 13:33:28 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 2.f.3.d.1.3.3.a.9.f.d.f.a.e.5.a.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (2.f.3.d.1.3.3.a.9.f.d.f.a.e.5.a.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:a5ea:fdf9:a331:d3f2])
        by smtp.gmail.com with ESMTPSA id z5sm591wrw.87.2020.11.10.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:33:27 -0800 (PST)
Message-ID: <6e2971889629724071065f7011efab293a4bd546.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Tue, 10 Nov 2020 21:33:27 +0000
In-Reply-To: <20201108221059.16854-1-chris.laplante@agilent.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-11-08 at 17:10 -0500, Chris Laplante via
lists.openembedded.org wrote:
> v1: initial
> v2: fix intermixed argument parsing
> v3: fix TinfoilConfigParameters defaulting of 'ui' with string,
> reorder
>     patches

Unfortunately oe-selftest is still throwing a few issues. In
particular, "oe-selftest -r tinfoil" is relatively fast but other
tinfoil users such as recipe tool and oe-pkgdata-util are failing.

https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/1533/steps/8/logs/step2d

Cheers,

Richard



