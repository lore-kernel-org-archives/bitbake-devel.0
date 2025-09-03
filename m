Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58760CA1009
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 12:15:12 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web11.10765.1756901707288663966
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Sep 2025 05:15:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RFYX/GjZ;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-721504645aaso9459136d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901706; x=1757506506; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0DxXiQCwY0+P4FN2UPkcuWsg0F9GlPEQl3CQQ2h8a8c=;
        b=RFYX/GjZzZbdZn5nCrkS9XIDDdJs6zDG9wR6h2q+6ZT1nJfkbhugCgcf7yFK4CjBul
         mD+Au5k/VtQ9ooG/L+EU2x8ziAxdixlL8yhcGxqs+V5diahDGF5odFCXuO2jVbja0qVM
         233tV7JmeE2z/OE1KZGGJeuatbpJhCCtgQUb1Atpo8/4vXwYvraok5qjPkEk/PW4eIxU
         fu25j3YyhqeNHIcPxaax9C0rDr1Tn5JrvnMnwh3naW33bl+RR+IxbfaYfO0AJb9IQjJY
         2KYWEcyeIFT+fxW6ahPKF1jpgBaxuZE96YI6Zc1rnhmsiNvurEwh5cK2nd7FCNdcyyAv
         oCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901706; x=1757506506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DxXiQCwY0+P4FN2UPkcuWsg0F9GlPEQl3CQQ2h8a8c=;
        b=qF3X+qup3/rOurE1Et6DEUG7yDOuSMOKWs9L5z9j8aaPAKyfEpReVzEmlkVPUnL/cB
         B7cZpC5NtYYDvefNlHO/fyyk5KR+83NmrNWXdRF5YqnemjNO0pTctRT2yfd6FNLDlQjv
         TyyAJbgGhkMYdFBQ5fexTw8aRM62gzkSJMQm0qUBrrr7PQmE2e5KvToOzQcmRirIe87B
         cvjISV5HqtUYxjqZFjXoKS8Q0d7Z1OqeNNgOC0KCtdui71ZLB/AgApvA9pzd+0y3Wagw
         QFNI0p1B5Y3pWuHcz75v7wM0FDxyGMCwm0Ue4l22P4lENw7Q96z7L2yyuJVPbME6KtGt
         WI9g==
X-Gm-Message-State: AOJu0YwB0pdS7Y6WvV189aM7X1b+aOr+VoU4ZANvVRbR+bFf0kXf+DhN
	kCKHNPNKUB96xu36r26Zl9h4b4B+Pe23uN6Fu+YKFqmYkHSlvbtABIY7z6/fBiHTo5Q9JaumJum
	BjJ8hrM6R1ll5UXEmRmZfQmNBy0VczvU=
X-Gm-Gg: ASbGnctOHj7cBXY0YSjkQ8SZT3aEYdBPRL8jzsyGoOjmewhEKQHY4puZ6at1H03HMkP
	RYQroEJyZQcqoOvtCTJ6tSxtAgrZ7adPEXdOlMYDzzZ2HMwc6in5KSYSZxYw2qws+g/yBLlVp5E
	lQISabn6Lpf5GFdysvJ27z/mjrqIP+uZt3w+Pz3aMpUeVgEhB8GLEx5R8jli1xTah4RZc1y4/tQ
	uNaVr4Kh+q1VfVN4/xK64XZciYds1IPUPyEG90PaVK90MdvyyvIqS5gdpXg6GmYSN7bbUPrKtTQ
	WOI0iPQx2uu2iipY8GYAsq3qOOo41O7Bs5HVKgx7
X-Google-Smtp-Source: AGHT+IHBWGmuj+UFly10MtyNhP9u1Peo2+x7g5DNJdOkvjQyL5rc9Pv+FTOvslbZ2oNM/Bcz3GqakDMbXCf67OMXNW4=
X-Received: by 2002:a05:6214:76b:b0:70f:a874:9838 with SMTP id
 6a1803df08f44-70fac544bc6mr148505886d6.0.1756901706128; Wed, 03 Sep 2025
 05:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <20250901135836.2927686-6-alex.kanavin@gmail.com> <DB5PR02MB1021363CFCC9D5EDC1217D085EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <CANNYZj_drPD8qO_7JfYLc7Px77OdOM3Mp1MUhtd+nU7h8mnFBQ@mail.gmail.com> <DB5PR02MB102139E511197B10DA2348737EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB102139E511197B10DA2348737EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 3 Sep 2025 14:14:55 +0200
X-Gm-Features: Ac12FXyfr4x2UcYCf5M2apOA9259fR0Jos11qyuOljd7IX0J5pVunYG1gGrkSSI
Message-ID: <CANNYZj_z1++QHks=dd_GJ9nyRWdVpCOekm7A1Hk+UW3C9NrYew@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 6/6] bitbake-setup: make sure git user is
 always configured
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Gyorgy Sarvari <skandigraun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 12:15:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17950

On Wed, 3 Sept 2025 at 00:32, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> There is no allowlist as the intent is that the Git configuration
> must be valid (which we define as the configured Git name and email
> must match what is in our LDAP database). Users typically use
> the --no-verify option if they have to override the hook for some
> reason. Which I guess would be an alternative here too...

This I've now added locally. I haven't pushed the changes yet, as I
also need to implement the top-dir-prefix idea.

Alex

