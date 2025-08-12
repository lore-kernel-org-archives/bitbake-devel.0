Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013FCCA0EC4
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 09:07:03 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.69527.1754989620261085537
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Aug 2025 02:07:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WucV6ghm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458baf449cbso50355785e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754989618; x=1755594418; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiERKSaDwHyxU9ktHxljCQdOWa/TRGU9A3cV/Aocjy0=;
        b=WucV6ghmBzVtjKMKed+8ungwJz/FoE/rxkWi9MBZy0vvFTpGBPGnbLiZ5ttapCnK/x
         ryTROFcnrsBasVUO860wLHiEQGwXnbb2Z0Lp3DEEUw2n0njicMOdp8FXcsLBZXGYk2z5
         OGwF3N0gOKS//65X8oySit6trgW1tY/z/cjkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989618; x=1755594418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fiERKSaDwHyxU9ktHxljCQdOWa/TRGU9A3cV/Aocjy0=;
        b=vsQgD4sxWyXLs83SVukh2reV81kzakzGcdb9qsYj0jioMSJE9A/zXuaasZm/BckeYL
         rCPRiwwM1NQqC8QzRgyQKNzuLbHDPFyZhGDLG79bT2RYukz9P0huVsVHySmLxLn7lYL2
         ITjRpKX0CbjmUw0bPaBxRzjm5ZiNIbMMVzLx6SOJFYZRDooEXImnz5gJ3pOTWAv+cKj6
         DqyThTPy3dVXipvvii3Y2D9pGNOMOGtWaiG3nYeBccpuf1x/yZvGaIPHQ93cKed2aPqY
         apNh/pJCs6STq9ZllrUVRZtHzbb1CmsBCFbyW/KvcrOEFVWox0u++6uRCaTX6GaspmjF
         MY2g==
X-Forwarded-Encrypted: i=1; AJvYcCV7EUjbepmluoMP0tcO3TI5feTaSp7N8RMgxuR1Med+ZAoApHUggQiep09MmfO+QSlgorgVT1pJntugDWLi@lists.openembedded.org
X-Gm-Message-State: AOJu0YygnslEbcMQ5Ej69MByTNvbztAWbEIvu1kwmwAl8NB1vMWtu9fn
	8e2B7nUKgGocnJlja1BgHGLQbLFbLF+cDmipTtAMJWPL2tX7vvFCTBXLupgU5qwh2laGZJd14ux
	gFA0I
X-Gm-Gg: ASbGnctqk/ZdJKm9InQr9eUlv0yYjA1dQlzN0Qvp3TDdCXZAcH+dw1/fu3KjEsS299X
	nnkb03IWUd3G8IEq4yPRnzL6WI4HrQ2ErKOyYFM6jEVIABdVFmC4HDp7DIYB269GYKbSbaWOOXz
	Nek/MST1NOyC2NHpReakJ+Ghunrlm4m/FxSbbOsLkzhRVeWyqRbtoaD4B2KjFKsClB3HAfBA2bP
	mAuN5mxLvJw+9+WiNG/xwwq9hVLjjcbRdidH5Yakec/ZG/3ovPd60SbyZqTovT8hqmhNNk+2hJE
	ASn6PxJu3LbO5Dh3VZCEcY+6l6RW57as/U0J3U5aeJzfnHjyOHNU5n/JVW3TYAfoalOvm0BcF1G
	IeOWLOmIRbtRv1S/0W1GCTG9tgeyRNGLw6fIJfoo+UnektpqOztgXO5XZDRXb3737rNz4AMInfs
	4/bTjgV8vIYpY=
X-Google-Smtp-Source: AGHT+IFtq+joV4N61ZW4PKZ1Mgv0tO2SsGRbPei0+UhrTaxaZ+51+Td6UUtn3rxteEfQRH/YqeSTqA==
X-Received: by 2002:a05:600c:1f1a:b0:459:d4b5:623a with SMTP id 5b1f17b1804b1-45a10ba2d7dmr25092015e9.9.1754989618466;
        Tue, 12 Aug 2025 02:06:58 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:89f2:883f:9153:ef6b? ([2001:8b0:aba:5f3c:89f2:883f:9153:ef6b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm44074217f8f.66.2025.08.12.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:06:57 -0700 (PDT)
Message-ID: <f371c3b26e57f5dfad8b5ee109e1eab8852d6095.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd'
 arg from check_for_interrupts
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, "mathieu.dubois-briand@bootlin.com"	
 <mathieu.dubois-briand@bootlin.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 12 Aug 2025 10:06:56 +0100
In-Reply-To: <DM8PR12MB543077160D85EADD9D5654358B2CA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250806145308.2052128-1-chris.laplante@agilent.com>
	 <20250806145308.2052128-2-chris.laplante@agilent.com>
	 <DBW0984EY1IE.31I0NJ43GU7N7@bootlin.com>
	 <DBW0AL5OM8CZ.1J05XYFYPMZ20@bootlin.com>
	 <DM8PR12MB543077160D85EADD9D5654358B2CA@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 09:07:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17867

On Thu, 2025-08-07 at 12:52 +0000, Chris Laplante via lists.openembedded.or=
g wrote:
> Hi Mathieu,
>=20
> > > Hi Chris,
> > >=20
> > > Thanks for your patches.
> > >=20
> > > It looks like this is breaking several builds on the autobuilder, wit=
h
> > > the following error:
> > >=20
> > > Removing 12 recipes from the aarch64 sysroot...ERROR: Execution of
> > > event handler 'sstate_eventhandler_reachablestamps' failed Traceback =
(most
> > recent call last):
> > > =C2=A0 File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/meta/classes-global/sstate.bbclass", line 1301, in
> > sstate_eventhandler_reachablestamps
> > > =C2=A0=C2=A0=C2=A0 bb.event.check_for_interrupts(d)
> > > TypeError: check_for_interrupts() takes 0 positional arguments but 1
> > > was given
> > >=20
> > > ERROR: Command execution failed: Traceback (most recent call last):
> > > =C2=A0 File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
> > > =C2=A0=C2=A0=C2=A0 self.cooker.updateCache()
> > > =C2=A0 File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/cooker.py", line 1653, in updateCache
> > > =C2=A0=C2=A0=C2=A0 bb.event.fire(event, self.databuilder.mcdata[mc])
> > > =C2=A0 File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/event.py", line 232, in fire
> > > =C2=A0=C2=A0=C2=A0 fire_class_handlers(event, d)
> > > =C2=A0 File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/event.py", line 131, in fire_class_handler=
s
> > > =C2=A0=C2=A0=C2=A0 execute_handler(name, handler, event, d)
> > > =C2=A0 File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/event.py", line 102, in execute_handler
> > > =C2=A0=C2=A0=C2=A0 ret =3D handler(event, d)
> > > =C2=A0 File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/meta/classes-global/sstate.bbclass", line 1301, in
> > sstate_eventhandler_reachablestamps
> > > =C2=A0=C2=A0=C2=A0 bb.event.check_for_interrupts(d)
> > > TypeError: check_for_interrupts() takes 0 positional arguments but 1
> > > was given
> > >=20
> > > Can you have a look, please?
> > >=20
> > > Best regards,
> > > Mathieu
>=20
> Thanks for catching that. I forgot to check for usages in bbclasses.=20
>=20
> I'll work on a v2.

Requiring flag days for changes like this is a bit of a pain. Since
there was a much bigger change going in, I've just taken them together
with that and bumped versions but in future, we may want to make the
parameter conditional, or add a try:/except: in the oe-core code so
that there isn't a lockstep change needed.

Cheers,

Richard

