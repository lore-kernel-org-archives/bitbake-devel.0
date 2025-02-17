Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74943C021A9
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 22:12:15 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.6017.1739830334779309880
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Feb 2025 14:12:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZlZgUj+/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso8830815e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 14:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739830333; x=1740435133; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IFy1ZdCLAIb1Kf1UqE/5mYxIgAzfbXJeD8/UXhp9C0=;
        b=ZlZgUj+/BZlH/4pPANt43qLAJkvhJBjS8GYmn1zBB2BRJM5NMm9ZVtJj2T4Tnzxdev
         6H0v7oeljfzK+6hLgH+fHg4VGoi+f/4hFOxk+tIxKWu2kuaMl+KG02qDs/f0tR/+O4hE
         lHib9cYb7qbVSp2VSUkf4euqxDfxYpJpj/Fp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739830333; x=1740435133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IFy1ZdCLAIb1Kf1UqE/5mYxIgAzfbXJeD8/UXhp9C0=;
        b=LLmxxg4jjhNyVVJUbhpx9r6qKiIvRwAKsjn5whOhfJ58RHg7P55445ti5JYHXOt7Tj
         7EQIZ+2+LIp1ARLrE1w1wNNIsNBFy4KXY37REutx4yb/BjJkaonNb3m0FKUs+rmZtpAn
         8qhloijaX3YclzY28jzw99otI4Qad4f+VEHW8nSVRPVDlD6+w44TYL9Mstak2eZFeb62
         xQni20hFQhAs99DFwHcL+cq19mqRafmOm6YsbcBuGrOWxUnTBbluMypcDSSSZ9bnxII/
         L/iUAgeq0UUmTiQeSUhTFh+VcUm2dwD73zEfYlEc5OnUb+0przNBL5Q7GGFgF/K7ybmi
         mSjA==
X-Forwarded-Encrypted: i=1; AJvYcCWOP0BMNcRARyXF4rnVdtMPQne/6jzzMV36B6Xgkvp7szKwC/1sQ59dh3hf7gK01gMLuX0liwoxkswu05tZ@lists.openembedded.org
X-Gm-Message-State: AOJu0YxXMgc0Z/PQw8Rw1w8axAl9Vujas9XDbYMmADqNomGtNFV5qvQD
	oHqaFd/AjXW3EqAA9N9ckOo/mx09yL2d+K2ZdpmosFWenc0fdt0kqC0e0lO0pIqQPdhbd29jzp1
	w
X-Gm-Gg: ASbGncvvIsadsIxbjlBgRRl7vc/q9ETV+4Teb1xspifXePCR59/wdBqlofepFw2kS2m
	vJVbeGEp9pDh4D1T8XFaaRT/Z2ZEuu8XjfYmENF8g61qkKXNCJ0KsYMY+NGmjDxLezH4jpoeTQ7
	0FrLNciD/0CR9RH3PHW4MWh728ZL+YNyVapoxxfJsQ5ZSKRhFM17tH/nTgOobLKFLaqRy3TWjXF
	MB3QkoRMilK3lF4Kvf5b+xgpibJ1N6zpXhGJcZCQIhPy+N84s+GF2WxT+/LJWSDKzpNRHiPqlwP
	pY0zh3IK9pyY3YXz+lNnl83dJe4uAjbiFuKue97CjqG07ukmHNAWfNiEIdFT4ff2yv6VclZPlhY
	+/58F
X-Google-Smtp-Source: AGHT+IG33DSnUI/dJ20E+2r8ryl812dhd/HeBziCkakwSb/EDzxiSwuIU7EjwzllnftFjsiZcP7iOw==
X-Received: by 2002:a05:600c:3b92:b0:439:31e0:d9a5 with SMTP id 5b1f17b1804b1-4396e733555mr97037005e9.22.1739830333088;
        Mon, 17 Feb 2025 14:12:13 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f127:df56:488b:353b? ([2001:8b0:aba:5f3c:f127:df56:488b:353b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267eesm68623445e9.0.2025.02.17.14.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 14:12:11 -0800 (PST)
Message-ID: <30f3b2a2f541485d0f8762d76deec6e1de94dcf1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] cooker/event: add cache validity
 checking events
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Mon, 17 Feb 2025 22:12:09 +0000
In-Reply-To: <20250214211403.493573-1-chris.laplante@agilent.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 22:12:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17237

On Fri, 2025-02-14 at 16:14 -0500, Chris Laplante via lists.openembedded.or=
g wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
>=20
> There's a "dead zone" between the "Loading cache" phase and the "Parsing
> recipes" phase during which bitbake checks whether cache entries are actu=
ally
> valid. Even at the highest (-DDD) debug level, bitbake produces no output=
.
>=20
> On my relatively powerful baremetal Yocto build PC, this phase takes 6 se=
conds
> in the presence of 4 multiconfigs (including 'default') and 40 layers.
>=20
> This patch provides events to track the progress of cache validity
> checking, so we can give the user some visual feedback.
>=20
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
> =C2=A0lib/bb/cooker.py | 10 ++++++++++
> =C2=A0lib/bb/event.py=C2=A0 | 15 +++++++++++++++
> =C2=A02 files changed, 25 insertions(+)

Personally, I hate most of the progress events. Having a few seconds
pause for a command line tool on something with 4 multiconfigs and 40
layers doesn't sound unreasonable.=C2=A0

I've put them in the queue for discussion though as I know I'm in a
minority on this, I just get to maintain it all and my own view counts
for little. I'm just mentioning this to illustrate I don't get to
simply do what I want as some people seem to think.

Cheers,

Richard

