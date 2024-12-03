Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A030E6689A
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 10:06:23 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web10.15829.1733220380795837973
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Dec 2024 02:06:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bPZJBS5z;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d882699271so29235276d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Dec 2024 02:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733220380; x=1733825180; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GoJ/WDja0ykgpc9AQQ1gv2mYciZHT0FbSPC0wd3O9A=;
        b=bPZJBS5zmDTLyx+eZxDSPNhJZTUwGMhuTT0T5AaLSQTgqTwMQiTUjKD8tfCygk565G
         cAYsjQsbY5lZKwuejAJLCrYqBIH7kZ/rCT5KUnu1EAHCzR7XjyFi6dYeokgUh/7HO2RK
         7sHS2r4Lvu8lTd5X8NB6XmzTojJtqJ0NHJS6Jkd3c/ihGn2gVW6U4izaKDlrGGmoil9n
         lF5NE9dHe3MLAcLk7jRAk1gw1UDQkn2LxbTtAexZCx8PlhpZfOCYJli6nuuUJ3F4pt3Q
         qx0fHoOrltCsf/ivQuNoCg0FKI7WucezwOtA2rRYWq0SkcsVti4EjVxMv747rqo4HDBw
         yopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220380; x=1733825180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GoJ/WDja0ykgpc9AQQ1gv2mYciZHT0FbSPC0wd3O9A=;
        b=DniqojjXJw2sfc0f6ini6lME+K7CU7KYHMXBQT/Fe9eAJIQweSgRvRQcs0h3+MXLfx
         946ipmzDm2W0OW+U2zzNfkT+EcBMDA6zSWca6z/YLm2Le4wI9IkKqJC4XBFd8B29+FNB
         ZOojF8ctZHh+iT7VffTCnKZiZMkqnMDgNFPl5RzJ0wQNoqrbN//vZqFBs08dsZABPsiZ
         VxJGSpkgozAxnNMwRTxwa/AqE5pqqteWpN7ppSlURjpwlY4seJJfO0VPRDH8Wx3al2ho
         NiquKtSDe215OcGoJZLV/KMvxgVLA4cDCjykJuTIN7bRnaY7kZCa86Gc8pYafwwhq0hu
         2m4Q==
X-Gm-Message-State: AOJu0YyfqtbZkrTq+xr7sbKld9r6bGq+IuZKn9mPZO75LIr5B8Z7Fzkx
	TAESyFwPItcwM3hJ9J+1k9SFDia7tIcTUiEmq5uw/QwG0l323SXzGHndK7HCiG9UDr6YAsJdeH6
	NSL4cdsri5L7tpTYFEn2mqm+uwu4=
X-Gm-Gg: ASbGncsPOyu4ejOptTq5NzsAWVF8KMAxO8KqFy4scXA4CE+xVd2gOzcGYO61PFvCiPh
	Hn1AUG3SBglCuJc/aURUoDMi7jr6gNzLpNSrlsxoWrJMVV/BntmKZttOXZ74vm1l1Qg==
X-Google-Smtp-Source: AGHT+IGRYnDOIfqKJ3WNcGfjfGwufs6BjFFro0UV8RLjS+Q16v3czgVGsqmqQO5OG61Mfu1YmKoSWL9VhpZu2iQUqhY=
X-Received: by 2002:a05:6214:2aa1:b0:6d4:2131:563c with SMTP id
 6a1803df08f44-6d8b7387ceamr25095246d6.27.1733220379681; Tue, 03 Dec 2024
 02:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20241129125524.131362-1-richard.purdie@linuxfoundation.org>
 <CANNYZj_sJuUFJc9V37yhvjeFukqQ-A7GRC5SUwc+WMM24bvSeA@mail.gmail.com> <ae9a07452b8df67f44ead3a83d177e57cf4034c0.camel@linuxfoundation.org>
In-Reply-To: <ae9a07452b8df67f44ead3a83d177e57cf4034c0.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 3 Dec 2024 11:06:08 +0100
Message-ID: <CANNYZj9CO+PxHG_3q9iB7kYYGnjiZEyBTbciohoOsQJhjU_33A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Fix performance of multiconfigs
 with large overlap
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Dec 2024 10:06:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16856

On Fri, 29 Nov 2024 at 19:54, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> > I noticed that particularly 'bitbake core-image-ptest-all' tends to
> > sit for significant amount of time without spawning tasks. I
> > cherry-picked this patch and it doesn't seem to be helping :(
>
> Try:
>
> https://git.yoctoproject.org/poky/commit/?h=master-next&id=6522505769cea6bf96739469e64ec3a0a99be2b4
>
> since the issue there appears to be a different performance bottleneck.

Thanks, this does seem to improve things. The typical pattern was
pulling latest changes from master, and rebasing whatever I've been
working on (typically some version update batch). This results in
sstate being only half-populated and bitbake seemingly having trouble
figuring out what task to run next. Hash equivalence is always local
for me.

Alex

