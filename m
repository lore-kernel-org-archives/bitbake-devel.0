Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B66C00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 16:34:25 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.540.1660149259077785392
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 09:34:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hnAWmxQV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id j7so18402769wrh.3
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=ivtL81i4+9dFnUDY97rrGk/L48WNfRHn3yyJcJTeXPs=;
        b=hnAWmxQVhn+ccGFu1JZ7OPoabMq1+x5HJryScwv7BZvDX44KsHsxNbVmviQKKCvgbA
         z1+9HNb0TR694UzgHA3WY3Zhowz2ktytUg+t78jCuN7gYzSOpmAsOW1WLYM9XzOjuNEZ
         V8k9ngKZtIc2v0REqoupVoxGC92IU014UIWKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=ivtL81i4+9dFnUDY97rrGk/L48WNfRHn3yyJcJTeXPs=;
        b=rI0k5l7fF7ONF3K5sClroFT6GqIRDVZYWPKC8tvwd3pCz24EjRuPXvtWA8SX/I/b+S
         OBYGYcLNPMtONL3FHDRJNkoxir7Plfnc2XH+TvfTm0XgB+idkM8KCE0cxnR/8x63+bCm
         prpA9dmjs1YBUkSCOLxSdYiX4NcnfaM4d2aYK3Q7l8mlzEjLchjWjrt0tp7B9I0K+mfN
         SFN+mEXEdggFqPBc9qwYrncwmd3KEqkNN/9KFhXn2bR52milq9Q9UlZCsF/AXZP45tn8
         2Iz7xJZFRGSSdqz3KVIs4m2DRujm9iPBWf7ZC+OQNZXJ72YbZV2Rzr2aDzl+hoISElD/
         LeLg==
X-Gm-Message-State: ACgBeo3+PgR8jQunMxyN87YRG5xBa7jpQddolYgrhMLDn+no3sWcQ4d7
	BU44E5FF+X0F6wdeGp7KsOHGeQ==
X-Google-Smtp-Source: 
 AA6agR7s+VJdhAC4NHyklePI/nR9fFbHq5qusOMoAmhezl7oFhiixjRwaPLHEvg4v5w9f4s0mg+o3A==
X-Received: by 2002:a05:6000:18af:b0:222:c48d:9064 with SMTP id
 b15-20020a05600018af00b00222c48d9064mr11612016wri.18.1660149257475;
        Wed, 10 Aug 2022 09:34:17 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b?
 ([2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b])
        by smtp.gmail.com with ESMTPSA id
 c18-20020a05600c0a5200b003a531c7aa66sm1823310wmq.1.2022.08.10.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:34:17 -0700 (PDT)
Message-ID: 
 <351fb140d21275741c2c75bb255d7a5d9aec3643.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] BBHandler: Allow earlier exit for
 classes not found
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2022 17:34:16 +0100
In-Reply-To: 
 <CABcZANkj2Bq+cnCNmD4sTadK9QXV88u0YeqOriNQTePzSd_UFw@mail.gmail.com>
References: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
	 <CAMKF1sq8xAqD-yzEkV67yDPs3yoeQ86ygHKXoLHbp0Go2n=kWQ@mail.gmail.com>
	 <e37b5612a36eaebe3ac3aa93f36ebe9bcda3861d.camel@linuxfoundation.org>
	 <CABcZANkj2Bq+cnCNmD4sTadK9QXV88u0YeqOriNQTePzSd_UFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 16:34:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13890

On Wed, 2022-08-10 at 09:27 -0700, Christopher Larson wrote:
> Can we not make the inherit command adapt to current inherit context,
> global or recipe?

The issue is that I'd made image-artifact-names a recipes class in OE-
Core and it was trying to be pulled into the global space via
buildhistory.

Either we accept it as a global class and change some of the users, or
we make it image specific as I'm proposing in the patch.

Cheers,

Richard

> On Wed, Aug 10, 2022 at 9:19 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Wed, 2022-08-10 at 08:55 -0700, Khem Raj wrote:
> > > I seeing
> > >=20
> > > % bitbake binutils
> > > WARNING: ['base', 'sanity-meta-odroid-extras', 'clang',
> > > 'report-error', 'image-buildinfo', 'package_ipk', 'buildhistory',
> > > 'buildstats', 'buildstats-summary', 'debian', 'devshell',
> > > 'sstate',
> > > 'license', 'remove-libtool', 'sanity']
> > > ERROR: ParseError at
> > > /mnt/b/yoe/master/sources/openembedded-
> > > core/meta/classes/buildhistory.bbclass:10:
> > > Could not inherit file classes/image-artifact-names.bbclass
> >=20
> > I think we need something like:
> >=20
> > diff --git a/meta/classes/buildhistory.bbclass
> > b/meta/classes/buildhistory.bbclass
> > index 4345ffc6939..203310ba975 100644
> > --- a/meta/classes/buildhistory.bbclass
> > +++ b/meta/classes/buildhistory.bbclass
> > @@ -7,7 +7,7 @@
> > =C2=A0# Copyright (C) 2007-2011 Koen Kooi <koen@openembedded.org>
> > =C2=A0#
> >=20
> > -inherit image-artifact-names
> > +IMAGE_CLASSES +=3D "image-artifact-names"
> >=20
> > =C2=A0BUILDHISTORY_FEATURES ?=3D "image package sdk"
> > =C2=A0BUILDHISTORY_DIR ?=3D "${TOPDIR}/buildhistory"
> >=20
> > Does that help?
> >=20
> > I need to remove that warning too! Although it does help debugging
> > right now.
> >=20
> > Cheers,
> >=20
> > Richard
> >=20
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#13888):
> > https://lists.openembedded.org/g/bitbake-devel/message/13888
> > Mute This Topic: https://lists.openembedded.org/mt/92936457/3617123
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
> > [kergoth@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >=20
>=20
>=20


