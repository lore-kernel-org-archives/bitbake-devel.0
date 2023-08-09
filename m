Return-Path: <eekmecic@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F47C001B0
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 09:13:45 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.84186.1691572416142091872
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Aug 2023 02:13:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=d1ufpdMG;
 spf=pass (domain: snapchat.com, ip: 209.85.210.51, mailfrom: eekmecic@snapchat.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bc9d16c317so5305902a34.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Aug 2023 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1691572415; x=1692177215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vaf/oL0Gk/OAk94XIGlxlDY3Su5gLLW3c65SVk+Apx4=;
        b=d1ufpdMGQmm65IdFhh9V8aC9VevB9AOBfBB7+whwKebsBQBRs3hEN+wPcbJ7TAUwyr
         mO7Oi6mgjeVgc2eY6bJVDlW04PUopS9H6e7Et+x9qOlJCoWvoeCtcSv8tuHpRMbkfvaD
         88M4dHFZKLC5RosxL6TZaAQJstNfE7aYbrA9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691572415; x=1692177215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vaf/oL0Gk/OAk94XIGlxlDY3Su5gLLW3c65SVk+Apx4=;
        b=LrXy4M1/IJ1rLSNX53tJT0eDFlNCGGJ4BHi+9E+tGrOWYQYDKU2y4xQy++pDTbwIgS
         IpUWy+L/qwHU9fUA4KlUdn5i76ZfMF6WDgCS2M00PwVUh+DYDAvbj6GHxYR6vOc+xhLa
         TPn8+liEIb+Bs4ZFOZ9UQr89rq5GVrwlciWNM2FUh6tHVRjWCWD801/+nBu3gvvO3nt4
         vDIYvfuLM+12iTjSz7hqPtp386AzSL9YjGhut41MuN7kwWNCA0eEepUv5dfcVKwIBsQ7
         ZfHWoR0TqkzsKrZhKaAaNwJPV2RP6e736k1eKuxKNjfYsJJEuadEQnsyjTIg/wnDIEka
         QeyQ==
X-Gm-Message-State: AOJu0Yz9jff2FxWGMtzBHxaBR4LqFHtd5PWxLp61reQoqAWeqiysqz46
	hT6GhDR1VNDRxQDACRvw6jGAf4QULdBwvwu5UXopMg==
X-Google-Smtp-Source: AGHT+IH6aojs0gd6kGNlJiJ+aBWbecioa1K51miKb3Gs08GBPeVodzIZPloPl7YwX/k4y305Zq6aDLoM7i8YJNWjo/k=
X-Received: by 2002:a05:6358:3a18:b0:134:d78f:67bc with SMTP id
 g24-20020a0563583a1800b00134d78f67bcmr2044855rwe.14.1691572415284; Wed, 09
 Aug 2023 02:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230802130632.805865-1-eekmecic@snap.com> <202308072156510534a9ce@mail.local>
 <CACjag3vGrbb=aZq0hMfQUobbyzLn+5GD1Tj6pWze7zVOakWwqg@mail.gmail.com> <0dc5f0bfa8e48dee0c1b4aedb75285725054ca0b.camel@linuxfoundation.org>
In-Reply-To: <0dc5f0bfa8e48dee0c1b4aedb75285725054ca0b.camel@linuxfoundation.org>
From: =?UTF-8?B?RW1pbCBFa21lxI1pxIc=?= <eekmecic@snap.com>
Date: Wed, 9 Aug 2023 11:13:24 +0200
Message-ID: <CACjag3v04QAP6TipSeHhmvm4Wxd=C-0-zd2wTyFc_FagA13fbw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v3] fetch2: add Google Cloud Platform (GCP) fetcher
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Aug 2023 09:13:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14931

On Tue, Aug 8, 2023 at 10:05=E2=80=AFPM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Tue, 2023-08-08 at 12:25 +0200, Emil Ekme=C4=8Di=C4=87 via
> lists.openembedded.org wrote:
> > On Mon, Aug 7, 2023 at 11:56=E2=80=AFPM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > Hello,
> > >
> > > On 02/08/2023 06:06:32-0700, Emil Ekme=C4=8Di=C4=87 via lists.openemb=
edded.org wrote:
> > > > +import os
> > > > +import bb
> > > > +import urllib.parse, urllib.error
> > > > +from bb.fetch2 import FetchMethod
> > > > +from bb.fetch2 import FetchError
> > > > +from bb.fetch2 import logger
> > > > +from google.cloud import storage
> > >
> > > This fails on the autobuilders with:
> > >
> > >   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/bin/bitbake=
-layers", line 24, in <module>
> > >     import bb.tinfoil
> > >   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/__in=
it__.py", line 139, in <module>
> > >     from bb import fetch2 as fetch
> > >   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/fetc=
h2/__init__.py", line 1979, in <module>
> > >     from . import gcp
> > >   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/fetc=
h2/gcp.py", line 26, in <module>
> > >     from google.cloud import storage
> > > ModuleNotFoundError: No module named 'google'
> >
> > As noted in the comment at the top of the file and the documentation,
> > using the GCP fetcher requires the Python package to be installed.
> > I'm not sure the best way to handle this given that using the GCP
> > fetcher is optional. Other fetchers (S3, Azure) rely on third party
> > tools to be installed on the command line but no fetchers that I
> > found rely on Python packages to be installed.
> >
> > I'm submitting an updated patch where the import statement is wrapped
> > in a try-catch block with a descriptive error message but I welcome
> > other approaches too.
>
> This will still mean that effectively anyone trying to use bitbake
> would be forced to install this python module which isn't acceptable.
>
> Instead I'd suggest moving the imports into the method calls. Whilst
> this may have some duplication of the imports, it will also allow
> things to work without forcing everyone to have this python module.
>
> Cheers,
>
> Richard
>

Sounds good, I will make the requested changes and submit a new
revision of the patch. Thank you for the feedback

Emil Ekme=C4=8Di=C4=87

