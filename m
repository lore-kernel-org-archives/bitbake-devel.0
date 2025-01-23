Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2218C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 05:53:28 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.5385.1737611600486054618
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 21:53:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D11Yk9xJ;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e1a41935c3so9444606d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 21:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737611599; x=1738216399; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7Sy/jXLrImegGGoz/fiI0quWE/8Q5BLfW4t4ckAIlA=;
        b=D11Yk9xJB57Xee30xI2mK3eP1kdzB6LImI0XZ8sSTXnjwXWf6ryiPQyIW2t5U4flDE
         li/low1pBk42xhxMEf76DdDqVx2HVXzXtpeEXMV/qxpcHSrXefmHtmwzp1IQV7p5ZwGF
         AcaZEs9F6Ympn5ruU/ySv03vM1gxZdVRMDSEE2dXn92jvRad5fOx7LJmmcVjIJYYLL2a
         vkc+QxEdq+cVl6/Dd+zXsfRpHvo554loWP22QedJxY3jKAAgAo/4K8LOM03VuOHBq3hi
         YEsCS+WClGom+NCxuDcNz0et4viDkGwBmWu1pgNZI48kiojbJJWOCuJAinDgumspkuGX
         +m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737611599; x=1738216399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7Sy/jXLrImegGGoz/fiI0quWE/8Q5BLfW4t4ckAIlA=;
        b=ilseW/OcUM8Ceom+7Uwn7w8FtHu1pyVppn+S0PrGKZGggz50PcHCXtSSieRAqJ4l/X
         14eQNxMCsZ4culk/7Qb0Wegu3Ft7heInfpwhPHhiXmOfJo/6lamScIOGu+VuwG2uNAL3
         TFW0hFmbjTpgw8+NzltfTehG7WflwkfAp3F8Z/ffJuIR4rORYoCNdG8iRnl+uSynHPt7
         fy9IY/4+CvsrfYvebTNpePoUj+YM5lFe5XdTGgaBqlc3JQtzqrOwkNqz4g0GATlBjnfG
         NbKXuVGLONhQ+razVSMNpIUDCPxY0brUDMkhWNymvbVsi0uSmkVS5UYYpi3uUyh/7LIT
         0qlg==
X-Gm-Message-State: AOJu0YxftxoHdvEZYtcuAO8Bfar45OmI8gH64sIAO3zl72Cw4yFuvvy2
	SNOXjWj70TltcbDrqcBqq2BOw0F1NTsYzUAYMToLsOVEDz5x4IYMQBZLcfyPxM5We5yhBrfMWPV
	a1ZU1fWPPOlQ1b1VP9swcnMXhh4E=
X-Gm-Gg: ASbGnctWz2p8NInV9I5mGV1LQyvc7RKZrDcWgGs9naOIBFjBRkK/IaJsOuW4A8+qwaL
	BzJW7utM4F9JIY33MK9rO0xBnzauF69sCXdWN3vOxKAu3fA/TdD+sldDiPI4cBiR1cwDUSCWtLU
	RtoRl09Znkz3/6MP/788UY
X-Google-Smtp-Source: AGHT+IGnqWWP0ArookTPvQ7bSBdydvoiSgIIj3kymHYD6JNuB8sdq9IhDyk/Q6nOA4U6ePBAM/ywUjLkdqFQf09aIQg=
X-Received: by 2002:ad4:576f:0:b0:6d4:dae:6250 with SMTP id
 6a1803df08f44-6e1b220a4c0mr383002456d6.34.1737611599512; Wed, 22 Jan 2025
 21:53:19 -0800 (PST)
MIME-Version: 1.0
References: <181B8041053EB73B.1562@lists.openembedded.org> <CANNYZj_7L03Tp9c=Ps1KAmvWW4=5_9LEVOCyh88FfUbs8GxfKA@mail.gmail.com>
 <CAB=6tBQvfC-+fZGPeqO7tDsNQj88OFgOrXe5YXC=EWqs+x0jEg@mail.gmail.com>
In-Reply-To: <CAB=6tBQvfC-+fZGPeqO7tDsNQj88OFgOrXe5YXC=EWqs+x0jEg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 23 Jan 2025 06:53:08 +0100
X-Gm-Features: AWEUYZn9CHrU2JQ5r_C4ln1rdVDogADo3Mj95f9tauO4X7jm4P-mokuzLTLZQvY
Message-ID: <CANNYZj-jf-v0w+zV3R9=EJVOpRiF8JYNfxJCs3B2MXFtW-gzTQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 1/2] bitbake-setup: add the proof of
 concept implementation
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 05:53:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17066

On Thu, 23 Jan 2025 at 06:12, Chuck Wolber <chuckwolber@gmail.com> wrote:
>> After some consideration I've concluded that placing the bitbake-setup
>> tool configuration and caches into hardcoded ~/.bitbake-setup/ is not
>> the best idea. Rather, the tool should write and read everything using
>> a 'top level' directory, which can be set via command line switch,
>> environment variable, or a default of ~/bitbake-builds/, in that
>> priority order.
>
>
> Agreed on the command line switch. But what about making ~/.config/bitbake the default
> and falling back to $XDG_CONFIG_HOME/bitbake as a secondary default? That would be
> closer to what is considered "standard" behavior and probably make it easier to manage in
> the long run.

This would still allow only a single tool config per user. This config
has things like location of the build configuration repository, or
where to cache downloads, and possibly other things in the future.
It's better to allow multiple configs, one per top level build
directory. One can conceivably want to use multiple such repositories,
or have different DL_DIRs for different things.

E.g. like this:

alex@Zen2:/srv/work/alex/bitbake/bin$ cat
/home/alex/bitbake-builds/bitbake-setup.conf

[default]
registry = git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main
dl-dir = /home/alex/bitbake-builds/.bitbake-setup-downloads

Alex

