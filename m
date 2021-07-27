Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web12.425.1627388912878912277
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 05:28:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YDZIBzg8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id b128so7457020wmb.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jul 2021 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=D5hCjYZg4HjuzMCeg/BgkA7TozPP7jV0B/K2dCgOKFA=;
        b=YDZIBzg8sRo/Q4+bkmgDjpbmr7i2994Fgn2Fm8uc3kp6AsrxPsunr5UCz4XzNS0/il
         ZFvto8VuyxCQn+qO7cxo4vs4jDU0AioOK5NM5ZBiTErZ0FoHgQBrMo+uCtP6GOXthW3v
         hcWxs8K/x/pADb9yyFjz69Znofgj+ilUAFuDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=D5hCjYZg4HjuzMCeg/BgkA7TozPP7jV0B/K2dCgOKFA=;
        b=Ho1CEuB1qgp9Lpcq+dT8JasrUmJOQlHpEUR1KPKHKfWcWmDKqN+0M9ZlQwY7W4EsWK
         l3t6Gx0lFL5L4ZnVuYq3K7I6+sHnMezX7JAiiCoXQQK0SWRTXEWoyJTOzUx69ZsWBAPG
         i5+qd5eRqj0rrPxOU0alU4W2TjO+8ItnCy4o0pYjroixMnR9uzycrAwxMVRj0euA9D0Z
         vrE59a8svG8QXc1EJlYGJT2iAZkpA/SRBYL0kNgKUtZVXgTqiEtOa/mliUPbvM/Qadnv
         FS7pirYo2lDOFYAMaKWnTT246YozLLgGhdkFsgz6iuQa+DrQRNreQEykC4iD4wD4oz70
         QLkQ==
X-Gm-Message-State: AOAM530BRu65qG0vhjRI2Evi1Dh1xYVNMd2tCFvmX/zm2wf1oVenvERV
	s3zQl6ne8zXGzSC4aZ3qQk17zQ==
X-Google-Smtp-Source: ABdhPJyy2AcBFYjZsZqh84e1rCGsOaI4OJXKC14GofFMHtCmglJiNjknWROxqMADp2qYmFChQbM26Q==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr21750512wml.135.1627388911411;
        Tue, 27 Jul 2021 05:28:31 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4? ([2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4])
        by smtp.gmail.com with ESMTPSA id d10sm3206278wro.43.2021.07.27.05.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 05:28:31 -0700 (PDT)
Message-ID: <269b9c191fdc8540eb6602409ef7a991e32a249d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v4 0/5] Re-implement prserv on top of asyncrpc
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Scott Murray <scott.murray@konsulko.com>, 
	bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>
Date: Tue, 27 Jul 2021 13:28:30 +0100
In-Reply-To: <1695A57BEF93A6B5.3345@lists.openembedded.org>
References: <cover.1627352176.git.scott.murray@konsulko.com>
	 <1695A57BEF93A6B5.3345@lists.openembedded.org>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-07-27 at 13:26 +0100, Richard Purdie via lists.openembedded.org wrote:
> On Mon, 2021-07-26 at 22:37 -0400, Scott Murray wrote:
> > These changes replace the old XML-based RPC system in prserv with the
> > new asyncrpc implementation originally used by hashserv, and add a
> > read-only mode to match the hash equivalency server's support.
> > 
> > Changes from v3:
> >   * Scott Murray taking over upstreaming effort from Paul Barker.
> > 
> >   * Dropped patches which are currently applied to master-next, this
> >     series should be applied on top of the current master-next branch.
> > 
> >   * Patches 2-4 updated by Scott Murray to rebase on top of 3983643
> >     ("bitbake: asyncrpc: Catch early SIGTERM").
> > 
> >   * Read-only PR server support patch added to stack to get it into
> >     the review process.
> > 
> > Paul Barker (5):
> >   asyncrpc: Wait on writers to close with Python 3.7+
> >   asyncrpc: Ensure that asyncio shutdown is clean
> >   asyncrpc: Handle exceptions
> >   prserv: Replace XML RPC with modern asyncrpc implementation
> >   prserv: Add read-only mode
> 
> There is an odd failure on the autobuilder which seems related to this.
> 
> https://autobuilder.yoctoproject.org/typhoon/#/builders/75/builds/3746
> 
> and looking at the bitbake-cookerdaemon.log:
> 
> 1958 12:03:42.046562 Running command ['clientComplete']
> 1958 12:03:42.046659 Command Completed
> 1958 12:03:42.047003 Processing Client
> 1958 12:03:42.047061 Disconnecting Client
> 1958 12:03:42.047215 No timeout, exiting.
> 1958 12:03:42.147541 Exiting
> Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
> Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
> Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
> Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
> 
> with this last line repeating a 'lot' (log is over 1GB in size).

I should add, this is after the bitbake-layers command used to add the layer during
the setup of that build. The later command just times out as the server process
remains and is locked up.

Cheers,

Richard

