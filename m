Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C28AC7EE39
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 10:21:19 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.36208.1751278873911655300
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Jun 2025 03:21:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PrcT6Vyh;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso49088146d6.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Jun 2025 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751278873; x=1751883673; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvV2wTjllD7H8DRJELrqoxQvBLHDn2yq0tWZINXh2gc=;
        b=PrcT6Vyh/02c2fc6UbU+MCrwFeVT8kKLEFbkbKkIDi6NT0yCQwaG8Lat7Is+G9KBU/
         jXLgAMXBK1Z1VmKomxABDxXLPOVJaMDsal2V+EZ5JW8dM1p2F7t9EHaTG/9k5jDzIXhH
         Unc8EKBsSwNyhO4IB4TebLcQhPqgYzF0o+26ZMV8hNoA5RJyVeN5nJwUNvbYOjtx0zri
         lfZSyxA/TFjF5ErZ3lqcDSpL0C7wpvaGJ+sXoE/y9rFR4ACbAzOCPwrdwl0fW4n7+OKT
         thzRnpBTIJ7geYzyrrhkuVaDTUQLybpWimonYZEMMDdlpb1mazZULA109V/E8Z0fWJGP
         jy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278873; x=1751883673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvV2wTjllD7H8DRJELrqoxQvBLHDn2yq0tWZINXh2gc=;
        b=JCt982RcmONju1VFCO+ZwWFMV5Y1Ke9R/mMam5ijvFbA+HNXrLWMz6XwUCQvhj0wKd
         4tYIkRmMs4dB74fL/Cf0/6pI4pjCYT4OpPLTHeUI+bO/sA855qPvTwW0IX/pSj0n50u9
         xB3Q96ldVr+y7mXZYckPfL5uqxmLla58YnlEioyejlujg4E2pFV2G83EVhBGUe5ZbDLf
         C7I34fimCOuGHe7OeMnIRmPd+G2J85iU447muWvP86/vMvaBTsRXQNQYBhr/Ehlvs2zE
         DGcPCpvSLfzT0yHjuQnlg5VW9fJst0ddhrLW/dUwrvDojSkBhaIPpsq9y0m8Gv7XBqWc
         5rsw==
X-Forwarded-Encrypted: i=1; AJvYcCWdPPYY0/VUDDZakSrZuFyTD49O9fgl/MehxmY/ZdORKQRbNAYaMAxDjD6bnSwu/BkHmdCO9vrFtYauwEpN@lists.openembedded.org
X-Gm-Message-State: AOJu0YyhhFz8a87qo426iAsZs8X2fDEbM+tIryPDhEJvsZnJv44ZkJog
	mjlfHKpn+ex56F3rPxdQVa39XwcAwuNJ1lL60iNBbjkdKHlFD3WwjfUnbMQGNirIeGFj9plfex8
	ZtfpaQ5BjF5VCzNwmuRkI86IcBRq5xz4=
X-Gm-Gg: ASbGncskwSGNhXgDwMujJuwLVMHuxSLjVdvrjWmyo1s7YYH+lEXrXk+WjBxMocjfvjX
	8wXOpA7Y7dfAQqOqoz1mOiLwDywXVbs83D/d1lyQdee9oRcC4v2gUqDMsTm2gmuT35MGV8zsA5S
	mZ/1Fk8xqSsCCM4zQp4TDd40FTnPDwcKosQVNcu/icKZg9+1EuIab1R0yj7U4l4xPB6lkM3606b
	K009p3AWpek1095
X-Google-Smtp-Source: AGHT+IEprcyh/LbjqP1yo6jG080TLUZ8w6AxcBKpaMXIDJWzMvKFk48BfjqLjkdZkFuMzZ8C0NT8LXJeu65QX2W3syY=
X-Received: by 2002:a05:6214:f2b:b0:6fa:acc1:f077 with SMTP id
 6a1803df08f44-700134a8bb8mr178282166d6.35.1751278872827; Mon, 30 Jun 2025
 03:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250623165507.1633860-1-alex.kanavin@gmail.com>
 <6fb30604dfb196088f07c6b59f437eeb0f1df788.camel@linuxfoundation.org>
 <CANNYZj8bcMto=-OHPNEZs_aEM4vr9K1ujVOZ77EDBT-9xC5sRw@mail.gmail.com>
 <749dde0c3ed74dc938085cd15316245eeaa15cc4.camel@linuxfoundation.org>
 <184C05EBFBF7A622.2779@lists.yoctoproject.org> <184C4DB835DB2097.24592@lists.yoctoproject.org>
In-Reply-To: <184C4DB835DB2097.24592@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 30 Jun 2025 12:21:01 +0200
X-Gm-Features: Ac12FXwdf9RYPG8XpXf9gX7qnn_Ww2-m3EDOA7v3zUlUH_RxhIyhZl0zacIxfw8
Message-ID: <CANNYZj9JJXimG23QPDJ7kBZu1Q+ps9iS3dkf-HJqvWK+2q9VoQ@mail.gmail.com>
Subject: Re: [yocto] [poky] [PATCH 1/2] meta-poky/conf/templates/default/bblayers.conf.sample:
 do not assume integrated poky repo
To: yocto@lists.yoctoproject.org, alex.kanavin@gmail.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, poky@lists.yoctoproject.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Jun 2025 10:21:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17729

On Wed, 25 Jun 2025 at 15:56, Alexander Kanavin via
lists.yoctoproject.org <alex.kanavin=gmail.com@lists.yoctoproject.org>
wrote:

> Bitbake-setup would write out bblayers.conf with BBLAYERS entry
> ('bitbake-layers add-layer' can't be used at that point yet), and then
> enable fragments via bitbake-config-build (this is already
> implemented). This should result in a functional build directory, with
> a blank (or absent) local.conf.
>
> Then this patch, and the ones adding 'blank' templates become unnecessary.

I've now implemented this and resent the bitbake-setup patches. The
sample 'poky-ng' config that doesn't need templates and specifies
layers directly is here:

https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master.conf.json

Alex

