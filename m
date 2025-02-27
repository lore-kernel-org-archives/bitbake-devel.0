Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E3CC19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:42:28 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web11.7315.1740649339183454854
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 01:42:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nZh0b0a0;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c2303a56d6so76015085a.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740649338; x=1741254138; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAPef1XjUMfGMD3Tu86xo+MmA2j+0VM9HXNODX+7UP4=;
        b=nZh0b0a0IbnFueMV3oj8YmkI6bkGV/hXX/7ub5BxhNFJ4Qjz1bx2KrxIJiQUU755Dw
         f/ovyPYbcQie1Scvnct831lxdPdZr/2sF2SdKKcgywOc7nrAAKAcxIPnc9AQZLCe39Db
         ZqebEvW2L3ygfpcNeu+QBHxRMaQn4l7MYxoyTVKe9j/RbXTJwobdB76TGONF5FasGwVW
         8cTCrUYt5zdYuoPovxUCFD+0Ey2XyXBOotd/ara8z09mIvXQlC/k3iFDNzRHB/9mUvNX
         VvJaAj3UIqmkz/Bb6TmjHNYUHgJ1INFrXQUhcjuvJGZrJCg43KWEhl1SIGyIB7iKDp59
         NTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740649338; x=1741254138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAPef1XjUMfGMD3Tu86xo+MmA2j+0VM9HXNODX+7UP4=;
        b=TT/Ot9VNyLv6unDizWXb+rlBG3XcPmMG4PFH3ggUbRsHH4Oq2g1S78Q9Ri5kFcHpnr
         j58e3lvB8b97jVGA4neLHzdp3Qte1kxAc7OyubGnF74joyd8TEG6QtZvqWbh2UZMx8M6
         MyDcHKuwaU0Wcay67B7IjEhxmRds/qP82C7LN6Tz9NLi4iooa9MBJJhT7qhFKE74cpfX
         zz7EeR0/JzeuXP14UKlO3lFhyniqWgU2xHQBgjeFG98HQeQKJ5pxJdzx5eH419ys1t+l
         ty7je6gsuY26grdf2btjJ5TOS233GfBTHAMk29s/GAJbx7hAPpwqCdperM1ECUhXs3X1
         9x+g==
X-Gm-Message-State: AOJu0YwOLzfHBFgV++u40vdKMY9arBy/pyHnQgopo3awe+ZMtyIRWjxX
	Wi2fsaMlMdShehnoqG2uVWXIRZzPKvGV1xguHgnSBgY/vT6qwmNrXip7jBL0T4uD5OPgqU6+b9B
	f3sqhYS4fpsgHgWpIsuMCrtFMlu8VQO9U
X-Gm-Gg: ASbGnctxPh/ntuaSdm+KHfAouXNkYtCb16dU6ld7sTaUkXhOXeniz1hyjQQk3PLxjiE
	gHnlogbKrQaVOtOknY/MYqDoBLQHGAVHHPYTG/wCJT9wtu4pFZZtYcJXrgiZyqf1uk6VZvj4OJY
	H+6BnjKZU=
X-Google-Smtp-Source: AGHT+IFv0kG/zK4EejGDlvsaaRLsDps3FoLFc1E4rk7OgqhM8S3ooxdM85e5BJaaIQ5JVVn7U8ZJbGlN7DuG/hhjgkk=
X-Received: by 2002:a05:620a:2414:b0:7c0:cb96:831e with SMTP id
 af79cd13be357-7c0cf8ea13bmr3177939285a.27.1740649338084; Thu, 27 Feb 2025
 01:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de> <20250227090853.1632280-3-l.goehrs@pengutronix.de>
In-Reply-To: <20250227090853.1632280-3-l.goehrs@pengutronix.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 27 Feb 2025 10:42:05 +0100
X-Gm-Features: AQ5f1JobGgv5dKmgARRP8VawGzQD6FSxHOnS1QDSsOD0mAIC3Amr6i1oj2ws8Lw
Message-ID: <CANNYZj_8DU=8eFrbjEBPhupuu13KG7a19V9z_zcj+WPhWAQ_ig@mail.gmail.com>
Subject: Re: [docs] [PATCH v2 2/5] fetch2/github_release_artifact: fetcher for
 (private) release artifacts
To: lgo@pengutronix.de
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	yocto@pengutronix.de, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 09:42:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17343

On Thu, 27 Feb 2025 at 10:09, Leonard G=C3=B6hrs via lists.yoctoproject.org
<lgo=3Dpengutronix.de@lists.yoctoproject.org> wrote:

> Authentication is provided using tokens, for example by configuring them
> in the `local.conf`=C2=B9:
>
>   $ grep TOKEN build/conf/local.conf
>   GH_TOKEN =3D "github_pat_123456789abc...
>
> The token may also be provided using an environment variable,
> e.g. for CI builds:
>
>   $ export BB_ENV_PASSTHROUGH_ADDITIONS=3D"GH_TOKEN"
>   $ export GH_TOKEN=3D"github_pat_123456789abc...
>   $ bitbake rauc

Unfortunately I have to say no again. These still put the secret token
into a bitbake variable, and are therefore not any more secure than
just putting the token directly into a recipe. I have to restate: you
need to find a way for wget to pick up the needed token and produce a
header directly from netrc or similar file that is managed outside of
layer/bitbake metadata, so that bitbake never even sees it.

Alex

