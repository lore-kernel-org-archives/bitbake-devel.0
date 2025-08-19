Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088EECA0EED
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 10:47:23 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.11073.1755600438594701117
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 03:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B2d6mq+q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41bea3cso5460036f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755600437; x=1756205237; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRHcu2e08YtsRo9vQadFKszo1iwvH3Ig2dy4iMFn+Ik=;
        b=B2d6mq+qltVVwT9YF1/BRhzoZmuZ3wSyTeAxGYayyZ1n44ENadtyFPNsb/pR0FuW2o
         tHHxHiWmJQl+ZHutdXfBUHmjaR05a8wpgDRtVCf5qCArUZITyhPGYdfZBhavrPN14mpD
         FeVtowi4w/mrSN7jrv64aYlPZp++YMeLGILcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600437; x=1756205237;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRHcu2e08YtsRo9vQadFKszo1iwvH3Ig2dy4iMFn+Ik=;
        b=k/mGC7mTHiM9yZ5SDrngyMM5Rbwazyp/VLNx3qHYp/4sU4OnDXlSKI+bXHYeY1aDUg
         aw0u2XZM9SC9aob9URB7ShFrEk3LODPrpmG2SZ47kBSozbBnkgX4DbJ4Q8mLm92qHlNs
         6kMRyoX8lakvNUFTsoiaOSrJ8G1WiHdhAC8RFHu9biic4Lm8vC+2LkdMGG9ci/HJ21RN
         86cZwTMQknJuxCHCs8wFQBltsqCYNJlOSZTPCup8mBtHD82Yqs+qVVdOefkcZ7e6hRYO
         3i7zAtTSlfQsjz6NvV0slP8IXBj9mE8FiHiVP0wfacuh93b99agjijWqSBmR4ppkIxtU
         p7SA==
X-Forwarded-Encrypted: i=1; AJvYcCX3KiQWU17DdJTjpddNCTjcU3K6fV4A0TtTsdVJQZXYsP7S0u9dxdODUky2iWy2zcq96/MfrjEuAkE9K/lV@lists.openembedded.org
X-Gm-Message-State: AOJu0YwgMDXc8vht5mI7gbqd4Ywn2pf19IeYe1nxBJlCRfaorzF6VCkP
	bHIrvsqv7LycWy4+LSi/BqJkHWNuKULwD5JqYXpKq7FdrCBJ3Odww7Yj4X3VEaRKd3A=
X-Gm-Gg: ASbGnctJqZz1dhuVV0HjTEGXe6/0ANjoHcDypfeP7/cROMtPoYKo7HHmhX3LV0V691A
	vwcn6C7vGpLxU6TX+24TMsUOYBZjSc0KRfTD5PJ3J+Nn8ERo+9UKuawK84FFHLkjBOeXIA7SQHC
	Mq3JXzkgUosuDmhyqDeo4FR2iLkMcfVA5ttTNI1BWurvPYp282yXdWdF4eCmrnghGA8Nsq8sYi+
	nrTBBLYQPYG/SmThM7cMgmupzB7HzzHuYpn5mytppmxGkR56WZNLxmIMmHDxIGmI0xGS/ifMecY
	boeWId5SDp0UGi1VOcOV+72UqgA328afqs83Z7FgPY1FJpN23Ym+gF4V0zSv7Yl3kt55RWXSmhP
	Eb0LtnXT9kuGZJ84jmbmXJpwvBBX1Ff4E0sa90vsbizsPjCvXTmBHUfVPIgW5uH3xIZWL0SXPXi
	Vtj4et688TDig=
X-Google-Smtp-Source: AGHT+IHk78Qul7oI2QpySK4cdvE0jl3iTbaXEwwap0zzk+Rk6J04W6qPZDo2mN97scdVG5BpjykKXw==
X-Received: by 2002:a5d:5d0c:0:b0:3b7:9d83:5104 with SMTP id ffacd0b85a97d-3c0ed6c4b11mr1571891f8f.51.1755600436874;
        Tue, 19 Aug 2025 03:47:16 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3d5c:7b3b:65dd:ef80? ([2001:8b0:aba:5f3c:3d5c:7b3b:65dd:ef80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789d1dsm3179088f8f.49.2025.08.19.03.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:47:16 -0700 (PDT)
Message-ID: <5e0ca348553df238270f5abcca27a39aaddfc07e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: verify if local clone
 contains tag
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: skandigraun@gmail.com, bitbake-devel@lists.openembedded.org
Date: Tue, 19 Aug 2025 11:47:15 +0100
In-Reply-To: <20250815194401.2866251-1-skandigraun@gmail.com>
References: <20250815194401.2866251-1-skandigraun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 10:47:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17887

On Fri, 2025-08-15 at 21:44 +0200, Gyorgy Sarvari via lists.openembedded.or=
g wrote:
> In case a recipe specifies a git SRC_URI along with revision and tag, but=
 only the
> revision is present in the local clone without the tag (because it was ta=
gged after
> it was cloned), then unpacking fails with the following error:
>=20
> ... rev-list -n 1 1.0 failed with exit code 128, output:\nfatal: ambiguou=
s argument \'1.0\': unknown revision or path not in the working tree
>=20
> This happens because the during the download step only the revision's pre=
sence is
> verified to decide if the repository needs to be updated.
>=20
> To avoid this, check also if the tag is present in the local repository, =
when the "tag"
> tag is specified.
>=20
> Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/git.py=C2=A0 | 10 +++++---
> =C2=A0bitbake/lib/bb/tests/fetch.py | 44 ++++++++++++++++++++++++++++++++=
+++
> =C2=A02 files changed, 51 insertions(+), 3 deletions(-)

Thanks for this. I suspected there was this problem and your patch
confirms what I suspected. I really appreciate adding a test case too,
thanks!

Cheers,

Richard

