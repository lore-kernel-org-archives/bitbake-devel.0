Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0712CF2571
	for <webhook@archiver.kernel.org>; Sat, 12 Oct 2024 17:10:10 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.14834.1728753001783925386
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Oct 2024 10:10:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=De3TdK56;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e6c754bdso412167e87.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728753000; x=1729357800; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU4GUArfzFIpOOAYPdHueoVAa/bltCasyUxinK7c/+A=;
        b=De3TdK56Uw4rua0fYZibKlQd//mDFxwHbv32Qw86Oa/kxGqabO9lAxisHyNvX+mPvv
         f+vNMDdlw7zwY+XmbQe3oB4VtQCoAqwxsH5Qq2UnNuYVWu0EdWOwIiaGLO+kIBfhXAE9
         CkZIGGhi0aPWfDPTNwmKhxV2Yf98LB33a8o7LR1gsazjM4v6ARtOrFgEN31ejCigLElC
         EZRRGnMCM7INMvh6QbVUArvYZ4FnR6oSgfDmrnD4Vi4OJRi7D5BpSF1O3kd03VavMxFx
         SN2nBRA6bIh9ejyLbhIXUYasG70fVrQkKOa3avOCvgRG6GhzQyWOhF/58e8U08eQVJUo
         bYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728753000; x=1729357800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU4GUArfzFIpOOAYPdHueoVAa/bltCasyUxinK7c/+A=;
        b=eITbqp6qa5VsPoMjylBwhlm2IY5QjzBpo6jCG5BHWH6q8fzkNFE8tJS/dsIGX2Gwss
         Rtou29jHatDRZGf2pHnIpIKbsu25sAJ0VzF+H9rQciMUfy9K5fMzqVxCJOO44Qmpj3Z8
         OKMcjEU6iPi64KPKng61F+/HKD+Ol5PygqiZYa+nZkkZIFoMxr3R+T8xjvNGuAtIGwfs
         Y2nzdhEA8swh2en+DjVnEeDse4c4rMbG+oikwPC4bnFk/kJ1gwkMxs0lnJcFvr4fL/+9
         A5xvLyEAPD2uHRjftZ0yBEEgqIdy+vadgv/PxRTAkgCEBAmWzXlNXPDg5xU6+Y7KT7uW
         9Z9g==
X-Gm-Message-State: AOJu0Yw5rLfneX5uLY9G54cx02yYJGYrYgGjYBtIj4xa9kkhXMtcb3DY
	3/KWaJnhdLE3WgpC1s5Mg9BH9fNRhixjEPCraebjpHu5cSZJM5pxgovJKeVOXlsyqaWBMvZ9YtJ
	1z4mywIsdwjrd8zfyL2Ih7GDdnro=
X-Google-Smtp-Source: AGHT+IGO+2cKHdZt7o2nbDcsfBCi9mIbeJKY7Xi1A3BqcNsfzm76Fbrs9NasH7sspsAiSEBfxgVd0cYTap7nFYKluIQ=
X-Received: by 2002:a05:6512:3046:b0:539:d9e2:9d15 with SMTP id
 2adb3069b0e04-539da4e12eamr2789677e87.29.1728752999450; Sat, 12 Oct 2024
 10:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj9B2LV2ZH1VivrwdfH1T2FJTV1FU9MV3X+TwWcDCUqtFw@mail.gmail.com>
 <17710.1728337442729823697@lists.openembedded.org> <CANNYZj9+CLT81zNGCw8nTZAZa-1BPMn5UYjy3hUuAUDGGs0_ZA@mail.gmail.com>
 <8c2a1863-8b07-45ff-b519-3cc6b8fe3b14@oliver-kaestner.de> <CANNYZj-iaojsDJUcFqU976c3q7gvo0i-Mt6bnJXtNB3Sx68o0w@mail.gmail.com>
 <cb9971c7-749d-4868-97c3-eaf1f80d6156@oliver-kaestner.de>
In-Reply-To: <cb9971c7-749d-4868-97c3-eaf1f80d6156@oliver-kaestner.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 12 Oct 2024 19:09:47 +0200
Message-ID: <CANNYZj82Z8YyuVQS-V1dtYt_ugCJXdLPbsoLLMYVLa8uc7iSPw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: add GitHub Codespaces support
To: =?UTF-8?Q?Oliver_K=C3=A4stner?= <git@oliver-kaestner.de>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 17:10:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16676

On Sat, 12 Oct 2024 at 18:38, Oliver K=C3=A4stner <git@oliver-kaestner.de> =
wrote:
> Simply put, GitHub Codespaces are Docker containers with a VS Code
> server that run on GitHub's infrastructure. You can launch a Codespace
> directly from the GitHub web UI and use VS Code in the browser or
> connect to it with a VS Code instance running locally. It checks out the
> selected repo and lets you work inside the container as you like. You
> can use an own container image (e.g. crops/poky) and thus get a
> pre-configured development system that you can use from any client
> system, even Chromebooks.
> In the free tier, users have free 120 "CPU hours" each month, and
> enterprise users on a pay-as-you-go basis.

Thank you, now I understand what it's for. Please put any relevant
links and additional information (e.g. location and content of the
script helper) into the commit message and resend.

Alex

