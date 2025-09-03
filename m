Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAABCA1009
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 09:57:21 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.8626.1756893435746975641
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Sep 2025 02:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JKC+HI5I;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70fa0e37bc5so24886206d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756893435; x=1757498235; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iwBBTQktH17rb8Mlsr0UdHMo+QvrfdjE1P4rutF4os4=;
        b=JKC+HI5INTJA2jOonp4UHUY49ZnpTjFxX3NsbK2DDHdyB57z6PQHyP5/sc6gv3G9et
         QuUs2OEQEaCf80NKkO2wouwgZYOXz48jLahOOP7BK8i+bX6y8tpyPQMK/UE84hmn7vUn
         qi7nJIahjevtyJL7D2rwXjIoE2pfvy3kfqGKgGDMOQKDw2fGHlHsODfD0xTyPYo03ddm
         9XQMWexFArsfbJrD37wq8aknB1YA2bfnEocajj0tDJfxLALLXgvR5d8abFnlPYE6XYDA
         H+ZJrsAsaNVo4+Rj2wuscZfGduMO8eC0g5adygAdDS/PLp1xDpQ2sEKiOqzpTVIvIXNI
         r1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893435; x=1757498235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwBBTQktH17rb8Mlsr0UdHMo+QvrfdjE1P4rutF4os4=;
        b=GxUQyIVBv5v1+ksP4mJysx5D83Cd86GYCr7ateOmYYxtvPGTgFuaDaJPfDDV8RRYjZ
         rppijX7T5PJY0VDQ6zo2KqWDrVBJja9UbACCXOgxttr7TxIDL1hAxm1lwPZIQmJrQCZj
         KQkyBg9Ov/nPJoYjq1FhmpylIHqXRA/Te4yLabEgQyrz2zw2vFLBduJcVzaYGqdry6nL
         FBrKN/SE9Qdpri90tb9RnpwAL3umEXG40BRQk0s3VLS3xXzEDdTtcXmd4WBbN9dcn/l8
         XEC6LUg3r5bYPZPyxhM2CukNz4ZUhcb8iuc0q839woxFK//s6hw3JTBZFS3D8/z0Tu3X
         BHHA==
X-Gm-Message-State: AOJu0Yzaiv0sLpMKl5KTywmz5iBz5IBvce8YZFBnBLbn0a8gUNqs1maK
	xxtWQo1Dj78a2josZNEhVW9uLe7B4PaKaOryGQk2HQe8nh+1dcke/xz9eQ0Xc/v5g0wNwFYHFI/
	eUjmQbijOmpSbsnLE3g9T7Bfm4AKu+gU=
X-Gm-Gg: ASbGncv79KQv0IKdD4RnDIguUlpKTikRK0JEnRLYN/0onBRm7tE7Q/qzRKbgkLAy+DP
	CzrbJtqp0vay5P/RvNG6fkHzPLMJmFm92Zw3skv6hrxfZ04pI78c9PiR86A0UpgzES1TJow75fJ
	Z8HOKbN/v0U+mX9SyBNPyRg9JqLIvEhatuoG6B6LLYAFBeH+kDbc9dRkJEeG5qkDUVZ1BCtA6UQ
	LvpTMCB23QUIVqjusXDdcxb46I1gO23PC7syN2Kzfl4kHW4Yq6xt03VoEYFtfVbOOYDqhQjrstd
	J2R4D00neF/d5ot4560wlxGYYtd92G3myndE7Tz6
X-Google-Smtp-Source: AGHT+IFaS30aBzdWp8igzBBqaheNz8aLyT7dl00+Mxk+sTVhmS48cTIKlBcGYhdxn7Q2ag+Ge1ecGakcC47Q7atVfKg=
X-Received: by 2002:ad4:574b:0:b0:70d:e83a:4b86 with SMTP id
 6a1803df08f44-70fac74b0ecmr159647856d6.17.1756893434659; Wed, 03 Sep 2025
 02:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <20250901135836.2927686-6-alex.kanavin@gmail.com> <DB5PR02MB1021363CFCC9D5EDC1217D085EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <CANNYZj_drPD8qO_7JfYLc7Px77OdOM3Mp1MUhtd+nU7h8mnFBQ@mail.gmail.com> <DB5PR02MB102139E511197B10DA2348737EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB102139E511197B10DA2348737EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 3 Sep 2025 11:57:02 +0200
X-Gm-Features: Ac12FXxAkO4I7m7b2tDN017Mh6OrF1n5njZu6yROs4F1kYFMD4vSWKa7cJekZr4
Message-ID: <CANNYZj8YF_yNojh-RmMydByomyXZOB9pfjFx7ZfMhUwTr09P2g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 6/6] bitbake-setup: make sure git user is
 always configured
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Gyorgy Sarvari <skandigraun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 09:57:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17949

On Wed, 3 Sept 2025 at 00:32, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> > I'm not fully comfortable with doing that. The commits in this repo
> > are created by a program, and so the author should be the program, not
> > the user running it (who did not give consent to use their name and
> > email, regardless of how harmless the content is).
>
> I must admit I have never thought that way. In my opinion, I'm
> creating the commit regardless of that it is some tool I am
> using that is creating it for me.

I would agree to have me as author of the commit only if I wrote the
tool myself (not true for users of bitbake-setup), or the tool stops
and gives me a chance to look at the changes before making them (also
not true for bitbake-setup).

It's not any different from sending automated emails, if they come
from a bot, then that should be made clear. I don't sign AUH emails
with my own name, even though I maintain the periodic autobuilder job
and the tools that produce them.

> > Can you fix the hook to run on pushes, and not commits? Or add
> > bitbake-setup to allowlist?
>
> The whole point of that hook is to catch misconfigurations before
> they make it into any repository, i.e., at the time a commit is
> created/updated.

But you can also perform that check when users run 'git push', and
reject the push. It's a far more common way of enforcing rules.
Restricting their commits is a step too far imo, and once again puts
you into the situation of having to ask the yocto project to handle
your organization's 'special needs'.

Alex

