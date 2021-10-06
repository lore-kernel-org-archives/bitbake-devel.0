Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30866C433F5
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 19:54:08 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web08.1402.1633550047285772300
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 12:54:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=MeqpB5rG;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.222.181,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qk1-f181.google.com with SMTP id z40so2385389qko.7
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4OQ2b0hr5kupVvH8C77UJa99UYtutc45wpiGG1yff0=;
        b=MeqpB5rGuMpx1eJIcOXkwvZMBpNAGIOgUPGAePmX9atp6pJ4k5sP8YL60NmB8nH41g
         ql9XqGYaOFbqaY2mVK3txzODv50F7Ksfsox5bsOZVOBRiRbO8r0zJmQWwz/YMw4L2+oQ
         t8Ts/AHQDkgu3pvf1oekqXxJbkKRBAI/Pyuh7nsUxpuoLegg3KBMirjBC/7uzpA+YHk+
         us+cQoRrVT6/nSL7BMXtkmTa4Do3dSNAUIsJC0I58mMo4w6MmCCyKqhX1hUe5QFK9PbT
         I1BsaWwUmOp+zJgbF6JRUvjS9EqfY7Z6HOjizzU3CZ28k1TS2hp0iN3FQ0D9HOQFX66Q
         6yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4OQ2b0hr5kupVvH8C77UJa99UYtutc45wpiGG1yff0=;
        b=3BlVCfPRKoFP+p5sMxeED660oNSxJHiHQIG2se+jR1WGmavzO/gqSkgZiOkpDRkmP7
         G6klcb/nKCX6sw99zPojgjlkK9xeMtZPHjEXNS4JP/v/+Y4hhJ6hCIboahFT17n3VgQz
         +DFl3WQTwhzFe0RksmR89xFVYgBJ0ftJAjXgcA9mzB7Ui69goUISV4yEOnNrI4fzQWiw
         u4Fq/avsfPfVAeqT7v8YHdI3hqvKiuZLAFpMUQucY6T8t3ms17CGFZEIdLTzkch1Tmh1
         HhyuuvPixWUuQaEsfEuSufJT/B4znb8HSjnqV/jUVe3i5Ut/MOZzYDOwA1GlEHWVHXTR
         eskA==
X-Gm-Message-State: AOAM533XuiLwC9pY5y7dxhGyBG2Cx/M1T7cjv68NV44ZwNDdo49DcwTG
	5NuPBwhF/ERqm5XFjiSLeGMd1ZM2c1Q4dBzAZaFWgA==
X-Google-Smtp-Source: 
 ABdhPJzutrW3TKAUj8ZRhXZAXZsGlf882VXiN/CMNY4OZ1ykXoamvByKNMLowu4f8i6KJsdO19uw/wktpaz58fsjPig=
X-Received: by 2002:a37:b7c2:: with SMTP id h185mr19138qkf.311.1633550045610;
 Wed, 06 Oct 2021 12:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211005224513.14134-1-jdmason@kudzu.us>
 <35bcdc42-9ed6-5232-c94e-c69f3fd7af94@bootlin.com>
In-Reply-To: <35bcdc42-9ed6-5232-c94e-c69f3fd7af94@bootlin.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 6 Oct 2021 15:53:32 -0400
Message-ID: 
 <CAPoiz9xhmQ+dCEUibDV7_evNhLVb5i83LjU_uo3k1f_4Q3Y-fA@mail.gmail.com>
Subject: Re: [docs] [PATCH 1/2] documentation: update sources mirror URL
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Oct 2021 19:54:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12733

On Wed, Oct 6, 2021 at 10:41 AM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hi Jon
>
> Thanks for the proposed update !
>
> On 10/6/21 12:45 AM, Jon Mason wrote:
> > The URL for the sources mirror no longer works.  Update to the new
> > location.
> >
> > Signed-off-by: Jon Mason <jdmason@kudzu.us>
> > ---
> >  documentation/ref-manual/faq.rst       | 15 ++++++++-------
> >  documentation/ref-manual/variables.rst |  8 ++++----
> >  2 files changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
> > index d3a603d4a438..f06abc84ee6f 100644
> > --- a/documentation/ref-manual/faq.rst
> > +++ b/documentation/ref-manual/faq.rst
> > @@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
> >  ``local.conf`` configuration file::
> >
> >     PREMIRRORS:prepend = "\
> > -       git://.*/.* http://www.yoctoproject.org/sources/ \n \
> > -       ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
> > -       http://.*/.* http://www.yoctoproject.org/sources/ \n \
> > -       https://.*/.* http://www.yoctoproject.org/sources/ \n"
> > +       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > +       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > +       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > +       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
>
>
> Hey, doesn't it sound weird to show an example that proposes to use http
> when https is usually recommended?
> What about proposing https://downloads.yoctoproject.org/mirror/sources/
> instead?
>
> Or we don't really care because we use source checksums anyway?
>
> Just my two cents. I don't mind accepting the patch as is.

A quick and dirty grep of the trees shows many occurrences of
downloads.yoctoproject.org without https.  Perhaps it would be good to
correct all of these in a follow-on patch.  I can do a quick patch of
all of these and get that out in the next day or so.

Also, looking at documentation/profile-manual/usage.rst (where most of
the occurrences in the docs are), shouldn't we have a newer kernel
than 2.6.19.2 as an example?  I mean, it's almost 15 years old.

Thanks,
Jon

> Thanks again,
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

