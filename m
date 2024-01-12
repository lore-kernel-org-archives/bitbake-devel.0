Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A36C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 10:57:33 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.4574.1705057043320065545
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 02:57:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T4vRHP+X;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd8b661cb8so15317031fa.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705057041; x=1705661841; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jt2+kuKOhqAzx6DNiULWFo8I6aEg94A477Wt966UnMU=;
        b=T4vRHP+XdHbAnzwswCEJvq0AQnNn4vclZvIToLCSXLyLbsPdPDKFS99RXS9AsNal7L
         Fknm3JWnJiQwPbv72nVU1gR2MtMbPHeYwmdwKGixw19QkzUQ3XxhL81xSS13h28zJZiK
         AoQ9CyVBlsZmDqMi8zWcjH4kYn8v/WWjExdJbBkVx7ePuZE4XxbQ56UYvmshT88stX4P
         be+u+XeWcFr/7/czjHP0sRYXkf9xQBQ+UmIQ94GHUfpoS2tUXS0w4Jr8KS/qsOfASX4B
         VzmgGV1Treub8yzun8ZSZiI8E+a8G4eQyOcDadylkLuE3FRqICwmhI85BW5P4T8I0pKx
         nQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705057041; x=1705661841;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jt2+kuKOhqAzx6DNiULWFo8I6aEg94A477Wt966UnMU=;
        b=l760qHiSP1tzsyb19QuIWZEWom1nMwdBVURygea2sPCAA6wzWsAALrcj3P11sB+IEz
         c9q0ufH4A0hAAVeXfWOgWSgfRoLgX0XNztdOkkvzM2x3F9WWXS1OX0RbUoemZng9PeKv
         AEXNT0+6QJnDGOXMgcou2UfMBJzJ54Vjvex+L0/Dv5nY1q7iK2I6c72PCh4rv/AkMFYt
         8TFpAz9XG5VK6l8yh5b4QhSlzawro+nmO9RSv6+I7T8el3n8coFR3Ps6yzxW64b27b9a
         xC/7vCe6VGSWoEwoyNYgtmfTr3t0nYLCtrE1C/T+Uqm7YkOHTTGr05nrk/rxR809Tnak
         HVSA==
X-Gm-Message-State: AOJu0YyiC6Sk0nQjB/5eXOF9lHDnTWwTID864tezbNLj9yKSEn9drBaq
	FkL0uUSNx7NzaWIp1ob6TFmPFPESlY2gX0Ek1OXgSvo1rKQ=
X-Google-Smtp-Source: AGHT+IHA0KN1XUS3Gx0+jFciR5C+Nn08cL5bohi22YlwzMaf522XXbqQp5+3ymArWSKvnSUwd2/0WK7BcjU6cmmUgyA=
X-Received: by 2002:a05:6512:280e:b0:50e:ca97:5afb with SMTP id
 cf14-20020a056512280e00b0050eca975afbmr440890lfb.18.1705057041218; Fri, 12
 Jan 2024 02:57:21 -0800 (PST)
MIME-Version: 1.0
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 12 Jan 2024 11:57:10 +0100
Message-ID: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
Subject: regression of 'world' performance?
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 10:57:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15785

Hello all,

there seems to be a noticeable slowdown in bitbake doing world builds,
particularly when layers in meta-oe are added to it. I've locally
observed Cooker process spinning at 100% while no or few tasks get
executed, apparently deciding what to do next, and it is noticeable in
autobuilder too, e.g. right now:
https://autobuilder.yoctoproject.org/typhoon/#/builders/88/builds/3515

I'd like to profile what is happening, but not sure where to start. Suggestions?

Alex

