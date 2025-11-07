Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434FCCCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 09:55:49 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7914.1762509341741836356
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 01:55:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KfwfBnRt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710683a644so3336465e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762509340; x=1763114140; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wP9SIqB6iP/w5mE5rHLqKZVpIPpQ0r992DBeeUOWrPw=;
        b=KfwfBnRt9ykGq+NpE24zud+kJq3U9CKpIy3PCqDgCQUn4Jar5wzshFZLmMPSvZ/091
         Bm+ISFJFUn8Y28uwiZayWtABGGd/UkEFezNc9gdHAN8sOICcK7xn8Avf2jE3F3hmJddT
         yBQu5hHhphWWWAVJZK83AhsQGxcPe28fBTReU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509340; x=1763114140;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP9SIqB6iP/w5mE5rHLqKZVpIPpQ0r992DBeeUOWrPw=;
        b=XqYT8z9I8Em4FaMZJ4fv+CcuUT4BJJIwvOVmCbPrQhQP2mid2s/AU+S2OZq+nqadqd
         px5Vd4CPmMDsxoimEFNB7UGRjBTpT1MivHDchMwMnmp32KQKHJzakqJxP/WqBJGmfq9Q
         DCvskl89QPKN75y8e3Dh2uEUm4i9VfOXPCsrj5YRiRDvMpM/UsPsTZKPyBVpYh5KalW8
         bZcksNC+yTNil3GiFzxiC0/WLEJlqw3JzH84RdjTBp6pacmCRypGQcdnpSXh8UQYT23n
         C4KF4V9cerdcAHD6vBYWa1Fhh7GvuP9Mk3+9iFs2HCxUQLuMrxDu/2/IbkAR7cKuNgxd
         qlqA==
X-Forwarded-Encrypted: i=1; AJvYcCWHYVSAR4fiLGZIgt4v4b/1ryRM8MNlOvlYIB3GLtup+/3o0JCQdm8I1YPfKuMXQLNCTceCdwpqs8fcpQbp@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxw2SzxKHOGUxjpRJLjjWF5TDZrM7mXj6EdsBu2mapHinMbHU1C
	DAzue5ULKGH2mx86jNe5CAqO8jxVve7Cb7fgZFPO5xsWvSxEkuYp9BeRGwmx8v3Qaik=
X-Gm-Gg: ASbGncvCmM+MvtPrny2YyjBvv1qWW5nuaNyzHVDHG9n8UA0WQO+OBcDkKBri8dpckZy
	X1bnBdfo6/hk9zy6slIlfGhvOHKUEj3/8EbR5hEBnS9k5J7vcGbMQZ1WFw9gR5ws1gxkOeb0a9p
	1paYEutn2IRW5l4FM+D22mcIDHpzhAGz4ROeibpF5jemiSkj94dvHhNmuIampvkVnSBp3w5ASYs
	g7eozVhO6x4io8uO/7novGQ4oEQWV7OGpY62sTxymbG78PIsN+1bbya5xpVFXO1TCJNxfTBi5kB
	ECIOhHDWdD+7wgo6rUOAZw0Z+i+aK4e4RI/8Lic1hOoIRJexiqLLZWb+MsimHMwRgwWGBTqsxtA
	Eni4pOcGWXXuuLMk1OZgQ4RrGEbqmHJ2oxkP0d24qIWaoeaivUVL0AwnlOiO9jkLObRAIolaJjX
	kYfNl4gGksetP3VEr8lMRoH30QCxq2i4FyoD7GazLdBtZfX7N4i/4es88/M5mZdI+p
X-Google-Smtp-Source: AGHT+IHtweeN3Xr6LpbeFi5UNpKIG9WMCz4bmxphc3nNejwLLpELxoWkam1itCVqsuAGCi/36mMBSg==
X-Received: by 2002:a05:600c:444f:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-4776dc1db25mr11546065e9.8.1762509340037;
        Fri, 07 Nov 2025 01:55:40 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09? ([2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477632bda1asm90456425e9.3.2025.11.07.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:55:39 -0800 (PST)
Message-ID: <daa19e97cfc92bdfdfdebc0b344dc11c6462d0fc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, Peter Kjellerstedt
	 <peter.kjellerstedt@axis.com>
Cc: Antonin Godard <antonin.godard@bootlin.com>, 
 "bitbake-devel@lists.openembedded.org"	
 <bitbake-devel@lists.openembedded.org>, Alexander Kanavin
 <alex@linutronix.de>
Date: Fri, 07 Nov 2025 09:55:38 +0000
In-Reply-To: <CANNYZj_qwFt6F-LEwMqe0D04dy7t9_FJMWf1tpCUZ0bayfdUZQ@mail.gmail.com>
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
	 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>
	 <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
	 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
	 <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <CANNYZj_qwFt6F-LEwMqe0D04dy7t9_FJMWf1tpCUZ0bayfdUZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 09:55:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18301

On Fri, 2025-11-07 at 04:32 +0100, Alexander Kanavin wrote:
> On Fri 7. Nov 2025 at 1.59, Peter Kjellerstedt <peter.kjellerstedt@axis.c=
om> wrote:
> >=20
> > >=20
> > > bb-layers-relative maybe?
> > >=20
> > > bb-layers-relative-to-this-file is precise but does feel a bit too
> > > unwieldy. Any other options?
> > >=20
> > > Cheers,
> > >=20
> > > Richard
> >=20
> > After I saw Alex' patch for bitbake-setup.schema.json:
> > https://lore.kernel.org/openembedded-core/20251106170815.2439421-1-alex=
.kanavin@gmail.com/T/#u
> > it made me realize that I had not thought that paths in both=20
> > bb-layers and bb-layers-relative are actually relative, just to=20
> > different locations. Unfortunately, I think the newly suggested=20
> > name is then misleading as it implies that paths in bb-layers=20
> > are not relative. :( I now also understand why the longer=20
> > bb-layers-relative-to-this-file was originally proposed.
> >=20
> > I don't have a good solution for this. The best I can come up=20
> > with is to rename them both to, e.g., bb-layers-dir-relative and=20
> > bb-layers-file-relative
>=20
> I tend to agree. I=E2=80=99d rather call them =E2=80=98bb-layers-in-sourc=
es=E2=80=99 and =E2=80=98bb-
> layers-in-this-dir=E2=80=99. Patch is coming even though I=E2=80=99m tech=
nically on
> holiday since midnight. This is important.

I don't agree with "sources" in here.

I think if we call them:

bb-layers

and

bb-layers-file-relative

then this should be ok? I agree we need to get this right.

Cheers,

Richard


