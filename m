Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B4EB64DA
	for <webhook@archiver.kernel.org>; Wed, 28 Jun 2023 10:02:36 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.12401.1687946551710893492
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jun 2023 03:02:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=GGG/ShMf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3141140f51bso36814f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jun 2023 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687946550; x=1690538550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9ZKB2deudz/HHWvrrsBGM0Y9Vi0tWdkgXPg9dK4Gd4=;
        b=GGG/ShMfcppKShe/QyADEMkTQjkmNtpHmTTWOKsrdJhag7/rePa6d5AtGZYWpEgHzi
         gCwAfiLHW+fOdRnO8gdDDyn2o3vrfCWuaRPrtltBaBJ+rSZ1ajYpA9hGRvbDD/fn+Sa8
         cd9rzAZ4BRg0BfrBCC6ZlRw6SE+KSzjYE8+2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687946550; x=1690538550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9ZKB2deudz/HHWvrrsBGM0Y9Vi0tWdkgXPg9dK4Gd4=;
        b=LJoPObKrnIEPrJ2CsugwxpjulE0YUblp3yTmpAvVe5KUnS/1Nk4bd1viv/evWQq8GF
         EYrFDMAs2aQWeZSd05DPpzxfXIM42lyKskv3SLVx54dAmFA1CSlg7mOQcWS3Yw32/cON
         ab8rPfgcyGCpOuZYetc14awChBvYV8VSVTn408SMyau3p81HiCdiQ7UkwgeJF+eh20hC
         CMO7bz8Kpb+WoFG7lv444VErqloyco/rT02XknaIr0LXzNvQzDlpxXCQ6/nbHpL2jF8d
         rIDrXedC33UbJNzFI4rh7Nphvv4nN3fGVtPSSYEdO/P8lK6Blm7MovGEzCW4ZACuTFb4
         +i+g==
X-Gm-Message-State: AC+VfDyWErTcE/3rsvzod+5crKzRlB1qjuQY1lf9QjTi9L3AqWdmtDnl
	HeTTry0B1BaUVNJ1v8/UQ23GRVrkN1LybaHTtkk=
X-Google-Smtp-Source: ACHHUZ6lWyR4EVsrSiIG1VboHiutbqdcNVkGyRmM0TRSJW9XrRFErWGiImlQRU/HHqjW+ORzCmlDwA==
X-Received: by 2002:adf:e40d:0:b0:314:824:3778 with SMTP id g13-20020adfe40d000000b0031408243778mr1746059wrm.22.1687946549999;
        Wed, 28 Jun 2023 03:02:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a71a:20d6:74fc:9334? ([2001:8b0:aba:5f3c:a71a:20d6:74fc:9334])
        by smtp.gmail.com with ESMTPSA id m9-20020adff389000000b00313f551b032sm7130516wro.53.2023.06.28.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:02:29 -0700 (PDT)
Message-ID: <a1305ddd177a57a15906a33472d3479a90e994e5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake race failure with BBMULTICONFIG and
 setscene
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ari.parkkila@qt.io, bitbake-devel@lists.openembedded.org
Date: Wed, 28 Jun 2023 11:02:28 +0100
In-Reply-To: <176CC907B9F981A5.9439@lists.openembedded.org>
References: 
	<CANPvuRmbE+cYJmuXE=Rtg6O9wYxO762WcUqFwauftCKMY1to6Q@mail.gmail.com>
	 <21003.1687869881720533934@lists.openembedded.org>
	 <176CC907B9F981A5.9439@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jun 2023 10:02:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14865

On Wed, 2023-06-28 at 10:36 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Tue, 2023-06-27 at 05:44 -0700, Ari Parkkila via lists.openembedded.or=
g wrote:
> > Richard,
> >=20
> > The "bitbake XXX -S none" spell creates locked-sigs.inc which has four =
identical glibc:do_populate_lic checksums: Once in "SIGGEN_LOCKEDSIGS_t-aar=
ch64" and three times in "SIGGEN_LOCKEDSIGS_t-armv7at2hf-vfp". The checksum=
s are for the packages "gcc-runtime, glibc, libgcc, libgcc-initial, linux-l=
ibc-headers" which are the ones causing this failure so maybe there's somet=
hing fishy?
> >=20
> > My repro steps above should have been:
> > - repo init -u git://code.qt.io/yocto/boot2qt-manifest -m ti/6.6.xml &&=
 repo sync
> > - git -C sources/meta-ti checkout 1b313bcd
> > - export MACHINE=3Dam62xx-evm && source ./setup-environment.sh
> > - bitbake b2qt-embedded-qt6-image
>=20
> Thanks, I got further with these reproduction steps. I haven't run a
> full build yet but I did try:
>=20
> bitbake mc:k3r5-gp:glibc:do_populate_lic mc:k3r5-hs-fs:glibc:do_populate_=
lic mc:k3r5-hs-se:glibc:do_populate_lic
>=20
> which is in theory where your race seems to be. This did show:
>=20
> NOTE: Deferring mc:k3r5-hs-fs:XXX/glibc_2.37.bb:do_populate_lic after mc:=
k3r5-gp:XXX/glibc_2.37.bb:do_populate_lic
> NOTE: Deferring mc:k3r5-hs-se:XXX/glibc_2.37.bb:do_populate_lic after mc:=
k3r5-gp:XXX/glibc_2.37.bb:do_populate_lic
>=20
> which should mean only one of these glibc targets runs at a time and
> shows the "same hash" detection code is functioning as intended.
>=20
> Do you see those messages? Could you share a bit more of the output
> around the time of the failure so I can get a better idea of which
> tasks are racing against each other please?

I've realised:

$ bitbake mc:k3r5-gp:glibc:do_populate_lic mc:k3r5-hs-fs:glibc:do_populate_=
lic mc:k3r5-hs-se:glibc:do_populate_lic glibc:do_populate_lic=20

does cause it to break much more quickly with an error similar to the
original report.=C2=A0In this case the mc configs are deferred until after
glibc:do_populate_lic then they all run together.

That gives a good clue as to why this is breaking. The issue isn't the
deferral but the code that executes when deferrals are removed. I'll
have to dig into the code a bit more but I can roughly see what might
be wrong.

Cheers,

Richard


