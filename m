Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122DDCCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 18:02:28 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16346.1762365737729885386
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 10:02:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NrH+lhxC;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a5d03b53dso890771fa.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365736; x=1762970536; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12nWPoUtxRqGpDW9kOBeRrtSQfpXYkYzgehiGq161wg=;
        b=NrH+lhxCik5NY+HawOZ2rppep3leaAirobRfDxaya3rg3cHx3lnWFx8Gk+dYUrJ/51
         qMejta15cAMw+3xOpxTjM/QU4ELzWjtX+O/hUu7+UrhcEyf/j4VwkHvUb+fgRizxw+dm
         7b/GfhQTMQ/cwlAloWsoR5P2ljfECjYA3KCheBiGjj+yksGuX/Vl4zPCRJG3hC8guhzl
         tDTmYawhXegMUml8HX0DiI36kSza3ivGNmpCEp4+7G6o8/0KxDca+Nuy1hY2lL4ZUU1q
         3U4mQgh/y/jQJbuAWKYjK7vlAAhIv0V6JplroD1wV2NmeAeWsXte6s0SfGPefu57+ZJ3
         S1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365736; x=1762970536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12nWPoUtxRqGpDW9kOBeRrtSQfpXYkYzgehiGq161wg=;
        b=pdpbjWAcQA7U9Kg26rjhiDsjEpSDncBe+FbOLVQh9ahRRx2sXwT7wK+ldmj/RhajGX
         Fj1r+kFfwqsyzK5R1jkrSea+mUaNXCbWcDPcYwhch27hJ1CJxuJ0fytGKOp/s4JAamhE
         q5MjUY4wY9MebX1wUBLdfQasoJEeLFq296+f7x8g6D5DGjeK1k3xNIyWbGqZLAhewfXT
         SINRPAmqnvNQnaTSAUbAspjSGyK4/al2+kPs/B2Lc0PwHqeOOhFXIAVGcbcnDGWtfX1u
         QaEM+zK7o9Ei8YHuGUvIxw2DlUtOxqVcQtachvsgl1cBicOuN95cm/Vgb7ngSxxMfwID
         uCaw==
X-Gm-Message-State: AOJu0Ywdx3K4rDVfEHVtJeGXcrzR6v2ct6SBKvuEPmH+LfDpqv1hCPqs
	C5MSDnemYMVKzCohN99A/XT5vuObjCqlDPKIxeihOK4Wf9aVPoTloQraeFkdk9iZkQZ46xUAUQB
	sFkV5iZiRmLYMQu7/vq/rANi7REORaaM=
X-Gm-Gg: ASbGnctDAtOmX0dWRpodsNEX44gx0vOm6WN1vVxTkrdHbI5qrDk9vPyT1kkRSwdp+T/
	cBtESrFiv8FMJGOzHRVZAPMLAC1yMGXAGNnXs3Upof/jObeBApzFl3x2M6Ex70hfn70to/rPr/V
	cAg71b3iXBImdsdsm4Mf41lVRHXpPrM/Pmd+8iKv4TD4YLPs2xs3wkUDAOTqGtTDVVl7nHYvJ9y
	PhkoRBaAg152fm4tEUM0X2zasOCPrwaIbar6I3QJsbGr+pKIw9/gmWN3EqxpZ8=
X-Google-Smtp-Source: AGHT+IFsQLuJFUCmQoUWXA/eG9GzHcTos16icEw4Sm5fCS4EWyaqcj3JU3GapPD1Qx3aqPQhm50mL+IeZxcK7NU2f1o=
X-Received: by 2002:a05:651c:234c:20b0:37a:31fc:1d47 with SMTP id
 38308e7fff4ca-37a513e718cmr10231511fa.14.1762365734072; Wed, 05 Nov 2025
 10:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20251105144420.359338-1-JPEWhacker@gmail.com>
In-Reply-To: <20251105144420.359338-1-JPEWhacker@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 5 Nov 2025 19:01:59 +0100
X-Gm-Features: AWmQ_bk_rN44RB-dpiGrOhv8KeRQ0g3lBq9VNmTQ5lSzHV1UedG1zc01_N7upRg
Message-ID: <CA+chaQcs5bUK8Aa03zcBBqN_hTBvG5cGTTBh_goyq8DE_-rziQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] knotty: Integrate PSI reporting into the UI
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 18:02:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18269

On Wed, Nov 5, 2025 at 3:44=E2=80=AFPM Joshua Watt via lists.openembedded.o=
rg
<JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
>
> Reworks the way that pressure stall information (PSI) is reported in the
> UI. This change does a number of things to enable PSI to still be
> reported, but less intrusive than a NOTE message each time it changes:
>  1) The primary reporting of the PSI to the UI is now done through an
>     event.
>  2) The knotty UI handles the event and reports which PSI montiors are
>     preventing tasks from starting with a line in the status
>     footer.

Small typo above, otherwise LGTM

