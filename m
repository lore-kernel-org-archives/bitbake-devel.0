Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E50ACCF9E3
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 08:07:38 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6738.1762502854449971716
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 00:07:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XWBe94Eu;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so4569371cf.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 00:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502853; x=1763107653; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwaC4rg0afgzFrJxB2c6DjfQ6PZ7Fzge7PlmokIPeWs=;
        b=XWBe94Eud5qN+56qWmvUqILysliuFUn6KneaTTKhQKTMA+hXtESu5TftQXhjiafsB/
         OzcqjT40pQfroq6+PG62GI1lmDV8bkK1nCWFc4Tc43k8kb5TzJDP4OOYiwi3VwWkdPAk
         nBzb2Go2YVUdRyNkIEK4b7jerZtPmNJ2ODfV9ug0LMzLNxgkHx7L6Q6kg/aD/LTZeAg2
         HfOwx2nhcfXRk9kLi6NtV5DJvKKOnOdlXdB+ehZjwcusCgnwmkIux7Lul5YV2OJyv0nF
         qV+r3S0R2IxxkF8Q6TVvaJ+sH2wYslXzOB/QTw2augK16miPMK8WkvqNf7AK7yvBlPot
         WwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502853; x=1763107653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwaC4rg0afgzFrJxB2c6DjfQ6PZ7Fzge7PlmokIPeWs=;
        b=onkDoCenVF8Gga8aY7vvFI2Tsrkx67+GL1SObuD+yEzfEMMh6UZLWLzPA7T4S33PlF
         AqWcQoWwd9+cC771nDR2tL+ykb+TxmBFO7U4gjXf6JuAqEoo+nNQCczeU8B0n96hmqPD
         FxS7aaN8N6s+kXNV0IaoIwAUe+rsqD9LPOim/sh1Pl495YTIKqO/WzI8L95hbpZclmhN
         JHl+QiBSlbtBYqt1UMk6546vGO9i19zuQR15g6yUxb5QATN0em+ub+PNLNu+Sha8St+a
         rqmV8l3Gy+uGc+amDAqcE4mpR+LBDy+JVIrtev+6C3di2EpYNmCG04Byb8Zox1mkXsPa
         FNfg==
X-Forwarded-Encrypted: i=1; AJvYcCWNnfrgkGs2fG+4Zen6dp/ervkn53KfGm2ewKKFAyySqkgJR5gyTSH6zGnubqPlCs8TjW3IIy5l5uV6P96V@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy8tBg/iktP9RwbLIiV2L6b1yKL4y4UpY6jnSuQw63CskZ+ws7x
	h70lJi7kXtJADWPAXNRvFc1TcGr3KM5Q2hm+ccVll+Lb//ALWARxU7negZG66cFARZkN3m0apAC
	UagsM6SzbedrG8L5TvxzivAMI2gVLMrI=
X-Gm-Gg: ASbGncsInf9ibf9oK+jw55Ihu50+Lt4YnLsL5/EdACdAWuxtzl3SXbBUQn8FdoKMcnz
	VezOcTj2+fM471tMHQz9ugIYQDtAeRhPPdtASmyv2ZOQrfyoSE+rbO/6mW38IWnNDgInk1WIKe7
	mRk3qJD6GYeit4KovC1A+MX3ZKNhTI0OXnaKpSGI4FYUPopi48CYdBlDwEe92lQxR8K4IbZEyd7
	oZxX9HGORs2snVPCRSXbU8/uXiSxu1jr5Gywex6CKOyiIG5Ht430dkEwhV9ADhl/56dJISP6Tuc
	mqeNBNY55UxDaTLITz0=
X-Google-Smtp-Source: AGHT+IHWOGgJT0P5AJaBpbroQDI1FniCPMlhzr1p0gaFhJo9nteg6yQ3Chi3FcNPxB/jHpN7TAcAPRleADaP+7pY5z8=
X-Received: by 2002:a05:622a:148d:b0:4ec:f18f:f7c7 with SMTP id
 d75a77b69052e-4ed94938fc7mr29557381cf.12.1762502853358; Fri, 07 Nov 2025
 00:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com> <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
 <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <18759C05E6F46C57.499307@lists.openembedded.org>
In-Reply-To: <18759C05E6F46C57.499307@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Nov 2025 09:07:21 +0100
X-Gm-Features: AWmQ_bmPKkrvwWrAsT5EDF5dfMRVBGa4I67N-r7zmNUpgDak2NTgE_ZE_BM8S7w
Message-ID: <CANNYZj8uZTO5R1AJ12Bvu5RpA4YTq5Jd=UmaeS9VwcqmAgRoXQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
To: alex.kanavin@gmail.com
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	Antonin Godard <antonin.godard@bootlin.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 08:07:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18299

On Fri, 7 Nov 2025 at 04:32, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
wrote:
>> After I saw Alex' patch for bitbake-setup.schema.json:
>> https://lore.kernel.org/openembedded-core/20251106170815.2439421-1-alex.=
kanavin@gmail.com/T/#u
>> it made me realize that I had not thought that paths in both
>> bb-layers and bb-layers-relative are actually relative, just to
>> different locations. Unfortunately, I think the newly suggested
>> name is then misleading as it implies that paths in bb-layers
>> are not relative. :( I now also understand why the longer
>> bb-layers-relative-to-this-file was originally proposed.
>>
>> I don't have a good solution for this. The best I can come up
>> with is to rename them both to, e.g., bb-layers-dir-relative and
>> bb-layers-file-relative
>
>
> I tend to agree. I=E2=80=99d rather call them =E2=80=98bb-layers-in-sourc=
es=E2=80=99 and =E2=80=98bb-layers-in-this-dir=E2=80=99. Patch is coming ev=
en though I=E2=80=99m technically on holiday since midnight. This is import=
ant.

Patches sent:
https://lists.openembedded.org/g/bitbake-devel/message/18298
https://lists.openembedded.org/g/bitbake-devel/message/18297
https://lists.openembedded.org/g/openembedded-core/topic/patch/116167407

I also renamed the sources unpack dir from 'layers' to 'sources',
which is somewhat more invasive, but is a real improvement too. This
needed adjustments in yocto-autobuilder-helper as well, hopefully I
got most (or all!) of it right.
https://lists.yoctoproject.org/g/yocto-patches/topic/yocto_autobuilder_help=
er_patch/116167410

Alex

