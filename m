Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4CCAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 11:13:35 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.17023.1758021209295113509
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 04:13:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OJd+QSqv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so16345975e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758021208; x=1758626008; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDiyzLRVM+yJSwyWUIVj5deVb0ywgPkbAsH04ZiRatw=;
        b=OJd+QSqvr8yGPxTgo7C5//+S5/sXBaFQPURa6/31343R97USJBlZveUwQZxt2Y8npr
         UZsSkBHSZX0CguJfeuRN/k2pRj2F4vTFdt1j1TtspQtmOneUykGYRBHE/kBRLOV9Z8zy
         C6b53O9atnOOjynSWOlzD9hyQ/JbzpTxGy9l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021208; x=1758626008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SDiyzLRVM+yJSwyWUIVj5deVb0ywgPkbAsH04ZiRatw=;
        b=M6GsDZJ/6TTbK3Q2P2GlOqVBXbXrzbJhQ/QBQK0Grj3z2ffSnWoLFf2Sz/UCPwDfza
         RuxVo4s0eeRPd+829mcQvuv6zw2TxmEyyh17wE97ic7c3EITZlLy7J2Xt71jybYFcAdW
         dfmsvFVO31PF5/24ZWKr2FqG7fGcJO3e5jZOCHQdCXZUURAcLXnYyiXx3BsFaihEr1ZK
         3LXQIiNcXuez+NC7Slp6P/D55RxNAhvzTe8PSMFhgLh4/6+OGwaCeNp+Chs3LIOu5mSV
         gOtRUTNo74Q4Fbm7UiDC23Qdm+ASnKGa3Rz5w/rzqOnBU5qUyTrCv9RiCAwxCYTjTGOY
         aUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwu6trmsTDIh8snqwxqNbAULLYseUI3dD8qYiNkugViCdYdXhYJESD16JwFHOqvUThdBsFF1+UCpAidWF1@lists.openembedded.org
X-Gm-Message-State: AOJu0YyLEoguyZUxwKNC7J263T/+YAvxxF4URO4TAgwL2Scl8zV48ILf
	vW9ya85+K/Nz+11ISaMUkWMApPaqROkrEEe2EC/vDQqKWwQUL9YN6X9mnmaUcb18NaI=
X-Gm-Gg: ASbGnctw6CuOIVAUuHurQkEGmfEbcXWjGw/xV2Vk2Legqd0f+tVxdpoffHMIJquTikU
	VQqh16UyGHWhEd1C4ShZndnanE0g2AR0SC0C+J3AZfmmFYRYFtq3PL+ooD/QK2KtWz4a7Mrq54f
	d56xMHHJ51LDjId2EfrgEfzxYA67OSFXHOZV4iintFXgK7qbS9UlqPurV2zBMEUrOYQKj46Fu7E
	mPw7EQKXj5mffegCEnIW57rpFumoKRhJrRI9hrAe0Grgd910RqJV2jaFG7KnA9liiZVv5K3BBp/
	2sgAPB22fWCJ9kNnCQXatzUu5B45JLiF+50DgIEeItgIKUsTfe88eAZ702Zi95J65oEK/nxtsqq
	NWAZpb/RuODpOdURyEOQLee9eP24uIM6WkulaWrEtyuBmxm6Ygwdi5ptIdsHJzTi4jNoGdQdN6/
	TjJywt8X5+DgxZKUqF4l8=
X-Google-Smtp-Source: AGHT+IF9paa97NUT+6/kwqK4M/4OvT7vVbsX9votmTMV/kvm8pGFoJuJgR1aPIuzIXlV/iQZI3xOyQ==
X-Received: by 2002:a05:600c:4e4b:b0:459:e002:8b1e with SMTP id 5b1f17b1804b1-45f32d54582mr22073475e9.13.1758021207651;
        Tue, 16 Sep 2025 04:13:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1187:545d:1fb:9346? ([2001:8b0:aba:5f3c:1187:545d:1fb:9346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015775f1sm219016285e9.8.2025.09.16.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:13:26 -0700 (PDT)
Message-ID: <27f6f0fa12a0896f708125c144bbf968c938dd19.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 5/5] parse: Make include_all support
 absolute paths
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: peter.kjellerstedt@axis.com, bitbake-devel@lists.openembedded.org
Date: Tue, 16 Sep 2025 12:13:25 +0100
In-Reply-To: <20250916000648.1182372-5-pkj@axis.com>
References: <20250916000648.1182372-1-pkj@axis.com>
	 <20250916000648.1182372-5-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 11:13:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18043

On Tue, 2025-09-16 at 02:06 +0200, Peter Kjellerstedt via lists.openembedde=
d.org wrote:
> While it does not make much sense to use an absolute path with
> include_all, if one is used, it should only be included once, rather
> than once per path in BBPATH.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
> =C2=A0bitbake/lib/bb/parse/parse_py/ConfHandler.py | 2 +-
> =C2=A0bitbake/lib/bb/tests/parse.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A02 files changed, 2 insertions(+), 1 deletion(-)

I think I'd prefer this to error to be honest as it doesn't make sense.

Cheers,

Richard

