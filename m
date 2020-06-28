Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.24384.1593330707107355508
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Jun 2020 00:51:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G0syhRR/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id k6so13371957wrn.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 28 Jun 2020 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=BdH0xKMgttt0S+hVTDUOJhWhPtlERvxjDDetmiKTcyU=;
        b=G0syhRR/n1bClWEp2lwpzcdOgy2PWhPbr/acrMBU8UO465Obp6ymHQ6zozxsWg6yWA
         gDMcc76XFIxOnD6qrj1m+wVJcqiYMeuIegfhf9yvAWqD8cgBROWEQLI/WxrLoSEkUKzn
         uK+jTrAtyhhHtKlIbPO7Bg67yPc3T3ZGH1qms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BdH0xKMgttt0S+hVTDUOJhWhPtlERvxjDDetmiKTcyU=;
        b=o3TG0EGjU6hs1+l1lqa24yeMGWLR504+ZtyfsqW7//p+mporhfmXPdtGZ/uG9eEuVK
         e5Y7YMZzecby8e07Cprh8a8sozJEFDK4AyEHHI9DdnvXDXgOa/znmv0NoW/c22Zt5qRp
         EwcaG0RJiwCnkRE+1Q2PyQPEpa9ncotoVWahIz/DddIssDBoSX8QkhRlK3KCs7A3FB0U
         GQCCdik0IgP8yY7cBQNR/Dq/8xnxmVB5KFunzNyiBhrMVh0VwSHf8v+3Bgo3r/ZPYfCx
         0YTkv3QJVeA6ExD+8EQWRvXlxvhMjqHWi7xgpbv0PHJ+QHBHVd7Jgn3bzy9d+PaMk0DM
         99MA==
X-Gm-Message-State: AOAM531JD56CiPELaseCo1yKQFdEDRPQkQldgxs6sQg3i5vS5f0HllMS
	6jq2dCVO0ZjDY8JQcY7frGBBmg==
X-Google-Smtp-Source: ABdhPJzQ3RFKVxjuBNChDyvoSPHOXDpBG/80cwyBh8wllaTffJUCxZJcZSyNZ9hrZkoySQHOLTHHRw==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr11218152wrs.87.1593330705474;
        Sun, 28 Jun 2020 00:51:45 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id k185sm21128057wmk.47.2020.06.28.00.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 00:51:44 -0700 (PDT)
Message-ID: <099ddfc8784d7760adb9b1fdd8207325d29895dc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Support for git+https://foo.example.com like URIs
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: enrico.scholz@sigma-chemnitz.de, bitbake-devel@lists.openembedded.org
Date: Sun, 28 Jun 2020 08:51:43 +0100
In-Reply-To: <lyh7uzxnvx.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <lyh7uzxnvx.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-06-25 at 15:42 +0200, Enrico Scholz via
lists.openembedded.org wrote:
> Hello,
> 
> for some years we are using a mechanism which allows to encode the
> protocol ("https", "file", ...) within the base uri.  So, we can
> write
> 
> 
> > PROJECT_BASE_URI = "git+https://foo.example.com/project"
> > SRC_URI = "${PROJECT_BASE_URI}/some-repo"
> 
> instead of
> 
> > PROJECT_BASE_URI = "git://foo.example.com/project"
> > PROJECT_BASE_PROTOCOL = "https"
> > SRC_URI = "${PROJECT_BASE_URI}/some-
> > repo;protocol=${PROJECT_BASE_PROTOCOL}"
> 
> Four years ago I wrote a bug report [1] with a patch against bitbake
> itself which was more or less rejected.
> 
> In the meantime, I moved this out in an OE class [2] which overrides
> 'bb.fetch.decodeurl'.
> 
> 
> Is there some generic interest in this functionality so that I can
> create and send a patch for bitbake?  Or is this too special and
> people
> are happy with altering ${MIRROR}?

I didn't (and don't) like writing special cases into general code. The
fetchers once had a lot of that, it was hard to clean up and I'd prefer
not to go back there.

There are multiple different issues with fetcher urls in this context
and multiple open bugs from what I remember about related issues. Your
patch solves your specific use case and doesn't help those other open
bugs.

My intent has always been (and still is) to see if a more generic
solution is possible which not only addresses your use case but the
ones others have as well. That will likely mean using the mirrors
variable to remap things which will be slightly more complex but will
also enable others.

Cheers,

Richard



