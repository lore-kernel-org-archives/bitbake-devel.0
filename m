Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CA9CF9C69
	for <webhook@archiver.kernel.org>; Sun, 22 Sep 2024 09:28:14 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.12126.1726997292663641435
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Sep 2024 02:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=InEHsuw0;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365aa568ceso3913097e87.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Sep 2024 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726997291; x=1727602091; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a06L+hQyn+eJLBljCS7EQrWMQEjUbJ37pEYF47iV29M=;
        b=InEHsuw0qrxXD398RdSchROdKC2tqQvqweEqCctVtxZ93L6FpobcByi4V9R2p58mmf
         Cp857fah546dIhFLdyp8GN2XJMuzgaf1bSt/YUQ2sekFwulnNpz8OFn3v0RZsRPWrcGy
         4/b5PPfkx2E9FX7lmWQAA762Xl4mCxxZ4qbL7b6DUt82D1Nm00xFV9ULfRrvo/10KG5X
         fT9hKZXJQzfkUFhpkBjmNK7FsGX6qPH8HddlYun7MDmYsepJQEeKsLZHcBe5YxJYMBFU
         N5uPGpIQG3nmUDdTwykehRNlvtlJ0kuL5eA52VAdK8reSyYdYzyWnlBP4qkql5V7aPl7
         gW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726997291; x=1727602091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a06L+hQyn+eJLBljCS7EQrWMQEjUbJ37pEYF47iV29M=;
        b=uQlDAzSvJHdTXxvSr8145vFfOlC+m/7zMgOn0ilsV6mme9G/4Gm8cDJXwHQFEkMdYL
         hXA2RchKum7VFnNtSTjHu9tyzbV16rzF/aW6GFn9NjGKajtG5vGE1XEfhwDpTR+AWvUd
         IVDXb38bcih+5kKPNS2JWcGyW3mikuNVGTBynOYCKzA2AnDqWQx23uFARqg0TMUsb563
         tH+mb2rGHjbl6jPajqVI4jFHv+GBx/PMhkpS1wHit43gmbCwojSmPYhOX1j8HeM/lteC
         cKzNaxtQtTrdgJw7pn1SUiszGv88SpxB3VBHkKrBLJJaAbS0UcO5dDn5JpA0FOaN4f8p
         7ZEg==
X-Forwarded-Encrypted: i=1; AJvYcCW8UFoUoiaNDqqsoIyfENqclXOtzfjRqaygJXtRTVyqeppaP6lHh2vSElL0p8GUds7sFvWFqOLajAduV4cM@lists.openembedded.org
X-Gm-Message-State: AOJu0YzSa0AIUwhknbqpkopdGReP0S2rJ5T3CToCIyBL7ZShXQ8AQDiJ
	a/uclI1509DBKnJi6SsOvkLy9udoHRXcLfq/I9g9LwR3DvyK/lx9iGRMfu1hSAEQaXjdhMw9ERM
	uDQS24NRbO1ZYS1cq7G3RmGuQ5UU=
X-Google-Smtp-Source: AGHT+IH5kRq10VkW7lUXQfZ3d42bTd/DLwP2pPgJRnrrUdq0rFwFkY4UOqj72gfjC+IXHUZs8gEHGjzUt5OyXpBKx8E=
X-Received: by 2002:a05:6512:1114:b0:536:a5ee:bb75 with SMTP id
 2adb3069b0e04-536ac2e8300mr5157358e87.21.1726997290417; Sun, 22 Sep 2024
 02:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org> <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
In-Reply-To: <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sun, 22 Sep 2024 11:27:58 +0200
Message-ID: <CA+chaQe3DCAxuvORYFrn4sr+0pUyrPR+oLrXkjor56+7XVaraw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax warning
To: kweihmann@outlook.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 Sep 2024 09:28:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16585

What about using precompiled re only in cases where the old "in" is
triggered already?

On Sun, Sep 22, 2024 at 10:48=E2=80=AFAM Konrad Weihmann via
lists.openembedded.org <kweihmann=3Doutlook.com@lists.openembedded.org>
wrote:
>
>
> On 22.09.24 00:15, Richard Purdie wrote:
> > On Sat, 2024-09-21 at 22:43 +0200, Konrad Weihmann wrote:
> >> Richard, this is in my opinion wrong.
> >
> > Noted.
> >
> >> It's preventing, for no reason, valid tasks.
> >> I agree that it's an expensive operation (potentially requiring to
> >> making it precompiled), but I honestly don't follow your take that
> >> this will be of any significance when taking a full (ordinary) build
> >> into account - the penalty of the operation is in a millisecond range
> >> while a typical task/image build is more considered within a minute
> >> range.
> >> If that "penalty" is unacceptable I at least would expect the
> >> documentation to explicitly name this limitation (currently I don't
> >> see that anywhere).
> >
> > The penalty I worry about is against parse time. That *is* a serious
> > concern for usability. Lots of small changes like this mount up. I
> > happen to know (as someone who as done a lot of performance and
> > profiling work against bitbake) that setVar is on the hot path.
> >
> >> So either way we would require a change, it's just unclear to me
> >> what's the consensus in the community.
> >
> > No, we don't *require* a change. You're asking for a change, I'm saying
> > I don't think it is good for the performance penalty vs the gain.
> >
> >> My take would be to prefer precision over performance - not sure how
> >> others think about it.
> >>
> >> Side note: the original patch never got any selftests, which just
> >> kept hiding the problem IMO
> >
> > FWIW nothing is requiring you to have tasks named like that.
>
> I find it troublesome that a generic build system doesn't mention that
> as reserved keyword/pattern - esp as the printed hint isn't exactly
> helpful (tbh I was scratching my head for a minute to see the "old"
> override syntax in the example)
>
> I agree (also as I believe setVar is fired million of times throughout
> an ordinary build) about the performance penalty.
> But what about removing this code path entirely and letting those vars
> to be set in the data smart?
> And then probe for variables having one of those pattern for instance
> close to the finalization (which I believe should give a overall
> performance gain) (line info can still be gathered from varhistory if
> needed).
> Would that be a way forward?
>
> Or one can even think about moving that stuff into a sanity check,
> instead of erroring out that early here (and potentially often).
>
> >
> > Cheers,
> >
> > Richard
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16584): https://lists.openembedded.org/g/bitbake-deve=
l/message/16584
> Mute This Topic: https://lists.openembedded.org/mt/108574686/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [martin=
.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

