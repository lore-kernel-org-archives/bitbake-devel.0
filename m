Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31B2E7E366
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 10:16:28 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8650.1775211383755813878
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Apr 2026 03:16:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Wyze+HzB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d02a71526so1067514f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775211382; x=1775816182; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OIQNshmWK9LfBrYKKtPat+pOT+T4xEJ2Ke+8EaLXRdI=;
        b=Wyze+HzBFkH1yDBC9IG0gLgfo5GmjsHe4WOuXpcEk3lM/lpp18gKsEhkv/Gl+r+iQd
         RNaGTf0qM34FYO0eCfsJY1tEU2P+04HNd1N9NtmcE5G27NKy99lRFB30AaOBTReO5CGo
         ek/SDwXvcCW+gaxAnebiytsoRng9Q9ZW9guB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775211382; x=1775816182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIQNshmWK9LfBrYKKtPat+pOT+T4xEJ2Ke+8EaLXRdI=;
        b=rP1amMWpjqHSSBDXPmLsCQ/5DsQYX2HJf3N38eLsOUXq9gono5JGbnVvxeOH4jh+k0
         bLXTo9KUvGoV3Jk5PWO9TIN0ylKl2Vaq0gS9IB7m16eXY/O8pG9a5moG2q26922objI1
         KikvpZtd48WafvwLsAKMVmOtI36n0DdJZUNbxOb+EZgqIHMkrSZa3QrUjGBgJ2vQmFou
         RAiVFmO60Y2p1MDIdGUcjA5laSRZg3zuNWPuMybWjYH3RPLJvlqSf6btMM5QKqqzwjZr
         pd0bP9QL4+Dp9Pr6dnrWzccJUC2McdUeSet9fF6hjhrFgDY4RUOeuB5VC7rTWvwE/Cpm
         f+pw==
X-Forwarded-Encrypted: i=1; AJvYcCW9/NNfZBxdPozuvOexuNEGjixcwTcYRhbDDJMB3onu3S0EoWMgPYDaSfOEk/tN1kb2AR7+CnRyosAGL0ug@lists.openembedded.org
X-Gm-Message-State: AOJu0YwYDql2NBEim/9YmTSY3ekKD6qfEoxSxFGwpimpsoSow4bc2c7s
	6ui2SimnA6XgcpqiKjwvr8mk1s+2LA+PYi+htCLOBzFgsDn+8KC0kBIh5smzRXG8MCI=
X-Gm-Gg: AeBDievP4zRg/nEhWGAq5sN+4pLHO2xh2zlzx+d0Fo4h6H2xXeJ8DCzJy0Zce4EOLSq
	YivAF8GYjioqWSH7MHKPZXCc6Dxw5EgvtJ4/+7TmztVWNdnz7kCnxOw1filLG2P2zRB7f0O1Qn1
	FnECkRhx8POTjmYvpGuhTwjha5qPDBVxYhnOL0ZW5AK3wwiV2NEBuAAYYE9XpAMx8F9m6k/ARoT
	izgPmslh8DMhU+s6ZFKhTUING66B8Q2Sj/OCmiXX9HnuHfRQ0gUqq5I+RAymCZmZkMuz7Z0KXXB
	jSByMG/zKbW5twK2p0OZGzdQeSTSZ8+CUHtCLIM6qLv9CadCVXeY0sRuUmdDVlsSKzAA784tOTv
	185Uw6QJ1W6/TfyRAi99ri54VjUxX5ZGvjbezY7F8GAd5JuuFRLsDdYFVsKbLZ6aUYR4akxMz9B
	LEbe22SQKvPlqf7afchvKCcRtxmY0Prw+hiq8n4f2rKph77T7cKfFdnCtfKcJXG/G6ApvsAOMta
	H40RZ/mPzkePw==
X-Received: by 2002:a05:6000:208a:b0:43b:492c:8345 with SMTP id ffacd0b85a97d-43d2927f4bfmr3510332f8f.10.1775211382112;
        Fri, 03 Apr 2026 03:16:22 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d1f2:4cb0:580:188d? ([2001:8b0:aba:5f3c:d1f2:4cb0:580:188d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm16528695f8f.8.2026.04.03.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:16:21 -0700 (PDT)
Message-ID: <ea91cc2bf0fcaeee1a152e62f0ebfd367b58b2fa.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] bitbake-setup: rename
 "abort" rebase conflict stragegy to "halt"
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, antonin.godard@bootlin.com
Cc: quentin.schulz@cherry.de, bitbake-devel@lists.openembedded.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Date: Fri, 03 Apr 2026 11:16:20 +0100
In-Reply-To: <CANNYZj8=z7U5jpCN+NaAmTspYduH=pcMohMcbnqGp8mQvmHoiA@mail.gmail.com>
References: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
	 <20260331-docs-fixes-v1-1-45ee34341e72@bootlin.com>
	 <6f743774-fe4b-4e9e-ba99-6ffe1d76a51b@cherry.de>
	 <57bb4e5300a4be34f4cfddcf41d9a21b5b7bc579.camel@linuxfoundation.org>
	 <CANNYZj9U3BYUv-cvQvmu7d=8O82Gdg-2GSon6vNJ71BMi6bKsg@mail.gmail.com>
	 <DHJD5ZA0XGWN.3LDDWNE9PDM1X@bootlin.com>
	 <CANNYZj8=z7U5jpCN+NaAmTspYduH=pcMohMcbnqGp8mQvmHoiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 10:16:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19319

On Fri, 2026-04-03 at 12:04 +0200, Alexander Kanavin wrote:
> The trouble with =E2=80=98reset=E2=80=99 is that it means resetting the w=
hole system
> to its initial state. =E2=80=98Abort=E2=80=99 is about a stopping a parti=
cular
> operation such that the system is returned to the state before the
> operation started.
>=20
> I have no idea how INI has utterly failed to catch these nuances in
> its rationale you linked, and is even accusing the term of =E2=80=98lacki=
ng
> technical clarity=E2=80=99, but it certainly doesn=E2=80=99t help the cau=
se.

"reset" also struggles as "git reset" means something quite different.

"attempt" is probably the closest other option we have since that
describes what it does rather than the way it recovers, the recovery is
then just implied.

I am torn on this, I recognise the concern around the word, equally,
the word does have two meanings and we do clearly fit one of the cases,
as Alex mentions, we are inheriting the issue from git too. I fear any
change we make here will hurt usability.

Cheers,

Richard





