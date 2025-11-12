Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DF3CCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 15:19:52 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16144.1762960789460583118
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 07:19:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QnchUlYV;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7869deffb47so9281397b3.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 07:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762960788; x=1763565588; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz2ZRTwFXcrmraXl8JDY+MnNzSUHynlOt6sRBSNOmPw=;
        b=QnchUlYVjnXVS0+lHNUXbmElJTwtL61hf9Qk9S75iLwWwOb0tAMagicNJcLQXqEMy5
         q9HqVU+kGSJFh0rJgNOixD5xOP71rGn9Qm7yqm0Qd2wjnZxfA5H/Xvwd/zY2XkS62umy
         vEy6+D9qG6CO0EHFr5KjZLexDwgZlX++PnicAX0d3WI2r2KaHhyf9+mK+pWZtssgUk3t
         6lriKDYTRbVFyoJr7HyxM+6hOoPicERZaUVKG0cguXrXYK6SpZ7ne5FJggpaJPTcVZ9O
         htBCBhhS49g5KQtnhall8sdEHXdkGe6BVud1IDfm6yrXIPjvvKRRfQesXyPQAkHa7vKn
         Aqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960788; x=1763565588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vz2ZRTwFXcrmraXl8JDY+MnNzSUHynlOt6sRBSNOmPw=;
        b=waM0zQ2UISN2HKJOIY6aIAq1c1/pBxqlaczZG+SycBLGGnX2kGvs6fSpzMyFYFA4rT
         nQBP3avvLYN3vWqp3q3R7CP8/FGvafIoMkvuvoEU+60ShBQwfZ6F19TfetDTXLAs08ba
         v149cFux4hU8accQqQtoeI8OFIghs/TW9EmPJMCPGjEKqgaFJRtl7lVLc43x0n1B6eqi
         JTYQHUNzeDAA36bcm8K3d8tpXvPUQa7N24lOBgHMwaFYhNEqjZHnov4KqbwXSCTtIpsM
         lAyv2KVMdzfb5TLzzVSQ71GNxOGNuEc8GdoUHlqxk4h4qs1GSxqjuHdF2f+WxCr9t8zQ
         KBMw==
X-Gm-Message-State: AOJu0Yyk348EoeOPCmelksXjKACq9niD3PGeQALlVp3yP7jxV+8C77oE
	IfW1iNOOzMN+k4ke8vjHxZFuPJreJMRCgX91L4ZrzicQBPKZKbpETVT6QDTcTAmOCStTT9fot08
	Oj8ilVO3qofIgF4Nn9TaY3fGGVZemzQE=
X-Gm-Gg: ASbGncu+8QG/wAD35pl2bvuxcRMeiAdpFuZbMU6crP5YMMDwy+sC2PCFp+HiYH1VvTE
	PQPsbzUOh7+57MbjHxCdW7pYNfbHgWpt5VWha51H6dxYg9MlMmlEL9ufO9OXyd7TNLZTfEjHy0g
	Irrw+IXjtOy2FoovKlrXwnz5FGMCanFAboA72BTNVFs/gO3j8G4U1Oipyx+lGS76Da9ZfVR0ufd
	oUkNzPSnivTCe4iYQY5ekvKlGIAGrS9g5WbEx6uyUsiqwl7VlYlvdMnsiq046zsybRdo9MWoCGl
	1zfliqQMHw==
X-Google-Smtp-Source: AGHT+IExuZpJH+uOowToFvkNG20a1M9Q6aQo2rsHpsfmgnLizByXwAUv0C//uBhpHsoa6LeqgUPyStH/hcnsLCifbNk=
X-Received: by 2002:a05:690e:d0c:b0:63f:ba88:e931 with SMTP id
 956f58d0204a3-64101b0871cmr4058845d50.38.1762960788634; Wed, 12 Nov 2025
 07:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20251111172522.2838760-1-JPEWhacker@gmail.com> <CANNYZj92WLXk2-9HE+oxe8MASLy5tDTz3pAJgrZdEh4FAZ0H9g@mail.gmail.com>
In-Reply-To: <CANNYZj92WLXk2-9HE+oxe8MASLy5tDTz3pAJgrZdEh4FAZ0H9g@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 12 Nov 2025 08:19:37 -0700
X-Gm-Features: AWmQ_bnkyhRlHoTBGhWlPVbIIU2Yn-wnWvyQEBjlTRced61luyf2X9EZIgpBxAo
Message-ID: <CAJdd5GbdjbKTO62FV1VSpg5SC4DNJYkaE=gbmzKuJXVg3Om4EA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] bitbake-setup: Prompt setup directory name
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 15:19:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18352

On Tue, Nov 11, 2025 at 11:39=E2=80=AFPM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Tue, 11 Nov 2025 at 18:25, Joshua Watt via lists.openembedded.org
> <JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
> > +            n =3D input(f"Enter setup directory name, or 'N' to quit (=
{setup_dir_name}): ")
>
> Isn't the convention to put the default in [ ] in such interactive
> prompts? Otherwise it is not clear that hitting enter will proceed
> with the default.

You are correct, I thought is was ( ) for some reason. I'll send a V2

>
> I'd also not special-case N, one can hit ctrl-c to stop rather (and
> that could be hinted).
>
> Alex

