Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.2867.1597097305374711586
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2020 15:08:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MdQqsbBg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id k20so961945wmi.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Aug 2020 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=kY5LAXx4Sk3rsNu763g/XmwYF6fWpSHSw4Ft/WE7cFA=;
        b=MdQqsbBgqj3EAC4PAUFS7WOxFsHjosoYWSIrm2bWNT7U2+L4RHFc9nxz9jPVEFPSfR
         duGaZHnW2SryuZTan5hm5mL9X3uhiVFhUiTy1D+/fNIlPWvEpJnu6MHCua5o4Sxg18k/
         l4kI613j02xt3sR5DBgvKtaOlyDLFsD85BDa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kY5LAXx4Sk3rsNu763g/XmwYF6fWpSHSw4Ft/WE7cFA=;
        b=dzYunvoWHIEzm4cjaQL56oA6TznaUzDP2hGqDQ6mEz8tGuhyIwLMSAunRAg4/8s/Af
         VpfyI4MaKaRzoQ2SrzVFR2DURqrase7UVPT7lVYu3iH0aQM/0BvhyxrL2mHj7+dLV7m3
         oguXE06sNE0ByS9f11Sj+Rs95MUK88Kxo4rzevt/40ibqGPZu3XV7IrUkoN1SxI4UW90
         6rFwzag2w3WkDV1RvsxFsP89ekpOgwXu26V505z1+Ce0YKTtV5v2nlmqp8zbK0jqh0wG
         H5UXpS/H6+QimCrfcCe2HKK98PWaEVJIXVaI83KKmMpujutKo84qJU0mudTrwdmFfbKM
         lmjA==
X-Gm-Message-State: AOAM532rA69+ld3yc0gSgkE5A2Cwo1awUEoeu3e/V3r5Oi1BP4Ak0f1X
	rbHn5TQHx8wPNZqky01zKpKX9g==
X-Google-Smtp-Source: ABdhPJywQl8cwsO27VfpHXWFIu5Z3bAQM4AwEjOeKQtUS39Bh8dKsqUlBOfKAU/xYh9A0bCPZ324mQ==
X-Received: by 2002:a1c:bc54:: with SMTP id m81mr1193901wmf.73.1597097303834;
        Mon, 10 Aug 2020 15:08:23 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from b.1.8.7.e.c.7.c.b.7.0.b.c.1.9.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (b.1.8.7.e.c.7.c.b.7.0.b.c.1.9.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:291c:b07b:c7ce:781b])
        by smtp.gmail.com with ESMTPSA id j5sm1646654wma.45.2020.08.10.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:08:23 -0700 (PDT)
Message-ID: <7175d431218ff97c0c28fdaf40c89685feeb2f9f.camel@linuxfoundation.org>
Subject: Re: [PATCH v3 0/4] [RFC] Shell func backtracing
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Chris Laplante <chris.laplante@agilent.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2020 23:08:20 +0100
In-Reply-To: <20200810165524.37417-1-chris.laplante@agilent.com>
References: <20200810165524.37417-1-chris.laplante@agilent.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-08-10 at 12:55 -0400, Chris Laplante wrote:
> v1: .run script backtrace
> v2: add metadata-relative backtracing
> v3: fix dash syntax errors; ShellCheck warnings
> 
> This patch series lacks commit 9747211c (data: emit filename/lineno
> information for shell functions) since it has already been pushed
> to master.
> 
> Chris Laplante (4):
>   build: print a backtrace when a Bash shell function fails
>   build: print a backtrace with the original metadata locations of
> Bash
>     shell funcs
>   build: add back the Bash EXIT trap to handle cases that ERR doesn't
>   build: fix shell trap syntax errors in dash; ShellCheck warnings
> 
>  lib/bb/build.py   | 116 +++++++++++++++++++++++++++++++++++++++++---
> --
>  lib/bb/process.py |   3 +-
>  2 files changed, 107 insertions(+), 12 deletions(-)

I suspect but have not proven that this series resulted in the failures
in this build:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1247

Cheers,

Richard


