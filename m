Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FB8C5B572
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 19:34:18 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3064.1786995257353453677
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 12:34:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E7UP1sq+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f71156e1aso1644595f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786995255; x=1787600055; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3dtZTOZ80EjTNRK8Tdz7K7LOiNL+xjP/T9GWplWqtNo=;
        b=E7UP1sq+icG2NwYpZ9kYqDs6HnWiI1qNfeNj+WOwkbArgKzGzsAUORZcF/qpaPmDud
         oXRvpNYAm1L16DMYrRGjS2oajtpF56QtSF9eY36B7LtCR003x9yOg1PkXu8cvlE/30V5
         jLPcqjenT5kzb7KZcSEnAPpKihlL6uVLrU+PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786995255; x=1787600055;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dtZTOZ80EjTNRK8Tdz7K7LOiNL+xjP/T9GWplWqtNo=;
        b=jrH1bci8GfwhgCOwRWY5tntxNs/dpDn2vV4+Er3mqWew5hi5hQgOnAjErJ1dZdczWl
         IlTHS/VsE50y+pXK4CDUF/+qdMew5WOeUnda9WX9F23LpTnP6a4QNiT+V1QSYVpFLz9Z
         TQtCufGvITM9ZcDePsTmHdmXmLqjITHIf5Y0EHEzgtGcIcEbnsghmL9XLEuv0NeQuPm/
         tUmIgEJjLxzsbT7rg+ARbg3EFEyjOxhKSu6UPCLbMDZMR7NdzLaF0JltqBNonzfLz9F4
         3thxa1AmO/J9PaxMjVJHtNr7NjRbJdyRHd2K+hztp5HLMvEWRB85No3VXzBuSzOG2F2N
         f8bg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5550MMSeTdc061DxaeYwFtbjdLPnYHzJ59F1NdUy9YCWIUwB9LtzKk3drDCmlVybWPmKl/2dMQiUCqFRu@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywo3zGj1Y5DZY7p7D6DTUZFaQkuDe6Bal9BLdqgezHbf1nId7Ca
	zGHYHzT0TeigjQTKXh8eLWnKT0Vjs/N2bjkTxpP8kQE0OgTOyIccFVJS/leMaAcPYOs=
X-Gm-Gg: AR+sD13wJFgn7WOgl3Z8GNbbdJgJCWGlur+Ue+eDEoiU3hoO3NNITcL7krslRC26zkf
	Z6wR1XslOdpp7eV89+T3y+335ZKDU5VTUgLuadVVAjI3tmK1rHrbfZSzpLQRHNHQc3HDxIGLzx8
	LTXoCFsdvMuZ7rhRFZsCzTkPPL9NPIS3qJl43jKqsLlQl3v8+GpQLXkH94BRyWsQd+QaB9lJ7Hs
	3zPgWxblnFoaLLPG+wY8X62xU6WbYdVzG9MTVDeDl46v64aPZ31EWjMF8iY9rMKiPoXajoi1tKe
	e7SZUFR0NdzC4zTbCdrEUbdNPju2pUnOgOgX4fbqkY3JowUDS7VHTjznwz5+BjscJ21k4ly5Ypw
	LLiZiGEtktqDEdvh/WYpxAIzjI2gVpvZPnL0UG/FOLUdAkM/qrXb1i0QnW2YVoMsDRxl1OJ30To
	mRx9+iTLHNPAc5QXepB3D5RHGby5vKdaQnwEW0KwJNOjmnKr9UBIltXF3FUuDwhCv+iKbWS3pIi
	gv23lw3EVM+/Rr/uViJbULXxMEMSsqaFq6UUl62M77p99jb083cOg==
X-Received: by 2002:adf:e193:0:b0:47f:25db:8161 with SMTP id ffacd0b85a97d-48160763c02mr44884904f8f.28.1786995255609;
        Mon, 17 Aug 2026 12:34:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4d4c:ee18:5ecd:c132? ([2001:8b0:aba:5f3c:4d4c:ee18:5ecd:c132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77f41sm5726777f8f.27.2026.08.17.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:34:14 -0700 (PDT)
Message-ID: <09f0be3fae9caaa9cc033c4d939f74027157df1e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel]
 =?ISO-8859-1?Q?=5BPATCH=A0v2=5D=A0fetch2=2Fwget?=
 =?ISO-8859-1?Q?=3A=A0reuse=A0cached=A0HTTPS?=
 =?ISO-8859-1?Q?=A0connections?=
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, "Fredrik Svensson (svsvenss)"
	 <svsvenss@cisco.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Aug 2026 20:34:13 +0100
In-Reply-To: <DM8PR12MB5430D56BA600CBBB0DB41C428BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <DM8PR12MB54309AEE365DF999981829528BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <DM6PR11MB39628059FA2D29F9B3F74295CBA72@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <DM8PR12MB5430D56BA600CBBB0DB41C428BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 19:34:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19973

On Mon, 2026-08-17 at 14:17 +0000, Chris Laplante via lists.openembedded.or=
g wrote:
> > Funny enough, just last week I was also poking around in this area usin=
g
> > viztracer to do some profiling. I was preparing to send a patch that ju=
st cached
> > the SSL context creation, which on my system costs 100-200ms each time =
(since
> > it has to load the certificate store from disk).
>=20
> Will do. I think I'll hold off a bit until your changes land in
> master-next though, to avoid merge conflicts.

I think they're already in master?

Cheers,

Richard

