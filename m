Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B285EB64D7
	for <webhook@archiver.kernel.org>; Wed, 28 Jun 2023 11:29:07 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.13799.1687951739517498852
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jun 2023 04:28:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=QwS6Xo/9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fbaed1ac99so7524895e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jun 2023 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687951738; x=1690543738;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEzIDne0rXYCaUVoqTuD4xayVRUmn+9s7vGJB99UZ3Y=;
        b=QwS6Xo/9NNkGWn5hhbPrf41KqwlHqwGKxFuoPMQB14fzjBT2XIgUglnLXioB1booIN
         BfJYuChgro3htVn6mp7j7dLXcIh1YcRopXIovUnD7TD6LNFwUVzaiHN4MmBtFf7NWAME
         X0xf45eNHDmfFjd0WDoq1DvriIBuxFOKgtZUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687951738; x=1690543738;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEzIDne0rXYCaUVoqTuD4xayVRUmn+9s7vGJB99UZ3Y=;
        b=aFslWKVpvNQDeNvUgv55veRAnKM+hJOJBr2y2NSNgQ8Ij5BBMhN5zR98ISHE+Rl1nG
         0dNoipIDVYsirDQlEdbql9oV5dmF2wbsXXgEXjxEQKSHF0Tzz6/+ZTcIxE3IkVYTJly/
         Ujozrw+6MNCYLcIqAsX5V1Rtfzi9+nc5p1K57U+uAiAF1vZI6EpEqcgSC/bK8sahIdQh
         sVRpYQKh8OQJOBS78l4VO8lYWb5S7ZaqcClKiiL32eHkNHAO3WPn1wTEBeTaNaGCC/XZ
         aa4zgLXYGPlrT/0VhVc319JNIP8n0ZTkIYxRWjB4p7Ys8WlceBwb9JrWeFmHvjwDtHI5
         rNbw==
X-Gm-Message-State: AC+VfDwOSQAP74Kafmq7nsAq9L5NSx/F10Wazlc0IDiSY3AdzFZqRlE1
	puAWbmkJTv8G0/DTPRCNNzpCBQ==
X-Google-Smtp-Source: ACHHUZ7mltA7AdCar0nAfLiGouJ0Qt8MclJAp0LRsrfIPynXFc8tC1tUDCDWgGijpAEJjMGUrRLSOQ==
X-Received: by 2002:a7b:c456:0:b0:3fa:7b1b:4adc with SMTP id l22-20020a7bc456000000b003fa7b1b4adcmr9776027wmi.39.1687951737789;
        Wed, 28 Jun 2023 04:28:57 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a71a:20d6:74fc:9334? ([2001:8b0:aba:5f3c:a71a:20d6:74fc:9334])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fa968e9c27sm8761948wmo.9.2023.06.28.04.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:28:57 -0700 (PDT)
Message-ID: <5bb4da5354c23d8d8eb782bf7a5b15d34987378b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake race failure with BBMULTICONFIG and
 setscene
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ari.parkkila@qt.io, bitbake-devel@lists.openembedded.org
Date: Wed, 28 Jun 2023 12:28:56 +0100
In-Reply-To: <176CCA722F4D0B2A.9439@lists.openembedded.org>
References: 
	<CANPvuRmbE+cYJmuXE=Rtg6O9wYxO762WcUqFwauftCKMY1to6Q@mail.gmail.com>
	 <21003.1687869881720533934@lists.openembedded.org>
	 <176CC907B9F981A5.9439@lists.openembedded.org>
	 <176CCA722F4D0B2A.9439@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jun 2023 11:29:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14867

On Wed, 2023-06-28 at 11:02 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Wed, 2023-06-28 at 10:36 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > On Tue, 2023-06-27 at 05:44 -0700, Ari Parkkila via lists.openembedded.=
org wrote:
> > > Richard,
> > >=20
> > > The "bitbake XXX -S none" spell creates locked-sigs.inc which has fou=
r identical glibc:do_populate_lic checksums: Once in "SIGGEN_LOCKEDSIGS_t-a=
arch64" and three times in "SIGGEN_LOCKEDSIGS_t-armv7at2hf-vfp". The checks=
ums are for the packages "gcc-runtime, glibc, libgcc, libgcc-initial, linux=
-libc-headers" which are the ones causing this failure so maybe there's som=
ething fishy?
> > >=20
> > > My repro steps above should have been:
> > > - repo init -u git://code.qt.io/yocto/boot2qt-manifest -m ti/6.6.xml =
&& repo sync
> > > - git -C sources/meta-ti checkout 1b313bcd
> > > - export MACHINE=3Dam62xx-evm && source ./setup-environment.sh
> > > - bitbake b2qt-embedded-qt6-image
> >=20
> > Thanks, I got further with these reproduction steps. I haven't run a
> > full build yet but I did try:
> >=20
> > bitbake mc:k3r5-gp:glibc:do_populate_lic mc:k3r5-hs-fs:glibc:do_populat=
e_lic mc:k3r5-hs-se:glibc:do_populate_lic
> >=20
> > which is in theory where your race seems to be. This did show:
> >=20
> > NOTE: Deferring mc:k3r5-hs-fs:XXX/glibc_2.37.bb:do_populate_lic after m=
c:k3r5-gp:XXX/glibc_2.37.bb:do_populate_lic
> > NOTE: Deferring mc:k3r5-hs-se:XXX/glibc_2.37.bb:do_populate_lic after m=
c:k3r5-gp:XXX/glibc_2.37.bb:do_populate_lic
> >=20
> > which should mean only one of these glibc targets runs at a time and
> > shows the "same hash" detection code is functioning as intended.
> >=20
> > Do you see those messages? Could you share a bit more of the output
> > around the time of the failure so I can get a better idea of which
> > tasks are racing against each other please?
>=20
> I've realised:
>=20
> $ bitbake mc:k3r5-gp:glibc:do_populate_lic mc:k3r5-hs-fs:glibc:do_populat=
e_lic mc:k3r5-hs-se:glibc:do_populate_lic glibc:do_populate_lic=20
>=20
> does cause it to break much more quickly with an error similar to the
> original report.=C2=A0In this case the mc configs are deferred until afte=
r
> glibc:do_populate_lic then they all run together.
>=20
> That gives a good clue as to why this is breaking. The issue isn't the
> deferral but the code that executes when deferrals are removed. I'll
> have to dig into the code a bit more but I can roughly see what might
> be wrong.

I've followed up by posting a patch here on the bitbake mailing list to
change runqueue to address this issue.

Cheers,

Richard

