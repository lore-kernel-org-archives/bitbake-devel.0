Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEEFE7BD83
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 09:57:30 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16622.1771235844216702116
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 01:57:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bJnnk1pO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso22775315e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 01:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771235842; x=1771840642; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v938re3QNU/LFIwpJRxz7mwfwNizbkUiFcnflFVQl4k=;
        b=bJnnk1pO4KGENoQIgQGBTmqYmf8uY0CdliTOZbPf28+Lx7rSUwFHlruLf18DBd6l4B
         FJea0kIQJpFBQCDFbuAcEkRALlz/9SINTP22t5I9uVN5E8BtVbegrT+KQ4N+4P7OVPm2
         6yK6QyGLnkT8kID0cTJ3BioN6qdN1idK3laKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771235842; x=1771840642;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v938re3QNU/LFIwpJRxz7mwfwNizbkUiFcnflFVQl4k=;
        b=KCnsgvC0YV4Bd0tlvo4kYgXwG++hLa+/+uwQUTQ1OyxtAxnUItCRN8MpWYv8ySVenC
         H6VNroVumOYh+T7kVUg3lToW5AuB+g/IVdFzgUcIckxDhYulEeCfdCQI9F1JFxeELC1Y
         Ch/fdjNuf+s8oGLX3PBgFco0mgf/Qks5T5yNaXZRw51irkvZLAsi9QMwMDcssdmU36S9
         cJBjQwPTKKRQ2WyaBAGbb8aabUcFN+xCdUudRf9FmN7b31qhNeFGh/dOQxZJR1axg+Dh
         L2DEhw/4gZxfh9IT/DmIuni/rmf+bw0SC4TfLvtnRKrQC8mWLEKzEFlrmD5RU0hK5+nh
         qQag==
X-Forwarded-Encrypted: i=1; AJvYcCVyChGf5hUIwXkQPqzc4jhVdrbkrhAAayGmrABnFXCSQup0anGfrKjwKapFtc37NXFOkZRa8aOzzCaM7Wuw@lists.openembedded.org
X-Gm-Message-State: AOJu0YyZIt+tw9ofOIro//fuzSs3gBUXxoXfUewChYhlOUfOQDKbha8f
	it8SSGunXWIC2AlJDFNfIz+l4W7wdje9e0x5PfLXNM0xhjk3x/iEaB0LvEWbDPQiT34=
X-Gm-Gg: AZuq6aKEpadiYaf2gY4ds0CSuSDGWuNlATtmoXcJxkDG3bdl1OW1H0n/TxV+3BZoR9G
	6IrDLybfEPa7TqNydIi8bKUQDYtMoc6KYYi35o2Hfy0Sp0LGSviPUqTRInprd/RdnEhuRhd+m+X
	+xaawSiXrA2XIht0RNhtAN85ZhEfmJDVqoRZ9M8AuD5VfqkCIviN8sZ6A6z56CMJ/Z+N3/ovvNg
	Iz9TeUUWSYoDoi4kUIDS/+drhx0fGLZVLkZNIRb0fsOx2dMKP7+Ux+K0Oa0QfJZiJ4SUtnL8ATU
	dd/YIHwVH0YivnaRqFufYStzrgoPWfbgs5l70D+fQ8lvpww3BSTeOtgoyIg+kUfmA+0U0/uRrPf
	WU3VfjPDRgDg9AYHckWSX33f1UVO8HqzpBG6Suxa1YCM1Mbc4r05Vv0rSDvZ5oa0MMipbc94fmC
	WiCL44ol5Ai8XVHLwIFayMpUdMJpRl7E1uWecnMxvJ+MjEbgHj+scj8hQs4kaHDqTOd2cCTvCsK
	FAgRv2yghE/zj0=
X-Received: by 2002:a05:600c:818c:b0:483:709e:f239 with SMTP id 5b1f17b1804b1-48373a5d56dmr155465925e9.22.1771235842467;
        Mon, 16 Feb 2026 01:57:22 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:c30e:78c8:ded9:8375? ([2001:8b0:aba:5f3c:c30e:78c8:ded9:8375])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0e327sm417417025e9.14.2026.02.16.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 01:57:21 -0800 (PST)
Message-ID: <21b5becc8144a7fd22f6796907255281506dc210.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch: Drop Bazaar/bzr fetcher
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Antonin Godard <antonin.godard@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2026 09:57:21 +0000
In-Reply-To: <DGG84UYJBB6C.6SDW57KWFV03@bootlin.com>
References: <20260213155953.1751687-1-richard.purdie@linuxfoundation.org>
	 <DGG84UYJBB6C.6SDW57KWFV03@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 09:57:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19033

On Mon, 2026-02-16 at 08:56 +0100, Antonin Godard wrote:
> Hi,
>=20
> On Fri Feb 13, 2026 at 4:59 PM CET, Richard Purdie via
> lists.openembedded.org wrote:
> [...]
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-
> > variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-
> > variables.rst
> > index 4b3b10d4662..c75f2c27b32 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>=20
> The SRCREV definition also needs updating:
>=20
> =C2=A0=C2=A0 :term:`SRCREV`
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The revision of the source code used to bu=
ild the package. This
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variable applies only when using Subversio=
n, Git, Mercurial and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bazaar.

Thanks, I've added a tweak to the patch to remove that. I have a
feeling we might find a few more old references in one form or another
over time...

Cheers,

Richard

