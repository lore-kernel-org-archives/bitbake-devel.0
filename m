Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web11.9896.1603098570048831601
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Oct 2020 02:09:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WlRSOHz1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id t9so10456116wrq.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Oct 2020 02:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=AErXgWXsUuzlEWGIvqkYF4+NnVF2VTv2Q3tAE+WT0WU=;
        b=WlRSOHz1Yl00FurInMB6j3xfb3gbVbomg0aaVoTqehm9oXrbMRk/Dq5/q0jRDqQxos
         bVG4XNyxSJf6neGrYkS+XvRE0CRVG3MyPE5OpoROS1kAdBE5CZGbVjJTT48PWXFRMruS
         nFh9rgmFYWew9YbPNy1SgoHJfMpmhu4xuXo9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AErXgWXsUuzlEWGIvqkYF4+NnVF2VTv2Q3tAE+WT0WU=;
        b=jlDOwuwz/X6WAbmipwYenKQ/I1OygJ+lzGcoTsZTLEEb5xAVbnIOlBToVoiUi/jXUy
         B6aucC6sU06/IqDxpx0p9GQW/+oS8oBIs+MuEn4XVQFpUmP2Qh0LOpSvMV0ZgVUnk4iF
         VHFC3DSLFR/V3NO02+SoOEy4ePHOjXY9HLddfDvoY5RKbBMSUnt/QtnalLhhyGo/ZMqt
         g3mHBWG126XpBQ8OGlk1K+pCUzIWv64dQ+AcRoOB5e7/maExOHOGZOxsDs8CZDmrU+aq
         y5sEjkqDFVqZnb9PcFJzV6GRfy6TD5L6Prt4WvEw3mD9bh3GrmTCD6oWMZyQ/6chVIDl
         Zbvg==
X-Gm-Message-State: AOAM531e6aDf4/jyb2OozEJVSan8hrcIALkos+XfJFaZh5R6nfr+0pyy
	HUeAKtx2NqLK5TvoIz/wLMhD1g==
X-Google-Smtp-Source: ABdhPJze32J0lQAShO+9tAh7cadEgrpsZkpnq0XU5Mctw0fgOmNku0SuPjhIjL0bxpmInvldtwP4rw==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr10007372wrl.415.1603098568539;
        Mon, 19 Oct 2020 02:09:28 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from e.c.4.c.b.d.d.d.d.1.e.7.a.1.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (e.c.4.c.b.d.d.d.d.1.e.7.a.1.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:1c1a:7e1d:dddb:c4ce])
        by smtp.gmail.com with ESMTPSA id x64sm15542048wmg.33.2020.10.19.02.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 02:09:28 -0700 (PDT)
Message-ID: <5654d90cef29064a898f279d73c6deb6f6f91052.camel@linuxfoundation.org>
Subject: Re: [PATCH] fetch: git: add reference parameter
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 19 Oct 2020 10:09:26 +0100
In-Reply-To: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-10-18 at 23:33 +0200, Rasmus Villemoes wrote:
> The --reference(-if-able) option to git clone can significantly speed
> up the initial do_fetch if one is able to point git at a local
> repository containing a large number of the objects that would
> otherwise need to be downloaded.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  lib/bb/fetch2/git.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Whilst I can see why this is useful, it is going to end up causing
problems when you share that recipe using this term with others :(. I
don't think we should add API which will cause scaling issues end
"encourage" behaviour which leads to problems.

Clone by reference also causes problems for the archiver.

I have often wondered about this issue though, my own thoughts were
some kind of "keyword" system where if present, a base repository could
be cloned, then added to from the original upstream. At the end of
cloning, revisions could be pushed back into that making it a kind of
mirror.

So yes, I see the attraction/need but I think to have something merged,
it would need to be more usable in the general case.

Cheers,
Richard



