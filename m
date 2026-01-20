Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D938ED262A8
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 22:13:52 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18646.1768947226774039977
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 14:13:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KARPfXTC;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fed090e5fso3435928f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768947225; x=1769552025; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TJib69G+VzH2CM1aRZY4nVLzfl23tVABPzvYr2cvZY0=;
        b=KARPfXTCdYtB6TP0S0vvzFUCH8qe6vBg8eX/Zbw0yEwFMQB0tB0RDhSGgsZQUYmfca
         Rs0Q/MXZawkV5GGpW4XtouqnpPyrY/+pLg/0iYnNEJVDmb05eqxx98ARwkAIWf6/905l
         yef5daDBIE8cni7415aaXfaPWnPVwupu4s22EHmNBq58MVZhU4VTDc/f9UJx/7tVmf79
         ryiHxJEroOG7ATOAA6DJ8jCB0qA7ZvVXekSD7Ms4LMHk+J6PaQM3++pgMzz7NORZXL/L
         XH4EFmIKSThUdcPj2Iq7/A7edz1liQnl2XYunCgjHpD9LZjbgiAddZsLqjSocIY/pJoX
         fQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768947225; x=1769552025;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJib69G+VzH2CM1aRZY4nVLzfl23tVABPzvYr2cvZY0=;
        b=DXhbgP2VdYBo+1yBc/8p8ilAWfMR6ksGjlUuLum2P9vtcR+yovtJKBLjJ9St5XdemV
         OonLpXEIwAwzrGzMccw+WjWPfILE2jVZ1iTaxrsamJCnrEDM6asWGEaVMDyZ5iN+rQwQ
         g11HR92GCc1k0lXhi2QGljp1d8ukGWgj5gs4JBjziGneYxQdQ/VoAz3aIawP+5ZulnGO
         faTOc5hxLETUGOnLV0zVqgOcf9BqtksaKYmwMzD51aSOWL2T583mjU0ahtetaUl/5b2r
         YIO2eZFqhuZLW6DRpuptFCs2PPFfsia62Kmh5y9BcPoqD10w89szS680B07vgYFVaBg6
         7GRg==
X-Gm-Message-State: AOJu0Yx19n25R4VJo3HovpNir14Ubfd0/f24eTZhhuAm34g7DxhZZdB7
	qxlUZVl3i6LbuQaDzo5ECcOyZBuk/6NIS0Xu5KMyGKlfXERnyqqJE/T/
X-Gm-Gg: AZuq6aLIo0UvrzaFFDBII3nqiFVRKgpU7PqTqoilPLpu0WIZtWDGM2GoYOf17wqXnPw
	VJwuihtd47bhuw1s+T2dyY6soKM6R80yslbQqZugGczWNMdrObQV/J8xXprArRUUMDeLRXDYfrH
	ibBXiqZNhujwc5AQCdZf20qT+WARSIS3rjMJ/x+AelbikBRUtqDLtSkYwzk5pQ2/6wVA2w7z5EQ
	00RK9aQMDbiildJgunM7ReudqSMx1DJzaiYzkgvFRi4SVjr7SqomaZx37Ubsju3Kixax+BJCzUN
	w9sMI93KfCRMUyHGFHmNrrhiIX0tAZBh8dHIXnAvFlLe+wyTqpSzTEQZ6SXwBws2BzB6WR0A2+C
	TGzYse9gtHU8MizgG4mCa8vqWhz6+1Yc7RiED/Rv+l81/wXOEwWvyyk6cVPW0sYnqQmtetdHVA/
	bObefGVXB0hfELyAKpxWr0WGTFyWvHIMqjrpH3hFq5cBNJD0o4JvQ1Tm8MvzZu
X-Received: by 2002:a05:6000:3102:b0:432:85eb:a3cc with SMTP id ffacd0b85a97d-4356998c538mr21848903f8f.19.1768947224902;
        Tue, 20 Jan 2026 14:13:44 -0800 (PST)
Received: from ?IPv6:2a02:169:59a6:0:55c4:f628:91f3:4287? ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cf58sm32325177f8f.22.2026.01.20.14.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:13:44 -0800 (PST)
Message-ID: <daaeb2e7bbdd85c5ec6861f0129048b5e1810412.camel@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/2] bitbake-setup: Add VSCode workspace
 generation support
From: adrian.freihofer@gmail.com
To: alex.kanavin@gmail.com, adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Jan 2026 23:13:43 +0100
In-Reply-To: <CANNYZj9rLfTy2A7P-CbEuM4uEqOELqABCPJc_XQXr3W6R5e18w@mail.gmail.com>
References: <20260119073419.952608-1-adrian.freihofer@siemens.com>
	 <CANNYZj9rLfTy2A7P-CbEuM4uEqOELqABCPJc_XQXr3W6R5e18w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 22:13:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18822

Hi Alex

It looks like this patch series was just killed by your latest commit

  bitbake-setup: correct several scenarios in layer updates

  ... Yes, the user should've used -L option to symlink a local
  clone=C2=A0from elsewhere; this advice doesn't help when their work
  is=C2=A0gone.

I was not aware of the -L option until now. The idea for this series
was to configure VS Code to edit the Git repositories in the layers
directory. Now bitbake-setup informs me that I must not do that. But if
I have to clone the layers manually, why should I use bitbake-setup at
all? Not sure we can find an easy solution for this.

A completely different idea would be to enhance the VSCode Bitbake
plugin to handle bitbake-setup registries on its own. The user would
just enter an URL like
https://git.openembedded.org/bitbake/tree/default-registry/configurations/p=
oky-master.conf.json
and VSCode would handle the json file and download the git repositories
independently from bitbake-setup. That would solve a bunch of issues:
IDE users do not need to bootstrap their environment via command line.
There is also no need to clone bitbake just to get bitbake-setup for
cloning bitbake again.

I need to think about that, but spending a lot of time on bitbake-setup
and VS Code without a usable workflow so far suggests that something
isn't working.

Regards,
Adrian


On Tue, 2026-01-20 at 12:57 +0100, Alexander Kanavin via
lists.openembedded.org wrote:
> Hello Adrian,
>=20
> the approach looks good, but the changes are not small, and I need to
> set aside a bit of time to give it a proper review. I'm now trying to
> fix some of the more difficult autobuilder issues we've been having
> with newer distros (f43, ubuntu 25.10). I'll get to it.
>=20
> Alex
>=20
> On Mon, 19 Jan 2026 at 08:34, Adrian Freihofer via
> lists.openembedded.org
> <adrian.freihofer=3Dsiemens.com@lists.openembedded.org> wrote:
> >=20
> > From: Adrian Freihofer <adrian.freihofer@siemens.com>
> >=20
> > This patch series introduces automatic generation of VSCode
> > workspace
> > configuration files for bitbake projects created with bitbake-
> > setup. The
> > feature enhances the developer experience by automatically
> > configuring a
> > multi-root workspace tailored for bitbake development.
> >=20
> > The implementation generates a `bitbake.code-workspace` file that
> > includes:
> >=20
> > - Multi-root workspace structure with all layer repositories and
> > the build
> > =C2=A0 configuration directory as top-level folders in the VSCode
> > explorer
> > - Pre-configured BitBake extension settings (paths to bitbake
> > folder, build
> > =C2=A0 folder, environment script, etc.)
> > - File associations for `.conf` and `.inc` files mapped to the
> > bitbake
> > =C2=A0 language
> > - Python analysis paths automatically discovered from layer `lib/`
> > and
> > =C2=A0 `scripts/` directories
> > - Sensible exclusion patterns for `.git` and log directories
> >=20
> > The workspace file is placed at the setup directory level, outside
> > any
> > version-controlled repositories, avoiding repository clutter while
> > providing
> > a centralized configuration for the entire project.
> >=20
> > Adrian Freihofer (2):
> > =C2=A0 bitbake-setup: generate config files for VSCode
> > =C2=A0 bitbake-selftest: add test for VSCode workspace generation
> >=20
> > =C2=A0bin/bitbake-setup=C2=A0=C2=A0=C2=A0=C2=A0 | 198 +++++++++++++++++=
++++++++++++++++++++-
> > ---
> > =C2=A0lib/bb/tests/setup.py | 201
> > ++++++++++++++++++++++++++++++++++++++++++
> > =C2=A02 files changed, 384 insertions(+), 15 deletions(-)
> >=20
> > --
> > 2.52.0
> >=20
> >=20
> >=20
> >=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18816):
> https://lists.openembedded.org/g/bitbake-devel/message/18816
> Mute This Topic: https://lists.openembedded.org/mt/117341468/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

