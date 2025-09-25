Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5E8CAC5A7
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 12:48:00 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.10821.1758804478596678575
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Sep 2025 05:47:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Qn5NkwLg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso7265895e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 Sep 2025 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758804477; x=1759409277; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLMsOrDlJETxfdAVvIyGRD3kgx5oIwM4uxzzguJpXOI=;
        b=Qn5NkwLgTiIzc1Wbg93bn87tQanrGP7ITN2G0vaGbwMUmDmpQJdHna1z8OUubNjALg
         ASLoI1a1ovY1Bz/FUUesBqYya/OQ4aclCxz7LM/FyKnIst+aoWfUjdNJ3pGKjNEOtw23
         4VHk27LIMr1DeKlDVMacSxzh7fYYLXxtD6mrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804477; x=1759409277;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLMsOrDlJETxfdAVvIyGRD3kgx5oIwM4uxzzguJpXOI=;
        b=pz95T8fHDlhl+7FRQXba08OXzUYKuXxb7hmZ35E73cRJy1t0q4Xyb11l6Z1k6/sCqy
         utUOHOD4oSO5d4LKYdb1h2zcp2yvPKzzY4As7WRJFzIbywCBQrkISLsyf2drAMeSEm4o
         Oug+kfg9q9IgdrdapzumHXJhLRr4YoEzZcrKiXb3kHX2shjN08hN8VX4Wg0rh0BYBwPy
         bD8gLX70HV2L6jsru8k5EH7vRLikMbJZl1Gv6bNLyGK9J3Jmd+HM8gfoUTsr22X+vGml
         ssladQNE8UumxuqQvNHRWakJOLvbrJUyZ2PNrPt/pc2nWJuame4XMhZyseIy21LGppgc
         Wmaw==
X-Forwarded-Encrypted: i=1; AJvYcCXqU2mFnfHdD/zHf0HsTGme2xY+hrA+RGcCH5AtNImmbc0UDs+OMbOssJtreB6tdWpI47B+5xAqhNj/tfJH@lists.openembedded.org
X-Gm-Message-State: AOJu0YyGTukdpcNur0uZV3oh0fHVm7SCdigpYerZEzMltX0lP5EmLh7N
	vEvy5XFkc0BRJSo0JnW+hgJAEo4yFqHeLkePbfGqvD49wR8ji0HxymgJB9WpZFHCFYk=
X-Gm-Gg: ASbGnctxZSbRDQKJvwAx1BQu2Z8xUy4FpbUfLCh09HSuUOyX0jCFFhfY/0JeOJbfTSz
	QaMs5TEyEbF9JX7iypSMB0jLiS96UVNqqvtRlXyhLVcNntFyNrfy5TwdBCKPu4a+14Q8oUtl2Kq
	ejdv5VpYEjdmjQLQeesKWF0iL4AqSvfeqPYVIk8oXfyaFpcrMCr7iUGvveDNP3wxtesXBIwpVp9
	PQzq4Wp6Ispht4rDPEXi9M8j3cT785vLphXMteq/XJHjqe0ug883868tmb/pEUD9wvlD07/emRl
	ebmMYpqVYtSDYrpoZZHKQHu9AvUTbXHRfkK4QcoUZ0uVgTS2CRVjKT+EXHvLz/pdBlPpfUmLY/S
	1rVJZnZz+r+LuoB1lbg6AoE5aSiW7yansqRPCwEgFLwNhBh74eqDVbhDbD6ppw2GZE8JboeYBlf
	6M+VAz0FE6rFs=
X-Google-Smtp-Source: AGHT+IHrAaU8q/CglKykE1nIeNBj1tCZvZFvYwv33Vlc2R4xHthFXaIdnRv5OCa77HUjmWqZwmoV4w==
X-Received: by 2002:a05:600c:6214:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46e32a0e293mr36361635e9.31.1758804476931;
        Thu, 25 Sep 2025 05:47:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3dae:a8ef:27f5:f9cf? ([2001:8b0:aba:5f3c:3dae:a8ef:27f5:f9cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f1dsm75288935e9.13.2025.09.25.05.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:47:56 -0700 (PDT)
Message-ID: <f2766447a2c7e3f9f036e02aa2c1913205e54191.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: add the initial
 implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Thu, 25 Sep 2025 13:47:55 +0100
In-Reply-To: <20250922092731.1993813-1-alex.kanavin@gmail.com>
References: <20250922092731.1993813-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Sep 2025 12:48:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18093

Just noting issues I ran into:

a)

"bitbake-setup --global-settings /tmp init"

gives=C2=A0

KeyError: 'default'=20

i.e. if --global-settings is something which exists like a directory,
you get a KeyError

b)

For <reasons> I tried to set an empty --top-dir-name to flatten paths
however '' didn't work, nor did an empty parameter to the option.


c)

If you have the global and build settings in the same file, you hit
KeyErrors.

Cheers,

Richard

=20

