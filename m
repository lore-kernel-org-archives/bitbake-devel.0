Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9669D2FECC
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 17:47:11 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17764.1769536026699262459
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 09:47:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AC/NeOHl;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-502b698e510so72675581cf.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 09:47:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769536026; cv=none;
        d=google.com; s=arc-20240605;
        b=VeB7a4b8MaWYbfSSsl2BkoNndsyIOsbLP2dn2gxOGZY9vi/HcyClwCNf1cxg+Lv4me
         VNBv+gKn0iESHwsA0v24NPqH0pzW5HSWwL07pOcEx9hCfMoJ3AuBXp3LBeUI09pGJwEc
         2TEKCVfiWhyql3TIx/WhAFxnGTlsDQy1wbUW4uXjyugMtc4vD2Q0hntToVMdMUk7d7wS
         2GLWGB1LqdhQfSFpNx2g8J/Bjemdno9LVJleJd70udc/AOREh7quO070O0Vgpo6wNAuB
         0tIXh/Vbaco7iAheuRhxDG2q7w1lw0AsbcJaKHYM/jNXo/6qvyKZMp6Cp+oYGmItQk+7
         eOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eQvQk0yeTFxLKE1B3hpGwIjNTZpr+MmBS/ubdrvqD9Q=;
        fh=P8aLSC5zQr+tYdwm1eUijcHhQH79GyCkTcjS8nZF+aU=;
        b=eb2wp7Wm6LSn5QG5rEb0FikmLhclqt2WKigKznvAoFcEcD9YVD4oUrBZfDqYDdr7zp
         6f6h8oPCzdHdk3PGnYDpg9W37b+AD0RJP/rlE6LE1cEmsoCbmSfpC92d1qzygwqL1GfP
         ZrWsIhJmvh9Dexd5rOs1N49aMlJznwdUjDiTRT2OTpiDT886iBeLJlQnbZlQLy+71QC9
         SfquZMmEsNSfWApccdOhyLHfvdV/V3FtiWGL2IhNJ5bFkkq8WYkmRxpPT1ajNOW2EOuM
         0QjseXmZ2wyx+OqFG0IuQ4A9ZbJjC8QmVpY09MeWZf5QCTWbmI1F2Qkzxl8mrIBhMkq8
         dOZQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536026; x=1770140826; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eQvQk0yeTFxLKE1B3hpGwIjNTZpr+MmBS/ubdrvqD9Q=;
        b=AC/NeOHlgGR6H0jjuIJBoBLCMEfKgTqgT1xe5XsoEngDeoa3EB6iZtlV3lJdzM7UGZ
         WuQ24Ww777ClOq1+a1FGvECkggjQpwIcHfMkhU2GJ4evBAFfqOv15J//4nLo8qf6NCU+
         ZOjs7Kc7rNErteuwHqAYxKtEB4SCcThyaU1Y/MBgVZI9pHWQg7W+v4KCRYaEcDuOXqdA
         uBD/4Mn0qdzMjek6nUfaNW0gp7D7+9nsgp3PcNzDXBXmAmg40LaJXrecBm6gbcnTTQST
         JbuH45JQmdTGcr8cE41eeZ/yjI0GiCPXdQviLVQ2anL5oMgLn5SgXYddYjnvUYh4ABpT
         7v+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536026; x=1770140826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQvQk0yeTFxLKE1B3hpGwIjNTZpr+MmBS/ubdrvqD9Q=;
        b=S2405MQGrScehUVWyc5ozYq4Ocfe3si9ZEen7/FbjcOb35gNqVbNZS43nrpbndojJo
         Q9jeTfLTTz/aP43+TybTwuRaPv22Vk8g7dKCpxH65Ssl9zlOluG/eR22jHDL/e+GEMDg
         28qhKqXvfysoIxstKQ3YtHcFIdmM8/fCjAvry2LJBxelyORYDXy4LNcHwWwql560DlZd
         1WErvZJlgwjCPS/07xcLGrS/rxZ/lf5btq2KbzHWEUQxSIzW7BxIXLNg9/zBysQe01TB
         8rlFxPwI5oJWForbllbpOaP3FwfSu00WdcjsRWTcxrwbyvVCvHVgGBMuqDZwRN0hup2t
         qCAg==
X-Forwarded-Encrypted: i=1; AJvYcCX/+Zb4qQbsnA51j1hHf3U3Kal0amQxZBQ/5zPymJpV+YlZVfi7eCq7g0ULgc/VJrPNCR6Jia24y522gkRW@lists.openembedded.org
X-Gm-Message-State: AOJu0YwU1KW25MaM91WS7G9JHxJUIMGNMz5gRsOINucK620E0rxP38Cf
	Kr98IipsazpGBXlUb86qo4TmejMLHWoF6iNUdPhlHD9r1Tmcm2PGibS7Bl0UO5tEgudd2loCisY
	fGah1d76EYhiP/PAR7ZD4xSehN5zUdzQ=
X-Gm-Gg: AZuq6aLu+kVO0pHd4gFx6LqURnysNoVp/xMU8+w2IF5yQw2N20tezpLdm9MXnPq9MHP
	S2x+ql/yyH4FG9ZOtCDuSO04ODE+n+Imh68D3oxX4mDX7clpJ9BTQddl5PvQ3oR6uWQjqzynn1f
	xgATTkK4CoqHZIjKpW8PtA3qM2neyxVRvwHTacTr2gtRDiac8WYRpyMsO5tpJfybrjwQuYR08y/
	zPybxL2Cpd6/dFnm/TjPLBr83zOROwPotne0+TyLWlUgyqFci0V6lu2UnPwE709ak9I+Yn5Zh7p
	cyyfZogmKfJQfeBUy9oyVITuQM7/nQ==
X-Received: by 2002:a05:622a:11c2:b0:4ee:26bd:13f3 with SMTP id
 d75a77b69052e-5032f74ac2fmr31556061cf.8.1769536025671; Tue, 27 Jan 2026
 09:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-5-daiane.angolini@foundries.io> <DFZAULAJWR0S.1RQ0LXOE4BSUR@bootlin.com>
 <CANNYZj_Y1JiRoXK3iW2mwe1Cvga95icXtx3FzByfBzRs4upMuQ@mail.gmail.com> <CA+HEL791UhQ28wsGx4zofiadgbgx4kfYDG+fQR6P1PrTvKQeeQ@mail.gmail.com>
In-Reply-To: <CA+HEL791UhQ28wsGx4zofiadgbgx4kfYDG+fQR6P1PrTvKQeeQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 27 Jan 2026 18:46:53 +0100
X-Gm-Features: AZwV_QiMI_oqoAiPR9lA15_jEFvZ0y44diVV5Adu1DkT0uLLlORZBEZ-wieBXO0
Message-ID: <CANNYZj9+x9hxi2XFOM5G5FUCTT+tkrwmtoY89JrOSQMPpx2gJQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs][PATCH 5/5] docs: Fix sources as required
To: Daiane Angolini <daiane.angolini@foundries.io>
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 17:47:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18902

On Tue, 27 Jan 2026 at 14:27, Daiane Angolini
<daiane.angolini@foundries.io> wrote:
> For this one, I'm really guessing. Because, when I made a "wrong" json
> file, I got an error that bitbake source is needed (so I added
> bitbake).
>
> But when I drop "sources" completely, nothing is created (and I was
> expecting at least the top directory and the .conf files)
>
> So, saying it's "optional" is not accurate, but saying it's "required"
> is not accurate either.  But I don't quite understand the constraints
> here.

It's just that these are all not very common corner cases, and they
aren't tested. We test the common case, but if behaviour in such
special situations doesn't make sense, that can be fixed in the tool
itself if there's a need for it.

'configurations' without 'sources' doesn't make sense though, as
configurations contain lists of layers and fragments, which are both
references into sources .

Alex

