Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED36C48297
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 17:02:27 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web11.17183.1707498144405944970
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 09:02:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dlbWXxgT;
 spf=pass (domain: gmail.com, ip: 209.85.208.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso12647711fa.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 09:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707498142; x=1708102942; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/0W9IbKGPDKgpUuR1yY7e8BWbE+8bgHHeQUDL+GDxM=;
        b=dlbWXxgTfdi3ZXePeBHNc+o3fUUv/Lss0RcQ12dV/a1pI47+azpU1SdOdRoD/z8Xwl
         eqdKA3SJQLAGJPmLocROLzvmUgRnHg/JR8QqiV7xi08VhYjkMRmM4pL1vRYueeMyA6UG
         SeWq9Oa/QtTQ0bNOqjfR7qjdHUTlLZ4ytdx7icws7nyj2G8lKNfSno1gkZaizoIBUDKq
         RrfD/aEjMbL1b/J5tGg/CoqJh4YHqJhM2xAkqfqbIVqISqksZdqustInt3b5SBafQASO
         m1BmPfc4PWYeIOsaYDy6eQMYNt4q/2YHv4bnvW62lsve3wQj0X+nbfE8Yv0oZRh15p0G
         Yj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498142; x=1708102942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/0W9IbKGPDKgpUuR1yY7e8BWbE+8bgHHeQUDL+GDxM=;
        b=QCB7AaIWsPLICBZqiBhaIUhMwVPuuCYAAqsSyg5SORH2tTdl0cZNJlgiYM6TEkyfE2
         5Hxytgj/jsSt/mR8UiZsovucZvT88O27jODc1yPvfnpaST+YKOTHWtgo+Mnf27A1wVz0
         7q9r8451nGCqdK5SKLd4PCOUnm1La2g6Nq0K1hYclZmzdDcvZ8xjCYAQgKhdTysxUJ9P
         m9EUbblmt4swSJ9KfTdJzwmY4CjeapBv4tzuG2ef4hWS/AY/vvtECXC1tVmfT+/CVqEv
         7cwOzJozZ5gdIc2YPFZIwgtKSeBl7RSDVJJFuTK5Afts6IIRPg7gU5tKMnLXQUcQYUGo
         RxNw==
X-Gm-Message-State: AOJu0Yy0Msd+t+KmEWpsIDIm1jLccNuXMbY2E9SOdm/ctJ0kfEJ6QPly
	XZBQpN7Cr+uM0ukZu2salXZ6l8ynt+x02BtjaCkzSsfzGqqpewOdEs7SRdE4KDrkXt9g08+BbB1
	JJ4KWFVKxG6bocmkPhAhMoukQOhs=
X-Google-Smtp-Source: AGHT+IGNG9VRUV/dDFK2yvI8nS0/Aj5ZLY2oGtEHvpmX9pep7UdkTvvoHDd20O+NgYVQEXGZuJyYDtxFIILWm4rRXQ4=
X-Received: by 2002:a2e:b6c1:0:b0:2d0:abff:9c89 with SMTP id
 m1-20020a2eb6c1000000b002d0abff9c89mr1671416ljo.31.1707498142357; Fri, 09 Feb
 2024 09:02:22 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
 <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
 <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com> <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org>
In-Reply-To: <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Feb 2024 18:02:10 +0100
Message-ID: <CANNYZj9fxB00mCqUPVPsjqA5Tojv5urXit++1bRwv30FDv1Cyg@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Khem Raj <raj.khem@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 17:02:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15862

On Fri, 9 Feb 2024 at 17:22, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> That is very unexpected. I just tested "bitbake bash -P" myself and it
> did work out ok. The stack trace doesn't really make sense to me so no
> sure what is going on or why this is failing :(
>
> That does look like it might be the post processing code failing (it
> saves the results in binary, then loads and processes the logs to be
> human readable as it exits).

I worked around it by running 'bitbake world' without -P so it could
parse recipes successfully, then re-running with -P against pre-parsed
data. So profiles are being collected now.

Alex

