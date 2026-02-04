Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC590E9539E
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 13:32:47 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20390.1770211966444126447
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 05:32:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Yu37c2w4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-480142406b3so51509695e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 05:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770211965; x=1770816765; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3BwZ8IBQdwbJL5ARI6rPTCtw8xNgciE64ufrG68z1BI=;
        b=Yu37c2w4RakuwEz5HYIXxpAsd18bnhpJHX39ixIwqqz2Zy7NASh0QcfS8+ys8eBmp6
         vSNmrPuUlU806XvJQlKZNQfrRMToCKNDDGXRwyo9UJhklpkD9kVi5ofC3KNgMgi3KoBR
         P9cTqtk5HcjYs5LWPDa1ll8dOJgmL5g6kMK7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770211965; x=1770816765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BwZ8IBQdwbJL5ARI6rPTCtw8xNgciE64ufrG68z1BI=;
        b=UqdGV7rTsbBjirfRMK0Dh/Hu9rSfiiOrqe3fDXbyxGyr0tAq/qtu1bVDicBznNBq0G
         Q5lP7F9sLWA1Tgzp/Eue5UCt9HAZngTJm0yS5ZRyXKHOklY68C6xn/a+f7SUJNzZVBqx
         qTfDxjbVVLdo/JvRxja+fIIauFuGw6ufTwPpVCUAeoG/FgGuH/A61ZYtwH8RLkxuOPCh
         g3sYz2gMDmPMt6UPbnWcIfarKQwIpVl+dsWIqmOGQWTNEkg4BLZAAXEwuQgGdouv/fYl
         C07XPtxaZNhJR+BV26YjNQcUUYd8ztvlq5c1xk08/jrmfBzSv2ub+7xiRyXVqsazseIj
         r1sg==
X-Forwarded-Encrypted: i=1; AJvYcCVpC1WVgc3h72uxU2WeYARaIBWR+aHDyP6QGS1ka59H2D8bEOxmdlLpsDmUmlOeFJl0lIx0PBcG7NRmMBh5@lists.openembedded.org
X-Gm-Message-State: AOJu0YwLPqMunZad2C3U3P8FKZR86lk97/BvF/Wa4EmZxs7xLAM+i3A7
	r6VicoK8q1YsEtlaV393vnuL0JOcdICzbJp8rlRZnzwZLL+rapgRXZmsLW0/gHae+iM=
X-Gm-Gg: AZuq6aLPfLPv2aScWZSuiJbpvwP/TX7Z+A9tc7XKA1yw26yCHBhp9vNBRMkWWn9pPqB
	jtJieUeo+hmWrTgWrjeOEkabunHoFVAM4DY4NnKBbVSzdATkG416Hbv79L4icU3psBDmqXzyoio
	u9BiolF3NuiDv82ZJT55nkrQDxLNo/2q5//+VH2azlVP8mXd5ltkenLUlYW871mOkMUBDqLfaNz
	vRWJAMKEIVZfYb/xQKqBRkyLL4bkJ5AZv/o5eLEzzGsb9WAe1M9zxBlFaTE7ccAsgKGcvwwnzaf
	sVqIbGJxRCWhipKuS/4U5XuiJ6DHDkcq7/R7025N6Kd9yvhO9PAcCT/zDsa5ffYAMxdBQlo1+UH
	ajDfFUMX7ASOOYi73ZCyPN2r4CoufIR0yKajr3tD0WcGSM10SvS4RaE4bwU0wi8o1MPXnnZ2I+2
	215nnxcI7HwQgbg6jiE8SC/Cob8wFmlVvsMa/vC7M14faJJg90sdJbjokuULr4KoHTM0q/zqquX
	/o=
X-Received: by 2002:a05:600c:8489:b0:483:ea6:8767 with SMTP id 5b1f17b1804b1-4830ea687b8mr40244435e9.36.1770211964723;
        Wed, 04 Feb 2026 05:32:44 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac04:f180:6f5c:7b1d? ([2001:8b0:aba:5f3c:ac04:f180:6f5c:7b1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831091a0e9sm77799335e9.10.2026.02.04.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 05:32:43 -0800 (PST)
Message-ID: <ad6217119fe0e7382684ef6a41078e172a4e8498.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] doc: fix the switchers menu
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	docs@lists.yoctoproject.org
Date: Wed, 04 Feb 2026 13:32:43 +0000
In-Reply-To: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
References: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 13:32:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18954

On Wed, 2026-02-04 at 11:03 +0100, Antonin Godard via lists.openembedded.or=
g wrote:
> Fix the switchers.js script of Bitbake to show what are the supported
> versions and be able to switch between them.
>=20
> The default landing page is the stable branch and shows the BitBake
> version along with the corresponding Yocto Project codename. This
> hopefully makes it easier to remember the correspondance between the
> BitBake version and the Yocto Project version.
>=20
> This works thanks to a set_versions.py script, which is largely inspired
> from yocto-docs. It reads the tags from the repository and tries to
> guess the currently checked out version of BitBake on which we are.
>=20
> The "obsolete" warning is now also shown when browsing outdated manuals,
> meaning any version not part of activereleases in set_versions.py.
>=20
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Note: This will be accompanied by a patch to adapt the Autobuilder to
> generate this file for each release.
> ---
> Changes in v2:
> - Remove environment information grabbing mechanism, making this fully
> =C2=A0 standalone.
> - Link to v1: https://lore.kernel.org/r/20250915-fix-switchers-js-v1-0-52=
3ef53fe802@bootlin.com
> ---
> =C2=A0doc/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
> =C2=A0doc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +-
> =C2=A0doc/bitbake.yaml.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +

I was about to merge this however is there a requirement to use yaml
here? I ask mainly as we don't currently have yaml config files and I'd
prefer not to start adding them and try to remain consistent with what
we're using...

Cheers,

Richard

