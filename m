Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.23459.1617401674705826866
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 15:14:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cwSmUivr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id j7so5777561wrd.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Apr 2021 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MudKZTiiIxGo3tQ5qr7uHeBkGEZWUKhVx/cRZKXLK6Q=;
        b=cwSmUivrqsKh7laRtY2jWUpT3p9nOHVbtD6Z1wcLaAnkg6biOBk21yPHY58Ei7ME+i
         n+fCuBvfRZLDDW0SYRDnCyuUl+BpLqwlj+hC1/vPa+iECLVghtCNClSuZQC7dejbwtDs
         xdy3aIFy59fey8VDhTYZUWM8yEAMhVZ2q5W0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MudKZTiiIxGo3tQ5qr7uHeBkGEZWUKhVx/cRZKXLK6Q=;
        b=NZoOkv54msnJSJAqPo815bbknNBpvyISJXE4/VeXsg9TmpKhKqgexZ5J3wghAPszK7
         hEuXsO8PEm3/JxFcq1bgllZkX28YQiiM8rDBbBX4z0f//gkSx3lscXIw3R9I1y6q77Oo
         KWnWDNiwKGRuiY+by66oBwmlLymw1FOVi5DUrOnGssuc1JVDYQy4UUu06o+fx++ZGBiC
         EEjTehyaA0Y+MCY8dgQCr4k9NFH7XY5sPjRk5bbuT8OWFaSjdM9EQGlrl2AGSlHV5Uca
         klvc3LnvHdBBIntEfgHubhdTXfQD3HDTwTUN9zUAAzJoyTV8TDO2fFPtI1cnYZVBY7eZ
         zK5g==
X-Gm-Message-State: AOAM5336gBa0jWCyVuKaBlA3E0Fcou6OrVlaMZ6X5oeG63oOmphVlIPc
	wy9rOYhEUSXy1ljzN51uWaHJ9A==
X-Google-Smtp-Source: ABdhPJy49nf0C96L5zsPHP1WLSAV7gDHO+UtdNEBWeBi/PqNabl0raw5tkhSd2+21xiIouv/qygXTg==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr17066330wrd.47.1617401673184;
        Fri, 02 Apr 2021 15:14:33 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:a3bb:8f94:1e3d:b6? ([2001:8b0:aba:5f3c:a3bb:8f94:1e3d:b6])
        by smtp.gmail.com with ESMTPSA id u17sm15804972wrw.51.2021.04.02.15.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:14:32 -0700 (PDT)
Message-ID: <929dcfb2b10aba2ca29d0b1cba44dbc148e0643a.camel@linuxfoundation.org>
Subject: Re: [PATCH RFC 00/21] Git repository sharing for kernel (and other) repos
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Bruce Ashfield
	 <bruce.ashfield@gmail.com>
Cc: linux-yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Date: Fri, 02 Apr 2021 23:14:31 +0100
In-Reply-To: <20210402171557.981599-1-paul.gortmaker@windriver.com>
References: <20210402171557.981599-1-paul.gortmaker@windriver.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-04-02 at 13:15 -0400, Paul Gortmaker wrote:
> Next Steps:
> -----------
> With this being a functional implementation, it seems like a good time to
> get other people looking at it.  Ideally step #1 will be getting general
> agreement that this is something we need, something that is overdue,
> and that the implementation as shown here makes sense in the absence of
> any similar effort from anyone that does the same but in a better way.
> 
> From there, we'll want more people not just looking at it, but testing it
> as well.   I know I want to write a commit (script?) that will avoid any
> "transition tax" by prepopulating new repos with "old" already downloaded
> git objects where we can.  And to add/do tests with my own popluated mirror
> and NO_NETWORK, and also try to ensure nothing in BB_SHALLOW gets upset,
> but I wasn't going to hold up starting a review of this any longer.
> 
> I suspect I can get some co-workers using/testing it too, but Yocto gets
> used in a bunch of different ways by different groups, so we'll no doubt
> have to do some additional fixups to ensure everybody gets the benefits of
> this sharing.  But I'm hopeful that when people see the benefits above,
> they'll pitch in to help take this the final mile by ensuring it works for
> their use case as well.
> 
> I'm not too worried about pontificating out beyond that until we get past
> the acceptance/testing hurdles outlined above.  So, please do have a read
> of the commits, kick the tires, put on your bikeshedding clothes and grab
> a brush, and lets see where it goes from here...
> 
> https://github.com/paulgortmaker/poky/compare/reference-RC1

I've only briefly looked through this but the more I look, the more worried
I'm getting which is never a good sign.

I totally agree with the use case and agree we need to do something in this 
area. I'm not sure the implementation looks right though, its clever but I
don't think its very usable to end users.

The warning signs to me are:

a) Needing new/confusing "fetch only" recipes
b) A large number of new options and variables to the fetcher
c) Needing recipes to change and people to migrate, potentially with scripts
   between old and new
d) Variable namespacing needs work

I'm very worried this confuses up the git fetcher code and nobody will be able
to tell what is going on any more :/.

What I'd envisaged was git urls having something like a "mainline-linux-kernel"
tag added in the url as a parameter and a table somewhere which meant the checkout
for this would share git objects in a common pool. There would be a variable 
mapping that name to git.kernel.org/pub/scm/linux/kernel/git somewhere but that
should be all that is needed.

No, this wouldn't cover 100% of artefacts but it should cover a majority of them
and be much simpler for users to comprehend. I haven't gone into this in detail
and perhaps I'm missing some problem that prevents it? :/

The other issue here is there are no tests. The bitbake fetcher code is one of
the few pieces of the project where we do have a fairly complete test suite and
we don't add things there without tests (see bitbake-selftest and lib/bb/tests/).

Cheers,

Richard

