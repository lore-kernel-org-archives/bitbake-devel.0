Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E5E9A04E
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 16:39:55 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17987.1771519186413928441
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Feb 2026 08:39:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FChVFtya;
 spf=pass (domain: gmail.com, ip: 209.85.128.181, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-794719afcd4so11458457b3.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 08:39:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771519185; cv=none;
        d=google.com; s=arc-20240605;
        b=dJUy57XM2RI51GltQlLrjAGHvEOMBE5+JOu+UxmHElhgrv1q/fJX8tDwLoYGkRfPnE
         tb01Hqe6C2D/NJUbdRiWbu7N/bIe4FUtnkh+B3WF9BHVc8SXVJgd2R7yPROpC9Ojo/7D
         iyICKznReCDY5VQ1tRO7O/QJvRBNk2g4Ugjo0vMbFPl9ZBplyC1K7JPXMtB1DQn3gZJN
         +1AqPURziAD/kZ4GWIaXEVqrcDSUndyhuEI3zbx2zAZiDrdMMX45slmBnaJ/t4gNC7Ki
         8KfCTb45CtdTkwiIVZbgN3LXiFdPmAzRRyW2HTIM2sL+ZpEaMk03oS397dDQERXIZnF3
         yeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9CGDO/E9IRmjnUMYKROUMvMKltmu7BrZBtukNmUci9I=;
        fh=kwhZ3Li+yPVxdlH3ayfQoAuPa3/pJuSlz2Co5M6h6T8=;
        b=WlyGinf5JUM4Mo90dtEFXHO1v76ANW5X/fv2CnGvenbFSSzfNQlssT+EMX3k14ueOU
         Vo99xBUlj7QoGGnla72CFPI/yU61WCKop0Qmgcoc37iGhj4c/gW8nnKqfLcAknqS7LC4
         LDkoJO5iME0kyzNPJowfy5BbbU64pe1UoxhZVjql3w9JGhE3104MGqYJLe3HduxSyC3k
         GCx+H3sq/xp1JkJLOpWhk5bMeMLe5Gbn9PVq4ZD5SLChHLwp9vLYe5XOwPdtCaYbwmyA
         BW62rhQYLuK/PVJxGZMXqn00gq8Qw9D+ZDV2bMA3rLxtU+/87/L9CDeoHPlKWz4pn63R
         agRQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771519185; x=1772123985; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CGDO/E9IRmjnUMYKROUMvMKltmu7BrZBtukNmUci9I=;
        b=FChVFtyaK4gVA+YHgoiNeBUcxd9k/mnbBQ+4lrvGqJ4k+Scamqr/Fw47oMFkASdpOD
         DkfeNnUeBi3DWY6cCExba+YJQBMcJNwD6869jFw/98g2UCynQAsDV5m4hZAGutcK+B8k
         nE/TiSl3Q6CK+8O9Oxs5NzUgYy0s3ao5ZvNpG+xzmFDvnBhzZEIlKvy0bTebE8s1JMIA
         p9q07RQHu0PzM5GdhtSnSK8muD9ym/xeLncV2Pshfbsi/MOKJoW3EDOXlGXXL/WOEa/B
         hNUWhiqp2zqM+MeQIsuN+iiSSG5W6w9V0lDJJd/y2FClA+DR+1DsPj1kAV4s9qAu4GH7
         E0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771519185; x=1772123985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CGDO/E9IRmjnUMYKROUMvMKltmu7BrZBtukNmUci9I=;
        b=HPibkWq9xeH819L6byyyDKkKKNGAdWB4+5fP4yCspBQS6P2Qt98HLM+eVGUq9NdXEo
         +d4t3sT0aM+DNH7donSv1yeM60RqN7VY4dYed7l3+mUgjGcFG5Q5jgupDX0CEUaZa1WG
         Adi2foLc8oj1+pOwjNyeVyass1NvnX1cm3RiwzFGpfIpbS99Sv0EyYHvMctP+KV8G2A1
         oae2kbns9EBD92hWJacX00TxI1Yqg9fVcodz1vpb83se/xHXrSqafrzpi+c60Su22hSt
         qhhiQMSxbdAgDhnL/H+5rCEvw4Y1rNjFFft28UwcAAP/cNHXBgYHlcdAYTeJOfwsLdU+
         Xxtw==
X-Gm-Message-State: AOJu0YyeZqEDIOEMOJDPT3jy5msMLW7PyB2jMFqDffPOguaamySR6M8g
	eQXeGuNRIBS58sRxdvDt29+O4vLZcmbvKnmsYrCkPENMoGGhJnfChAjOrMPpvSIZIfS4R1aKiUW
	fE2WmNbnZkpJ2E6NwH5J3cM5jbh6606t5Fw==
X-Gm-Gg: AZuq6aJArHzrc9pPfwuIHo4xzADKwXHK3RyWXfeNJsIKz9DUF+geTokdYMcOKLqGcXP
	Cs5IBMWrm1EGhlngS4Hx+f2p/4OmDDjIzDmGxv5NMx53vT4DCxYHuuEnOQwrgHFiv5x0l+FzYo1
	MbyhlqjHtqU+eJF3QMwKZOngeQkfAYTwrz05r2DDuz6ljC40k7KeqgxdhuZcBkoFYsSC74uiLf7
	zqfR8uAt9qhan0n92mC5uxoBZLR0MOacChv6h0NQ6YVsDOa4OObG4PF7l1n6thMMAqkqZZ1ey2a
	85LOgEz2+U0+yYM2Uz5P/Q==
X-Received: by 2002:a05:690c:c50a:b0:797:d286:2cd with SMTP id
 00721157ae682-797d2860e9bmr108598767b3.18.1771519185326; Thu, 19 Feb 2026
 08:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20251030141904.69494-1-JPEWhacker@gmail.com> <20251219223620.2222861-1-JPEWhacker@gmail.com>
 <eeda7effdc1bda1ac5422ac7cc8095d46021a578.camel@linuxfoundation.org>
In-Reply-To: <eeda7effdc1bda1ac5422ac7cc8095d46021a578.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 19 Feb 2026 09:39:33 -0700
X-Gm-Features: AaiRm51duoC8qKgNqJuiDtQ9LYBAi5sUH7mYe2evACfBXqsEpsQjOXa3Ig4yVX4
Message-ID: <CAJdd5GbPdL4Ah3d65Uqap4An8MqrY=KiEsdhgk3gR77q=HYFyQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] cookerdata: Include "originating"
 recipe name when parsing
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 16:39:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19071

On Thu, Feb 19, 2026 at 9:32=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Fri, 2025-12-19 at 15:36 -0700, Joshua Watt via lists.openembedded.org=
 wrote:
> > When a bbappend file is parsed, the FILE variable is set to the name of
> > the actual file being parsed (e.g. the name of the bbappend). Since
> > PN/PV etc. are derived from FILE, this means that they can be
> > misleading in the event that bbappend is using wildcards (e.g. PV might
> > have the value of "%" instead of the actual version number).
> >
> > In order to allow bbappends to derived the actual information of the
> > recipe, capture the name of the original recipe being parsed as
> > ORIG_FILE when parsing a new recipe.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  lib/bb/cookerdata.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > index 22ac95eac..fe41bb3bf 100644
> > --- a/lib/bb/cookerdata.py
> > +++ b/lib/bb/cookerdata.py
> > @@ -512,6 +512,8 @@ class CookerDataBuilder(object):
> >          bb_data.setVar("__BBMULTICONFIG", mc)
> >          bb_data.setVar("FILE_LAYERNAME", layername)
> >
> > +        bb_data.setVar("ORIG_FILE", bbfile)
> > +
> >          bbfile_loc =3D os.path.abspath(os.path.dirname(bbfile))
> >          bb.parse.cached_mtime_noerror(bbfile_loc)
>
> We discussed this a bit on the review call today, I appreciate Joshua
> wasn't there but it made sense to try and unblock this.
>
> In brief, the concerns mentioned were:
>
> * no tests/docs

A test should be pretty easy to do, I'll see if I can write one up; I
can try to write some docs also.

> * not wanting to encourage wide use of this
>   (conflicting with the above)
> * whether the name is right
>
> The idea of using a __ prefix for the variable was mentioned. That
> would allow Joshua to address the issues he has but not make it
> 'official' recommended API. That might be the compromise we need.
>
> For the name itself, I'm really torn. For variables which bitbake
> itself responds to, I've tried to standardise on a BB_ prefix. This is
> more a variable bitbake exposes for use elsewhere and we have the FILE_
> prefix already being used but I'm torn on whether we should continue
> that theme or use something with BB_...

BB_ORIG_FILE then? I'd probably avoid the __BB prefix since that is
reserved for variables which bitbake used internally (only).

Alternatively, if we want to set a new convention of "hidden"
variables, we could perhaps to do something like "bb_ORIG_FILE", but
that is kinda hard on the eyes :)

>
> Cheers,
>
> Richard
>
>
>
>
>
>
>
>
>

