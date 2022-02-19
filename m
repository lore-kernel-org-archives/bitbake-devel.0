Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F19DC433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 20:25:37 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.14258.1645302335886745564
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 12:25:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=La+usPLE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id i14so20126658wrc.10
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 12:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=PZugp6JCkKraoMmoCtArhMIfD/9/xReHLYyQ76yt/Cc=;
        b=La+usPLErg2cMEb23jLU3CkbSGIo3GRMLoFCoBAHPMYAx6h02ckPN83cEP/27h0DSL
         6cavv564EB1YV1RKS7wjnMXOui8ECHTTZO+YsA8PUvbE+epkJ8cuO9pTTZMGaQ4LV5uW
         fluVmV1cUTHbfytvS8IKvsG06PttdbqbhRB0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PZugp6JCkKraoMmoCtArhMIfD/9/xReHLYyQ76yt/Cc=;
        b=lw8IdcJ5DEAzX63jdmoiW5MoXH7oUFoQ7J01ysNIHsa/H0gamzF+1W/064+JxbxtuS
         0+mnbBYVzUSBUS1SWpXM5kZkyRddEAQDuiWkd8D6D8cMdRs6VYrTk8v7MQvMucVxt4iA
         7nfqtzIGHKUPkyhgYydLUfCZiSTA+BuhH44YxnLCbVAoMP3fH3NDRwzfiuQ+bAlnTnoB
         kJt9TPDaimCaJInhH3kMLyAoxLc0liumRiGnQ0lZ4CpXDuLmV7RD+OQqFIvhpWTR9vey
         +7wYur3MbTnqpAPkE4N6hUJeecsKOzXd/LTDu7Vx9U6f4CrKgQOZD4KErCOVXvN/sCWV
         OF+g==
X-Gm-Message-State: AOAM531uV6mdbwIY/z0qkKmEXva3vul36xCkOUEDMFZLuoAaeQSHNfa1
	Ng9UdXuhgjEkzoHi8a7Auk8AXw==
X-Google-Smtp-Source: 
 ABdhPJy6ODGr8MWZMhypJyXMg/2vz5LQds7TFhoahhsjRbw5y4YeQi0m+fdzBEkaOArr0G7DzAVLdQ==
X-Received: by 2002:a5d:6546:0:b0:1e3:2236:e338 with SMTP id
 z6-20020a5d6546000000b001e32236e338mr10056606wrv.72.1645302334058;
        Sat, 19 Feb 2022 12:25:34 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:bf04:d486:cfa0:deab?
 ([2001:8b0:aba:5f3c:bf04:d486:cfa0:deab])
        by smtp.gmail.com with ESMTPSA id
 n7sm3135652wmd.30.2022.02.19.12.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 12:25:33 -0800 (PST)
Message-ID: 
 <edab9e75c3e51c087f85d448a7be22e64aaaa5cb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/3] simplediff: Add type annotations
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: zygmunt.krynicki@huawei.com, bitbake-devel@lists.openembedded.org
Date: Sat, 19 Feb 2022 20:25:31 +0000
In-Reply-To: <20220219201957.8329-3-zygmunt.krynicki@huawei.com>
References: <20220219201957.8329-1-zygmunt.krynicki@huawei.com>
	 <20220219201957.8329-3-zygmunt.krynicki@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 20:25:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13393

On Sat, 2022-02-19 at 21:19 +0100, Zygmunt Krynicki via lists.openembedded.org
wrote:
> I was trying to grok how various parts of bitbake work. As a habit I
> make type annotations, as those help both me and, perhaps, others.
> 
> Introducing typing to an existing project is somewhat challenging, but
> by now, well established. It's good to start from any leaf module and
> work up from there.
> 
> I've picked, somewhat at random, the simplediff module, since it's
> small, self-contained and might be used as a starting point for the
> discussion around type hints.
> 
> With the patch applied, one can run mypy as follows:
> 
>         mypy --strict ./lib/simplediff
> 
> The module now has strict typing compatibility. Allowing it to be used
> in a typed context.
> 
> Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
> ---
>  lib/simplediff/__init__.py | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)

Just to be really clear on this, we have no interest in adding typing to
bitbake.

I've also mentioned on irc that some of the files in lib/ are upstream modules
so we limit our changes in those cases.

Cheers,

Richard


