Return-Path: <giancarlo.cicellyn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF601C5DF6D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 10:51:14 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4286.1787136665363117759
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 03:51:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KeI5R6ZL;
 spf=pass (domain: gmail.com, ip: 209.85.161.43, mailfrom: giancarlo.cicellyn@gmail.com)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b145a9623fso13818eaf.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 03:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787136664; cv=none;
        d=google.com; s=arc-20260327;
        b=L+PDsb5C/5gCD5ZgnprG0EIFFHo5VDwTYmzAAqit+mcnmk0y7FxwjWT2/CfndTVT2Z
         UTYauAeWOt9o1Yjh3F50OWU5zAHHZXaNVin1QvcTZeKV67OQPWOaQzk0QALq5t/uvHww
         aB8Kw7lvW5I2re97mVN7fSjYo8vcMkSrcVhlNUHNkfq3xBnXsplW00YO2eCCsaSz8HAL
         It0pF1jFORQSey+UjtrymJ4+58euIFEeeMx/wZ4ZJ+plTr9vrLlupkZr/hpG6sBasGLR
         PEsx7JMlDr1JDC/q76egzAMOTScoLc0L/x3+iz92yHTiYzeBo1/sGPXdRMTcm4TMvkLb
         V7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=H1YyHSuo80FccYvETZhsnsLn9PsgcNzXxl+F2s8haRI=;
        fh=Da0VcnEWTsEJFcxSqb8W58S9DB5DKFhcwZoV1ZLH5nU=;
        b=GcS4Soqaiwso8yCI/DBF71/5ecaseMuiUo2MHO86Hvmm0x0mQ9eUmSmnqZp++h83+/
         Q5yQwR1oeoAbir5sZH2zy59i8rjd9+jZjvup4Dj4/qaHRso4hAMUj1UMDwGItVI5Jdcz
         KK/ohasyGLv8w11qOf3kpSkpoGPD+nCfVVS9jeDXbzxtHu1r8eu8ZwS/+vwRJAM8xX65
         CN2m2yAh1icA2Z7igIbGeN/jU3VqQ4TS4n8QPEYeab8DB6CYDYD9MeE/J8qkeS8jeGJZ
         mdvHa3j+ixzqS0iDthcu9poT+O9csq5g7HHNKZSwvoAusM6z4D2ruhiuE/ihPUEnkI+B
         s9/A==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136664; x=1787741464; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1YyHSuo80FccYvETZhsnsLn9PsgcNzXxl+F2s8haRI=;
        b=KeI5R6ZLDNFKHeqWc6ulSSLQ7E+szAQS/rS6sYyByATnBoUTDZG6RjwdU1yQVFot0n
         v3ulofKjFD1D9juonp/37oYGVsLKLi6XbvN43bVx6IV6fDd7fNSDogeIaQgKh7qm+sAy
         wQN4uog7sgNHb+Uzz1mQS2RDlQLsTK3wz+lAVshFBt3i0n7QPYZX5ufzrAAr6WSl4Kff
         K5tyJV64xDuaVORkSJVzEAqBuAbwWT7ynstl/NasXGeRX8B8XyA4PoEo2Jo5NoEOW6Re
         jxKz+rVO8eDTudFF/wjyGAYsdhkRRJB1xJtvYOcWOoVBqQ+EkkEKeTkRyLrYO5Wny91k
         Ohvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136664; x=1787741464;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H1YyHSuo80FccYvETZhsnsLn9PsgcNzXxl+F2s8haRI=;
        b=SuCxUqsQgIEo5XuI60Z/lauy9LJX0cWTmbHyEas9C9nVAnMYX7E6on5YepfurZ8X5H
         bi0gEawa+LgIo2+zjMT1bLYpwani60oCBH2aHxkVvSzYj5f2niX+fIHdMUv35rCd3cRt
         99foaWWBGhwUvNLeJlBu0uWeuKCBC+uwY3H3ODNUaxPlpxxPDdFnCdSJKtNaok9XV3qa
         N4WziI2nEPnkFU/761G7lwOGZqpSGbU6lL4zReGP9c5wcFy4hXoH1Zlqn6nP8+hFPXoi
         pkVf2Z6xpnPZDudJedR4TSpR4NOcamm0HC0xF1ue6hGVRlcJAWI/s45lpFUsG/U1bxgq
         WfOA==
X-Gm-Message-State: AOJu0YysE4yTAPBEwbPrWRHwA4uawLvKybMN5pst5OfQa1eRoDlkPDeJ
	RUmST8uM7XPxlA4sPE/w3YUOFGdSB+25ybJoWbUgLgTDlfYLzzK/QRMNdKnZ0fWYosCsYHVKPsP
	fHyp3rl2rMegfjyLJmMVT7KwX6Hd2Zuzsnw==
X-Gm-Gg: AR+sD10Ege5C07YadD1ERaVKFc7rGY8LezqHeV9o+uWV52UTLY7Ti1ilUin4Ran4nqC
	1I14TgjmRH1nJTg4cUbTc4fwj8q2iWyrRk4N/EI9IzaqkERmgyz+ITduvjgM0SLw7t7+apvPW7j
	r4avT8KBckc3qJUp+8PabM2BNXk6YXKT8lMWeUj9FSNLDRhv63Jvvw0aAtfO9etUGTGKADuUrfz
	2wIrpHFiYvZ8yUG+V/iQGz1b70/AwZNW3U4UHje6CHrlinpo9hY13sh1ARasvsy4MdSxj02tQ/z
	pQ6cXS0jt2RgxpIrayRPCXSg6SNhICEamLl6LfgE+oyWU5aLDRD1D5/8CSyo+Z3zXzHoro75+Kt
	ym42nbk5PUMFAxIHyMcXFLhrH+eybG8LC8GueJ1vKvppqH0heyAeKs782yQMNN6LnHeUInOiboe
	FvE/bbXS/L+8O/coaMzDsX8/8VjgesAgfBtbfs445X
X-Received: by 2002:a05:6820:3415:10b0:6b1:4250:6a43 with SMTP id
 006d021491bc7-6b142506b33mr839819eaf.17.1787136664339; Wed, 19 Aug 2026
 03:51:04 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 03:51:02 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 03:51:02 -0700
In-Reply-To: <CANNYZj_v-WM7ZQOt+ytKGG2KxbE4w_Q9r_w1U1nJTLkfZLy_Ow@mail.gmail.com>
References: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com>
 <CANNYZj-FZ5trTVaP_nvZu+sAoEZ--0RZk_cDMUkK6jgrGobTdA@mail.gmail.com>
 <CAK46CgSuNHHqd8Nm_9KTEiiad1+4LoQB9sJ-5v89uhzjCcP8Bg@mail.gmail.com> <CANNYZj_v-WM7ZQOt+ytKGG2KxbE4w_Q9r_w1U1nJTLkfZLy_Ow@mail.gmail.com>
MIME-Version: 1.0
From: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Date: Wed, 19 Aug 2026 03:51:02 -0700
X-Gm-Features: AcwNN1X5hjLEKcKQtj3OiAiLPhes1tv-h0aMrQCzDyh3TUq-IjdTzHOy4fFax0Y
Message-ID: <CAK46CgRZjY2XP9BtxSiWUhtYtdPF-1GiO3X7wN5R7rm3urUk3Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve build config when
 init script is missing
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 10:51:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19995

Hi Alex,

I want to clarify a few things directly.

First, regarding AI use: I have not found anything in the published
Yocto/OpenEmbedded contribution policy stating that review replies
must be written personally without AI assistance.

On the contrary, the reason the patch contains the `AI-Generated:`
trailer is precisely because I was trying to follow the project's
published policy correctly. I did not add that casually; I added it
because the contributor documentation explicitly requires AI-generated
code to be disclosed before the human `Signed-off-by`.

I understand that you personally expect review conversations to be
written without AI assistance. That expectation was not clear to me
before, but now it is. I accept that this is how you prefer to
interact with contributors, even though for me using AI assistance is
part of how I work and learn, and it saves time that I can spend on
the technical work itself and on the other projects I handle in
parallel.

About the prompt: I do not remember the exact wording I gave the AI. I
am a human being, not ChatGPT-9 :)

What I can tell you accurately is that the goal was to learn on the
job by auditing `bitbake-setup`, looking for problematic or fragile
failure paths, and trying to validate anything found with tests before
proposing a fix. This patch came out of that process. It did not come
from a real OE-Core incident or from a user bug report, and I already
made that clear in my previous reply.

There is one point, however, that I would still like to understand
technically, because I do not think it has been answered yet.

My understanding of the current code is:

- `checkout_layers()` selects the repository providing the setup
helpers based on the presence of `scripts/oe-setup-build`;
- it creates `oe-init-build-env-dir` pointing at that repository;
- I could not find an invariant or validation rule requiring that
repository to also contain `oe-init-build-env`;
- for the `bb-layers` path, `setup_bitbake_build()` explicitly handles
the case where `oe-init-build-env` is missing;
- but that check currently happens only after an existing `build/conf`
has already been moved aside and a new one has been generated.

So I would still like to understand which part of that reasoning is wrong.

Is your technical objection that the source transition exercised by
the test is outside the supported contract of `bitbake-setup`?

Or is the concern instead that the transition is technically possible
but too theoretical / unrealistic to justify an upstream patch?

I am asking because those are two different conclusions, and I would
genuinely like to learn which one applies here.

If there is an invariant or project assumption I missed, I am happy to
understand it and withdraw the patch on that basis.

If instead the path is valid but simply not considered worth handling
because there is no known real-world occurrence, that is also useful
feedback for me.

In any case, thank you for the time you have spent reviewing this. I
am here primarily to learn by doing useful work, and I have no
interest in defending a patch whose premise does not hold.

Regards,
Giancarlo

On Wed, 19 Aug 2026 12:19:10 +0200, Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
> On Wed, 19 Aug 2026 at 12:09, Giancarlo Cicellyn Comneno
> <giancarlo.cicellyn@gmail.com> wrote:
>
> > So the motivation is defensive handling of a supported source-update
> > failure path, not a failure I've observed in OE-Core.
> >
> > If you consider the disappearance of `oe-init-build-env` outside the
> > supported contract despite the current handling for it, then I agree
> > the patch shouldn't be kept.
> >
> > Giancarlo
>
> Giancarlo,
>
> please do not use AI to write responses in a conversation. I want to
> talk to *you*, not to your AI agent. If you do this, then anything
> coming from you will be simply discarded on the grounds that you don't
> understand your own patches.
>
> Specifically here, I'd like to hear from *you* what instructions you
> gave to AI. Was it something along the lines of 'find problematic code
> paths in bitbake-setup and fix them?'. You need to be clear and
> transparent about it, if you want to maintain trust in your
> submissions.
>
> Thanks,
> Alex

