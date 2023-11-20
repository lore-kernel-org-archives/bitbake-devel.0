Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64076C2BB3F
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 15:36:30 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.53193.1700494580586837057
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 07:36:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZL176Hsm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so3013553f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700494579; x=1701099379; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F6L//t4Rb6okg4Stj+4RlmSLifLBY/afbulk8RXkk/M=;
        b=ZL176Hsm1TO4c7oL0YexT+GYayM6OVm61qyNyGy5Mb9OuTyW+9tJ5+hQirTW4UEd4A
         4wK8kVJfYt0vPKTp6y1IpT40+VfugrdXWIk0GSr0WIgZTpCLsk26Mz1kZFAP7RrSDYhs
         q0J7sqtdwAOiVkGk+2bkgvkcpz+XoLcH0ezIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494579; x=1701099379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6L//t4Rb6okg4Stj+4RlmSLifLBY/afbulk8RXkk/M=;
        b=iDpsQblZ6AUGMRjTSYHNAncXIj86y1uDzbdf6W1zC5AzUcZRIy320Iv1LD2BPAbC94
         uCn16jnqM5kFdMvhgaZnd19TQ2yBAG22fYHxVo2JttkPqP7l0VsIBcDM8GejqNS6xl27
         A/ihsLExC5CHJcRQ1judrHruuiKBBy60e4d7NEMZCXtqPthZ9nDD5lvNRaplYJ1siNxW
         rZAHUmIbZFYRXttvtj8bHzpjGeI06iLXMXWDVqIBXnceh3TrxqiiGa0aNo5jJnljTK9f
         uUTBTrqSPxxpaOgdmHpdWD6D/kcpUalNISR3BvhPDR+RfKM6L/85L9ldOysHhh/4NhNk
         Ueqw==
X-Gm-Message-State: AOJu0YxnddB59un/xWLdS0ApITmWf094tRcYiKrKCItbuK5oIPZ4gRiM
	uxMTHm8hVNb47P5Zps6pGfiWWg==
X-Google-Smtp-Source: AGHT+IGhxrJJOB2gns8ydGTyGGC3PYzZlaN4+jEE6esB0P3MLrNQyaxd0mN49dJo8YbPve+UrPaLlA==
X-Received: by 2002:a05:6000:402a:b0:332:c4f7:1f83 with SMTP id cp42-20020a056000402a00b00332c4f71f83mr3132683wrb.7.1700494578871;
        Mon, 20 Nov 2023 07:36:18 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:503c:cf74:300f:8e26? ([2001:8b0:aba:5f3c:503c:cf74:300f:8e26])
        by smtp.gmail.com with ESMTPSA id f18-20020adfdb52000000b00332cbda1970sm890745wrj.30.2023.11.20.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:36:18 -0800 (PST)
Message-ID: <d27a565ef33973d7a195b1d480e1480b6a4e38ab.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] npm/npmsw fetchers: Support for "offline"
 builds?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christian Eggers <ceggers@arri.de>, Markus Niebel
	 <Markus.Niebel@ew.tq-group.com>, Martin Jansa <martin.jansa@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 20 Nov 2023 15:36:17 +0000
In-Reply-To: <2178448.Icojqenx9y@n95hx1g2>
References: <4851356.GXAFRqVoOG@n95hx1g2>
	 <70e7245a5f6b37f9045027f90c665c244a28a234.camel@ew.tq-group.com>
	 <CA+chaQeFGqnDbKav6JbXOO4ouqEVDvUNofuhM5A_+t7dv9n81A@mail.gmail.com>
	 <2178448.Icojqenx9y@n95hx1g2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 15:36:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15541

On Mon, 2023-11-20 at 14:25 +0100, Christian Eggers wrote:
> On Monday, 20 November 2023, 14:14:32 CET, Martin Jansa wrote:
> > On Mon, Nov 20, 2023 at 2:01=E2=80=AFPM Markus Niebel
> > <Markus.Niebel@ew.tq-group.com>
> > wrote:
> >=20
> > > Am Montag, dem 20.11.2023 um 13:19 +0100 schrieb Christian
> > > Eggers:
> > > >=20
> > > > Hi Alex,
> > > >=20
> > > > On Monday, 20 November 2023, 12:05:28 CET, Alexander Kanavin
> > > > wrote:
> > > >=20
> > > > >=20
> _______________________________________________________=E2=80=8B
> Christian	=C2=A0
> Eggers
>=20
> Software=C2=A0Engineer
> =E2=80=8B
>=20
>=20
> ARRI
> Arnold=C2=A0&=C2=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0GmbH=C2=A0&=C2=A0C=
o.=C2=A0Betriebs=C2=A0KG=C2=A0
>=20
> Arriweg=C2=A017	,=C2=A0
> 83071	=C2=A0
> Stephanskirchen
>=20
>=20
> www.arri.com=C2=A0
>=20
> +49=C2=A08036=C2=A03009-3118
> CEggers@arri.de
>=20
>=20
>=20
>=20
> =E2=80=8B
>=20
> SkyPanel X
> Get=C2=A0all=C2=A0the=C2=A0latest=C2=A0information=C2=A0from=C2=A0
> www.arri.com,=C2=A0Facebook,=C2=A0Twitter,=C2=A0Instagram,=C2=A0LinkedIn=
=C2=A0and=C2=A0YouTube=C2=A0and=C2=A0
> X.
>=20
> Arnold=C2=A0&=C2=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0GmbH=C2=A0&=C2=A0C=
o.=C2=A0Betriebs=C2=A0KG
> Sitz:=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Registergericht:=C2=A0Amtsger=
icht=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Handelsregiste
> rnummer:=C2=A0HRA=C2=A057918
> Pers=C3=B6nlich=C2=A0haftender=C2=A0Gesellschafter:=C2=A0Arnold=C2=A0&=C2=
=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0Gm
> bH
> Sitz:=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Registergericht:=C2=A0Amtsger=
icht=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Handelsregiste
> rnummer:=C2=A0HRB=C2=A054477
> Gesch=C3=A4ftsf=C3=BChrer:=C2=A0Dr.=C2=A0Matthias=C2=A0Erb=C2=A0(Chairman=
);=C2=A0Lars=C2=A0Weyer;=C2=A0Stephan=C2=A0Sch
> enk;=C2=A0Walter=C2=A0Trauninger
>=20
> =E2=80=8B
>=20
>=20
>=20
> On Mon, 20 Nov 2023 at 11:59, Christian Eggers <ceggers@arri.de>
> > > > wrote:
> > > > >=20
> > > > > > When having NPM based application in my SDK (e.g. quicktype
> > > > > > [1],
> > > > recipe is
> > > > > > attached), the "fetch" tasks perform a full build of nodejs
> > > > before starting
> > > > > > the actual download of the quicktype sources. But building
> > > > > > nodejs
> > > > (and its
> > > > > > dependencies) during the "fetch" stage, compromises my wish
> > > > > > to
> > > > perform the
> > > > > > actual build in an offline environment.
> > > > > >=20
> > > > >=20
> > > > > I'm not sure I understand what is being compromised here. If
> > > > > you
> > > > want an
> > > > > offline build, throw away the sstate cache that was created
> > > > > in the
> > > > fetching
> > > > > step, and nodejs will be again rebuilt together with
> > > > > everything
> > > > else.
> > > >=20
> > > > my intend is to run as few build scripts as possible as long as
> > > > the
> > > > build
> > > > machine has access to the internet. For security reasons I
> > > > would like
> > > > to divide
> > > > the build into two stages, one stage for downloading (with
> > > > internet
> > > > access enabled)
> > > > and one stage for compiling (without internet access).
> > > >=20
> > > > While I highly trust the OpenEmbedded/Yocto projects, I fear
> > > > that
> > > > single upstream
> > > > projects may become targets for supply chain attacks in the
> > > > future.
> > > > Running
> > > > the package Makefiles/scripts etc. on a machine (e.g. docker)
> > > > without
> > > > network
> > > > access reduces the possibility for manipulated packages to
> > > > retrieve
> > > > internal
> > > > secrets and upload them to the internet.
> > > >=20
> > > > Are there any other use cases why people want to perform an
> > > > "offline"
> > > > build?
> > > >=20
> > >=20
> > > At least offline builds are useful for release builds to make
> > > sure no
> > > recipe tries to bypass the normal fetch logic. We saw this
> > > several
> > > times in the past with silicon vendor stuff - recipes tried to
> > > fetch
> > > things during configuration or as part of compilation.
> > >=20
> > > Another thing I can imagine are builds against an internal
> > > PREMIRROR
> > > for several reasons.
> > >=20
> >=20
> > Yes, but bitbake and oe do that automatically (even in "online"
> > build) now
> > with following changes:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bitbake can now restrict network access i=
n various tasks based
> > on
> > "network" flag as implemented in:
> >=20
> > https://git.openembedded.org/bitbake/commit/?id=3D0746b6a2a32fec4c18bf1=
a52b1454ca4c04bf543
> >=20
> > https://git.openembedded.org/bitbake/commit/?id=3D9d6341df611a172509044=
4f6f8eb0244aed08213
> > =C2=A0=C2=A0=C2=A0=C2=A0and oe now enables network mostly only in do_fe=
tch and few
> > special
> > tasks as implemented in:
> >=20
> > https://git.openembedded.org/openembedded-core/commit/?id=3D7ce1e88a3ad=
85bbb925bb9f7167dc0a5fd1c27f4
> >=20
> > so unless your evil vendor doesn't enable network flag on (m)any
> > tasks,
> > they shouldn't be able to bypass the normal fetch logic.
>=20
> If I had known all this before, this would have saved me some time
> for the
> complex setup of my (docker) build pipeline ...
>=20
> With my concrete intend to improve security on my build machine,
> being able
> to ensure/enforce this behavior would be great
> (bb.utils.disable_network only
> produces a debug message if unshare() returned an error).

When we implemented it, some of the commonly used distros we build on
don't support it so we couldn't hard require it. I'd imagine that will
change over time as the support improves. This was a compromise to
allow us to improve but not force everyone into upgrading their host
systems.

Cheers,

Richard

