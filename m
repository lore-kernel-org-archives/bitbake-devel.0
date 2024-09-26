Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7756CCFA13
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 09:47:45 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.38942.1727344056249299590
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Sep 2024 02:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HBcIK7S9;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5356ab89665so940304e87.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727344054; x=1727948854; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UX96Ced687EC3ayJABjKH2VJemlYS1Cn7WoaVB2oCBg=;
        b=HBcIK7S9LYUwE10/L48hhn4ocM9JmhEKdUnWNlTw5xZ4A/na+8o2xBED1xCO59/ZPh
         QzGBrMuczKXAePLL1PQezR/a4Z7+vt9lzG7SN2Tx4DZZ8mNQ1A+ntMA2J8Yabms1juUh
         25Esorlcgk540WwUhh82XFpMSq7v0rrgL+1aF4VTkRTUCv2dER8fzbcCFokyV8oG6E/H
         owyHzSDzjnf18Q0Npux5k+5cOvee1+OimfqoGvOJZNu4s7IswqPRVR4BhuHqBxQtC+DD
         U7LekieZyjHwg4KZFkTPOVolXov25SIVRBQrnN3SBHovPe7hYOdJO0tm8oAt9sHpIoEt
         sWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727344054; x=1727948854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UX96Ced687EC3ayJABjKH2VJemlYS1Cn7WoaVB2oCBg=;
        b=Itrf98LsSq+MkFPn+gaojBu019MR69sal4KgvmK+zdnBpA5GfeHSB9PimPyFvPmH3T
         odQZDHHnq+HzQtILyVj+b123NBo9xkzfeasLD8ZePJ+0MmQMvYevRK5rX433R1cjRd/x
         HN/p5Vh8/R8M3etN4KeO3C+jK+BtXgXlhfpiAMA606Aak1t+Vfj6aMDjYvCuqT7sV+aS
         hdnPaZe7WPxmlrIBomLGrq3wy9UWI8Wzts7tPoVDnFpIWxGs0x+t+pX8GQLf3ajydtX8
         ipzJ3c3drJHq4kmDsavSZ7UyrWs8OzAslZjXQ3IV35j1wbiyCtj75o1aPKRjP6NhYsDl
         l+XA==
X-Gm-Message-State: AOJu0YzN54ixBoQkDfKals8p4hS8FIgNt8cQGbSlGp323YW/3WxN3J4K
	KhrTeaP86lRgFseciSV4NePPbjtK58+8t5baaMeAQ8s/k1DyeT6vTZBnCsrMTy43wymp+0/RR44
	+KaKjmjaLkQ16yCmITHdIwcma6Ov5uQ==
X-Google-Smtp-Source: AGHT+IH18ifkg4heg+eFrbCUXZrREqpJQ6Hrsu+EvOMCG2UJTCdz0Evrggunz+ehKG9L39bT5E8t0BJ+vGfQcl4b/3c=
X-Received: by 2002:a05:6512:ad3:b0:52c:842b:c276 with SMTP id
 2adb3069b0e04-538775649fcmr3793488e87.53.1727344054111; Thu, 26 Sep 2024
 02:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <bhfQ.1727300278439114446.Ff3Z@lists.openembedded.org>
In-Reply-To: <bhfQ.1727300278439114446.Ff3Z@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 26 Sep 2024 11:47:22 +0200
Message-ID: <CANNYZj_3XLABQZLYvRuQu+PnQ52gDRS8pXgQDS-SBfp8g9o=sA@mail.gmail.com>
Subject: Re: [bitbake-devel] URL encoding/decoding bug with files like
 "serialgetty@.service" or "sshd@.service" with archiver.bbclass #bitbake
 #kirkstone #poky
To: brennan.coslett@bluerivertech.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 09:47:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16603

On Wed, 25 Sept 2024 at 23:37, Brennan Coslett via
lists.openembedded.org
<brennan.coslett=bluerivertech.com@lists.openembedded.org> wrote:
> It then can't find that file and so then the archiver doesn't package anything up.
>
> Hopefully bitbake-devel is the right mailing list for folks with more knowledge of this stuff?

Not really. Archiver is implemented in oe-core, and so oe-core list is
a better place. It also helps if you can provide specific numbered
steps to reproduce the problem on poky master.

Alex

