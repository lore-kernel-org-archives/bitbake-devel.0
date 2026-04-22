Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912AF9B609
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 10:19:28 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.79150.1776853167620728539
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Apr 2026 03:19:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dYz9oelu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d75312379so3924397f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776853166; x=1777457966; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KtDQVPYpwTbMYlScB3Puz6m3D2wmjHxSMxiS8o1yBXA=;
        b=dYz9oeluza06m2qlB2g7Gv7DxlZGs2gpmtmYaEzYlN87U8qVdCUhBxrJu+mZfjEA52
         AWf8DBToqVvLfWCBQN3NSgDI/SbA1R2r+temfhm7fyXQMIYd1wgowGgEAefyycXfXImx
         fczLSYiqsiNgU8eoGBisECuV4TTc+TuSMVKhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853166; x=1777457966;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtDQVPYpwTbMYlScB3Puz6m3D2wmjHxSMxiS8o1yBXA=;
        b=sRVX1PMR492o32BgnCfErkAaTC2NsxSojnqNrhfvCDGrcGQqg12S5dmqiu4c2AVGeE
         9/bO7vO4fP6NBObNqKvt6rRf5YaDQJzud3OvYofeYlgqYHkdcGEEq5LC/+oPAsm3LAk/
         m7VNXd7JviMxwzpXQDDyKE+yO9qqzEgPm2vdLL4rSWePetMhbpwuQlOVXtzlCKJQQiqs
         o58AVCD+rQzim/T4NiOof/BbcRHSagfZqSmxfvIqKoaPDsr8DJQd0kWOTNtej5CC8n8n
         CC26iiTwLNC5dlbh7UI8Km8GvZhidPk29Px31PBTZtIgDg+2P41xl8Jm2gxaXG6J0Jty
         WMCQ==
X-Gm-Message-State: AOJu0YyMvkCg6KSfo7zJRPeniOUCdPucAtdHMKCXy2XUmjplwDBTdDAj
	9MoNvDOC9wnhVqG3qDAXF06V1xQLvL9PKbdALDNu3PmM8Kooy2gl7aZeo9UyPpJUrSY=
X-Gm-Gg: AeBDievWnRAkiB8yW8E7j4w+ojAPjR26Ix5M8i1JDTJD8ohFKLFPATVrmhR3W+ndqOf
	AlmROk2B5grldC51VnUW0j3l8rxt/+OSusFRvF48XunJtMOxgHME4WEyew9ylVALF0krNNcuvdD
	/W92gQ/9AGyoKlPTLPyArH8WKticHmJ6jXoXGCXQ3HoW9GsvvVkPsF4ulUjYna3zBzJVA2NjSUE
	Q45c3HSKZ9UsOZP4guqaBQKjv07/SNC01u+sVKmVomn+sSZx3W8kPJv1fJqPJX9msd4wkb4s1Qf
	md0gFuKGxbv9vvL4tailSN+x3xGrf+mBeAzXswEx7uqgHunUxVRlKPUlLE4XPyBTuHfKBkVO2mF
	5CbKHPdtLH5Mmz1cDX5pdJF5B0L+uOFeZTnrdmxvZRRe+4zW+CzGVrPAD9YBlK5wqanIiMZwiEm
	piNV3m1nTp/C+1HrpZc3+NwUANh1Gr7kOVC6kX+ounYzP55+0XPVMvJ9i3hmYiorLpyyNdIcoSl
	HnOdt9Rt7nPXj3vsOcuGIa5Fyic5pxmhxMMgw==
X-Received: by 2002:a05:6000:2505:b0:43d:1598:2d6e with SMTP id ffacd0b85a97d-43fe407c3camr34182655f8f.20.1776853165793;
        Wed, 22 Apr 2026 03:19:25 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a9c6:3deb:bd01:ef01? ([2001:8b0:aba:5f3c:a9c6:3deb:bd01:ef01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4ffa8sm45647195f8f.35.2026.04.22.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:19:25 -0700 (PDT)
Message-ID: <9e395359d0cba6898d50451c0355861d45e7bb1f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] default-registry: Update whinlatter ->
 wrynose
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Apr 2026 11:19:24 +0100
In-Reply-To: <CANNYZj8jK1aNNsDufo3y3_Dd95VrAFCdu32OfykMzRuPdxmouw@mail.gmail.com>
References: <20260422091826.135946-1-richard.purdie@linuxfoundation.org>
	 <CANNYZj8jK1aNNsDufo3y3_Dd95VrAFCdu32OfykMzRuPdxmouw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 10:19:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19376

On Wed, 2026-04-22 at 11:39 +0200, Alexander Kanavin wrote:
> On Wed, 22 Apr 2026 at 11:18, Richard Purdie via
> lists.openembedded.org
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> >=20
> > Add the new release, replacing whinlatter which it supersedes.
> >=20
> > =C2=A0...onf.json =3D> oe-nodistro-wrynose.conf.json} | 16 +++++++-----=
--
> > =C2=A0...atter.conf.json =3D> poky-wrynose.conf.json} | 22 +++++++++---=
-------
> > =C2=A02 files changed, 19 insertions(+), 19 deletions(-)
> > =C2=A0rename default-registry/configurations/{oe-nodistro-whinlatter.co=
nf.json =3D> oe-nodistro-wrynose.conf.json} (82%)
> > =C2=A0rename default-registry/configurations/{poky-whinlatter.conf.json=
 =3D> poky-wrynose.conf.json} (84%)
>=20
> If someone has set up a build from whinlatter, this will break updates
> for them. I think it's better to make a copy, rather than rename.
>=20
> It's also good to diff the new wrynose configs against master configs,
> to ensure they're in sync with them, similar to how wrynose itself is
> branched off master.

Fair enough, I sent a v2. This is a learning experience :)

> > =C2=A0=C2=A0=C2=A0=C2=A0 "expires": "2026-05-31",
>=20
> This needs to be updated to 2030 :) This field is how bitbake-setup
> decides whether to include a given config in listings or interactive
> selections, so whinlatter will simply not be included in those after
> that date passes.

I'd got one and missed the other, thanks!

Cheers,

Richard

