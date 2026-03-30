Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F57FB3CF8
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 10:17:49 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47673.1774865860280442018
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Mar 2026 03:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UNMPAQSt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b41b545d9so4692687f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774865858; x=1775470658; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22tuyZh++x8fT/Q9plIksfQhQvCcpxzSWxV6B53exUU=;
        b=UNMPAQSts35oEXz5ryy0lCcQBLOV5h2maxh/1cDYr4S6RM/zdl57x5sDXvnSE7kCB0
         HqHgQ976Xii+hrQELWw8x8LMfn0uPq0DyXvTzZwRYHyC3BdjwhKHhh1qLj/xC8pNzH60
         DGLFpaYrPmQi7sIEpOHsWJn21jg6R4kN79CeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865858; x=1775470658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22tuyZh++x8fT/Q9plIksfQhQvCcpxzSWxV6B53exUU=;
        b=dutS1P8dHQM+mEXLNB8h/vCGPcUxLI8kIqxPKo3Q6YdbwVLqVYczvWDDrJTZOevVA7
         Kf6DUQGN5JgeEUrsbfDkVgqLAiClpk0rxdgjUR2JLO4AF2RAZAkrK5ZBBnsUGaVHUQax
         ACWX9lNCodd0R5lWAiip677IGbTfvkCHGFyJyJeLirKDaFLS70XuyYHZXTUkoD3UfuOQ
         juOfaGpAhlKPAkp08rzITugPKEfMFWpuqUE1VpyvDBc14PFK5U0ghjx9phi7ubc23t0x
         fAkXK7Yco77/yrn0imvIx1zSOBQJxjEfIN+2Nqn1dyUMbtXXdGrvfCfBaCsqaNJ4/qYc
         uveQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlPRs/6P4humI8LlhPRYtE4EG3bNsVuc6PEeupigGC0WEY+K7Qudw7NlpaDAczSuLZIUs5yKUftIBBPpq+@lists.openembedded.org
X-Gm-Message-State: AOJu0Yywlh8m0c/zadxg1GWF19wbMvasQhs3wqye3WgrpHp8XrioCmLQ
	A0dXgSQxoTpl/O+/ptmbsc5+y95PIEs+YvS7KoRuI37WDZjo8PQ3wV5XCqsSjZ7fgAc=
X-Gm-Gg: ATEYQzxKeCdWVo4bfTgOrd70Xtmuf1Na8xrymrZnEYr/fIfKi5cqYjH6chyhg5+ybOw
	cZhujKitmeM/6Aonh7GrXa555o6t6ZtxxisaHGHVLdbRlLcTEXgX/3RxVmSc4C1vs1vh3cOFYHf
	N7KQG1wwMBDa8aQGN5OMYBxIop/7Gj99WmeHXA3SLK9LbcaC7n1Z4XQA1+CCdlIK6jylIB6+t5g
	wrSSzXUrraDnC5ttvKie24g+u1luWRACEA0YAeT868CZTqixIrseZpUwkyI8dIehYo2FrwHWyAJ
	NnDFCne5tWLgCo8MAGze8I7v+ptT802/D4XzR7/8H3XGCvFyX7ORxIqj7BoCzKOnR5LQVXSyXcj
	GTD5VWw8L5DBF7fTnPLYFvF0nbZ2kjqNzQXJSTpqA1chUq1ToXFVL8By9/sjvpX0z3zi2WUjbnr
	wdsVrwMEjW8d8ktD6VC2fSakgGWxcCfCKyNksYedeWmbauEMcURityfS9jjzHbv8HFjcFpo+Zsb
	myf1sghBQHxpmSI
X-Received: by 2002:a05:6000:4010:b0:43c:fe7a:4917 with SMTP id ffacd0b85a97d-43cfe7a4bf8mr5412977f8f.2.1774865858061;
        Mon, 30 Mar 2026 03:17:38 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:49bb:fc1a:471d:cb37? ([2001:8b0:aba:5f3c:49bb:fc1a:471d:cb37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm18694604f8f.30.2026.03.30.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:17:37 -0700 (PDT)
Message-ID: <652ec352c81776b9facec797e78fddac0a95c643.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/14] bitbake-setup: improvements,
 VSCode workspace generation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Freihofer, Adrian" <adrian.freihofer@siemens.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 30 Mar 2026 11:17:36 +0100
In-Reply-To: <e1fe66216b8b426198689c8acf27fb1c21daa800.camel@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
		 <565cf6848e8f3c0f9e626a61e27cb7ed482fe33f.camel@linuxfoundation.org>
	 <e1fe66216b8b426198689c8acf27fb1c21daa800.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 10:17:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19280

On Mon, 2026-03-30 at 09:01 +0000, Freihofer, Adrian wrote:
> On Mon, 2026-03-30 at 08:09 +0100, Richard Purdie wrote:
> > On Sun, 2026-03-29 at 20:32 +0200, Adrian Freihofer via
> > lists.openembedded.org wrote:
> > > From: Adrian Freihofer <adrian.freihofer@siemens.com>
> > >=20
> > > Changes from v2 to v3:
> > > - Rebased on master-next from 29.3.2026:
> > > - New commit:
> > > =C2=A0 bitbake-setup: Fix type annotation for descriptions parameter =
in
> > > print_configs
> > > =C2=A0 might be squashed into commit on master-next
> > > - New exception: bb.fetch2.RebaseError
> > > =C2=A0 - Adapted tests accordingly
> > > =C2=A0 - Simplified code in bitbake-setup accordingly
> > > - New commit:
> > > =C2=A0 bitbake-setup: catch unexpected exceptions and show a clean er=
ror
> > > message
> > > - Documentation
> > > =C2=A0 - git fetcher unpack_update
> > > =C2=A0 - bitbake-setup non destructive update mode
> >=20
> > Sorry Adrian, this caused an issue on the autobuilder:
> >=20
> > https://autobuilder.yoctoproject.org/valkyrie/#/builders/5/builds/3443
> > https://autobuilder.yoctoproject.org/valkyrie/#/builders/92/builds/3471
> > (and probably a few more)
> >=20
> > Traceback (most recent call last):
> > =C2=A0 File "/srv/pokybuild/yocto-worker/qemuarm64-
> > tc/build/repos/bitbake/bin/bitbake-setup", line 49, in <module>
> > =C2=A0=C2=A0=C2=A0 def print_configs(prompt: str, choices: list[str], d=
escriptions:
> > list[str] | None =3D None):
> > TypeError: unsupported operand type(s) for |: 'types.GenericAlias'
> > and 'NoneType'
> >=20
> > python version specific?
>=20
> It's the first patch which adds only this little (as I just learned
> problematic) detail. It requires Python 3.10+.
> Would you like to try this series without patch
>=20
> [PATCH v3 01/14] bitbake-setup: Fix type annotation for descriptions
> parameter in print_configs

I've tried this and it is looking much better, thanks.

Cheers,

Richard

