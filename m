Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.125.1613065884147684798
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Feb 2021 09:51:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bzZZUG9B;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id u14so5073585wri.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Feb 2021 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=M0n5XSHoHuZrqVLOZKkzBdFbCjl4a0dHwmw4uHwGbRI=;
        b=bzZZUG9B4Rcfyopdf/t9/IgDu1jJjypdbRJrU7ArGG8TSuEV8movvGq+Kp0YP4s4b7
         w1cGzT/OtI5mD+XErDHl6dIz80YKIj25EGwQvA/DgZMSCqJjD+lpSJfQFG8LmLRf8ZR8
         itGHf+RKUU9CELp3W77suHS+UcI6TdPA/pF7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=M0n5XSHoHuZrqVLOZKkzBdFbCjl4a0dHwmw4uHwGbRI=;
        b=SAyxRaC9FFNkXKWBk7DL5Lqo+3lYS3Ai2VpA/28gQA+kEm47Z76/f2JW76UtgENold
         VK1ntVGlbh17/J7SU9KzfPeEHfF0LM3z8pY/jS+EBlNG0SneqfCnPICo6oYdNpjFCAgX
         3+LTU9f6qBMEsNy65qWhHGqZN+W6rvN22ENx8O73zTLhIAqdRY9ss2ce4lS2JvLfiKiu
         I9OcgDKifoWmwghYEuVPSll7rqqd2kSbkU3rauK6zWW8Xm9tpzvDhT1BsYXlhk2EgXFX
         GTrbkDHe0Ge3Rh/aWM8yAs1+inJ0MovwF7KHRegqzu96afU7A5Ov2Jc3Eg9+8qMzv8lE
         +wTQ==
X-Gm-Message-State: AOAM530FI2y8BccFS9MJRoWnDPGmwJLDFbuTV+9wWwNpBgZ603+WaVO5
	MiQrOGkW5lDeh7gFEVjuWGg5KQ==
X-Google-Smtp-Source: ABdhPJw/7Ill7A4265eIYd69boInRTSiHGf70wWUFN3LBV+X6SQSwUV7godvR6Cg2w2iSWw/9j9riQ==
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr6927401wrw.166.1613065882671;
        Thu, 11 Feb 2021 09:51:22 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:1f44:6379:818:1e61? ([2001:8b0:aba:5f3c:1f44:6379:818:1e61])
        by smtp.gmail.com with ESMTPSA id l1sm5988409wrp.40.2021.02.11.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 09:51:22 -0800 (PST)
Message-ID: <133107bffad3c5bbaab27aa1b2aa8a9a93778f2f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC-cargo-fetcher 0/3] Suggest a first step
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Andreas =?ISO-8859-1?Q?M=FCller?= <schnitzeltony@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com,
 ross.burton@arm.com,  Paul Barker <pbarker@konsulko.com>
Date: Thu, 11 Feb 2021 17:51:21 +0000
In-Reply-To: <20210207150147.31011-1-schnitzeltony@gmail.com>
References: <20210207150147.31011-1-schnitzeltony@gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2021-02-07 at 16:01 +0100, Andreas Müller wrote:
> This is a first version of a cargo fetcher. It mimics cargo fetch means
> it creates cargo cache in ${DL_DIR}/cargo. As mentioned in comments the
> proxy-thingy was stolen from npmsw for shrinkwrap files.
> 
> First approach was to parse Cargo.toml for projects that don't ship a
> Cargo.lock (crates for rustlibs should do this) but that was skipped:
> An unknown magic inside cargo detects which libs are avaiable: Blindly
> followin -> download explodedc [1]
> 
> As proof of concept I did (no meta-rust in layers to avoid surprises):
> 
> * add a simple cargo-fetch.bbclass to oe-core [2]
> * adapt a pure rust recipe 'spotifyd' to new fetcher [3-4]
> * moved console to source of spotifyd and did
>   > export CARGO_HOME="<DL_DIR>/cargo"
>   > export CARGO_TARGET_DIR="<B>"
>   > cargo build --frozen
>   --> project was build without issues
> 
> Please review carefully because I am aware that:
> 
> * my python could be better
> * the 'one cache for all in download area thingy' might cause issues I do not
>   see yet
> 
> Am also aware that this is not more than a first step. Once this makes it in,
> further TODOs are:
> 
> * Merge latest meta-rust -> oe-core (latest: There were some riscv adjustments
>   recently - and I am not sure if these are in the poky-contrib of Alex/Ross)
> * Add documentation / tests / devtool-support / ??
> 
> [1] https://github.com/schnitzeltony/mimic-cargo-fetcher/blob/master/test.py
> [2] https://github.com/schnitzeltony/openembedded-core/blob/cargo-fetcher/meta/classes/cargo-fetch.bbclass
> [3] https://github.com/schnitzeltony/meta-musicians/blob/cargo-fetcher/recipes-streaming/spotify/spotifyd.bb
> [4] https://github.com/schnitzeltony/meta-musicians/blob/cargo-fetcher/recipes-streaming/spotify/spotifyd/Cargo.lock


Thanks for putting this together. Out of interest how does it compare
to the code in meta-rust?

I'm hoping Paul Barker and Randy MacLeod can take a look at this as
they've done a lot more work in the area than I have.

Cheers,

Richard

