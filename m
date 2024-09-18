Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF8CCD188
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 07:42:16 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.10028.1726645335292550986
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Sep 2024 00:42:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W5sgXott;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso2742545e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726645333; x=1727250133; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mj2sZPn1nMM8IK90NW71KpUH65soRSK6NjtK3/ys5Fg=;
        b=W5sgXott6GTzWdVkIBTMCOd5R44n5GzQq7h0Dajua/DARN0yQbdZdv8tG+EpIoqmin
         ZzdzCqaDCm/pfBJNXngpms4ujqbvSIN+NQ1ciNpvRrZqI8LkbttpKYxWuRhHCOpkz+lt
         XSprci3gkldSG+pKyXA5MOdHC66BPX+RvDaF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645333; x=1727250133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mj2sZPn1nMM8IK90NW71KpUH65soRSK6NjtK3/ys5Fg=;
        b=f2ZIuejlzVxgQ7o+9nQSJxAKAy5ivBHH+1dyqqWIDRdVjrXlLonFpyc4uqOl81X+u7
         dmhRAu5VtQRD0m22y+483qiLq+mjRo+63Hb3359GjhXQakcg+pkR5PxpIMTWE9FGCnwj
         Ze+uH1qlTW/XgqKmyPTXIXB77iKsMCUXOcxn8UU2lbiP1cInQ8Qp/lTB4j3fpx0vE0F4
         QpIvEP71x3xLg1qOf8Wic/Q3iPetRwbAI7fyFY28o98qIDufP6tZNycbZjMsDnI0QshD
         obGGoxIN7a7zES1DNmJanHIuxd6hut+xlAJdNLWPHPRSLYsiM0bpXfgNJ6snNmMNzxcN
         5zjg==
X-Gm-Message-State: AOJu0Yw8Kvk11iSdcz2fOATF5WGJe49hwVn0p6+A4FFhyYT5yFACxVeP
	/6RI0qlM6NJvPIve82jTJx6UYPpQqKIMKtwCfqsXceg6XvsptxYmhW/6VDw1ilo=
X-Google-Smtp-Source: AGHT+IFoIvryPMTidkOgC0CJ2nfXYnRhehCFj3E/Q1B5SmwrhwcZAuZTrjcMq1qHKC9gP2BhTSFmaA==
X-Received: by 2002:adf:ee8d:0:b0:36b:5d86:d885 with SMTP id ffacd0b85a97d-378a8a83a66mr15602087f8f.24.1726645333048;
        Wed, 18 Sep 2024 00:42:13 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:84e0:f160:18f9:5089? ([2001:8b0:aba:5f3c:84e0:f160:18f9:5089])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78051c1sm11762810f8f.99.2024.09.18.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 00:42:12 -0700 (PDT)
Message-ID: <8c5a997d4bde25f493cff512990c9cc4c7885187.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: add documentation for
 "bitbake -S lockedsigs"
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Sep 2024 08:42:11 +0100
In-Reply-To: <CAEHHSvZpX1HZAX_wT9X9ysnAG2meu0UeO1-tA5Jrebc6449_6g@mail.gmail.com>
References: <20240917151157.780068-1-jstephan@baylibre.com>
	 <b911e5bef3e661b976d6a5822e9fa2941d2e90d7.camel@linuxfoundation.org>
	 <CAEHHSvZigPQTmPwHP-vom2ybOXoXQm3NhCsUyFLW0n9H2t3VxA@mail.gmail.com>
	 <6a74952e25ddc9b0aaf90571851b4802c574369f.camel@linuxfoundation.org>
	 <CAEHHSvZpX1HZAX_wT9X9ysnAG2meu0UeO1-tA5Jrebc6449_6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 07:42:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16571

On Wed, 2024-09-18 at 09:39 +0200, Julien Stephan wrote:
> Le mer. 18 sept. 2024 =C3=A0 09:30, Richard Purdie
> <richard.purdie@linuxfoundation.org> a =C3=A9crit :
> >=20
> > On Wed, 2024-09-18 at 09:05 +0200, Julien Stephan wrote:
> > > Le mar. 17 sept. 2024 =C3=A0 22:55, Richard Purdie
> > > <richard.purdie@linuxfoundation.org> a =C3=A9crit :
> > > >=20
> > > > On Tue, 2024-09-17 at 17:11 +0200, Julien Stephan via
> > > > lists.openembedded.org wrote:
> > > > > The following commit added "lockedsigs" as new signature
> > > > > handler
> > > > > for the
> > > > > -S option of bitbake:
> > > > > =C2=A0=C2=A0=C2=A0 2cf13f25139 - lib/oe/sstatesig.py: dump locked=
.sigs.inc
> > > > > only
> > > > > when explicitly asked via -S lockedsigs
> > > > >=20
> > > > > But it was not documented anywhere, so add some basic
> > > > > documentation for
> > > > > it in both the .rst documentation files and the help message
> > > > > of
> > > > > bitbake
> > > > >=20
> > > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > > > ---
> > > > > =C2=A0.../bitbake-user-manual-execution.rst=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6
> > > > > ++++++
> > > > > =C2=A0.../bitbake-user-manual-intro.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 13
> > > > > +++++++++----
> > > > > =C2=A0bitbake/lib/bb/main.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12
> > > > > +++++++-----
> > > > > =C2=A03 files changed, 22 insertions(+), 9 deletions(-)
> > > >=20
> > > > Unfortunately I don't think this is quite so simple. The
> > > > lockedsigs
> > > > support is implemented in OE-Core and BitBake doesn't contain
> > > > that
> > > > code. This makes it very hard to accurately document since it
> > > > is
> > > > metadata dependent.
> > > >=20
> > > > I do agree we need to improve this somehow, I just don't know
> > > > how.
> > >=20
> > > Hi Richard,
> > >=20
> > > Maybe we should remove this from bitbake and implement it using
> > > bblock? :)
> > > Let me know if I can help on this!
> >=20
> > That is a direction I've been wondering about and I think it would
> > make
> > sense. It is one of the reasons I wanted to see the lock/unlock
> > commands become separate tools!
> >=20
>=20
> ok then let me try to come up with something :)

Sounds good!

> By the way, my next step was to send a patch adding documentation for
> SIGGEN_LOCKEDSIGS*
> variables, but I realize that the same problem applies to these
> variables,=C2=A0 right?
> I don't see any reference for these variables inside bitbake code..
> Should I add them in yocto-docs ?

Yes, they wouldn't be documented in bitbake but they could be
documented in the main variable index.

Cheers,

Richard

