Return-Path: <giancarlo.cicellyn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ABDC5DF6D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 10:09:34 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3819.1787134174342125229
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 03:09:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=tCH6aH72;
 spf=pass (domain: gmail.com, ip: 209.85.161.53, mailfrom: giancarlo.cicellyn@gmail.com)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b13496112cso694441eaf.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 03:09:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787134173; cv=none;
        d=google.com; s=arc-20260327;
        b=ZWYbqFNzeQCuSq45PMacuRG8WTOInWvahHX+Bs/clcZWYMt5qsT4+nsUb4BilTJLbo
         vVtU27aGaO5tzgCZ3SWEcPC94H3eKGzYNHoMmCuA01LnzvGxov9XWW+2sinJxJYKHF0k
         SUNw8cygGHWgdOy2H/qoUYFvIFukKRyzubpTPabcIzbxgAlBRrMb6EdmccOPpotgCBSh
         l7eC3D+MaW8uEYCqmp+jYJwNCYtLWOmVrTz9ZV/kdjRY6f7mUTaj+n2BUmIPUdoH4eJa
         HBVHuz2TP3UQ3bdj4iYZgQ/Tgz1Q4XVsgIAagmDC58vpDH7fdtPCfY6RCtfKhEI3zExm
         GFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=FETZY6BaW7DAn6SN5+R49wTA++jZzHcLGuyisZmOSN8=;
        fh=Da0VcnEWTsEJFcxSqb8W58S9DB5DKFhcwZoV1ZLH5nU=;
        b=r/3tLt57bq2G+IxYC1txZeNgqkphxur+oY97JkxAlwU2ehBnyiXtzLoq8faTS59ztk
         fIAGFNx0bYgopdJaFfSptV/39vUVMjYfXXfj2lBBObq0pKsprwq+CkmX/NJCWC9ytQZP
         HjeXGMnGg+R9uYoMCwXpkEFgRSLHpdmvUg+i1k+xPO6ZFaCtlr5bZJIZJb7OSEVOJCli
         L0sueYR4k22lKirT1HdOuQuoZwh2mqkX5JqzuAF5KT8rSdyWBicWCKzMDgccI5JA9Wba
         NZvZbbdlU4o93RnMnlm2I7UVAiPvhsRMtx5nj6iHvlfV9wZkpRfC3O2hVMMJpTJ4m5eP
         ycew==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134173; x=1787738973; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FETZY6BaW7DAn6SN5+R49wTA++jZzHcLGuyisZmOSN8=;
        b=tCH6aH72+QK+3i0ym5moYt+ISvNn6AqMuis/hjzI2ETvBCY0mAsC3de2pTCm5FPnwq
         sEm/vfLf5lVSdSr8jWf07YSt1pI2ZlbZ5z6T1TJX0Ny+kCIG64P6jm71w/85MdIsQQq6
         k7fpwuV+MvaOZ2a6bPn9osiRcTpnt2x1C90ItLptuOpUHSHYvFlCHTaC6SBJrbtyJNxW
         e0bH/eJ0MJ+yqdDj88TzA5B5hMTeKFhhG2xGhaOtEKnvEcx8A3tGnuVQfDZg+iOwzi/w
         mAaq1LYwxG/ADBbalqsQdV59GfUD8jVwNZcdMvSeCWki6g6nN6heywue1gy1uoO4/scM
         RN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134173; x=1787738973;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FETZY6BaW7DAn6SN5+R49wTA++jZzHcLGuyisZmOSN8=;
        b=QOVegE0ts18kU868jyVhGAci2ItPuSFFJ1Ivm4FIMsf0na2OdwXGpGiOpT6lv8xFVo
         X18ErI9qELVrTT6tlNAExYPnUb76Rj5TbPiA+lU79ugWRhX6SNLDcVpQmd5SLITS5yqS
         vKYqL62V/G0xL/W3HQQPJjYYrw//Oo9Wm5h8ykxaG1gQYkIbIE+h3JyunbZeV+jKv+Xv
         OsBqp+X3rMRX7SxJQss/Hj6LJqoEPU+OxdzaAga9+Re+xLyqgVSvvm4ID+Ti+oFyoGh+
         NmfKXmKKznfsoe1MKJU6PcXwtmc9o4nGyIjQw8zgdqbi5JDRWrI1ODdQt1M8uAMbQQUy
         t6Lw==
X-Gm-Message-State: AOJu0YzOUFURPmeVdpDvbFeT3s6QGgYhGdgwdKvt74rPKoE72/eyOOe4
	MrioM1HrQWR4i0RN5JuTbzI3vepf9FfaRs4BstSs9Dp4hiC+XbKxTzbNy+XUe6aSfd1POaHlCWj
	24doK6HVU92b6irSlrfkrreXsynonT5NYcA==
X-Gm-Gg: AR+sD12r4ypwfK9QJPmPTFKXr2vxDFlJsoyPJgC4qf2vuRFILzDU7wNKMG1Sax1saZQ
	cwMhBaFHXmz2sn/iWw4iPJoHkcjLuWrpaT06VS1Zu/rWywEIOIY326xZMZz12C3FMJKdYQ/HWhI
	7DpR3PsQPT8oM669/xGSzpnGtQACxiE8o539+ZfJNN4216wupA008xjAbRLsUhml2DQzZ/PZdXE
	1ir17p7NuiX/K5hauM8tu00jXLMKj3706loqjWZF3usoJAyOX3W8U2w1sv72P7xX8pOmJ/OtD1L
	iZvHRc91SqyhVi8bYKu0fd2xNY/0EuHIfn0OSfchmQMuQTPLiEZA9h1xwUctgmZ0Yl1zmymoi7p
	+Z/o1ukTgOuLij0u86Hiu2eHlEAbSISqX2UBakcH4uDZsedUPXLg+nRUKnAjson+F90He1QZc2w
	4ahKjZRC0gDujDj8BIx3FWtXoT6IPjum7oKbbRl0hK0A==
X-Received: by 2002:a4a:e911:0:b0:6b0:3572:38b1 with SMTP id
 006d021491bc7-6b13c3877d0mr3427731eaf.13.1787134173425; Wed, 19 Aug 2026
 03:09:33 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 03:09:32 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 03:09:32 -0700
In-Reply-To: <CANNYZj9S=CZzqBFOBdGzSZvyaUMA_+nsDDhf-3siOGxMNVBAdg@mail.gmail.com>
References: <20260818203658.90975-1-giancarlo.cicellyn@gmail.com> <CANNYZj9S=CZzqBFOBdGzSZvyaUMA_+nsDDhf-3siOGxMNVBAdg@mail.gmail.com>
MIME-Version: 1.0
From: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Date: Wed, 19 Aug 2026 03:09:32 -0700
X-Gm-Features: AcwNN1V6Cqq8ib8aKekJrkFcg_cuf1As_P8I0bvc-G4XdCmkSIXuK6oSHqd4bVU
Message-ID: <CAK46CgQSvLe=1U+Xd_6pL_aWC2_940HXdJTwCmzKqhL_RhVvug@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve VSCode extension recommendation
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 10:09:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19992

Hi Alex,

Thanks, you're right to question this.

I went back through the history of the VSCode workspace support and I
can't establish a convincing real-world case for this patch.

The workspace feature was introduced with the
`yocto-project.yocto-bitbake` recommendation already present, and the
original test explicitly verifies it. I also couldn't find an
established contract that treats `extensions.recommendations` as
managed state that bitbake-setup should restore after a user changes
it.

So the scenario in my test was effectively assuming policy that
bitbake-setup doesn't currently define.

Please disregard this patch. Thanks for catching that.

Giancarlo

On Wed, 19 Aug 2026 10:32:26 +0200, Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
> On Tue, 18 Aug 2026 at 22:37, Giancarlo Cicellyn Comneno via
> lists.openembedded.org
> <giancarlo.cicellyn=gmail.com@lists.openembedded.org> wrote:
> > configure_vscode() initializes the Yocto BitBake extension recommendation
> > when creating a new workspace. When an existing workspace is loaded, its
> > extensions section replaces that initial value, so the managed
> > recommendation can disappear.
>
> The existing workspace was also created by bitbake-setup, so what is
> the scenario where it doesn't have the yocto-bitbake extension and it
> needs to be re-added?
>
> Alex

