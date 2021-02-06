Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web09.10322.1612637018761132570
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 10:43:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gH8SMkyR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id 7so11865899wrz.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 10:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=FSQZgjAIK/K3dr6nyI8X0HfE+6WqiO1yeU76iCfExow=;
        b=gH8SMkyRLOgQy/d24klEcd5M7dwPjI7ysYdyoW9x1ugvkltxbcD2+ro+wreWqL0NfI
         NuSLlGUwF6ncOa1cHeBF784RL1YtZhxmecJcttCD5ZQTVoNiGORnI9uVaK+ryMgRENP3
         AFPetKpzsRBLqcFQBayL8UUW4K4JwVIas9jVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FSQZgjAIK/K3dr6nyI8X0HfE+6WqiO1yeU76iCfExow=;
        b=P2LWUUpfoE1IcBPvMn2792W3Y9MleW+LN8GJQQqEO5xyOlX2vYQ7SfHCT+iNTEHNIH
         vCkfCGcuexNBRLPbuR3R6EpEkAu63tfK13K7hxBP09TNC8FtRHH3uCrgKQBN2u3LHdsD
         sCAFelL3wfFUfnKiKzEVRVpRjJ/cp0QlC4Qg/AWjAQvnMdO5zMxwMzonVm9kGal+N7/0
         nykkaFbHU/TvGQz5grE1N78rOQTJZzGc4V81pjJD51n4bHXOGmJ1yvUIZdkGniswlcYL
         hxhC2I33MXZ20M4+e8DlaxbUpfg8o+/62AHrKIXLxqCnJPzsxiJO+pHNDZKssvdYe7p9
         rn9A==
X-Gm-Message-State: AOAM5302sAP05kLpFF9az0/eaAxQo0YNmazUXBdEmhCIFEctkLGNcLdX
	9UNbRSBVlHN2K5Zlrbs/yaxBpQ==
X-Google-Smtp-Source: ABdhPJy3S4HB6++KiIPEJcbP1SA+NXuhEAD/4FvbKef7ROLDkFe5Cn1F7/bodL6cyqvifhrv9ArkzQ==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr11157404wrw.379.1612637017263;
        Sat, 06 Feb 2021 10:43:37 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.config (5751ab90.skybroadband.com. [87.81.171.144])
        by smtp.gmail.com with ESMTPSA id c9sm12753398wmb.33.2021.02.06.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 10:43:36 -0800 (PST)
Message-ID: <aca5e0448eba4292867e1dbb76e68f75f2a90f9c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] event: Prevent bitbake from executing event handler for wrong multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 06 Feb 2021 18:43:35 +0000
In-Reply-To: <20210205182141.753810-1-tomasz.dziendzielski@gmail.com>
References: <20210205182141.753810-1-tomasz.dziendzielski@gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-02-05 at 19:21 +0100, Tomasz Dziendzielski wrote:
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
> I added a mc target name as a prefix to event handler name so there
> won't be two different handlers with the same name.
> 
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> 
> --- compared to previous patch I added mc prefix before putting to __BBHANDLERS, so hashes are not changed during the build and oe-selftest paseses
> ---
>  lib/bb/cookerdata.py | 5 ++++-
>  lib/bb/event.py      | 2 ++
>  lib/bb/parse/ast.py  | 7 ++++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)

This is doing better in testing but there is still a selftest failure
showing:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/1804

oe-selftest -r buildoptions.DiskMonTest.test_stoptask_behavior

should reproduce.

Cheers,

Richard

