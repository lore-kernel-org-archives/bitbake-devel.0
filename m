Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4D1CD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 13:31:49 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19477.1781789500120107425
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 06:31:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bnFGdv33;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bf84a2b2077so114137466b.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781789498; x=1782394298; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z7oagoUzGA3AWwoYmYyduUV74QYqSRN6tQM05FcGPc=;
        b=bnFGdv33i0LBiy/21GvPz29zLmlOjwDgrDyTsFGLG1zhM4HOfrYUe1IxfHeNzpMwGR
         Dx69R0vutup+oEzvFFGJvnXK/l6m6nVfSaRfYttkboT6QMrgfUsCy4Xsheid/McGZ/KM
         iQDkzFEyGqsUVx3D8BQBwwceIpBXnStjnq+HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789498; x=1782394298;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1z7oagoUzGA3AWwoYmYyduUV74QYqSRN6tQM05FcGPc=;
        b=I8lmA247v5fF+bfdFCyXeSOxFijMcQr+3AqAF9hCJv1wclx3xQB5rk0Jf41RUa28nG
         M4Wc2dbQpssXmUb87ep4ZIroN1dA2v4pnmbG7JL0jxEwHr51pxh+ABKhhYsZw7n4rE76
         mHR1MDpOSgfW7vIVMJzcD+rt7UpWWWHozhSvDSz/eTsRsyP9aH/Ujkd5m5AyxTm+3cfM
         3Qe13A4mBLmk0woZRZdoHgJGaGjP9FsQUlVafnnUWMzebcOQ9Sixzy366ILENeIe9WUT
         8k01wIFObroX2RUZxqSFNBFK1zeYMs5/Lv44ksNLBBwCxXYYDYoFIuiVoF5ZsIcWwRI6
         WbzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wZLAb3Y6vqa+c7AhPv7ht0iZ76CHBj2k3hrfQ5SUwr35MDFVtip5K2dr4y+xnWriMVVQUwXf5tFRvuoVi@lists.openembedded.org
X-Gm-Message-State: AOJu0YzcXQnuVXaUHs26K/R/HyS0vD7XzM2/HBTKvx1Pb28ESYVduBSZ
	Fnk5gL5+Vfk5fdhx8n2DE5uYtnxQbYLje03oc5UV805OPRIYvWy9pzDVa+pNjnIEAq8=
X-Gm-Gg: AfdE7cmd+MB63KCyl/MWXHl0M4Ulbh5Hr1KlO6TqRmWISCbaUG6JZDheR2TgKkNdE1g
	xI2I5bpSC1Oc2da4w3xuJr5MsX5Sgpa0nI0qLaIJpAR/OXcsbTJ+1Zvbgippn9slhT63ROG+0Dx
	0gPTDDV+ejnZfHnJ17JdEX60Gk322MhmXLxH+uLOncm4DohESfqX1kV6XEBY28mEKBZWt3/zJxe
	EmU9fLdZHpaH5mGb51BWKUj9Inh/Xg7BqGM3UJaUaOoBFYzuGEM2RfcKmXhXl8yxcxuSjmilFHr
	wtEaHHimPOJ6S9BiwJvc2B4o68gPr/9L1j4DUy6GfsfoodRtQc/sSSITgBTQJo+4+tF/KegZ3S1
	ywputGP8EAn+07G+adofswUFYA6Wr3hyUNngIH7gBkG2w8qEpvPPdzj4YkUD/w/MDa0ZJPxJ/5x
	NNR8bMP9UFl2cNR5nerTfb8/PGuo2LWs0o7MCmhcizWD2z1/6Tf0w7q3Fmy9dJqRlw7AwCzRt4w
	O/xfQ==
X-Received: by 2002:a17:907:3e04:b0:bfe:ed74:526 with SMTP id a640c23a62f3a-c05a83a19f5mr567509566b.53.1781789497770;
        Thu, 18 Jun 2026 06:31:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:70bd:e97f:6372:90f9? ([2001:8b0:aba:5f3c:70bd:e97f:6372:90f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb44203c9sm958687166b.12.2026.06.18.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:31:37 -0700 (PDT)
Message-ID: <c8fa8109664c812686866b2ff66ed188c419d106.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 03/10] bitbake-setup: Add checks for
 version information
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Date: Thu, 18 Jun 2026 14:31:36 +0100
In-Reply-To: <20260616-add-pypi-v7-v3-3-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
	 <20260616-add-pypi-v7-v3-3-fe224e3ba878@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 13:31:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19740

Hi Rob,

On Tue, 2026-06-16 at 14:31 -0700, Rob Woolley via lists.openembedded.org w=
rote:
> The __version__ has been present since bbmake to ensure that the
> Python script uses the appropriate bb module.=C2=A0 Other bitbake-*
> scripts do not check the version.
>=20
> When executed in place, the bitbake-* scripts manipulate sys.path
> to find the bb module in ../lib. This path is inserted to the
> beginning of sys.path and it cannot be overridden by any other
> modules named bb.
>=20
> This commit adds a check for ../lib/bb/__init__.py before making
> changes to sys.path. It falls back to importing the bitbake_setup
> module using a custom bitbake_setup package.
>=20
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
> =C2=A0bin/bitbake-setup | 29 ++++++++++++++++++++++++++---
> =C2=A01 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 664bffee..ed9b0947 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -23,10 +23,33 @@ import time
> =C2=A0
> =C2=A0
> =C2=A0bindir =3D os.path.abspath(os.path.dirname(__file__))
> -sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), 'lib')]
> +libdir =3D os.path.join(os.path.dirname(bindir), 'lib')
> +bbfile =3D os.path.join(libdir, 'bb', '__init__.py')
> =C2=A0
> -import bb.msg=C2=A0 # noqa: E402
> -import bb.process=C2=A0 # noqa: E402
> +# Obtain __version__ and import bb
> +if os.path.exists(bbfile):
> +=C2=A0=C2=A0=C2=A0 # Execute bitbake-setup in git repository
> +=C2=A0=C2=A0=C2=A0 try:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sys.path[0:0] =3D [libdir]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 import bb.msg=C2=A0 # noqa: E=
402
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 import bb.process=C2=A0 # noq=
a: E402
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from bb import __version__=C2=
=A0 # noqa: E402
> +=C2=A0=C2=A0=C2=A0 except ImportError as e:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(f"Could not import bb f=
rom lib: {e}")
> +else:
> +=C2=A0=C2=A0=C2=A0 # Execute bitbake-setup installed with packages
> +=C2=A0=C2=A0=C2=A0 try:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from importlib.metadata impor=
t version, PackageNotFoundError=C2=A0 # noqa:E402
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 impor=
t bb.msg=C2=A0 # noqa: E402
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 impor=
t bb.process=C2=A0 # noqa: E402
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ver=
sion__ =3D version("bitbake_setup")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except ImportError as e:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
(f"Could not import bb: {e}")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except PackageNotFoundError a=
s e:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
(f"Could not find package bb: {e}")
> +=C2=A0=C2=A0=C2=A0 except ImportError as e:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(f"Could not import bb f=
rom package: {e}")
> =C2=A0
> =C2=A0logger =3D bb.msg.logger_create('bitbake-setup', sys.stdout)


I don't think this patch is quite there yet. To solve some of the
issue, I've sent a bitbake __version__ related patch which adds the
checks to all the bin/* scripts. This is part of the guards which I
felt were missing if "bb" (or parts of it) are going to become
available through pypi.

With the above code, I can see why you need to change the way we're
importing bb. I don't really like having the noqa: E402 scattered in
the code, or the duplicate import blocks.

I think after my change, we should just be able to inspect __version__
from the imported bb, which should allow the duplication to be removed.

Could you have another try at this patch on top of mine with the above
in mind please?

FWIW I have merged patches 1, 2 and 10 from this series which should
allow us to make progress as those were ready.

Thanks,

Richard


