Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A68DE7718D
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 12:51:34 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web11.12724.1734958286603257373
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Dec 2024 04:51:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JW6rWMxx;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so44675226d6.3;
        Mon, 23 Dec 2024 04:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734958285; x=1735563085; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FfHCUpZHzfWnJbzTrvQiW062OsiZcrjSt8Q9iYefA90=;
        b=JW6rWMxx72Jb10zl2L5IRsa//N8T14ZxiUQDg5JcSDRrMKUK/mKzzUsZc4znLxJqg4
         ixPhGvp07PCrPlWpTMpBPpTTzkCeCU40HvWcH/NpwIiNVJJdHn0BQv1+KFWzjGqLtH01
         LVm8zkiy7od/myEntib7niGp0nNf36DbbG2Y3uPnwayNAyZi4nRrVOl9f9lod/2jhVcC
         i2NoK5/W+e931N/Q2OPyajjMHoCCmSPD09aKiX2byWR2JvfcpClqewRI52LCzukhxajE
         qit1J9VXxf1fTVpuYpk6gfZdYBKoipxZqDOQZ+sUxE6LoPAGrMkSzdHmX5S39UKrSMNZ
         yDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734958285; x=1735563085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfHCUpZHzfWnJbzTrvQiW062OsiZcrjSt8Q9iYefA90=;
        b=JBqJbMcOxaKMavH2vuR/ndAfDS2COvzwFxDpOlOzPYmirbUFzVYApXcPsNnF2OZIqH
         QVx+C5AdOY8lJsRsGlFFLm9SiHLVqMSQBa63bkHCrOgQHkyc2sDP5sx3RGMFiwYYyzUS
         tkjKVG234PooilYWgahtbF2WLzoQqNqweOQZRc/j7J0RX8eKzLqRSh3iDOJFFQFoQ4Vr
         LrTjvObMtddfoUK5fYqg0TsczDFzWYVebh6M32BmqMl9goDn6ouZnZLxqgEYtQkJtetv
         U/nq7P3Ow9+U/FMzCNdUeFiXQA+cBvEyV2+H6XXXzxtzWWoVy3rqGxdKTCvhR0UP4tYY
         1qWA==
X-Forwarded-Encrypted: i=1; AJvYcCVpq0PrciITKkrJWnHynrK1PiICI+sX7eU6oph8EUZeLRtZCixrYo24ZZYTzmOnkAxm8/HUaR0x4tZZS5q95/txzk7Q71K/93W5@lists.openembedded.org
X-Gm-Message-State: AOJu0YwDhdS0OpHw26HhZFXnSdg2QvWWBJFol8crE1jLhBgRKy06qTcq
	tsXbIERSVx0KlQ5NxKYbu0beWU1bOcYXVIr53vxCefFlg3TRC5XcwEXftHwbKdjWqT/RyP66tXH
	xpsUEEAUYPODxrGwaIO2+NoXRWVs=
X-Gm-Gg: ASbGncvbU/6YH6QTvAn2rfTMeyJXLgY/O0yAIZcuM0IeDsrwMbyNH3dsdvHcdXBpEuI
	2ocjOFvh6zMQN2NOLHEstVLRNtJ2HWPgWH059kYaH++yHAz8P2HHcmim3ppfv/NKtIhKvrdki
X-Google-Smtp-Source: AGHT+IFnzre59fmuLh69LPth4+8o047wLsY5D8yejG/ajMsny1rPc+Bw+BjB1xYWPkcsF7oyroH/ex+6VFZPvE9VA2E=
X-Received: by 2002:ad4:5d69:0:b0:6d8:81cd:a0ce with SMTP id
 6a1803df08f44-6dd233aab3amr218037446d6.43.1734958285580; Mon, 23 Dec 2024
 04:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20241218124722.2030523-1-alex.kanavin@gmail.com> <CAB=6tBTTn=C5xAqDwtUm9nyTnnxh2s+Lfwoe+sD3Ara3cCKtLw@mail.gmail.com>
In-Reply-To: <CAB=6tBTTn=C5xAqDwtUm9nyTnnxh2s+Lfwoe+sD3Ara3cCKtLw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 23 Dec 2024 13:51:14 +0100
Message-ID: <CANNYZj-bimfikUijTUqB2avVC+h8a8zpEHSD7zLL511qDgXZxA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: add the proof of
 concept implementation
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, yocto@lists.yoctoproject.org, 
	openembedded-architecture@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 12:51:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16947

On Thu, 19 Dec 2024 at 23:18, Chuck Wolber <chuckwolber@gmail.com> wrote:
> Would it be possible to change that to just "build" rather than "build.sh"? For
> an executable, there really is no need to telegraph the language it was written
> in. It also makes things very difficult later on if a more sophisticated
> implementation in a different language is warranted.
>
> Related: https://google.github.io/styleguide/shellguide.html#file-extensions

Sure. I changed that to 'build-targets'. It might be good to consider
if that should be even called 'build-default-targets' in case we might
want to support 'other' kinds of targets as well, and how that should
be reflected in the json structure.

Alex

