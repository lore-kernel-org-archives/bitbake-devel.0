Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.38572.1599474636321600707
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2020 03:30:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YVaYgyJw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id t10so15293375wrv.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2020 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tNkPgaeVU9eCGhZIj1P/82iaB68x2o9U0d/JinrcUWk=;
        b=YVaYgyJwgkFVMc6yT8AAbqf/TJmfj5Coikbxi4chVt6w+WXobc40msEZJSzBOKqTJb
         zVOyyhaAGMLPbeAjUZqgxZgwPHpWnjjGkHope9A1vFOnZ5tggROZueH2/FVN8F4Xvdon
         p9IxXbsBUARj8crzrXDTe0G4w4vRgk4O/mJsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tNkPgaeVU9eCGhZIj1P/82iaB68x2o9U0d/JinrcUWk=;
        b=TYDh+ivJ8uDPQsK5JpoV3XHd9ByaNUBE0PS9S2eAoHsyKAiUGqbHqCJv7+2WaA1iio
         FNJTPJSYmB72OlsqFustuiJHJEE8wRKbJKgbNpOvnoBsRiKeYZckdyUsadiq9QKQ+/VN
         qvtZs0hX18OybsoaLcaNW30AZ79Uidfeqg0NP8/WXWCfAKIwziV4u8VHVxSmOGpqPRAt
         P3JQ+It5c7illUWtxv2wJywqlSdd1g38kFmlUzyzePlewXGgAddXZcLWdit3H5oVKoPR
         csThnOUlYvfHvDM++nz7oUz7o7RmpDgQkwFDaG2uyNaSLIErO3M/+/sL8yCG6JR7b88k
         0zEw==
X-Gm-Message-State: AOAM531wa6JiaKx6nOUUjFOWtbqtIG4zlv3BAKWA4REuFxVqgp+emu0r
	owVGQK0dEcBXGjQx+c3D0yIrRg==
X-Google-Smtp-Source: ABdhPJwwcnvFOX8bkkgO9K5LRN0XBb41h+dPEoMNYcugXmdmpkq7XSBcINVh6MCZ7U/Od7d6Jp2PlQ==
X-Received: by 2002:adf:ec87:: with SMTP id z7mr22478620wrn.57.1599474634675;
        Mon, 07 Sep 2020 03:30:34 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id u66sm1188543wme.1.2020.09.07.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 03:30:34 -0700 (PDT)
Message-ID: <a61fd29432c52915aa8f680e02b05f1a19ded580.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] an idea about parallel doing do_patch
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Mikko Rapeli <mikko.rapeli@bmw.de>, zhangyifan46@huawei.com
Cc: bitbake-devel@lists.openembedded.org
Date: Mon, 07 Sep 2020 11:30:33 +0100
In-Reply-To: <20200907085816.GO2026@korppu>
References: <20200907083711.GL2026@korppu>
	 <20610.1599468217725892636@lists.openembedded.org>
	 <20200907085816.GO2026@korppu>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-09-07 at 08:58 +0000, Mikko Rapeli wrote:
> Hi, please reply to mailing list too.
> 
> On Mon, Sep 07, 2020 at 01:43:37AM -0700, zhangyifan46@huawei.com
> wrote:
> > Sure using git repo is best solution.
> > But I am working in a company  and we use local codes(tar +
> > patches).
> > right or wrong, I think if we can improve the efficiency of
> > patching, it is better than nothing.
> 
> Well, here I would really move away from tar + patches approach and
> move things to git.
> I've been there and forced BSP vendors to provide full git trees with
> proper commit messages
> and history linked to upstream kernel.org stable point releases. We
> have these
> in our project and product requirements. I suggest talking to the
> vendors and moving
> to git.
> 
> Tar and patches was ok in the 90's but not anymore large change sets.
> 
> Parallelizing do_patch() could be a nice addition but needs serious
> testing and validation because bugs could have really serious
> effects.

I agree with Mikko, that do_patch isn't really designed to handle 3000
item queues of patches.

If you really want to do what you're doing, I'd write it as a
replacement for quilt which has parallelism. You'd then perhaps be able
to swap that in with fewer changes to OE-Core. I'd also want to very
carefully analyse where the time bottlebeck is in do_patch as I suspect
it may be on process execution overhead rather than in the patch tool
itself.

I'm not really very interested in changing do_patch in the core to do
parallelism since this is a very specific corner case where you really
should be doing something else entirely (use git).

Cheers,

Richard



