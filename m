Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web12.21804.1600261135386427172
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Sep 2020 05:58:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GObeRtcQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f67.google.com with SMTP id l9so2924886wme.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Sep 2020 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=o9HW3KrNkZ8iC+n09lgLrlYsmzA4Ra9FGnUn3WTur5s=;
        b=GObeRtcQk4Irm8LBUwt3pzKwR3S94M/IRrx+g7Ks8phyg1s8b8FNrLDyMdbtBcn/w4
         g6myxaeeFbRPruU2OxWbDw5An/XL/zJY/LYaHw4cYRbZnBtasxXKJZFPPR4QmJzMmCRp
         sLZ3xJ/kepwFYDPTQRrK2SDl0Vx0Fae2WncbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=o9HW3KrNkZ8iC+n09lgLrlYsmzA4Ra9FGnUn3WTur5s=;
        b=sM+LQm+dAcRwr2BJcb5X5bY5to4hVfsFinm9kwGJhAUIJSGGr2nZpYBfDTkbDWktwS
         wZaTgq/O6YUr0gvtNZhmJ59R62w5OCBlf8yb8MJ0CvxFJv3YQ6fK1WLwJO7wyzbrtTzp
         F11kGVMwvczlAkZLtc/1/iwxec4R6HqYhu9SydmcrOoCTjDZRZic/04Lat0JBqRZRe4w
         o/lUF9c+stjALrXi5WhRPXbFXoR04C9wCydXOfONAZJXTYBYeyTKytndPYuqcdPoS/uE
         pN2ywMesqstJrrgNc17Oqvqno54iXqElLCfhPAT4YYOtpz2jv1W6KDgoK/D6b4IXopHe
         89MQ==
X-Gm-Message-State: AOAM5333uZNcJQQjjWMqVVyyhSMS3wjTFV8V4o3kd7i08thOj2e9qhqK
	aVDmfSdb587E3+Z87vTPKmqLFqnRrklarg==
X-Google-Smtp-Source: ABdhPJzzvQUdDzoDxbKBRufSC119+0X/rguCZhCraDq4yRSOppXftsFKAqYxCUK/fwbLZF0os+IFFg==
X-Received: by 2002:a7b:c359:: with SMTP id l25mr4491911wmj.187.1600261133840;
        Wed, 16 Sep 2020 05:58:53 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from c.6.3.c.1.5.9.4.8.7.9.7.2.3.5.0.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (c.6.3.c.1.5.9.4.8.7.9.7.2.3.5.0.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:532:7978:4951:c36c])
        by smtp.gmail.com with ESMTPSA id c16sm2927370wrx.31.2020.09.16.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:58:53 -0700 (PDT)
Message-ID: <075098f5e21fc34a925187c6114206af92bbfd78.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch/git: add support for SRC_URI containing spaces in url
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Charlie Davies <charles.davies@whitetree.xyz>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 16 Sep 2020 13:58:51 +0100
In-Reply-To: <20200915211214.140434-1-charles.davies@whitetree.xyz>
References: <20200915211214.140434-1-charles.davies@whitetree.xyz>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-09-15 at 22:12 +0100, Charlie Davies wrote:
> Microsoft's TFS VCS system allows for spaces in a git repository url.
> An example of a valid url is:
> 
> ssh://tfs-my-company.org:22/tfs/My Projects/FooBar
> 
> This commit adds support for such urls by implementing two changes.
> Firstly, when bitbake makes a git command line call the url is
> surrounded by quotes so that the url, regardless of spaces, is
> treated as one argument. Secondly, additional parsing of various
> filepath variables, which are based off of the url, are now
> completed with any spaces in the url replaced with underscores.
> 
> Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
> ---
>  bitbake/lib/bb/fetch2/git.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Hi,

Thanks for the patch. I wondered if you'd be able to add a test to
lib/bb/tests/fetch.py to cover this please? They're run by bitbake-
selftest.

I'd also caution that whilst this change is probably fine to support
the cloning of such repositories, the build doesn't work well for
repositories with spaces in the build paths. We're limited in what we
can do about it as autotools doesn't handle it well.

Cheers,
Richard


