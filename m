Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A183CCD8CB2
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 07:54:46 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15170.1781078083155936230
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 00:54:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lN3KrDuM;
 spf=pass (domain: gmail.com, ip: 209.85.160.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51764768c36so84422191cf.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 00:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781078082; cv=none;
        d=google.com; s=arc-20240605;
        b=M8NgBf1a0Rrw1nuUPWnLF0JxLdk9BWgRzRfO+ErI7T9Mz5l89CLKJYLVQNoNZw7dxf
         Zo9yLhbFz0GlcZdxx2MoX7gc7BXNxOv2OVsW8T33lHEyMWD8E1B7LWWHs6ZYY1zLBFMP
         RSWriHdovI+LyhXsFknigN5KirLz0FjTmJt48cMLHjmrzE3iciiUUJBcmgk7EVT8Mr5o
         G5VGhJKG4oDoQCdCPRC5vLfVzxJh5RRtwi9sBPl+Hy4CfC8Qlois7OEzPv6rcEDNq/M4
         iqMr8276TtyWbKRp0VWRjEGQMyPb6APG0jdYSGucYNSNRYgAlzMa1HA8PWERc46bMb1y
         OI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yrrbwmNqyJZ36bc7SvZG8D4TLK47KtV9WOL77su247o=;
        fh=C7wwA6xcYwG5x3JYjkOTBI4vfyehQD5IL7gDxv3rPm4=;
        b=lbC/0n8SHST6tkKNlAYCzzGUHV002VnsEERwC7+/MHyIbEbPG8c8t/VJvbhaWH9z7l
         +FD5KGA6bTS4is3GNiG7dt3wtHjv6Ebk6sq5g3FpDX3Rz4UwHUafPl20mjp7UkJzl5WT
         mgaJLAaQinxK/kI9mtrU8LCcpw2TUwgRof01E5qaXVNQ+/HhdF2W2BqK4iU7Rt++BM1f
         aHhad5yVGk3PBc4+vW/mxyC/ho5qt/VdrmbWjwfZVN4iC+UEsJz3eix47u3+pNO+8PIc
         JoU/gjS1r6nj4ilv5tYwbG+UbCCVe0JpWLUbjD4SP9FIB69BM5ZI8UqFyW71oNw6LsT+
         5Vvg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781078082; x=1781682882; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yrrbwmNqyJZ36bc7SvZG8D4TLK47KtV9WOL77su247o=;
        b=lN3KrDuMSvqoADA+r3G2NAcTy31qwrj/dIWi2iR9sF6k0eSC8gIAZGhH1/d/U77RcW
         HBq25XzYYyewpQoOa9opWABbSUwa1WJRMhK/QYulEiyexhwrhN/QuejKOAEYEGY/qJKq
         yGogc5g8rHwmeFlPHuVwyjGbCVm+GN6wCDLUpyLYufmnabGvFb7gq+dlayA3wLxysSY+
         UTyaAoQ9U7O5ZdvryotRPx8yk8PpJ830SAojc1yyXdx+iHJcmXvpKPRwD/q1Fi74pjzO
         T3VwjrICHwnr+9CELNGfK51pQ4ZLOF2q6dzS5BolSEsHzjG31atOkb86BgioOrtCU121
         pyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781078082; x=1781682882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrrbwmNqyJZ36bc7SvZG8D4TLK47KtV9WOL77su247o=;
        b=Wiq1uOC1tw4E1eEcEp5qDc/LpUedIa3G5skUvZIt98UpBQonu2FMkkPURPGi8nBN50
         fXE7rXxrQwTrNkf2dBOhsfJoW3TOTEqLNSuIejX8zvvGpZGd+2S7xzWrlPKWwCm8Wfnx
         XHqRjo6c7AVBBe4+LXWfr8EdSDyhDM+MMoqaeHZiu47CVIbYuBt9VGsvDCp6N8GBLUom
         eDp77DPn+fjJcPztBb5P/Db4ccQvLqfsXrm2IsqPJ3fHn6xDQVfpE80Iix3CZH904szb
         1DqnikkigZySsPe3oP9aMj2zG8fq40a0nRCJF0QinVB/Ilc1dWshAQfkVGIcnIla3r5J
         L1Xg==
X-Gm-Message-State: AOJu0YwjvSg6CEpR09Qk7dyj8hV9tJ+ugJa7SHYKf93XHvDFUso5HQQx
	k4HpwHNzi6y3PT2ez3nnA6ciCKcPwwey9xW/gpICkV1Jc5IgZlShR1ItSPwQHGY3er13LvxYvCu
	vPt2zoHZtYWOgMLt5msE6WJbCTNwAsH0=
X-Gm-Gg: Acq92OEUGhvoYa86rVPMMq/bxXtE0c9Hsc1WUBDw05KNu/+7Jlm9OyO0Am2HjW10lWY
	guX8jyNhXgas2yDdtx9q72Q1Ita4TRxzaGTCFEjWQobTFgqavZWtB4SzbJp7hUiyHLNDcPO4zGR
	Wwi9THKu8WOAXY6JAh1N7gHvKMAEb/ldOfT4KJKHaLC3XoHZpC/tWAkFyL8gGnX1W7cbj4+DYDp
	/XxIMXBgySj3ViPUO+JieBr/kbddItXDgnisT1CoZ26+8GwlLXKw8tADy9hcdB4TeDdL43UNNpz
	m3P/pGyx6HMAel0eihY=
X-Received: by 2002:a05:622a:14b:b0:516:e3df:c10a with SMTP id
 d75a77b69052e-51795b9fa29mr358546191cf.24.1781078081955; Wed, 10 Jun 2026
 00:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260610074013.558709-1-anders.heimer@est.tech>
In-Reply-To: <20260610074013.558709-1-anders.heimer@est.tech>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 10 Jun 2026 09:54:30 +0200
X-Gm-Features: AVVi8CfIarO29e2-bs2YVl-0H6h5LwbNmxl6eQo-S3TfYOpNl2AlQJkZ_PWL1rk
Message-ID: <CANNYZj-=MA6L1w8_zOEngOZqHDqmbuuz74v9Fy=pgxr1D+Vs9A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/2] fetch2/wget: limit auth headers on
 checkstatus redirects
To: anders.heimer@est.tech
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 07:54:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19639

Unusually, this was rapidly merged to master almost immediately after
the patches were posted. Is this a sensitive security issue, or what
is the rationale?

Alex


On Wed, 10 Jun 2026 at 09:40, Anders Heimer via lists.openembedded.org
<anders.heimer=est.tech@lists.openembedded.org> wrote:
>
> FixedHTTPRedirectHandler currently copies request headers when following
> redirects. The first patch drops Authorization and Cookie when the
> redirect target has a different origin.
>
> The second patch adds local HTTP server tests covering both same-origin
> and different-origin redirects.
>
> Anders Heimer (2):
>   fetch2/wget: limit auth on checkstatus redirects
>   tests/fetch: cover checkstatus redirect auth handling
>
>  lib/bb/fetch2/wget.py | 27 +++++++++++++++++--
>  lib/bb/tests/fetch.py | 62 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 2 deletions(-)
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19636): https://lists.openembedded.org/g/bitbake-devel/message/19636
> Mute This Topic: https://lists.openembedded.org/mt/119736443/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

