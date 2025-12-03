Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE514D12D5B
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 12:47:56 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14442.1764766073280209938
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 04:47:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=imhYNLWg;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88678d7ed65so25966446d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 04:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764766072; x=1765370872; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qdPcnIJw8T8qq7JuvLrAn+tGyzmLNIJJ8ZmVKHTcNiU=;
        b=imhYNLWgQVeKZd8lX21UNmVdcekc4UxACDVbOw0agQj2CP4cYXuQIKFnuMBx6ylhV1
         eDZOfhUZdlSA7ZoJv9lNArmGNoZSG1dFFUUTE69bs/igUzopj5abtmVz7qW9ceLgie5D
         VtMrtf4KZ2YR2nfWTT0iens3M8bX5K/2n/Fzx3Puwkwthn/JSmoebgnjt4q4F0ZHtpX9
         8n49H/146tEXCIb1H6xaWE9A9HZgfk+yzvsSSGUn8rcVJ8zOmH6kfJIlxhvyalpxvVlJ
         W7D7A740ZCR2WndmIShEIfbHIeSQeXmaM09g5XhF0Yl2R+uTtJlGCqpZwKfB8MRtVVN/
         gAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764766072; x=1765370872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdPcnIJw8T8qq7JuvLrAn+tGyzmLNIJJ8ZmVKHTcNiU=;
        b=b4Kcf4uAGd/UtnTUCgs8fLsxU84sQCrWcq7YS5KE4TMK8X9tJexvnTdYDevUetjNCk
         KOme3ZlDlVfOjBFuBLB2KXYy2/qXCigpvzYOJAZ/W7D2WbgAH0rs5ksbsSYx6DY4Xr0u
         bAYwrkVaA5PHUFVdKTux6/ePkCr4trsOhXakjbl0BDdnA4EveHDgiFHFMHO1iAztQ6j4
         f7lAelKp0shbt2shkCU/3MZoVSklPGVcz0zMa+x+eJktJqeQ8da4yjD1HEMfL2cFZll+
         wSkwyrujxpHVkEwy2uFzuSsxsE65YV+4bVCYtwSSI95w3ahqe2pj8AXP5sgYODRouGmI
         ANpQ==
X-Gm-Message-State: AOJu0YxRHK/3afSaDifuuT2V6zGoUlI7JogsxCSbQB7Kta26FpDfkNXt
	EZ1yCuGAgc5Hacyf13lO9ABYV4W6HorP0LtsvpADLuqh6+E+209WFXRxw4mVeFu9Ly18XT35KP1
	4n8bcy6YTgWsPBhUZh39fBKJ1TGBuEGo=
X-Gm-Gg: ASbGnctSfojXIOaet1diFSxd2Wr9r7f5/O/HlhvZX1+8S+QLMRzNPvaKIj8CRfbb7bE
	wvsIbXHaymYZQK25+Y08ges/Vl0XJsqHYj3uN5rW5nyOfFzgoOplVRmFkaIhm5b3FBvGAidVl+z
	DzLlrkDPILN6x4v33Oj/65zonXH65WwncZdwXNxyhu5jSCtrVbxuaFWo9lHvYFp51eyLgkUk71g
	2d7D5wVN8m1XtaogiBa5gn7XfcCMpVtqV86Lpkm1dkuKbi9B/tpoXbmkpgf4f+LHORQR0lRWezm
	nxVQG1ICKCc+CK44o8vG4zgUQgvLMg==
X-Google-Smtp-Source: AGHT+IHgyqSMTH1JZ8twlaJlBp7acaEsb/dQWnxW2AV+8XWbvLD+AwDpNvTGWsIAs7KMQWD01HMRH6RAl6Uwsvfjahs=
X-Received: by 2002:a05:6214:5242:b0:884:6f86:e06e with SMTP id
 6a1803df08f44-888194b5c62mr25327996d6.16.1764766072285; Wed, 03 Dec 2025
 04:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20251203-bitbake-setup-input-consistent-v1-0-3c7e6edecd57@cherry.de>
In-Reply-To: <20251203-bitbake-setup-input-consistent-v1-0-3c7e6edecd57@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 3 Dec 2025 13:47:41 +0100
X-Gm-Features: AWmQ_bkQWm_prCCLAU7kBB5htRLAB6EyJWITY0Bxi8Q43FejjbPQd_Aqub6Z-f4
Message-ID: <CANNYZj_9edemAZgTa-xqE_HrftTuOAZ=L+iz9vsZfqtXcyOvag@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] bitbake-setup: improve consistency in prompts
To: foss@0leil.net
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 12:47:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18527

Thanks, all three lgtm.

Alex

On Wed, 3 Dec 2025 at 13:15, Quentin Schulz via lists.openembedded.org
<foss=0leil.net@lists.openembedded.org> wrote:
>
> The prompts for integer inputs are displaying the user input after the
> line while string inputs are displaying the user input next to the
> prompt. This aligns the behavior to have the user input next to the
> prompt in all cases, even for numbers, even for retries.
>
> This also fixes what could be said to be a typo: the colon was added
> before the default value for one prompt instead of after, confusing me a
> bit as to what was expected from me.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (3):
>       bitbake-setup: allow to pass a prompt to int_input
>       bitbake-setup: make all callers of int_input pass their prompt
>       bitbake-setup: put colon of prompt after suggested default
>
>  bin/bitbake-setup | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> ---
> base-commit: 720df1a53452983c1c832f624490e255cf389204
> change-id: 20251203-bitbake-setup-input-consistent-1186fa1d45a3
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18523): https://lists.openembedded.org/g/bitbake-devel/message/18523
> Mute This Topic: https://lists.openembedded.org/mt/116592605/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

