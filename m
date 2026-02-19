Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9CCE9A051
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 16:55:55 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18769.1771520151070073629
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Feb 2026 08:55:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y1b9Yocw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362507f0feso768888f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 08:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771520149; x=1772124949; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7bys5cx3Mo5nVB9B0ErYmmOq9A23gdOnUf923k604c=;
        b=Y1b9Yocw2riAm+hfFujWyW3KlLraOcDVIY3SSxc4qEM2i25yLBparYkMja7qRbxOhY
         bkd0KNRIY2BP4oIEMJng5RJuSIC9kV2+K1Fp3+0GGjE7S7RPbP4QeiBy3eF6cvh8vrb0
         DBK4kOaF0sRLZEb3xnk2pKXdpmp9GuukVnFZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520149; x=1772124949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7bys5cx3Mo5nVB9B0ErYmmOq9A23gdOnUf923k604c=;
        b=gVXHiAXbkx/CoJScI5Xfzk8Odn06qTowmDMQ2YOSvInkRa+tGmrGmIoOBdGV1Vkoqu
         6ydijVZ22V40oevWByOAVuEwnCzs8eyz38QTmf2W+6556GeTy+EM9GcAD+Tv3NPc2CWg
         x8mxjbl1wGSuI+uWG5wgN+ZrDdmFQb2lKjMicA34j+KCHQLFc9pcveZcZK5q6Hm7XAoC
         xjUqSv3nMSFJIjPCMwuN0ONOne4iwh3LXe40x7AL2WaSaYt2fwgVMZadgj0ge3WKgzIQ
         URx2VrsnjkmtEyAtVJbLdtj3Ttn7r5r+PK+KZsVlQjxlsuFwQG6PEFvO/fwhrJs85U4F
         p2oQ==
X-Gm-Message-State: AOJu0YzJtePToFyd1OKWicHfTeBvJBXuayXq71XXgyHuMW6L53u4zcaJ
	nrdQSxJzgHlzT+HfM3BG039eFJr1S1Fi/ISi/BpFPzR4F2Vxj0dwatfVmsJ4oQRnFkB9v3dluO4
	OrlEeFCE=
X-Gm-Gg: AZuq6aJlOPhvDkNx2Js59oTMRtc/I4UmJBumk0n9KkGJOTso32ijhwk3zpz0ghxR9Pq
	P4ooyGsBLvrCuzZDviCr0x5cYiOOY5s93TdX3fTJ55zqFY27YVz2iezdGiylRSvTP7LdydKM3Oi
	pLBK0rsJXLgX7BgadI8E6TvoJRdvNGVGph07GFwgk9Eyh6heRFBSmSjg4bQfFu9bFkdLP644iIc
	eCngcR+hHikoDDnTXxIuGJtF2x4sD1m+QwVOl3iZekKHq9bkzhpUSg4U+aAfAbBnkPu8RqVkbm3
	7twZLk1gDKvWJgiEakxvQ36CBaHJXj8xn9/QjwsyhhU/TVqMHW31k5/RtuJ4VblFNHvaZiN6Q3m
	LsFV4VviduJLpi3PtIBA/AAW7XvvPYFUDmIE0StJiBwJIIqZWFGWqz7lc1kSm2QlgRTXR0l9ZtT
	ODbYQmNrJcFEyib3KKAVc6+lmCwYLhhXA+rBo6yUoDZlEJUcLx8v2bjX68widN7i7D/z3jO/FR4
	/kS7M2A8hpsQts=
X-Received: by 2002:a05:6000:2502:b0:435:9f1b:8d19 with SMTP id ffacd0b85a97d-43796aefb41mr42939777f8f.38.1771520149351;
        Thu, 19 Feb 2026 08:55:49 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:da95:be37:6ded:ea39? ([2001:8b0:aba:5f3c:da95:be37:6ded:ea39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1b4sm48087435f8f.14.2026.02.19.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:55:48 -0800 (PST)
Message-ID: <d99ad183e6b7199eb5dbef84ea7b3b48501afc36.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v2] cookerdata: Include "originating"
 recipe name when parsing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Feb 2026 16:55:48 +0000
In-Reply-To: <CAJdd5GbPdL4Ah3d65Uqap4An8MqrY=KiEsdhgk3gR77q=HYFyQ@mail.gmail.com>
References: <20251030141904.69494-1-JPEWhacker@gmail.com>
	 <20251219223620.2222861-1-JPEWhacker@gmail.com>
	 <eeda7effdc1bda1ac5422ac7cc8095d46021a578.camel@linuxfoundation.org>
	 <CAJdd5GbPdL4Ah3d65Uqap4An8MqrY=KiEsdhgk3gR77q=HYFyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 16:55:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19072

On Thu, 2026-02-19 at 09:39 -0700, Joshua Watt wrote:
> On Thu, Feb 19, 2026 at 9:32=E2=80=AFAM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >=20
> > On Fri, 2025-12-19 at 15:36 -0700, Joshua Watt via lists.openembedded.o=
rg wrote:
> > > When a bbappend file is parsed, the FILE variable is set to the name =
of
> > > the actual file being parsed (e.g. the name of the bbappend). Since
> > > PN/PV etc. are derived from FILE, this means that they can be
> > > misleading in the event that bbappend is using wildcards (e.g. PV mig=
ht
> > > have the value of "%" instead of the actual version number).
> > >=20
> > > In order to allow bbappends to derived the actual information of the
> > > recipe, capture the name of the original recipe being parsed as
> > > ORIG_FILE when parsing a new recipe.
> > >=20
> > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > > ---
> > > =C2=A0lib/bb/cookerdata.py | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > > index 22ac95eac..fe41bb3bf 100644
> > > --- a/lib/bb/cookerdata.py
> > > +++ b/lib/bb/cookerdata.py
> > > @@ -512,6 +512,8 @@ class CookerDataBuilder(object):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb_data.setVar("__BB=
MULTICONFIG", mc)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb_data.setVar("FILE=
_LAYERNAME", layername)
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb_data.setVar("ORIG_FILE=
", bbfile)
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbfile_loc =3D os.pa=
th.abspath(os.path.dirname(bbfile))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.parse.cached_mtim=
e_noerror(bbfile_loc)
> >=20
> > We discussed this a bit on the review call today, I appreciate Joshua
> > wasn't there but it made sense to try and unblock this.
> >=20
> > In brief, the concerns mentioned were:
> >=20
> > * no tests/docs
>=20
> A test should be pretty easy to do, I'll see if I can write one up; I
> can try to write some docs also.

Right, those are straightforward in many ways but it also establishes
official API which is a concern. That isn't what is holding this up.

>=20
> > * not wanting to encourage wide use of this
> > =C2=A0 (conflicting with the above)
> > * whether the name is right
> >=20
> > The idea of using a __ prefix for the variable was mentioned. That
> > would allow Joshua to address the issues he has but not make it
> > 'official' recommended API. That might be the compromise we need.
> >=20
> > For the name itself, I'm really torn. For variables which bitbake
> > itself responds to, I've tried to standardise on a BB_ prefix. This is
> > more a variable bitbake exposes for use elsewhere and we have the FILE_
> > prefix already being used but I'm torn on whether we should continue
> > that theme or use something with BB_...
>=20
> BB_ORIG_FILE then? I'd probably avoid the __BB prefix since that is
> reserved for variables which bitbake used internally (only).

Someone did mention "recipe" instead of "file" might be an idea so more
like BB_RECIPE_FILE maybe?

> Alternatively, if we want to set a new convention of "hidden"
> variables, we could perhaps to do something like "bb_ORIG_FILE", but
> that is kinda hard on the eyes :)

I want to try and unblock you, yet at the same time discourage people
from using this. '__' is the best chance of that we have. I really
don't want to do bb_ as that is horrible on the eyes. Part of me
realises it is completely futile to even try and do that and thinks I
may as well not try.

I think the horrors people could implement with this are problematic
but I really am not sure we have many other good choices. Layer
specific dangling bbappend controls aren't particularly nice either.

Cheers,

Richard




