Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F322C369AB
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 12:07:43 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.18333.1744718862454847485
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Apr 2025 05:07:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gJipzoeQ;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54c090fc7adso4114509e87.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Apr 2025 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744718860; x=1745323660; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM9+9zg6WDU+B1m1x2KvL+94pqENdSwl2GbO58kj7ek=;
        b=gJipzoeQo2ci+MXaHaic4HVlp8lW8ZtgLaqU5xyjAhvuKsz4PT8/Az/sDsmk/lIS9s
         Z6goc8cQ9xUwLfXpK1lQVxZ8xYUz8GwHX1VpMdkrmaNH9FRcF0oyDaLHo7C0A/d5ihBN
         7VREODMefabO7MSSFT6LQrkBcPiZetBaMtiKhmZkwuafIEtMphce17hMO1zreHqU8Auv
         kZbnMEt2EKIlhr5bKU/Qssb4thc5Msy8fWJkRUY1YMdgnvDSj8jZJ6aEmyrZxTgdH6G3
         D0dGZZiGTMTm+sgz9O+VPlePFhBzg6gM77k9lYLG6lZ/twsTZWy5EttNW4x77N0ZXzNr
         0AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744718860; x=1745323660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM9+9zg6WDU+B1m1x2KvL+94pqENdSwl2GbO58kj7ek=;
        b=p00cRaD9uOb/dn5wES42ZtOMms5EUCl/8t3xrvEL4yb8KfsZQEaUbKwkAwxfDAap/q
         tv31uLzViSK0T9ZeUpwJC7LtfLBGniSPGqWUAbdJlZGM6x6KRlYxjx3/ctTWN7/N4z0z
         Rv/boTOgt+N1ZPizT9n8vr6309rOpdWnwve9I7hOy7K4M9eKTySLxnNHExeL3kWVKFmz
         05RNH9wJrpBDtMgveIL4V8gnSs/S0qWXryFj9ukDiSKuk3rpHiC9rIq7k9vpKXh+FzvA
         dLhduJYZtJ4gsoq5Pnp0eHkw4mF1nBLygKmXcMg+LDuNeAE0j2s7TSD7S6YmUKN1g92X
         /Rsw==
X-Gm-Message-State: AOJu0Yzx1ky5F9XrG/VxcSl26IFe8drBKMs71zOr13Q60H1WesR2efnI
	M9JqdXaXQGzQMz2Ij25LAxmau78EMQAFDuxdyO07I0XLKO+6AV7iN+P28rCFokeTFUWDXsfd+hM
	CcFd/1itK1KpcnvI2ybOljItw6bo=
X-Gm-Gg: ASbGncsa1b8FEu1xL4oIlMmAITBGKUgmrzC0/B3X5oTVXF7BFb/iPxrJ3S+/AYo1PCj
	jzRnCNdptNm1ogzYVyAtaLjWxDAblNQh3JjNVy2hTudAjPpUNqRvOYQ0nmK7yThtg5FrRpn3ZDw
	NylbzEgUL3wq0sSBGlYdVoIDVRINEC/0JeU/0=
X-Google-Smtp-Source: AGHT+IGHNkhGG1SuDxKvLc4/FCb5aZOMQEYjymWnVIllKPJVOfDg9WLhM90VQ5ZwPZx1f53rhDK1WzAnsEIgl13AIY8=
X-Received: by 2002:a05:6512:1318:b0:545:285f:cd7f with SMTP id
 2adb3069b0e04-54d45295932mr4858966e87.14.1744718860118; Tue, 15 Apr 2025
 05:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250411-bb-pressure-improvements-v1-0-7d9e3593167f@bootlin.com>
 <20250411-bb-pressure-improvements-v1-1-7d9e3593167f@bootlin.com>
 <CA+chaQeXK2pbaNWaYvDVzMhu=eZLpFLB9zeeaGDA7oLDJnaG3A@mail.gmail.com> <D976VXV65RT6.1ZHT2MCAP4QL1@bootlin.com>
In-Reply-To: <D976VXV65RT6.1ZHT2MCAP4QL1@bootlin.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 15 Apr 2025 14:07:28 +0200
X-Gm-Features: ATxdqUFuB9JlFCWtMT1Zag2sivcSrbzktXs1arS5j_fxFNxEIPq3s_0M0XdaNRs
Message-ID: <CA+chaQdNvTosunsyh1=_sQ0E1-u4FwPJ2=FtNsFTLyic1pvc9A@mail.gmail.com>
Subject: Re: [docs] [PATCH 1/2] runqueue: decrease the verbosity of pressure messages
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Apr 2025 12:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17531

On Tue, Apr 15, 2025 at 1:52=E2=80=AFPM Antonin Godard
<antonin.godard@bootlin.com> wrote:
>
> Hi Martin,
>
> On Fri Apr 11, 2025 at 9:09 PM CEST, Martin Jansa wrote:
> > On Fri, Apr 11, 2025 at 4:46=E2=80=AFPM Antonin Godard via
> > lists.yoctoproject.org
> > <antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
> >>
> >> By default all the pressure changes are printed on the console and
> >> generate a lot of spam to users using the BB_PRESSURE_* variables.
> >> Decrease the default verbosity to bb.debug (level 1, so can be seen wi=
th
> >> -D).
> >
> > Isn't "a lot of these messages" a proof that the BB_PRESSURE_*
> > variables aren't set correctly?
> >
> > I find them quite useful and using -D by default in my builds would
> > bring even "more spam". But in worse case I'll just revert this for my
> > builds.
>
> I see how these messages can be useful.
>
> To my understanding, having a low value for BB_PRESSURE_* variables will
> generate a lot of these messages. To me, it does not necessarily mean tha=
t the
> value isn't properly set, it just means that you want to limit the pressu=
re a
> lot.
>
> Maybe the default behavior of printing everything is good for adjustments=
, I
> just think it'd be convenient for user to have a way to disable those onc=
e they
> are happy with their pressure configuration.
>
> I thought first of a BB_PRESSURE_VERBOSE or BB_PRESSURE_QUIET variable. I=
t
> would just allow enabling/disabling these messages. But on second thought=
, I'm
> not sure an extra variable is necessary when we could just move these mes=
sages
> to debug messages. Other variables that limit the load do not generate su=
ch
> "spam" (take BB_LOADFACTOR_MAX for example).

I guess you're using the default knotty where I agree that these
messages from pressure are more annoying, because there isn't much
else printed by default.

Most of my builds are on jenkins or run with tee, so I get a lot of
messages about e.g. starting and stopping tasks and almost never
notice the few pressure messages between them (unless it's IMHO badly
configured and changes regulation after almost every task).

> What do you think?

Do what you want (and others agree with) and I'll deal with it for my
builds if needed (I might just disable pressure regulation as I don't
find it that useful as it cannot prevent OOMK anyway and the task
granularity doesn't prevent it from triggering multiple heavy and log
do_compile tasks at the same time while the pressure was still low and
it gets overloaded shortly after - still hoping that
https://github.com/ninja-build/ninja/pull/2506 will be merged one
day).

