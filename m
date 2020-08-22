Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.154814.1598105982410539997
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Aug 2020 07:19:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AO8I0q2I;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id y3so4471242wrl.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Aug 2020 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=6KrKEnT3qRU0pqpqPVe3OEJMT4qMJEQtVf4NbKv199A=;
        b=AO8I0q2IAjFO6kW8Fb/VGpTmt7lYaU4VxBRTkBO3yDLAYHHoJD8TqMzl2thHPHIUXQ
         lEXDA0yo6mjwadzrHEfI5bHsS8eCyyhqWmUaG673crSahowi7BfG9QzWruPmvpXR9R1Z
         7QC4eo87UstbJ7qCyuhvH8O6ydJBEO52iMajs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6KrKEnT3qRU0pqpqPVe3OEJMT4qMJEQtVf4NbKv199A=;
        b=QbXDVX0k+ysrNGCH4qxqIGwhufKrLLIkoXwivvZTiTu9VSY32Z/5moVd+GUJsa027y
         MZr02cFAl4XD1WP9Sh3Ku1aKIzlEgXqn44XO/RllzsGS2aVX5xdhk5lp+8BxAQwcPglW
         Ec8k3tvef3bifv5sY9LyvIpWWpP2fLR2NJ9qWHj1tP23iUU7Vqzncid4+53/SunnRqmf
         6dEPaV7nh0up3qhl+1gRoW0qTu5jgvXL4YVxU3tTdyRem2QnZuHHRL6GiOnVWvFLZNwE
         V0Fr8A60r0rdgvrpF0dQmJSgdvAwdbqFW2ditVUMwMqc99Ps18K+1KGtXlxfZgpjbkBO
         B8pg==
X-Gm-Message-State: AOAM530FUBYA+l+dOifPF33m44ixHXhoOnXtIPaUIyBUz+Lp7ey0VOSZ
	OiKD6a2I8D1Ry27aNFAT3bRT0HwUg6qH+5YL
X-Google-Smtp-Source: ABdhPJxCSNhtsC0sO1m+3PgDXV9n17jVSDZl3ISBCMwLg61d2bOjJ01iTLEKJ7MeufaKroUv8t82Gw==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr7395528wrt.67.1598105980662;
        Sat, 22 Aug 2020 07:19:40 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id b8sm11535406wrv.4.2020.08.22.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 07:19:39 -0700 (PDT)
Message-ID: <83d152f2c66dad66c620d7a6063f7364533c16d8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] server/process: fix exit racing between process and thread
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Hongxu Jia <hongxu.jia@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 22 Aug 2020 15:19:37 +0100
In-Reply-To: <d9f5d95c-1796-de85-bfa3-889c1ce31c2f@windriver.com>
References: <162D282190DD8FB5.7353@lists.openembedded.org>
	 <9b28fe30-a475-2949-118e-1fe70aef4fe4@windriver.com>
	 <0e45aff7dadff33243ae2590e2f813395b71f35e.camel@linuxfoundation.org>
	 <d9f5d95c-1796-de85-bfa3-889c1ce31c2f@windriver.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-08-21 at 23:47 +0800, Hongxu Jia wrote:
> Yes, after applying solution 1 fix, I check the content of
> bitbake.lock,
> 
> the saved getpid is the same with cooker process. But it differs
> 
> with the log message in bitbake-cookerdaemon.log (the log message
> 
> is before multiprocessing.start)
> 
> So I think the fix of get multiprocessing.Process back is the best
> choice
> 
> we have which reduces unknown risk

I don't like creating extra processes just because it seems to fix an
issue so I don't really want to add the multiprocessing call back, we
need to understand why its breaking instead.

I went digging and found that the os._exit() call from the server was
why the atexit and Finalize handlers weren't running. I sent a patch
for that.

I also realised that the write for the cache file could happen after
bitbake shuts down. That could be bad for a lot of reasons and means
Finalize and atexit are the wrong way to do this, it has to happen
before we drop the lock.

I've therefore sent a patch to fix that too.

Cheers,

Richard

