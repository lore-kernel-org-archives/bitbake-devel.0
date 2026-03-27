Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7063310F285A
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 17:03:58 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.77616.1774631027797941709
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Mar 2026 10:03:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Pg5vyYMu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1324666f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Mar 2026 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774631026; x=1775235826; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hxrV2WhAQo08zW8EF6oBc6Qi15SG9LJwIf9Qtwtu4cE=;
        b=Pg5vyYMuD5HUYbc2Bndj2/PT4VR7ypB5jfB3Y43+uRrCNvserEromF9vsVBggcRre5
         KzYWoAQc0RqkvCWTxNZuETQQr8i20Ti35nOcQiNGsT3xvZIKNAOvdCOQmJEi767DTf7Z
         csGP2MNJVip60QtjDscuzujl42744mV5d9KJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774631026; x=1775235826;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxrV2WhAQo08zW8EF6oBc6Qi15SG9LJwIf9Qtwtu4cE=;
        b=izY6u/s0zLW4TwbuzPhcsnzZY/VfBvK6R1mnDx/QEBiZF/iHWM6lNYKcUDRvUqnAH3
         XixjIeIYuEfLTCL1qNKxgvjg7ryKh8ZDV3pTZ1DGe4nZr3f/FdQsxmKf+1ISwl4T78X5
         7EOmKBJU6nbmaLWyuRhSV8HpcZw3x+hnllRMHyhyILVqcAygs3P3DKjTCW/eOQ2BGv8B
         GkPvIRC2jVZ8Ybi4U4pRllFWFGLPov3mol0bk9u8/xyGxMwDPC258Okk0TDmR62GgBke
         C86DYoPjZwjrUMhp3fMdd+tYqspxwWen0YX1XGGnF11OzGHdihxjV0hifTVvLuulH0UF
         my9g==
X-Forwarded-Encrypted: i=1; AJvYcCU482lklQ1/LNyseNe7AAXN0S6Y3SMiL+MtxGj5A+XzjfX7YGUdvEkO7IYbkUhP60f1Q95QrlC7N/Hvg/IN@lists.openembedded.org
X-Gm-Message-State: AOJu0YyV+Ke35jAI8qtJPpNHzuVAI1zkKoIUZxIPB9m2bBV2dIskYRL/
	FgMB5vrzKFxITtGxq5GP6Pk15WnYAA7JSne9ycxFvKBY7led+/OJpg/IymL8X5FOjeQ=
X-Gm-Gg: ATEYQzxbZLHTo1sSANnHNIk2iCiURkIEGQb6149tpGpjQ+qVEbHuLB9ttFdUAGuHtIs
	n4hHtWY22nWVB4Wig1KIlVsQs40ttVp86LZbuNPdpsyfUWU/gBojELKh7plHgJ377qQyXVR5H+B
	EoGX14Duv1ErAkg/3Xo7TVZE0rg+L/4RVTtt4UNgMgCChdVZ/KHD4gFA4S0z1mPDmmHutodFzbo
	GTPwspu3hy0I+o1NPuPNSTHErklZy6+mgyo3fADjAmgbrveQ4Utu+T33GPm3gVE0KTux5foHN85
	P1hEb/S0cePWc8KdXWsYZK53ssCYj9b3aUKyFTVYbM+GTdguLIOJmRz7KEz03WZfW0PzEuY5tnE
	M7lOb+n6fhol7Ccj7owunxJ9xBpKI5Z9ieJ1xMZ16s2V872NZdMEAYnCuF97N4Z8hU2q75rzYVb
	oiGz++LwBtQezCzmEm6IEtcgyZDhGpX47T/xoE2iyfiglThqBxt42XgpWrcI0ZvT139YLg3bnCI
	jR/T8iB2dJxA0G4
X-Received: by 2002:a5d:64e6:0:b0:43b:8fa4:1937 with SMTP id ffacd0b85a97d-43b9e9d5ea1mr5604640f8f.5.1774631026055;
        Fri, 27 Mar 2026 10:03:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4d9b:9818:1b9c:6027? ([2001:8b0:aba:5f3c:4d9b:9818:1b9c:6027])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91943312sm17090408f8f.12.2026.03.27.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:03:45 -0700 (PDT)
Message-ID: <aa7e9473a5d2712f16b0edb366af9b172779397c.camel@linuxfoundation.org>
Subject: Re: [PATCH] Common BitBake Versioning
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rob Woolley <rob.woolley@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Fri, 27 Mar 2026 17:03:44 +0000
In-Reply-To: <20260326173951.519326-1-rob.woolley@windriver.com>
References: <20260326173951.519326-1-rob.woolley@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Mar 2026 17:03:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19261

Hi Rob,

On Thu, 2026-03-26 at 10:39 -0700, Rob Woolley wrote:
> We discussed how to version bitbake and bitbake-setup on a Weekly Tech
> call at the end of January.
>=20
> The initial proposal was to use the git tags in the bitbake git repositor=
y
> to dynamically determine the package version. There were complications in
> this approach due to conflicting conventions between how the Yocto Projec=
t
> maintains git tags and the format accepted by PyPI.
>=20
> A simpler alternative of using the version strings directly was proposed.
> The request from Richard was to converge the 2 version strings for bitbak=
e
> and bitbake-setup. He asked for it to be sent as a separate series from
> the PyPI changes. He also asked for some sort of version checking in
> case the scripts find the wrong version of the bb module.

Sorry, I think there has been a misunderstanding here :(. I asked that
we reconcile the version strings from bitbake and lib/bb/__init__.py

I'm worried that we might end up with a bin/bitbake being run but a
"lib/bb" coming from somewhere else. The current versions are compared
to check that but if we install bitbake-setup to somewhere, I'm not
sure how we'd continue to ensure this.

Putting a "version.py" into something we inject into PATH does worry me
a bit as it is a very generic name and it doesn't really avoid the
issue above I'm worried about.

Cheers,

Richard

