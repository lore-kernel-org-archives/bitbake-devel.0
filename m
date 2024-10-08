Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43313CFA757
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 09:01:50 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.4532.1728378106235940748
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 02:01:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CIZsG/5Q;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53991d05416so6510943e87.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728378104; x=1728982904; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3aTkjmbY9Nu40VHbykpoVumc6OhlFXTNqVDVd8WXHE=;
        b=CIZsG/5Q2R0CyBArslY1X/d/tf36AMHog4M13uCNyzv2gAl7aqvsXhnn5UNis3ijVd
         ji5UR8+NeZglh3QTHGxT55ndtX5qQZUzSTkswyRathtFF1f882oUKscSHCRrMwX1EI4U
         N3P0b7CElsBaSUPli1nV4KZrbjX+ry39ApQ0dGZib68UaDUPNaoKmi9bUbzI08XNvX9k
         gll8vRAJz6r5AsPL5AZ7AGzzj0rsdkvlGTnq9EBbWPI+TyiCa9D/+5ruG3p3ZBF4Zltw
         rjhpZpKZGemG+B12fTI0CJy9NAXvTwLCJ2jiyndOYyGFFp9QM5q+dOB2wpnA7oWc20MY
         hAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378104; x=1728982904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3aTkjmbY9Nu40VHbykpoVumc6OhlFXTNqVDVd8WXHE=;
        b=wOCKOmzTgQkkU5GIsMB7pt+ZVtrAmmBy694enEuKzCzVNePpcKh2hJE+nREHRuNsZS
         O4XE6O2QHVyd6VP4LvNwcTdn2yJNtj07PyFa8DLsZZ73d6cDLm3nKaM3L5LGbEbZoWvu
         TNor1K791S+xhUwpXEfsn+Xak9i3MhVPsG0fBNG03JeLjDIsZY2McyvcfyUwaCT+Mx+r
         bjSGsyTyj7rnGAQOh5kvjTSK32mUefh6UuktjpCwTGyD8tj+m+c5rYazMrlsA4yfshBA
         Zer0mqBsJLM7a1Uye/Yqvd3XdWRhsMbAuCNOhaczvRBWB19ICr7WbBcbcsX3n8frg/RG
         G27Q==
X-Gm-Message-State: AOJu0YyHKOvDkpsJuTkOjUGvDpcQm90DrYFXuIWaCfa857hYrrmR5adu
	De3rPjvtFj7BGjxkQciC9U0OQuOb1e4TJ52VL9O6JiJybGO0YuBnpZl7QjNhwOf145gCbpsNXVA
	G6Ymsa5dT9J0EK5u/ArrcV6K6XBSAoGbw
X-Google-Smtp-Source: AGHT+IG1c0jCPcR+t6rTyGeaXMrG7iSqxlJiKrTz1QHP8BIbGssHhn610Q5FcdSOWjJY8ozDbuRuxF5UyZxprcOxBeM=
X-Received: by 2002:a05:6512:1256:b0:536:741a:6bc5 with SMTP id
 2adb3069b0e04-539ab84e0ebmr8127059e87.12.1728378104015; Tue, 08 Oct 2024
 02:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj9B2LV2ZH1VivrwdfH1T2FJTV1FU9MV3X+TwWcDCUqtFw@mail.gmail.com>
 <17710.1728337442729823697@lists.openembedded.org>
In-Reply-To: <17710.1728337442729823697@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 8 Oct 2024 11:01:32 +0200
Message-ID: <CANNYZj9+CLT81zNGCw8nTZAZa-1BPMn5UYjy3hUuAUDGGs0_ZA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: add GitHub Codespaces support
To: git@oliver-kaestner.de
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 09:01:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16653

On Mon, 7 Oct 2024 at 23:44, Oliver K=C3=A4stner via lists.openembedded.org
<git=3Doliver-kaestner.de@lists.openembedded.org> wrote:
> GitHub Codespaces use a Git credential helper that provides access to
> authorized private GitHub repos. To do this, it requires access to the
> `GITHUB_TOKEN` env var, so add it to FETCH_EXPORT_VARS.
>
> Which fetcher would be using this environment variable? Presumably it
> would be picked up by some external executable run by one of the
> fetchers, which one is that?
>
> Alex
>
> You're right, it's the git fetcher calling the host system's git executab=
le, which uses the configured `credential.helper=3D/.codespaces/bin/gitcred=
ential_github.sh`. This script only contains:
>
> #!/bin/sh
> echo protocol=3Dhttps
> echo host=3Dgithub.com
> echo path=3D
> echo username=3DPersonalAccessToken
> echo password=3D$GITHUB_TOKEN
>
> That's why we need to retain the GITHUB_TOKEN env var.

Thanks, where is this gitcredential_github.sh coming from though? Is
it an official script maintained by github? Where? I don't see it in I
don't see it in https://git-scm.com/doc/credential-helpers

If you can find the link, and place it into the commit message and/or
comment in the code, then we'd be able to track down actual usage of
the variable in the future when needed.

Alex

