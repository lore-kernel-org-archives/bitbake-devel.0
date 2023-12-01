Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41340C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 12:15:56 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.21187.1701432955803471025
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 04:15:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ALwpRiHt;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c9d33f049cso19092621fa.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701432954; x=1702037754; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ErrM1HfVxZelTb7z2r/qpyF+3SBKdQ0NJ2bVeqTMS4=;
        b=ALwpRiHtz7RNAtm1UhzyAZT8NW3Xk0A9qCuzUDYxEV1uo90/SDzBso+Rg8he97US4i
         mnLt/09BWMIBDXB2mraAFaglN7TfMkSAo8GicygdOXxKDfQ36MdFQ/W/rnStI9DCWHGM
         mTkMKpNAGd89bDSCWqDgAa713ni8PSfD58MioD52TzwzBD0L3hZJs7lXizhF0UIO4hJm
         huZ+K4CMuZcQVpQWM6AlbHSxvwl5nHN13LZIqQ17wOdUrDIRes5L/SFUCDJyA+9uolM/
         bThKuPo1idLknc/7j1vOfiqsEeCmn8sX4mpZbtxCF7XACyMPXD6KjONqDm2PJf1ldFs3
         U75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432954; x=1702037754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ErrM1HfVxZelTb7z2r/qpyF+3SBKdQ0NJ2bVeqTMS4=;
        b=eVuJM3+WbcCcYncUgabfyrGOtMWs00DfpEFkHba6AxYQUYXEX9yjTfZWVu3/IuXHOi
         cjAeSx18SDQ/vBgnjz6cdGidP4lgvBnYavFIwvHgL0xxRjil3ITjkbO34MIqd9WtysBi
         7xjGzBkAlNnWewWP02JIuwTXDDE4l1T4usv1oeJSfa54WrKsCYyc1DB4wM82sfYVRXpR
         SqAof3TAilTBPF27Aslc6qYRFuyD3b9ZgLV/dIpk8zZoIhf1gLdx8wu6Oq/Thf0sRfDr
         o7ukx2LzkUFKJdetZyDjE/MpD2pk8441i4+fNwdPzOW28pzlu1Ay8c88Jk0z8IkiyIB4
         aEyQ==
X-Gm-Message-State: AOJu0YweV4q9JwHM/CjHsKO8kMiVNsl6SsjPYXzRl5MA385qBErsmKKs
	AvVh+bBw9+MnCOWFCwq5vlbOc3xZ1zbgM8nrEmk=
X-Google-Smtp-Source: AGHT+IF4O9NEu/whOOLMw9twEdVn+qWq+80yejOmxo6vOZaUxXMugWekEAakEUbwvdONPgydYumc4qLVTQ4R4tNxKD0=
X-Received: by 2002:a2e:9005:0:b0:2c9:d874:20b7 with SMTP id
 h5-20020a2e9005000000b002c9d87420b7mr730532ljg.65.1701432953774; Fri, 01 Dec
 2023 04:15:53 -0800 (PST)
MIME-Version: 1.0
References: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
 <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org> <513a7d673eb8cdff5cc8ae0c5717ea3e81349da3.camel@siemens.com>
In-Reply-To: <513a7d673eb8cdff5cc8ae0c5717ea3e81349da3.camel@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 1 Dec 2023 13:15:42 +0100
Message-ID: <CANNYZj-7f=a9Bj2Ec83qS=vyCU10Wz2zdn-vqey0ThbHUjn=tA@mail.gmail.com>
Subject: Re: [bitbake-devel] AUTOREV, PREMIRRORS and unavailable upstream
To: felix.moessbauer@siemens.com
Cc: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"Kiszka, Jan" <jan.kiszka@siemens.com>, 
	"enrico.scholz@sigma-chemnitz.de" <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 12:15:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15600

On Fri, 1 Dec 2023 at 13:05, Felix Moessbauer via
lists.openembedded.org
<felix.moessbauer=siemens.com@lists.openembedded.org> wrote:
> there are more cases where direct access to upstream projects is not
> possible. Simply consider airgapped environments where all resources
> are accessed via local mirrors. I'm also a bit skeptic about the
> definition of "latest". Git by itself is a decentralized VCS, meaning
> that there is no "global" latest, but just "latest" revisions of a
> local copy (in contrast to e.g. SVN). These copies are just eventually
> consistent.

Perhaps we need to step back and consider the reasons for using
AUTOREV in an airgapped environment. What are they? Perhaps you can
replace AUTOREV with external tool that updates SRCREV in the recipes?

Alex

