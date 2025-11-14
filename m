Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D007ECE7AFD
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 12:14:39 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16463.1763122469983578492
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 04:14:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BEwVTOWT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so14072805e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 04:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763122468; x=1763727268; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ToO9hbwAPxy3VX1RwsF7Mw+gPm6MuDHF1erY8wObP0c=;
        b=BEwVTOWTrQtk115O12lpkd6Dx+HWV0cgWpjMoPtG+GRFXPj+1r2GvTvoVtwHsjP29K
         xtCIKtQJ+t/oOBLfqyEqe6Z/+NoutvFSMK6H0VT7iGOT0p6FyD20XXR+rcZ1MCUaVRmQ
         VoEY5haxkDZfshXlWH6d26NINdZaVX0b5ZfNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122468; x=1763727268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToO9hbwAPxy3VX1RwsF7Mw+gPm6MuDHF1erY8wObP0c=;
        b=ZzA4xjvTA3Nr1BGRwhtxrAC7T3B51X05QB9flQMUACoEwdOJlMLXeHtnaPP2i2zAaN
         ANxi43maZ7CIO12midUmcwkx4D7YECnACXAFm58h3rkLoBynoX5me1OEuPPQichyu5Od
         HqUsdKOt41yJ3a4Cy50o7Bng44rX7RqzeWFx/0vUTTmQSLfJvn6c1cFkd2IgZSV0Xxf2
         YYpYat7GW4O6Iigl3uS6TnaRFvni9RQCQpMtXRnJUFFxjB3b0sLeVcXa3a2CjJCNOTHU
         NRmb+yccjLJFLG8CRQpxspd6qe91eYjhRWU/U9V4iad24zKddd+vkbEqnqMDb3FqeGTc
         Tj/g==
X-Forwarded-Encrypted: i=1; AJvYcCUliRYaGT/MpNwPvanCWjFR6MzKY1Xllns8TPCqwLdpsH4b//jCI2TesO7fuRTl7Fn0jh7DcayXjnRl/yNi@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywz0iy6r4MfH/EHBBWEiV06VJmyo0G1PXgspw0L2ZxPnj9bM+da
	J58a96G3CvgF1XMUzq/YnzKS5mimwDw19yBFYdYvQqfmszHeloRLvvf/4V1eacN+xaM=
X-Gm-Gg: ASbGncv93BwmQvJK8D+8EPKYOH98VPH4fQSw8Z4d1TKAEa+VLuNSHEJV7kdPwJSuDtJ
	X6xgO7CGMAKcER4QCyh7socnuci+RfSLY5Bd80f8f0IoF4BufLOiOgY0t6oJM9m+defKR1yem3J
	TqVScnnQGPSLWPhHqalvR4WGvXPY/zBgd+ULnIHktvC3OcRMzpkw4qz6n4pUAlhaHegf3JUrMwH
	YDaEYzqFoD6j4ugWkoMaMvIhMYw9QtSW2mnvEBuL3Qey9QQsdx8UYMiZpXIX9YwqxIvPQ6c5BRe
	5bgWb8ZD/dNl7wOwU/F8Zf/HIylOnjI4+CK+ak1Lg+6wjBc3ge8SfeN4iTJWuRHe43JOGaxHDim
	YqZtNd0mM9Kjsmqc4vMVR0ozaXFNpM/IYrCKqSvSgbPkFGkUfU5pFAgSHGa8xCbPE6nd7Nt7zL0
	FScJqtHPxMLZmWZ7IXcvYpJLmbR4iLZIGkOCWId+pTTc7FDcRrkpSExCIeb0L3H8xS
X-Google-Smtp-Source: AGHT+IEK7MevCpTkqeLEWcmSVsygjFUHiQ7YMyl+UgHoxYYr54MxyaHBhwgFp9OjnbWqA2BLUEIUQw==
X-Received: by 2002:a05:600c:4513:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-4778fe59a16mr30676315e9.3.1763122468176;
        Fri, 14 Nov 2025 04:14:28 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e30a:8116:32e6:5cd2? ([2001:8b0:aba:5f3c:e30a:8116:32e6:5cd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9424001f8f.35.2025.11.14.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:14:27 -0800 (PST)
Message-ID: <74af9f38baceead07ed102aef4559b6b01612c0e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Fri, 14 Nov 2025 12:14:26 +0000
In-Reply-To: <20251114060211.1742728-1-Qi.Chen@windriver.com>
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 12:14:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18398

On Fri, 2025-11-14 at 14:02 +0800, Qi.Chen@windriver.com wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> When an internal fragment is enabled, and there's already a value
> for the corresponding variable, we should error out to avoid any
> confusion.
>=20
> For example, when 'machine/qemux86-64' fragement is enabled, and
> we get some "MACHINE =3D xxx" in local.conf or env, we should error
> out and recomment users to use 'bitbake-config-build disable-fragment'.
>=20
> We should be tolerating weak assignments. For example, DISTRO defaults
> to "nodistro", and when 'distro/poky" fragment is enabled, there should
> be no confusion.
>=20
> The implementation hacks the environment variable as a way to tell
> bitbake that we're using 'bitbake-config-build'. Because we recommend
> users to use bitbake-config-build, then it should not error out.
>=20
> Fixes [YOCTO #16060]
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
> =C2=A0bin/bitbake-layers=C2=A0 | 3 +++
> =C2=A0lib/bb/parse/ast.py | 7 +++++++
> =C2=A02 files changed, 10 insertions(+)

Thanks, I think this is a step in the right direction but I can see the
challenge you're facing with the parsing. There are probably other bugs
in this area, for example what if there is an invalid fragment set (you
delete a fragment file, then try to disable it with bitbake-build-
config?).

What might be a slightly "nicer" approach would be to pass the toolname
into the bitbake datastore as some variable (BB_TOOLNAME?) from
tinfoil, then we might want to skip all of the fragment code if
bitbake-config-build is in use?

We'd have to check what other implications that might have, for
example, does bitbake-build-config need a full datastore? What are the
implications for bitbake's cache files and cache file hashes?

Cheers,

Richard



