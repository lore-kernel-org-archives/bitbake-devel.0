Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web08.2179.1627397173763842022
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 07:46:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EXfVik0P;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id b7so15521839wri.8
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jul 2021 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OAtZT1xgJ5ioJjH617sk2LtoJHUk+PCngaQeLABIkhI=;
        b=EXfVik0PPl1HOq9UKNU0k5oY38uzA1oUSLhtyxj35UYnoFkTSuj1K9SQDdII8R15Yz
         W4ygduXoeDrXCShST9GNEs7DBlNLPec3mvJYVeJC3ZyHpDOXE2r6ronb6PlOR3bLEKJB
         zXodQWSramfE9wC3QVf93wZ+C3K/0zrarfC1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OAtZT1xgJ5ioJjH617sk2LtoJHUk+PCngaQeLABIkhI=;
        b=qKcvfJCVwE/MZmRzRcV6yDy9GQtdC13DuFF4D2I32u5n/XYaiOWTpah4Id7aAUCmAY
         YZK8iMOD45D/FnZjahlYfnKyT8BKDyGLPJO/+RdMXV4VEXHLuq0Sb1MfGxZdJV35TPIW
         AORA36ZGlKDl7qlTybRV8Zva3OBlz20MCgcY08h9g+wvEqyFFItrRfEpCZNG9IdUsp75
         /NJobTFnD1BvKroI8MPCxTfzSteIs8DoaXdxds+H/qtGm6jhczpkH7MnC/Y3/tze5Hy0
         A35J2lWzP5lpx5bmue3UaBJQpuDh4wbxL5BaKR/9RrH3JivfXxYhz7S3PfHIfUUfBSGw
         15Fg==
X-Gm-Message-State: AOAM531F94FI3GUDa1LelwJdkxb3EQ3XQqCzYDH+/7YMTpv3BhQiL32C
	/bJF39ltoozw+uz8iAwmNC3apA==
X-Google-Smtp-Source: ABdhPJyPjbrFiQrj/MlPwruriWrkGWSjzwiiJsDScqG6mbOCmatPC9jxJxJ96NGSjgibUeNvgwnWMw==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr20039059wrr.396.1627397172231;
        Tue, 27 Jul 2021 07:46:12 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4? ([2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4])
        by smtp.gmail.com with ESMTPSA id g15sm3116326wmh.44.2021.07.27.07.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 07:46:11 -0700 (PDT)
Message-ID: <e02c55af2e9b2330f9e7ad552a7fb9add0664940.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v4 0/5] Re-implement prserv on top of asyncrpc
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Barker <paul@pbarker.dev>
Cc: Scott Murray <scott.murray@konsulko.com>, 
	bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>
Date: Tue, 27 Jul 2021 15:46:09 +0100
In-Reply-To: <20210727141356.240bb95a.paul@pbarker.dev>
References: <cover.1627352176.git.scott.murray@konsulko.com>
	 <1695A57BEF93A6B5.3345@lists.openembedded.org>
	 <269b9c191fdc8540eb6602409ef7a991e32a249d.camel@linuxfoundation.org>
	 <20210727141356.240bb95a.paul@pbarker.dev>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-07-27 at 14:13 +0100, Paul Barker wrote:
> On Tue, 27 Jul 2021 13:28:30 +0100
> "Richard Purdie" <richard.purdie@linuxfoundation.org> wrote:
> 
> > On Tue, 2021-07-27 at 13:26 +0100, Richard Purdie via lists.openembedded.org wrote:
> > > On Mon, 2021-07-26 at 22:37 -0400, Scott Murray wrote:  
> > > > These changes replace the old XML-based RPC system in prserv with the
> > > > new asyncrpc implementation originally used by hashserv, and add a
> > > > read-only mode to match the hash equivalency server's support.
> > > > 
> > > > Changes from v3:
> > > >   * Scott Murray taking over upstreaming effort from Paul Barker.
> > > > 
> > > >   * Dropped patches which are currently applied to master-next, this
> > > >     series should be applied on top of the current master-next branch.
> > > > 
> > > >   * Patches 2-4 updated by Scott Murray to rebase on top of 3983643
> > > >     ("bitbake: asyncrpc: Catch early SIGTERM").
> > > > 
> > > >   * Read-only PR server support patch added to stack to get it into
> > > >     the review process.
> > > > 
> > > > Paul Barker (5):
> > > >   asyncrpc: Wait on writers to close with Python 3.7+
> > > >   asyncrpc: Ensure that asyncio shutdown is clean
> > > >   asyncrpc: Handle exceptions
> > > >   prserv: Replace XML RPC with modern asyncrpc implementation
> > > >   prserv: Add read-only mode  
> > > 
> > > There is an odd failure on the autobuilder which seems related to this.
> > > 
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/75/builds/3746
> > > 
> > > and looking at the bitbake-cookerdaemon.log:
> > > 
> > > 1958 12:03:42.046562 Running command ['clientComplete']
> > > 1958 12:03:42.046659 Command Completed
> > > 1958 12:03:42.047003 Processing Client
> > > 1958 12:03:42.047061 Disconnecting Client
> > > 1958 12:03:42.047215 No timeout, exiting.
> > > 1958 12:03:42.147541 Exiting
> > > Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
> > > Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
> > > Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
> > > Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
> > > 
> > > with this last line repeating a 'lot' (log is over 1GB in size).  
> > 
> > I should add, this is after the bitbake-layers command used to add the layer during
> > the setup of that build. The later command just times out as the server process
> > remains and is locked up.
> 
> What's the Python version there? I've just re-checked the docs for
> asyncio.Task.all_tasks():
> 
>     This method is deprecated and will be removed in Python 3.9. Use the
>     asyncio.all_tasks() function instead.
> 
> asyncio.all_tasks() was added in Python 3.7. So we need to use
> asyncio.Task.all_tasks() before 3.7, asyncio.all_tasks() after 3.7.

That worker used buildtools tarball which would have 3.9 in it.

Cheers,

Richard



