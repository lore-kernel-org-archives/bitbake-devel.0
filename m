Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E86E9A052
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 16:58:05 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18824.1771520280216489910
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Feb 2026 08:58:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e9klGXrM;
 spf=pass (domain: gmail.com, ip: 209.85.128.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-794719afcd4so11692447b3.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 08:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771520279; cv=none;
        d=google.com; s=arc-20240605;
        b=dk4C5OI8/VkTsYc5rdQG5CHP6sry5TVucHTA0eI6cKTaIz/JfeFIyGPu3HckKnaT0k
         Lp5KaMJB0Rl+Sr3OCJmJ0CrtYWHRTGTutLnu/59icH/rAG1HsfwZJ6aaUiNGp0ekQvbC
         UkglgGcVVEnKlWU+BG1lnfho9ZR6lFf9fIciRtirPY9eW/VvqRyfwPRUYqbbf777mdpt
         NE6LXoBNKqWLqFhG4JSmXsLUZActFU6fHTD+NvEkFSjZUnG5+X/w4HE+20FNeRtaqh9w
         bLK6B3+/bZYbpaMHyNhIqqK08jO21qqdj6Fx9v2RMTpyxiOjtELEZ2rjl1Vk5f2UL6UD
         vbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8lfVgr+voeG9ZLfr47nKKLXFPpAKvlDv8Kx366idSfE=;
        fh=kwhZ3Li+yPVxdlH3ayfQoAuPa3/pJuSlz2Co5M6h6T8=;
        b=kGChbhrNc6YUY4wd3JcRK8v22JzTa28/miCbAtgzYO9ZvNE5PKC1f91dkPczGHc0LK
         rvgLLErd1cD3KkXJOOT85QHGYEewmGILBhwFxzTYvN+G3P3M943kjG0oxEASvqxqxWG3
         j+4ym0pghilMIAZIJWMLIwni04B3Lp+VTcmn85UAb43UTq+rsTf1Dqp4kpV5J6V4aE4Z
         nCYFkXdZeJKiutxKo2Ebb2Kw7hKF9X3zL/sTdhP55U3R9IezGv39Ef22Sxx7KFwRju+H
         1eOtprd5WpMvDWnlNZZ2iEKSii07QVHqPakuNwB3kz+MwbrIxjbq+dz2Kz0vbIVs7NXW
         CvdA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771520279; x=1772125079; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lfVgr+voeG9ZLfr47nKKLXFPpAKvlDv8Kx366idSfE=;
        b=e9klGXrMjMNbybisyRmCrEpPssTyzR9rWEbuosAojKdQwQCCyZkyzegUozdRaauxJ/
         G+RDgemmfUYb6Q46s1SvC0tkg/pVq/cWZBx8b0TNpUkKLIh2pl8Flv91xnUQfE/MSxjb
         JplOM2bt3rHFz0UehQ4/vPnhm1CwVQ1rmisi1Tf4V4ddK2Z1zvajxuq0UZP+rKasK8BC
         5LMJ9QKFIy3FuVrWIEdxfs/CPR68xJh4vpjhGQ37AxqqlBd/3/YRYznuqCMxOoCXHH/z
         MF4D6TyAnjqtditTpMlTZEFcTUFn+hZ72l8RoRmy6DrgCWPYxhOGvwySbGmXfxd6WbCe
         rOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520279; x=1772125079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8lfVgr+voeG9ZLfr47nKKLXFPpAKvlDv8Kx366idSfE=;
        b=HLnVTjJO/RlzdBfXLfxzZ2exd0Edrq+EUhx+umtpc+opYJctwIuPG/5sb7V/zY+1hY
         Mz5g0T+zAkgao77kToAD/tdfJgY4HnoMlseqtSkvfBl047MZ4IkeQn8iWpcGhNCCOIML
         A+X1HCuwU4wRD/OlzE/s2w8cT+HjIvB/k04GBpPKNwVVulkTLO4DL09v0T3yx89QTJGv
         2qwPq1wKnnIlincPzjdDBQ8fFLZyu0xAlQo0kccJJOxveJCv+AKJekI1kG+6i1DvRl2l
         jNDbRubWDs+R3V0i2vbadb3lmHOT2cxhENUIpN/xU9XnILh9hnOPzVKNbTrQ9pGAPLrj
         fOyw==
X-Gm-Message-State: AOJu0Yyun0RZovhVZPWeEfeW6i7pjYobM7L6QiF5+QJJWnqLX5DbA3/H
	ZtYI/wlKKOCf9kKOsONvP2ocbtGZvBaYmvBvl8QpexBJtIBei3qGEJHOgydMLRxZgjwLMrx5hWa
	laihPuI/YrgtjxeKcnivCuhNhUVHJqXI=
X-Gm-Gg: AZuq6aJR4x34Juvvnbyk/Lx4rNKwZTbxAsM55hlu9w9jdNIgJSii4JG5f04o9Ig1DHY
	7EHF1Zd7Ectf9eeW8WlZ0sc2ZnsOz6WBpwr7ZM/GwrJdMhov+s7S6jH9AS+tlHVWPJeacLYgxGM
	HLt+1+1Ffv8szEzy+zdcpD+QCa3vEu3MPWjRiivSUlyprCevC8SLlWmKF/RtX1TqEZXS7KFrasY
	EH+a4rsNk4D4JFraHK1azen5PXCnxQ/F4diEFG3hDHgQsLZR5Es47LFGa3hv0nsyUhtQKlm/aUX
	0oC49v8edFgc/BLmJFo3kA==
X-Received: by 2002:a05:690e:d58:b0:64a:d35e:d356 with SMTP id
 956f58d0204a3-64c198c72e3mr15133485d50.30.1771520279192; Thu, 19 Feb 2026
 08:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20251030141904.69494-1-JPEWhacker@gmail.com> <20251219223620.2222861-1-JPEWhacker@gmail.com>
 <eeda7effdc1bda1ac5422ac7cc8095d46021a578.camel@linuxfoundation.org>
 <CAJdd5GbPdL4Ah3d65Uqap4An8MqrY=KiEsdhgk3gR77q=HYFyQ@mail.gmail.com> <d99ad183e6b7199eb5dbef84ea7b3b48501afc36.camel@linuxfoundation.org>
In-Reply-To: <d99ad183e6b7199eb5dbef84ea7b3b48501afc36.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 19 Feb 2026 09:57:48 -0700
X-Gm-Features: AaiRm51ciC1Uo8vUtxHusrxYwv0qRWgBfS0y-1Scy7_l46_m8y5uKxUCn2dpy0s
Message-ID: <CAJdd5GbThCnm1TP7hUBCObKtydDVS3FTFvPEWMHHCkJgUFEXAw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] cookerdata: Include "originating"
 recipe name when parsing
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 16:58:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19073

On Thu, Feb 19, 2026 at 9:55=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2026-02-19 at 09:39 -0700, Joshua Watt wrote:
> > On Thu, Feb 19, 2026 at 9:32=E2=80=AFAM Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > >
> > > On Fri, 2025-12-19 at 15:36 -0700, Joshua Watt via lists.openembedded=
.org wrote:
> > > > When a bbappend file is parsed, the FILE variable is set to the nam=
e of
> > > > the actual file being parsed (e.g. the name of the bbappend). Since
> > > > PN/PV etc. are derived from FILE, this means that they can be
> > > > misleading in the event that bbappend is using wildcards (e.g. PV m=
ight
> > > > have the value of "%" instead of the actual version number).
> > > >
> > > > In order to allow bbappends to derived the actual information of th=
e
> > > > recipe, capture the name of the original recipe being parsed as
> > > > ORIG_FILE when parsing a new recipe.
> > > >
> > > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > > > ---
> > > >  lib/bb/cookerdata.py | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > > > index 22ac95eac..fe41bb3bf 100644
> > > > --- a/lib/bb/cookerdata.py
> > > > +++ b/lib/bb/cookerdata.py
> > > > @@ -512,6 +512,8 @@ class CookerDataBuilder(object):
> > > >          bb_data.setVar("__BBMULTICONFIG", mc)
> > > >          bb_data.setVar("FILE_LAYERNAME", layername)
> > > >
> > > > +        bb_data.setVar("ORIG_FILE", bbfile)
> > > > +
> > > >          bbfile_loc =3D os.path.abspath(os.path.dirname(bbfile))
> > > >          bb.parse.cached_mtime_noerror(bbfile_loc)
> > >
> > > We discussed this a bit on the review call today, I appreciate Joshua
> > > wasn't there but it made sense to try and unblock this.
> > >
> > > In brief, the concerns mentioned were:
> > >
> > > * no tests/docs
> >
> > A test should be pretty easy to do, I'll see if I can write one up; I
> > can try to write some docs also.
>
> Right, those are straightforward in many ways but it also establishes
> official API which is a concern. That isn't what is holding this up.
>
> >
> > > * not wanting to encourage wide use of this
> > >   (conflicting with the above)
> > > * whether the name is right
> > >
> > > The idea of using a __ prefix for the variable was mentioned. That
> > > would allow Joshua to address the issues he has but not make it
> > > 'official' recommended API. That might be the compromise we need.
> > >
> > > For the name itself, I'm really torn. For variables which bitbake
> > > itself responds to, I've tried to standardise on a BB_ prefix. This i=
s
> > > more a variable bitbake exposes for use elsewhere and we have the FIL=
E_
> > > prefix already being used but I'm torn on whether we should continue
> > > that theme or use something with BB_...
> >
> > BB_ORIG_FILE then? I'd probably avoid the __BB prefix since that is
> > reserved for variables which bitbake used internally (only).
>
> Someone did mention "recipe" instead of "file" might be an idea so more
> like BB_RECIPE_FILE maybe?
>
> > Alternatively, if we want to set a new convention of "hidden"
> > variables, we could perhaps to do something like "bb_ORIG_FILE", but
> > that is kinda hard on the eyes :)
>
> I want to try and unblock you, yet at the same time discourage people
> from using this. '__' is the best chance of that we have. I really
> don't want to do bb_ as that is horrible on the eyes. Part of me
> realises it is completely futile to even try and do that and thinks I
> may as well not try.

Fair enough. __BB_RECIPE_FILE works for me

>
> I think the horrors people could implement with this are problematic
> but I really am not sure we have many other good choices. Layer
> specific dangling bbappend controls aren't particularly nice either.
>
> Cheers,
>
> Richard
>
>
>

