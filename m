Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19937C433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Feb 2022 22:01:19 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.web12.1985.1644444078100516804
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Feb 2022 14:01:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oNO6iBg5;
 spf=pass (domain: gmail.com, ip: 209.85.217.49,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs1-f49.google.com with SMTP id w6so3828315vsf.3
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Feb 2022 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3BtZkSIsAGjHjnnLZXp+x8fWQLZcWc+yu8gLTGt4OM=;
        b=oNO6iBg55KV+WC0ACZa7pYdAUAFWokFJcaRppU3DJBU9KComjveN1Zr/AvJ3CInpiP
         3tbGt1mJgiJlHHZnoQTYuXkFiDc/7fRqHI8YNT0yHzQ93qTDr2iYBI6CS+F9H9mFj31N
         /yUsDmeBSYn5EowjtCmL0id5UHKYebZO6CZ+x/oI2CJk5ttBiuY0QcjDu7IZzUlQxmKc
         /6dFY1dVOC9Ml1/RQP89JQMjEprL5Ax5FXV0axheXSTOUiPYYvUnPJ+bWvIqoQq4meni
         crgQBxA5x++CmRLdYs3tHyBSHG77qjsDoyPSj7JdjohX0EQhOTcrdoAmRbUBzoyXyGoX
         ZOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3BtZkSIsAGjHjnnLZXp+x8fWQLZcWc+yu8gLTGt4OM=;
        b=7AJcYtcqrf1FOE6B2AWQUC3bcIa1beIUwpFMnQqwF80macSuw4l7Tc/O+V3Qbmxl+B
         RcZbM3NQ5+WeS5vOD28ZfrRDoLpVxzMdHH8lHNnMQpN23jDXQhLGNZk/vt3LJnatnLf7
         9tBsr8L5KPLOh3y9syTxGvKh1076KaTA7bT88rlAr2l/lVLg7iUJinTiXWcLMVQeyzXE
         VUaZLfSseyg1DnC8C6GR/W/+xosMLzbGinhX3B3nFJh+2fFYSWN8Sm349IkTzFNUf3pn
         Ozj3zbrkhW5k+RyKwFnXkLiXoOVkS3ksi+qZGD3cExLJpAPp3H8EJYkdZTNAILCZ4fIu
         narA==
X-Gm-Message-State: AOAM532y39lZtaCAIq67YteOPx9FXYJcRueuvA9hpzjauzC0x4gHTr0p
	phMPEMOtTfGB9E7S43ZPHVvh77rGcfa69jFGybE=
X-Google-Smtp-Source: 
 ABdhPJzYqI29BmUJJYyodDl8sz7s4l4+BmnLQwk2yG005j6KoSjjKw+l1HRgYBItocbEXC/vrKBguqSWoSk4s4dTqis=
X-Received: by 2002:a67:fc16:: with SMTP id o22mr57947vsq.42.1644444077238;
 Wed, 09 Feb 2022 14:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20220209214018.363691-1-alex@linutronix.de>
 <0f1f2eace443402fca3790908033286be4a9b0e0.camel@linuxfoundation.org>
In-Reply-To: 
 <0f1f2eace443402fca3790908033286be4a9b0e0.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 9 Feb 2022 23:01:05 +0100
Message-ID: 
 <CANNYZj9wDgfTEUdrToHxenEDrLHGW+KZ-VaWYn6o4Je6k=A1uw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] wget.py: use a longer timeout in
 checkstatus()
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Halstead <mhalstead@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Feb 2022 22:01:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13325

On Wed, 9 Feb 2022 at 22:47, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> We need to fix the servers. I doubt that at 300s it would work much better but
> the user experience would be horrible with builds hanging at startup for 5
> minutes.

The tracebacks are showing both straightforward timeouts, and timeouts
while handling a server 503 error (presumably urllib has a built-in
retry mechanism which is thwarted by the 30 sec timeout). I guess I
mostly wanted to see if bumping the timeout value resolves those
errors, and in at least in my a-full they did not show up.

Checking the server logs would be helpful: they probably do say
something useful when issuing 503.

Alex

