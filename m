Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B9C04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 17:03:55 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web11.21714.1715706232391786354
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 May 2024 10:03:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CLkCSr+J;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: raj.khem@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23f0d54c5ffso3776783fac.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 May 2024 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715706231; x=1716311031; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkHgFFzBWT3sG3T1NatiDZA6joUOPc5aVF30tTdzV5s=;
        b=CLkCSr+JSF9HMbpvdgeInpY5oO8pqAnr/G7iIwgDGz92mE0tZl/17Zni3VSTfUYoHW
         2mYF6hFljloJVogrIrojzRamt2AeoBbNUNI8ZDoXm+HmaYeNwY0Mcpodv9GZwNLOuRkY
         RqDuFlkD5GfBHYVXSpK2WetTBzUW0R5pDbEC/XOOn7RroJcCEG3/DDURbxGT0vCo56sX
         7yGH4RcgCDJyxJyCRP52132z7aLqqrBCe9nZrzhl2KqAm6N1lc8S/s5uuA7b2zobXMvw
         UqOSXXqujkAwX3JKhZpZrrQ1ARhpZXSvf+hVlj167pX5GLeuRQe1vNeZc0OHhgI1fvVV
         MCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715706231; x=1716311031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkHgFFzBWT3sG3T1NatiDZA6joUOPc5aVF30tTdzV5s=;
        b=r1BEPb+9zng2r47CcNrVf+3tmGUVZa0TNGkt1+0Y74IPr8rPz2jggccAgVabAZ6BKc
         9EIsWECX1XE65awvJqgUeSlBey2wI/heLBqznGfbdi77DbPx0EBkYO3Js6OXWCARIvVM
         erosfoDsU4IuiKF54Kamtw9m5ujY1ofAP71kV2jKUFi8tb2sEBKyu+MkTncLS6LYaPSh
         WAYrtrhZ0KSytjaUpMZWtXKVJ2jo07aswNM/QyBDg1xonTgYmMIvdpkzJSydMNbOG/Yw
         cgi2vB6gAqz6Ry4dvj/blnPUAVnnVa316wW+NPf6vGJ4ioFPfAwfeMURW/6cVFjxbJcg
         h00Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjfqROo6TrMCfRJ7LMhn21CRdDlpVjLh1+m7LW43ZfftUIRacu2UcFOc0oq5/u1l0VemH0u+Uyk2138LBvg2YNNSabwtfwbBVooTDpfBzJbMnP5oQ=
X-Gm-Message-State: AOJu0YyRHTxy1YacYmTYbOVajw9cmcFZQX0eIHlVZ1btki9LoOTu2Si8
	OFuW1DfV9HPPpAE6S09DAdTs4GQQB/j89WUA34DVV7Qzae6TbmtXem9YuIsfTfit02ylE9reHiC
	mqWfEFc18jNgH+qE8SYMmRiiyQCA=
X-Google-Smtp-Source: AGHT+IHlVZAOwsqscEfzsH2gJVdlfTRKfGTh99Ej2Xwg8ibfB03R6/56Q7SL8UF+oXKfWkbSWw5zIpP9iwCtTd+Pi0E=
X-Received: by 2002:a05:6871:713:b0:244:bf6e:c94d with SMTP id
 586e51a60fabf-244bf6ee995mr10748390fac.11.1715706230244; Tue, 14 May 2024
 10:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-3-michael.opdenacker@bootlin.com> <CAMKF1soyTt3He84XOgAv01ZdwGPZ2gxVwZaRxsL2Dufj3W_=rg@mail.gmail.com>
 <2a2f731e-7ca0-4442-a0e2-5e2b3bfde80c@bootlin.com> <CAMKF1soksEYiF37G=1bhDSX83iecpfVcxjiS+QLW4DciVu7LCA@mail.gmail.com>
 <bb6d8641bbc41c7ac1e32447e6b2f691127dfdca.camel@linuxfoundation.org>
 <CAMKF1srwkF=UOLvd3Een+uVLSjH6yo0XjKwG+=kDzF4g3vbjvQ@mail.gmail.com> <f4e7af33-b0ac-4620-9f96-f1c83460cd01@bootlin.com>
In-Reply-To: <f4e7af33-b0ac-4620-9f96-f1c83460cd01@bootlin.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 14 May 2024 10:03:23 -0700
Message-ID: <CAMKF1spa9OkazyZiz2MB5PDDHPkZh3xN6Zvh4UkSwbs_PLY1Ew@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v5 2/5] prserv: move code from __init__ to bitbake-prserv
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Joshua Watt <JPEWhacker@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tim Orling <ticotimo@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 May 2024 17:03:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16218

On Wed, May 8, 2024 at 10:41=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Richard, Khem,
>
> On 5/8/24 at 20:43, Khem Raj wrote:
> > On Wed, May 8, 2024 at 6:35=E2=80=AFAM Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> >> On Fri, 2024-05-03 at 07:14 -0700, Khem Raj via lists.openembedded.org
> >> wrote:
> >>>
> >>> On Fri, May 3, 2024 at 1:04=E2=80=AFAM Michael Opdenacker
> >>> <michael.opdenacker@bootlin.com> wrote:
> >>>> Hi Khem
> >>>>
> >>>> On 5/2/24 at 18:57, Khem Raj wrote:
> >>>>> Hi Michael
> >>>>>
> >>>>> I am seeing a problem with this series, specifically following
> >>>>> patchset is causing a regression
> >>>>>
> >>>>> * ea1d7b8a36e bitbake: prserv: add bitbake selftests
> >>>>> * 5c66d345300 bitbake: prserv: import simplification
> >>>>> * c23f2c1680f bitbake: prserv: store_value() improvements
> >>>>> * 395b321af29 bitbake: prserv: avoid possible race condition in
> >>>>> database code
> >>>>> * 8022dc1029d bitbake: prserv: enable database sharing
> >>>>> * b81bfdfbed8 bitbake: prserv: add "upstream" server support
> >>>>> * 9539ce3b14a bitbake: prserv: move code from __init__ to
> >>>>> bitbake-prserv
> >>>>> * 4ec1553710b bitbake: prserv: declare "max_package_pr" client
> >>>>> hook
> >>>>>
> >>>>>
> >>>>> error seen during packagedata task of base-files
> >>>>>
> >>>>> WARNING: base-files-3.0.14-r0 do_packagedata: Error talking to
> >>>>> server:
> >>>>> Connection closed
> >>>>> ERROR: Error from client ('127.0.0.1', 59846): 'PRTable' object
> >>>>> has no
> >>>>> attribute 'sync'
> >>>>> Traceback (most recent call last):
> >>>>
> >>>> Thanks for the review. Actually, did you test with the V6 update I
> >>>> sent?
> >>>>
> >>>
> >>> I think it was version in master-next that Richard has staged
> >>>
> >> It was against v6 so I'm not able to merge these until that is fixed.
> >>
> > Right, I will try a  clean from scratch build and see if it was somethi=
ng
> > intermediate to be sure.
>
>
> Thanks for testing.
> I confirm the issue is still there. My apologies for this overlook!
> This is a busy week for me, but I will submit a fix as soon as I get the
> time, and before the end of the week anyway.

FWIW the new patchset seems to work well for issue I was seeing

>
> Kind regards
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

