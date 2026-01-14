Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC66D30CFE
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 10:26:53 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7171.1768386411296902158
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 02:26:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P7qWuSRs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so2907795e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 02:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768386409; x=1768991209; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3nK2Xv7AH3YghajNyUckQCl3O68D3LZY2tJp37tMBeo=;
        b=P7qWuSRsegDGYjPyH93R4+JXhS4XTFO1MEOry+Yng6ktYesfw2UYF5K+4PL5HfmOAA
         VpqUEh816cOGsp0bQDR6YiWPOeoDBl+1Ytkys20XKDG0FccgFx/ympv9Rs1n7nFoapol
         vgZZ3UlrRrAxeKwpK4xbQHg57RLTdhQ+FIle4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768386409; x=1768991209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nK2Xv7AH3YghajNyUckQCl3O68D3LZY2tJp37tMBeo=;
        b=eVZn1kaIte7itfUl8mSAyJdRcMlACQetLjWE2h5eW8KyeYAqXo5nDYwtTy3epWIzWX
         DUukeoNhp988b8LKDSWuiBQ9V5/U1yM0KtskFLhKI+v7XlCfqwSDGsG5c3ybkjebEmUl
         0jzkZ6XMwEa+5uDJEg9/bw3ilTw4zHk290iw7cKr9OcDIMnfltwuLRHrczTAxE1rgzRV
         Zf5NXRukn+Jj74kasLePi+RCaPQxaVDTf+NvG+8qkUaLLG7DfcWQtf0rrgVMq4OmzhjK
         tZEHUvhbmT9+PNvRwoxqp9FrVTB0a3WuVbTfkGMXYcHztUAkFHB2XLHbxsenu4YeI6rl
         G5dg==
X-Forwarded-Encrypted: i=1; AJvYcCXLFHlfBH4+kZw5cmjPlZrDBzUDbveAk5JILt4c7kxg63wjPeJphRZrWNPDiSOiV8n9Xp+AOwnjtPfPlt7V@lists.openembedded.org
X-Gm-Message-State: AOJu0YzvgJZ8NvnjpC8SnoZuxfUbUEU2MmAft4alTCkGu5VSUIciONhS
	T4N24/+0w5yhA04AKbJhXgrLG9bOq1niumfI82n1/V6cnXVmNuV0ptlDgt3zZFrwSEA=
X-Gm-Gg: AY/fxX5LYeXEOyrJ9YuTMF9bv5xnt2+Lrqx0VFykKOqPS+jmMwC2Gtmzq8hKu+e6sWG
	V8WIIrmUqC836LQRKQoyLXsg5y9A/E3MS4WiO47R/rK0cYybTCM1hdz1sqSHWbRjtSm2eh/szEg
	AaeVZ95yhLK2YyTLHBu0/8Xq1+sKVl5c6GVPlWCmaTrEVnNr2w9vsbIQLHTwgARIt2lX77wBXHY
	5MI0yfl6D3E8V+lscZKvWg/D8rRG5TKxFbIUVMIxLej63oyBwJ+KrIUMacpfqHsXI3VxW937dSc
	XvEIcBVwPrO4ibSqaYAfhsh1KiOz0rNzqA9NOHb5GRTVRQUhlNJ64hiX8I2iAnHAq5s8KgVB6QM
	xGZZy9jv2sya+EAVkpQk1XWelN71pbrkhvfcolQM5tusyzIktVgRJ3tXnJoCsafkguUmX+3uS3E
	5cWbzqWpZqCUy3a1jOMFZ1L21/CtaBHuGaYuDJ7Oba7+I8XmJukBy0y4avIv76g/52dIQE3Fzhc
	Jg=
X-Received: by 2002:a05:600c:c04b:20b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47ee3372b78mr16017495e9.20.1768386409505;
        Wed, 14 Jan 2026 02:26:49 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:94c7:73b9:87a6:4747? ([2001:8b0:aba:5f3c:94c7:73b9:87a6:4747])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27ce2b2sm17709635e9.5.2026.01.14.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:26:47 -0800 (PST)
Message-ID: <0adf825db9501818398a9ef04752e4000bd3133e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: use internal registry if
 run from git checkout, bitbake repo otherwise
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Rob.Woolley@windriver.com, Alexander Kanavin <alex@linutronix.de>
Date: Wed, 14 Jan 2026 10:26:47 +0000
In-Reply-To: <20260114080414.2927046-1-alex.kanavin@gmail.com>
References: <20260114080414.2927046-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 10:26:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18749

On Wed, 2026-01-14 at 09:04 +0100, Alexander Kanavin via lists.openembedded=
.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> If bitbake-setup is packaged and obtained from pypi, or another package f=
eed
> it needs to be able to find standard configurations. It is not impossible
> to package configurations into some location inside the package
> and add logic to find them, but it is much easier to just fetch the bitba=
ke
> repo and use that as a configuration registry. The other benefit is that
> such packaged/installed bitbake-setup will not have to be updated in orde=
r
> to obtain latest configurations: it will simply check the registry and fe=
tch
> them as needed, which is the original intent of config registries as repo=
s.
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
> =C2=A0bin/bitbake-setup | 12 +++++++++---
> =C2=A01 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 2c2b6d8ec..dc0c4b1c4 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -21,8 +21,6 @@ import signal
> =C2=A0import functools
> =C2=A0import string
> =C2=A0
> -default_registry =3D os.path.normpath(os.path.dirname(__file__) + "/../d=
efault-registry")
> -
> =C2=A0bindir =3D os.path.abspath(os.path.dirname(__file__))
> =C2=A0sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), 'lib')]
> =C2=A0
> @@ -37,6 +35,14 @@ GLOBAL_ONLY_SETTINGS =3D (
> =C2=A0=C2=A0=C2=A0=C2=A0 "top-dir-name",
> =C2=A0)
> =C2=A0
> +def get_default_registry():
> +=C2=A0=C2=A0=C2=A0 internal_registry =3D os.path.normpath(os.path.dirnam=
e(__file__) + "/../default-registry")
> +=C2=A0=C2=A0=C2=A0 git_registry =3D "git://git.openembedded.org/bitbake;=
protocol=3Dhttps;branch=3Dmaster;rev=3Dmaster"
> +=C2=A0=C2=A0=C2=A0 if os.path.exists(os.path.dirname(__file__) + "/../.g=
it"):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return internal_registry
> +=C2=A0=C2=A0=C2=A0 else:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return git_registry
> +

Probably a silly question but why not just check if the default
registry exists and if not, fall back to the git url?

i.e. why isn't this just if os.path.exists(internal_registry) ?


Cheers,

Richard




