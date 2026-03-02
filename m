Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE31CEB3625
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 17:17:46 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.165974.1772471862105686617
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Mar 2026 09:17:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ZfJivzDg;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483770e0b25so41184675e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Mar 2026 09:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772471860; x=1773076660; darn=lists.openembedded.org;
        h=in-reply-to:references:content-transfer-encoding:from:subject:to
         :message-id:date:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=733RadiN5IcH4GfG1UprvMHghBOqXLBWPCbQbN0CiJs=;
        b=ZfJivzDgVNwjfqx9nHI8HFBrnRWVsRhdwgWzsoiKcxqr9DJwhQOGW9XtBo+0m2OUvr
         PjpPzLgckd/mARJpQ3039zrsIZzuNyS+Bx7bVH/10YfQzk+QG5f2EME5UPGBXO0gFv5d
         Sdd7MPjqOfFQSPk2hyaoKQVO/Pvcm3NAifCfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471860; x=1773076660;
        h=in-reply-to:references:content-transfer-encoding:from:subject:to
         :message-id:date:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=733RadiN5IcH4GfG1UprvMHghBOqXLBWPCbQbN0CiJs=;
        b=wOI+mKg3oDr4pZdXQDrEmcwIiagYXM0sZOhT/Wz7FCgHKor5XiTvpvLJyYTwkMXyGg
         DEDFz6oT45gjJ+hU7m0DjXsIn9RDDu0cN/I9w3ldXsOMSc72E2jXqwZlcCXWezFEgdl3
         o7DBzC/x+xGNkFl0ljjEgwtfg7DwSBZA1Q24hcjVgVqv/87khWL5VJtPlAxVeNydKUTs
         P7/WkFTbAUGujx/Pq83iqAywhYHkpI23GgtCEleOsFiYvUvWjlxBe/q6P8j25gCmAb18
         cvEy3/jrTrWMHgbbb8liaQsyBWVqSWc/BNAvcjkD6gDIeMbseLt6uZLasqOxt3KG5SK6
         k5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa3msh/d2uBXpnMncdjgsu1R8XPK+AYtm9PLgY3OEjG2PuCxYpkljAENVeQYzFyer/vCVxvHb69DZlpFf7@lists.openembedded.org
X-Gm-Message-State: AOJu0YySkjRvZrwdEUnfOFYZJSd6NVdXwWq8Yds9H6qbLDggWwSUaX3D
	Ue6K27dQnCUUzQvHxthZ3cgv/VXCaIXrhtarfr9CqlK85F5QvlhHWzLQPJR/C4V0fSE=
X-Gm-Gg: ATEYQzwBa1Z22l2AdA0CvVlS/kGhcZMGpVxZGTZTllH32rgNcGmdLJ9tlpYuCuJ5lXm
	bSxOQtFbDV6OkuG+NtwRa8Wf7x+nLLBPeiJz8FJj0PJeXbILeJ9SIJ4tdojRSZjEma0gxDPVTQ1
	f5/OG54bBzUKs4vkhued0v5bGUH1FOz4XVsLCdeTDyVR/p1uBW6uT1O18nHXNDmsQT91yd59iKo
	KN3945NbOV2DcD+no07t+2STdGeyPmIA5hE++iNv5qn6q7cyOHkxenzqdT8iK9FDRLfI7IrqmDa
	+Mt0JSoMiGX08Ffmu5wWTkngn/reXgjcHBUCbSx9wBSzbA65m++Yb6xVOWEHSBmnmbJc1+wRRm6
	KMyKo8fmqhdzJWjGXymYVePKmvQhjH+zKrdSOBX5ZZnK+jtRgfwvNk7M8RKu8qUhwFCKbNht/jm
	+Edoq13/lfcwRd0Q8Wm0P+bgegJcoah7gHlzs8VXnX/qjvrCeLG5lTd6dPNg3c7+GPvtkVTWBVS
	Evpd3l2SY6q3A==
X-Received: by 2002:a05:600c:3110:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-483c9c23ffbmr222929765e9.24.1772471860274;
        Mon, 02 Mar 2026 09:17:40 -0800 (PST)
Received: from localhost (2a02-8440-7505-a0cc-b4b8-1006-63f2-cab6.rev.sfr.net. [2a02:8440:7505:a0cc:b4b8:1006:63f2:cab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df9fsm500829595e9.13.2026.03.02.09.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 09:17:39 -0800 (PST)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 18:17:39 +0100
Message-Id: <DGSGU316HXOK.3GB9VWMIHY7O0@smile.fr>
To: <pedro.ms.ferreira@ctw.bmwgroup.com>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: avoid reuse download filenames
From: "Yoann Congal" <yoann.congal@smile.fr>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.0
References: <20260302151443.256386-1-pedro.ms.ferreira@ctw.bmwgroup.com>
 <e58fedf42052698a50007bd5d49a70e0b77aa702.camel@linuxfoundation.org>
 <1127752.1772470455842490403@lists.openembedded.org>
In-Reply-To: <1127752.1772470455842490403@lists.openembedded.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Mar 2026 17:17:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19100

On Mon Mar 2, 2026 at 5:54 PM CET, pedro.ms.ferreira via lists.openembedded=
.org wrote:
> Hi Richard,
>
> This was detected internally when users modify source files and update
> the hashes inside the recipes to match. Bitbake is allowing this operatio=
ns
> because it identifies a mismatch and renames it to procede with the downl=
oad.
>
> I tested this locally with:
>
> - Create a source file, for example, test_download.tar.gz
> - Create a simple http server (python3 -m http.server 1212 )
> - Create a small recipe, local_test.bb
> ------------------------------------------------------------------------
> SUMMARY =3D "local test recipe"
> DESCRIPTION =3D "Downloads and installs test files"
> LICENSE =3D "CLOSED"
>
> SRC_URI =3D "http://0.0.0.0:1212/test_download.tar.gz"
>
> S =3D "${WORKDIR}"
>
> SRC_URI[md5sum] =3D "12e597833772126eade44740570aab3c"
> SRC_URI[sha256sum] =3D "f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8156a3=
d4949f7de67fc87"
>
> do_install() {
> install -d ${D}/etc/test
> install =C2=A0${S}/README.md -C ${D}/etc/test
> }
>
> FILES:${PN} =3D "/etc/test/README.md"
>
> ------------------------------------------------------------------------
> - Run it: bitbake -C fetch local-test
> - Modify source file
> - Update the hash
> - Run it: bitbake -C fetch local-test
> - A warning is raised: WARNING: local-test-1.0-r0 do_fetch: Renaming /hom=
e/test/yocto-downloads/test_download.tar.gz to /home/test/yocto-downloads/t=
est_download.tar.gz_bad-checksum_f03e325aa451beda1b340a7ce0fcfd620b74c86e12=
b8156a3d4949f7de67fc87
> - Bitbake continues the next steps with this new tarball.
>
> Cheers.

Note: This is related to 16154 =E2=80=93 Mirroring process fails if an arch=
ive changes hash without changing name
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16154
--=20
Yoann Congal
Smile ECS


