Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8796CCD3439
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 13:20:32 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11718.1778160027754243610
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 06:20:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TqppTl93;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48909558b3aso10130805e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778160026; x=1778764826; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LJsLOmp0qYaii3yyI5rIKD6zXTNR4+QVpujVBDeHxS4=;
        b=TqppTl93Rw9zlnwotRkbs8ardrmoRHpUX0gKVGy6kHYoa9lAJcpD5VNoL72qScAkQJ
         vN8qI+ihe97dLGBXZxMn3d8ZY3ESc+4K+z+A1OjNe74T7oK/CG2n5ORYn7b+G10h1rUn
         Bp9PwljmF8gl8YEzboFHUzDQAAoaqVL7zxJXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160026; x=1778764826;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJsLOmp0qYaii3yyI5rIKD6zXTNR4+QVpujVBDeHxS4=;
        b=Pt5zV3+qewX6VmElMnwpT6iOV3qS1/tnitCzRQkb2Qg3ePNK2P/Aq98PpG/MedYDB6
         nqg9x4buc0gNx24OdmsUgP9lrbxA2VBf0J+s21J/dsg4dQbkzKQNdKR3bhTDyEThdIlY
         NZbTBEvs/uo+StCySi2C8/Di/pjMG8se8yKPHrnT9c3/I+sMeWC4RSHNQzXRe6aHy5r4
         XTO6gVVhZkAlJEDhVtZb4uZm5/ql9gQ8Xj7rh3NgaL+re/lxyGq/2PsR0oJuSvNGoGCB
         MpIRnAdqmcOjVThtqColxAEjXwI1SSUfoAP8GHhrVRDxmYL4vl0qgYaoWlyIlI5XZI9a
         goGA==
X-Forwarded-Encrypted: i=1; AFNElJ+lUWydvdUOamCNU9truvGrujeokC1GrAyoFj/K2YgL8O0Q5uqrPyMxsfjUkJdnu6zcXMbAUzOH9lv5vZzK@lists.openembedded.org
X-Gm-Message-State: AOJu0YwXL8StS0KevZtGCsry7gC+qLpXYFJOVZH8OZPFfeCBFKExF1KP
	uFEeTyCFT5EQhHmmJBIXc6P+rS/77KIm705k/BCnUSRQaja/c21aAeYui0UAXfG/bOs=
X-Gm-Gg: AeBDieth3IstYLO/G0b8X21hJaopjQVOYPpXVHVs7Ecxp+gWBx+XK6uIMBkeZ4Lttwo
	TG/GkIJv8/MaKoxOD3zbPGe++2xFCDMOrJzuWEELpZPlcp9aOKReHT6x2u6nl8rMSpZLttvg47j
	6Y1P0Zu1tECJDByEXeLzmwweqjKUTzcQhJJtlFV7zThnxu7MAjaiURKZGFMBWMBBxZ0f3M8mwjg
	cKJafbs3Z0T6eOma5xEtOXNbi0lYG/nXWer2p/9P7DFEixzYve9nDIux72hPdcwWyJjqRVGdjF0
	Ef2cGE4qY9T7AhLN5sD5j04PHgTNesuXmr/cAJgMZLrNN4a3CdGMx6mCqtRVyCQnIbHrQlBvq+e
	nVwI8aynEVfmDQOi8DNeq5wnhcorux24enRYvOY2XfEON9LjtDG7+2DazhVk588LQim6ARYg00V
	H52ehxvt2i+ER6eYDvXv7vffA16HY10qSruPifj+jPEPoDlLfdLY3AK7CZrplzkc6g8CAeUAs3V
	FnEauFrBW9MEPhyhijrH7/pzlM=
X-Received: by 2002:a05:600c:a307:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48e51f4111fmr101720835e9.19.1778160025796;
        Thu, 07 May 2026 06:20:25 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:44fa:5dbd:b82d:7b00? ([2001:8b0:aba:5f3c:44fa:5dbd:b82d:7b00])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5313b023sm64535155e9.5.2026.05.07.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:20:24 -0700 (PDT)
Message-ID: <224b7cb95cda25816f49ce2b036a0c9cca437e1e.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] [bitbake-devel] proposal: build
 pipelines in bitbake-setup
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, Ross Burton <Ross.Burton@arm.com>
Cc: openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>, Yocto-mailing-list
	 <yocto@lists.yoctoproject.org>, Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 07 May 2026 14:20:24 +0100
In-Reply-To: <CANNYZj9YxLpwDe4pTiT5-WMYUG=6AdV1u=dQHCZt45Pk9QF=xQ@mail.gmail.com>
References: 
	<CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
	 <6100A74F-B06F-49D5-9895-DB7D5B563773@arm.com>
	 <CANNYZj9YxLpwDe4pTiT5-WMYUG=6AdV1u=dQHCZt45Pk9QF=xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 13:20:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19461

On Thu, 2026-05-07 at 15:13 +0200, Alexander Kanavin via lists.openembedded=
.org wrote:
> On Thu, 7 May 2026 at 14:37, Ross Burton <Ross.Burton@arm.com> wrote:
>=20
> > To be honest I think I disagree with you here.=C2=A0 There=E2=80=99s al=
ready a
> > load of =E2=80=9Cbuild pipeline=E2=80=9D tools from sh scripts to Makef=
iles to the
> > multitude of=C2=A0 task runners written in every language under the run
> > (invoke, rake, etc).
> >=20
> > Does the world need another one?
>=20
> The idea is that bitbake-setup should help users do something useful
> with a build they set up, by providing a standard UI. You'd type
> $ bitbake-setup run
> and it will give you a selection of what's possible, and then proceed
> to do it. It's the equivalent of 'kas build', just more flexible :)

The trouble is there are multiple things a user may want to do and
which one is a hard choice to make. If you have some narrow layer with
a specific image and application, that is easy. If you have a general
layer like meta-virtualization, it is unclear which target(s) a given
user may want. nodistro/poky face the same challenge, the thing the
user might want "depends".

> If someone has written their pipeline with make or a shell script,
> then bitbake-setup can simply run that (e.g. a pipeline containing a
> single step), but I think there's also value in having 'native'
> support for multi-step pipelines. They're simple (e.g. executable
> commands are static strings that can't be parametrized), and if that's
> not flexible enough, there's indeed plenty of industrial-grade tools.

I believe if we implement and do something, we need to do it well and
it does need to have a specific target/focus and use. If this
functionality is too hard or inappropriate to use for too many of the
application areas, you have to question whether we should be doing it
at all...

Cheers,

Richard


