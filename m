Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B627BC19F2A
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 14:03:55 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.5995.1660140231226905285
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 07:03:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OnTEBXvj;
 spf=pass (domain: gmail.com, ip: 209.85.208.54,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id b96so19301421edf.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6UD8Ltm/+snGonNGY5vrNYIuzGOwXBj8DZlosrdq2Rk=;
        b=OnTEBXvjSw8SkE5bpeiZ+YZ5o01TtwH1JMOUScfJp78/5glq/s3hXDTJHvjRSVDwwv
         UWuBgwSmJ5+thoXsJrZ5DN51mai9Qn0vmWvg3Dhsd15k+mskhKX+1G26BQDyEEYMWSfH
         939H/QUYdk/uZ9izXT88IuDwkymjZBkmhp9Pt52YOXErR9KRF5AmpTztNdKz0uSDibzk
         hmYZC/3wFCNTVnLDhXxr8UPjtIi+8no5NFMiKudGuRql+fM1Mky3BoLCgdYWnivJbVB+
         8XHnPKOdf7oG4/HrobpN7O6UlvAuBg12V2gvWrH8zU7RKwDc5KLP35qHaL1gXrwb4SvG
         ccKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6UD8Ltm/+snGonNGY5vrNYIuzGOwXBj8DZlosrdq2Rk=;
        b=yFPhdyV2wf7Wf3m37rHZWpu8P1Fz3RoBpbIE74pih7Jj1kSW8MSA/CTr7e2mMcRuMn
         yLBVzhJzBboIcGhh0qtnnAmCWNL83wv/23K7Mf++K99Uem8A5PG6BONMkTCoZ9RUe6P9
         iTBebP7zEmCBmPL6lAD0Ul6CIpQmnLfIJ4ycqA9HrYutVbZZU3PSk/2SzJtGLgure9VZ
         RZuwAbeJWfCILfMHryRemO3hL+HD3TTY3/p7XhO22ehmsy3C8GsBjAeb0RkQUliMQtau
         x14tcbjUCS01V11Dj2++kwncmmiYwN00YVGfLuVvDe7FdNyuQQ1S1aHXd8hV8Qp0FFQc
         wAVQ==
X-Gm-Message-State: ACgBeo3ROZJ1caK5VAsOdiS/tykHv8cvXMXLFfUHKM8qzhQ//xEcZl+j
	ZX519oJrEFrUj+MVI98bwr8zMdtPSx+I3rUsZJY=
X-Google-Smtp-Source: 
 AA6agR48seeE/vVH3oaQM+u1Wrh44EeX2H5VoXXQRZ1DsrLjhroLlygdeSCsJ/sttwQQmJBvEm+0dNOA4aj1yiVmFuw=
X-Received: by 2002:aa7:dc17:0:b0:441:e5fc:7f91 with SMTP id
 b23-20020aa7dc17000000b00441e5fc7f91mr6019279edu.301.1660140229582; Wed, 10
 Aug 2022 07:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220803140441.1196056-1-JPEWhacker@gmail.com>
 <20220804112648.71c80544@booty>
 <CAJdd5GZRRUOf3ZMSQQnxOgU0oxqW2-ty5P0QKbAKTEitD7HnfA@mail.gmail.com>
 <CAOSpxda8h1Wzc6odfQxqn4EUJzgY7Os-sWi9wynk2GKiuKNVpA@mail.gmail.com>
In-Reply-To: 
 <CAOSpxda8h1Wzc6odfQxqn4EUJzgY7Os-sWi9wynk2GKiuKNVpA@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 10 Aug 2022 09:03:38 -0500
Message-ID: 
 <CAJdd5GZ+O2jepST0K8ACe9GWt-8XUysbMnGe+nC_doTo=DU75Q@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] siggen: Fix insufficent entropy in sigtask
 file names
To: Steve Sakoman <steve@sakoman.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 bitbake-devel@lists.openembedded.org,
	rasmus.villemoes@prevas.dk
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 14:03:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13883

On Tue, Aug 9, 2022 at 4:48 PM Steve Sakoman <steve@sakoman.com> wrote:
>
> On Tue, Aug 9, 2022 at 11:44 AM Joshua Watt <jpewhacker@gmail.com> wrote:
> >
> > On Thu, Aug 4, 2022 at 4:26 AM Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> > >
> > > Hi Joshua,
> > >
> > > On Wed,  3 Aug 2022 09:04:41 -0500
> > > "Joshua Watt" <JPEWhacker@gmail.com> wrote:
> > >
> > > > Signature generation uses mkstemp() to get a file descriptor to a unique
> > > > file and then write the signature into it. However, the unique file name
> > > > generation in glibc is based on the system timestamp, which means that
> > > > with highly parallel builds it is more likely than one might expect
> > > > expected that a conflict will occur between two different builder nodes.
> > >
> > > s/expect expected/expect/
> > >
> > > Taken in my testing branch with the above fix.
> >
> > Steve, can you please backport this to kirkstone and dunfell? There
> > may be a context failure backporting it to dunfell, let me know if you
> > want me to send a new patch with the correct context.
>
> Yes! I'll probably get to that tomorrow after I finish up testing for
> the 4.0.3 release.  I'll let you know if I run into any issues I'm not
> confident about resolving.

That's fine. I also just realized this relies on Python 3.6
functionality, so hold off on backporting it to dunfell for the time
being; Hardknott should be OK still

>
> Steve

