Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB3ACAC5B8
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 15:16:23 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.19920.1758899774507585797
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Sep 2025 08:16:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BmfO0G/M;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78f58f4230cso17669026d6.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Sep 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758899773; x=1759504573; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2eIJclW+njugfd01Ghh9oKQ0yqs52HIFDlSpeiZpvcw=;
        b=BmfO0G/MKUWxWJ+KSlw3x9Zc+vO9ajEnr7SZD0FMMyXpebBGZAlR7k9/nrZf5Pc/nE
         txWpK7vHSHFGQ3evmHjw2SggL2BHfiARCnMpLMlGf82F4wdGulQ8xjYT2G2SHYI67UCa
         9qhfsjDwh6RjH77Dmc5LdYQmwVV/CbZHI403KmOb9lDVlVu2uDCQU5WBAxHc3i+LB8CJ
         kP0Ertn7t3WBAvhnrx9OJ5a5WreKFZ/mgmztUtvfvzFdyKqGf2IhAd0mzvKlo+TT1WUb
         Ux9koTQllkyE92km4aIFE2HNzME8Gz95CsmjbGnxd+I5dFIRTxHrdoDABG10IgJVidvx
         aZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899773; x=1759504573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eIJclW+njugfd01Ghh9oKQ0yqs52HIFDlSpeiZpvcw=;
        b=WdldJY8qdFNJs7a3oCblLH+uwNA1Em5AwywXhHKE8jvkYiBQAVswSqoxeINko6h5FJ
         lSbtPXYWh90ctNyjOk5sbmcXRcRwEdDhqPJHzS8rrxhkHcs9vMdx+mYih7w3MqlZPJ0l
         w3+lU7LsS4mReKSHh5R8VUVyCFIJ2Tew1dPHB7c+MdO7UjXOkUXXT7rqviYvFJ0b5Rby
         3WN78I7wKsE9Ng9Hm7FxgNCSyVrEdjWHXBr2WR0HPaDkagM8rtoerG+nWQ3aWdFI7N2f
         TETDKvMeI4Sa3EIP1dyHyHAXkLaGnsDcJR8Nqsp4Fsm/QCV9Duky5xIUa/GzVoBYaKIO
         b3LA==
X-Gm-Message-State: AOJu0YxC3MjzowybL2ph8fGgYnEAmnydA4Ggu54Obi/KWstgtTa+eU/4
	sTgdLUGxAlk0eWLWIO+lQcLrYC4RYR58f68LAc6III2ZyWb84uvkf4QW/gNmRpQAFRSVtgduXD3
	UFWnDNJZixRG4Mgl2n46WDN7qGm/iJK0=
X-Gm-Gg: ASbGncv8RPYyivXZmfFJyfzJZQe0sX0hPNBbPtw+78QFiID7ZPh2BPuh64UlafCcr/K
	ysR6JfJfhCHwY5qaLaT2zepbFztdjNBJ4WDYRT1sm/wOoFbTnp/dO/W/Wa91RyxrSHqEmJALnrk
	1AVXKN0rlwcV3lyWXmf80PhpzyyfPJEnn36wgk31hWtcus6/iSQ3GV6ZjgDwzkZfz9Y+XtJzytv
	sWQNcqLxj/xh2LBuCnrRGEzDi/d/D7kjuo0lVOG9AHsQirgtwS0tIqKdA10Ow0oPqk0SU8Dj+Uh
	lK30k1SOdMQh2GlKOiQGV+jzblri4xIVz3xWkFNXMKsQaDj3H8E=
X-Google-Smtp-Source: AGHT+IFfC/K5KqLiytWhAiHdzT0TDUn8QbNMkhu7UFoqm1cZZeeSOGOboivxcW6y9gqDRrFmJfm6f9Om0+/OlaEixpk=
X-Received: by 2002:a05:6214:3d9c:b0:804:6a87:c9dd with SMTP id
 6a1803df08f44-8046a87cacdmr77470386d6.5.1758899772848; Fri, 26 Sep 2025
 08:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250922092731.1993813-1-alex.kanavin@gmail.com> <5849b9f23a3782c7a4b4eb32a6797454336ffcae.camel@linuxfoundation.org>
In-Reply-To: <5849b9f23a3782c7a4b4eb32a6797454336ffcae.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 26 Sep 2025 17:16:01 +0200
X-Gm-Features: AS18NWB1r_8_kQxs8nG8OBeUXUIWPuOZpe77sBmdOS6fTlQYL3d6AkI7k1f-WSg
Message-ID: <CANNYZj8rP-QDE6LUnARXaLCogOSqxPExzVOKSDptZNPDEzvDgw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: add the initial implementation
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Sep 2025 15:16:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18096

On Fri, 26 Sept 2025 at 16:23, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> I know Alex has told me the "nobranch" approach was by design however I
> can now demonstrate why this is sub-optimal. The reason being that if
> the branches aren't used in the fetcher, the build can't work out which
> branch it is on. In general that isn't a problem but there are two
> cases where it is:
>
> a) the autobuilder was querying branch information to report back to
> the UI. This could be done differnetly.
>
> b) the summary output at the start of the build. This is a usability
> issue if not fixed.
>
> A bitbake-setup driven build prints data like this:
>
> Build Configuration:
> BB_VERSION           = "2.15.2"
> BUILD_SYS            = "x86_64-linux"
> NATIVELSBSTRING      = "ubuntu-24.04"
> TARGET_SYS           = "aarch64-poky-linux"
> MACHINE              = "qemuarm64"
> DISTRO               = "poky"
> DISTRO_VERSION       = "5.2.99+snapshot-07747aa7390e98bf2853154e5fd473e4984a1d3d"
> TUNE_FEATURES        = "aarch64 crc cortexa57"
> TARGET_FPU           = ""
> meta                 = "HEAD:07747aa7390e98bf2853154e5fd473e4984a1d3d"
> meta-yocto-bsp
> meta-poky            = "HEAD:db24e48498b2d40131b871f6eafeb7a67da343f0"
>
> and I'd much prefer we didn't have HEAD in there but show the actual branch.
>
> Could we improve this?

Yes, I think so. 'nobranch' was simply the quickest and easiest way to
convince the git fetcher to do a checkout when all you have is a
revision. I need to think for a bit and do experiments, but I'll come
up with a way to specify branches in configs and passing them to the
fetcher.

Alex

