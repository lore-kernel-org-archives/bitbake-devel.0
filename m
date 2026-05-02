Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B2CD3424
	for <webhook@archiver.kernel.org>; Sat,  2 May 2026 09:05:30 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3181.1777712722162826633
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 May 2026 02:05:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NWErBHNJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so38106675e9.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 02 May 2026 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777712720; x=1778317520; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YTBhi9j30Me3NWw8ckGHFkK1s8HUDeHoCGf961OmTV0=;
        b=NWErBHNJbPCyzo67Ms0x4rD+K306L06Dgg/wxdcUfHK1uoQH8Z3XAaiU7klnF/jPFL
         wkJzaiN1NhAYbGFa7okHHPmJY+ILcnyBf5y9tL1mIzgTbqzvya5+/jRrq2FJ47mF8cQl
         498uNpciP3Hg8XKajnKZz7MZkEvn0t3rb4OXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777712720; x=1778317520;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTBhi9j30Me3NWw8ckGHFkK1s8HUDeHoCGf961OmTV0=;
        b=bUaKWhcu4HzDE4TKuCerTG6drq/dJjwy3sN+88ZmCX80QuEbONJNkpd07HaV+ehlYh
         7xU6KxdLK41jp/v0c1ywD7pDVOnYJOCpR8xHu5rMkCsP9Kq57l2Nz8SZW53/4lWwkgQw
         Iw/VQchO+CqlNvdNPcI0cfrf3colPspDGFtyXVCBYaWRvVtrSMbJH8S8E/2K4jCqGTIC
         /DtQa6c956D6UVNtyhjHZL5z8IXRKdVv5PZx8kgx72eUdtXZC4914IAsCm8K9qexxauI
         qzpWO/JLc8cHrPRRxx3/nEAZe4ekX/+7qpmMChYZnqlgc7g34q19+qILuWSFksarxNkC
         8MXg==
X-Forwarded-Encrypted: i=1; AFNElJ98RDFfrVjfx/ZUzGKbxurIoabvLeFC+otzZloqdCgBdXxJTZGkGeT6W0yu/wDUteQICzGRSo1/fK7btJ5f@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy56lubUKj04YQTfxIwBwYFAPiSAdxL8ZBWgFa2stCkj2vSzRq4
	xc1ctJ+Q0v1i5IGc7hChfavVwX1WPSp2bydNooGdH3E9tRLb50cXlvX2xiOh6HpYfJfKmTBdCqV
	+trZnJjjyq3gPuNZSR/oF3mUPskDhLr6SASLWcgSVBimW6u7m9OFt1XGx2AoFHPG/noMeZA==
X-Gm-Gg: AeBDievAL9Bal+0w1YqJotI4FPPu7FcifYkyKDix9qyc8bzPC5IvcSa4r+WTEBx4S4L
	xNCXeiE6CH2hHH8Qr3ZUE80WDFilCNiKSJwyfNK/NClXG2ey854b3zT8DRDyFZfyvAmlyj1tLlv
	v4sRVZlRhMVXz29kI9GlJOITwkvz2J5r9z7RvhLhFKqdHtHiDm66XnrkORKKPFK6U5h4UJcfrhc
	XEoZFkvlgFk1eJQrQuM0bK2X9ZX4a11KybppYtoEXzzF0zkjqx9ZSMhtn7YMKrVcpWNvmKulYRQ
	Jwn+mtbhKROI0yUw1kJ/fv+/6SjWfxTAN4Df9ctmKuESe/wKUeZEhnKeYUOj6eY+lKf9OhwcXeD
	Rz+ZZe47UYobTe1tCONl6mAi1mU0C5iyUvanY6YLjRVLCxW1rz21J0BLF/ZGcdVGUFcSAqU6Mri
	KbXbYAf2cRHBBYKBNBCyQRnJ837cQGDY9LxUJyrec5hLQXOjaosxM1fQUDgDdbwo5AlqVRtXAZv
	m/bP64SwedYKKhYa4xnEdrDbRs=
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48a98662e71mr24689405e9.21.1777712720369;
        Sat, 02 May 2026 02:05:20 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8635:4fc6:d16e:90be? ([2001:8b0:aba:5f3c:8635:4fc6:d16e:90be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cfd2sm9916209f8f.2.2026.05.02.02.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 02:05:19 -0700 (PDT)
Message-ID: <3586fb9ba7e47c129f73720bc39bc19d2d37b299.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 6/6] bb: Move codegen.py inside module
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Sat, 02 May 2026 10:05:18 +0100
In-Reply-To: <20260331145319.3125456-7-rob.woolley@windriver.com>
References: <20260331145319.3125456-1-rob.woolley@windriver.com>
	 <20260331145319.3125456-7-rob.woolley@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
X-Gm-Spam: 0
X-Gm-Phishy: 0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 May 2026 09:05:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19432

On Tue, 2026-03-31 at 07:53 -0700, Rob Woolley via lists.openembedded.org w=
rote:
> Codegen is used exclusively by bb.codeparser.PythonParser.
>=20
> Move it inside the bb module to avoid exposing it externally
> when installing bb as a package.
>=20
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
> =C2=A0lib/{ =3D> bb}/codegen.py | 0
> =C2=A0lib/bb/codeparser.py=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A02 files changed, 1 insertion(+), 1 deletion(-)
> =C2=A0rename lib/{ =3D> bb}/codegen.py (100%)

Some good news is we removed codegen.py entirely so this part of the
series is no longer needed.

Cheers,

Richard


