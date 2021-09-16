Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web11.3495.1631824250900493116
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:30:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lj93rTgB;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: andrea.adami@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id g8so21444139edt.7;
        Thu, 16 Sep 2021 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsY9HHjQjJNbo87TM50vEZX5MfOcNFVy37+koyFLKrU=;
        b=lj93rTgBIR3T7KkZ2G8vsd7Uk6iGEmZFaDgKGGXEe4YbW6gdA5Dguw143L28SSPc+g
         8eJGIg6ucegdE1IGSCQgS+NOyPuRNb25G1c3mDfXtKdIQHtdKtD53VSD4FnMQa2JMJAJ
         sH7ByOJnzb1rQMk+pT0HPfdHKdSjK5BTKhrp5Nm7nN32X7TiP7/4jznxTBtMsNSpSzta
         E1xoYwDs/hPUeYSjFpdQzEGKpYfYWNmN6mFQ7M8rx4vGQXgImLQtoGWUoRDLAG9zxkzC
         +isgGAY6fE9zPsdsRQpphkaDsY6GiCRQQO4g5GU1/mrWxLu/90cFQMFvMhRKA7KS2fMp
         Ltjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsY9HHjQjJNbo87TM50vEZX5MfOcNFVy37+koyFLKrU=;
        b=2NJPi2TQDqgEYZDXRUGDbQhjzc89H2Fnw6RPRIfKORceNR9s1CDc+mJRsihmRyC8kg
         bBFLo+Ylf/DChPR3Ps7OJ8LyeOTyL2SZtvP4nwtqmhqD94WPz+g5dnNxG+z3CccxqTHd
         kuUQ2q4HliHHsEtdWYwz7OdVHoE9NspC9pcX/0GHd+syEvPxT2S8rCE1TdhUUMtru2NO
         qjRTcHIGgrM7P1lqUUaCMNKy/tYMHGlaBJzJGzX0LObHQJVAzlgInmU07+1jN4adw5f0
         hsZOldBSFoXvaonmVdeU02xptAA0eipoUM4h7efoQwGR4r+rXxGJsjZ3vciIWp/uMEbm
         mmKg==
X-Gm-Message-State: AOAM532A9j4Y/njc93ctQ+9ZUMimU8gBBiJZd1IIfhldmgAERJCdtyVP
	u7yACKVgXiGgyZ12QTAng3jwY3wXdMxQ7Krm+58=
X-Google-Smtp-Source: ABdhPJz9rpxuwY/MobAPLFyqoqWzhvP+6g1j445ZibU7Cn8G8NviGGPA1RPwfeNBBnQ4B916cymM6yl771yyaWwpK8c=
X-Received: by 2002:a05:6402:42d4:: with SMTP id i20mr8587462edc.348.1631824249148;
 Thu, 16 Sep 2021 13:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKjpqyJZGQh0BruPiny5X=hv3iqsfzj+FJwmdzXdWm-ThzgQhA@mail.gmail.com>
 <CAMKF1soE_CY13wubo7mqyTUKpVqXipqOCsoXhEjeiw-AqDAcsg@mail.gmail.com>
In-Reply-To: <CAMKF1soE_CY13wubo7mqyTUKpVqXipqOCsoXhEjeiw-AqDAcsg@mail.gmail.com>
From: "Andrea Adami" <andrea.adami@gmail.com>
Date: Thu, 16 Sep 2021 22:30:37 +0200
Message-ID: <CAAQYJAvZbSNhoCMcpg9f=7qY7MojpyDdzSqDGBtp73FENLb0jw@mail.gmail.com>
Subject: Re: [Openembedded-architecture] Disable bbappend file from another meta layer
To: Khem Raj <raj.khem@gmail.com>
Cc: Mayank Agarwal <mayank77fromindia@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 16, 2021 at 7:28 PM Khem Raj <raj.khem@gmail.com> wrote:
>
> On Thu, Sep 16, 2021 at 9:45 AM Mayank Agarwal
> <mayank77fromindia@gmail.com> wrote:
> >
> > Dear Experts,
> >
> > Is there any way we can disable bbappend file from another meta-layer in the current
> > meta-layer or recipe file.It will be of great help.If we can use PNBLACKLIST or BBMASK
> > to disable bbappend file.
> >
>
> bbappends can not be undone sadly, maybe you can try some BBMASKing it
> if its in unique location perhaps.
>

See here one example:
https://github.com/vu-plus/meta-vuplus/blob/master/conf/layer.conf#L4
vs one allowing them
https://git.openembedded.org/meta-handheld/tree/conf/layer.conf#n8
cheers
A.A.

> > Regards
> > Mayank
> >
> >
> >
>
> 
>
