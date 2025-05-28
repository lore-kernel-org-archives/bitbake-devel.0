Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13EEC3ABB2
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 12:34:17 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.14486.1748435651469718391
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 May 2025 05:34:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MrKgAxHy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a361b8a664so4500485f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 May 2025 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748435650; x=1749040450; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P4qObdgjpD2LxdcwtC14UQLZcCd53h4vxiiWR2nUBPo=;
        b=MrKgAxHy4PHO1Tg699AxNB+IMHd3QqfVE1yX1yHyJ5JUIRKu7vBHmQjpWrvDdzNkZ2
         LmbAz3BijEMDgZDPIxQeLfDkwvGd5kN8QgvNsXeWg6oYiygdj6kh+4jIOCD3hS/uHdW/
         SHCxyTSPLbp5rkBoO54k532s+2v2afHsaDM4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748435650; x=1749040450;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4qObdgjpD2LxdcwtC14UQLZcCd53h4vxiiWR2nUBPo=;
        b=hB14NZ9wHzeTZ5NNAidX8WjJoDBgyrGNeELBEBv+N/38YV1686a+QH4tDgDBTDRmEm
         7YcUU+1VFdSBmmGp1JDqkM+VNHYzeN48+nQ53rNqMOXaLLVrLInvXa7JMa+haLw7fGMI
         r5Hbfd/tD+uTZ36+5Kc6e2rrWYvfvDxMiTJgqwPeK4mSMva6y2hj22oU5g7fmgkBMSbB
         XHUB2ly9AQLGPsw737PYv9mP+nSC/x2kPZSEc23EOQJDiKvgSYlvpUkRcb9skrTIoK4u
         TpGA4EeK8p3nSgfpxDyPpLp5BH6w8auei2tV8ifVo9be+ZcIrQWe0OT8uF7tPA3Rrn0l
         DZAA==
X-Gm-Message-State: AOJu0Yxntye9AyJ/euprJmIV/+9TNCnJg3MclAOHixK5iJcfOra7wsEv
	fYplutJXOLFh2hpgLubr9ExMr/x0ATJ0sfJfgCVQg9MmDk9lDngr97Cfxz2pKaQ8dVs=
X-Gm-Gg: ASbGncuP5zmCawFJa5D/XW1+Sji2gLrczAiYieNUX1zonDX6WCG84l3sCgydg/68BW3
	9GHhL0E9KjuyOZbzMMhnlnIEET7mP9dMER5ESh6nEt/7DTYIW5CKinAz8mD3gxVsU4b1FS6JTUF
	1TBDLGc6SMVSkxf+FfenVgKt4ZKx2COW5yz9et/TuuPeGOybmhWXPUaU26v9hVsZ7gjuzXVu2F7
	xem8LATi5li3GJnjLtCh9NjWVKppJIU2MY6WUwcL12zcM6rHGa+yXm02mGipUNxfD+OdWhaS40n
	mPSQBC0gSF/O1g2nqy5QKGC0DJw/HkpoO6NxU5ABG34Ri7wZaPPIvRP1lpBspYKup4PviCNtxtD
	L8IIFYSE5HJYyPm+yU7IDP4qFDqVLTRorZlkLF17K7Z6B6oVBOkU=
X-Google-Smtp-Source: AGHT+IEzSd/SBUxWkqqSGRsuhbV/VSv+ZavMnDLgMIuCymY1MNsTEfBLTmzAXCHKLhnTTXoMlAJlDw==
X-Received: by 2002:a05:6000:2011:b0:3a4:eb54:9bec with SMTP id ffacd0b85a97d-3a4eb549c45mr1546263f8f.47.1748435649628;
        Wed, 28 May 2025 05:34:09 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ebb4:3a70:7323:f416? ([2001:8b0:aba:5f3c:ebb4:3a70:7323:f416])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac6e9fdsm1390030f8f.16.2025.05.28.05.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 05:34:08 -0700 (PDT)
Message-ID: <c46074a15da17c013a08bf63d7ec7ca4857eab39.camel@linuxfoundation.org>
Subject: Re: Tuning BB_PRESSURE_ values (was Re: [bitbake-devel] [PATCH]
 runqueue: Allow pressure state change notifications to be disabled)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mike Crowe <mac@mcrowe.com>
Cc: bitbake-devel@lists.openembedded.org, Jack Mitchell <jack@embed.me.uk>
Date: Wed, 28 May 2025 13:34:08 +0100
In-Reply-To: <aDb_9E_ZqiOb_zz8@mcrowe.com>
References: <20250523145205.3542264-1-mac@mcrowe.com>
	 <d317516d9184fc3d304f1c21577d0503e06e93cb.camel@linuxfoundation.org>
	 <aDXY_Vp48EnDDP9-@mcrowe.com>
	 <adfa0b4e7e456937f9fe5cea524ddb0f773c4c6c.camel@linuxfoundation.org>
	 <aDb_9E_ZqiOb_zz8@mcrowe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 May 2025 12:34:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17651

On Wed, 2025-05-28 at 13:22 +0100, Mike Crowe wrote:
> [snip]
>=20
> On Tuesday 27 May 2025 at 17:07:45 +0100, Richard Purdie wrote:
> > On Tue, 2025-05-27 at 16:23 +0100, Mike Crowe wrote:
> > > I get hundreds of lines of pressure monitor changes when building eve=
n a
> > > single large recipe that can take about an hour. It's always the CPU
> > > pressure that has changed.
> > >=20
> > > The last time I looked I couldn't find much guidance for setting
> > > BB_NUMBER_THREADS, BB_NUMBER_PARSE_THREADS, PARALLEL_MAKE and
> > > BB_PRESSURE_*.
> > >=20
> > > We currently set PARALLEL_MAKE, BB_NUMBER_THREADS and
> > > BB_NUMBER_PARSE_THREADS to the number of CPUs on the host. (Our build
> > > machines tend to have about 32 logical CPUs though we originally set =
these
> > > values when they only had eight.)
> >=20
> > That is usually about the right amount until you get to larger numbers
> > of cores. On the autobuilder which has 96 cores, we use:
> >=20
> > BB_NUMBER_THREADS =3D '16'
> > BB_NUMBER_PARSE_THREADS =3D '16'
> > PARALLEL_MAKE =3D '-j 16 -l 75'
> > BB_PRESSURE_MAX_CPU =3D '20000'
> > BB_PRESSURE_MAX_IO =3D '20000'
> > BB_LOADFACTOR_MAX =3D '1.5'
> >=20
> > (see meta/conf/fragments/yocto-autobuilder/autobuilder-resource-
> > constraints.conf)
>=20
> I would have expected that value for PARALLEL_MAKE to be stopping a singl=
e
> instance of make from using anywhere near enough CPUs to cause CPU pressu=
re
> with that configuration. With 96 cores you'd need to be running six copie=
s
> of make in parallel, and even then the load average limit stands a good
> chance of kicking in before the CPU pressure will rise too high.

For clarity, we run three autobuilder targets in parallel on most
workers and that can include oe-selftest -j 12, so our builds can scale
differently/badly and this was found to be the best combination of
options for us. I mention it mainly to illustrate a combination we've
been happy with.

> >=20
> > > With the above settings I tend to see Bitbake kicking off many tasks =
all at
> > > once, which pushes the pressure too high and it backs off whilst thos=
e
> > > tasks finish and then the same happens again. It makes the knotty out=
put
> > > on console look rather like a spring bouncing up and down. This is cl=
early
> > > not ideal. Luckily there aren't too many really huge tasks that get t=
o run
> > > in parallel, so the smaller ones finish and free up resources.
> >=20
> > It is tough, bitbake could perhaps have a startup/backoff algorithm to
> > try and avoid it. T
>=20
> Yes, I did wonder whether it would make sense to wait for a little while
> before launching another task to give the first one a chance to get going=
.
> That's bound to make things worse in some situations though.

It would certainly limit the build speed in some scenarios and you'd
have the challenge on how long it takes for load to increase. Some
parallel make jobs probably need a short while to build common
dependencies before hitting max parallelism.

> > That said, the idea has been that it should be able to run
> > BB_NUMBER_THREADS in parallel without issue and then the pressure
> > regulation kicks in if one of those jobs is heavy and using system
> > resources and avoids bitbake starting any new jobs until it is done.
> >=20
> > I still suspect your pressure numbers may be low. How to work them out
> > is trial and error though, I wish there was a better way.
>=20
> I'll certainly try much higher pressure numbers. I could certainly try
> reducing BB_NUMBER_THREADS, but reducing PARALLEL_MAKE's -j would slow do=
wn
> the larger projects we build when they are the only task running. It's
> probably worth experimenting with -l too though.

I'd say the -l option is by far the more useful of the two FWIW.

Cheers,

Richard

