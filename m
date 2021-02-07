Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.18704.1612693978350940499
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Feb 2021 02:32:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VHTNGRVd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id c12so13499899wrc.7
        for <bitbake-devel@lists.openembedded.org>; Sun, 07 Feb 2021 02:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=5Lf3uvgQKFweUtXh0FUUbAE86shUJRpXiuF35ibBf3M=;
        b=VHTNGRVdIF6hbrvoGniG9HKMGDCg/Nz6/ZDBPEhFiAl3/B/oSA2eXyMEz3IQ49ymuK
         6OKmVgUPEIIM3FB7IyjPnzXvu0SkndF9i3UPoOnOCF8QGDXvMqnTEikkYRVdIOb6TqYF
         xLW6vr2BZB0uE7i31idrXStvZv9VXXdcIYEzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5Lf3uvgQKFweUtXh0FUUbAE86shUJRpXiuF35ibBf3M=;
        b=t6p8wKwhdnlmMe97c+N62wwwwB3DPOJAs3v3jO2K7sOp0nF3VLN10h6nmkRjiziuUw
         VTUXUa6fRGceTOdzTGF00S5T9FWmXMnychondGGCo+R/Ij5of0rP0yAsWGJJvrEmm8AQ
         iSHH00BEvMmZy0RiT1ZqyDZoXqixvZkBxbzi9prjkquZPPNiqk8IuHaJHZ4avw/2QMlR
         Gy4XJe0U0WY+8N5tqo8TPlKhpMA3kjBNczND/AgS12xWoT9heIzicgb0q3HWEoHzY1rA
         kectyW76S5TVSH7bLhSxwnpfUvvhVSBFF/g9r8Z6mjOpsxVsxenjThgLC3bjAoNvMEdw
         R1xg==
X-Gm-Message-State: AOAM531bU4MYR9zBsEHkCw5WVkBphjhsynCIRz0K/0bk6Gr33xOcEBBZ
	C1BXEUkdzibIR25yTPWqC3qmbA==
X-Google-Smtp-Source: ABdhPJznauqSE1hKk3ugu48aD503dhA9RZVmGKqa3RgUajiHcJcrV+0nLNIzUjbtE31EJdUDfdPrcA==
X-Received: by 2002:a5d:4391:: with SMTP id i17mr14360641wrq.57.1612693976869;
        Sun, 07 Feb 2021 02:32:56 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:b3bf:bbb5:4fd5:d8e3? ([2001:8b0:aba:5f3c:b3bf:bbb5:4fd5:d8e3])
        by smtp.gmail.com with ESMTPSA id 2sm2931299wre.24.2021.02.07.02.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 02:32:56 -0800 (PST)
Message-ID: <28ad5643e356d5a2278f6d1aae24b6278f5ec5b6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] event: Prevent bitbake from executing event handler for wrong multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 07 Feb 2021 10:32:49 +0000
In-Reply-To: <20210206214034.295239-1-tomasz.dziendzielski@gmail.com>
References: <20210206214034.295239-1-tomasz.dziendzielski@gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2021-02-06 at 22:40 +0100, Tomasz Dziendzielski wrote:
> When multiconfig is used bitbake might try to run events that don't
> exist for specific mc target. In cooker.py we pass
> `self.databuilder.mcdata[mc]` data that contains names of events'
> handlers per mc target, but fire_class_handlers uses global _handlers
> variable that is created during parsing of all the targets.
> 
> This leads to a problem where bitbake runs event handler that don't
> exist for a target or even overrides them - if multiple targets use
> event handler with the same name but different code then only one
> version will be executed for all targets.
> 
> See [YOCTO #13071] for detailed bug information.
> 
> Add mc target name as a prefix to event handler name so there
> won't be two different handlers with the same name.
> 
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> 
> --- v2 compared to previous patch I added mc prefix before putting to __BBHANDLERS, so hashes are not changed during the build and oe-selftest paseses
> --- v3 fix for test_stoptask_behavior, _bb_diskmonitor handler is an exception that is not created during parsing and was not added to __BBHANDLERS where I check if a handler should be executed. In this change I add it manually, so it is detected and executed
> ---
>  lib/bb/cookerdata.py | 5 ++++-
>  lib/bb/event.py      | 2 ++
>  lib/bb/parse/ast.py  | 7 ++++++-
>  lib/bb/runqueue.py   | 3 +++
>  4 files changed, 15 insertions(+), 2 deletions(-)

This seemed to trigger a different problem, seen in a few different
builds/tests:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1831

Cheers,

Richard

