Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722BC83F26
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 14:57:52 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.9776.1753801066537870282
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 07:57:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EtlA55kK;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70478ba562aso9533246d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753801065; x=1754405865; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+ngKfaIkOmDd8DAjASqmEIdrSFfaYrmN1LlCbl2GxQ=;
        b=EtlA55kKV7xvd0THRb9XDVoGnwY5O0Os6ptCV3iHS+tnt37hH0YNCgzsNqN1NWj6PH
         7b3omSD3XqVHkfpBc7cT8URN8U0OvHUU2k44T8RAFIWINPje/WbGiE9ZJyUIuXoaJOrN
         Jn3WGmOcd9qOskdXybCCxNn9lE8TBadByD6fNOdneTdDcJZtBKpREsBeKiH628+RrVO3
         A9eL45ieV/+L+K81R70g4CZLNbZPgf/YuUZyIe3g6/dDTnh4tqOuyCFtOK5ttP3ZZu7S
         7ZpdT6WUeykMvMIU1ltaJ/91EvEVGv2PXBFZo6kyt985lyLHfrgVtwlIPsN6DVU9DVUt
         2U/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801065; x=1754405865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+ngKfaIkOmDd8DAjASqmEIdrSFfaYrmN1LlCbl2GxQ=;
        b=DqgzTAkumV2Ifa46kW4kH6Q5yl76DpC5hDGLRm8O1Aeevwd5THjtcfa5YIIVxuWv6A
         frdl2az7LJaBYXjpNxrSQkxcjCdck16+lAsWCLXcpE6W1VY84/IURwrmIP7WjefkZC2f
         IL0/0pDXKWSAYtr+QNVn3BTcnZTlihNKx/Xb3s/dCwEvv8/JBX4zMdIVIeEo0RZH5iga
         9xkedVQy1RWXPrikW3jvCxkSRQ+Xlhd7IRWo273YTtJCJg1/T8e+NTUM5O2ueVUYgZ9y
         zdUbz3W4Qtyktcjh0Hm0dyuZhsl6PdyDqMARhvjIbZLNtVhWZO5sDLvncEC72w+TGEAA
         tEDA==
X-Gm-Message-State: AOJu0Yx8z5rbltFsvAXCGlhb0/N2PkFvqGRg/wfJIQfu4NV6JFwS0iJg
	Z8G8cn+D8XWt3kesUFOdPFxM+GVgyahNH9Fai37crRPkb+S5qJalbsKoRhimQYo9S87ejCrRqJP
	hiDY5lUeK3jhicCKKkmvsuuuykb2QNdY=
X-Gm-Gg: ASbGncvfCmyYjZhgcxsJT9LeBj7lBpksWmvLYeq5unn6khaWtM5iUAak2JlBriyeKIF
	sFjDnuRdoNHvers8lx+K7CMrS/JELCyOCy/lLO3qOoEjVASUCSdOJV04LpwJsUIldrj251uLLGc
	zXM8ahou/JR+5I882Ow4wvZnvcgkyv0P27z6aoFFGsrZOUcZIoN4198+DBGLjYGhP2nuPgM8sAM
	EQpexUaqf/0eH1Ji39og4r3rTGLkJnp+ACZ//M15uUjxlhd4ejA
X-Google-Smtp-Source: AGHT+IHIKiqhJfCt4Y5kC/LKmSW5vWeWreyZKpDBLgt0pbDfe8O68GlMgrQ4/sgxb7fdH0LtuHRzMG5OEdhykvSMQFA=
X-Received: by 2002:a05:6214:301b:b0:707:1b3b:7715 with SMTP id
 6a1803df08f44-70757bc1426mr42433666d6.17.1753801065297; Tue, 29 Jul 2025
 07:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
In-Reply-To: <20250729144906.1665908-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 29 Jul 2025 16:57:33 +0200
X-Gm-Features: Ac12FXzQQtViB8KOZpr2Bf9qi8KH2kVXY6z-uHkDsgGWUhRSPIz62RvwzdL2UZs
Message-ID: <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 14:57:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17820

On Tue, 29 Jul 2025 at 16:49, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
> Our setup is that we have a "disto" layer that we need to maintain
> against several version of Yocto at once. In this disto layer, we make
> policy choices that sometimes are tied to a specific version of a recipe
> found in a specific version of Yocto using a bbappend; and often that
> version is only in one or two Yocto versions, which means that the
> bbappend will be dangling in the others.

This is where the weak point of the argument is. Yocto does not make
concessions to layers that attempt to be compatible across yocto
releases, patches that help such layers had been previously rejected,
and this would create a precedent to the contrary.

It's always possible to make a branch.

Alex

