Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E2ACD98CF
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 15:38:28 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.132693.1781537900425836781
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 08:38:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=g0WUazMk;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8cce22e029cso51398986d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 08:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781537899; cv=none;
        d=google.com; s=arc-20240605;
        b=NPueqkhc6GP+1cPOANfHvnw3FPLfXua4QA0/OXGOhptoEc+A7AoLM4bUy239qm0hnx
         B+kze7P6wvLAtUFwBGQG7ZYSdVMorzbon0ldGdowFD7XYzeLoF8THeSOEjU8Rp47dawk
         grY0cmRoozw1Y981oYBJf8yJZq3vpZkpnRp1ygcffVg8epkbvOQ1KYQRynC0qk2319kg
         cQqW7+o1ddctQAYQeHuhi+PpOMvzFD6syzZJwY7KccYG4ukKDi3Tgyt9QXoWQeqw6s/s
         StTa7w1B5sguafo+mlhbqIJ3SGfnVpRbDg3TrmjDmRHnmd8eWXqMn9qTl4dRFJnFTkZk
         B0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzlGteolsWf6eFYDpy7pLc/yhOFY3CLq/HOYVpcnUy0=;
        fh=ihLuYaNNuTy/C9eCuAumQK3Vy7JHROFrJMZxWgXSlyU=;
        b=VJdytU6+0gUhuQ7u8Qv1rAmU+wts6kqnju/WeZo18kNMsKCSSi5QV5e5PcEuB77tSL
         jRMEGD9gRfOM/GukMjagHAdyUdxcKBgCElhzLO8fjA59ujs11fK4BDPwVBbwQNON3tXw
         xfikASh/bpMksPsI5OEqN0/oLrRBVA9h+caVBb5elqo6I6r4hyJbjDdjj8AwuM7QuKH/
         Mc4yLNansCiOt6F1v2DweU77k05ymv10s0DpzLzgrSbXOagYJW8IWQv8uaS+Quq6SOny
         z+KuVjyxzh8KSV0s4h1clDjngozVXiU7erTbW/1Z9iwo89im5QOJxAsW8YcfVe39QvZa
         6wKg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781537899; x=1782142699; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzlGteolsWf6eFYDpy7pLc/yhOFY3CLq/HOYVpcnUy0=;
        b=g0WUazMkcARsVRWr4hwH7ncGwp/XDtjyke+9u7eqAYbTZgFjnWhj2q3Hfy7ctCsZ9u
         iI3EUbIc40vUS4BaoF0MiygPSMis8dEYWUBtFYyUAXQtm6gt8RPmt6wUa14L1ipzmNpv
         tScmwO0Rz1vc/Ki0DzKL2DFvWXnwxbXhy7aTAL24m9vEpwNAQUIqtzzAxGNqHavkTzdR
         R/7QywQnd7+xPcymj5Bw/8df7cML5Rb6Q3sgH1wbw7GUWIQYKjwFwhzYFhDySsNa2GvD
         iixk+7FMQHtVoF7ulg0E03S2a2fGE9xL/B3z8IGIOKP4aStwkqHKZLru5MayGpcwvCmX
         3d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537899; x=1782142699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzlGteolsWf6eFYDpy7pLc/yhOFY3CLq/HOYVpcnUy0=;
        b=FA70+YYRJ2EJtIB6uFZ2yZrzaAa1UmWd0kb0YmMqVcOIdcOjxaqieueVLPNyyJsq9A
         nvc+wDB8i+gj4wKbTe/AyjvD/NRCe7uGy05K72GDT2wQUmYuhGFyqBA8lI0gfBKpnqVd
         GZ268PyKMrhx/m49almvg2gNHQQjegDSYQgpbToBQWoB3iwdw/f/gB2Qea3EqRLL28Bq
         eO6HMc+ex9FVhd/ChNzravK+kq9zB9Ujph3GfjXsQQxH0B9eXaMYI014+ll/mFiwb78R
         G5xSBPhBX6AualtyvxTZnV+BS2uqmuFApJuQgsZ7Egaaa9Su/zbNLGjk4AgD3X7ZkVXc
         kvbw==
X-Gm-Message-State: AOJu0YwXmkqBMsRkIbMORRTwJDlT2XLXuc69iNu7gNCqOa/wmHv93Buz
	+Cka7+1Y5ftVcpX712s804HI8rQ4pziGNGzv9KX0MuuTjlxeBndK+MP9iKppLxiMaLygo87BGwh
	UboYr5n80tEMfhOdtqGtIXv5FpJKoYks=
X-Gm-Gg: Acq92OGMQEZjM1EC59IdG9uwYafGoYOPb1v5cnpteQ58Qxd0o6Rn741CgzNH5XNRyL2
	ncrY1V9TWkxHjKj4AukADUF9cjWBjd00wx5U7+4bRTdIe4ZJrlPF+dQiPFkKRR1I+kCua7MV3o6
	VQx9kkkyVa9GmqHD4NbAfDT4gjFEXmINgwSX3gdLSzumWYg5AgPvTgZWp1pKgsuzpS6zgkxyW2P
	lfmyoECInIcAIIDvDShMLX2wVt8U6dI6NflMV5L+IT1vhme3AkcCiKkcuW0VfHS8bs5PZNEzYpX
	jBL42KGOpLwrqIN+BLJqNdSHnkyq1pROmc8ckvitUSvy78Qc/i7/
X-Received: by 2002:a05:6214:5bc6:b0:8ce:e416:dad1 with SMTP id
 6a1803df08f44-8d34cdf0ea2mr203180596d6.21.1781537899211; Mon, 15 Jun 2026
 08:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
 <CANNYZj8ggqRPVgpnnX1Qtn5-c-b6=xE=FbdSsnrPt-hMUVKGng@mail.gmail.com> <DU7PPF66507B2D70622D4334AF9DC0F3C7BF3E62@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DU7PPF66507B2D70622D4334AF9DC0F3C7BF3E62@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Jun 2026 17:38:08 +0200
X-Gm-Features: AVVi8CeQ0F_5YnyPF6jd0mhfpSBj7J-Zbb6GnFLHAMupAd1MpPcmPW8OnU_3xvI
Message-ID: <CANNYZj8FzL095jg5nhOqP32hhYj+_6__rS6DGazqtpHmt0yorQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
To: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 15:38:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19688

On Mon, 15 Jun 2026 at 16:59, Jaipaul Cheernam
<jaipaul.cheernam@est.tech> wrote:
> The archive itself contains the same tools as upstream extended buildtool=
s =E2=80=94 it can't be provided via recipes because buildtools exist speci=
fically to
> bootstrap the host environment before BitBake can run.
>
> The --url and --filename options are needed for projects that host their =
buildtools on an internal server rather than yoctoproject.org, and want to =
pin a
> specific version across the team without requiring manual arguments on ev=
ery invocation.
>
> The workaround today is to pass arguments manually or modify wrapper scri=
pts, which is probably why this hasn't surfaced as a bug report before.
>
> The --sdk-name option itself is introduced in a companion patch to oe-scr=
ipts/install-buildtools in openembedded-core:
> https://lists.openembedded.org/g/openembedded-core/topic/patch_install_bu=
ildtools/119814299

Thanks. I'm broadly in favor of this, but I don't know what the
bitbake patch reviewers will say, and especially RP :) Buildtools can
be used to do isolated, reproducible 'container builds' without actual
containers, and I like that.

I wonder if the archive should be downloaded by bitbake-setup itself
using bitbake fetchers (similar to how layers are obtained), and then
given to install-buildtools as a local file, or even executed
directly. There are benefits to this: it will be preserved in the
download cache together with the layers and upstream components (which
helps if upstream server isn't available or altogether disappears),
and checksummed against sha256sum provided in the config (which adds a
reproducibility check, and protection against supply chain attacks,
similar to tarball recipes). What you think?

Alex

