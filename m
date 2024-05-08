Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B1FC04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:14:03 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.15241.1715181242303943962
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 May 2024 08:14:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IwxWRgfA;
 spf=pass (domain: gmail.com, ip: 209.85.160.48, mailfrom: raj.khem@gmail.com)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23f0d54c5ffso2459690fac.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 May 2024 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715181241; x=1715786041; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egS3f28gZItPZ2vQg6hUei482JoczXQ4P9FbRygWWWc=;
        b=IwxWRgfAyhgc1UPjjM2aYiYYe+Ip5YmEz1P2bmT2ujYpVTyHi+6bCZ/Dhi/D4my/Hy
         LTw94QFDARcZacqxOcTu9+4hZgJETuV/AQwpYiKXv6t0E0ExH2mOkicqXCqzxXRailAD
         8lf+PexsleIGVyb/lMoezGqsesr3iMvJWlVq7Ob7lCPzO2mi8Gcz6y1vlhK21xy456wr
         s4GHvs3XkJrBbQb1UxgubvTbbCb35fKXYA1HtPfbcKQA9anj8oe2Ll6/EQR2bSt8nV1A
         jXB1XsXuliXAdarSD1gIt7DSDQCygD5fCPqIGnF9qU8GqTFS0I/1dvHvd3OxzuxY8VUx
         ptOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181241; x=1715786041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egS3f28gZItPZ2vQg6hUei482JoczXQ4P9FbRygWWWc=;
        b=js0vJeNkyyIsXQBcuOBiEWtazogL4KATHPMTEyNQpXyc0Nm4ufwdIbdJa8bRcSN2zR
         grX5loKaj3ugb0IbW9QviytmybdbIZi0uJjt9rdI/5lhYF3sL0j8slG6eVIcYQdVphBR
         STt3xXV10U0hQeRRVLoLh0nFQZUmM6jyrt84CUhR+GET3rS7XYusrbbawW61jCouFqSv
         7QwvU63p6CbCF2cHtgwBx46l12R7WVmGo4FVXHc6vnL0s5B4qAsYqiN3jjGMEluLeynX
         upWCw7q6mhPOySmrYsuXUcZ2JY8O2KzM1KXmpNTqDf7E9fS301+0zKEmkJd52tRxUEi7
         4AzA==
X-Forwarded-Encrypted: i=1; AJvYcCVlFk16b9csdv5/zqLABBxPSpgdD18AyXkYsHC4yUQov4Yst38GT2exWF1H427p9ueGnAGPS3JDd93EU2BCRinsg9QkNiH3LzueaO+2dhlkzoI57zo=
X-Gm-Message-State: AOJu0YzgKs2eqm4EjvQa2Bwp0KLSoIVXWGYAnz+cPLGZqHH2DhGGykAX
	8s8sLFQXUYNHUj4o444GFBnTNrTwCzqnfXMyjmDnEkZg3WO1rJa676QHai8nOYmZHu2zKGMM0+j
	QMpn3Zk7WsvqQsEKTaeIr9Y1pFTs=
X-Google-Smtp-Source: AGHT+IFo3w3XstcNP7fwIIAmnOzzm6gshbJdOArq1C73TslZZ3ZCSMAWXgUUgddkoroDIDYCbuSS+4fdFOaY4G0OqEE=
X-Received: by 2002:a05:6870:b149:b0:23e:111:cf21 with SMTP id
 586e51a60fabf-24097c27cc0mr3151184fac.13.1715181241501; Wed, 08 May 2024
 08:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-3-michael.opdenacker@bootlin.com> <CAMKF1soyTt3He84XOgAv01ZdwGPZ2gxVwZaRxsL2Dufj3W_=rg@mail.gmail.com>
 <2a2f731e-7ca0-4442-a0e2-5e2b3bfde80c@bootlin.com> <CAMKF1soksEYiF37G=1bhDSX83iecpfVcxjiS+QLW4DciVu7LCA@mail.gmail.com>
 <bb6d8641bbc41c7ac1e32447e6b2f691127dfdca.camel@linuxfoundation.org>
In-Reply-To: <bb6d8641bbc41c7ac1e32447e6b2f691127dfdca.camel@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 8 May 2024 08:13:35 -0700
Message-ID: <CAMKF1srwkF=UOLvd3Een+uVLSjH6yo0XjKwG+=kDzF4g3vbjvQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v5 2/5] prserv: move code from __init__ to bitbake-prserv
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tim Orling <ticotimo@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 May 2024 15:14:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16192

On Wed, May 8, 2024 at 6:35=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Fri, 2024-05-03 at 07:14 -0700, Khem Raj via lists.openembedded.org
> wrote:
> >
> >
> > On Fri, May 3, 2024 at 1:04=E2=80=AFAM Michael Opdenacker
> > <michael.opdenacker@bootlin.com> wrote:
> > > Hi Khem
> > >
> > > On 5/2/24 at 18:57, Khem Raj wrote:
> > > > Hi Michael
> > > >
> > > > I am seeing a problem with this series, specifically following
> > > > patchset is causing a regression
> > > >
> > > > * ea1d7b8a36e bitbake: prserv: add bitbake selftests
> > > > * 5c66d345300 bitbake: prserv: import simplification
> > > > * c23f2c1680f bitbake: prserv: store_value() improvements
> > > > * 395b321af29 bitbake: prserv: avoid possible race condition in
> > > > database code
> > > > * 8022dc1029d bitbake: prserv: enable database sharing
> > > > * b81bfdfbed8 bitbake: prserv: add "upstream" server support
> > > > * 9539ce3b14a bitbake: prserv: move code from __init__ to
> > > > bitbake-prserv
> > > > * 4ec1553710b bitbake: prserv: declare "max_package_pr" client
> > > > hook
> > > >
> > > >
> > > > error seen during packagedata task of base-files
> > > >
> > > > WARNING: base-files-3.0.14-r0 do_packagedata: Error talking to
> > > > server:
> > > > Connection closed
> > > > ERROR: Error from client ('127.0.0.1', 59846): 'PRTable' object
> > > > has no
> > > > attribute 'sync'
> > > > Traceback (most recent call last):
> > >
> > >
> > > Thanks for the review. Actually, did you test with the V6 update I
> > > sent?
> > >
> >
> >
> > I think it was version in master-next that Richard has staged
> >
>
> It was against v6 so I'm not able to merge these until that is fixed.
>

Right, I will try a  clean from scratch build and see if it was something
intermediate to be sure.

> Cheers,
>
> Richard

