Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web12.34104.1631014813327460167
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 04:40:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GVarpfjc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id m9so13980903wrb.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=xTIeI3Te7sQuMM874vrJouwMlagw+FfaG4hKh4WK9o0=;
        b=GVarpfjchSdcsFOF2vD6BHAP0QXENkj3vjq7J7CAtqMpTJk3fq35+/DVFf+LBS1IBQ
         3RGRm2STKAwpnFD1vS+aKidNiIvWL1isRgCRMntG+nJCbhMmueDkMXS1Oe6cfpGCO0Wf
         QVrzElqeDJebdUChoDQYRPHQhE8qjkckl8EU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xTIeI3Te7sQuMM874vrJouwMlagw+FfaG4hKh4WK9o0=;
        b=dpDT5M0P6qlhNkf4p7E/ZFKTUNwacxTLdN5YCOsoyq7++GeP7CAhttqUAV4Cyry7As
         Eo+Fr9x5LKz+WQj1OH313UiuIJvhzBEv0lNaOecHsCdd+hp5Z0scW5PpIZecCP054ZSC
         wd6aC8tgvzvLbsggy1AaEsxSHMMoJ/4qBjH8/sSbot/lqoEdWiC5tp9cdPZrdoCgqauz
         0JYt7lL+t4zhjLP9G8g9ytyrCX6ku/Bf/C/5M9g8Aonzf7HjB+fYWnZ+WVkdSvAhK4ir
         ZEw3T/1Q395wG7/XbCye/DbYishLtgdQxxLM+FIGp1f4S1/aze4E4hzbc0lVC9MsDhUr
         1ziQ==
X-Gm-Message-State: AOAM533rkkVxEBf5dUCo2ug/YO+hkqndpbiT+tjJmEiUJaJHWXxPSLAe
	gQBtZMD6uP5JGlrX83qrhaL5mA==
X-Google-Smtp-Source: ABdhPJxTtKEveSyaq5dZaX4u+eb4JCdPH3rhQLElhQ5wPQJ13wsZKSDjEyRLhvNqGsjZ40WXrU+58w==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr18311773wrw.390.1631014811786;
        Tue, 07 Sep 2021 04:40:11 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:7ba0:bddf:c938:8f16? ([2001:8b0:aba:5f3c:7ba0:bddf:c938:8f16])
        by smtp.gmail.com with ESMTPSA id r129sm2077437wmr.7.2021.09.07.04.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:40:11 -0700 (PDT)
Message-ID: <3ac3e69e0b3d7f0cbb25da58c450411b466259a7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 07 Sep 2021 12:40:07 +0100
In-Reply-To: <3199.1631004870582679813@lists.openembedded.org>
References: 
	<209f7a813b8003ad75e5edb9600f729a91abee7b.camel@linuxfoundation.org>
	 <3199.1631004870582679813@lists.openembedded.org>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-09-07 at 01:54 -0700, Damian Wrobel wrote:
> On Sat, Sep 4, 2021 at 09:54 AM, Richard Purdie wrote:
> > Adding a single keyword every six months to show the layer is active and
> > meant
> > to work with a new release is not in my view a huge maintenance burden
> > compared
> > to showing that the layer is actively maintained and clearly showing which
> > combinations are meant to work.
>
> It's not feasible because if the layer required some extra bbclasses cherry-
> picked to be support it in the older yocto, then no one can simply add this
> keyword to mark it's supported with older yocto.

I don't understand your example here. If you can cherry-pick changes into a
layer, you can also add a patch to mark the layer as supported using the
standard variables?

> This in practise means that despite the layer itself didn't require any
> changes to be supported in older yocto it will be unconditionally rejected by
> bitbake.

Your previous sentence says "the layer required some extra bbclasses" so it did
need changes?

> So, in reality it mean that such a layer has to be forked and modified to be
> accepted by bitbake.
> 
> I hope this clearly shows why this kind of checking in bitbake is
> inappropriate.

I'm afraid I don't understand your example.

Cheers,

Richard

