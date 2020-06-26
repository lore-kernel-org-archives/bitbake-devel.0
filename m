Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.100.1593206457606657922
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2020 14:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VDkh1l+I;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id q15so10026374wmj.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2020 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=bwCcPC+N1hzsQI7ZyTCh1OT8Kcs+0zuMABGJDdoscE4=;
        b=VDkh1l+ISEtMrEpkxnYw9T5SqX1yVCMk/4UwgZ4TA1HMls+VL5oMmQXHz7+fFsHgew
         yK6bw/BDWBr0PqGmWx3k3MdzRCtQ+fGhCYFEZ6HfXNMwbr7dhtoshDQdPf+Dup/6wuX3
         payM6Z1TsCYLKUmxlGoyH9iBD+9IqhCcZaUc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bwCcPC+N1hzsQI7ZyTCh1OT8Kcs+0zuMABGJDdoscE4=;
        b=l5zSIfH04l1S4Ld+tTQIdjjG9/9sSgppoaQKJ+QD/4S9gkwjvnOlriPLVTM6WdC3ff
         4q4+iwM+sIwi6vpK43RVG4nb2t+GBPOuPkxARRs+LibPlAQ1XK7qf2xuACuMTDONQbug
         I3esCdQdRLbheYKrlAPm0/BxNsb1V72TwVqRQVIt+jVWJ+mZ+BEDcH+MToVqVTVYtxEe
         tGbAf40DxAoA3H3Hwyyfdj+soxERCeJQYsZvpffnrn+XoEns3q/4ASg3nDYvPf3UV4pT
         G0Gv/aP91kKHJF968WjHKn6UVpMM0Ok4+KUxRep5TYjbFmodEBOmrAKiJLvcup9006j3
         +icg==
X-Gm-Message-State: AOAM531irIgIAxSlNdRO0auItzQm+a8aUuF7kHZ19WKufG9ZSJq2r74c
	/jxyjFh+O5aeXD3QNAbMMX9nEQ==
X-Google-Smtp-Source: ABdhPJyznkjh5avgN74V1gkGJVuMxwF0FkYVqk6j5TJofSQZADNw5dxe2qPLeyPbnB6BrYgil64OrQ==
X-Received: by 2002:a1c:4086:: with SMTP id n128mr5553193wma.118.1593206455832;
        Fri, 26 Jun 2020 14:20:55 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id c2sm38799364wrv.47.2020.06.26.14.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:20:55 -0700 (PDT)
Message-ID: <aa414ee5c19b78e4fd148e9e3e97b8147269ee49.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v2] hashserv: Chunkify large messages
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Joshua Watt <JPEWhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 26 Jun 2020 22:20:54 +0100
In-Reply-To: <20200625142107.11098-1-JPEWhacker@gmail.com>
References: <20200625141338.9078-1-JPEWhacker@gmail.com>
	 <20200625142107.11098-1-JPEWhacker@gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-06-25 at 09:21 -0500, Joshua Watt wrote:
> The hash equivalence client and server can occasionally send messages
> that are too large for the server to fit in the receive buffer (64
> KB).
> To prevent this, support is added to the protocol to "chunkify" the
> stream and break it up into manageable pieces that the server can
> each
> side can back together.
> 
> Ideally, this would be negotiated by the client and server, but it's
> currently hard coded to 32 KB to prevent the round-trip delay.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
> 
> V2:
>     Removed some debugging information I left in accidently
> 
> 
>  bitbake/lib/hashserv/__init__.py |  22 +++++++
>  bitbake/lib/hashserv/client.py   |  43 ++++++++++---
>  bitbake/lib/hashserv/server.py   | 105 +++++++++++++++++++++------
> ----
>  bitbake/lib/hashserv/tests.py    |  23 +++++++
>  4 files changed, 152 insertions(+), 41 deletions(-)

I naively ran this on the autobuilder, forgetting the server is central
and would need updating manually.

How backwards/forward compatible is this change?

With new client and old server we see tons of warnings, e.g.:

https://autobuilder.yoctoproject.org/typhoon/#/builders/61/builds/2068/steps/8/logs/warnings

I know I can upgrade the server but then will it work with old clients
(e.g. our LTS)? Do we need to warn users instead of warnings like
this?

Cheers,

Richard

