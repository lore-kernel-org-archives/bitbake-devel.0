Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web08.3538.1631824464756655168
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=aohgS6F1;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: andrea.adami@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id h17so21477856edj.6;
        Thu, 16 Sep 2021 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtjAYVzPdlnCXEvAqsHkw9mJDlYBLJpM4kNa9C27nrI=;
        b=aohgS6F159yZID5mS+cjbsjP6Vs+dV+r3ShmvKsnomsrTJ432NiWpRGC6K4T+wBRBo
         bmxML5Sl6qEllDIeV/RCZKCKNaFr6hJugi0fUA31nQSnp/SJtjZcj131hjedpOqcSiua
         oJx9vSKeXLyB55NohfMspbVniUYkvtcccdpgek/PYygpM+SOqB+6OXiKia1hSshm7Ve6
         rcKTQC8ruBqiFeHOSrFpEOlT9La53VfTr2SgPHqvmOnTzJKiwvGWWVfb2lpUSE0wi8d5
         DRySPaw9q3QTMen33w16CufSzUL31txvqJWOFuwG1jvlUle2lYdkPjVfbLgDf0We7rk1
         m7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtjAYVzPdlnCXEvAqsHkw9mJDlYBLJpM4kNa9C27nrI=;
        b=FOurISZCADhxKZpRCpuVNdBMU5PH6bokr0cKe6gqwj62COsAvHSDPB8kGdE6UQxylS
         2G2w3Hh+HOvLgDAHeu6zNFxdqDEyCdxqH1f2P6ltqZRET8OsIi0Jt172hwZ9hqkP4xFG
         NiS4ou2Uq0QhOi0dTLcVLKBeECO/1pmcfngeUBNvAtZhF+LR/ieL983yZG7stKu0Y4Bt
         E8I2308EGDaBGcDyjbNJ7KyxZOYzKP2OX6qXl35iub5/cLLyo41g5nZcE6o90dPV9vQ7
         A9jeGlJHRZC2Ms7Z9FeDTuxPGtnrOhKdXsXDvUALGsZx2cGU/BYkhYBRK2gp+E+aEr19
         DyMA==
X-Gm-Message-State: AOAM532Ec0PSl37EJfmLY+LoiVngAgDYN0Qs3/N+8o/XRzncHoYsdhmo
	LEdNM0iZd7MrzFCB+Q7tsp0VRF+QPO3PXEFK+FY=
X-Google-Smtp-Source: ABdhPJyBRCTPLnN1np9RdoWKXZ3AH28wP9280mlwZ01qo1mLl5OBscaJKTjaFwRY7ZwjGty1oRjkzO8ugwO1oHnLk2Y=
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr8459889edb.314.1631824463389;
 Thu, 16 Sep 2021 13:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKjpqyJZGQh0BruPiny5X=hv3iqsfzj+FJwmdzXdWm-ThzgQhA@mail.gmail.com>
 <CAMKF1soE_CY13wubo7mqyTUKpVqXipqOCsoXhEjeiw-AqDAcsg@mail.gmail.com> <16A56782DEC68495.13685@lists.openembedded.org>
In-Reply-To: <16A56782DEC68495.13685@lists.openembedded.org>
From: "Andrea Adami" <andrea.adami@gmail.com>
Date: Thu, 16 Sep 2021 22:34:12 +0200
Message-ID: <CAAQYJAv-mi9veLTXqqaMFMZxqWKAaH07bxciXDGMCxkOTMjYoQ@mail.gmail.com>
Subject: Re: [Openembedded-architecture] Disable bbappend file from another meta layer
To: Andrea Adami <andrea.adami@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>, Mayank Agarwal <mayank77fromindia@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 16, 2021 at 10:30 PM Andrea Adami via
lists.openembedded.org <andrea.adami=gmail.com@lists.openembedded.org>
wrote:
>
> On Thu, Sep 16, 2021 at 7:28 PM Khem Raj <raj.khem@gmail.com> wrote:
> >
> > On Thu, Sep 16, 2021 at 9:45 AM Mayank Agarwal
> > <mayank77fromindia@gmail.com> wrote:
> > >
> > > Dear Experts,
> > >
> > > Is there any way we can disable bbappend file from another meta-layer in the current
> > > meta-layer or recipe file.It will be of great help.If we can use PNBLACKLIST or BBMASK
> > > to disable bbappend file.
> > >
> >
> > bbappends can not be undone sadly, maybe you can try some BBMASKing it
> > if its in unique location perhaps.
> >
>
> See here one example:
> https://github.com/vu-plus/meta-vuplus/blob/master/conf/layer.conf#L4
> vs one allowing them
> https://git.openembedded.org/meta-handheld/tree/conf/layer.conf#n8
> cheers
> A.A.
>

but maybe I misread 'in another meta-layer' out of your control. sorry...
A.A.
> > > Regards
> > > Mayank
> > >
> > >
> > >
> >
> >
> >
>
> 
>
