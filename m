Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB2CCF256E
	for <webhook@archiver.kernel.org>; Sat, 12 Oct 2024 16:07:00 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.13800.1728749212520660783
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Oct 2024 09:06:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CYur0Brh;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5398d171fa2so3867894e87.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728749211; x=1729354011; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UorF9tGUp+2YbTxZXmksjG8oN21vpk4M1xw76pSqWGs=;
        b=CYur0BrhCbda+ekimnmyQOuUHFgh7NBKCsFSFZiurl4zhnKtzM6eqKOjTbKQRoS/pQ
         PjwC3GHGXSVPRHwmdryunY2w1GGcjEMCJRIfnOm/HpF8qCJKYWJzmm0NZHzNZpIIyXwY
         cLXmC4L+NH9Hta8Y2pFovTpn4gIfxiHdB+KHewvYLN3xvVB5sGVHp869Uy/m4kCfdQMK
         gG+htEqu5MnMAVbnXGi/incnwri9GiEC0mTnARt+gXtUGjrV3rZyUKJgBPY8jayMhCZG
         aGCsLPUVPk0VIYKkedmjN6NhcrNYKfiKV+E0blGbePCBE5zqTUPQ3MHG6/u1xBbRIwmd
         NE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728749211; x=1729354011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UorF9tGUp+2YbTxZXmksjG8oN21vpk4M1xw76pSqWGs=;
        b=KADa5mC/csX0JyfgL31EtBc+OA9aK97jRD/Pf28D+hK03nGyUK4ljMOQf/1tLrNOq9
         EB8PBHswoRqfNuhZWPjacdDUcYwybzgoFmKmPeC6Y6o9pNnkfnCBKIuaEOEQBLyUOD1o
         TfQSJOh1cWwDuzLqgO6CrRBoaygM1edgda33Uo3WFzuu+QBAsMz2+0cmqkTZ/nTTz9IB
         fsIoguX8sSgb+imaKBffbHOPnJzHB1NvlfztY/118X49bGif91hQJiv30Swl1V5oXa65
         bA/PbCFvheCNtMVf3uyPtRGrjWIufx2cyETSpC2/E1dSf2O4RTHcQAAWSWwbX0tojZt9
         O+FQ==
X-Gm-Message-State: AOJu0Yzu1hvwZhV3/9BZY+upM6TyMH4ywmyE+DjEXOVYKNCf2/8uJiY/
	BsizhC5LRNgbcy7hZ7xPP0XW86WZZMixuYKCWeE/NPiM31A0kp3qws4dV9fvGipJhA61hee2GKr
	MypuXq41Y9WDQsKMCLfdaVMvhqVE=
X-Google-Smtp-Source: AGHT+IE9zSZ52J/a+ng1Piq28Zt4tsDtRZdS3flynYVA0Daz7dc05CVipNL+9YgUAsQz1xivlLvRFml2JlUMOypTkJs=
X-Received: by 2002:a05:6512:2384:b0:539:8f4d:a7c9 with SMTP id
 2adb3069b0e04-539da552ebfmr3384442e87.41.1728749210260; Sat, 12 Oct 2024
 09:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj9B2LV2ZH1VivrwdfH1T2FJTV1FU9MV3X+TwWcDCUqtFw@mail.gmail.com>
 <17710.1728337442729823697@lists.openembedded.org> <CANNYZj9+CLT81zNGCw8nTZAZa-1BPMn5UYjy3hUuAUDGGs0_ZA@mail.gmail.com>
 <8c2a1863-8b07-45ff-b519-3cc6b8fe3b14@oliver-kaestner.de>
In-Reply-To: <8c2a1863-8b07-45ff-b519-3cc6b8fe3b14@oliver-kaestner.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 12 Oct 2024 18:06:38 +0200
Message-ID: <CANNYZj-iaojsDJUcFqU976c3q7gvo0i-Mt6bnJXtNB3Sx68o0w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: add GitHub Codespaces support
To: git@oliver-kaestner.de
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 16:07:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16674

On Sat, 12 Oct 2024 at 17:29, Oliver K=C3=A4stner via
lists.openembedded.org <git=3Doliver-kaestner.de@lists.openembedded.org>
wrote:

> I couldn't find a source for this script. I assume it is injected into th=
e Codespaces container at creation time. However, the script is mentioned i=
n the GitHub docs: https://docs.github.com/en/codespaces/troubleshooting/tr=
oubleshooting-gpg-verification-for-github-codespaces#checking-for-conflicti=
ng-configuration
>
> Please let me know if you think that this reference should be part of the=
 commit.

How is this environment set up in the first place? Is it on your local
machine, or is it something that github magically creates and lets you
access remotely?

Alex

