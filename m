Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA7BCE8E7C
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 14:07:37 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.15466.1729778849621949683
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Oct 2024 07:07:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AfC92Sws;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53a0c160b94so1184925e87.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Oct 2024 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729778848; x=1730383648; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sEEDqMqqjEZKSM3PfZpBh/iFkV08yxJXG3k7mlHRyiw=;
        b=AfC92SwsGub8qiC4sQpuBL2G2rce3SScZRhDjla5uVXQS3t6ZrK+B5xOZXGu9x181h
         vEYGKRqn6yx+HkInfs7kWIVjFNSl03vkUfTyypAcT5ZaVbEIKI4ZAAAdWSQXYJmFdNxq
         ysfYmV+klbt5LOk5omCF3haPkic4BqCGRSJ8XQLMqZB35EL41KtAZMLC1s8mOPO32dAr
         /Qw6doySLtDdgrxnWizn4qBDqf498qWJgBIpP4jFmubKqEyDL/Nn12O1FsGlSFqvih1P
         gQjB8V16gY9Msok//bIJpB80marAtMONVXDMTbY58uJdcm5YiGGOJZ1tS6Ofxi1d8nhW
         5lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729778848; x=1730383648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEEDqMqqjEZKSM3PfZpBh/iFkV08yxJXG3k7mlHRyiw=;
        b=H1vadxnHZ9U3iLxwUGdntlalb3amRMRgSOCa0mTCiPD9Bkn9pgQugC9BrGX78h0eOY
         sGcttJI+hWDvdTk2yZj2wDPVbAsW85wd7yEeJP0M9nGZ6EKs6nHNpqpyxkJjj2cGhVZ2
         /m2q6Z+VGMMd7XrTmPmQquULCf0YBymms/fQQCYf/a5x9NRFNfNDiKOamfeMnuT8Apof
         QJ3JQd40S+6QF3OuK4gosd32/CapncQzb2cNUDM0is+YbiblFUPMn4B4yEhEkDXQ5x4Z
         V4H5nnELJJ7m9PtTRql5kEBu/waZ0vCpJhT5+gNOZE721RCGRDzhxw8wgNHu8Svc5yMC
         7FRw==
X-Gm-Message-State: AOJu0Yy5S0QAkaSgLwmUwFZDQ3Fo69h3OH9YXH5NaF7UPn/Os4UOsXqg
	Z79XOXbhe39ecB0zAKLeUfyab8KsvRf8jmoDybIhUbC3dK/yyIs3/RyP0OONgM66CCgiaEfyALJ
	5ChvqmHJ6or7hlJ6H/ZgJhQ7GDQc=
X-Google-Smtp-Source: AGHT+IGZl/tLhoYVh5Q12aOPjWIs0S1jLXVp+ohQB2ri/cDLQmIkjonaGueyD+LGz/NpOZtJLj1f7q2pYo2Pls6Ksb4=
X-Received: by 2002:a05:6512:3f17:b0:538:9e24:a3c9 with SMTP id
 2adb3069b0e04-53b1a302932mr3272097e87.20.1729778847406; Thu, 24 Oct 2024
 07:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <00b87e99-7b7d-4cdb-b800-000860eb0263@googlemail.com>
In-Reply-To: <00b87e99-7b7d-4cdb-b800-000860eb0263@googlemail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 24 Oct 2024 16:07:14 +0200
Message-ID: <CANNYZj-nrsNXbhLQ+m67ck6Ss+Twcxx=Xh8JfKFc=UO3FZ8OJg@mail.gmail.com>
Subject: Re: [bitbake-devel] Stupid Noob question
To: matthias.schoepfer@googlemail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Oct 2024 14:07:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16724

On Thu, 24 Oct 2024 at 15:42, Matthias Schoepfer via
lists.openembedded.org
<matthias.schoepfer=googlemail.com@lists.openembedded.org> wrote:
> I am stepping totally out of my comfort zone and had the idea to write a
> custom fetcher (shall pull docker images O.o). From reading through some
> of the code of fetch2, I would guess there is no way to register a new
> fetcher from outside of the bitbake code itself. Please correct me, if I
> am wrong.

Please remember to write a good subject for your message that tells
what it's about.

Fetcher set is non-extensible by design, as allowing easy additions
would only result in people writing all sorts of crazy layer-specific
stuff that works around restrictions in existing implementations that
are there for good reasons.

You're still welcome to add your own fetcher as a way to learn and
experiment, but if it's merely pulling things over http with a
specific custom URL schema, then that might be implemented in a class
instead, reusing existing http fetcher.

Alex

