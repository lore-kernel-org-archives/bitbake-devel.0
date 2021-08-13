Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.39113.1628872910378040667
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Aug 2021 09:41:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=H4hTTFws;
 spf=pass (domain: burtonini.com, ip: 209.85.221.46, mailfrom: ross@burtonini.com)
Received: by mail-wr1-f46.google.com with SMTP id b13so14126316wrs.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Aug 2021 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3T4unwBN6DAss/vXa/xJmAOTD2m7ZDx+eMxXRo4e0Fg=;
        b=H4hTTFwsP8toYwP39HUHscK0k6efCxn1IRFhAD67w8C/FMCxASA9rzY2ljdEX82w1Z
         InTA8z0weArkqyBMjovM/KX7kXiPRfMoCLOt/ca8HDi7K19GTqmbsS0ZZ9jphlzVhIz1
         0jxG7rm54TznViyjGLZbqI6AmK474dWErFUK4iZoOhTPq0dtPv2RpJowBOtcT8RS5WH1
         P9OUNq6PdhPtBXm+nGn+jJep1TJKZiBXmPxP5gpTVlciobdiIkp2F16r+j2gnjnVmw3P
         LD8EE0y1/0VB1sIZpy+2iKB0T0dT27shq2appyCqT6lpC6Xb5htOGFQ6CyyWJRVQmKG3
         JEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3T4unwBN6DAss/vXa/xJmAOTD2m7ZDx+eMxXRo4e0Fg=;
        b=ufN+u38QZxvMADCl+V3Q5vKypICRBbPL7EqcY3NGbES5F/QGUwzYSr/QLmrjaF93fJ
         V98wr2Tg4sxrS6FQdPYiJQaCu78VG5uPrRZMZ7cl9/5qkix/T+yc5HYe/7E+jY4HBRaI
         pqr/5HHEDnc7l4g4Hpfgt4yadhJC39skRCOFMViTGYKJYTMbT8QbCIr8AgwEqRErVDlG
         L9N4RGpiRJyt+dtZ+XgBWyt4r6jO2kXGfqUU4kO7yEzr1GNs1M7U/DkqRp6DjANBOUYO
         kh9p/wPVQrKhogBiGa0ajX3cV+AME2rG1dwFGgr3WRE0qw8sNuvlaL1gjTlvTb+gJcWY
         qtBA==
X-Gm-Message-State: AOAM5308CrHAL+THFJBnHnRWQslJKrGR+WqDnpRqBZ3pedDfAqGabS1W
	dYmkwfPG7+T5tVxYDmXhM6SIuIMCIgMRfHqRqYqkJw==
X-Google-Smtp-Source: ABdhPJw24AVBXmYa10OLqr7VzQwxvcnDwQ6Eh+udPQ83x5v4K/TtFzGA68hubhySMwxrObV5mxzXVBB2oADdJj++G+s=
X-Received: by 2002:a5d:5987:: with SMTP id n7mr4323023wri.260.1628872908548;
 Fri, 13 Aug 2021 09:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210810165509.19121-1-ross.burton@arm.com> <20210810165509.19121-4-ross.burton@arm.com>
 <86a39b80-209b-8fc5-7239-ef6cf3541f55@bootlin.com>
In-Reply-To: <86a39b80-209b-8fc5-7239-ef6cf3541f55@bootlin.com>
From: "Ross Burton" <ross@burtonini.com>
Date: Fri, 13 Aug 2021 17:41:37 +0100
Message-ID: <CAAnfSTvxcxK6budbRk9UP+YxECHzCkxRygO6SG1V5tL-v836Aw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 4/4] fetch2/wget: fetch securely by default
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

In my experience git has been clever enough to notice that the base is
different and will apply the patches anyway.

Ross

On Wed, 11 Aug 2021 at 14:46, Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hi Ross,
>
> Thanks for the patches!
>
> On 8/10/21 6:55 PM, Ross Burton wrote:
> > From: Ross Burton <ross@burtonini.com>
> >
> > The days of broken certificates are behind us now, so instead of always
> > passing --no-check-certificate to wget, don't pass it by default and
> > instead only pass it BB_CHECK_SSL_CERTS = "0".
> >
> > [ YOCTO #14108 ]
> >
> > Signed-off-by: Ross Burton <ross.burton@arm.com>
> > ---
> >  .../bitbake-user-manual-fetching.rst          |  4 ++++
> >  .../bitbake-user-manual-ref-variables.rst     |  4 ++++
> >  bitbake/lib/bb/fetch2/wget.py                 | 19 ++++++++++++++++---
> >  3 files changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>
> This patch looks good, but your patches seem to apply to the Poky repo,
> not BitBake. Wouldn't be easier for Richard if you submitted patches for
> the BitBake repo instead? That's where the patches need to go, if I
> understood correctly. Unless there's a workflow I'm not familiar with...
>
> Cheers,
> Michael.
> --
>
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
