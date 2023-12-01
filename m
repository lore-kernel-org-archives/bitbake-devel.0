Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB917C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 17:54:50 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.6271.1701453281367816837
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 09:54:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EaGfHRyK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40b4c2ef5cdso20858735e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701453279; x=1702058079; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NCXLdgVyhxIzcRxnzHZqjE/nrOKm+rXwF36UoJYjQO8=;
        b=EaGfHRyKWLBvu35SaOrd01TlV7f4e/0OazS3Z8mBUlgyIjuikgrvo3+w47lf889OD+
         VKFMOSq2gAgIevjf95pyf1yVufc5XlsFOZa3yXFS/Q9aA9mBjVLOzEQx3c0cK3B+mKYu
         TrTUF19uNybO1O9pYnAIZ/JH7yfx2FZcX51RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453279; x=1702058079;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCXLdgVyhxIzcRxnzHZqjE/nrOKm+rXwF36UoJYjQO8=;
        b=fYv4xI9vVF0QcVxIrj/YrjxzUPMxEB/VyxNIv2V9ZnXFVAVkofP2SwJ+9byFUvV8Yu
         xxFzMLLTKYpsBB4+Okmg5N/AhNfLAoErYhgScfGyf9WJzsFDYQFSJy+mmOdjGRWMWuUf
         m/wkB0lzOAfwkLz+r9bsg+y+ttVushcUnVswbSp+thV07auqvD3BDWkdGk+FzKehRrAw
         GHMOdY3u0VeTslFRRJxQZi88t2KMlOnFpKrBBLfZUR3MDZkDSkVC7F+mcn34RTSXdWwA
         QE/2RTv82cxkcY0yuTZ04JvjJpiLR9Jm6S2+KjRtFCltid2FRKRjwJM2z1fo3VVNtx8E
         Ahtw==
X-Gm-Message-State: AOJu0YxmR2y+q681Cvd/ArLEHcKnLdzzb7rs5J+q4pW4Ju+EbAUMfE+H
	RF3fDuoLTW3wLmzeORfMi1wN8g==
X-Google-Smtp-Source: AGHT+IF+2yyxupzUz6778Lx/JV3k1OMN/Fuz6pNZoB8NzH190NPagFE4tJmrOpOIj6qvvdjPitM2uA==
X-Received: by 2002:a05:600c:1d9d:b0:40b:5e4a:4085 with SMTP id p29-20020a05600c1d9d00b0040b5e4a4085mr423174wms.165.1701453279407;
        Fri, 01 Dec 2023 09:54:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:201d:dd04:f9b4:3c83? ([2001:8b0:aba:5f3c:201d:dd04:f9b4:3c83])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b00405959469afsm6135619wmb.3.2023.12.01.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:54:39 -0800 (PST)
Message-ID: <ce59da9ec69650d1b26da97b30d78c1ff62cab5f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] AUTOREV, PREMIRRORS and unavailable upstream
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>, 
	"alex.kanavin@gmail.com"
	 <alex.kanavin@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>,  "enrico.scholz@sigma-chemnitz.de"
 <enrico.scholz@sigma-chemnitz.de>
Date: Fri, 01 Dec 2023 17:54:38 +0000
In-Reply-To: <79097bd03a108ad216ee54df76629e820aec8566.camel@siemens.com>
References: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
	 <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org>
	 <513a7d673eb8cdff5cc8ae0c5717ea3e81349da3.camel@siemens.com>
	 <CANNYZj-7f=a9Bj2Ec83qS=vyCU10Wz2zdn-vqey0ThbHUjn=tA@mail.gmail.com>
	 <79097bd03a108ad216ee54df76629e820aec8566.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 17:54:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15602

On Fri, 2023-12-01 at 12:29 +0000, MOESSBAUER, Felix wrote:
> On Fri, 2023-12-01 at 13:15 +0100, Alexander Kanavin wrote:
> > On Fri, 1 Dec 2023 at 13:05, Felix Moessbauer via
> > lists.openembedded.org
> > <felix.moessbauer=3Dsiemens.com@lists.openembedded.org> wrote:
> > > there are more cases where direct access to upstream projects is
> > > not
> > > possible. Simply consider airgapped environments where all
> > > resources
> > > are accessed via local mirrors. I'm also a bit skeptic about the
> > > definition of "latest". Git by itself is a decentralized VCS,
> > > meaning
> > > that there is no "global" latest, but just "latest" revisions of a
> > > local copy (in contrast to e.g. SVN). These copies are just
> > > eventually
> > > consistent.
> >=20
> > Perhaps we need to step back and consider the reasons for using
> > AUTOREV in an airgapped environment. What are they? Perhaps you can
> > replace AUTOREV with external tool that updates SRCREV in the
> > recipes?
>=20
> I'm anyways not a fan of AUTOREV, as it is too much magic and somehow
> unpredictable. However I cannot easily change upstream layers (with a
> reasonable effort). By that, I might end up with combinations of an
> isolated build where still autorevs are in use.
>=20
> Maybe I was a bit too imprecise about the airgapped environments: I was
> referring to environments where from time to time no direct access to
> upstream is possible. In the end, this is also a supply chain
> resilience topic: Upstream resources will not always be available (due
> to maintenance, network issues, sporadic filtering on corporate
> networks - yes, that's bad but daily business, ...). In the end, we
> want to have a resilient build that is not susceptible to these single
> points of failure.
>=20
> And in addition, it blocks all users from locations where direct access
> to an upstream resource is not possible, e.g. due to well-known
> reasons.

This is what PREMIRRORS are for. They will be accessed and used first.
This is how we cover the resilience issue.

There is a specific case of AUTOREV where it directly accesses SRC_URI
and bypasses PREMIRRORS.

Basically people shouldn't rely on AUTOREV in production layers, its a
nice tweak for local development use only.

If you encounter a layer using AUTOREV and need to use it airgapped,
you'd specific specific source revisions from your own distro or local
config and complain to the author of the layer they're making your life
hard.

Cheers,

Richard

