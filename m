Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46580CF3957
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 16:25:09 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11216.1763569501096640715
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 08:25:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JaRzzVdL;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-882360ca0e2so50836266d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763569500; x=1764174300; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fH7o4wnrfRIdShx8pLId8ouNjFI/bx5HsVz8Jykb0DA=;
        b=JaRzzVdLsDslo9/PHR6Zl7Ef7mobbPCVv9d7afFxQiA/3WxeAS+DLTkDZNJ4hvozzR
         SQOcGr2Qf2QEOf7UgHKZvZCMeCCNK4omLw8VEgOEsyuAHj1H+hewnFsSl4c/F6kjlpF2
         KlCOGYLfeyMnwDXg1SgzOLuEi2bo3fPFj4WKjnK6mqg/wGGE8XnmaXGt2HgPbVdZHYXE
         Fn8OVWWTzaW6UlO8fc680kE+d4ICmokL8PzZqpA8P9O26AQ2bIYIW/bKshkX+IVvy7fY
         HEJldIN678d7G/u5IbTj4Qvqs6ck+AHiHmai7UEmLZChfN7f622vGIv7U9vj/ApEj6J3
         12Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569500; x=1764174300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH7o4wnrfRIdShx8pLId8ouNjFI/bx5HsVz8Jykb0DA=;
        b=tlZYTLbbsX/wUDIT90CXt5pHb4cyBlwTETHWxV1JWUCGUbFQMtdTp94/4tZCMYhcK/
         fzd9aosPsofwPd840oOBttKJqHIARlFw/izxg0IgYFDSQRjTp6c33GS8nSSWqmPH1vzM
         4+eql7lxtqr8L4Vzcqqeh5O2ycjfbYhh6Mywwn6HESMqxYl31m89iM9An0AqExToyHYl
         DGxreBtuQAvQGPSGC2iLwdQ2I6wtIKPo24JAqKCmFtRoRhHM4Wd39BTeCyma+v7z4blf
         K4VyAuQFoqS4O1+jeHpg1FGSPj7s0YC8dfe8LwMFsLEqP75V9FdzJ5U18X4Y7DQvQAVr
         PmMg==
X-Gm-Message-State: AOJu0YwypefIPZ3YenAS0Fpv04EIhVkS16+ehRvMXHvl/iYzjzqMVdx2
	fzPWCeS4yoMp1a1VdL68bi1pv9pS+S23Yhc9FputOn9Sz+gwAISs6Ob0Op5mIuN3ArKadxmIlJT
	RuqkAzAzg4HBdLqubeNYfXq2A/o3UQHYxbg==
X-Gm-Gg: ASbGncsA+e3oJDMls2YpsGFhkqYJf3Hg1eLOaXbdkzvBGXCYwfuYtYSP9VkyqEFKvPD
	H5ERwG372E+BkPKrjy7DvVKFWxc3qvKQu+bftqbd+4lr0uP05wdOSj8twbtve810utYmndBmq/N
	CPQTPttirKcknWAKy8PlHL/bUeMnWDWeuvKZj/dG9Mp3tcd2xOzaHesWe4wSjUJI2/qU/v/J2sK
	ZByy4mnV7eInfStrI93OCO7AJ+2/YqtMgc6xmYO1Y5r2yxSH46IWB+raIb0SI2XAtsYFEFxuCNx
	8sPB4K9KBbJhbBP0o3IbATPmQLcsfndt39zTcQlL
X-Google-Smtp-Source: AGHT+IEpZjsK4YG1QpeLgBiwqWvCtO1tCPuKMpFllmECYSqPjxT1K0CjC8jjfRM/3TqB4rc4vUMVZCEvJjTehrfrpw4=
X-Received: by 2002:a05:6214:509b:b0:880:52b8:2f9e with SMTP id
 6a1803df08f44-882925f7830mr258730046d6.21.1763569499939; Wed, 19 Nov 2025
 08:24:59 -0800 (PST)
MIME-Version: 1.0
References: <42bcc23e-27ae-8bf4-486d-3e552d58c701@crashcourse.ca>
 <CAJdd5GZZNGyPePiJEQnn-0mZK0cX9dzTh7KM3uqkFJtnJ6dVQg@mail.gmail.com> <1879711085697862.1423420@lists.openembedded.org>
In-Reply-To: <1879711085697862.1423420@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Nov 2025 17:24:48 +0100
X-Gm-Features: AWmQ_bkBUVkpefvg2BTZbDqZ7utxD61s7XXMSbFzg5Cc0GDqCfZT0kckcpEAGqk
Message-ID: <CANNYZj_t7mtmdY2bW8+2zL6Ro_KFW4D=MXwygQEu3HB64-5=Hw@mail.gmail.com>
Subject: Re: [bitbake-devel] why is "bitbake-setup list" trying to *create*
 bitbake-builds directory?
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: JPEWhacker@gmail.com, rpjday@crashcourse.ca
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 16:25:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18463

On Wed, 19 Nov 2025 at 16:10, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> It does yes. The issue is that bitbake-setup needs to set up a bitbake
> datastore (at least), and potentially fetch and unpack the registry
> repository, so it can walk its file tree looking for configs. The code
> to do this is shared with things like init/status/update, and so uses
> the same top dir as those other commands do. And of course there was
> pressure to change the default top dir to . (instead of ~) which is
> how attempting to list from places like /etc no longer works.
>
> I guess it can be changed to use a throwaway tempdir as topdir rather,
> or go through the same "print top dir info/confirm top dir" sequence
> as init does.

I just sent a patch for this.

Alex

