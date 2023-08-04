Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C0C001DE
	for <webhook@archiver.kernel.org>; Fri,  4 Aug 2023 16:04:57 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.1124.1691165090369367524
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Aug 2023 09:04:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=g6JH5Igu;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9b6e943ebso41486101fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Aug 2023 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691165088; x=1691769888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LfR9FdnIvC2UOr+jDJtKWPZ9rh1gvI5iNL1Ph6VahXs=;
        b=g6JH5IguFIGE0OUcZ6v1HngoJt2LW8qUwD2kC4OMp57ZmqCHYC1hIehL80PrK6r9kF
         FSnZgY1zY4xs+zctbNK6bIB3bHVzRNT7Ta4bN0WnDpFrK4s1k0T4bbw7ixC4DSIqnP4I
         QfQ9ppRpbtO4TkJ80Zq9IBrlEEAG9K4rSEYeFuwnfr98BJ3jikdFdzMWCY/Jf+bJJhR+
         myg1cpBAD9qX3OeYcFhntd6dVcBA/Vl9kxBMLETTaQBlqIyvTbKSQhs2xlrWBDe13H7g
         e35RLyJ4MuqC4P+lecs17Kql69/TM4VrMEpqL0K08GNtpqV96VeWpACyFBiWrL8m2vds
         4lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165088; x=1691769888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfR9FdnIvC2UOr+jDJtKWPZ9rh1gvI5iNL1Ph6VahXs=;
        b=D1ELbYCPp4Yq/o2BD64v0RMzVKSsuGN7jCG4nU9cX4If+vD8d+dCoryVtbQNMM1l3W
         to9eV4l/2xIP7Y8/FuSEBXOcGP/qA1NLmsrPjrCFOKG2LCz+eJgD9fpyOAI6TsFCkz8K
         fWvBFNsy45bh6dojE7PTM91O15apYyHIItS07hngQJdD27HSycF0OU7fB02lduGGr+UM
         Bpu6aTqcXnU1wSoxnDtmUJGvpJvLtYpScwqYmpnQ67fiVxAviahbwlmuSgAy8j/uV1iz
         brFDsqAoS2m4ZV5qg/+UIVr6EBA/lnjkiraC3ZndS0aC1JjUZKMvMnAuPEPpQm/t5s7e
         jhLw==
X-Gm-Message-State: AOJu0YwSpRfCUoMiQfTKuKNSUKwY7LRxBkISaULEqKcmOusdmrWPIUv7
	60McX4ipW/AoNdAwjVdYog+CUTVBcHVBfvA4S5A=
X-Google-Smtp-Source: AGHT+IFm1tufOCX9gMk8NCZn8f2wmFVOC/ykvzQfnX+GcgFeFEes4gWHC3RSWErXESHGjuiAPeG+9j01PlFb/c4IW4E=
X-Received: by 2002:a05:6512:ea3:b0:4fd:daa0:aed8 with SMTP id
 bi35-20020a0565120ea300b004fddaa0aed8mr35387lfb.4.1691165088191; Fri, 04 Aug
 2023 09:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230803114210.604-1-jermain.horsman@nedap.com>
In-Reply-To: <20230803114210.604-1-jermain.horsman@nedap.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 4 Aug 2023 18:04:37 +0200
Message-ID: <CANNYZj_K_Jz9RqC22yoJJy00d-2cMuGW4A6OuU=pSCFwSt2qAw@mail.gmail.com>
Subject: Re: [kirkstone][2.0][PATCH] bitbake-layers: initialize tinfoil before
 registering command line arguments
To: jermain.horsman@nedap.com
Cc: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Aug 2023 16:04:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14916

This has landed in kirkstone, thanks.

Looking at the mixin repo, the problematic piece for backporting to
kirkstone directly would be meta/lib/oe/buildcfg.py. Backporting that
with all the other changes across the tree is rather invasive, and
makes it ineligible. The rest is self-contained and independent.

Alex

On Thu, 3 Aug 2023 at 13:43, <jhatnedap@gmail.com> wrote:
>
> From: Alexander Kanavin <alex.kanavin@gmail.com>
>
> Plugins may want to use it (e.g. the layers-setup plugin that would
> want to discover writer sub-plugins with it), and so it makes sense
> to make tinfoil available a bit eariler.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 2f6c7523a622f59ddf84a1a196927492bc5fa7a2)
> Signed-off-by: Jermain Horsman <jermain.horsman@nedap.com>
> ---
>
>
> The layers-setup plugin that has been added to the Yocto Project
> recently is unfortunately not available on the latest LTS (kirkstone).
>
> After a discussion with Alex about this, I set up a mixin layer to
> enable this functionality, however this commit is required to get it
> working.
> Normally LTS releases would not get new functionality, but I think
> this commit is fairly minimal and would allow for a valuable addition.
>
> If people want to try and test this I have published the mixin layer:
> https://github.com/nedap/meta-nedap-mixins
>
>
>
>  bin/bitbake-layers | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bin/bitbake-layers b/bin/bitbake-layers
> index 449434d4..d4b1d1aa 100755
> --- a/bin/bitbake-layers
> +++ b/bin/bitbake-layers
> @@ -68,11 +68,11 @@ def main():
>
>          registered = False
>          for plugin in plugins:
> +            if hasattr(plugin, 'tinfoil_init'):
> +                plugin.tinfoil_init(tinfoil)
>              if hasattr(plugin, 'register_commands'):
>                  registered = True
>                  plugin.register_commands(subparsers)
> -            if hasattr(plugin, 'tinfoil_init'):
> -                plugin.tinfoil_init(tinfoil)
>
>          if not registered:
>              logger.error("No commands registered - missing plugins?")
> --
> 2.41.0.windows.1
>

