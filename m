Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4DC19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 16:33:41 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web10.15158.1740674012011336671
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 08:33:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IvHDF1k2;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c081915cf3so148582885a.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 08:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674011; x=1741278811; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE28vjjgYjL/+MmbXoLSoUdnR2YkulslPNxMaDhrwk8=;
        b=IvHDF1k2USq+pasqdwJjPzenAoZvvEJbxFcdU0LofWto2cnlcp5RK7vgnB+UI/K/ZF
         8hHFzMfOzoJ9fnsDFVjNwBOcnMxRP2YQItXFSg9L/kOlRQTXDT1ksNKhyefcC18m93RS
         bjDQohWTTqRptjGZxhRu7M1h+iVUfx+F6uY9DxSC5uc2Kx47OrkHVdqe+0LKzEURx7Zj
         +HzHwvWwrRk8gwH93Ii2oW8WnBnkKM4AhB3qOqk4ugeiuGscnvTQeayqN3zCQbtwIvwF
         wKynrznp0wV/hwFGY+b7utwWbISwrlLku5WhWlC+8JNEp2yo60vTry3hkvsk4a+ACD7p
         FswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674011; x=1741278811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE28vjjgYjL/+MmbXoLSoUdnR2YkulslPNxMaDhrwk8=;
        b=FkAfZzwMljkv/jOaTzlRniz6jLuT5RNEDvihYgkypnIQHr9ZOSZ8RZ4BGtq6egpBGB
         G3v09jl0G2Kjh/EqX7viE5XuV5U3Ry5EBQxQ1HKCJstvKSC3rZu1qO6+kaG8Pz42tD8A
         UwP/CYhq/60mtvVrB52LYqw/Zlbg+zKqRzJIOSarafK6bSVN86qHL8DH3DFM0fo/6zrC
         ezcsIvydwNjNb/0bjjBa9EFXMbeMfIhC3tI974GTG1tMqC9Nxg40VzSr641vk141e5Iq
         L2U/a8Aa9/Y0X63nvzBYXcw++3D4BggNZMY2OwtC5nXsBU1p1ntkswcgQzWGnHz0T8Az
         68Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX+O0FymWip4QXNk09CfTULk3gf7RCHF1Er5Ob4qnNOzga2N0L4attvVtM1FLWgTCs8EGhsDUDFFd4PRcse@lists.openembedded.org
X-Gm-Message-State: AOJu0Yzwd11uFmkisW2oaTqCnU0pxw+PiSciE17MrFsouGaAiQSr9zOR
	OIY01cf0QRfcyBWuxLXHzGgcv2xAvXPdKLCjZV+AtD2KKjMF0/uIwQu/LtxufAFpM8PeuN+VZPS
	Gepc7FqYZxZTIhQvQv2oU8taJwKo=
X-Gm-Gg: ASbGncsC/60CgtDvB/6oziJzbuEb8UHIctn0YUjOg2Bjsq6G/NTTCpUA4N/Id+55vh6
	YnQ9V58Z8khTzCmQon3CKfeDX3nAUWj95M9KKwmQO3iclE8bmq9jFbs4jVqPMbo2sLbOuiLSo2D
	WF4CXRV9o=
X-Google-Smtp-Source: AGHT+IEIQy//btD372hpqfVILd/aIU5NVFxn/Zh0qVYHFZqMVD6CAAYyp9Umz32EgRsGCRWCpIaWht5x+/04o16HP4M=
X-Received: by 2002:a05:620a:2991:b0:7c0:b3cd:9bc6 with SMTP id
 af79cd13be357-7c23be1186dmr1656554385a.18.1740674010430; Thu, 27 Feb 2025
 08:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
 <20250227090853.1632280-3-l.goehrs@pengutronix.de> <CANNYZj_8DU=8eFrbjEBPhupuu13KG7a19V9z_zcj+WPhWAQ_ig@mail.gmail.com>
 <c800a81e-d6cd-414b-a0bb-e011ca257bf9@pengutronix.de>
In-Reply-To: <c800a81e-d6cd-414b-a0bb-e011ca257bf9@pengutronix.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 27 Feb 2025 17:33:19 +0100
X-Gm-Features: AQ5f1Jpn6mLGBWbZ-cmb3CB4d1-hLXdZn5E-0gip7JBrTpaPd4jPWsWLv-sPaOI
Message-ID: <CANNYZj-2zn4LxP_4Bco4hWGVBG_3=waEAsvxPnWSC35-E6fSWA@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH v2 2/5] fetch2/github_release_artifact:
 fetcher for (private) release artifacts
To: =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Cc: lgo@pengutronix.de, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org, yocto@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 16:33:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17347

On Thu, 27 Feb 2025 at 11:37, Leonard G=C3=B6hrs <l.goehrs@pengutronix.de> =
wrote:
> I've had a look at the `.netrc` / `.wgetrc` documentation and it looks
> like it possible to provide custom headers in the `.wgetrc`, but it do no=
t
> see a way to specify which hosts they should be sent to.
>
> We could add a mechanism to `wget.py` that searches for a per-host
> `.wgetrc` and maybe allow overrides via a `SRC_URI`-Parameter.
> But I don't really like the idea. One misconfiguration would mean silentl=
y
> sending the GitHub token Authentication header on _every_ request to any =
host.

You can't make the argument that attacker gaining access to protected
artifacts is not a big deal; if it isn't then why are they protected?
Just publish them openly, without those pesky tokens.

You similarly can't make assumption that people will handle those
personal tokens with care; they won't. They'll put them into layers or
otherwise share them, against everything documentation says, because
it's convenient.

AZ_SAS and username/password support in https fetchers are both bad
precedents, and should be removed. The correct precedent is set in the
git fetcher, and with the recent changes to npm fetcher: bitbake is
not allowed to see secrets, period. Bitbake was never designed to
handle sensitive data, and it can easily leak into for example logs,
which are then published in CI for everyone to see.

What could help is wget picking up additional settings from a
wgetrc-like file specified with a command line parameter. Can you
check wget source code to see if /etc/wgetrc and ~/.wgetrc are both
hardcoded, or is there additional parametrization possible? Raising
this with upstream would be also appreciated, perhaps you can propose
a patch. Then we can think of how to provide those custom settings
from a fetcher.

Please also see the discussion around npm authentication we've
recently had, as it has many of the same arguments and approaches
discussed, and we were able to arrive at something that satisfies all
sides.

Alex

