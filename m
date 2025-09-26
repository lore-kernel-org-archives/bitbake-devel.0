Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B07CAC5AE
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 14:24:02 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.18674.1758896639158894127
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Sep 2025 07:23:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W8y9tBdr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e425de753so3377255e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Sep 2025 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758896637; x=1759501437; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rsuU8lGsZqhVEqABO6zA13Ut1dEnxrtR0YPUghomSeU=;
        b=W8y9tBdrsYVWHkFCgPPmyE5+MLEh6DuHm7qwhcoMuTDWeZRwb8OzXCHgLsQl8iq1ja
         5ggqHNDIfskuBhikBoDEfxoeGqC6l7+llMxxtfgU55R6XPDRh3o8Dg9aiIy6eldCPI2B
         VZn0cqw6/I334KH9T0sCFZ3Amz+xoN97QtOX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896637; x=1759501437;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsuU8lGsZqhVEqABO6zA13Ut1dEnxrtR0YPUghomSeU=;
        b=cQO7VnfmRNoFZnZp0W5e9qySHZCIBMwwjTin4GlhB6CL03aSnWNKT87eHUh+LgEGAF
         TjlzLzBT1L3oKMywlslSujukDpp9jI+zML5Z76/VEPUNFsTuv46ykBPBq00xDTHpJ7zd
         bAjFobGSeLcfVldMtMIKjvTKe+i8kqHZHaO0YECT1hSZh9y2lTX+12XhXsPHSYJZQ1LB
         Nk+FQXt0Qfhwv3PLuPoitnNmcr7eNXdyo2QOYX1FUeu9JS19+yy8pU0Jm57mLwp3bgXi
         Y29uf6Bc/kpC84u68fOuxGFnRGu70PmoCNHDHpDgzhyGr94UmC+x5fHhhYHeKZ4TpZf+
         rrpg==
X-Forwarded-Encrypted: i=1; AJvYcCVVaUz4xKBB2MKVwS7UMwnjWWeMFlEgtN+NAuwRjgyQ5bprwhmH55c8vXwK15xUQTAufH1DM03urdEH+ej1@lists.openembedded.org
X-Gm-Message-State: AOJu0YyJXa6T3XyZoDhsf+0mI2ctRGzdjjjJ7PwOYTZuf+o2Jjfj4ymm
	Z4lvSFW/1SDBRmzi7jA4c0UXP/FubFkUeQFdkzIoP5rsBo+rgJ7PD5CBfriEQRI89+o=
X-Gm-Gg: ASbGncspMlAP6HQRjOxp9H7EXa1ciyxH558aD+25F+TC+gK+PDoUAvONVFw3jWPfpG1
	QzQZzLwWMYnwF23o1HYxdkptdfPpaP8ZpnOL65cDcsYKJ8cUcm9hEzIFBMcmIxRmyN8kZMBqFU7
	rNtmsc2YKkVpoB7JfgdGBm5bffFPxz5eQ3jh04QC9RIeo6/znBg1tEt6sExes44X64JeyZbAi29
	+7ROPABmAqn9F8RbB91QdMxiSflFgEZhveT5sHzwDk6KF+U40h76CGPfTv/QgvG+1lycQ4pjPoN
	zz1WqGbxJjFLElzdCMfULq4CWlkUumculYd8sEKrINplpfrt4Q9yTvo4Gf7wiRKcuaA/B+nMlYa
	f70TRDHp8BqNKte93GqwcGL1d8ftKylsMiqhBfOrneNXhVp4agaWedr8lgYAbY8HbPXSf0Lzd0l
	V7GW7dO1cbyM4=
X-Google-Smtp-Source: AGHT+IGI5Z83uFtB3wPRjmbZlqQLvzDBrM2S3n6alDMAyT22HOxBbjMKL+j8sNx2lEDH54aiEnxmxg==
X-Received: by 2002:a05:6000:24c6:b0:405:8ef9:ee71 with SMTP id ffacd0b85a97d-40e4373715cmr7405739f8f.24.1758896637359;
        Fri, 26 Sep 2025 07:23:57 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7? ([2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1b665sm7198448f8f.27.2025.09.26.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:23:56 -0700 (PDT)
Message-ID: <5849b9f23a3782c7a4b4eb32a6797454336ffcae.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: add the initial
 implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Fri, 26 Sep 2025 15:23:55 +0100
In-Reply-To: <20250922092731.1993813-1-alex.kanavin@gmail.com>
References: <20250922092731.1993813-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Sep 2025 14:24:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18095

I know Alex has told me the "nobranch" approach was by design however I
can now demonstrate why this is sub-optimal. The reason being that if
the branches aren't used in the fetcher, the build can't work out which
branch it is on. In general that isn't a problem but there are two
cases where it is:

a) the autobuilder was querying branch information to report back to
the UI. This could be done differnetly.

b) the summary output at the start of the build. This is a usability
issue if not fixed.

A bitbake-setup driven build prints data like this:

Build Configuration:
BB_VERSION           =3D "2.15.2"
BUILD_SYS            =3D "x86_64-linux"
NATIVELSBSTRING      =3D "ubuntu-24.04"
TARGET_SYS           =3D "aarch64-poky-linux"
MACHINE              =3D "qemuarm64"
DISTRO               =3D "poky"
DISTRO_VERSION       =3D "5.2.99+snapshot-07747aa7390e98bf2853154e5fd473e49=
84a1d3d"
TUNE_FEATURES        =3D "aarch64 crc cortexa57"
TARGET_FPU           =3D ""
meta                 =3D "HEAD:07747aa7390e98bf2853154e5fd473e4984a1d3d"
meta-yocto-bsp      =20
meta-poky            =3D "HEAD:db24e48498b2d40131b871f6eafeb7a67da343f0"

and I'd much prefer we didn't have HEAD in there but show the actual branch=
.

Could we improve this?

Cheers,

Richard

