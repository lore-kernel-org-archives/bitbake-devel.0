Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3090C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 21:41:05 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.27722.1737495661780613653
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 13:41:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lOq4elKI;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d89a727a19so2702266d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 13:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737495661; x=1738100461; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zPjYZjJpQrHdjIQdQw3baBZjbxSLa5GzJkdnhfMURg=;
        b=lOq4elKIrgOxPuWfFQ2c/lm2rF2oGzsi4l2IuQy0uQvD59ydLIeUqbhOAkT+Yl2AI/
         egWRxquSroCQ7VqUoVlTKqLazpSjziN60eoQPGuAyLGkJJ15Tu9EBJwbVpIVMoiBFvaI
         tQT7EaWn/hSu55lNmcDI7cvNVm2ZzgVuJNw+uNrAfYRqR3AEQzdm3hMg8m56J8z/8ABV
         ZludC8c4Vcf63oXTXl/DJzIm424zT7S7MaLCSoiU9JbAga1VFpSJBfPH3kV2DKYrC+rz
         FQG05MnLbe8jF2izsjxRmllZlCrvTzITa7arNaqGBtprCjETZyl5vnwCiR0pr3+7yGQS
         LZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495661; x=1738100461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zPjYZjJpQrHdjIQdQw3baBZjbxSLa5GzJkdnhfMURg=;
        b=glcCzM32j1iOZZ8BF32llEvpiEO1XaX9H9SKscPFRm+N2T8c1d7ZvE4ghcsSlKR7EN
         Nd8y82A/8JtC+n+WYvadK5am4VhGPCueJVFTl0DMyyYUSqbVipJ0cNaptVVCHk7dPWTw
         Dy5HqS7HaXZnzqYH1bDa6hRtrmTSkTZDr7ibjfa6GYa33QP8D6uQLSeuVF+iOIjxA5fz
         NnVaxi1KKhjxJE9W4296RbErqgHZ0J1nSSECKQGw96F2qvdvbbtE2ioOOOexwGe02gMG
         +b0v0imo5gAojIqX+WvtPyBeD6fOqTwyLSfS+cVJEkriKW40VE3ts1k5P3oKkbU7AzAW
         Lp6A==
X-Gm-Message-State: AOJu0YwSK/rGKU4pJNRdxeyXTALIZnBN2QyCMVqJOB85X+7jYAbk9qGw
	nDjBwz+us4ySoVE7OiQP7PhPKsZtyc1jz5w2RlpZND7mHgrf49Y/PbZMv8m+1QHkFfFEfujdA5R
	se4o/k5bh6JXnmFriXsIQmXUHXmk=
X-Gm-Gg: ASbGncuddvmWPfNZqjVGsEZgrWO4kKlINuAKJSpsihSShOgD/kfxmk3FGD1KAdx7E8W
	PqvgdugnkSi8S32Ul/BzMCD4kOVkAx/EXewgFPVQnjHlhoXSUCfT6eBL8xSPC3621as+UHfzet4
	6zRz7SDhEe5A==
X-Google-Smtp-Source: AGHT+IECd0DgvwceMBDwP764ccT3bwewnDVOrGqpIqh5/csogE0t+MFkEho2AZvgHZZMqT8MNFAmXiYGeZSqkzmTys0=
X-Received: by 2002:ad4:5c49:0:b0:6d8:b5dd:7699 with SMTP id
 6a1803df08f44-6e1b279dcabmr248095256d6.17.1737495660865; Tue, 21 Jan 2025
 13:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20973.1737493163596337097@lists.openembedded.org> <Groupsio.2.20973.1737493163596337097@lists.openembedded.org>
In-Reply-To: <Groupsio.2.20973.1737493163596337097@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Jan 2025 22:40:49 +0100
X-Gm-Features: AbW1kvYE9nInQ05ioAqJc6RNzhA_TNArA-JkiOV_-gET_iQ83Znv_Do1IczAq9I
Message-ID: <CANNYZj9tGqHAv0+SgMgQo=T=8oOm8XLCTk0aKQwJsEWhP+ERsw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget.py: use default wget
 user-agent in upstream version checks
To: egyszeregy@freemail.hu
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 21:41:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17050

On Tue, 21 Jan 2025 at 22:02, Livius via lists.openembedded.org
<egyszeregy=freemail.hu@lists.openembedded.org> wrote:
> https://lists.openembedded.org/g/bitbake-devel/message/16352
>
> User-agent issue will be happened time to time and it will never stop. This is why i pushed a patch/solution to be able to configure it easly from recipe codes, but nobody from you was interested in it. Now it would have easily solved this problem.

The correct solution is to fix meta-java. Please focus your energy
there, rather than trying to portray this as some kind of persistent,
wide-spread issue (it isn't).

Alex

