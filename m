Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5BC433F5
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 00:48:20 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web09.5212.1633567699343875005
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 17:48:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=o38S2fcA;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.160.177,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qt1-f177.google.com with SMTP id r1so4572802qta.12
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 17:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txIRgEC/7VoT6tHJzuXWR3/P3iO0DiQK7jBMdjMsqU4=;
        b=o38S2fcAKs4RUkLj5zLJGdKePrfknejPYgrVgnMbQc1ui+e9TkWiMca8BDIY7WAm61
         VnbccMg+sTdXOLzrySkpoc/6IT+qvi4XnZszs0uZitE7xKCOSk6pNSB9KGrgj1btvdvI
         8ilAlPuGpkefVuKGSSnbjqhJTeoaGypa1FvULLFzBAY3luvMtysv1u5UkzGGBoPgTskL
         LhUoj4hUrG5H741U2jM8udV64rbtBUqDEEhOKd7U+291oPNzHbMP9sAxHs0xwyXm9lff
         B198F6g+lHmJFhJSFuV7YqUdhv009Jc48aNfJpHWytdlZkYUwh0VuDYXJ/X6CROD2RKc
         uJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txIRgEC/7VoT6tHJzuXWR3/P3iO0DiQK7jBMdjMsqU4=;
        b=xaM66Sf4HclH4tSg0ez9jh9enLwUsgyyLn1LgmsSVUOnFIaTfG7+PJdtnw1zPHRxW9
         v7BYq7ZdLdQRX+CESlFmfqP7Psiqn1Xm/mwDunG34JGVzUI932XjlLte1fIBSqMdu6k0
         ArVAj+pYNPIPaPPMU2qNDjd/Eduvx2eG9y2JE36KbI3BNGNL5HBx/G+NSWy3D2taTFQr
         dfzsYszDr16vxxSxF9ALtlLj3MRBb7svPtCXY/E94q/FYBx8BE3mlKNnFWRN+Ec4OQbY
         l7EmYJA1QbKnZGXRzAEG62ol4xcg09QAC5qi98+ULclhULGYvRfNxe+vfj0mG0JJUfmq
         OJGA==
X-Gm-Message-State: AOAM531I8X3YxLXEhPDimL004vgPC5clIHVw8jdnx920/cJeMU6+t4Qx
	q2z/TjHYLfO7eXdo9xJvAL7nA8WIZDr39+b88V6/NQ==
X-Google-Smtp-Source: 
 ABdhPJxY6eGXLcXMILrmDvDUzojbP7sF27gDawVOQhy3kwl92Yg1FVbVk3/ZQa50mCcTFi8ORlFu0j9COwi4Yh+Jq/Y=
X-Received: by 2002:ac8:5c0a:: with SMTP id i10mr1637557qti.23.1633567698381;
 Wed, 06 Oct 2021 17:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211005224513.14134-1-jdmason@kudzu.us>
 <35bcdc42-9ed6-5232-c94e-c69f3fd7af94@bootlin.com>
 <CAPoiz9xhmQ+dCEUibDV7_evNhLVb5i83LjU_uo3k1f_4Q3Y-fA@mail.gmail.com>
 <755f3e7bd1d40628a911b9c1d165785ad6d5a494.camel@linuxfoundation.org>
In-Reply-To: 
 <755f3e7bd1d40628a911b9c1d165785ad6d5a494.camel@linuxfoundation.org>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 6 Oct 2021 20:48:05 -0400
Message-ID: 
 <CAPoiz9wSdfgppgopSN7M9TZRRH21j+r8YEBgHdWKHKA-d0fryw@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] documentation: update sources
 mirror URL
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 00:48:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12735

On Wed, Oct 6, 2021 at 6:17 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2021-10-06 at 15:53 -0400, Jon Mason wrote:
> > On Wed, Oct 6, 2021 at 10:41 AM Michael Opdenacker
> > <michael.opdenacker@bootlin.com> wrote:
> > >
> > > Hi Jon
> > >
> > > Thanks for the proposed update !
> > >
> > > On 10/6/21 12:45 AM, Jon Mason wrote:
> > > > The URL for the sources mirror no longer works.  Update to the new
> > > > location.
> > > >
> > > > Signed-off-by: Jon Mason <jdmason@kudzu.us>
> > > > ---
> > > >  documentation/ref-manual/faq.rst       | 15 ++++++++-------
> > > >  documentation/ref-manual/variables.rst |  8 ++++----
> > > >  2 files changed, 12 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
> > > > index d3a603d4a438..f06abc84ee6f 100644
> > > > --- a/documentation/ref-manual/faq.rst
> > > > +++ b/documentation/ref-manual/faq.rst
> > > > @@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
> > > >  ``local.conf`` configuration file::
> > > >
> > > >     PREMIRRORS:prepend = "\
> > > > -       git://.*/.* http://www.yoctoproject.org/sources/ \n \
> > > > -       ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
> > > > -       http://.*/.* http://www.yoctoproject.org/sources/ \n \
> > > > -       https://.*/.* http://www.yoctoproject.org/sources/ \n"
> > > > +       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > > > +       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > > > +       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > > > +       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
> > >
> > >
> > > Hey, doesn't it sound weird to show an example that proposes to use http
> > > when https is usually recommended?
> > > What about proposing https://downloads.yoctoproject.org/mirror/sources/
> > > instead?
> > >
> > > Or we don't really care because we use source checksums anyway?
> > >
> > > Just my two cents. I don't mind accepting the patch as is.
> >
> > A quick and dirty grep of the trees shows many occurrences of
> > downloads.yoctoproject.org without https.  Perhaps it would be good to
> > correct all of these in a follow-on patch.  I can do a quick patch of
> > all of these and get that out in the next day or so.
> >
> > Also, looking at documentation/profile-manual/usage.rst (where most of
> > the occurrences in the docs are), shouldn't we have a newer kernel
> > than 2.6.19.2 as an example?  I mean, it's almost 15 years old.
>
> Careful, some of us remember working on the 2.6.19 kernel and have patches in it
> :)
>
> I don't think we've worried too much about http vs https for the downloads as
> they are checksumed but it is probably cleaner just to convert them.

It's a fool's errand, and I'm just the fool to do it.  Changes all
over the place, broken URLs, etc.  Patches coming shortly (as soon as
my sanity tests make sure I didn't break anything obvious).

Thanks,
Jon


>
> Cheers,
>
> Richard
>
>
>
>
>

