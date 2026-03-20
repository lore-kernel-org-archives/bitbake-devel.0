Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74115108B902
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 11:42:09 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10603.1774006929015101213
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 04:42:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R+z/u16W;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899fbf92bdbso20779026d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 04:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774006928; cv=none;
        d=google.com; s=arc-20240605;
        b=V9jL/wZDqKfTjq6PQK4ndjSsXC1D3eyCaX7W5sddwI8khBTbtI1QkWfMITtkq/+iCQ
         OqRaQKeYq9k1vEu0bbPWyA78n4a146DLAQJClBu4RkKiKDHZ8dKtUMcTaA095lPFXIVR
         7+eari2xvVJ8A6WAkfT/8sHee3hXmEHi08pxMNyY83OZnvcdtgGaQJVs7+PIh7LHTGgM
         j5pZJQdfXX8oWwzloheS/maQiYg0hjKopxQM8FGKMiPm46nQcjpuJ6Im23isQXGFDyIc
         tZiGGq71uziEidS5ak7qOMnUC6q6QqxtuNZi2shAxVS/RvcbaeVP2Hov6nxv5sVBvOvU
         bx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hoeiV6hVn7GjUbdIJmTsRN+58a3S8hDphFIEH9wOeHk=;
        fh=k1yhGSfbC8ACgl7gRlbDMTW2hSa//jg7bNMfK6qiLYc=;
        b=bmrb6uPMeweJb+LE4SupiDRMboypli8xJS+p8jl4VBgQQYGsdp+Djt0z8/9ecj49TG
         /ucC2iACG49nr2XmLgZFeercX6ysBboQlkPuBwhb6ffb8nzaJGC167DVspT08bKGsZAr
         KCKIP9MZwO9CQgeahViyA0D+DLHDnaxsnFLOqTWILQHq135XBv6MhEIX0MPHjth41mlx
         kTn32vAordl7SFj/YnCaE5/D3E23x3F9ma1Q3gnz8jYC1KKX+q8bo0xyPEtnhoxq4gtF
         aLk4ZTsUVpqDA5HASaIEFDkjsmKGR0Sn4SBrQZPQHzqGIrbmFEvxDX+9bFktDs5rFUhU
         JtjQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774006928; x=1774611728; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hoeiV6hVn7GjUbdIJmTsRN+58a3S8hDphFIEH9wOeHk=;
        b=R+z/u16W52igG9rDD5je2Wi54RXQkHc4YoR/EfW0rOJV9SkYeGJVKrk59N4o6l47uY
         QvbSvN8AMOJjfr9C/GREwAmyKJ5MFtSiB8DXX7DR+3d7f7ydbie1bcjKes6EvXuhGQ/q
         qiSSIXw/liYQ7/aiioFjh2eDDEpHOAsyVoGsi1dFDWGoXxnlDO0qvj2taIzQVzIOqpjE
         CFkhU86SIffqh0OemvunYZiMUhX+XqfN9pobD3r8NxUDR41D47LWUKTkZR2z7O0U7L+l
         U/fpwoE0NBpJV5Jl1ArY1aZv60ERKM9yfGTklaMeCnFCLpwKmex1ZNKTpKt1+iHv0lJh
         SsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006928; x=1774611728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoeiV6hVn7GjUbdIJmTsRN+58a3S8hDphFIEH9wOeHk=;
        b=A8Ybb6+ioGGI11ZmVcfA5E3nOwUiGrgeY4bHn58cqYoR8ByaBVmkG7OX8yY13Qkiva
         x4wSCcAYfVwAdawKeZMo50fIxOd43QpKGtqF441ftIwyh2NqccjsLBR6GTaGeEItnrgY
         6+A4Rc0j5qP5jHqv0NpYHjSbZ0rUCiRy3QBepqxAHczvsDnN5qV5w/ErYcstJQDHA6Ob
         490eg5Ydo4ub6ZWeuc2PAusZ60xkpcrHSpK1mZ55rjddTNLVtHevasXwjA/qvSGNQaFS
         iLh8PQV+6wtfYFJojkgclii5Mhtc+5MMDRMXW/R+iV56la5+RztS6RKUcZtg/TIG/KJE
         z9cw==
X-Gm-Message-State: AOJu0YzI0uX73jusHCG74onhuQc9v7wRzWooBeOHe3ahVxUUUWxTj1bA
	ygYIUA/m0oKtRvmACfmnq2TnSgDMDXu5pKHIQQa7LeMSdjHAxATrU9sRXu+7ax9eB2UW7Xxf/hu
	ORW7AFKL0w1hNXLPN1GDciJ4B+84CfD8=
X-Gm-Gg: ATEYQzxlMRy/lMB+YPeoOV2aOeTSIvupPNJmdzGdamVbtHqSYiLdVbGCms2+UAX7dJc
	kQ/h+llQbuLweid8TkxpL/D1yuVVAdyVzQkH8ViHf7YbQ6n0DThYfiTgn7440Dhs9C1VMGlkQBh
	pZMsvhoWo7tOTSFuUqmlDPnbWwmXfVyNH9C49jIMBopQ9+mnRRO0bMjSfNIHwYUpyTzaxlJCZqi
	c5isHuozJXRWG/7Dvmcu+7Pi8vJmYoK3A+mbdXAWP4sdvhKTsiLzQ1JRJBa/+Oqzp1BbbPKpdld
	QcQ2RicSx9g1ekhn8Wk1s1w8pqG1Fcmb3Zr2442XiQ==
X-Received: by 2002:a05:6214:1d07:b0:896:f95e:65d with SMTP id
 6a1803df08f44-89c859d4e35mr39152156d6.17.1774006927764; Fri, 20 Mar 2026
 04:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <189E3DDB9FE2B7C7.1764087@lists.openembedded.org>
 <e551779604af9981640c070e5b9d07cb68f813fd.camel@linuxfoundation.org>
 <CANNYZj-dY7PfmJDe7W4KjbRp-WL2iLVBXo3MnLk3OmJ1+QtGsQ@mail.gmail.com> <c16464d67528ac1bf90a466eb96b695da1471159.camel@linuxfoundation.org>
In-Reply-To: <c16464d67528ac1bf90a466eb96b695da1471159.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 20 Mar 2026 12:41:56 +0100
X-Gm-Features: AaiRm51Sw5BSLFO7Emi-L1mpsfydDeCZo793CQlzgL3WsZNzh-_-jPJEJW2KTFE
Message-ID: <CANNYZj-LSpb73gL3VR6ou1L1sxYY2ZMu+DzVLyRX8hEEZ5kK3g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: Add an 'update' unpack mode to
 the fetchers (git only for now)
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 11:42:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19186

On Thu, 19 Mar 2026 at 23:02, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> I was looking at your patch and I'm not 100% convinced about this.
> Personally, if I have things lying around the tree I've forgotten
> about, I'd prefer it to just error out and make me fix it, then allow
> the rebase to happen.
>
> Stashing it make it "disappear" and would probably confuse me more if I
> miss the message about it doing that...

Alright. Let's keep things simple for now, and stop the update on any
conflict. The workflow will be that the user is expected to resolve
the conflict, and run update again. I'll send a revised patch.

Alex

