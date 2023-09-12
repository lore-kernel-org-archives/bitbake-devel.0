Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9CDEE3F3F
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 22:02:02 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.330.1694556114752912285
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Sep 2023 15:01:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=enr5vblV;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so99408661fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694556113; x=1695160913; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIxH+XStqaTtPn+NGtrc7/APRgb1t2S8OaxvIXa9cp4=;
        b=enr5vblVpfNXQQfg5pmExH4db9/UrGWuBKS5xPT/VWxjntlUpkTLRIlLDXBTTB3uAv
         83uBobSli5IaDfJg62IfStuNk+Xzgz9wFPUIbDFsr7bNtkc4sK0dhANWluELsf0HF8xL
         IM85ZdCoRlcNZCIluK/AA1ahtjRYGjg9VYnJlhZBuSF65EjpRrjBXGtSVJzxPPqzc9Wt
         sROt9vFIScs0CV9zJSxlZ5T+FQJWU5I6H0FKyZ1ZpMegBNumyf8fWKQQsGwQSHJsNbkR
         87kfS8nI2w28dgxecWMBXA/aZB1lC0LO1z88uY24qLS6P258804jqc9q0UoG9D0+YU1n
         I/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694556113; x=1695160913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIxH+XStqaTtPn+NGtrc7/APRgb1t2S8OaxvIXa9cp4=;
        b=v/BMlrZZq5as9CO4WgbPmmENDtquWW/zTm1LQ8tquqsn3WFjUe4g59GNCIIp0AnLA0
         cnz5uw6lnf97gTCyU+tY3hJy/jNjjjWEXrxWpGXbg/+W4FQe8sKA+aV10pJIQSholXH8
         6XGzdj1+lBv696dumHRsM9Jd4ScaZmMmp39oPUTSm2K5wQmCwKUR8bwUgGbvn/E4bmjf
         Ovsuuq38VWT1rnuqJVO53ST7n8lBSZZQxvcL96KiaV/33jTQsbByVeV4k0DUc4hI3bvH
         p2YnvBTsdNClqGckxPvNhuyiY0LF9qHYSppb591Yb96okS1Zqn2QdKHnFDPfC2T6bPMv
         1hiQ==
X-Gm-Message-State: AOJu0YycGJ/xnrbLm6K3J5J5k6GmMvz+bJ+BhPL9n7IPfhM4Ds6jADpP
	9BOtaZ5ANMY7kidhNCkUn0u1ISRF1HYyQG4XrjM=
X-Google-Smtp-Source: AGHT+IEFAEJwgEeKo3sIguEeSpezXtA+bdiE1kCHQFr1GFfT7fnlHiKa40EndKODwAGL7NAVZP4SFcAe7DA1hdFDUlk=
X-Received: by 2002:a2e:9057:0:b0:2b6:d790:d1a3 with SMTP id
 n23-20020a2e9057000000b002b6d790d1a3mr719529ljg.11.1694556112697; Tue, 12 Sep
 2023 15:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu> <CAJdd5Gb5wn7GG-1T_5CYjyESdBXU1RGghVYkAtAwF_GNBpnayg@mail.gmail.com>
 <9924500659de9ef4cf2b0c6e127fa27a@pianon.eu>
In-Reply-To: <9924500659de9ef4cf2b0c6e127fa27a@pianon.eu>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 12 Sep 2023 16:01:40 -0600
Message-ID: <CAJdd5Gbuc-ivs0LRTTefAoxp4QxLU7r4W3pD74sM+d73VBbpDA@mail.gmail.com>
Subject: Re: [bitbake-devel] initial idea for hooks needed for source tracing
To: Alberto Pianon <alberto@pianon.eu>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Bitbake Devel <bitbake-devel@lists.openembedded.org>, Carlo Piana <carlo@piana.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 22:02:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15038

On Tue, Sep 12, 2023 at 3:26=E2=80=AFPM Alberto Pianon <alberto@pianon.eu> =
wrote:
>
> On 2023-09-12 23:05, Joshua Watt wrote:
> > On Tue, Sep 12, 2023 at 2:55=E2=80=AFPM Alberto Pianon <alberto@pianon.=
eu>
> > wrote:
> >>
> >> Hi Richard,
> >>
> >> as I said at today's meeting there is no hurry, but right after the
> >> meeting I had an idea and I wanted to fix it in my mind and test it
> >> before losing it :)
> >>
> >> It's just a temporary/WIP patch, but it should not be too far from a
> >> working implementation of the hooks we were talking about:
> >>
> >> http://cgit.openembedded.org/bitbake-contrib/commit/?h=3Dalpianon/srct=
race4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8
> >>
> >> There is no interference nor modification to the unpack process any
> >> more, just collection of needed metadata through the urldata object.
> >> Modifications to the core unpack function are minimal and (I hope!)
> >> straightforward, and there is no fetcher-specific logic in it ant
> >> more.
> >>
> >> When you find some time, could you please have a look and tell me if
> >> this may be the right direction?
> >
> > I think this is much better; there's still a few rough edges
> > (`function.__name__ =3D=3D "unpack_submodules"` is kinda gross :),
>
>
> I know :) but I couldn't figure out something better off the top of my
> head...
>
> The thing is that "function" is passed to process_submodules:
> http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.py?=
h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n43
>
> and it's executed for each submodule:
> http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.py?=
h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n152
>
> I want to collect some metadata only when that "function" is
> "unpack_submodules" and not some other function.
>
> May you suggest a better way to do it? Maybe with inspect?
>
>
> > but this is much simpler and I think easier to understand.
>
> Thanks!
>
> > Also, I feel
> > like this is actually reasonably testable; presumably there would be
> > some mechanism to "plug" a different Trace class in instead of the
> > pre-canned one, and tests could be written that use a special test
> > implementation of that class to verify that it is being called
> > correctly. This also means your special source tracing classes can
> > live elsewhere instead of needing to be integrated into bitbake
> > immediately
>
> Yes, that was the idea. Maybe a variable where to store the module to
> load, like SRCTRACE_PYMODULE =3D "mybb.fetch2.trace"?
> And something like SRCTRACE_PYTEST =3D "mybb.tests.trace" for
> bitbake-selftest?

Ya (assuming you meant SRCTRACE_PYMODULE in both places). You might
even be able to combine the ENABLE and PYMODULE (or maybe CLASS?) into
the same function. If the variable is empty do nothing, otherwise load
the class. I'm pretty sure we've done that elsewhere in the
codebase.... see siggen.py in bitbake where it loads a module using
import_module. IDK if you'll run into trouble with the import path
doing that or not.




>

