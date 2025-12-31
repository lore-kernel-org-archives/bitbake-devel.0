Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0F6EE642A
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 11:00:41 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83460.1767178836179454483
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Dec 2025 03:00:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dXe1C1QR;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so5401772f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 03:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767178834; x=1767783634; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qG4OvBfppjDY9yE9s6zxju44dxmZjT/swe+9zMt2tLw=;
        b=dXe1C1QRSehmltFftrAYGwMSUxTmdYmZRhDZWDFvR2vV7MEhW9k51Q8UJ4uk+LsvAu
         Qs/q9LguHRgJ4NPED4Xkru/9q72ASRTaBYSsWr2aPjYMfar7UYzg+ichxJiw9TCH9pDK
         nUEREA/PYQq12eKXZhJH4QEEGX/V6lzkrv3kj1XA4Hzl21U0bb1Y+gtOz7BWYniVdUbn
         85gkP0/5TVLLRKewkchIKY1EgtBmbz2q4RzDUD80cCLnOFtCKj+lXtW2vNTDhqQKx5zQ
         /RMjmPbPaafGaWMQGApkHPXWLDspRCLu1y+Tx81F7OF1bTve3g6dKJP2jy3mh/gDzNol
         IpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767178834; x=1767783634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qG4OvBfppjDY9yE9s6zxju44dxmZjT/swe+9zMt2tLw=;
        b=AOueXcGwWRGflxVIsjC4CfnTOb0F0gbXSZFnsjU+LtJ07Z8mR1bShgOLyDolOWaTcj
         VJJvaLpfx9OrCoi8sx+z2g8hrhX/GkGkDXWnxj8GpgNY1T4h+ZD4fnzHgNlkJZAnCiXp
         QHSh1Loky/ldcW/vCZ6Nf6lbmfTNtxPk33laMtEdUyWw/uvy7K4MsRa/whe9eLUxLNTj
         ysREGNkOko8tImKWphBTyXMqZqYOwIewCV/sT9AruNzCFnnc9YurKm3ZZAX8CSSN7Gwk
         SKYtl+U1wIqa9gnW148SNb8hdNqNwdjQq7I8DiTjtPQ5F6QjC3GWeR5+JBbAbh5gUklm
         6mHA==
X-Gm-Message-State: AOJu0YxFqyGB8Di8fEPwQ+tXHK7yOKIJdaA9+al1/hHTDUbOG8WhjBHN
	c2SMlX5bJT0A9gBn/g7qrRuY0kySkRhQkBqCMD3jTjvf2TF0xFc14e74
X-Gm-Gg: AY/fxX5p0t5PURU56+Dh+WE+QuCqffCbKzNaI1m0jl3eEPPWdMLoPpZLkr8NsgTxMOx
	0//Iq8ecyoqo4L13drLAd3dM5pBQ3jcAQgxwkgp7B3o79b9JH6Gd3jQZJ9ocq7ypKU1ap75UVXm
	HZY+I6arvVKQxXQ+KQv7BxK1Qqh3ehPzjvZmHn3K7+xs2zPwaEmPTLlMbfzbMB6L1mLhZOByEAk
	fN6/Tg/8YdlWKQI9hsUpWALj2cNhxtgzX9AI/CoBMAjLn8cCzwmqbUrsBxOzvhilUMHbUWFrYAc
	inSozajlmmDhMmfdK0TWouMa4R6vtKRzbPdTAh/lkEiHN6/weJ9YnXQUkYqn8BL54QSePIPntQK
	5Ld9GSbDFC66lDztKeHy2n+D5ZTIi/nLrZ8yYV+Ly/OTRmuKdKNtiPenkNVGKaKWrewKcMmhF8G
	kY4aUw6wZFEam3yCZKQB7D0gCffyAwtKzsMfueEZlE2/0aTMWiMIUtf0jBBzNdpA==
X-Google-Smtp-Source: AGHT+IEYGbJKIcYlrNiUjs9RucXGXd56Q4WTtC+u8XTjyYdiVB2XVHm9AjFTsnHrI9shJ0iGuYi1Gg==
X-Received: by 2002:a05:6000:2909:b0:431:8da:11aa with SMTP id ffacd0b85a97d-4324e704794mr41382053f8f.59.1767178834335;
        Wed, 31 Dec 2025 03:00:34 -0800 (PST)
Received: from ?IPv6:2a02:169:59a6:0:55c4:f628:91f3:4287? ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325d10cc48sm63287759f8f.16.2025.12.31.03.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:00:33 -0800 (PST)
Message-ID: <55d314c3c6bd3e72c3ff972927dac0169d431982.camel@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] bitbake: add --skip-deps option
 to re-run tasks directly
From: adrian.freihofer@gmail.com
To: alex.kanavin@gmail.com, adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 31 Dec 2025 12:00:33 +0100
In-Reply-To: <CANNYZj_RiybYM31_uwwYZx+kNz_QLs8Ud4yZ1DXfL9RGU1gP-g@mail.gmail.com>
References: <20251230153539.3940266-1-adrian.freihofer@siemens.com>
	 <20251230153539.3940266-2-adrian.freihofer@siemens.com>
	 <CANNYZj_RiybYM31_uwwYZx+kNz_QLs8Ud4yZ1DXfL9RGU1gP-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 11:00:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18667

Hi Alex

On Wed, 2025-12-31 at 10:11 +0100, Alexander Kanavin via
lists.openembedded.org wrote:
> On Tue, 30 Dec 2025 at 16:36, Adrian Freihofer via
> lists.openembedded.org
> <adrian.freihofer=3Dsiemens.com@lists.openembedded.org> wrote:
> > This is aimed at development workflows (for example devtool ide-
> > sdk)
> > where an IDE or developer wants to re-run a single task (such as
> > do_install) and then deploy or debug it on a target without
> > rebuilding
> > or executing unrelated dependent tasks.
>=20
> The patch is horribly invasive, and I'm afraid the premise for it is
> shaky, and should've been discussed here first.

We are discussing this since a very long time. My previous attempt is
here:
https://lists.openembedded.org/g/openembedded-core/message/223669.

With the new attempt I'm trying to follow the advice from Richard to
add a feature to bitbake which allows to address this use case in a
generic way.

>=20
> Can you formulate the problem more specifically? What are those
> unrelated dependent tasks? Why do we want to skip them? They are in
> the dependency tree for a reason: so that configure/compile/install
> can run without error. Even if compile is replaced with some kind of
> IDE-specific re-implementation, it still needs those pieces.

If compile is done by the IDE, there is no need for doing it again.
Resolving the full dependency chain is not what an SDK should do.
That's very important.

Reagrds,
Adrian

>=20
> Alex
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18665):
> https://lists.openembedded.org/g/bitbake-devel/message/18665
> Mute This Topic: https://lists.openembedded.org/mt/116998957/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

