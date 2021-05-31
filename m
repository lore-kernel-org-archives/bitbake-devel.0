Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web11.45067.1622472360398799380
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 May 2021 07:46:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=okiULPll;
 spf=pass (domain: konsulko.com, ip: 209.85.161.51, mailfrom: paul.barker@konsulko.com)
Received: by mail-oo1-f51.google.com with SMTP id w20-20020a4a35540000b02902458551c0d6so1010979oog.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 31 May 2021 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j8eGsIGy1fv6KwRrqLo9l8d6PXrbVDZMLlSsh0kqoEM=;
        b=okiULPllgjQMl+W22tt+LK2DKfzJKv6lLt5ZjK08efE0jrFNxDreDfma3Irwo97M1N
         pzpPk6204KdtPJChTrB2GumocDIYTHH+MArMZkXpI5n/2ZJyCraRM4HCYWveT5qeMhQA
         PgLWjWcVebMhWfKCtqDwaUY6D23pUNuwCMC14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j8eGsIGy1fv6KwRrqLo9l8d6PXrbVDZMLlSsh0kqoEM=;
        b=bZbI9uVDAcMOIp2WULDhX1/qUuNS/zgM8MTnb2UE4WLW4+C8WwhDZFs6z0GBpjTgKJ
         VnZt1iQPqFRJUQRfB4/tUlgabMJrl054zANjMexyuQDnlSxFNo6Vh80t4HENC4T4wrGC
         oFz1s2I/7AS2ccwTNh1aqB1CgN07eq4+gCx8MVO7Cd6nIIAHQez7mR1Dweh83tib/OPo
         pp+L46jlv/ajaIMxNs7W3BsxwP1KTkJGe+BshZokQg8+aGWeEp02XR1+R34XBSOgcAqm
         VzOkwPTnr5vQLtfqBL5N2aiC/QUtQBTxEforpkY0TuSq6MlqZDqHMUubRgxdN+hvpVFl
         BSGw==
X-Gm-Message-State: AOAM533yWfOnSNyGou89Bzj03PvZgh3M3vFsrfHZkPCLatCSR76uFoww
	/vjkHJWgXPZH80s2TQSRA+Yj/Lk2RiDiElFqaJlzvQ==
X-Google-Smtp-Source: ABdhPJyq/YZ80sTnn45LIZ+RhuOq8F/+PeqTq5WVVf+xStU6vctzRZzXz42b2162c1gZRaKPCvzTUWMClB1NXLxxxzA=
X-Received: by 2002:a4a:3f53:: with SMTP id x19mr16847693ooe.88.1622472359746;
 Mon, 31 May 2021 07:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210528084209.8408-1-pbarker@konsulko.com> <b258e09be64468dcdf685cb9f7f26a011cb7f2af.camel@linuxfoundation.org>
In-Reply-To: <b258e09be64468dcdf685cb9f7f26a011cb7f2af.camel@linuxfoundation.org>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Mon, 31 May 2021 15:45:49 +0100
Message-ID: <CAM9ZRVuYgsQXPSYRR8ZJYQJsPKGpQGU8P2O_VMcFK6q=rdt8NA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Re-implement prserv on top of asyncrpc
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>, 
	swat <swat@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 31 May 2021 at 12:25, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> Hi Paul,
>
> On Fri, 2021-05-28 at 09:42 +0100, Paul Barker wrote:
> > These changes replace the old XML-based RPC system in prserv with the
> > new asyncrpc implementation originally used by hashserv. A couple of
> > improvments are required in asyncrpc to support this.
> >
> > I finally stumbled across the issue which led to the hanging builds
> > seen on the autobuilder when testing the initial RFC series.
> > It was a fairly dumb mistake on my behalf and I'm not sure how it
> > didn't trigger in my initial testing! The
> > `PRServerClient.handle_export()` function was missing a call to
> > `self.write_message()` so the client just ended up stuck waiting for a
> > response that was never to come. This issue is fixed here.
> >
> > I've ran these changes through both `bitbake-selftest` and
> > `oe-selftest -a` and all looks good on my end. A couple of failures
> > were seen in oe-selftest but these are related to my host system
> > configuration (socat not installed, firewall blocking ports, etc) so
> > I'm fairly confident they aren't caused by this patch series.
>
> Thanks for these. Unfortunately I think there is still a gremlin somewher=
e
> as this was included in an autobuilder test build that is showing as this=
:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2203
>
> i.e. all four selftests have not finished and I'd have expected them to
> by now.

(=E2=95=AF=C2=B0=E2=96=A1=C2=B0=EF=BC=89=E2=95=AF=EF=B8=B5 =E2=94=BB=E2=94=
=81=E2=94=BB

>
> I'm trying not to work today so I haven't debugged them or confirmed wher=
e
> they are hanging but it seems likely related.

If you're planning to take the day off don't worry about investigating
these. I'll take a look at the patches again on Wednesday. I think the
best approach may be to add some timeouts and maybe more error
handling to the asyncrpc code I extracted from hashserv - if we can
turn these hangs into a proper error then we can reduce the amount of
autobuilder time they take to test and hopefully we'll get a better
insight into what is actually going wrong. My guess is that there's
something in the autobuilder config or just the level of load on the
machines which is aggravating this as the tests finish successfully on
my build machine (with a few expected test failures as noted
previously).

Thanks,

--=20
Paul Barker
Konsulko Group
