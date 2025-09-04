Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB4CA1012
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 10:52:39 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.36257.1756983157887669901
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 03:52:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f8ChZpkG;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7220d7dea27so6712856d6.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Sep 2025 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756983157; x=1757587957; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ffGk/yA5Hch0skHRwYR8grfBgc/Ml8jFXEWIoMQq0no=;
        b=f8ChZpkGmZ/tn1F8k95Br6dhbqrTMPEysili7CRtMqUkvwzghQ9As6z2CMSvn5Tx3B
         hOglCzp3Q4lgYJGcCA0n/4MWsV2N9Uwaz6jPP/APOWiyJhw+JGcnyfL6VpZpo7a3rjSQ
         ffSOZr7Ojo8KksxfP/s6XBwon88S8NhEOTIjO2tzIpyQsKTqCuiWcaWlasLHBhZ66Bnz
         0+eVzr1ElnvcrGFPwP0G0dJn8upVFW8pwTZg3E/twtUvyczeg+jwYZk0blMu2r6xGb2F
         0D+i2hxfpP7gR7terW2Kr8e7CoKGmItMgBtE6o+9AK6zG1XOQIJAhwFRWC7/CVpdg8ka
         MyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756983157; x=1757587957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffGk/yA5Hch0skHRwYR8grfBgc/Ml8jFXEWIoMQq0no=;
        b=GxKwv85hUCMVTi2K9kDyPpxLeD7SsLz73KdPqYHUXNiD/suVenfS2bTqntDyv7UaE3
         xTlstQQ1pBh7L5KvqXUT9u70XPy6v99TnsdK+e29qv2OYF/vP0VEGsIeaq92JtR1JtiK
         5We+nVyveg1HataahQExxiJwxwmkUZ+QmBQLFtTypwJbUn2rpVvLFBqWXKaYJLGcLK/N
         XgkxtfJk2yRBs8Xz4hCEn5enZOqlck+quYBWeQ8gXyJGFBeuNLy1Z4VH7hxuuuJDXRHs
         uP5KorLBQAiDJfk/xeEiFUL2jiYj218N8r2oq0VSQcq0ZEp7b+1w+G9tZYEx57k71wk3
         rDJw==
X-Gm-Message-State: AOJu0YzspC4KY0wyVErPJCoHXKt+27ksk7duPXOaEgpgk0D+piCjqwLd
	XX5o1j9CFzPHA/TL/7Y1rYBYa20LEaCjMgYGTwQQiYWLbFx3MZXac/BQ9loTmLzdMH8JOdYHlLS
	4Q2m87DWEzWzU84E7I0xx/tHiwK1It40=
X-Gm-Gg: ASbGncsQSP0YnWMOEF8H4s87q1OuMvWkAI6DIZNIf12qP9IjYkq7fBJs8CxCnlDGEkb
	CSuta+eHK9KMZ8VXu3uzF7lTraE7CeYa47iwnq/2n0Dqcvq6TO4T8+rtONHWpFRD+7NgqWTSyTj
	U0uM7EYmVV+ZA86KmjDNrO/31aNMBhYpLpmzkEEQLz2Yn5pB0EsQ0p+fy6or8XPr0V0lNnmbmS7
	bxQ6ryCxjyNeJE9Okzwjf/pLYLPrKwgnRecqyxWIVMZxktry/xc0tCioiUXo3ddxVffKBgfQqp3
	FMp7bBwHRi2kBL4KP3E0um61sy5VcU7zDx5otNbtEN9tyzGQMri5teszcgUrug==
X-Google-Smtp-Source: AGHT+IG3vnc9IJ/KUXQlfnntyJt0yB0zTZQQf+eNN6ZM7vDXxXWNRhbux6iH1oHw4Q1cySlxDe+F2oAUNCEcxWP8b3Q=
X-Received: by 2002:a05:6214:529b:b0:71c:53c0:569e with SMTP id
 6a1803df08f44-71c53c05b4emr130923296d6.51.1756983156950; Thu, 04 Sep 2025
 03:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <20250901135836.2927686-6-alex.kanavin@gmail.com> <a8b57517-343e-4284-856d-108835d20302@gmail.com>
In-Reply-To: <a8b57517-343e-4284-856d-108835d20302@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 4 Sep 2025 12:52:26 +0200
X-Gm-Features: Ac12FXwM_rhswlALuaBZFjfPzIioeFMRv75XezaM8CEz0pok2vCCEbsPcg_mWjQ
Message-ID: <CANNYZj8N-72hZ12zwPGLJbOMBG7jOwCeCsxjSu2o09tZoRM0xQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] bitbake-setup: make sure git user is always configured
To: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Sep 2025 10:52:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17956

On Wed, 3 Sept 2025 at 15:05, Gyorgy Sarvari <skandigraun@gmail.com> wrote:
> As an more or less unrelated comment: you are free to squash my patches
> into your ones. It will help readability and I don't insist on having my
> name there (not because I disown the patches, rather they are just not
> as significant to warrant my name plastered on half of the patches).

No problem. I squashed them in but mentioned you in the commit message:

This commits includes fixes by Gyorgy Sarvari <skandigraun@gmail.com>
https://github.com/kanavin/bitbake/pull/2

Other reported small fixes are also added and pushed, top-dir-prefix
is still to be implemented.

Alex

