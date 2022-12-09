Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B5EC4332F
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 15:24:04 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.4123.1670599442838536234
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Dec 2022 07:24:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kpHhI0d7;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id x11so5247914ljh.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 07:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rJgpALY5jYVbc8Q/fEFaq7faPFANkegpj+9bzKpz1mQ=;
        b=kpHhI0d7EeGxOK10qJiPUTD/eJIASBuxqkU+yWJ0IWM7WG42ou/+GN94QvX4/GiLH6
         VHf9XRHk4y0ZXOI9DGsRT9LkAqBLfLCRVT6Mcdk73Vu6DptAgm6OaTPEDas4KBpWgq8c
         JkmMy5Ddd1L/2cju7t58JBnTtOH3FzZtSJEWP+IW4JDQB/C8ojAoqjN+krpeJ4OV6I/e
         yEMTamrM7T7+Yi8XNSKoOFXVWGB88FEBpS4/HmFriwoskeD2e9sDG3wtLO83av5kfF6O
         0LBIuqfcdCZYSTEYqZ9cI1MtPy3DvhYawBWUCPRnnvER5TNJ1xEtKSwGXuuj4uSD+i0a
         K0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJgpALY5jYVbc8Q/fEFaq7faPFANkegpj+9bzKpz1mQ=;
        b=l3vuvC9yov4RIbqvN8ru/MG9pEN0EXvuAeIyZyLlOrybtwESWpkD6Q1UJbaVOVRr0C
         AED0ctXZVCuj0jzzqRpSxauESqlD3Dxvf7xPpcL9IkNZjreNXPLp8sR5VGXseHxoUV1E
         gpFkjPGDJ4rTa+ph4hmt2zT5JyFgkbAmqHvFwjy6yPg6gXOYWfYG2j8lOPofEfORWPYx
         xLIFmRaoA70x+10QY31/OSsptay5YNWpSIYLTv9YUdyX5v2SRXKtGNCS7tB7VDewMKQJ
         nsZa6eTxIFRJoDT5pGWZF6JfeatJhRe5yQgmE67Afu6ZUGnYaf//B/ldLCFC8RcT6iP9
         amvg==
X-Gm-Message-State: ANoB5pkeXAkPJNKIn+gw9QFzms2RYrDfJ93bVbM+0GFHSoWcE020arVX
	4z+27IqA+eFk2wrfBjqxtsv+FzGJut5pGrmpVtQ=
X-Google-Smtp-Source: AA0mqf7NUnixtUAk9wlOtnnpqHiYPud6IYCCpE8YAqUibX5FprrZdkrVr4E9056P/2Uflu/Yba614EcMZwgNbTlb8yA=
X-Received: by 2002:a2e:9584:0:b0:27a:2285:411b with SMTP id
 w4-20020a2e9584000000b0027a2285411bmr1605739ljh.33.1670599440759; Fri, 09 Dec
 2022 07:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20221209085840.3733809-1-alex@linutronix.de> <Y5NJPlVxNR7kQsG1@mail.local>
 <CANNYZj_WLrfAUWjDu1Bqd+MTc+JO9p7YMH0qaQMFpe212Bx=0A@mail.gmail.com> <Y5NLdKDFJXGo7X/R@mail.local>
In-Reply-To: <Y5NLdKDFJXGo7X/R@mail.local>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Dec 2022 16:23:49 +0100
Message-ID: <CANNYZj8yB7ThFEnssxReBi919zrN6qqbtNQR=psKYioCNYJqQQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/wget.py: correctly match
 versioned directories
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 15:24:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14165

On Fri, 9 Dec 2022 at 15:51, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 09/12/2022 15:46:39+0100, Alexander Kanavin wrote:
> > That is not a failure. It tries ipv6 first, then ipv4 - the former
> > fails, the latter succeeds. Are you getting an actual red result, and
> > can I see the link?
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/4493/steps/12/logs/stdio
>
> I guess the correct one is:
>
> Resolving localhost (localhost)... ::1, 127.0.0.1
> Connecting to localhost (localhost)|::1|:46501... failed: Connection refused.
> Connecting to localhost (localhost)|127.0.0.1|:46501... connected.
> HTTP request sent, awaiting response... 404 File not found
> 2022-12-09 13:21:18 ERROR 404: File not found.

I was scratching my head, until I looked at the commit in your branch:
https://git.yoctoproject.org/poky-contrib/commit/?h=abelloni/master-next&id=7b3866c5f4a92fb9013402813c38c1592769cc68

The test data somehow gained an additional 'bitbake/' in its path, and
so ends up in the wrong folder.

Alex

