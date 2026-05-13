Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77936CD4F24
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 09:21:45 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3667.1778664103635953759
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 02:21:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Wfxeb/tD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e82c23840so28789075e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778664102; x=1779268902; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSJLwL+iPvj5efsYey5DQgEaOUxsFxvf7ew3G0d8vPo=;
        b=Wfxeb/tDxQdoXwjqPxBWXKr+sT8diXUppRIVMoEiWocoKzON+If5KgCNFcfKIqyHkg
         a4t8QrhMWh8WPr2wWy0g2yvCVwzWbGMC14NPHKuRzUpTObpmiVsU6jFwRmUDflBtzY+E
         uyxP9GDp4u71XfS5qpRuvF1DxPdq37L95M6Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778664102; x=1779268902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSJLwL+iPvj5efsYey5DQgEaOUxsFxvf7ew3G0d8vPo=;
        b=p72+E7sYm9Hgr1yOREM2MEm0oRBc0AHrIgY0sGZfvSEkgfzslt4BaduR+JnD/Kw9Dm
         TN8naSiF7MQ+jZ+p0Pq7a7/lZcXc2TM9CYUENNaDuCsrxbVglu7sAYFlTQFcwoPozKq9
         HIydqLOOebQ/xJpb/ocvMbc5791RuKL+OenVmXo5ISV7x6700DtmuBGP1U/7+4IhJyAX
         gpp5sa6nDXyP0vgeaK9YoYDgWLS447HgOHjbq2FK4T24KXSWghz6UFacJuSdC9P/xNcV
         gz53ChaoRJRUiQLV2QqmJDutITLjgNoozpkkXuR1bN1pQU0pi6cVnBQtQ1HYCUd3eL15
         BSAg==
X-Forwarded-Encrypted: i=1; AFNElJ8Nr0E7k0zrQr7EL2ACV9VBEZyRQXkS7+D7Lan/f5TBO2YNyxDfFq7Gx87jt/RL8tgLK5wYjfEbVptBO/SW@lists.openembedded.org
X-Gm-Message-State: AOJu0YyMS3bm1zfcConzBvWEA5qNjmIJaos7CJw5zzYtuD0zXCXZZ+s1
	0kA+TpCu0hRgSwNFWvOFRZz22RUeOdhTYCmcOZ56acv0WuHERmWWaeMb9F0k7Fpo7iM=
X-Gm-Gg: Acq92OEOl737Gwcs2b/49x0WraaHjHtk7laRMzcji1ygFu8NnR4TxkZgKtFEMrxarxY
	kZ0Hept2ZebIbIB8lsIkN7lOwEfdaZ8m9Yv8g5YXuEZpzThGrcIEGX2/QU9UCx7JZVhtyztKdKu
	FHqQVPp601OIBBuOtjqwnGkO8sAP42mv6eEZpp9d/WjNsoipwvkuY4NdSfQjBEGpqqsOn+waAbJ
	MSvyREBdPlewxab7YTSk16RpMKKTGHGjfwDpkXz/q6XhIheGEGCuURqVR9iFjuJ7qNUrpxzBESz
	Lh1legsJgQiXV5uRxKLtfw+NSUv6J5HVXEYA8x3LBEj4cKeup9t4l0lichg0K8GxOPnd+d/oSg+
	jdZQnG36bmYREpCNB4QoRX2/IEIzNDqCxwev5eErdXGBwbitENClgUMt0AlKZcZ0etu8QOBswj5
	GE6g3wZzctBPGJRvX5shqU4RIug30S+ZXuiGfH6z6MZ9wabclh4MAaZD/m3roQDkPMA5iLI4cQF
	eS+hWzOUlTM/e87
X-Received: by 2002:a05:600c:4ecc:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48fc9a391fbmr39381585e9.21.1778664101802;
        Wed, 13 May 2026 02:21:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b7ef:b234:c010:91da? ([2001:8b0:aba:5f3c:b7ef:b234:c010:91da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm37848424f8f.16.2026.05.13.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:21:41 -0700 (PDT)
Message-ID: <4d3807d067376d11bd13b5ccd1abf28f77c13ce0.camel@linuxfoundation.org>
Subject: Re: [bitbake][wrynose][2.18][PATCH 0/3] Pull request (cover letter
 only)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 13 May 2026 10:21:40 +0100
In-Reply-To: <cover.1778576715.git.yoann.congal@smile.fr>
References: <cover.1778576715.git.yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 09:21:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19507

On Tue, 2026-05-12 at 11:07 +0200, Yoann Congal wrote:
> Those are the patches from the last patch review:
> https://lore.kernel.org/bitbake-devel/cover.1778197991.git.yoann.congal@s=
mile.fr/T/#t
>=20
> Passed a-full on autobuilder with 3 AB-INT issues:
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3795
> * qemuarm-tc: 15698 =E2=80=93 AB-INT: runqemu.QemuTest.test_qemu_can_shut=
down hangs with "Data received serial thread"
> =C2=A0 Retried in https://autobuilder.yoctoproject.org/valkyrie/#/builder=
s/42/builds/3689
> * qemuriscv64-ptest: https://autobuilder.yoctoproject.org/valkyrie/#/buil=
ders/56/builds/1562
> =C2=A0 This is a ptest failure in procps: 'pgrep_match_against_full_proce=
ss_name'
> =C2=A0 This particular ptest later passed in https://autobuilder.yoctopro=
ject.org/valkyrie/#/builders/56/builds/1564
> =C2=A0 (I have yet to properly report this one)
> * qemuarmv5: 16217 =E2=80=93 AB-INT: boot hang in qemu (amba chip errors?=
)
> =C2=A0 Retried in https://autobuilder.yoctoproject.org/valkyrie/#/builder=
s/80/builds/3559
>=20
> The following changes since commit a2dd9be788274d9c7280be5b1be5eb5c3990cf=
54:
>=20
> =C2=A0 fetch2/crate: use CDN endpoint for version checking if possible (2=
026-04-30 10:08:54 +0100)
>=20
> are available in the Git repository at:
>=20
> =C2=A0 https://git.openembedded.org/bitbake-contrib=C2=A0stable/2.18-next
> =C2=A0 https://git.openembedded.org/bitbake-contrib/log/?h=3Dstable/2.18-=
next
>=20
> for you to fetch changes up to 87dcc2935137558ac236676ab7bcbc3cc4883c2c:
>=20
> =C2=A0 lib: Replace codegen with ast.unparse() (2026-05-05 17:36:57 +0200=
)
>=20
> ----------------------------------------------------------------
>=20
> Alexander Kanavin (1):
> =C2=A0 fetch/wget: in upstream version checks, match versioned directorie=
s
> =C2=A0=C2=A0=C2=A0 exactly
>=20
> Paul Barker (1):
> =C2=A0 doc: Fix description of git shallow mirror tarball creation
>=20
> Richard Purdie (1):
> =C2=A0 lib: Replace codegen with ast.unparse()

This breaks the hashequiv docker file so we may want to hold off on
this until we have the other fixes in master?

I'm a little torn on backporting it. Yes, it is a nice cleanup but it
does introduce risk, as that other issue shows. It is all relatively
minor but...

Cheers,

Richard


