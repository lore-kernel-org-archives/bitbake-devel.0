Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41919C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 18:26:39 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.3097.1720549591270739620
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jul 2024 11:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lokji1Xq;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so73070341fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720549589; x=1721154389; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlbhOn8aX5UOT9FI0shAxq7HBOSFITQzsLpUni1aX1o=;
        b=lokji1XqwfkgxTM0KL/4jh2WuruHAhRhnKGNl3ugJuKSVna7nrWC2PrbGHIE39rSUq
         KzHzQPbP/WQIQMXc/70jXUk0Lc0Lfo4zEa6hiHqxKJNUySTG7J5RPfzMfKGCeODi6vHq
         8RcY4N9g6IAoeXlh/7Zdcj1aw6kPGcEWiQYjAVLaHTa9J++J89uQXS/jAC2BhNYVPth8
         xIWjT9S6enCUVYOqWcqAMmAfSjVpeSioqt/c2scsPrRdc+CNkWFaVPiCzlVmVL6Lf3vk
         2XlIYotac9zTkT0Uk/E6eli531QGbHQ0SH9reggMmmLDEFnrbSJeKFV37PNUqyF1VFV6
         zsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720549589; x=1721154389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlbhOn8aX5UOT9FI0shAxq7HBOSFITQzsLpUni1aX1o=;
        b=fCE0p4vBhgrd5bZ5DYGskqCXZXf/HN2Fwn/uSHgxAsdCXpZuC259BufY7LTj6c6Nh6
         XAa9KnNun9JZ4Lqr03Ss849FG7LoENnZ44xnKQCEX+HRQPZ03IL2Rtcrq5rsqEP5ov1z
         turA1W1JhZyMw4hHBZKLQbET3ZxpJ/piY54IKkTruSGKdN0Vn/I5Ig359fsi12l7qBxf
         RlbhZj/tAy47vK0gu3OwJ2BsmEZNipd6ZE1zm8pBb4r3kuDm/BvydKpovMa92vNaScLd
         4wJLQo85oPZD87tlzulZJxS4UC2iepxiqfx6gC9d5jBqYVWGniwofbA2NWtMWGPXUGor
         Iznw==
X-Gm-Message-State: AOJu0Yz5T4DZK8QgCcPOByybMzuOUEo7OY6zPnS7xMMdi1BDIQG1Xsh+
	UQgnx9Tpy71CqKF+W9d9+/nopxHCUAbe/Lb8/6tQzvShUPmHgiPgc9N31tSOgSWVDKMY+hglwhu
	lEGionGDGsL7A/QBIrp7yKZHnsLY=
X-Google-Smtp-Source: AGHT+IGVx5tJ5DpbSAuR/8lxfYEkVvJjVlj+DTbzQlhzFHoVlS/ZOveRlp5E+1y4QpwD27Eu96DVfS6y9h7CA0SB7Y4=
X-Received: by 2002:a2e:2e10:0:b0:2ee:7255:5048 with SMTP id
 38308e7fff4ca-2eeb319872dmr22754951fa.48.1720549589126; Tue, 09 Jul 2024
 11:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240709182057.141231-2-wavexx@thregr.org>
In-Reply-To: <20240709182057.141231-2-wavexx@thregr.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Jul 2024 20:26:17 +0200
Message-ID: <CANNYZj8zZNAwgdA3C1yxesKLX=seZ7FiUWrRHxM7n8_Sm7pLOQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Sanitize git configuration
To: wavexx@thregr.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 18:26:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16410

Sorry, no. We explicitly allow git to use the system and user
configuration, and there are use cases where it's the only way to make
it work in certain environments.

Alex

On Tue, 9 Jul 2024 at 20:21, Yuri D'Elia via lists.openembedded.org
<wavexx=thregr.org@lists.openembedded.org> wrote:
>
> Prevent loading the local and system configuration by default.
>
> This prevents clone from failing if, for example, the user has set a
> different clone.defaultRemoteName (which git still honours from the HOME
> directory) whereas the fetcher expects the default remote to be
> "origin".
>
> Instead of overriding unsafe values (which might break unexpectedly),
> always start with a stock config.
> ---
>  lib/bb/fetch2/git.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index c7ff769fd..1ea000b3a 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -262,7 +262,7 @@ class Git(FetchMethod):
>              for name in ud.names:
>                  ud.unresolvedrev[name] = 'HEAD'
>
> -        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all"
> +        ud.basecmd = d.getVar("FETCHCMD_git") or "GIT_CONFIG_GLOBAL=/dev/null git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all"
>
>          write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
>          ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
> --
> 2.45.2
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16409): https://lists.openembedded.org/g/bitbake-devel/message/16409
> Mute This Topic: https://lists.openembedded.org/mt/107127802/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

