Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF3C87FCB
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 10:17:35 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.18197.1754389053143393087
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Aug 2025 03:17:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iL0tUdUr;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70749d4c598so48360526d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Aug 2025 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754389052; x=1754993852; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4xc3OxScTl5AbidUxrk3auh8ZYw2vl/I+Ys0XHK9zfk=;
        b=iL0tUdUrbQ6Nf9e/Ul+YOUtkfIX05l3LcxDIEeXJqEXIRLWrPqMzr5YUI2K9GJc5AL
         B52dDa4L4HtPuoQL9LBG9FhSnWl1jLyI8Dw66I7ebThv8LJXtooAOjo3o7bvLvmKCMUV
         UFy/cFqQBeku5xxVSlHhKYjVb+0lc9k9WWR0kJ7iRQsuR8p0w9uQGfP6vD2B38yqJvaP
         8q60fqxRja4n4ATUtIENTwJMRMa35DjMxq8LFovkon1hTi5vnz3BX66iDEhAfCNw3ZFv
         Wri1hDD2fzPSxTa9mfKamLTyPtCGtdPQ95gX3J3Ch8q/eurWJAmZExzIHewFb8zi32ow
         V7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389052; x=1754993852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xc3OxScTl5AbidUxrk3auh8ZYw2vl/I+Ys0XHK9zfk=;
        b=UFDk4lA9jpxDbe3tSj9dnjtX/ZoLD3CfqGPUAZ5zsQyDGGojA/k/p1crwGFZ1/eDOZ
         KwLZQQ3w0yJJPRvh4ey4sWljYeZNpzVJ2vRPSxpM298ZesCGaipjUYiL6yg7m3YCAOOw
         Y3IuwidRgL+8FvHKzW6ZSBuRTcUiadpLup3MnuyqYawktdv/Y8RwER5IAs3xAT3XiDOD
         cyN0Hu6MG4JnhozPXCn9W0+s1Q09DtQEHtd2sZUxgtF7u2Dbrmr6ELdCJqFC/VB446p5
         ZkpaVXL1a32Eiz/KrMUHPc1Q2J8OGtVmL7z+uEyZZM4k/nLsuoK1ZfSfXPIC82/sIc3/
         LFOQ==
X-Gm-Message-State: AOJu0YxkC67dZabU1wT0FnZgKEu5YHGGjmB41XUie/crNTyUgVnUVN8b
	UYznPBviBkYnw9LjG7SG2XX2/lEDcDSsMZOElmK6DFwqywSrfHIGthe51UQXKIJ+RqnFJaIaQGR
	ld/U7hHUbrj131/07oLCCv8aRG/CX1o0=
X-Gm-Gg: ASbGncsUnUAabHOddl9tC3cCxFqzs5fP0uKwG235U/OhI6M02eM/RC5vkXUzN3nsJ1Z
	VkVGQGRNsjZjym9Hq5xHqExOjeEnA6gofJg+3WBZxkzBR+144LHYNuYq6uczL9tpoF1+2HORjQ7
	D9tM0FOY2qIuPy7wnyq8KAxn1+cCTnbQw4/4+cVmXS+kf+l8lPdjKcGOzIcH/W/yQop29FoliJS
	l8iS61GrwjEcr8lLju/rtuwOb1w7b2ZnnrsHIpVgM/ohSyFvC1U
X-Google-Smtp-Source: AGHT+IECpVMUYLN1wj2029jnPlWz7rlMsmjAMQTN1UJfjoN64BZcWDOWCHJ/0GJFuf2ap+G9Jfi8YGBu7Qg3e6gOots=
X-Received: by 2002:ad4:5fc5:0:b0:707:60ca:7ee1 with SMTP id
 6a1803df08f44-7093626d249mr197171466d6.25.1754389052019; Tue, 05 Aug 2025
 03:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <74e41b81-6c18-46cf-a808-b28e955a5fe2@bmw.de>
In-Reply-To: <74e41b81-6c18-46cf-a808-b28e955a5fe2@bmw.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 5 Aug 2025 12:17:21 +0200
X-Gm-Features: Ac12FXygV5jLbG3q36QbJvbD7TQG3f27eeUfMF72ihtu06SQLfqPfxlI_xJ_ILE
Message-ID: <CANNYZj-XMgeaF3GyTWoXFcg+dPYSmZg09MKd4NKh2R9ZK56Q5g@mail.gmail.com>
Subject: Re: [bitbake-devel] Hash equivalence server garbage collection and
 *_qa tasks
To: philip.lorenz@bmw.de
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Aug 2025 10:17:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17837

On Tue, 5 Aug 2025 at 11:58, Philip Lorenz via lists.openembedded.org
<philip.lorenz=bmw.de@lists.openembedded.org> wrote:
> we have deployed the clean up strategy proposed on IRC (mark all
> unihashes with a corresponding central sstate entry as alive, then
> sweep) for a couple of months and are observing that the *_qa tasks
> (e.g. do_package_qa) contribute a significant amount of "stale" hash
> equivalence entries to our database.

I wonder if you can simply remove all package_qa entries once their
amount exceeds a certain threshold. Such tasks with empty output are
generally cheap to re-run.

Also, if you are using multiple hosts with distinct uids/gids for the
users running the build, then pre-walnascar there was a bug that
prevented sstate reuse and multiplied unnecessary package_qa entries,
so taking this fix may help:

Author: Alexander Kanavin <alex@linutronix.de>
Date:   Tue Feb 25 13:09:22 2025 +0100

    classes/insane: do not leak host uid/gid into package_qa sstate signatures

    This prevented package_qa sstate from being reusable unless host uid/gid
    values would  match exactly (and they unfortunately do on the
yocto autobuilder
    worker machines which all share a 'pokybuild' user).

    I noticed this when testing CDN sstate reuse, which otherwise works well.

Alex

