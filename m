Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web12.34.1616013338976389961
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Mar 2021 13:35:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=kAtKAN78;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: raj.khem@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id r14so2456800qtt.7
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Mar 2021 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5w96zIq9rP/TNTJ3uZWmMcu35IxtW6wL+/TureGKY5Y=;
        b=kAtKAN78pUm5jXZcq98ErrALqoGK1DN++uszsi5vT14TqLY3dKtFqJ1Yhb+KCL4kwt
         McXIflSOJ5el0/cPdNwWN8JsNy5Lzi/mFt0ovgH+ls9SxcDAzacQ9gTZ8XenXF+fx5cw
         8m/+P19qfXuDpam9GBGlb4Ra65x6XO4lWQH9dyshTxrbH2TiiJnj1pNOtdz5MMPeY0M6
         t9ArUBw4t5AhPFsa8A0Hg+woOFWHfB1thGrU8SeT6Tnqip3QIvyXQg5aef28vFg0JWEC
         w1c5mxzCSj05pCiq7i8a+PuZTpLKxruEQ/M4Lwv25KGj9QCWycNpOgHrg6YW+1IT4wsT
         bmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5w96zIq9rP/TNTJ3uZWmMcu35IxtW6wL+/TureGKY5Y=;
        b=gJ4hT521YSv28mQr3WQc8Cdh+HAWtLEvnUfb0KD4kVrmjt2eN56aYjLgi9+m3pvYKW
         nIgU7vIF1d1JHrTo+rg53Lr7hhPj4mT8+vDtTzRtAVvRRjIpd+N6FzaFrzH0zwB/ALuy
         WV1DNV+6ipTQKMbIyjPyV+IjuKyMONXK4mvzLMS1lvuXRL3Ednn0vwzkMVvVKFa2ShT6
         nTzP8v+H4GpWHv1brqfAUGioN6AbL7a9wgR1P8FTfssFQvC4pXykr0weqBSBrB/i1HRe
         klk4xpXqp2JgSmjh/NglP3Sav8EjJXiDiTNAPi69pNDpTmwiOvl9HxGpI8hiw65Jf4m5
         kxLg==
X-Gm-Message-State: AOAM5311qKKyhCG8EzMVy7fkb+mgnSiBoYWmbp0pCB0cgmuBo4cGgwz2
	NetR6jFlyt50DiHA1Og19lyvLE8+JpDPruwMg1U=
X-Google-Smtp-Source: ABdhPJxQLvau3K2P6BV1I7JT+5v2WYc5Uw7w2G9abRsrvCpu5Xxe0bEOsb6HGfREmJKaKgMiL1y9bFaAGwMTIqPJ3qo=
X-Received: by 2002:ac8:5a46:: with SMTP id o6mr789809qta.289.1616013338008;
 Wed, 17 Mar 2021 13:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <9914cbb9-eb88-c215-4fec-185762583ed@crashcourse.ca>
 <CAMKF1so2rS8miJHs-V+DHV5SXLAMd=F1FizmnQ9GzuaTfQ4mKw@mail.gmail.com> <ff65454a-d7d5-7f28-e785-b3eb5b4f724@crashcourse.ca>
In-Reply-To: <ff65454a-d7d5-7f28-e785-b3eb5b4f724@crashcourse.ca>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Wed, 17 Mar 2021 13:35:12 -0700
Message-ID: <CAMKF1sqWmgCeJ4VcLFA=SPF_Tx3oB-z=YUetzsqzBBKyvzcDaw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc: Mention OE routine for setting BB_NUMBER_THREADS
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 17, 2021 at 8:56 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> On Wed, 17 Mar 2021, Khem Raj wrote:
>
> > On Wed, Mar 17, 2021 at 3:34 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > >
> > > Given the discussion of BB_NUMBER_THREADS, what it means and how to
> > > set it, it seems only fair to mention that it's probably already set.
> > >
> > > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > >
> > > ---
> > >
> > > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > > index d74e768f..a2003997 100644
> > > --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > > @@ -45,6 +45,13 @@ the BitBake command and its options, see ":ref:`The BitBake Command
> > >     A possibly simpler solution is that some Linux distributions (e.g.
> > >     Debian and Ubuntu) provide the ``ncpus`` command.
> > >
> > > +   If you're using a relatively recent version of Poky or Openembedded,
> >
> > I think it would be better to avoid distro names in generic documentation
>
> ... snip ...
>
>   normally, i'd agree, but given that 99.4237 per cent of bitbake
> usage is in the context of OE or YP, if you're going to tell people
> about BB_NUMBER_THREADS, it is not out of line to point out that they
> almost certainly have that value calculated for them automatically
> already.

OpenEmbedded is perhaps more appropriate here, since its the build
system and would tend to cover all
OE based distributions including poky

>
> rday
