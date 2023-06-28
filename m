Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC6EB64DA
	for <webhook@archiver.kernel.org>; Wed, 28 Jun 2023 09:36:36 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.12111.1687944994893307384
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jun 2023 02:36:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=dhnZQxSX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fb41682472so5499492e87.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jun 2023 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687944993; x=1690536993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRuATAvMRfsfIOTTp4ixqYP8ow/Z0zyidz16inl5JAo=;
        b=dhnZQxSXr+ce8+RlNU2s2QGKcebH0fDE4wLaCI7bEj+g7JiaUs7umpjqIcU5MbOHdJ
         SJzcutnQyfqqrYbTMSsd06//22VS+qXJ1VrHRv7RBrxguBbFj4CMKlp2idorHjrYy2x0
         +Ot9nWks4mclMsJobakLPZeqsKRsbTQzwF4b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687944993; x=1690536993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRuATAvMRfsfIOTTp4ixqYP8ow/Z0zyidz16inl5JAo=;
        b=Aq2TuCjjjpDf/S8ZlrGJfGgrAM3X6V0uyLLl3295r7N67YDmSTeBE/xcQanFFWlEp9
         ZdZyaotfXQpTXWOxJylKWWb/hhSZWbVBlT0ZYk/uj/4K7dCgafJJyN+Qy/K4W65T3q6f
         4ZEFxHG/czjMWQrdhPz/AT4Q89xFCsBXwElurB/To/ICn3iwDnSjA8Rr0McRF2kw+9LG
         M/cSn1Wu/z8uMAtx0INjBfu6dYxCJr2jqHYS8rmvfz/DLIZNC5HwWL/eScs9UT651rx5
         zhjO6Q4FjOxgi/4zNNgghfeC5iAogL/WHr/0XFfXNPD+QBVZOBO5+d+9PF/Kxx3e/fz1
         oPBg==
X-Gm-Message-State: AC+VfDyy5FL8YrF9fvdWLcBbdCShSmGIG255MgZQ7V/9HD7tA0Ru2DLv
	90epE9QkpYfdytTqQf2TrA1SIA==
X-Google-Smtp-Source: ACHHUZ6ZFBaSgTZTBauha2h53h8HAySZcnIffpbr3TD3nhy0x7oUelfWLYZM9tEYIXugpz9gAxhDaA==
X-Received: by 2002:a2e:7209:0:b0:2b4:5a0b:9297 with SMTP id n9-20020a2e7209000000b002b45a0b9297mr25456078ljc.29.1687944992786;
        Wed, 28 Jun 2023 02:36:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a71a:20d6:74fc:9334? ([2001:8b0:aba:5f3c:a71a:20d6:74fc:9334])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c00c300b003faa6ce54b2sm7296506wmm.2.2023.06.28.02.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:36:32 -0700 (PDT)
Message-ID: <831c57cfe5894510ce00dd447fdb4c47b44203e7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake race failure with BBMULTICONFIG and
 setscene
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ari.parkkila@qt.io, bitbake-devel@lists.openembedded.org
Date: Wed, 28 Jun 2023 10:36:31 +0100
In-Reply-To: <21003.1687869881720533934@lists.openembedded.org>
References: 
	<CANPvuRmbE+cYJmuXE=Rtg6O9wYxO762WcUqFwauftCKMY1to6Q@mail.gmail.com>
	 <21003.1687869881720533934@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jun 2023 09:36:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14864

On Tue, 2023-06-27 at 05:44 -0700, Ari Parkkila via lists.openembedded.org =
wrote:
> Richard,
>=20
> The "bitbake XXX -S none" spell creates locked-sigs.inc which has four id=
entical glibc:do_populate_lic checksums: Once in "SIGGEN_LOCKEDSIGS_t-aarch=
64" and three times in "SIGGEN_LOCKEDSIGS_t-armv7at2hf-vfp". The checksums =
are for the packages "gcc-runtime, glibc, libgcc, libgcc-initial, linux-lib=
c-headers" which are the ones causing this failure so maybe there's somethi=
ng fishy?
>=20
> My repro steps above should have been:
> - repo init -u git://code.qt.io/yocto/boot2qt-manifest -m ti/6.6.xml && r=
epo sync
> - git -C sources/meta-ti checkout 1b313bcd
> - export MACHINE=3Dam62xx-evm && source ./setup-environment.sh
> - bitbake b2qt-embedded-qt6-image

Thanks, I got further with these reproduction steps. I haven't run a
full build yet but I did try:

bitbake mc:k3r5-gp:glibc:do_populate_lic mc:k3r5-hs-fs:glibc:do_populate_li=
c mc:k3r5-hs-se:glibc:do_populate_lic

which is in theory where your race seems to be. This did show:

NOTE: Deferring mc:k3r5-hs-fs:XXX/glibc_2.37.bb:do_populate_lic after mc:k3=
r5-gp:XXX/glibc_2.37.bb:do_populate_lic
NOTE: Deferring mc:k3r5-hs-se:XXX/glibc_2.37.bb:do_populate_lic after mc:k3=
r5-gp:XXX/glibc_2.37.bb:do_populate_lic

which should mean only one of these glibc targets runs at a time and
shows the "same hash" detection code is functioning as intended.

Do you see those messages? Could you share a bit more of the output
around the time of the failure so I can get a better idea of which
tasks are racing against each other please?

Cheers,

Richard




