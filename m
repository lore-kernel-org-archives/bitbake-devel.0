Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE055D3C930
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 17:23:03 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1445.1765387380540192495
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Dec 2025 09:23:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KqHFwF57;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-882379c0b14so656196d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Dec 2025 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765387379; x=1765992179; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBx5UXRx6JjvW1QGyq41xhh9naqoowYXmLDzBEDj/iA=;
        b=KqHFwF57g3asSnK/Sk9M/DxNBX1CKnwMsv4+xOMOfQCDJsBdWyr7lYjQIm5alQOJuX
         CVfmuGFQyntDAFX2pYno4tGVO9Iwe73ZFsVycrWOHzuq5bM3701LlyOAigVq/BR979UY
         kn8Q9yc28StRQvpEmBzKVklmZjkhviYfxC9QYGs8NMzzrH/tMyc4a7gqnAWCOjYR12dC
         eftkTUl93n9syZEpT7TZLh/QB0hkiYNJSlG2nEvLm5EhXs2+nw95li+Sl2c63wPynJ9Z
         rL8xA7IWUmNwx0yE/Smhsud7dU7g1HM/ngaS4Eb2nGIn05TBiv0mIIMdTBmfaCwqIEtt
         +akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765387379; x=1765992179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBx5UXRx6JjvW1QGyq41xhh9naqoowYXmLDzBEDj/iA=;
        b=lSoUcnd4A/KlVKMF7QNxxzUe12338DqSBXVwtIqqBh2M8dmaiZmL7DqMo54HuVZ4BT
         yApl+mXhsWc/Eu/AKF3lB6LhCy+H3C04d39GKKN5YSWHnMCvhENQQSSb7aszbjKn+O1e
         xJeBKNg7wKgQHzpDptnsKOKHVZBZYPkJDVL5RZRZy2R3BmmJs9TgcndjxTgZEZiJGOK/
         Jt/sk8gsTN35gQGddoSv/T8eePS/VMDRD66RCiDHeEPrt9iDAailMnJQq6vplrtyMrlB
         hx3BVY+F8Qp2StNwXpFYL0Enw5rO+NtsdINy/1k8U9RVvv8+l9fXT0Lh1jUBvSYlis0M
         Nr1Q==
X-Gm-Message-State: AOJu0YwPampgYf1hiGi+DaXurJ07jtDQOBghLTKx7GoqEqBehtSR3FNc
	IzIw8hZyFrhJLZ8Cu9bXdBOaFhm1XjWURrh/1ah6u4JEksgMoNp8oRpzaJO2nwwN3r9W794iZ6H
	oonwXjYpeBvFuH7+ZcWpg9MzOYMBxNIQ=
X-Gm-Gg: AY/fxX7nPgWRssQMuVczueEqbizVVdgXvQmhklF97VH907CNzDtTIMvgeoc2isa7P/F
	QUKjyE54WFyi2z653M/GRAL2nMrbEamiJxawjIh5ZQRg87/CTPFmoxK6FZhxHV9xZr29aYtwE7h
	qZI0UfuHAVh/n3yLpz7ZiOTQTTxWr8zralgMq2RHB3Ez8ro7H5hmbVHJjs05PGBPOliIddfbti1
	n++RZXrIrXVaHAwlG2/8Z74bCQ3mtVExhg+tEhb7mVRgNXVtGehHdjCW0Oe/lb376Ytv4poTvQv
	q1eWvsY6MdApJOtveuoGHRs/v9PeSw==
X-Google-Smtp-Source: AGHT+IEdikVEeCOzy14b2jjoLMpfSNnL9nobmaPueHgO3a6GRnDFPFNgo+MS/rZgAYzvxTkSA+vIfQj0PhvTdJJqbF0=
X-Received: by 2002:a05:6214:2b9c:b0:880:531a:a32d with SMTP id
 6a1803df08f44-88863ab6e99mr42019096d6.41.1765387379458; Wed, 10 Dec 2025
 09:22:59 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
 <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev>
 <18779541E6AD04B6.981615@lists.openembedded.org> <CANNYZj_p_FX1sb6UduS-5H=jsmBrZA5crpJFPi3juRXjRtarXQ@mail.gmail.com>
 <d6865d19f95b3e7a3addfc14f08ce042a82aa43c.camel@pbarker.dev>
In-Reply-To: <d6865d19f95b3e7a3addfc14f08ce042a82aa43c.camel@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 10 Dec 2025 18:22:48 +0100
X-Gm-Features: AQt7F2qBWWalg-XQmsUithrZa-IbeTxvNZguaiY_V_A6vowHbG4xLtam_-eDCYg
Message-ID: <CANNYZj8AsA45cW1T9vP14OKHpW3njABOsJ0Am3ddqWAw2YfhyQ@mail.gmail.com>
Subject: bitbake-setup: support local sources
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Dec 2025 17:23:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18559

On Thu, 13 Nov 2025 at 16:30, Paul Barker <paul@pbarker.dev> wrote:
> I think this may be enough of a solution. I also like the idea of
> bitbake-setup symlinking things into the layers directory so that we
> don't need to handle these paths as special cases.
>
> So, are we thinking of an override file like this?
>
>     {
>         "description": "Local overrides for development",
>         "sources": {
>             "bitbake": {
>                 "local": {
>                     "path": "~/src/bitbake"
>                 }
>             },
>             "openembedded-core": {
>                 "local": {
>                     "path": "~/src/openembedded-core"
>                 }
>             }
>         }
>     }
>
> I think it's important to support '~' in the path, we can easily call
> os.path.expanduser() to handle this. We should also support relative
> paths, which are interpreted as relative to directory containing the
> override json file.

I've (mostly) implemented this, and I realized it's easy to support
both the above, and a command line option from a single code path, so
people can pick what they prefer for any particular situation.

So there will also be support for the original idea, a kind of
shortcut/syntactic sugar (for this particular use of overrides) that
doesn't require making a file:

bitbake-setup init -L bitbake ~/src/bitbake -L openembedded-core
~/src/openembedded-core

Alex

