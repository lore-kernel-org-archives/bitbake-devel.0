Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A7BCAC581
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 12:42:54 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.12289.1757335364448833868
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Sep 2025 05:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GXb/u6+g;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-729c10746edso32723006d6.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Sep 2025 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757335363; x=1757940163; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XuC5B2UGi69zLG3xp9gA0lfVwbP0pJUC0ediGUaqJ1E=;
        b=GXb/u6+gBkOaNKAUOIlV4s3FRyicbdBFIjNcou8k1CmD0KMaCTCABZ2FdWseU3sokO
         yLLACOc0fIaKYoEh4iEAihrHCMZLINyABnkzFRgYlDrz6A6KDoOAv1s23w/rFrrmJhEQ
         PBxDOHLay8/PbYZM+MOPugxQXG3cqMo1bofZwPOVjImTMG7lJ7FrEgsl+iSZBrs9M/6v
         ju1eHi0Bla6ZuUziBBg0W3kHOzS2b8koLi/01yOTxAyKENnULrv5ZVfS0QAnK/DFFUkX
         RiKBM4DRbvAV0SBpNkTpmx1bHuS0sHS7JKSnbkfI3oAbZzCG6Wz8FmqV/6UvqjJAfm7T
         xPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335363; x=1757940163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuC5B2UGi69zLG3xp9gA0lfVwbP0pJUC0ediGUaqJ1E=;
        b=HulVpSeK8F2ZLb1UQtAnu4KySubEKCH3dSDy+DOX5piMTKCg8264Q2zubuhyPObnSu
         E7Y9ThJe7ZHTmoHvazuMvz9N2M0Zoa+UUIQDjFGVD4RCnIKnmE4TW0u/Um7lmKiXfxk5
         fK9o3n6O+TgGe7gYSypbLqXgAvEBNcDnYdfJ0BTBm1xpXFNuqUn+xLmHJSTkJifSxr2W
         Mr5zj9H4aSzydKuFjqL/+2G9th15qBX97z67IDmy/DwHnSSqH40RoLsG9xyb8g5NfqXy
         Fhu6HOu5MYnhgyzooTkStvj8xwIOgcZjJjyP3jujAXV4dWnK6ZHF7yMDtlaqRMCM6Gr9
         /7wQ==
X-Gm-Message-State: AOJu0Yxg2AXffdCMuYYqZSw983znF0wD8TvbmWJ923X5hOjTFk0eYEAc
	pMi2iLX5MmY16P77Jw+PX/TtoZjtWiEeK/QPpJ1asjs+KN7PRzNwfA2zToSNsNkQI2HiNGY0OoR
	H9GT2bC+t2ENjS6bRugZbOd2qlur34oCXDw==
X-Gm-Gg: ASbGncs/K37B7nMBei2KBY4yBR0eau90MJ229Pw7tt1MOzph3RFKB0zy0SmY/CSX9Nr
	k/FQd4XasV0SR4CbFwFC0zhLvLPWqP9dMKoig8ljevD1HjP9AkcTIDOR8duECXNKDSHtesUwjuH
	XX+mHwdMWp1aG4Hf7rAVehOvqKj8HQK3xNKyXxcRX1sUERPgUxRmNrPSLVR4Jd8w7SKCjYXaGkc
	xhU/nlYZ/JFjMlLjVQg5aodO95vg69gkCKkOq/xdGqT6tVDorHuuckVuaqagjGQIINJvK3IAjJ+
	H1f9Gk4b+DQlSFyxpRahWgoHDX9U3L1UnZ6e6vJnvXjt9i5MhoFbIaKlpWG3IQ==
X-Google-Smtp-Source: AGHT+IEY1Hvxr6Be2EAjZ1sUHyV7aKvMppq3PMDj7UM9Fp5hBZFlJ9Q8n/aUAgpCV4X2pfw00UMKqeubEXVtg+8Z3Is=
X-Received: by 2002:a05:6214:400f:b0:722:382a:601 with SMTP id
 6a1803df08f44-739371a7a12mr92803486d6.34.1757335363252; Mon, 08 Sep 2025
 05:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <DCIDMIQZKLXV.2ZM8YXZTV1MM8@bootlin.com> <CANNYZj982UwaX97yiyN-9gXkRJb1qmQCnrGKri9mMkK1CL8LDg@mail.gmail.com>
 <DCJ1LB07T040.172FGJP1QUJ1E@bootlin.com>
In-Reply-To: <DCJ1LB07T040.172FGJP1QUJ1E@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 8 Sep 2025 14:42:32 +0200
X-Gm-Features: AS18NWAEdLlVD36uzGo-3jMVc7OIYRIo1IwFfufCVrejE0KJ5Pgf27om3w2PDo0
Message-ID: <CANNYZj_8Quf-7SWdD7bvBApnKPX71YAfN=04PBHmK2hhrMPz-w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/6] bitbake-setup: add the initial implementation
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Sep 2025 12:42:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17991

On Wed, 3 Sept 2025 at 11:03, Antonin Godard <antonin.godard@bootlin.com> wrote:
> > As for --top-dir, the awkwardness of setting it to something else than
> > $HOME has been bothering me too, I've given it a bit of thought, and I
> > think it needs to be split into two parts:
> >
> > - top-dir-prefix, which defaults to $HOME but can be set to cwd
> > (someone requested that) or some custom local directory intended
> > specifically for yocto builds (this is also common).
> > - top-dir-name which is appended to that when a build is initialized,
> > and defaults to 'bitbake-builds'.
> >
> > Defaults for both items are taken from ~/.config/bitbake-setup, but
> > can be overriden with command line options. Then the environment
> > variable is not needed. What you think?
>
> I like the idea of a config file in ~/.config (~/.config/bitbake-setup/config?)
> rather than an env variable, if I had to choose.
>
> Personally I would prefer having both, with this order of precedence:
>
> 1. --top-dir-prefix
> 2. BITBAKE_SETUP_TOP_DIR_PREFIX env variable
> 3. top-dir-prefix = ... in ~/.config/bitbake-setup/config
>
> I think this would cover all use-cases and satisfy everyone? :)

I've now sent the latest revision that implements the global config in
~/.config/bitbake-setup, and the top dir prefix/name split (can be set
from that config, or from command line). The global config currently
carries only these two settings. There's also a roll-up of various
other fixes.

I took out the environment variable support for setting these things,
but it can be easily re-added if there's a demand and use case.

Alex

