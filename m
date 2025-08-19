Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DC0CA0EF5
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 10:29:42 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web10.10582.1755599374537856239
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 03:29:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ibeTk0IM;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70ba7aa13b3so44496716d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755599373; x=1756204173; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdyNmBrxQzIzoG5ij6SnGZlIRL4bvK0/qAlKJnvOpj8=;
        b=ibeTk0IMZjc3rxQXLOEe0XqLG0Ac/zdi40n7mshMUY4lrDxv5lMT8aYU/50uTF36ua
         96MTDEqWqvGMB9/3T/wUGCq76zC2l8LZqMqZD2JptviU0UHkvveHA3UwgfSV5I6RQ1UM
         wnKYVTFHF1AN2NIr2R67AuOZgY7D0L8LivHKTIedxq/EJFuLYFkJ8vePs5KH8+GF7z/N
         blTHepASoZSY2BPrVcFGiMGS+iQhrK9OAZilV+m62AxEObrePN1X/0by/UJ1jizU6j7u
         wiyzMZjSdh5e11apu4IuOvHZP/hlDZTQwKGw9IW0PXzfN9SXrgry/Q55rFHo9rj9GF4k
         9BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599373; x=1756204173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdyNmBrxQzIzoG5ij6SnGZlIRL4bvK0/qAlKJnvOpj8=;
        b=abkrk5grkYxcxTUa86oBaa7jhQnOvpcpA5cjEWXUmEzgA0OEXSbW4c0bWC9XeVkoK5
         LaW3J9w6asx/hnTIpEKUKWqvX8rnu9ciOKQ+nn6D6dUDNC/oYI/3ehd4VyOiltFQEkRB
         qGv3rBsjVsR8t9ABn9Y77P0EjY1150jVAef6uo+Fo5CBpMh8MQbl3kN3OsaJQ5zDcfDK
         94TS72wCZbH/RU0e+XgtkQSQii8gfKRgFesWTWyh85IISYR7c0Jl0lVK4xc1S9Lfn90x
         BZKfNkvQh/QrxqHp4TS3nw7U+Jv02Ix6AzBy/4M2atb4YwyJg/e58N+++hYJFSLutfNQ
         Ee4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwOEyB84MTAUgmD+XEbO0cupSc98rt2En8Z9e0WUBbVUiyR7a6KCa337zy9m4djiiGKl5/mZZZoZxy+PFx@lists.openembedded.org
X-Gm-Message-State: AOJu0YzUYUZat9oBxlInrxzGHW1njc7utj9bPaHjiFZuhbSs+botyGCh
	GD2Fl2AmuWuiImCpj4gX27dfDhArAjQRZ+CHF/oTccISxUNWMyM4x+QSm52nahZ7WL4unRD/QDc
	yxsgWJ+gz3HBrRJVj6VZIGlIVLHsME0U=
X-Gm-Gg: ASbGnctEh76nCg253T8uZYtmuQocq0wBWaVcpqfarHcijii6iYu9HKMjCMdCkqinoP9
	8agaMOAkC9N2ulcWkrwQfEOi7/YxFd4JApSO66IszvWv6VTp30XMONslo8TUw6hwaZBeRAwXZSM
	AneIaDZW9WeblyvX0QP68na0+EY1Vvc0TPTtjkbZmwLPMyalh5P5nDVRuQPGV7phS8rEpIbA+q8
	pFMJ1Nmp9RDWZ0AeyV601maL+jsjh9KWTS3E3s+kg==
X-Google-Smtp-Source: AGHT+IFvkfNwdqVYWC+kgCurAd1eDoL48pm8SvwneT48N2zMZFB8cRfZNMliKjglZMR8O3qPdXKN1VQTvuD7ssvxjo4=
X-Received: by 2002:a05:6214:21a7:b0:6fd:d33:bf30 with SMTP id
 6a1803df08f44-70c35c09ecfmr18953026d6.44.1755599373334; Tue, 19 Aug 2025
 03:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <b937fbb5-f398-414a-a440-7020004d91f8@muxen.fr> <7e828700163fb4218a19a60b7113f296a5bb96db.camel@linuxfoundation.org>
In-Reply-To: <7e828700163fb4218a19a60b7113f296a5bb96db.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 19 Aug 2025 12:29:22 +0200
X-Gm-Features: Ac12FXwgxAMVerAvwurH7yBx85cSKXC-fcQZbUB2__u_9L-j7C2Qoz-japZMusA
Message-ID: <CANNYZj_G64yPJoQS5MpJk9D4qkZXU69XxwcBEhi-pSUXaV3xng@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake and epileptic seizures
To: richard.purdie@linuxfoundation.org
Cc: william.martin@muxen.fr, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 10:29:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17885

On Tue, 19 Aug 2025 at 12:25, Richard Purdie via
lists.openembedded.org
<richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
> I am going to try and get this one resolved though given this report.
>
> Thanks for bringing it to our attention.

Until then, I want to mention that bitbake has a 'quiet mode' (-q)
with just one progress bar line and significantly less flicker.

Alex

