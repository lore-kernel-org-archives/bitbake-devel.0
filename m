Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.131410.1598004194596925279
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 03:03:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eufgVfQj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f67.google.com with SMTP id o21so1254670wmc.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=noxo3B5JOJ2ePtjqikUCUzxV2Fvsg6mobR2goV5QBHQ=;
        b=eufgVfQjSrABk83XISYCsn+e/J9ciKuV8nXE6nD86qunvqyes0JL5Kw46XpyaH3Jbs
         DMvE/nJREl9TmQFNUc2QMzkDQ2u5Y8o2RUpouy88HD+/or5eD5m58FnXcnB8NFzdJ4kf
         Fsig4LNhiGIsI5THr+pOLgH/RVEHXRVyZBSWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=noxo3B5JOJ2ePtjqikUCUzxV2Fvsg6mobR2goV5QBHQ=;
        b=hQ+hatSmLnt3JQW/J1glpMSofsItR8D4mhtlPeTQC76XsJVmwdE00BGDeNlr1IJZQs
         R3CQmSXw3C+cGWWHXEiS2ZPaaALf3LMyLQiflseBrdV3pF+fhFEL/83ITshpog4Sh1fH
         pjvd39zpWWNGSopqn9cI0AS+OJrrD7w1SDKyLOXtBkXla0GyARvhVhfjrMSZ9fJpwoq6
         qLM/1jO/mqMXvhP7+y0PixZLp59m/iarxCyHR7GXIMz6q++QVtk8nF3HuVJwLVJBdv6L
         IcoestKzU0ADowP1uonNlYJwEe6swLnttmgdiRTDh+vsSh3ZTaOBzgBKMtPyXTVSImRm
         NHqg==
X-Gm-Message-State: AOAM530IzunrgHwz6fSbHfuh43Zkh//hA90aE+sY104Viddh1tydPkFv
	XlrSWJkNvVVvVSnHdxqNmTRkZw==
X-Google-Smtp-Source: ABdhPJzBelJYT+2E8Ve/aHZ4VG4QD68mi6lPOgCup9Gkqo3iMLhCPAuTztQIUepsvQ5M/1K3uN5cew==
X-Received: by 2002:a1c:e20a:: with SMTP id z10mr2971670wmg.65.1598004192803;
        Fri, 21 Aug 2020 03:03:12 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id h6sm3398785wrv.40.2020.08.21.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:03:12 -0700 (PDT)
Message-ID: <0e45aff7dadff33243ae2590e2f813395b71f35e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] server/process: fix exit racing between process and thread
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Hongxu Jia <hongxu.jia@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 21 Aug 2020 11:03:10 +0100
In-Reply-To: <9b28fe30-a475-2949-118e-1fe70aef4fe4@windriver.com>
References: <162D282190DD8FB5.7353@lists.openembedded.org>
	 <9b28fe30-a475-2949-118e-1fe70aef4fe4@windriver.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-08-21 at 10:56 +0800, Hongxu Jia wrote:
> Hi RP,
> 
> I have another solution to fix this issue, how about drop
> thread invoking, directly call sync_caches in shutdown?
> But there are some else multiprocessing.util.Finalize calling
> in bitbake/lib/bb/cooker.py, I am not sure about the side effect
> 
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -2130,10 +2130,7 @@ class CookerParser(object):
>              for c in self.bb_caches.values():
>                  c.sync()
>  
> -        sync = threading.Thread(target=sync_caches)
> -        sync.start()
> -        # While multiprocess exit, it should wait thread terminates
> -        multiprocessing.util.Finalize(None, sync.join,
> exitpriority=-100)
> +        sync_caches()
>          bb.codeparser.parser_cache_savemerge()
>          bb.fetch.fetcher_parse_done()
>          if self.cooker.configuration.profile:

Well spotted!

We use a thread here to try and avoid delays whilst the cache is
written out so its a performance optimisation.

I wonder if we could use atexit here to register the call to
sync.join() ?

We just need to be careful this is only called in the cooker process
and not any others we may fork() off. We therefore may need a wrapper
to ensure that getpid() is the correct (saved) value?

Cheers,

Richard

