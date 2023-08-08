Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA76C04A6A
	for <webhook@archiver.kernel.org>; Tue,  8 Aug 2023 20:05:52 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.72304.1691525148028957527
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Aug 2023 13:05:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HjIUyJGP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so1300845e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691525146; x=1692129946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bS+tpB1GQA+AkbsiJwCq56b9QrMvmi9l25NrASrI/gU=;
        b=HjIUyJGPvqYvO2tTe/sBFgb6bMqtBjlEpI2BWjBAIb7DeLzBkxO9GF8r0oV/Hd7bsq
         pKd9DyKq8G4OjWiJOmHkeYEDktdRxTAp4jAEnl6XYOvr32ltG1+o3+ZNrH4FzRdGeCjH
         aF+MSATQBjzvgPkEL1zBVZqG65NT39nFrEu9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525146; x=1692129946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bS+tpB1GQA+AkbsiJwCq56b9QrMvmi9l25NrASrI/gU=;
        b=eaRvqKPnHUhNx8xVkfs+RPs46UYez7FtXIpelKP0E9JLfcVEQJe14NKnrGw/CyMdrp
         73FrYz+rLThoxB9UK+16hCZnCEuXmK++pbEODmDz/zhhDuxvgN0I4K4v9Qff1SNrTo+L
         QbVFNgIxoLDmeAFYAKMSNxuoPfqIiUUl9I9isumzv97RLERkzvRUe2NmyUW95A9wyort
         pCefmTRdO49mE64M38OYKPLkSjUn7A/EcmHYZNbYfSUKqjYKHUECeqKQjaGGiHtlYci1
         lShzK89w9J8O9mp75mjsKNqaG1cfEm+OgvMQCxeka+bklR1dfcVGkrSJj/SWugoXcTdz
         U4Lg==
X-Gm-Message-State: AOJu0YzU9fLReyl0Lr5Ia+vn/e4Wri++8I0jsxRphhiJxs2ttnD4ObN0
	xwxiQla1rZbsc13r0wvf/9BeiA==
X-Google-Smtp-Source: AGHT+IGhrATKml67j5oFJlAQ6SAnykfwzGSErjSU3Q7l+hqUdEZH0EuDvmBUydMtH4K0wX2bcAGOFQ==
X-Received: by 2002:a05:600c:ace:b0:3fb:416d:7324 with SMTP id c14-20020a05600c0ace00b003fb416d7324mr681302wmr.6.1691525146354;
        Tue, 08 Aug 2023 13:05:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d249:8c2a:f169:cb41? ([2001:8b0:aba:5f3c:d249:8c2a:f169:cb41])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b003143867d2ebsm14430917wrq.63.2023.08.08.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:05:45 -0700 (PDT)
Message-ID: <0dc5f0bfa8e48dee0c1b4aedb75285725054ca0b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v3] fetch2: add Google Cloud Platform
 (GCP) fetcher
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: eekmecic@snap.com, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 08 Aug 2023 21:05:44 +0100
In-Reply-To: <CACjag3vGrbb=aZq0hMfQUobbyzLn+5GD1Tj6pWze7zVOakWwqg@mail.gmail.com>
References: <20230802130632.805865-1-eekmecic@snap.com>
	 <202308072156510534a9ce@mail.local>
	 <CACjag3vGrbb=aZq0hMfQUobbyzLn+5GD1Tj6pWze7zVOakWwqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 20:05:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14929

On Tue, 2023-08-08 at 12:25 +0200, Emil Ekme=C4=8Di=C4=87 via
lists.openembedded.org wrote:
> On Mon, Aug 7, 2023 at 11:56=E2=80=AFPM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >=20
> > Hello,
> >=20
> > On 02/08/2023 06:06:32-0700, Emil Ekme=C4=8Di=C4=87 via lists.openembed=
ded.org wrote:
> > > +import os
> > > +import bb
> > > +import urllib.parse, urllib.error
> > > +from bb.fetch2 import FetchMethod
> > > +from bb.fetch2 import FetchError
> > > +from bb.fetch2 import logger
> > > +from google.cloud import storage
> >=20
> > This fails on the autobuilders with:
> >=20
> >   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/bin/bitbake-l=
ayers", line 24, in <module>
> >     import bb.tinfoil
> >   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/__init=
__.py", line 139, in <module>
> >     from bb import fetch2 as fetch
> >   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/fetch2=
/__init__.py", line 1979, in <module>
> >     from . import gcp
> >   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/fetch2=
/gcp.py", line 26, in <module>
> >     from google.cloud import storage
> > ModuleNotFoundError: No module named 'google'
>=20
> As noted in the comment at the top of the file and the documentation,
> using the GCP fetcher requires the Python package to be installed.
> I'm not sure the best way to handle this given that using the GCP
> fetcher is optional. Other fetchers (S3, Azure) rely on third party
> tools to be installed on the command line but no fetchers that I
> found rely on Python packages to be installed.
>=20
> I'm submitting an updated patch where the import statement is wrapped
> in a try-catch block with a descriptive error message but I welcome
> other approaches too.

This will still mean that effectively anyone trying to use bitbake
would be forced to install this python module which isn't acceptable.

Instead I'd suggest moving the imports into the method calls. Whilst
this may have some duplication of the imports, it will also allow
things to work without forcing everyone to have this python module.

Cheers,

Richard


