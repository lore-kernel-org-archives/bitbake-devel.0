Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB3C02188
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 14:39:20 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web10.52980.1737988754865238883
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 06:39:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aIHCs/Me;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b98a2e3b3eso236654685a.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737988754; x=1738593554; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSnXWhCBFD2+sKwU223lqiwGTPdZjR49GA9MTDXvPVw=;
        b=aIHCs/MemxSzagB6uwky/bZBpLsF/zWZIaybvdazsygLrc1JHYvQiSgYDaEvJJV59l
         /uIA39jbg4TD3K7VM4EYyD2l9n+9K+/Eqq3Ju78ghYsyKpuhlm1i4vzHaHy5haJb/pTl
         PrO8haY4+IMLk0/oiiUImmHsQn8C5fZWxpCpyzOxoAiTaf3G5gWg4lF7Hm+peB1m4hAK
         imBdOoaTijKn0+5/ns/ehnUP6phFoU3kG4lD2fRRyAIp54C8alUqtj8yduKoo2sCMWEf
         yKHtfczrrmtgIdOStdILtOiG2onMJTr/ZYLGA6cHjRVgBbf8Y/TZjEguCyFrQBJWiZlC
         UtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988754; x=1738593554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSnXWhCBFD2+sKwU223lqiwGTPdZjR49GA9MTDXvPVw=;
        b=jeyRHQ9sRzgtIt2ij5/8J6s1NN4HoO7ODNqABuJmMMd6pM0KG7QdTpsQY8nXeZ6+D4
         aWgPL3LBOyn21CbFu20mHINaYe/7jxSVPZq8H1oDn0QeTzRILxGej0UePld1q5RbYRNV
         tKQJLzly9EkclbPGARPvSmWi2gGihXqsfQiKLqmvvZHKaGabM2ZjUW2oUbSCCQDAck3/
         DkvmtwZYQb5q1SaDbckITabVe7/uMChWdIeSZAW4wReBdfuBWsX/cyH0jEcTbU8pkMs/
         QPm78GOhSLUIBZkfuiBQ3JCSez0zQctUV/Y4mDBnL8n2LRw/8OuVrlIwrI7RLYbgX2mN
         QjGw==
X-Gm-Message-State: AOJu0YwV60dd4BQOmBDUilrnTA7ICvtc1ycP+gOo9bk4kgSM3PWlipQL
	hzCHT2XFnxWLtJ0dAjXnW6vVKUx6jG4y3UuG+cI33q0RLhtkqDOeXLRaJG1YhzGmAu1Hqr0b3pB
	VLyXgIX5gkFX7Gd36hB/TaKVvpnc2aw==
X-Gm-Gg: ASbGnctrHaKsgBNKKbrEETEzu6JBYLH3sM3rQx6Y+5Mv+gfJ7bYKiz/J0k0+r1A5enp
	XWrykOgUTD+CQ9uECUPqrlM1uhjZu7tKJ14c0UBdJROGfcMRVDrS5MJ162XCgiBGjDzgQWw3Vrz
	VKpcoJ+CxgHfb62EkkiloszmUseBUTTKQ=
X-Google-Smtp-Source: AGHT+IFgUgbfD+itrBzoUrf8zo3HpQ21KM5VWml2RcBA6o5CkvjpkvxQkQHfPvtQsJ+5CsoJnmZ81QzVucb3JYfo9RQ=
X-Received: by 2002:a05:6214:4401:b0:6e1:a5c1:d52d with SMTP id
 6a1803df08f44-6e1b21c46bdmr667493526d6.31.1737988753832; Mon, 27 Jan 2025
 06:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20250127142918.163-1-eric.meyers@arthrex.com>
In-Reply-To: <20250127142918.163-1-eric.meyers@arthrex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Jan 2025 15:39:02 +0100
X-Gm-Features: AWEUYZnQroTKG7ivItnxzkpsM-5MnNZ-kSaV2zF-dJH3Is1H9Gc4KRf4qWNGj2U
Message-ID: <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] NPM/NPM Shrinkwrap Basic
 Authentication Credential Support:
To: eric.meyers15310@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	"eric.meyers@arthrex.com" <eric.meyers@arthrex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 14:39:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17100

On Mon, 27 Jan 2025 at 15:29, eric.meyers15310 via
lists.openembedded.org
<eric.meyers15310=3Dgmail.com@lists.openembedded.org> wrote:
> Changes in this commit include:
> - npm fetcher changes:
>     - Add =E2=80=9Cusername=3D=E2=80=9D, =E2=80=9Cpassword=3D=E2=80=9D, a=
nd =E2=80=9Cnamespace=3D=E2=80=9D parameters to =E2=80=9Cnpm://=E2=80=9D SR=
C_URI
>         - These parameters will be used to create a =E2=80=9Cnpmrc=E2=80=
=9D file that is passed into the NpmEnvironment object - used for authentic=
ation when connecting to NPM registry

You need to create the file with a separate step, then point the
fetcher or the underlying executable to use it. We do not allow
credentials in recipes or other metadata that gets committed to a
layer repo. It's not different from placing ssh keys or http passwords
into respective files in $HOME.

Alex

