Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36942CCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 15:07:27 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11821.1762355245254244420
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 07:07:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ZXF2OaIQ;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F14401A18BD
	for <bitbake-devel@lists.openembedded.org>; Wed,  5 Nov 2025 15:07:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C02FF60693;
	Wed,  5 Nov 2025 15:07:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 041E410B520D4;
	Wed,  5 Nov 2025 16:07:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762355242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GuEfCj6CwEnmyrrId2imZo9SSzPuSD2rSF1SGt8QerQ=;
	b=ZXF2OaIQdszQ7ay/9GUbW96NQdu54ZcxcnXp2R+D0tlLfgh+IoOw+3vSHhcTRv3r4obtJK
	QGdG+zmxLcyfqaPKB2LUhIvM5E9PSNNb96NWfSyesWhKJT51IOcuLt3TaW6dk+6jsE753s
	vACyVqZ/+fbFPj4lE65VNRjESjPZwP3e4yMXWlB2MP+W8BGjTqXLM5QRqodi1F4WF9X74T
	6L8GdmWI5VDBmULTzIH3fT3V0rw3HBPrytFRl+FF7ju+1ymz0DxHQ9zKJOBmjtnruAamdx
	mqHU5SRVjMt+OpVKy4zetJ7Ur38PX7GPxoCH5/FjfJAe4HOAwnul6CtwDlfUYQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 16:07:20 +0100
Message-Id: <DE0USKLW9WXP.3MKV2P4AI36E1@bootlin.com>
Subject: Re: [PATCH 2/2] Add bitbake-setup documentation
Cc: <bitbake-devel@lists.openembedded.org>, <docs@lists.yoctoproject.org>,
 <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Johannes Schneider" <johannes.schneider@leica-geosystems.com>,
 <alex.kanavin@gmail.com>
References: <CANNYZj8p5zTnzo3AO88_c7Q=qDtO1-QWaFNh+z37xLX4Y1H8Bw@mail.gmail.com> <20251104151156.3125937-1-johannes.schneider@leica-geosystems.com>
In-Reply-To: <20251104151156.3125937-1-johannes.schneider@leica-geosystems.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 15:07:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18266

Hi,

On Tue Nov 4, 2025 at 4:11 PM CET, Johannes Schneider wrote:
> Hoi,
> some minor findings and suggestions:
>
>> +   :term:`Top Directory`
>> +      The top directory is the place under which ``bitbake-setup`` read=
s and
>> +      writes everything. ``bitbake-setup`` makes a promise to not touch=
 anything
>> +      outside of that directory. The location of this directory can be =
changed
>
> ... except for the global settings, or when instructed to - e.g. dl-dir=
=3D/some/where/else
> would it make sense to not make promises, and just call it the working di=
rectory, where (most) things end up in, unless configured otherwise?
>
>
>> +To illustrate, this will translate to the following hierarchy::
>> +
>> +   Top Directory
>> +   =E2=94=9C=E2=94=80=E2=94=80 Setup 1
>> +   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 build
> =20
>       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 config
> the git-versioned 'config' directory could also be mentioned?
>
>> +   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 layers
>> +   ...
> =20
> =20
>> +      The registry location is configured through the
>> +      :ref:`ref-bbsetup-setting-registry` setting. This location can th=
e URL to
>> +      a Git repository,
>
> ...location can be the...
>
>> +      this could the location of the configuration registry, or where t=
he
>
> ... this could be the ....
>
>
>> +The ``bitbake-setup`` command
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> could we add an "Examples" section, that shows of some more complicated (=
and possibly common?) command invocations?
> e.g. a one-liner:
> ./bitbake/bin/bitbake-setup \
>     --setting default top-dir-prefix /tmp/bitbake-setup \
>     --setting default top-dir-name acme \
>     init --non-interactive \
>     --source-overrides /tmp/registry/2025-11-01/sources-state.json \
>     /tmp/registry/gadget_master.conf.json \
>     gadget distro/gadget machine/gadget

Thanks Alex and Johannes for the suggestions and corrections. A v2 should b=
e out
soon!

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


